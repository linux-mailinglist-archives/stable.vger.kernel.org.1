Return-Path: <stable+bounces-172484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35725B321CF
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDDA7AC0770
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 17:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14312296BD7;
	Fri, 22 Aug 2025 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP0XrgDu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C725C296BD1
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885318; cv=none; b=j1U2eSC9sMa0DIZ+Zf/5yYjNYEylydhm7Xafpjwe2qnn2CU2nRbQRbcw7W4fIsmmBo53Wgr99QmNq3/baGBst3m5JC0gCInPDWd2Y6YXleQ6mbkuoR1P95FsnjACOCwFTIccsSSG/v/myQM1JqzOa3CnrBJJuLuz8vnJc7HqL14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885318; c=relaxed/simple;
	bh=wSzh0ULx1dpPtWoPb+np4c8HG6RHrO+CQMQ8m8tENP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdytgUWkZ927PcWqHbilxwoToplJImn4PDPN5pHxbOGBAq2tFPAAimNb/y3hUUB+uZW+8g0teEnpnW6o5UaOoZyrl+amapMKmegtPqYugniFjGiNKZvJkxpcf9xOq/8PvbZ9PR+CGwKC4m5NbMEnKI3Jej0hpLCzfEWMQfoSdV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP0XrgDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DF6C4CEED;
	Fri, 22 Aug 2025 17:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755885318;
	bh=wSzh0ULx1dpPtWoPb+np4c8HG6RHrO+CQMQ8m8tENP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HP0XrgDuNAC+suJb1kMl3gk28kDYKlLvf0Yr8wftj3feCiY/jiJFv/tWRYBa3CvXO
	 fBCL0ZyYtxLlqKr4aZBYX0E1iCx8vu8+Co3KLc6GhToZmEWYbL9cp/cgB4yz+pOAgG
	 GMcAzdjBKDqeb3vRQlahSKcP9QT50mcWyBVG6AgUf1PEI9S7pGgIhcyZSXvR3s2L+/
	 vZjLHeF+KYpGSSLgzNxK+qN18fcWK68zzU7OM9Vs3AGkW1DWUBkTcvluaWC4SkxVde
	 k4E1eh+dEp4E3sE5pU/LFHceRM+vE71lVr50rBM78Jl4DtxbCJ7OjiFqKaQOUZUiv6
	 aZifYT3XhDyvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iio: adc: ad_sigma_delta: change to buffer predisable
Date: Fri, 22 Aug 2025 13:55:16 -0400
Message-ID: <20250822175516.1349300-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082108-ointment-anthology-2c2a@gregkh>
References: <2025082108-ointment-anthology-2c2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: David Lechner <dlechner@baylibre.com>

[ Upstream commit 66d4374d97f85516b5a22418c5e798aed2606dec ]

Change the buffer disable callback from postdisable to predisable.
This balances the existing posteanble callback. Using postdisable
with posteanble can be problematic, for example, if update_scan_mode
fails, it would call postdisable without ever having called posteanble,
so the drivers using this would be in an unexpected state when
postdisable was called.

Fixes: af3008485ea0 ("iio:adc: Add common code for ADI Sigma Delta devices")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20250703-iio-adc-ad_sigma_delta-buffer-predisable-v1-1-f2ab85138f1f@baylibre.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad_sigma_delta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 496cb2b26bfd..5dd0debb089a 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -371,7 +371,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
+static int ad_sd_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 
@@ -432,7 +432,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 
 static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
 	.postenable = &ad_sd_buffer_postenable,
-	.postdisable = &ad_sd_buffer_postdisable,
+	.predisable = &ad_sd_buffer_predisable,
 	.validate_scan_mask = &iio_validate_scan_mask_onehot,
 };
 
-- 
2.50.1


