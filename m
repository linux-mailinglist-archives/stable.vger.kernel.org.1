Return-Path: <stable+bounces-208193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F67D149A1
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 18:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B9923034439
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC8C37F722;
	Mon, 12 Jan 2026 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXrw1BLN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C55837BE6D
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240466; cv=none; b=cZFtukJp/PHhDQGymzqNhTeY9eUcK+t50ao8oC9jy17kK2clecqNQTKjMN3VWVLNtWOFUsxtJUG0HaxGFOvGEWqIlyldKPPfdNxEH4b9cSwL1H7tti/IPBl8WEszjVP5W3ul4CrRGJJLGSTlHdE3NS829S5Euk4UOxtILYG+GCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240466; c=relaxed/simple;
	bh=7RRinxojQrTMI4b9pZDLLzquZeo32XzsK/RNdDcG0aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHSg9Zzbg/qHDEMz28Wa0uHnxqsiZFcDDcnkN1kVUK7lLO9woRvFWQgEBFD2/DrcsC4TD8dzTtzc8G4h9WTuPX4pv5FoqX4a7Sup8eWHZGl4VfGPZEFl5R9uO0MF7HmOUk2VRin+p5XWPiZ/2mBcZN3T9PofVQDyGyJvpAMNiV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXrw1BLN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso61382245e9.3
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 09:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768240463; x=1768845263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ6/E1tgqYIjow3S6Hfpj3KTp0Kx78pCSAMldDRrYrY=;
        b=BXrw1BLNWpcc++sVgZJ+/XZ82XB7E/MTBrBKzYT75H7QHnRNM3hadhaEFU6/j8/cRg
         crdFloOzm5hazXX+xRSsNxPDLcZiNx+PIhHWd/cGnt2xNX1VoAbWvIaUAjzAnbMCgqnF
         1HwWjIkYO3IgheCUwfyvQDngG7fPo05Du+AAswGyHzibD+rKoWkJF6TmjYB/08hAUjC8
         GOO8PduX2MpQF/k6Edi6hV+eaLTe+wn1JEh0XGRP6p9S0JOovjSI3g/JIkhv3/vDBmbs
         vWjaLcQIgOg+Qx90h3XL7Lxy0fNnHTEpRTD2/qqL7+bgD1tkcvekTNMgSqfrhytaXuF9
         mELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768240463; x=1768845263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iQ6/E1tgqYIjow3S6Hfpj3KTp0Kx78pCSAMldDRrYrY=;
        b=PEiJlgb7bzWZtFcxzViSgmYlr0drAjwiqxtmS8tvRSHKJfkQsx+1sm1HphHpxlE+SZ
         3i6VyG9m5Tc7a+4UDCzTqAL/XPcYROpaeqm3P3NMoH346BBb1jaVxPNqP5rOVHjL83pm
         YhayyWN1+Z0qE1FscTVi31dymEtOTCrzWamXPmZ+K4+5O2yNmC6UtuHC/GAKquoyW1+o
         QNjfKPVmDcacpXccwuuA7RJ2rcRwL60f6jUxz2ULldNpd4U7L2NlziteYgylAROuNHAs
         n0kSkjJcCWC5weOanKYEGUbtKhIBv8RkfpUU0FOnZJZo0YapSkrPLZVHSGtD1c55j1jL
         IWqA==
X-Forwarded-Encrypted: i=1; AJvYcCUaLqRn0YoJEfuNTccmvi0xdXkX9SCUcUdYt2DXLQr4dPcy85RRcZ27xyFBUK+qsbRKJMbg1T0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYN2zI/98wvHdwBPaflgk7qgv17Up7bsVDgjlm8dzkf6ajnZFZ
	+YJSZe4WupUZdUAAJYAn36xnkxp7Dh9DUS8DM0Z8hDaktLSxvUT+KmC0z1Nkeg==
X-Gm-Gg: AY/fxX5EAjsNeYDoaFmVAopyFyMcYvcSRQSmQ4TR4GlSY0SAMJLLjgJZSbZTa+1g3wU
	hZn8IouMSQy/cB6MvmqEj2Z0WAlmscqcpLmljFxzwonYu1tTZtW2Y2Wmji8rqRsvVAT8s6OlrEO
	z/Xc0s9GlSCUAch2N4eSTJ/raLfeBLKWJhIGhIgD90M+VD51jUGjWrTYZyf7ObAm4Js52yROnH1
	IZewZsEFY728q2qXDOhZ4Ubk5jwEkEgsVVNPLKE5Kzs6VyzeFzSkksPUOhMjHIpqWm5wskI73mQ
	e4BKC84V+8G7IjGGkMHkLZ+XX36cToK7F1msuhlfsgHEm5G1YY6ytdDpJOLS5nEbhJYdk4WMBy3
	vRBcovX/ySK46kItrn/QI5C+Z8b93j02k5fb0OIGXiJMAMaaX/KMJYZ/7V8uGZ1mofH3S/tkxl/
	uxPmJYaTgcQCRTvqmKPbXCO3hsRe4=
X-Google-Smtp-Source: AGHT+IHGhWNkDca/+FCzmz49RYaZy2H/+LLzjBgLUetoD+8ejUSWqAtQI6jGW5uDZGAQmISWirqefA==
X-Received: by 2002:a05:600c:1394:b0:47d:3ffa:5f03 with SMTP id 5b1f17b1804b1-47d84b3467emr225515145e9.21.1768240462813;
        Mon, 12 Jan 2026 09:54:22 -0800 (PST)
Received: from vitor-nb (bl19-170-125.dsl.telepac.pt. [2.80.170.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8719d057sm134047305e9.16.2026.01.12.09.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:54:22 -0800 (PST)
From: Vitor Soares <ivitro@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ivitro@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v1 2/2] arm64: dts: ti: k3-am69-aquila-clover: change main_spi2 CS0 to GPIO mode
Date: Mon, 12 Jan 2026 17:53:47 +0000
Message-ID: <20260112175350.79270-3-ivitro@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112175350.79270-1-ivitro@gmail.com>
References: <20260112175350.79270-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitor Soares <vitor.soares@toradex.com>

Change CS0 from hardware chip select to GPIO-based chip select to
align with the base aquila device tree configuration.

Fixes: 9f748a6177e1 ("arm64: dts: ti: am69-aquila: Add Clover")
Cc: stable@vger.kernel.org
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts b/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
index 55fd214a82e4..927d0877d7f8 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
@@ -208,7 +208,8 @@ &main_spi2 {
 	pinctrl-0 = <&pinctrl_main_spi2>,
 		    <&pinctrl_main_spi2_cs0>,
 		    <&pinctrl_gpio_05>;
-	cs-gpios = <0>, <&wkup_gpio0 29 GPIO_ACTIVE_LOW>;
+	cs-gpios = <&main_gpio0 39 GPIO_ACTIVE_LOW>,
+		   <&wkup_gpio0 29 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	tpm@1 {
-- 
2.52.0


