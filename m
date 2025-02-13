Return-Path: <stable+bounces-116335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A00A3501E
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 22:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB287A3ED5
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 21:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91787221720;
	Thu, 13 Feb 2025 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="QIy+G1CL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2C526619D
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480751; cv=none; b=k4wcq5ENeWWA4XSBXkzxdxocLmXmz4HIBJdhzI3eOOAChzvH+9211J4y+3DV0kBcEj4OL85sJ32VjgO2y5aULmkS6qnOo4wpfOfOjcSdEV78FRzImowEf2bP+AyNU+uE3Z3btm4mzxT14vJ/Idf8h/INyKUDh/YShG4rvV6y+Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480751; c=relaxed/simple;
	bh=Ws6iFJpvHxmaBtwyedb0vWZcE9Hhm9sGOq4GFnkEUnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flaAxAK+hb+18FhwNroGGa/CVyia7ClKilwaRn0j5omh7cRNcjmnVLIRMMtYFk1O4aVfUFq7PuvLLen+W7eghB71AVHYMmf+yigtgXI/p2VMsKOu0eHiEBdRB96u61013FI23dlqgVf3wYTdlRN2XYYT42bSWoc+qdrLUbCkg0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=QIy+G1CL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4396424d173so10203815e9.0
        for <stable@vger.kernel.org>; Thu, 13 Feb 2025 13:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1739480746; x=1740085546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSqnIy7Es9O1D62Gmw73IwQ1Q2czJE1Ze+P+6EWBU1w=;
        b=QIy+G1CLM1Sgy3HJ6acIGGEJCenYmaYg/+/gGM+Q/5pmZxmyTdBCmlrx9EqDPDcX5B
         F+wnsFOJrg5xnXEhzPPZN35omFM0z+hhnPz6O83dmcxQyV2xJn39ZYz6UYIzT/f22GV7
         gIxbC40ElsZcZ6cfLKU/NPAwdoQSComSeHf9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739480746; x=1740085546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSqnIy7Es9O1D62Gmw73IwQ1Q2czJE1Ze+P+6EWBU1w=;
        b=E1FJGMQoXyAWNwtkE1jQklRtMPJBudJfngJXs99EVDnYDHRG26YdcKOQArinXd8sjl
         epqQzSVIB9OKLod7k7llT92Q3uDr0ixC+0aV9hKbgJO5Na+4U9wQbEzl8jxiNilVc1Z/
         1lax1vziIpQ16dwIUW+E1iREwDu5eD5xtLK56zVmfP8BlXxzupiiSnZYdl6dv1sBlZYv
         Z4MEio+zYi4SjgkRAwjhOrgk8viQeG+UCUfRMMVE0Q5BQ57FNjrwOaMjmT9arsBILqlP
         Qa9jpkxEUDvYx+rpN8fz0338DggCPKmZAgqvaxoF01dXjPZIUsNAXnjCb8xVyseVt6Mo
         oIBA==
X-Gm-Message-State: AOJu0Yxq6RYtUtw05TDqo6yT/9y0ynOESgI5qzrxd6GyA3fX3G48V3tl
	gQKfMMqCsztYisQzsV10U6LbVOYB0+zAwKWsbFMe3tZPeah5Wq16Yx3Dua7VGjgWQyFbSLy12Uu
	V
X-Gm-Gg: ASbGncsDSLBsNj0XOpmnWIDJRL7AqhDBIrO48A49IHwtMbPyznuKF/YvfqyGUJe0viy
	nxcZOrBof1YGPcv5ZvD9z7FNqKwYXkEFqQTJB8lsftx1elAtRa+JREFN7fr0uQvu3qm/HyzF1Av
	Yvpvc0ftxHb20bEnh1tXz7ky7CpMNDnOsH8i3L2w0hm5lc5B4t8UCh0jKBIDUJR7F3NCyujmC6D
	ifoViE+oAEcXGZOuc57Scsh6KV5KFvtbxQFcAt09r1xmFpJZwJGxTLa2UmXdzngd4DkQXvJocpo
	s0TVC0GK5y9RFWJcYhx9VPKVpxNeUrAndnvKYMDOyUensUuBvt4z6hnN02h8Pj3MaWX2ofUfwef
	8Ef5QhGO9c+EA
X-Google-Smtp-Source: AGHT+IHrED963hIbUv64mXHPYSeyt8fivBWdEEgVR0eZs9pABXx4oy2LbcxkfrVxn/UPz9IDciUo+g==
X-Received: by 2002:a05:600c:458e:b0:434:f4fa:83c4 with SMTP id 5b1f17b1804b1-439601c530amr72115805e9.29.1739480745714;
        Thu, 13 Feb 2025 13:05:45 -0800 (PST)
Received: from P-NTS-Evian.home (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr. [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617da90bsm28100335e9.4.2025.02.13.13.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 13:05:45 -0800 (PST)
From: Romain Naour <romain.naour@smile.fr>
To: stable@vger.kernel.org
Cc: Romain Naour <romain.naour@skf.com>,
	Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 6.1.y] ARM: dts: dra7: Add bus_dma_limit for l4 cfg bus
Date: Thu, 13 Feb 2025 22:05:10 +0100
Message-ID: <20250213210510.844588-1-romain.naour@smile.fr>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025021032-showgirl-penknife-7098@gregkh>
References: <2025021032-showgirl-penknife-7098@gregkh>
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


