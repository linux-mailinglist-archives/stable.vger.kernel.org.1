Return-Path: <stable+bounces-143326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6BCAB3F2A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCD63A715F
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A757296D37;
	Mon, 12 May 2025 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bg2nJE3x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28183296D2E;
	Mon, 12 May 2025 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071080; cv=none; b=Dt8bhyM5eCGgWYbVcJWUnCMTDYSZaWv6Ct8otCWTwXugTdBbEU3mOSYBiA+tFcnI3KRYgiidcdxuRiMGulsUySrV0s4l0e8RatkdSMJhm4ZauxYCV1ENsiu/hZ380gXuHCxprgjOlclOG6yX1YjzvUvE3yFawDqjTY1WQcLEtjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071080; c=relaxed/simple;
	bh=RxhIqYOKEE2SwYab40/82UWj7Ir3OSTeBk6Usp1W41s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsuvvH4t90qjltlPbkG6TMu9/7NOknfr7N1gHyE3uje5780N0tNzRHgAns45EBv9vyl+1G2rMwjHAWcbLzdL3t7mDm0A/WA/S0tky7ZVerzRWpdlIR75pv0QZ1wsOAEh6xrfh0HUJq0tWRucfDfy8AFB0SmsqB8Tin+hYp9Dt1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bg2nJE3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2329DC4CEE7;
	Mon, 12 May 2025 17:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747071079;
	bh=RxhIqYOKEE2SwYab40/82UWj7Ir3OSTeBk6Usp1W41s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bg2nJE3xrZjfjSTApJPk/5rji/135q87eeYVzaOrj7wwUxO/tk+OJEhnPxv9cggPl
	 5whhHSzF0sKj837fFAyV6xCB4k89PbDgfRFeoJlmyN5DCY8TXO5vAkXg4PGrqcT14F
	 MGcFuSxU0I0H3fkxDu3Vu2vU79X1J+dv5uqFQkd4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.15 24/54] iio: adc: ad7606: fix serial register access
Date: Mon, 12 May 2025 19:29:36 +0200
Message-ID: <20250512172016.617868262@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172015.643809034@linuxfoundation.org>
References: <20250512172015.643809034@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Angelo Dureghello <adureghello@baylibre.com>

commit f083f8a21cc785ebe3a33f756a3fa3660611f8db upstream.

Fix register read/write routine as per datasheet.

When reading multiple consecutive registers, only the first one is read
properly. This is due to missing chip select deassert and assert again
between first and second 16bit transfer, as shown in the datasheet
AD7606C-16, rev 0, figure 110.

Fixes: f2a22e1e172f ("iio: adc: ad7606: Add support for software mode for ad7616")
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Link: https://patch.msgid.link/20250418-wip-bl-ad7606-fix-reg-access-v3-1-d5eeb440c738@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad7606_spi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -127,7 +127,7 @@ static int ad7606_spi_reg_read(struct ad
 		{
 			.tx_buf = &st->d16[0],
 			.len = 2,
-			.cs_change = 0,
+			.cs_change = 1,
 		}, {
 			.rx_buf = &st->d16[1],
 			.len = 2,



