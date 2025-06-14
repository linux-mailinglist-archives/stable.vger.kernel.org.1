Return-Path: <stable+bounces-152647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB81AD9EE5
	for <lists+stable@lfdr.de>; Sat, 14 Jun 2025 20:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433843A8489
	for <lists+stable@lfdr.de>; Sat, 14 Jun 2025 18:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA2B2E763B;
	Sat, 14 Jun 2025 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKO7pE8z"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253792E6D0B;
	Sat, 14 Jun 2025 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924911; cv=none; b=OEmyakTVdz8VnRQirqT0itLqVzHp/saU+eID/te1C6uCgFi7lbyZiwCQVN6GIkkRPwmUPwupUiGA2tZHN5WqI0+oQEDmTIirOfa4SzjxE7LZSgNvuZm0OeS9Jl1S1iunYnDCGSgDjTGFKMEeH/i9Pl7zTos/J6M4MTOfKeJDRZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924911; c=relaxed/simple;
	bh=QdElGcOzwWgLhHGEr9MDl1bHr4d6LFvNBBvG2cBo4I8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UB+nQk5HeLySDNimeOCGRkWXUKt90DKNaqkgLo1IiZJTtHetYJu9DGlfMx3E4qZoxKW9mJBJk7gUGU7FpfK8cLtRUWilr9wyeSX1MRQs0tWkr1cXo5jP2wS3Ij8QHpaFkfLbx9jQ/xYOKQ9sqVcR52gy2otUF6W/KdHGj/lJ+vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKO7pE8z; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so1898776f8f.1;
        Sat, 14 Jun 2025 11:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749924907; x=1750529707; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kotMzWZ0zLMFy7t4bMJZwNuDsod7XWhOWO/9hNBXGWI=;
        b=GKO7pE8zBay++G3VINBxtybU8bQ8SAyREclnzktwTrg4It1duBHCGPCGb1acN/HElx
         yE2MhduodOIztS4UjHJ77dalciBgf4FqUAwESLtIXV6FmKI2ZlPRwVwbX7odQh1W8KGg
         YC6b2n10PBGRzRntW4FnyKPI52TjGiZOimMyYFNkkqRyDEMPpZsZVda6Ax6nDvCMC5RG
         b45yFqBL2wOkOyKZRg7dDjjy+SzUikT9oM49lriKlDBNCOjofrwa3VI4Q0vAAW20z5l0
         xBL93ChAFheB1Gib6ELljKXonwpSkpKTk3yi+fOqAo0UvVO9u3TX9fR2AqjChbwy4fRF
         zJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749924907; x=1750529707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kotMzWZ0zLMFy7t4bMJZwNuDsod7XWhOWO/9hNBXGWI=;
        b=wbhHG8mS4MEX4g1OXxjh7a9EbSwlyMzOiYvCKT/KBRtFvb4ni0mTsfUxO2SxwlAXLi
         Cq1yGyUIs/0VGFzltEbW2bQpvyMvbeNb5KAh7S4rmzli02u42+T/JGAxZVZ4gGoWXXEB
         7NYRFUvfS/fPbH4HIukZ2rkNTItHwdHM8O7WypTqr/STO5aLjjMKCBFnDOxjuAEl16sK
         FzuzaJGKOv22C4sKbylqsv+mhZxVt/j0fQa3dlJeeloXyS6a6NkH/QEqnR7MHgz00Lpf
         DtdWLEG8MGkdZ52wHsh2tbw42ZXGFRe0fGER+deCCwBXvJ+WX+aJD8erYNqGuW2zkSwR
         F/yg==
X-Forwarded-Encrypted: i=1; AJvYcCWSTwi6XN7ufRaTxIUwSmxcIM2o36yBv1Uvr65V8OG38bwyu7feW6m0QDs1Et15Un6wRrAiFq5edGZtD5I=@vger.kernel.org, AJvYcCXZjGA8HbAsbr2qzBOHGX8cF2/fDTm0dVXynoXJzH5id38l7sXgbnBs9YQfrSI6vdUeFvKBTnKQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxCc4H1OwV0lSySHk6itzow+2BTMAeB7t1hfOQ2CPnHTH5lwURE
	sipZGPVv5UWE5VELSj4YN1CnTNKVIxlHFma3WDU8DEnBD5GI7oZQi5JS
