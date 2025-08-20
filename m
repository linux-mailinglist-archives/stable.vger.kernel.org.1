Return-Path: <stable+bounces-171874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F24FB2D51E
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 09:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ADC17A3D25
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 07:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB892D878D;
	Wed, 20 Aug 2025 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="REX7/w4K"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E9A2D837B;
	Wed, 20 Aug 2025 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755675797; cv=none; b=tKB1m1n6afZsNm+scjmKhJdfQSU+bBb6Eb+Pv5gUD7rV7Q3BrolGfxv+hv2L6S644Lwi7mNfW1IjybvV8A+kkAAPMglJX8nIcurW+qrH6RuTYsFgtikUpejh9y30yR3BobOUhilq8D9+3cB2axOfyj6v36ILGv+DP76QXhFU0jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755675797; c=relaxed/simple;
	bh=pjGZKvmGxMF/qKgMyngeTm7Z3aNgduzo0JlXz+X9aA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyuIaMCu6HyBICOKmKLV6r9lqUECcf6NZwzSxERb0x8xMji8U8dK33T+b4sDvZUR2a29SVd+uSCIIZzrlq8oSDuDqZtewHhUIyEuZLwspkmCM0I181sMeHBn5ND6FeGPW3DMBUzysCL383H3mkBmtTLz/bS3IxMoczR7DswuT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=REX7/w4K; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7265E20CCB;
	Wed, 20 Aug 2025 09:43:13 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lVV4-Maa9Sph; Wed, 20 Aug 2025 09:43:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755675792; bh=pjGZKvmGxMF/qKgMyngeTm7Z3aNgduzo0JlXz+X9aA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=REX7/w4Kym5QWUu+pglh0MceOIHZE1MgohFpYm7lv00/iHZGJhtFA37tWI07YFLmb
	 bB0/qfYYqrDNGskh96Bb2/2fQppKFTl2xppt4rzLyQEraS8ATJhQierMeg3XU+OEe9
	 nU4PcJq0py7IIzzrEVfJl9DIrTqslRWNI/SYaJMy1riog3QYnMVPI38yWbTvjWWUlp
	 kDS54fxZqQn5vmaQxRH+YIyhATjBVRzY2bYI9rvq9kiSAT3J159wmQUy1SJlUXJKDo
	 gorHC/l2FFK9hRqaQXJ71kKy7kjKxCBVFOA+vbPXfsHDTVY+LKW88aH+05ePGeQEME
	 cpxR4hML4wATQ==
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>,
	Han Gao <rabenda.cn@gmail.com>,
	Han Gao <gaohan@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: reset: Scope the compatible to VO subsystem explicitly
Date: Wed, 20 Aug 2025 07:42:43 +0000
Message-ID: <20250820074245.16613-2-ziyao@disroot.org>
In-Reply-To: <20250820074245.16613-1-ziyao@disroot.org>
References: <20250820074245.16613-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reset controller driver for the TH1520 was using the generic
compatible string "thead,th1520-reset". However, the controller
described by this compatible only manages the resets for the Video
Output (VO) subsystem.

Using a generic compatible is confusing as it implies control over all
reset units on the SoC. This could lead to conflicts if support for
other reset controllers on the TH1520 is added in the future like AP.

Let's introduce a new compatible string, "thead,th1520-reset-vo", to
explicitly scope the controller to VO-subsystem. The old one is marked
as deprecated.

Fixes: 30e7573babdc ("dt-bindings: reset: Add T-HEAD TH1520 SoC Reset Controller")
Cc: stable@vger.kernel.org
Reported-by: Icenowy Zheng <uwu@icenowy.me>
Co-developed-by: Michal Wilczynski <m.wilczynski@samsung.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 .../bindings/reset/thead,th1520-reset.yaml      | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
index f2e91d0add7a..3930475dcc04 100644
--- a/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
@@ -15,8 +15,11 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - thead,th1520-reset
+    oneOf:
+      - enum:
+          - thead,th1520-reset-vo
+      - const: thead,th1520-reset
+        deprecated: true
 
   reg:
     maxItems: 1
@@ -33,12 +36,8 @@ additionalProperties: false
 
 examples:
   - |
-    soc {
-      #address-cells = <2>;
-      #size-cells = <2>;
-      rst: reset-controller@ffef528000 {
-        compatible = "thead,th1520-reset";
-        reg = <0xff 0xef528000 0x0 0x1000>;
+    reset-controller@ffef528000 {
+        compatible = "thead,th1520-reset-vo";
+        reg = <0xef528000 0x1000>;
         #reset-cells = <1>;
-      };
     };
-- 
2.50.1


