Return-Path: <stable+bounces-151762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD561AD0C7C
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 12:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9A0188F910
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 10:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2AE217679;
	Sat,  7 Jun 2025 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZazjoKRf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE901F4CB8;
	Sat,  7 Jun 2025 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749290932; cv=none; b=V4bITDGO1mo/AXBNAFEecP+dCeoam4q6lZ+Vmy7IBCNIlTIJc3NnqBG6LIiYHxz5sgkoKjFlYsGqxk7ychjJUYeCtEsHGpXwv/JeoFauR6uXuHygPqfYgXL1YzPmTorO8YZf78HZ8pi12r5Uk1x4Pq80imrzdGWNeP0bfD0U+qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749290932; c=relaxed/simple;
	bh=sbItSKibkDTEXKtcUYcyDTlHuyn4WSdz+s/XVXp3sDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcgULlHBNEIU4PoZQyedyxHQT7EcSejWO6fgleyV81UH2dTPrb6IxQImjzVKFJQtIYgtuHNMqQYdwCDyrIHR3hb4kTHS5KJ4pZWelGFXBe3dBGcMM5OHu/NfVkOYlxtTHCPbEwu+ccXOyGgdVVyOekuFVaATSJkq/rFpuECxToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZazjoKRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A22C4CEED;
	Sat,  7 Jun 2025 10:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749290931;
	bh=sbItSKibkDTEXKtcUYcyDTlHuyn4WSdz+s/XVXp3sDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZazjoKRfJlii5l7+8n3eiqaIlZkvegh4T5AgDrFp5TOvb/aAAw/sUze6rpMrvxRlY
	 QNsreaTrZyYoleHKOHhowCofLs9BxbeMG7+evSnAts714EcjkP9r15uJJd/d242H53
	 UAMw7b1+98RLO+ou7QUsINe+KbxwLOLQUYs79BSE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.12 22/24] dt-bindings: usb: cypress,hx3: Add support for all variants
Date: Sat,  7 Jun 2025 12:07:53 +0200
Message-ID: <20250607100718.911865818@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607100717.910797456@linuxfoundation.org>
References: <20250607100717.910797456@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

commit 1ad4b5a7de16806afc1aeaf012337e62af04e001 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/usb/cypress,hx3.yaml |   19 ++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

--- a/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
+++ b/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
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
 



