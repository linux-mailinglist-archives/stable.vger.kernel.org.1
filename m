Return-Path: <stable+bounces-176752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD312B3D28D
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 13:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B9A3BCE49
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 11:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0909A25A2C8;
	Sun, 31 Aug 2025 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPf5XB6l"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F59D22A4DA;
	Sun, 31 Aug 2025 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756640196; cv=none; b=UGt0hkjftCqcLXZFAJhnMPJxLzjet7XIrjEY/WgxYMrFYq3zBBWBRQ44ffQ0KD4AkMecBu4f31gSMJqkQSw37FOnXLQBQAm+zQWzDyneHnz/GwFRVc1iHzMZ58hTXllXaa0fV1DzwDOf79JDI+UNO2ntvKAe/VUcgbh4MxYM5JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756640196; c=relaxed/simple;
	bh=5UMA1QQbhpw59AbBzA24LNrq4MiD/a6bEyFrWmfD9AA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X0Iqb/n0RrSGBcB7eZDGuOPVb8P/u/QD8+eMlMZeiD/v77tt7mRp6jhtNYU7Xtw/dgESQRY7jItyAgUhDLkSTGDiXkjIomBcXkGzHbOuTOgvc1vkkyO0H9+vH2Z47CJfy14C2Hfa1JcR19buV4OKGwuhB/50cMfPvJDhi65uY+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPf5XB6l; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70a9f5625b7so31677816d6.2;
        Sun, 31 Aug 2025 04:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756640194; x=1757244994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55pZ4cEaeEj0rydwxsO5TL3wb1AMbR3NyzI16xoHkYo=;
        b=GPf5XB6lcucWRkH30JpBAZvcDxxzIDdYnpJSVzWRmtxw0xfQxODT1yhnLI6j2SX5+9
         8Y+GqsNBWgSW6AtwiqvS3y47RXtbV2dQetLngkboxfTCJhb1YTVqZM2TeGAtNyn5i1EP
         wAcNfwpv9CAzetD6iB68IxY3sRQgXxxDHT4UbbAOZq9P1Nyga9w9CyHxQ5532DGRkidY
         yi55sCM65mV3DaMC6xybkRE79ujVSFNjR10dcqrSXo220bcH7AwRHM3Q2Sx4RsN7i0yq
         xHqWzX3bGi3yvoEEV5mj97q699KPodsz6oNA4UpbrGy+xQcMuVxbdTC40UeZG0GYhNU6
         q3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756640194; x=1757244994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55pZ4cEaeEj0rydwxsO5TL3wb1AMbR3NyzI16xoHkYo=;
        b=mSdQX6LSb+ud0w1fswcraPKplpER8EWmJKBSreukoeO5jTNmHmQODvMzbFYVlGaKuL
         hbcU1RQmV7O+idk6tGFdJeeG9otMxuheCoxCQNz/zu+OhVYPsFOCsTBb4UPBGC7DLgrF
         Y+G3+RotH3vqhyth/1PnPbe90l/c9GXHGDuKMpW/hQKvXSeLbEwZ0xBPLZmZFB5pu+JS
         Mgg48hnxsn9a8TwicNrH94iTHjYIizbXbFo8Wfo5CgiV81OrPJI3vHe+NZR2UNCasYcR
         DKDL84H/USaQlHNoFRhamqmo5nKKnGrvBRvrRzdmLYotTDVX+bdTpI5hVJE8qj/PQGZA
         vIMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/gGN3QgkeHZftPRoeKVo3AtnDSn5erD4dF9pR8XkVdxYbBjrbCOG7upnkBbr+kx7avqdtDc2Q5q0c@vger.kernel.org, AJvYcCUWx4wV7vYMxMZTxlsoWV5ZBvwjAfNNllUiVJoPzLHwQU1nflsQD13JMhtszPKScmtsoRMPEk2OI0xk@vger.kernel.org, AJvYcCV7WPZYVXGIzy2UyFPTAKeOaOb3x4aXihCU4v7g/kc6EV91O19yl8ysu58tCoF3fUmbwfVK5QSPjOnn9+fU@vger.kernel.org, AJvYcCXKBWfw2K6ij6uAeSrskm3jMgYcAtW/Dc/SXaG0b33ZRbNSlnE5J7FhKSOKJ0GwbVTj32vZh160@vger.kernel.org
X-Gm-Message-State: AOJu0YwI2VNtl1mIov7DHC1cPc1YBkbg0MBCArVhUFHVY8GbzKA0eVjy
	6yJYcA2J3cBRK+98GNOJHFRbpNMK5z8rjZ4tSOo4nQL6+dgm5Up0KKKu
