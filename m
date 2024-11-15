Return-Path: <stable+bounces-93510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830B59CDC86
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 11:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBF21F213F3
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 10:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE0618FDAA;
	Fri, 15 Nov 2024 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="tF/2Isf0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1561FEB
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731666347; cv=none; b=BHgREzqBo4dVc6vz7l4dlnsdSDobWZ+q4SOt2TkdIvqlJGZxcMU9cFfxpBK8z8hAe8QKm9Ax9DNyyo/uYfhUvV6sBF5S6ls9oeKaZ5mpOEIb7jJ7JeV6YOqGOljM1Bbd8HCr/Bzq/8Jkny4m7v0X+BYU+SB4Y2zTrO390UWxqE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731666347; c=relaxed/simple;
	bh=uXIf0NJ2Ff6YhkZvGG0A1U1gPPLiq+QFtNR2pFwCxcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i55e5Vwr1uoP6NoOc2KY2Z+W447+Gt8cFbFj+6JBPUS/98iRKtqkqBP2M9wiKUVw6IHgAhCkJg5m2VK5+J/1IFQqdbZpFkHibE6jVjYh0Xm3dcJRVq06HkAoEJvms3YwmCcWFDs2k0ME/jK8yV+3s0WqVvL6UJROwNJQ/RH1Fk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=tF/2Isf0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso14672295e9.0
        for <stable@vger.kernel.org>; Fri, 15 Nov 2024 02:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1731666342; x=1732271142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkTaxhy56Mwcqt7Mg2BriCem6Pn3ih9G1CSYmGmRFXc=;
        b=tF/2Isf0aovBs34+5kyJiMswpDILUXoxkAa+ee9lU/l5sfK+Ktik6uEPBba/H6Jz6D
         Ol2BFXdCpXEUBCH+5fmzA6MQTAhCuOBUSV5ZA4OBzYE5rOPJzp7f5lGF2Vttgx+Jfdm4
         o1ctcgSIWCZHc5wXWfz7myw1IRRRisWaCIrbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731666342; x=1732271142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkTaxhy56Mwcqt7Mg2BriCem6Pn3ih9G1CSYmGmRFXc=;
        b=H2rPnyJ8PF4N2N5AQIISZrZbi7GIGn9/zp7v3B5zPGihnuiGOum/sQVxreuOMiorf6
         sHIH3cyhWSGctn9iBhWVNaQPXF0AVq3PEJTXBTYufR3YtYkRne33pL9kTQbkKWiYSmOW
         4T4Sy/6M6iEG+vPyH9EFuxD3jfqS1OAzo90BRDc+FL93wRa/dTkpYGRKsqS8i007IlQZ
         5Re4i+3S46Pt7CzGCQ3vn9LF+5hbrHgXyFxSI4gVrLUJzmxVLiPfWnaAr77xlsQ6z5xl
         EDl8to67LiNcG2nlAVsMV3YHbkstfii8eTCFYzOScpC5l4uWuKxEIxFTvpYVpfFj0Mw5
         vGDg==
X-Forwarded-Encrypted: i=1; AJvYcCW2hsSFsVg85oiKDxcdf7+B21reRTs53f/FOK6lHAWBZ9a6aNoPoWjP4ABsj8sbVimkuyjUknY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDa1dxrBlq6uTNqrvucEsj5NRegn/uvTZbkzhHmF9+es67NTD6
	vwV2nrlA2b3A5il6pcQdWLUGUT8/QBsxqGUsRkhYgtLBbsDFDFeYtUdXHmFR3u8=
X-Google-Smtp-Source: AGHT+IG0m4WAcGBu5LNbGsx6j4ydvgGP74YeW0Wx/GElg+fbuA667xmvAeUDZb8SobqQvtjR9CVM2A==
X-Received: by 2002:a05:600c:3143:b0:431:9397:9ace with SMTP id 5b1f17b1804b1-432df7411b0mr19095575e9.10.1731666342183;
        Fri, 15 Nov 2024 02:25:42 -0800 (PST)
Received: from P-NTS-Evian.home (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr. [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab788a2sm49170175e9.11.2024.11.15.02.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 02:25:41 -0800 (PST)
From: Romain Naour <romain.naour@smile.fr>
To: tony@atomide.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	stable@kernel.org,
	Romain Naour <romain.naour@skf.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ARM: dts: dra7: Add bus_dma_limit for l4 cfg bus
Date: Fri, 15 Nov 2024 11:25:37 +0100
Message-ID: <20241115102537.1330300-1-romain.naour@smile.fr>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Romain Naour <romain.naour@skf.com>

A bus_dma_limit was added for l3 bus by commit cfb5d65f2595
("ARM: dts: dra7: Add bus_dma_limit for L3 bus") to fix an issue
observed only with SATA on DRA7-EVM with 4GB RAM and CONFIG_ARM_LPAE
enabled.

Since kernel 5.13, the SATA issue can be reproduced again following
the SATA node move from L3 bus to L4_cfg in commit 8af15365a368
("ARM: dts: Configure interconnect target module for dra7 sata").

Fix it by adding an empty dma-ranges property to l4_cfg and
segment@100000 nodes (parent device tree node of SATA controller) to
inherit the 2GB dma ranges limit from l3 bus node.

Note: A similar fix was applied for PCIe controller by commit
90d4d3f4ea45 ("ARM: dts: dra7: Fix bus_dma_limit for PCIe").

Fixes: 8af15365a368 ("ARM: dts: Configure interconnect target module for dra7 sata").
Link: https://lore.kernel.org/linux-omap/c583e1bb-f56b-4489-8012-ce742e85f233@smile.fr/
Cc: <stable@vger.kernel.org> # 5.13
Signed-off-by: Romain Naour <romain.naour@skf.com>
---
v2: add stable tag
---
 arch/arm/boot/dts/ti/omap/dra7-l4.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
index 6e67d99832ac..ba7fdaae9c6e 100644
--- a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
@@ -12,6 +12,7 @@ &l4_cfg {						/* 0x4a000000 */
 	ranges = <0x00000000 0x4a000000 0x100000>,	/* segment 0 */
 		 <0x00100000 0x4a100000 0x100000>,	/* segment 1 */
 		 <0x00200000 0x4a200000 0x100000>;	/* segment 2 */
+	dma-ranges;
 
 	segment@0 {					/* 0x4a000000 */
 		compatible = "simple-pm-bus";
@@ -557,6 +558,7 @@ segment@100000 {					/* 0x4a100000 */
 			 <0x0007e000 0x0017e000 0x001000>,	/* ap 124 */
 			 <0x00059000 0x00159000 0x001000>,	/* ap 125 */
 			 <0x0005a000 0x0015a000 0x001000>;	/* ap 126 */
+		dma-ranges;
 
 		target-module@2000 {			/* 0x4a102000, ap 27 3c.0 */
 			compatible = "ti,sysc";
-- 
2.45.0


