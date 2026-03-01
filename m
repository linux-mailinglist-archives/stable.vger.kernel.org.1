Return-Path: <stable+bounces-221894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGk5EKypo2nfJQUAu9opvQ
	(envelope-from <stable+bounces-221894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:51:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 977D31CDF9F
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93A0D31DB35A
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452D02D5937;
	Sun,  1 Mar 2026 01:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBU1yJH3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E71145A1F;
	Sun,  1 Mar 2026 01:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329394; cv=none; b=iOPef0Iv8F0wg7EkfIQtYTzFuTMp3FJlT1F3PRy+PEUzh/rEq6TV8uPBrEk8BgJdQSiVFupFr1HJlR2F+Qgvczdhh5/opfIHXlqvs6ZzEznNx/GojxETz18rTSeABY0V7L3gvbndYS2gyMOyRRbZWX0Pza+cbX4XCQ0GRe/+6wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329394; c=relaxed/simple;
	bh=MiR9CnyBFm7C/mCgechdtkp7FS7z0nXkTSx/DIQrygE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yxm4pr4VnnQBUXnokRwNU7B2OhpHX/mTNzvGGWQf6NgDmZdNzn/K2gQCCbdJfykx2q/gDOaWGez0DPjemOgQjTI7m/qkFCEk2dvT4moqX2hsWMsLEHhVcUCp5vegAjnfm6PnPiKOAoeDZ0YPFE/NroqsTeQPSlb+rCU6uNmwOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBU1yJH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26824C19421;
	Sun,  1 Mar 2026 01:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329393;
	bh=MiR9CnyBFm7C/mCgechdtkp7FS7z0nXkTSx/DIQrygE=;
	h=From:To:Cc:Subject:Date:From;
	b=vBU1yJH3dzPJ/UVilxsgn5pmoMrKDbX67BKu3E7sh/3noNbgNBuNK/Z5hq9B7tB0K
	 Ohui7IOvmtD6qxM8mtikHQ8NrZNYpfE+TfyWcTncIVkC7jAIoiGW4QLW6YLEXunkOB
	 HvZt3OaWFjjSSi+q9h0YosMFyWZUm4ACc+Y49FqfsMf8dafmx1a8G8vW/TgDSA2AlD
	 BaVi3uZuZ9Wd+hupoTBCff0ieCrTunl1GFjfbskVsix7pUD3NLJrouFgq/Ywa4PUiA
	 VDZdaAjtFwpQIbdrUxaGStXLdps3DbCf5o00op9zvRdSl3xghpSeBP98lz416qHbbw
	 LinMbGIQCkYdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	shawn.lin@rock-chips.com
Cc: Andrew Powers-Holmes <aholmes@omnom.net>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: FAILED: Patch "arm64: dts: rockchip: Fix rk356x PCIe range mappings" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:43:11 -0500
Message-ID: <20260301014312.1705238-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221894-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 977D31CDF9F
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f63ea193a404481f080ca2958f73e9f364682db9 Mon Sep 17 00:00:00 2001
From: Shawn Lin <shawn.lin@rock-chips.com>
Date: Mon, 5 Jan 2026 16:15:28 +0800
Subject: [PATCH] arm64: dts: rockchip: Fix rk356x PCIe range mappings

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