X-Gm-Gg: ASbGncvO/qMLZfCBmUnhaMgOhdHURcIJTghdCXqGExqPnNZnUEmTSBIenbR/PqLyYBn
	94VnEnwZKTgzBdLoJS6lLVALeLEMmuHQpuVG8f6jO+u4b1IHUBj3eMD1ccd+XLA7/kaNyCej09Z
	zGYFLkcO+x3GxtsojHOpYZG9RpyqUbTZlWS+SC/tTAJN4MMinGszqMl/TnsDyyHakSrVEX+G905
	MzGtcwHRO5ACnfqKRWcDATfOxGmDet0fMdnDbPhvgq8A0Mk7ZS2ms/7jGux80m9/dB+LS4R4vIE
	CIqkBPu2CpyZsEgMa+Avhlp78vVIVBZQ8hZoqjgjRYBuJICI0PqjVeqEx3glNaWetItp6YuvAc6
	DqER5R78FcYPGqlN77WVOPqR7t1XPVjQ=
X-Google-Smtp-Source: AGHT+IExHYamVdOAcgQV8wp2Sxz6sXo66oWwsm5X4uR2NdQwoTIYNsv249mMC/XJXTvsDtdfpXt8aQ==
X-Received: by 2002:ad4:596a:0:b0:70d:edda:f4ff with SMTP id 6a1803df08f44-70fac6f831bmr48324426d6.11.1756640194107;
        Sun, 31 Aug 2025 04:36:34 -0700 (PDT)
Received: from [127.0.0.1] ([135.237.130.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb28383b9sm20519076d6.37.2025.08.31.04.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 04:36:33 -0700 (PDT)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
Date: Sun, 31 Aug 2025 11:36:27 +0000
Subject: [PATCH 2/3] clk: samsung: exynos990: Add LHS_ACEL gate clock for
 HSI0 and update CLK_NR_TOP
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-usb-v1-2-02ec5ea50627@gmail.com>
References: <20250831-usb-v1-0-02ec5ea50627@gmail.com>
In-Reply-To: <20250831-usb-v1-0-02ec5ea50627@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Denzeel Oliva <wachiturroxd150@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756640191; l=1688;
 i=wachiturroxd150@gmail.com; s=20250831; h=from:subject:message-id;
 bh=5UMA1QQbhpw59AbBzA24LNrq4MiD/a6bEyFrWmfD9AA=;
 b=jzsHw7/2Z/SAz8j9iHAzScqWyZXLXTBtJv7RhMq+aamElMTrlEiFWBFvcyT31bvKxO4J1KdPZ
 h4q9KYV5gcECA2Pr61g/PalEvkcP0getvfVGo+OnzKyk3aZCfQyrYpB
X-Developer-Key: i=wachiturroxd150@gmail.com; a=ed25519;
 pk=3fZmF8+BzoNPhZuzL19/BkBXzCDwLBPlLqQYILU0U5k=

Add the LHS_ACEL gate clock to the HSI0 clock controller. This clock is
critical for USB functionality and mark it as critical to keep it
enabled and update CLK_NR_TOP.

Fixes: bdd03ebf721f ("clk: samsung: Introduce Exynos990 clock controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
---
 drivers/clk/samsung/clk-exynos990.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos990.c b/drivers/clk/samsung/clk-exynos990.c
index 91736b15c4b4a0759419517f7b04dd0a8f38a289..7884354d612c54039289fa9b80ad08f34b9b7029 100644
--- a/drivers/clk/samsung/clk-exynos990.c
+++ b/drivers/clk/samsung/clk-exynos990.c
@@ -18,7 +18,7 @@
 
 /* NOTE: Must be equal to the last clock ID increased by one */
 #define CLKS_NR_TOP (CLK_DOUT_CMU_CLK_CMUREF + 1)
-#define CLKS_NR_HSI0 (CLK_GOUT_HSI0_XIU_D_HSI0_ACLK + 1)
+#define CLKS_NR_HSI0 (CLK_GOUT_HSI0_LHS_ACEL_D_HSI0_CLK + 1)
 #define CLKS_NR_PERIS (CLK_GOUT_PERIS_OTP_CON_TOP_OSCCLK + 1)
 
 /* ---- CMU_TOP ------------------------------------------------------------- */
@@ -1332,6 +1332,10 @@ static const struct samsung_gate_clock hsi0_gate_clks[] __initconst = {
 	     "gout_hsi0_xiu_d_hsi0_aclk", "mout_hsi0_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_XIU_D_HSI0_IPCLKPORT_ACLK,
 	     21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_HSI0_LHS_ACEL_D_HSI0_CLK,
+	     "gout_hsi0_lhs_acel_d_hsi0_clk", "mout_hsi0_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI0_UID_LHS_ACEL_D_HSI0_IPCLKPORT_I_CLK,
+	     21, CLK_IS_CRITICAL, 0),
 };
 
 static const struct samsung_cmu_info hsi0_cmu_info __initconst = {

-- 
2.50.1


