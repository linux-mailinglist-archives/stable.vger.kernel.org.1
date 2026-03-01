Return-Path: <stable+bounces-221316-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JpIO3mVo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221316-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:25:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E311CA7EB
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4C7430C3981
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA022641CA;
	Sun,  1 Mar 2026 01:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1pdJsTR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101F718E02A;
	Sun,  1 Mar 2026 01:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327965; cv=none; b=echyNi1C+car+8vTdXWGD59UbqIACTFVmg5Bm+Y2cL03Rpyf8zLgkwhCC5dD7RzqY8FccqR2DmO4pujRpl1XBuh1eTdDEVkrClXrY1rPJFQYcM8xQgOrSTP8sImLv0fNJkIjWdhKnh4yX6FWB6oi1tC6qDbIDv6+Lh/FUSy3cQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327965; c=relaxed/simple;
	bh=S/Aak4m6ZxYDgDAG2cPMbe3IX7TZmOu0+52KR8O0TdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QSplqUpL27VG6EWFPjviHnQEspwK3b57S08Kfdp93fxb7L45jNNgIs2E0TUZnc389x+39b68Ufvz+Df2lNZHcqT7gALPgDl02jU+HwwP9TKNFTqGv+aR3PUbCGjhCVpHRKFTf1W+zebit0G+qYukIC4sTxp6uiCE8xOXpuPDQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1pdJsTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E9AC19421;
	Sun,  1 Mar 2026 01:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327964;
	bh=S/Aak4m6ZxYDgDAG2cPMbe3IX7TZmOu0+52KR8O0TdE=;
	h=From:To:Cc:Subject:Date:From;
	b=d1pdJsTRBuDL4Zr6ImQ5CD+YYt0RE8scNhdN+Atb+dwfP2zsjBLI5ipcWxLLAL0AT
	 MTC+dF+60vsmxLp0ucPeH9PxcgSWcToFx2g9kjQhiMJ7P52kN1ckuCuv758YvnbKaX
	 KHrcwQkkFm7ua8DKTBDE5hBg5Z3tMONUPBAj92dbOtkG++MKapyPXdCqi0mCel6YiG
	 eB+TZBwkLO59DxDsotH+vKSffGv2aEujIlh4eTPVJRMVwZKMWdCtYHsqolblxJ9OwL
	 uw3IeP8kWUb1Fcbq5Qu/NJKL1E4bkGyiK19X02GapdEdrO7q3ovNVnmlSaXxhoVNez
	 t56U6RSd4pc+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	vulab@iscas.ac.cn
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org
Subject: FAILED: Patch "ARM: omap2: Fix reference count leaks in omap_control_init()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:19:22 -0500
Message-ID: <20260301011923.1674404-1-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221316-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,baylibre.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50E311CA7EB
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 93a04ab480c8bbcb7d9004be139c538c8a0c1bc8 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 17 Dec 2025 14:21:22 +0000
Subject: [PATCH] ARM: omap2: Fix reference count leaks in omap_control_init()

The of_get_child_by_name() function increments the reference count
of child nodes, causing multiple reference leaks in omap_control_init():

1. scm_conf node never released in normal/error paths
2. clocks node leak when checking existence
3. Missing scm_conf release before np in error paths

Fix these leaks by adding proper of_node_put() calls and separate error
handling.

Fixes: e5b635742e98 ("ARM: OMAP2+: control: add syscon support for register accesses")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Link: https://patch.msgid.link/20251217142122.1861292-1-vulab@iscas.ac.cn
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/mach-omap2/control.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 79860b23030de..eb6fc7c61b6e0 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -732,7 +732,7 @@ int __init omap2_control_base_init(void)
  */
 int __init omap_control_init(void)
 {
-	struct device_node *np, *scm_conf;
+	struct device_node *np, *scm_conf, *clocks_node;
 	const struct of_device_id *match;
 	const struct omap_prcm_init_data *data;
 	int ret;
@@ -753,16 +753,19 @@ int __init omap_control_init(void)
 
 			if (IS_ERR(syscon)) {
 				ret = PTR_ERR(syscon);
-				goto of_node_put;
+				goto err_put_scm_conf;
 			}
 
-			if (of_get_child_by_name(scm_conf, "clocks")) {
+			clocks_node = of_get_child_by_name(scm_conf, "clocks");
+			if (clocks_node) {
+				of_node_put(clocks_node);
 				ret = omap2_clk_provider_init(scm_conf,
 							      data->index,
 							      syscon, NULL);
 				if (ret)
-					goto of_node_put;
+					goto err_put_scm_conf;
 			}
+			of_node_put(scm_conf);
 		} else {
 			/* No scm_conf found, direct access */
 			ret = omap2_clk_provider_init(np, data->index, NULL,
@@ -780,6 +783,9 @@ int __init omap_control_init(void)
 
 	return 0;
 
+err_put_scm_conf:
+	if (scm_conf)
+		of_node_put(scm_conf);
 of_node_put:
 	of_node_put(np);
 	return ret;
-- 
2.51.0





