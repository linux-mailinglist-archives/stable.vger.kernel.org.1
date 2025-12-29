Return-Path: <stable+bounces-203482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EEACE6582
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2154630094B2
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 10:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD0827AC3A;
	Mon, 29 Dec 2025 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="be4IrT+Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFB528488F
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767003146; cv=none; b=hDqHoiJe3O/TgjJZ/rrzHnr3qfOMwhpO3v8E7oGKdbUhmnXG1LUvlbs2Svt+qwdS/ru70W9BngKsOa2Ur1Cvn56sAedcSYmmlj3NqV27yujULVxBqkMbFdrHE5LsBTusZTvKD4RStVoa9ekpudQ9xSxileicWwjSU0vK3Xfl908=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767003146; c=relaxed/simple;
	bh=iE2CbCdrK0vI0FrVCavjC9uDM/vsBwXeGKRyKumfVTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bsb+5Z6xkFGnjvjWjMEmj3iAol+HFrXEjEgrI5R5XTAynkixM/5FLTUkeJYxpUSP4opCIefyzIS8amxmRCfBcD3H/vN4bQQithgASAaFQAnJZqpuv/8Q07iR0lehMiq/aVokrwOL0iU3TRWjRzse08s/XfzOZZuowAdHQWAvb+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=be4IrT+Z; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so56512205e9.3
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 02:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767003143; x=1767607943; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ri0p4U6CFfsvzwsMRp5y6y8qxmA/cHDioM6peECfnxE=;
        b=be4IrT+Z6dr6Ci0CD7zBII7NNSUp5BtJl0Yfi/Exi6Gud5sisBUPX6Lg1byCHIjmlt
         R4AJ8K9GkIwQC9ZGXYoVyZV6GVN2pEvkGdjm7dNG36W773zFF5uJun1zfeJM3kIU/2VL
         MleOf5Ka7j3ZiwcG2TYTfzsccHYqDYECBFZp7aGu4yJjnnBF4bqE+SwgUYVp7a7sypTk
         fgOEFszyibxUKO1NQpj6BuDwkU2fG9GrKt+4CjVXNCyK8A4eKtWxZyhDFOjV5buSAhwn
         3lDkfNNf6J2hc5+xhSYv5ovosOYKca+tcqeL1u5d3h24wP/tMqCsWifqNe2463Q0XSPU
         8P1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767003143; x=1767607943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ri0p4U6CFfsvzwsMRp5y6y8qxmA/cHDioM6peECfnxE=;
        b=o/ilihV7cE51g3P4Uj5gwghYFU7F7NwOyUDCeazNeM+DFYWfiZsKEzpFjzmX5zsEIE
         vqVkU0fANG8h03Nk0dOvVkX6N6q60ndsICKCCB3La4iYExq+2JbpQhE79VYTKFLkd7du
         Vd8vI76BbspVGpWqZIiUkJfXbKvkrOGSvrIbjYnjRp4f5A7CeiYako6MujVa/Q9vxekX
         Rs9AN8Cv9djGoSr31WWcMl6FK0nFR13j364q8yBEjxFhf0V6gb9AIyXN/yJXI7IFA+tQ
         EyDWymOKYrvjivrO6d2J5PVCFQQ8YgPYvcr0AEGZ3bieD1C6HGJWpLjXh6WYRCXdO2M9
         LJCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGQJYvJm/3Np1l+qM2i4bmkEUMOjAxkXBDAzI1HMBadV2e1+qP1zsIPuXNiRFaW41htuOk1gY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6iChbA3/hUgrHSq5cBU7Dyg0Vmj/0t8+HA6xYjWah3gJQytuj
	LGL6NkuFimkFFcsELK8nwxJgN8DOKpYZJCyzGexulPTMBoi8Qp0E4lu5
X-Gm-Gg: AY/fxX7BuiSzUMu2RQWZqzPfSL8DZALE3of3Zveb7GQdrnHBZMIs3+bOAft4O+wUshD
	CG4zDXy6G0a9L0lMrL5fecrPXxRNx23pPD9hWY/3V186FeUzB2Wcw2Yy2Pr/7M9j+Tvqzavs8sj
	URTN4+e3dsh0JOr+hg96lqvzp3yKtZQRF5gG/vuL1Ufv9qTonPP+ddj3bPZ8TJbEFq1+/ueSTyf
	8qB7d1FGVxkKvEKiT5oyj/Gljom2F6AUvM9Iijc5LSzfHEj9VFNNF0jo1E//SOpuDEOTJdUyRFE
	cokqSUfsk0/iS928khYmbQPUjhVGo1L1khgNDncgiGaD3pu1LD/BoqeWUV1rQROvBxUzYlLm1wu
	rpnqTsKRoHW/JLtTCK66pu9w1quqeJLTatyibjdE4pVKwjEEJs4F3u1W+UXBTnV9PMqtY+46Rpj
	jXAawmnmGmNk0gwt0OXSTXzEBwaFJxbFVLK9fkFO3jfq/L7VmSzH5CChBno/e3
X-Google-Smtp-Source: AGHT+IHJS63lS/dPKoA9lGVZ+ST8crjqL/wpGYOYPkSn4ew0eH8IPo2DWmLK76jUaU+P9S/JFHAnzg==
X-Received: by 2002:a05:600c:468f:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-47d269c7019mr304884895e9.18.1767003143012;
        Mon, 29 Dec 2025 02:12:23 -0800 (PST)
Received: from alchark-surface.localdomain (bba-94-59-45-246.alshamil.net.ae. [94.59.45.246])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d583f42dasm19840735e9.6.2025.12.29.02.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 02:12:22 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 29 Dec 2025 14:11:58 +0400
Subject: [PATCH 1/7] arm64: dts: rockchip: Fix headphones widget name on
 NanoPi M5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-rk3576-sound-v1-1-2f59ef0d19b1@gmail.com>
References: <20251229-rk3576-sound-v1-0-2f59ef0d19b1@gmail.com>
In-Reply-To: <20251229-rk3576-sound-v1-0-2f59ef0d19b1@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 John Clark <inindev@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245; i=alchark@gmail.com;
 h=from:subject:message-id; bh=iE2CbCdrK0vI0FrVCavjC9uDM/vsBwXeGKRyKumfVTA=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQGhTAyn21XXvnWgbvV1bfrVXb3d+4/09j3Wy6MDfv3f
 HW/jgRLx0QWBjEuBksxRZa535bYTjXim7XLw+MrzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKhjrGPEwMUpAFNt0czwv/xx55SdHdc3+vGw/vAK+MT34Y5LeVXqjptBHM8t3W4majMyLO/fV9j
 3R2jz/Z8/lb8YLTwVmbUz5dCkm12qVpMynSIqGQA=
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Fix the mismatch between the simple-audio-card routing table vs. widget
names, which caused the following error at boot preventing the sound
card from getting added:

[    6.625634] asoc-simple-card sound: ASoC: DAPM unknown pin Headphones
[    6.627247] asoc-simple-card sound: ASoC: Failed to add route HPOL -> Headphones(*)
[    6.627988] asoc-simple-card sound: ASoC: Failed to add route HPOR -> Headphones(*)

Fixes: 96cbdfdd3ac2 ("arm64: dts: rockchip: Add FriendlyElec NanoPi M5 support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
index cce34c541f7c..37184913f918 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
@@ -211,7 +211,7 @@ sound {
 			"Headphones", "HPOR",
 			"IN1P", "Microphone Jack";
 		simple-audio-card,widgets =
-			"Headphone", "Headphone Jack",
+			"Headphone", "Headphones",
 			"Microphone", "Microphone Jack";
 
 		simple-audio-card,codec {

-- 
2.51.2


