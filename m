Return-Path: <stable+bounces-124454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87911A6151D
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 16:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD81917CDEF
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6E7202C21;
	Fri, 14 Mar 2025 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tvG5pOgc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300881FECA9
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966700; cv=none; b=nxQktsWNYeUrapw2/RE45G7/ZNGV0f4xWFeKlScoMPHmAgxXDAbtugLpaWv7e0MZ1j10A9tZv+DL0Wl5gTkn3NoEg8JDi9bsRU2E4YP4Fzzz10PtbxGhqlCU7uTiLnr/Zw6ZPLPqU9or1uthcO2YzN7ZBLSmsmrAWlJ0LqARBOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966700; c=relaxed/simple;
	bh=HSyPEmJtBsHxDhCUULm5Dya2418jRqfFk0guvCilkbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IqWtoui9bl0ajSaHTuuudKAws7RApH0JtvBKWZNrPfaqcxMvV3MNH/FyC2Kx+MXFk4LHommc+9zBHDok1mcFDFXoY+8YJ1FKi4FfCf97NGFt9Xf8wK7Z6zm4w1Rl62PKB4lqpTzGwqmlYnx2YP3M+K3KTmEyjWKoHTL3Q+ksLac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tvG5pOgc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394a823036so21608615e9.0
        for <stable@vger.kernel.org>; Fri, 14 Mar 2025 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741966696; x=1742571496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQ99iJ98td/B0zL57VABB7szu0CnieeOt84tDi+jGkE=;
        b=tvG5pOgcfe/r81tAPiVpE3WQr/uxysUpkxoK1ur9TDqCCCMR3nX+Jf0GVQkLb3UAG1
         eKHPtLkOHF50nhWOZ9HFaFTvJnt2qL9DRTY2bVsPZM0/HrWOdFuerkS+70Ph/R2QRwV5
         LprPQQX8ddlYNXtlIGAOl5ypU8keNWmYrVpQI1/58UhTlLCQmnjeIe9E7ocGbNRjynDL
         RTVJskTUxKzaBWO0SRKZllPH0+9DhFBgiCK0bYUZfelh90+iCVjE6aw0uMej7E32z6Pw
         k1h3q7PUqSiEETD3c/hKax6BcUec0dKg0RTWDxpRrpmivf5vB8vZPWuKbxG/A7i9jHX/
         7qiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741966696; x=1742571496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ99iJ98td/B0zL57VABB7szu0CnieeOt84tDi+jGkE=;
        b=q5XxUByY+4I4yN5cUcEN6zdyRqhZAur3DqiT6n8LPp2RxbiS1GnJFO1znlOoHY83py
         B2jujltWo6aUhzEyekHQZ1tOJq4E0J9q1DDAxiPgslQDb+gxCuBF1QSX2Y2XeyLsWI5N
         W+YZq74le80HAXNzj5qKzsn3cTmiyPhyLS3Nl2rH7xy97L+1+2+rAVw/ZTHZzrCOxe0Z
         epZZwzrOTaSviYuM22h/5ecImrmPvoHiJyivy6IkHq8pt/Xv8Xfm65753YTD2m+Gu/Ij
         j/Zdq51gWKOeQjv16Nw8Bnd+Rk5FQ9drpvXtnEAF+9VPFWp2pMLnKaVedS9Zgk8mYwyR
         p+IA==
X-Forwarded-Encrypted: i=1; AJvYcCXaejb9yY3/wHSRV9pMXlMq5e7UBdWuPUM5kT94fGLLqqwcfcEnF7tATd83aLXoFMCyrD0l7J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmuNmg5sAYTMfxVlvA8gHQhiOrUz5tCe2mDDJX9qtdcAG24LWo
	EqxNaXAi2L65BAXMLUREwN5vCHrKpl/uVr6TRX45KsocG6xMEFR8Bil/ODqvjeY=
X-Gm-Gg: ASbGncuxgDj6cT1uFWNFd1K5UmDfUZSx59vnRuXkUnDF6YNAGnkvBxCXDGzSH7zI4DS
	REy3KeZm4lJ9n3OyyjQDFtPyVSqm1iIVSrwhv3NGiYvNK7huxkzgG7GKX9H4k9ZJS9Rk6/+ezaB
	wuwsG6LguBsdOXC+FqM5zlGSD3vSvuonExN3AtwgGL0xfGI7kQrbX1rXpTLbaU22ij1R8Xs3Pkf
	6sbAnsjE8oGLiwpcWsIPbURT12xFw6kckjNDc+tvlGrh000Poqa6vTQ5TA9VXHskV8ouDo81MSm
	29DU5L/F/NWDj51Jp/uRwue8a6Yf1GIlwrW5JVM9YZGMfrRZrhXrcE93SjGaVmKDg9B7jvP31Nu
	rUDEv4I9OFCU=
