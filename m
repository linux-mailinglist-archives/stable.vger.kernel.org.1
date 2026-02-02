Return-Path: <stable+bounces-213049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOkwLHB9gGnE8wIAu9opvQ
	(envelope-from <stable+bounces-213049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 11:33:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D21FDCB088
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 11:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B4B3301C0D5
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 10:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B02235A93B;
	Mon,  2 Feb 2026 10:27:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56F53563F1
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028073; cv=none; b=omLY6ForT0l4XX8+b4qyCZo8/OxJBPbUwpTg78eoUb3jQUKuQV07/O4dNsvSEIOnPNd4Y2ZFFPNpkKPd8DtLi4oQ2WaJCs18+UXYqPd8JFL52aUumfzjuR85KjqWudT4LQDIBDRS6f28GY9pahvHIx2AuPn1aebgBfLtBWLOLdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028073; c=relaxed/simple;
	bh=9Yyi4gTMhanz87L+88zAle5xLB7ShfU/IZ/x32HRFuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AowSZU3ISKpVOA4Ld+uNSqbKTRW7a8dVAW1v8FxNQ/xhQM5Zex21q56tYfbWOrf7xKt48g4oFcryDQEHahyHBjJoGkKINTz+fQg7jHPRLpIIwgx2PpGD6iRhbW+R+Kmj6VVbfOLMW4UIxIGTsWPMAxPkR/bq5LuPRAJICUDKbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f4N9B1XMVz9km;
	Mon,  2 Feb 2026 11:27:42 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f4N993hzRz8V;
	Mon,  2 Feb 2026 11:27:41 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Mon, 02 Feb 2026 11:27:26 +0100
Subject: [PATCH 2/2] arm64: dts: rockchip: fix Ethernet PHY not found on
 PX30 Ringneck
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-px30-eth-phy-v1-2-ef365be64922@cherry.de>
References: <20260202-px30-eth-phy-v1-0-ef365be64922@cherry.de>
In-Reply-To: <20260202-px30-eth-phy-v1-0-ef365be64922@cherry.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Heiko Stuebner <heiko.stuebner@cherry.de>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[0leil.net];
	FROM_NEQ_ENVFROM(0.00)[foss@0leil.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-213049-lists,stable=lfdr.de,kernel];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cherry.de:mid,cherry.de:email,0.0.0.0:email]
X-Rspamd-Queue-Id: D21FDCB088
X-Rspamd-Action: no action

From: Quentin Schulz <quentin.schulz@cherry.de>

When not passing the PHY ID with an ethernet-phy-idX.Y compatible
property, the MDIO bus will attempt to auto-detect the PHY by reading
its registers and then probing the appropriate driver. For this to work,
the PHY needs to be in a working state.

Unfortunately, the net subsystem doesn't control the PHY reset GPIO when
attempting to auto-detect the PHY. This means the PHY needs to be in a
working state when entering the Linux kernel. This historically has been
the case for this device, but only because the bootloader was taking
care of initializing the Ethernet controller even when not using it.
We're attempting to support the removal of the network stack in the
bootloader, which means the Linux kernel will be entered with the PHY
still in reset and now Ethernet doesn't work anymore.

The devices in the field only ever had a TI DP83825, so let's simply
bypass the auto-detection mechanism entirely by passing the appropriate
PHY IDs via the compatible.

Note that this is only an issue since commit e463625af7f9 ("arm64: dts:
rockchip: move reset to dedicated eth-phy node on ringneck") as before
that commit the reset was done by the MAC controller before starting the
MDIO auto-detection mechanism, via the snps,reset-* properties.

Cc: stable@vger.kernel.org
Fixes: e463625af7f9 ("arm64: dts: rockchip: move reset to dedicated eth-phy node on ringneck")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
index 4203b335a2633..973b4c5880e24 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -344,7 +344,7 @@ &io_domains {
 
 &mdio {
 	dp83825: ethernet-phy@0 {
-		compatible = "ethernet-phy-ieee802.3-c22";
+		compatible = "ethernet-phy-id2000.a140";
 		reg = <0x0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&phy_rst>;

-- 
2.52.0


