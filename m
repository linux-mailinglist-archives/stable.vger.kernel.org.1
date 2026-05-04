Return-Path: <stable+bounces-243074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIvOLlym+GnQxQIAu9opvQ
	(envelope-from <stable+bounces-243074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:59:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CD74BE488
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D64830158BE
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045AF3DB642;
	Mon,  4 May 2026 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Wya5Z25"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE4E2E2F0E;
	Mon,  4 May 2026 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902950; cv=none; b=HKy9LndQcy+xJgFqSlvwb5EGBHck+iRuji5c8zHDgDD7CDlJopu63xSnG1TxpuZH3OWoOgca/QRa3V2bywhvi/SiURgOg6bNftCDAsWVpVYYWUSS4HpqnVzBxWLtwwFuOiV2oH4YkZJ8v58fr81gYB8WVNkcmNpXX2wDESCioXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902950; c=relaxed/simple;
	bh=qUfDBc0z6ToklAGyZCIbvb3s15HPrwWmQFJiF2Q06Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbuWvDGRDom4PR+cyVM+Gbl7hviIqUx+sEkfywr+90jZOUOb4uPBWLrYleN+Np+46Czu9qQ36KFDBPThiXjD6Tu9YvhZ6/5suDLvsFCRe6hnv3G4dHYwGyLEXl22mly3a4bGMi0P6bm3h26mE0KV2cIGTA2jjIwJI4lVJQeXzTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Wya5Z25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DCCC2BCB8;
	Mon,  4 May 2026 13:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777902950;
	bh=qUfDBc0z6ToklAGyZCIbvb3s15HPrwWmQFJiF2Q06Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1Wya5Z25U2fKsyNnr2YlCeGuxx7kd70Vpp7LcuuxoAuw/9cCAHvIl8hZBKhezQUN0
	 zJPKoHoXqkZYShsBumgBqJYIzvVITl0DfOxDW9IaWmpd5UwJZVi1zb5tsxY3U0qjvf
	 EWlvhuC+Fh07Z1twCMmc2ideKsO33Enr3iBdWHxs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Swamil Jain <s-jain1@ti.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 7.0 046/307] dt-bindings: display: ti, am65x-dss: Fix AM62L DSS reg and clock constraints
Date: Mon,  4 May 2026 15:48:51 +0200
Message-ID: <20260504135144.566632836@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 38CD74BE488
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243074-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:url,ti.com:email,msgid.link:url,qualcomm.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Swamil Jain <s-jain1@ti.com>

commit 9c469240997584449cfac51a75d1d3d71968c76f upstream.

The AM62L DSS [1] support incorrectly used the same register and
clock constraints as AM65x, but AM62L has a single video port

Fix this by adding conditional constraints that properly define the
register regions and clocks for AM62L DSS (single video port) versus
other AM65x variants (dual video port).

[1]: Section 12.7 (Display Subsystem and Peripherals)
Link : https://www.ti.com/lit/pdf/sprujb4

Fixes: cb8d4323302c ("dt-bindings: display: ti,am65x-dss: Add support for AM62L DSS")
Cc: stable@vger.kernel.org
Signed-off-by: Swamil Jain <s-jain1@ti.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260415110409.2577633-1-s-jain1@ti.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml |   70 +++++++---
 1 file changed, 52 insertions(+), 18 deletions(-)

--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -36,34 +36,50 @@ properties:
   reg:
     description:
       Addresses to each DSS memory region described in the SoC's TRM.
-    items:
-      - description: common DSS register area
-      - description: VIDL1 light video plane
-      - description: VID video plane
-      - description: OVR1 overlay manager for vp1
-      - description: OVR2 overlay manager for vp2
-      - description: VP1 video port 1
-      - description: VP2 video port 2
-      - description: common1 DSS register area
+    oneOf:
+      - items:
+          - description: common DSS register area
+          - description: VIDL1 light video plane
+          - description: VID video plane
+          - description: OVR1 overlay manager for vp1
+          - description: OVR2 overlay manager for vp2
+          - description: VP1 video port 1
+          - description: VP2 video port 2
+          - description: common1 DSS register area
+      - items:
+          - description: common DSS register area
+          - description: VIDL1 light video plane
+          - description: OVR1 overlay manager for vp1
+          - description: VP1 video port 1
+          - description: common1 DSS register area
 
   reg-names:
-    items:
-      - const: common
-      - const: vidl1
-      - const: vid
-      - const: ovr1
-      - const: ovr2
-      - const: vp1
-      - const: vp2
-      - const: common1
+    oneOf:
+      - items:
+          - const: common
+          - const: vidl1
+          - const: vid
+          - const: ovr1
+          - const: ovr2
+          - const: vp1
+          - const: vp2
+          - const: common1
+      - items:
+          - const: common
+          - const: vidl1
+          - const: ovr1
+          - const: vp1
+          - const: common1
 
   clocks:
+    minItems: 2
     items:
       - description: fck DSS functional clock
       - description: vp1 Video Port 1 pixel clock
       - description: vp2 Video Port 2 pixel clock
 
   clock-names:
+    minItems: 2
     items:
       - const: fck
       - const: vp1
@@ -179,6 +195,24 @@ allOf:
         ports:
           properties:
             port@1: false
+        reg:
+          maxItems: 5
+        reg-names:
+          maxItems: 5
+        clocks:
+          maxItems: 2
+        clock-names:
+          maxItems: 2
+    else:
+      properties:
+        reg:
+          minItems: 8
+        reg-names:
+          minItems: 8
+        clocks:
+          minItems: 3
+        clock-names:
+          minItems: 3
 
   - if:
       properties:



