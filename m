Return-Path: <stable+bounces-213047-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONOLJ6d8gGnE8wIAu9opvQ
	(envelope-from <stable+bounces-213047-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 11:29:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F88CCAF45
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 11:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF91B301BA5E
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 10:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072D33570DA;
	Mon,  2 Feb 2026 10:27:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE692BE7BB
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028073; cv=none; b=Bk5Pxfx/mYxS9t8LLDtk9UcJxYCKpSh2dpHw5Ci1ht/QKBow+6uVoV3wO730lL7O7jiH3kyH96zwdrqOGsQrXLPSXUR6CiOlv8uMHvoK8scvpU2D9H4DxGlAyGBrjCN7QwLY4i83bz6ERAkbHcm7fCdlfv7FsqClY++PuS/95WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028073; c=relaxed/simple;
	bh=bleeBFJPuuFsgNHUwUVf9FvzmPn7y26MsMtoKi1PeCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SZA+MMScCGJn0EphVxIlXa5mrkkG8lc+703MC8PPvURAYYt7GKLyXKA4/6wHVLhp3EwdnkzpBlW6ftZzD5XeAUrssu6miaKPDlWTfwMYCKwWmS8svF8iN8ZsNFjYCPtn2C0JC1kRaPTxrx//IXpHYMHKp5vXI54Ra5636oT+eY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f4N993pdZz7Y0;
	Mon,  2 Feb 2026 11:27:41 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f4N986dlPz6vV;
	Mon,  2 Feb 2026 11:27:40 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Mon, 02 Feb 2026 11:27:25 +0100
Subject: [PATCH 1/2] arm64: dts: rockchip: fix Ethernet PHY not found on
 PX30 Cobra
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-px30-eth-phy-v1-1-ef365be64922@cherry.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	TAGGED_FROM(0.00)[bounces-213047-lists,stable=lfdr.de,kernel];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cherry.de:mid,cherry.de:email,0.0.0.0:email]
X-Rspamd-Queue-Id: 5F88CCAF45
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

Cc: stable@vger.kernel.org
Fixes: bb510ddc9d3e ("arm64: dts: rockchip: add px30-cobra base dtsi and board variants")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/px30-cobra.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-cobra.dtsi b/arch/arm64/boot/dts/rockchip/px30-cobra.dtsi
index b7e669d8ba4d1..add917af5de78 100644
--- a/arch/arm64/boot/dts/rockchip/px30-cobra.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-cobra.dtsi
@@ -397,7 +397,7 @@ &io_domains {
 
 &mdio {
 	dp83825: ethernet-phy@0 {
-		compatible = "ethernet-phy-ieee802.3-c22";
+		compatible = "ethernet-phy-id2000.a140";
 		reg = <0x0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&phy_rst>;

-- 
2.52.0


