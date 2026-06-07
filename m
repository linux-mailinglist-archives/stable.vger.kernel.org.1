Return-Path: <stable+bounces-261578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w8HPLB1NJWogGgIAu9opvQ
	(envelope-from <stable+bounces-261578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:51:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4966500D3
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:51:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=bnhpp54q;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261578-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261578-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7536B300C020
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFFC3264F5;
	Sun,  7 Jun 2026 10:44:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EBB2FB97B;
	Sun,  7 Jun 2026 10:44:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829084; cv=none; b=ddHvsMD4IBw/l/ycEwA+ndvKULvh72e95tYcFNr8KSNHE01sD6UAQvIaRppIwUsSqXCCIP97IJQgCVlcYCEH+HkmZ866kq0cJtYcrnH56XK4drNm+s0IxK4SrA8gAHR5Ax92pylS3/H2g5EtwjTOAX97wrYpVsTnUBs6w9HYq60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829084; c=relaxed/simple;
	bh=JlETVc5NfEd59IdwbpCUq2xjEuPhzSaKPGzcPcgBa6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZn49Wqzmb7ua1emEX/BgN2SHqzz1fulKpQwREPhQbXR78cGeHwRnsRm0nK5tLE8g0o031DN1bumC+r69T1QEDHlTt/z1wNd2E2pZ+akw+WIiAzNu6gS9jPWIvVhTO7E37G6ftnIYb2tDEVIRcF7xH/X5i21D1G+nZ/MqkcfE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bnhpp54q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D264C1F00893;
	Sun,  7 Jun 2026 10:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829083;
	bh=qUsirmbA+WgwVVtrWXsBI4CsWiM6aHO8ryuivUdAKbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bnhpp54qDUJOOS+aOMP+YorUPIbeHxctikyHN+7SiCGDlaXVtgg8Hjlm3KlP6aGLm
	 JGgim0XbReV0fyBsPVkOqPc+GQY+ihyaT/4+0U8lV+HDh/ar5UUKgUpf0t69zfjdPu
	 Jo3xxNgc5x+wPKFn3u18JmxW3X8pHKVYqIob8Gaw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Hang Cao <caohang@eswincomputing.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 7.0 244/332] dt-bindings: usb: Fix EIC7700 USB resets issue
Date: Sun,  7 Jun 2026 12:00:13 +0200
Message-ID: <20260607095737.004756508@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261578-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:caohang@eswincomputing.com,m:conor.dooley@microchip.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,eswincomputing.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B4966500D3

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hang Cao <caohang@eswincomputing.com>

commit f1ecb0e563595d4ba9a3b8e39ed52a3dc2d8e328 upstream.

The EIC7700 USB requires a USB PHY reset operation; otherwise, the USB
will not work. The reason why the USB driver that was applied can work
properly is that the USB PHY has already been reset in ESWIN's U-Boot.

However, the proper functioning of the USB driver should not be dependent
on the bootloader. Therefore, it is necessary to incorporate the USB PHY
reset signal into the DT bindings.

This patch does not introduce any backward incompatibility since the dts
is not upstream yet. As array of reset operations are used in the driver,
no modifications to the USB controller driver are needed.

Fixes: c640a4239db5 ("dt-bindings: usb: Add ESWIN EIC7700 USB controller")
Cc: stable <stable@kernel.org>
Signed-off-by: Hang Cao <caohang@eswincomputing.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20260415064238.1784-1-caohang@eswincomputing.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml
@@ -41,12 +41,13 @@ properties:
       - const: usb_en
 
   resets:
-    maxItems: 2
+    maxItems: 3
 
   reset-names:
     items:
       - const: vaux
       - const: usb_rst
+      - const: usb_phy
 
   eswin,hsp-sp-csr:
     description:
@@ -85,8 +86,8 @@ examples:
         interrupt-parent = <&plic>;
         interrupts = <85>;
         interrupt-names = "peripheral";
-        resets = <&reset 84>, <&hspcrg 2>;
-        reset-names = "vaux", "usb_rst";
+        resets = <&reset 84>, <&hspcrg 2>, <&hspcrg 4>;
+        reset-names = "vaux", "usb_rst", "usb_phy";
         dr_mode = "peripheral";
         maximum-speed = "high-speed";
         phy_type = "utmi";



