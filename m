Return-Path: <stable+bounces-221674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAWaMyuYo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:36:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA071CB218
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CE733016B9E
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C892E4263;
	Sun,  1 Mar 2026 01:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se3d2dwo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A6E29B793;
	Sun,  1 Mar 2026 01:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328857; cv=none; b=Ffc1ZC4Lqam5WU10gVHCPTzTPTbLM/kRvxMyeUH1JJEsuhlCvXF/bFOEvorTybyqvJv6/SBPSd6P60orHqtSvZze1yVkTedd0ge/OCGoCS3GlpwVCWnapW334zzp87DmBIUiUlI1AapY83mNFZ38226kcwhI2a+puWPEwVctjx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328857; c=relaxed/simple;
	bh=0+cHeFH6bN3+Ii6nC3yaqGh3RNXA5v2GFSIX2DBpzrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Txqpjl5hy12bSun21CuxbT/tGRWbpudfyk0AEtmbTbDO/ZiEVGCfeCqpVAXoplOJjj47jhNbLfIWyaB4443Si8C1f4uDy5XxUkseFWk5Ny4zXmirvs2ORnLh7KEUdHgrWImGmhSc3IDkl2QQpb0+yen7N+R3Qdpv8+dPo7jgkSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se3d2dwo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098F2C19425;
	Sun,  1 Mar 2026 01:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328857;
	bh=0+cHeFH6bN3+Ii6nC3yaqGh3RNXA5v2GFSIX2DBpzrc=;
	h=From:To:Cc:Subject:Date:From;
	b=Se3d2dwoHH54bmA8OcXdW00cm8CWsGRhuJOP+aNu0XexPq1UcMssVgg/HEt/ko8jZ
	 +IIadqJhIqhk56HQxVUDbTmgEEsCk6G711frQoI47q/Kb3hR9kepkYZ5wqpRn2UH6Z
	 5KrqMfTa81EaL0WD3sPb5FQXNcjeLvcl3kIQNfsoGyR99Uj3DwHbK1qYoYJHrCrdUQ
	 4jq4rzlnWLmI1987gnDtZ4FoIcfqsxL73oipPwqwJMt4oyPRWFmH8dNg4+v6k/gJDw
	 mEGLdUEBE6TEJK6fiKO6kBPu7fwpv2hFGzPTiKy1xjFtGY2mWli9q8p2WFchq8R1CU
	 5FDZt7+lFbhdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	shawn.lin@rock-chips.com
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: FAILED: Patch "arm64: dts: rockchip: Fix rk3588 PCIe range mappings" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:34:15 -0500
Message-ID: <20260301013415.1693700-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221674-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BBA071CB218
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
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





