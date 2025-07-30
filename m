Return-Path: <stable+bounces-165506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1433EB15F75
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 13:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CEA07A6A40
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFFA276057;
	Wed, 30 Jul 2025 11:29:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AAF36124
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753874992; cv=none; b=jI2JWUvAeH/dDFa1P495pkPbc8+c5JtN4PlqFwmFNCYRXysmTjUu02O9PPGMCBJ9mfNFdYmk0D36zd/18utktKotYF1l1x1sXZR9aPPdDbsBHOt4UOQQKFUYiOuntqnrc6wpy3HwTqulFX+yF6R91135Gd9sIBEGAP0h4zb+CbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753874992; c=relaxed/simple;
	bh=Uu90uPBP6AfVvNKeUVX3NxA5B61cx5fIfis2vyIaTbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZZoIl5wudG4fR0R+Qq0ZTFdpDD6JiZ1EjHaO1KjFEX9qTwI6lR+4un/D4ooMnebkyDa5k4h/NbrqjSRdD0Y1JuWYC7NbLefv11xUi5Vs/5yec+82ndR5AImsvz2yyCUPnY7zXj1wOH5ATWozGAk5jlKWEFQvzxJmLe9yGX6sp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bsTzd2T1hzX3x;
	Wed, 30 Jul 2025 13:11:09 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bsTzc4QwgzkX;
	Wed, 30 Jul 2025 13:11:08 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 30 Jul 2025 13:10:19 +0200
Subject: [PATCH 3/6] dt-bindings: usb: cypress,hx3: Add support for all
 variants
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-puma-usb-cypress-v1-3-b1c203c733f9@cherry.de>
References: <20250730-puma-usb-cypress-v1-0-b1c203c733f9@cherry.de>
In-Reply-To: <20250730-puma-usb-cypress-v1-0-b1c203c733f9@cherry.de>
To: Klaus Goger <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Benjamin Bara <benjamin.bara@skidata.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, stable@vger.kernel.org, 
 "Rob Herring (Arm)" <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha

From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

The Cypress HX3 hubs use different default PID value depending
on the variant. Update compatibles list.
Becasuse all hub variants use the same driver data, allow the
dt node to have two compatibles: leftmost which matches the HW
exactly, and the second one as fallback.

Fixes: 1eca51f58a10 ("dt-bindings: usb: Add binding for Cypress HX3 USB 3.0 family")
Cc: stable@vger.kernel.org # 6.6
Cc: stable@vger.kernel.org # Backport of the patch ("dt-bindings: usb: usb-device: relax compatible pattern to a contains") from list: https://lore.kernel.org/linux-usb/20250418-dt-binding-usb-device-compatibles-v2-1-b3029f14e800@cherry.de/
Cc: stable@vger.kernel.org # Backport of the patch in this series fixing product ID in onboard_dev_id_table in drivers/usb/misc/onboard_usb_dev.c driver
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Reviewed-by: "Rob Herring (Arm)" <robh@kernel.org>
Link: https://lore.kernel.org/r/20250425-onboard_usb_dev-v2-2-4a76a474a010@thaumatec.com
[taken with Greg's blessing]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 1ad4b5a7de16806afc1aeaf012337e62af04e001 ]

(cherry picked from commit 53aacaed0ad140b017c803d9777473c6c62f5352)
---
 dts/upstream/Bindings/usb/cypress,hx3.yaml | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/dts/upstream/Bindings/usb/cypress,hx3.yaml b/dts/upstream/Bindings/usb/cypress,hx3.yaml
index 1033b7a4b8f953424cc3d31d561992c17f3594b2..d6eac1213228d2acb50ebc959d1ff15134c5a91c 100644
--- a/dts/upstream/Bindings/usb/cypress,hx3.yaml
+++ b/dts/upstream/Bindings/usb/cypress,hx3.yaml
@@ -14,9 +14,22 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - usb4b4,6504
-      - usb4b4,6506
+    oneOf:
+      - enum:
+          - usb4b4,6504
+          - usb4b4,6506
+      - items:
+          - enum:
+              - usb4b4,6500
+              - usb4b4,6508
+          - const: usb4b4,6504
+      - items:
+          - enum:
+              - usb4b4,6502
+              - usb4b4,6503
+              - usb4b4,6507
+              - usb4b4,650a
+          - const: usb4b4,6506
 
   reg: true
 

-- 
2.50.1


