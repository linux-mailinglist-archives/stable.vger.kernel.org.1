Return-Path: <stable+bounces-116339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36593A35041
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 22:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6BC7188CE58
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 21:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B7D266B69;
	Thu, 13 Feb 2025 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="3z2QF9ye"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48020766C
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480992; cv=none; b=LEzOXQb27bpNlM2y7KV9W97zNEifckGKVmaSpszS3/aBMETevlmDlNpUSVcbOjCFYM9//IlttEtD4MjYlA22PS7u6alUGH2tZruAbfBNj/oOmgpxWlgZVvTlxeFwuJY9nO+3zh1e2KcAOXWpAsRuZ6TDjpC4LgK03NYyoh9Pq40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480992; c=relaxed/simple;
	bh=Ws6iFJpvHxmaBtwyedb0vWZcE9Hhm9sGOq4GFnkEUnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkZCgl/N20zzH6EEifyUEG1jRCox3Xm/6Vxco1ZAEPeR0oATpQgf0GyciuPiMojsjTP+eexIG9HZMNLYiELehbBWiybIy7zIzdwBNRn4D66WdyNogu4oLmO4YPrh0s3Bli/idMcFCQ/vJVGy5K1ThJve1yt8//t1QP+XidwUnd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=3z2QF9ye; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4395578be70so14154805e9.2
        for <stable@vger.kernel.org>; Thu, 13 Feb 2025 13:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1739480988; x=1740085788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSqnIy7Es9O1D62Gmw73IwQ1Q2czJE1Ze+P+6EWBU1w=;
        b=3z2QF9yeddeu+db8/wue9h4C07hHzrKQ3mjBngiVhJcf7qQgGqHNljpvM7LS9ITQlQ
         O19mCHxGrMF1KnTgXBCRIRZrhL1q/lmSbcDXlNImFTmeeQqv3ifFXbmiNl5lY2YPThsS
         IwX0/1E/R+tuwUV/U06zcFKdTKbvlPjqBr+ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739480988; x=1740085788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSqnIy7Es9O1D62Gmw73IwQ1Q2czJE1Ze+P+6EWBU1w=;
        b=bd9UEUU41To+uCB/oljtxBjAoppR00yodXUG1M6Ta8RLgXwouMiOyn8Yz3UxnmBti0
         6ToaQDc2AmSIxlf/qqjEKaVBBj9f37pABTuuzZcuY7ByMP2WKSX5gcO8TAldf4CFw9gO
         hHbVTjPYFyIOwWG7R2NBjBvwlB8Ee3uQ6QHM0UenzyivAHPFxSrmzpdAO28CtAZbj4eA
         GGfGY9yBcqeGUOYUL8X3TahoMFACklH91WrPxM6s0SUW+bM7j8fo7PvxkZlr0QJsjKoZ
         x6cfgVRLkEtNo3kjopdmI3lxljYGvKoeWJSewLojvYpRzysYOtX2NXf2SlHPimFttRym
         2B5w==
X-Gm-Message-State: AOJu0YwOyJ9DF4OYmh1Qa1wP1UmjJAxCuWjncVR8kOhLVvmLHoG2W6VN
	CNLEY3bURxMVrHmLi+KMVLR3SQqI8MD3vgxCMH9CjJSJbR2qwzGHAaRFzcOexL28tW4ytH84fOJ
	f
X-Gm-Gg: ASbGncvR6kEhXCtJTULVWWN3R8YXoeIalu5HYTz7raouC/gbOe+worAkZxgt4GE6XPJ
	8QR8X7FmwLxXdkJbcjNTDNMvB3I03XxsB7trz2JflPd8hIwLw+ikzLs+GD10v+u7/DhUTJA+ohC
	z0ddshH4d/oRJpmgJVdoA1OgoqA/eWISZD8/nSrlks3UYDXgpXgYiLIiYafYhSuJBYyzI5vRutX
	52b39kDUPyY1Q7i8nRy88zROiAu6lMpBpMRGngiUSn0Dn0Qbk2NSu/wCWDiml3f2qQ4I1LQZneQ
	Dd/94WL4AMg9IrYvOFC+DjshwG4kTDgGDC4oC2e+39KnzmuyRUaG8kXOT2gRy989vSQCcv1E+/k
	/2n5638GBXBVD
X-Google-Smtp-Source: AGHT+IFrgC8cAHC8h7VvCsAcXXCbSkSgDsokMXXG5AzDzh3aM46JVj55pdPgHxuhSDD2irc2R2ZrmA==
X-Received: by 2002:a05:600c:2d54:b0:439:608b:c4ad with SMTP id 5b1f17b1804b1-439608bc717mr54909935e9.3.1739480988080;
        Thu, 13 Feb 2025 13:09:48 -0800 (PST)
Received: from P-NTS-Evian.home (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr. [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439618a9ab0sm27063865e9.35.2025.02.13.13.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 13:09:47 -0800 (PST)
From: Romain Naour <romain.naour@smile.fr>
To: stable@vger.kernel.org
Cc: Romain Naour <romain.naour@skf.com>,
	Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 5.15.y] ARM: dts: dra7: Add bus_dma_limit for l4 cfg bus
Date: Thu, 13 Feb 2025 22:09:45 +0100
Message-ID: <20250213210945.845685-1-romain.naour@smile.fr>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025021033-chariot-imminent-753d@gregkh>
References: <2025021033-chariot-imminent-753d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Romain Naour <romain.naour@skf.com>

commit c1472ec1dc4419d0bae663c1a1e6cb98dc7881ad upstream.

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
Cc: stable@vger.kernel.org # 5.13
Signed-off-by: Romain Naour <romain.naour@skf.com>
Link: https://lore.kernel.org/r/20241115102537.1330300-1-romain.naour@smile.fr
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 5733e3a4ea8e..3fdb79b0e8bf 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
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
2.48.1