X-Google-Smtp-Source: AGHT+IH7++KO6U3/Ls5QrCBpzBE8hSy6ZKSBdIjCMesbwEWDqmyH8LmW+4NNaM1O/LoeImomGS20uw==
X-Received: by 2002:a5d:47a1:0:b0:391:2a9a:478c with SMTP id ffacd0b85a97d-3971d70c23bmr4277553f8f.23.1741966696382;
        Fri, 14 Mar 2025 08:38:16 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([209.198.129.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdafsm5944388f8f.62.2025.03.14.08.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:38:16 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 14 Mar 2025 15:38:02 +0000
Subject: [PATCH 1/2] arm64: dts: exynos: gs101: ufs: add dma-coherent
 property
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-ufs-dma-coherent-v1-1-bdf9f9be2919@linaro.org>
References: <20250314-ufs-dma-coherent-v1-0-bdf9f9be2919@linaro.org>
In-Reply-To: <20250314-ufs-dma-coherent-v1-0-bdf9f9be2919@linaro.org>
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, kernel-team@android.com, 
 willmcvicker@google.com, Peter Griffin <peter.griffin@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=HSyPEmJtBsHxDhCUULm5Dya2418jRqfFk0guvCilkbQ=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBn1E1kYCQBmCyj5ZPX4kgCPL0qUhJeVs8SYMUGs
 jG0pHfrOVeJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ9RNZAAKCRDO6LjWAjRy
 ukfOD/9qIbmRkrjri21mRCY4ydKJb92uYxQTmLzBqS9EoQqKw3ypCrcUPmvcJfpaXhH+DpWLSSy
 a2IioXKB+tQuqZRLgTsSzAmFr8d1n3q67OAnvPh1Lbf81/vs1hKRH8pfjjl6cuRfZLpo7J98uwD
 rXzds9tzH/JHEJMWfqNXb5PL0x8yDubYQPlrg7FM74C9YYnE9gVYi8CPuXyYuPIeq7wzPaZfcYk
 NC4fLOfTgMXIscvqeUd+ybPUSz4iJQTqn9r1yKZikyXqyr7zdY3vHR5jhgV1TkvyKA56I6wA7Cg
 9mvSJgXSeglXhnLEnf7QqASjQxHkzcXPgQcsCmkfUsPWYuzil2U55RH2SI1Q33PhdjKsK4Vi9P+
 leUhppTQRotRB3f38/g8gyh45DP3VdfDFAL4y0Hm0hZWnRFmSBzPBgjhLoayKeln75j7B1vgRgH
 /8znc1PSTMKIe9EcT7LNnGe8+kSwHMOSuKyawIBFRQI/gGgiFOYvnWMZej9B2ZTa3uQp0WSbV+3
 /mxOVssXI9mS1r2sfTuMeV4BXfo8wPxsE7Bf10tVpbljxq17THjVCyjaD4qYpjWYBAYJ+NI6IZV
 vRqX3vpHKVMoL6e1KTNUEVHCDqmvnUCLNqOjia0oLpF/tAfqujQFEoig5Ck2h2ULDvvIB3trQ9k
 W+zbPT/ONn7vy5g==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

ufs-exynos driver configures the sysreg shareability as
cacheable for gs101 so we need to set the dma-coherent
property so the descriptors are also allocated cacheable.

This fixes the UFS stability issues we have seen with
the upstream UFS driver on gs101.

Fixes: 4c65d7054b4c ("arm64: dts: exynos: gs101: Add ufs and ufs-phy dt nodes")
Cc: stable@vger.kernel.org
Suggested-by: Will McVicker <willmcvicker@google.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index c5335dd59dfe9fcf8c64d66a466799600f8447b0..cf30128ef004568f01b1c7150c5585ba267d64bc 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1360,6 +1360,7 @@ ufs_0: ufs@14700000 {
 				 <&cmu_hsi2 CLK_GOUT_HSI2_SYSREG_HSI2_PCLK>;
 			clock-names = "core_clk", "sclk_unipro_main", "fmp",
 				      "aclk", "pclk", "sysreg";
+			dma-coherent;
 			freq-table-hz = <0 0>, <0 0>, <0 0>, <0 0>, <0 0>, <0 0>;
 			pinctrl-0 = <&ufs_rst_n &ufs_refclk_out>;
 			pinctrl-names = "default";

-- 
2.49.0.rc1.451.g8f38331e32-goog


