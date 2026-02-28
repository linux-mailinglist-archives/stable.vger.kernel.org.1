Return-Path: <stable+bounces-220748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKRmHY9Bo2lC+wQAu9opvQ
	(envelope-from <stable+bounces-220748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:27:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 355AF1C700F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 991C131101E6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E723235F5F3;
	Sat, 28 Feb 2026 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIyI+nQc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912B35F5EC;
	Sat, 28 Feb 2026 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300628; cv=none; b=igxHc1S04AnoL2RXvsuNuM//ChppmoeVi/CXD4fWEWZI0ViZgdJ5sZP8h/F6isYffqIanFfsNyFG6eSRCeKjJFH+eclny3VK6sgMCHHY7pbsjRdvmrYpLpzaqPA+Q1zPuVS+HocCJsiVodJk+j+d07PMoOkfAAz7neKnjlKAqs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300628; c=relaxed/simple;
	bh=DxwOjVHa6ljGNxDzcQvadqF7PJ2KfWO294/LSSF1MBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQQJz9SZ02gDd4uRQiPsEs2E5bPyo/Akd4q6CRiVif/Tsnk4xVfgbZRUPBYrkf3tRQa9L1dGQ2MmJesYxAL64O+4rVQYlc7DJpHZHd1vt4fUUg9oA2ITk8PXSM2VnNK/m5dxBhNIEHogPBVrFcLQkeI6MXhcaXOmFT5GwUBKEro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIyI+nQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E225CC19424;
	Sat, 28 Feb 2026 17:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300628;
	bh=DxwOjVHa6ljGNxDzcQvadqF7PJ2KfWO294/LSSF1MBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iIyI+nQcbd3NE0dikim5V0+RTwDeLxP8K/9bCPTNVTJL5KBWuB6kgV5W+EEJvdZJW
	 Y5IfKINafJJMfHWOJss8kPu9O3rbiP3WKAXJe35/ecHGmlMJrwJeWQEV6AgJqBkZ96
	 RRrg7NkWKCbsG7k7QkAOwoLR3vEK04XKuTIfI6VMEIBzeWsHsqGJa8HiBto8R+6qgy
	 WXpj8h5FeDBAOinI2YLTC/s15VTZk6CX0pcdHpDmX14G7SEVN44nh1Y8AOkYl5wpAe
	 +5JfCavdIaDryCudMySQcn3hHkFe9RjZ/KDONnJq95lbEZxNMn2e8Mw5JKFSbeiXLL
	 k0l20Rbn32zFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Andrew Powers-Holmes <aholmes@omnom.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 669/844] arm64: dts: rockchip: Fix rk356x PCIe range mappings
Date: Sat, 28 Feb 2026 12:29:42 -0500
Message-ID: <20260228173244.1509663-670-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220748-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rock-chips.com:email,msgid.link:url,sntech.de:email,fe260000:email,omnom.net:email,fe280000:email]
X-Rspamd-Queue-Id: 355AF1C700F
X-Rspamd-Action: no action

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit f63ea193a404481f080ca2958f73e9f364682db9 ]

The pcie bus address should be mapped 1:1 to the cpu side MMIO address, so
that there is no same address allocated from normal system memory. Otherwise
it's broken if the same address assigned to the EP for DMA purpose.Fix it to
sync with the vendor BSP.

Fixes: 568a67e742df ("arm64: dts: rockchip: Fix rk356x PCIe register and range mappings")
Fixes: 66b51ea7d70f ("arm64: dts: rockchip: Add rk3568 PCIe2x1 controller")
Cc: stable@vger.kernel.org
Cc: Andrew Powers-Holmes <aholmes@omnom.net>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Link: https://patch.msgid.link/1767600929-195341-1-git-send-email-shawn.lin@rock-chips.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      | 4 ++--
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index e719a3df126c5..658097ed69714 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -185,7 +185,7 @@ pcie3x1: pcie@fe270000 {
 		      <0x0 0xf2000000 0x0 0x00100000>;
 		ranges = <0x01000000 0x0 0xf2100000 0x0 0xf2100000 0x0 0x00100000>,
 			 <0x02000000 0x0 0xf2200000 0x0 0xf2200000 0x0 0x01e00000>,
-			 <0x03000000 0x0 0x40000000 0x3 0x40000000 0x0 0x40000000>;
+			 <0x03000000 0x3 0x40000000 0x3 0x40000000 0x0 0x40000000>;
 		reg-names = "dbi", "apb", "config";
 		resets = <&cru SRST_PCIE30X1_POWERUP>;
 		reset-names = "pipe";
@@ -238,7 +238,7 @@ pcie3x2: pcie@fe280000 {
 		      <0x0 0xf0000000 0x0 0x00100000>;
 		ranges = <0x01000000 0x0 0xf0100000 0x0 0xf0100000 0x0 0x00100000>,
 			 <0x02000000 0x0 0xf0200000 0x0 0xf0200000 0x0 0x01e00000>,
-			 <0x03000000 0x0 0x40000000 0x3 0x80000000 0x0 0x40000000>;
+			 <0x03000000 0x3 0x80000000 0x3 0x80000000 0x0 0x40000000>;
 		reg-names = "dbi", "apb", "config";
 		resets = <&cru SRST_PCIE30X2_POWERUP>;
 		reset-names = "pipe";
diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index 8893b7b6cc9ff..a2c4957a58992 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -1022,7 +1022,7 @@ pcie2x1: pcie@fe260000 {
 		power-domains = <&power RK3568_PD_PIPE>;
 		ranges = <0x01000000 0x0 0xf4100000 0x0 0xf4100000 0x0 0x00100000>,
 			 <0x02000000 0x0 0xf4200000 0x0 0xf4200000 0x0 0x01e00000>,
-			 <0x03000000 0x0 0x40000000 0x3 0x00000000 0x0 0x40000000>;
+			 <0x03000000 0x3 0x00000000 0x3 0x00000000 0x0 0x40000000>;
 		resets = <&cru SRST_PCIE20_POWERUP>;
 		reset-names = "pipe";
 		#address-cells = <3>;
-- 
2.51.0


