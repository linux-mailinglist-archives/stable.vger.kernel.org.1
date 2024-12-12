Return-Path: <stable+bounces-101339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 789609EEBE6
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5435A1888748
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CB32153D9;
	Thu, 12 Dec 2024 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QCHTrXmI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0160F748A;
	Thu, 12 Dec 2024 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017214; cv=none; b=dXm8iI51JsR8v06GrgqYsBH1WCPKpq4nZEmu8W7VuqFrbtXR388bUwFbeHqBXF+OF/5CStIsLaTWDhi1JHSdaHxMDw+kxQlfel94hkOuoYvTUY+HU2cLgfjgCnNLgnYZV4SGJshAx0Rj6ZW5ssuT5HqEXc2cdwlIh1NEOSRTSzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017214; c=relaxed/simple;
	bh=S4VT7ZW+pu8SUGmWxgyjeY09Jm5EfyAcAYFHWsGYMC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qdll/+Jj+lfQKfGcRjkr1CB3jEi1nf4FG+znG4bhR3qfsrfd+o7kVHB8ED5D4AZLxuBSGZ+9GUlt1fRkDuPweoNLhsIZglA2VXnC75RHfXQkYbi3XYyX4hgZQEuNMKxmCr12VGoO6wGmEbCIx/C05XQ+gtuur61GI+CEvW1/E7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QCHTrXmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAAAC4CECE;
	Thu, 12 Dec 2024 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017213;
	bh=S4VT7ZW+pu8SUGmWxgyjeY09Jm5EfyAcAYFHWsGYMC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QCHTrXmIdvXnGSM1Q5mtf/NjXJhwdEpaj5dFD1jA88fb9DmFF8DSYGWUFnawZ892a
	 0PYEhuLcnBs3EvUdEYWL/U7/VGCTEAylSbyun9EFTk2GlCwHV6va/+lMhAWWW+T8D8
	 2HKzne/pFT+NJ1ZCyZMyDJ0ij82iRM5HGcaeGOaY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 414/466] iio: adc: ad7192: properly check spi_get_device_match_data()
Date: Thu, 12 Dec 2024 15:59:43 +0100
Message-ID: <20241212144323.113129305@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Nuno Sa <nuno.sa@analog.com>

[ Upstream commit b7f99fa1b64af2f696b13cec581cb4cd7d3982b8 ]

spi_get_device_match_data() can return a NULL pointer. Hence, let's
check for it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://patch.msgid.link/20241014-fix-error-check-v1-1-089e1003d12f@analog.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7192.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 7042ddfdfc03e..955e9eff0099e 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1394,6 +1394,9 @@ static int ad7192_probe(struct spi_device *spi)
 	st->int_vref_mv = ret == -ENODEV ? avdd_mv : ret / MILLI;
 
 	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -ENODEV;
+
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = st->chip_info->info;
-- 
2.43.0