X-Gm-Gg: ASbGncsN7DI3pYaqFBR/6F1avogdrFIK2lTPrWFWPHwP6CN8ahlthSKyPnDp77ESPB0
	8bTBqubKcDcFqPK5txhtuf1F32dUtflh/+hKnbfFM0aWXbMyUgQk9XTvset0nW26iWItIMyaojK
	hThqvrQKo5oTibzQHC+YdP4sku7TTf4mck0zXrv6glMP+Biznc9FfzwbFV6isS1j7FK2F7bZPNt
	KyiNWGDl7jt9E3k9IcOjpkDcfRvf1htJ7lGbBs6AipPTOKPoQ+B9Mi/BZVv8AhmN4Sbdrj4MavB
	KFFB9kinMa0TW+32siDf/hRr+FVbAamjCHu2jZe1AtazEl+VVVsIGbJemldKVY7z/U19tyL8H7l
	fRg==
X-Google-Smtp-Source: AGHT+IFR4cqqc2eCOz0C/iQEhfLitX2elIxGt3D3mCWCWrmmAD6CaePuepyuNfM65uKa6bxZ3sBGTQ==
X-Received: by 2002:a5d:5c84:0:b0:3a4:f55a:4ae2 with SMTP id ffacd0b85a97d-3a572e92c50mr2925691f8f.50.1749924907228;
        Sat, 14 Jun 2025 11:15:07 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c50esm88195255e9.4.2025.06.14.11.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 11:15:06 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Sat, 14 Jun 2025 22:14:33 +0400
Subject: [PATCH v2 1/4] arm64: dts: rockchip: list all CPU supplies on
 ArmSoM Sige5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250614-sige5-updates-v2-1-3bb31b02623c@gmail.com>
References: <20250614-sige5-updates-v2-0-3bb31b02623c@gmail.com>
In-Reply-To: <20250614-sige5-updates-v2-0-3bb31b02623c@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>, stable@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749924902; l=1915;
 i=alchark@gmail.com; s=20250416; h=from:subject:message-id;
 bh=QdElGcOzwWgLhHGEr9MDl1bHr4d6LFvNBBvG2cBo4I8=;
 b=cgSA57cepXZcVv6ZPbKxYOxuxZxJek5TAKiawvvBrPyXqC4Q5ALi/AvBqL7/VFcoqDr2XbqKY
 v765NdmZ2EeAAYtEnDczgPJ+i3fgGivUkqrhlv++n07kN4UzbWJxNbb
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=ltKbQzKLTJPiDgPtcHxdo+dzFthCCMtC3V9qf7+0rkc=

List both CPU supply regulators which drive the little and big CPU
clusters, respectively, so that cpufreq can pick them up.

Without this patch the cpufreq governor attempts to raise the big CPU
frequency under high load, while its supply voltage stays at 850000 uV.
This causes system instability and, in my case, random reboots.

With this patch, supply voltages are adjusted in step with frequency
changes from 700000-737000 uV in idle to 950000 uV under full load,
and the system appears to be stable.

While at this, list all CPU supplies for completeness.

Cc: stable@vger.kernel.org
Fixes: 40f742b07ab2 ("arm64: dts: rockchip: Add rk3576-armsom-sige5 board")
Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 .../boot/dts/rockchip/rk3576-armsom-sige5.dts      | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts b/arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts
index b09e789c75c47fec7cf7e9810ab0dcca32d9404a..801b40fea4e8808c3f889ddd3ed3aa875a377567 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts
@@ -211,10 +211,38 @@ &combphy0_ps {
 	status = "okay";
 };
 
+&cpu_b0 {
+	cpu-supply = <&vdd_cpu_big_s0>;
+};
+
+&cpu_b1 {
+	cpu-supply = <&vdd_cpu_big_s0>;
+};
+
+&cpu_b2 {
+	cpu-supply = <&vdd_cpu_big_s0>;
+};
+
+&cpu_b3 {
+	cpu-supply = <&vdd_cpu_big_s0>;
+};
+
 &cpu_l0 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
 };
 
+&cpu_l1 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l2 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l3 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
 &gmac0 {
 	phy-mode = "rgmii-id";
 	clock_in_out = "output";

-- 
2.49.0


