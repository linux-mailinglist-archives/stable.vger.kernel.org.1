Return-Path: <stable+bounces-159565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87656AF796C
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90538189DD22
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD982ED157;
	Thu,  3 Jul 2025 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BvDz5Fub"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093AB126C02;
	Thu,  3 Jul 2025 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554627; cv=none; b=NM3q0nseAprYlPOUYdM1Ol4W+Xx2hEutQimMDTPXBT05wgqOjmwQPnU4mFoOW/7uVKvTj8IKEhVd3rd6ZdBgb4pEKxgccwQplhkcOxVcTomfXyo2IAD+ABRIdxU48oS8wST/2ZvBEDrtl2nYHDIGnPaG8Fiik7aQTCuIPC74fEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554627; c=relaxed/simple;
	bh=OnkTSpneecE1+XMWtfnR6xXTDSGAU75qEwyk5oNHy7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlABCPgDE4GmpCXRaBUoomdSUpXEv1VGgkR0ZHLaQJgcSrKxi9OZcNaJdAEx8tHe9UiDoonPxsn14gM9f3+C2ZzdewAmD8zaXjYb16BgNxRxk4VIDIErkWNIqPimF+OrT044N4DT+7R1Rxf21qzQNjJdpa0jT+V+O0GyrnmVR/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BvDz5Fub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFAEC4CEE3;
	Thu,  3 Jul 2025 14:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554626;
	bh=OnkTSpneecE1+XMWtfnR6xXTDSGAU75qEwyk5oNHy7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BvDz5FubzCzkgG35ERjErjUcqL6GCQNpXiB4kJ6bZTdPPkRJvzpyZ/YT8mAe4B4lT
	 il6hqHAECyTojRoUDd8X7zExJD2E9Wk6MZwc33fGhsLZXSOFJ7VXKCFGYq1tueREJO
	 MY1XU46Pk/Udia9ytxlCwnS4Uv1+Cqvjd4PZh+jU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 008/263] mfd: max77541: Fix wakeup source leaks on device unbind
Date: Thu,  3 Jul 2025 16:38:48 +0200
Message-ID: <20250703144004.626928011@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 6c7115cdf6440e1e2f15e21efe92e2b757940627 ]

Device can be unbound, so driver must also release memory for the wakeup
source.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250406-mfd-device-wakekup-leak-v1-4-318e14bdba0a@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/max77541.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/max77541.c b/drivers/mfd/max77541.c
index d77c31c86e435..f91b4f5373ce9 100644
--- a/drivers/mfd/max77541.c
+++ b/drivers/mfd/max77541.c
@@ -152,7 +152,7 @@ static int max77541_pmic_setup(struct device *dev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to initialize IRQ\n");
 
-	ret = device_init_wakeup(dev, true);
+	ret = devm_device_init_wakeup(dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Unable to init wakeup\n");
 
-- 
2.39.5




