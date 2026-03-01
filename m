Return-Path: <stable+bounces-221410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFKCJmqVo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:24:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 364351CA796
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9410F302A9F8
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4B127CCF2;
	Sun,  1 Mar 2026 01:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOWJ7Unj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11F613B7AE;
	Sun,  1 Mar 2026 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328190; cv=none; b=TC0TL9U0qw30dJ4wQDYFRr84DrwtqqNtlbcOs7F9hPtnPX4Z9y/9LV6Zom4bF8j9HPbPhP1M0aCiTdCxdjzvwc5i90EAnXTxlfXiI0YWcNLMtXaK21tW+lJXay8mQ9/j/q/nh3IW/QsjblzTKAvl4ttRMe9sc0mD2vOWli6Kgns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328190; c=relaxed/simple;
	bh=m90CLQXYe0lP2Ieo4mdXrBevUl+U4rgL6lH3gYQu9aI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BDbLKMho6/G4aw4lrEIHf1ALJVFo249FfZUNDdJkTxTxSKdrw29FagfFplV7k8GJPD4KAQubzHllpSa06iurRnBnlVHADbdNZ2rSjOw563ZzhcAMgOKwYU25PQ7MgnC9JEcfD/G8RkUn0+l2jVUbPj4A5+ZsTpfqsh+tq3nInrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOWJ7Unj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A39C19424;
	Sun,  1 Mar 2026 01:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328189;
	bh=m90CLQXYe0lP2Ieo4mdXrBevUl+U4rgL6lH3gYQu9aI=;
	h=From:To:Cc:Subject:Date:From;
	b=hOWJ7Unjnu9JK9AAjzmZpraRoDSIg6T4dF89ntK/M25ScyPRPPJyK73nxW86AIBbR
	 1MIWB6RF1h+F7rXnXDGdlxQS44tBSzxDc6gRw9YEm7WQZW9spKEjlJExW9svSoxImE
	 sx3vyjUHED41BCL68cMcdXfNLiVqhkiK7ezF6Mi7cftXtB8j6E79Ogvk/gJYO972aK
	 yQhNB+egWgpJOVhr+5GCLmtwXkKvrPdJbcgSld9cs4pZFNZEQ1mgC42VjwuevNt4VC
	 9I3EDrbcpPbT2cqLIKOcl6+TKCbPve5A7gMbt2kpbwRfoTqpPoihWrAHnHv+vCFb/P
	 m2Gbe76DdHd2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	shawn.lin@rock-chips.com
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: FAILED: Patch "arm64: dts: rockchip: Fix rk3588 PCIe range mappings" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:23:07 -0500
Message-ID: <20260301012308.1679779-1-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221410-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sntech.de:email,fe160000:email]
X-Rspamd-Queue-Id: 364351CA796
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 46c56b737161060dfa468f25ae699749047902a2 Mon Sep 17 00:00:00 2001
From: Shawn Lin <shawn.lin@rock-chips.com>
Date: Mon, 5 Jan 2026 16:15:29 +0800
Subject: [PATCH] arm64: dts: rockchip: Fix rk3588 PCIe range mappings

The pcie bus address should be mapped 1:1 to the cpu side MMIO address, so
that there is no same address allocated from normal system memory. Otherwise
it's broken if the same address assigned to the EP for DMA purpose.Fix it to
sync with the vendor BSP.

