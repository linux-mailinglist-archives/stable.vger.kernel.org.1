Return-Path: <stable+bounces-143725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E4DAB4110
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3652C466E74
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E602550CD;
	Mon, 12 May 2025 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k+8dLBIE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70FB1519B8;
	Mon, 12 May 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072879; cv=none; b=F6c0nnAeI/zoNKO9kWbrKSWK2E27BWKqve3VyRSKpZGxD5jahYMwr1hFCFM+4r3/H5pqKU7ElTRGYpqII4aQVE7lRTAi0ZqXjuWUEvcjZ/BypgchZYZaC9rxEqcWK6KBY6cmDT2rZs3Xrt4FmtxbhzX+/Za4GNxLRgx4N0eaO2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072879; c=relaxed/simple;
	bh=6CKep5RKUAiMMv9I2KgDb7B/3gJ7If/Z6oouo48e8+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtFTHuAKYYvRJlZsB2Cq9BvGdNH+5qJz35rB75wW3iUkfVw9diPwk6Tu/Xv0GI3rZ+SxQIQtUr+VsbIORkD+vAuVVsJ/nETcI9J1LpSmlZMtFMM4Rcwkq9gqpDm2LG8vFGbGZTRlgJJEbqWuK69cw64thjMZwvkIelGstp4bcg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k+8dLBIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA71C4CEE7;
	Mon, 12 May 2025 18:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072879;
	bh=6CKep5RKUAiMMv9I2KgDb7B/3gJ7If/Z6oouo48e8+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k+8dLBIEbUAr7m59QTP+PIs4cwvvJrux1wJvll/qTpvrDcEUeS8rN3FUspMKtnN22
	 sAKT1xIAnMr9ImsGjpLJQpb61wIlQlPNoPWa6Bg7uuN1iwnzfb7fqSIcm7a1Oe6les
	 rbPS9niiTgTiXJ+sp6/KpWawKgQx720e2iANNzkM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gabriel Shahrouzi <gshahrouzi@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12 084/184] iio: adis16201: Correct inclinometer channel resolution
Date: Mon, 12 May 2025 19:44:45 +0200
Message-ID: <20250512172045.245313811@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
References: <20250512172041.624042835@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabriel Shahrouzi <gshahrouzi@gmail.com>

commit 609bc31eca06c7408e6860d8b46311ebe45c1fef upstream.

The inclinometer channels were previously defined with 14 realbits.
However, the ADIS16201 datasheet states the resolution for these output
channels is 12 bits (Page 14, text description; Page 15, table 7).

Correct the realbits value to 12 to accurately reflect the hardware.

Fixes: f7fe1d1dd5a5 ("staging: iio: new adis16201 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Link: https://patch.msgid.link/20250421131539.912966-1-gshahrouzi@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/accel/adis16201.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -211,9 +211,9 @@ static const struct iio_chan_spec adis16
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
 	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
 	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
 	ADIS_INCLI_CHAN(Y, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 



