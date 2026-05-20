Return-Path: <stable+bounces-250805-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG6WK5n4DWqR5AUAu9opvQ
	(envelope-from <stable+bounces-250805-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:08:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 142295955EE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7907E33EEDB6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DCF3D75D3;
	Wed, 20 May 2026 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="InHwljWz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06602373BEB;
	Wed, 20 May 2026 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296354; cv=none; b=lVM0idlK7vHBA/aPzlgv/1UEJs28A1ciauFBeqnhow/WcMUnoIKPmHix1uwnoDEZVLwEM0Ga6cdxSwnqXVjwIRdLs2oCfFt6+AOVP9IflEEsWZfMYCJ4r+k2DFehb6JCGUZ9IFLNE7H69GRJVYGZRpzNetavSa6qYSDXUP2e+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296354; c=relaxed/simple;
	bh=df0PUKAQTNyNdK3fXBi7or5x0noBLB2Hz34nlUq0zyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5n0UKLGBZRbQq0+k5ehfpFuu9PFdYLYz8cicpSkA9pQtHW94WoggskhkspMWAQJvFk+JkpW89AwoFgF60jaTo0LogQLDYH4a+RlzQS+wBZXFp5tMIKyGyJW8CVcXZMMH9pPBSjdSVffXxNkYep1n7DnUQVRLCiHPtzJcdZ1dc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=InHwljWz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB931F000E9;
	Wed, 20 May 2026 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296352;
	bh=8sB5WLlv9r6p70AIRrUr6Y76pK0FI4eeQRAmqsIOibk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=InHwljWz+DxbujocYH+o4b68R+cCu/3cfCM4rzRlt+wLq4nvlHKJ5GGps1if2JehT
	 lDIpARjuvMkD9heoI9ZXRBXKJ+LrmU9DcpgzfRJ3YulmeJ714JKX7UwMFfb007Oeod
	 XvK8H+12bwg+d9s4qzXaYVXEKM18xfFDwiXkZVGg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gabor Juhos <j4g8y7@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0766/1146] arm64: dts: marvell: armada-37xx: use usb2-phy in USB3 controllers phy-names
Date: Wed, 20 May 2026 18:16:56 +0200
Message-ID: <20260520162205.548727242@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250805-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,bootlin.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email,0.0.226.144:email]
X-Rspamd-Queue-Id: 142295955EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabor Juhos <j4g8y7@gmail.com>

[ Upstream commit 0fef19844624f8bc07651b4d26088d8940affba3 ]

Instead of the generic 'usb2-phy' name, the Armada 37xx device trees
are using a custom 'usb2-utmi-otg-phy' name for the USB2 PHY in the USB3
controller node. Since commit 53a2d95df836 ("usb: core: add phy notify
connect and disconnect"), this triggers a bug [1] in the USB core which
causes double use of the USB3 PHY.

Change the PHY name to 'usb2-phy' in the SoC and in the uDPU specific
dtsi files in order to avoid triggering the bug and also to keep the
names in line with the ones used by other platforms.

Link: https://lore.kernel.org/r/20260330-usb-avoid-usb3-phy-double-use-v1-1-d2113aecb535@gmail.com # [1]
Fixes: 53a2d95df836 ("usb: core: add phy notify connect and disconnect")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi | 2 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
index cd856c0aba71e..12deacb741ccb 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
@@ -161,7 +161,7 @@ &eth1 {
 &usb3 {
 	status = "okay";
 	phys = <&usb2_utmi_otg_phy>;
-	phy-names = "usb2-utmi-otg-phy";
+	phy-names = "usb2-phy";
 };
 
 &uart0 {
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 87f9367aec122..cbc411bfa3810 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -373,7 +373,7 @@ usb3: usb@58000 {
 				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&sb_periph_clk 12>;
 				phys = <&comphy0 0>, <&usb2_utmi_otg_phy>;
-				phy-names = "usb3-phy", "usb2-utmi-otg-phy";
+				phy-names = "usb3-phy", "usb2-phy";
 				status = "disabled";
 			};
 
-- 
2.53.0




