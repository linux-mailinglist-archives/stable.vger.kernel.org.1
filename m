Return-Path: <stable+bounces-13305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92903837B5A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B49E2930EA
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D893F14D44E;
	Tue, 23 Jan 2024 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kEyr+/JI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9918814D42C;
	Tue, 23 Jan 2024 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969289; cv=none; b=YVEhxSH03Hv2Rc1cBksKrGCGH81cHM/gNEKdhYU/fxtyH1ZfBoylcQGiN5KA/unm3UZlTKJZYbUmtVoN/qF8D9DiP/lyNddOZOtOq7UTrM+0fuLpj2yXWRbotDLRHHVlYm8KWBPYMWx7m/SKUOQOJYFKBCesjoSfHpTEH1+U744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969289; c=relaxed/simple;
	bh=aIlH1vDMpOaNMrcxPdJZSZh/uMQk4of40HnoOcnOUgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jp9L326P5k2KrvDt2swn1kjkc9Jc5z8gQg2m+7hJ/Pa1U9KdvD0z3FkfnQQw5Twno0Mrc8HvQ170uCMphbwUTUpaBbslayv9erv2cxkP8DqV8Gww9EB3KjkXX4zgggdS8CEzs9LhEoSe27fOdYST/VK1P766lxmb/FRPXrsQ6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kEyr+/JI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57542C433C7;
	Tue, 23 Jan 2024 00:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969289;
	bh=aIlH1vDMpOaNMrcxPdJZSZh/uMQk4of40HnoOcnOUgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kEyr+/JI5G5B37+++wrBf/X78AAdoHPBgvxgT5Rj1/1LXqIdbT51Zz/pCne5GyzxB
	 ZVHSqB4DDQ27bPXeIGjdAGjo8JjO5ZjU1aodpCBmYlVR9mavn9kW1g2gLmR8SQ2pSS
	 kS48Sq8QOWFEcaZ4wsTIvcZNfaqwsHPGlBFf+wnQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 148/641] wifi: mt76: mt7915: fallback to non-wed mode if platform_get_resource fails in mt7915_mmio_wed_init()
Date: Mon, 22 Jan 2024 15:50:52 -0800
Message-ID: <20240122235822.673032373@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 5f9d5d4fc561e7bd3a18742f1fdb96cab98f1870 ]

mt76 assumes mt7915_mmio_wed_init can fail just after wed driver has
been attached running mtk_wed_device_attach().
Fall back to non-wed mode if platform_get_resource fails in
mt7915_mmio_wed_init routines.

Fixes: eebb70976be5 ("wifi: mt76: mt7915: enable wed for mt7986-wmac chipset")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index e7d8e03f826f..04a49ef67560 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -742,7 +742,7 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 
 		res = platform_get_resource(plat_dev, IORESOURCE_MEM, 0);
 		if (!res)
-			return -ENOMEM;
+			return 0;
 
 		wed->wlan.platform_dev = plat_dev;
 		wed->wlan.bus_type = MTK_WED_BUS_AXI;
-- 
2.43.0