Fixes: 0acf4fa7f187 ("arm64: dts: rockchip: add PCIe3 support for rk3588")
Fixes: 8d81b77f4c49 ("arm64: dts: rockchip: add rk3588 PCIe2 support")
Cc: stable@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Link: https://patch.msgid.link/1767600929-195341-2-git-send-email-shawn.lin@rock-chips.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi  | 4 ++--
 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index aa74e8d7b4e95..f79e54c14ff0a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -2019,7 +2019,7 @@ pcie2x1l1: pcie@fe180000 {
 		power-domains = <&power RK3588_PD_PCIE>;
 		ranges = <0x01000000 0x0 0xf3100000 0x0 0xf3100000 0x0 0x00100000>,
 			 <0x02000000 0x0 0xf3200000 0x0 0xf3200000 0x0 0x00e00000>,
-			 <0x03000000 0x0 0x40000000 0x9 0xc0000000 0x0 0x40000000>;
+			 <0x03000000 0x9 0xc0000000 0x9 0xc0000000 0x0 0x40000000>;
 		reg = <0xa 0x40c00000 0x0 0x00400000>,
 		      <0x0 0xfe180000 0x0 0x00010000>,
 		      <0x0 0xf3000000 0x0 0x00100000>;
@@ -2071,7 +2071,7 @@ pcie2x1l2: pcie@fe190000 {
 		power-domains = <&power RK3588_PD_PCIE>;
 		ranges = <0x01000000 0x0 0xf4100000 0x0 0xf4100000 0x0 0x00100000>,
 			 <0x02000000 0x0 0xf4200000 0x0 0xf4200000 0x0 0x00e00000>,
-			 <0x03000000 0x0 0x40000000 0xa 0x00000000 0x0 0x40000000>;
+			 <0x03000000 0xa 0x00000000 0xa 0x00000000 0x0 0x40000000>;
 		reg = <0xa 0x41000000 0x0 0x00400000>,
 		      <0x0 0xfe190000 0x0 0x00010000>,
 		      <0x0 0xf4000000 0x0 0x00100000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
index 6e5a58428bbab..a2640014ee042 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
@@ -375,7 +375,7 @@ pcie3x4: pcie@fe150000 {
 		power-domains = <&power RK3588_PD_PCIE>;
 		ranges = <0x01000000 0x0 0xf0100000 0x0 0xf0100000 0x0 0x00100000>,
 			 <0x02000000 0x0 0xf0200000 0x0 0xf0200000 0x0 0x00e00000>,
-			 <0x03000000 0x0 0x40000000 0x9 0x00000000 0x0 0x40000000>;
+			 <0x03000000 0x9 0x00000000 0x9 0x00000000 0x0 0x40000000>;
 		reg = <0xa 0x40000000 0x0 0x00400000>,
 		      <0x0 0xfe150000 0x0 0x00010000>,
 		      <0x0 0xf0000000 0x0 0x00100000>;
@@ -462,7 +462,7 @@ pcie3x2: pcie@fe160000 {
 		power-domains = <&power RK3588_PD_PCIE>;
 		ranges = <0x01000000 0x0 0xf1100000 0x0 0xf1100000 0x0 0x00100000>,
 			 <0x02000000 0x0 0xf1200000 0x0 0xf1200000 0x0 0x00e00000>,
-			 <0x03000000 0x0 0x40000000 0x9 0x40000000 0x0 0x40000000>;
+			 <0x03000000 0x9 0x40000000 0x9 0x40000000 0x0 0x40000000>;
 		reg = <0xa 0x40400000 0x0 0x00400000>,
 		      <0x0 0xfe160000 0x0 0x00010000>,
 		      <0x0 0xf1000000 0x0 0x00100000>;
@@ -512,7 +512,7 @@ pcie2x1l0: pcie@fe170000 {
 		power-domains = <&power RK3588_PD_PCIE>;
 		ranges = <0x01000000 0x0 0xf2100000 0x0 0xf2100000 0x0 0x00100000>,
 			 <0x02000000 0x0 0xf2200000 0x0 0xf2200000 0x0 0x00e00000>,
-			 <0x03000000 0x0 0x40000000 0x9 0x80000000 0x0 0x40000000>;
+			 <0x03000000 0x9 0x80000000 0x9 0x80000000 0x0 0x40000000>;
 		reg = <0xa 0x40800000 0x0 0x00400000>,
 		      <0x0 0xfe170000 0x0 0x00010000>,
 		      <0x0 0xf2000000 0x0 0x00100000>;
-- 
2.51.0





