Return-Path: <stable+bounces-218551-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Mk4OYBTnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218551-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:42:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5277D18F8AA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7858B3019503
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB9823D7CF;
	Wed, 25 Feb 2026 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EpOz80+7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139DD18B0A;
	Wed, 25 Feb 2026 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983390; cv=none; b=kHhTjsVOfAuJHmO3VC/Gp/FQiH8EAWdQ+7rwOwPusy5ew6URcK3xpzlKMexJG5dEkwsQLzy8zN9+kjjKJnOHObDjOiFakx3IQlJLEr4b94N93ce3FffDDs4SidFmUMh0SkCUbPUVH78kMolDdg77G+mrJx5HH2EyHVQ0AQUKh44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983390; c=relaxed/simple;
	bh=Nn6o5r1KlvY1Zc5guEDxtJoRdXGf+icA20b2yNAzXpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJ92FGxW0fpn+Ye+qQ18KAJblsFESV0aaSXLZTWRR9/flQuH0lOLsAlRzo5dqkVOmWFiQlV0y2HRHXXoeJtf7j0NEwYgKLmpefnZC01YbJJB5lD/dihvG0K0AabJRJ6Qts/9M28LVVK/Ubr1GS5/XNP7gP89CSUmFmM+IoD43VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EpOz80+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0265C116D0;
	Wed, 25 Feb 2026 01:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983390;
	bh=Nn6o5r1KlvY1Zc5guEDxtJoRdXGf+icA20b2yNAzXpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EpOz80+79Kfwzy5n4ES1jC7Ay8BQddv17ztWjqnakT1ik+w0GcLy5JVnM2e9ThfoA
	 3z+xH+FClGe8YvwuDlDcHEJiJsJpDBm3OXB0uy1Ghr7Z2tKH19zCMSHZU/utcZSgEp
	 nwrqDoHcRcb6J8oDqN8iPj7Zi4esSHmC05lTpmt8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Inochi Amaoto <inochiama@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 512/781] clk: spacemit: Respect Kconfig setting when building modules
Date: Tue, 24 Feb 2026 17:20:21 -0800
Message-ID: <20260225012412.361787684@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218551-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,gentoo.org,kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5277D18F8AA
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Inochi Amaoto <inochiama@gmail.com>

[ Upstream commit 5ec8cbbc54c82c0bdae4dbf0e5aecf9817bde2b9 ]

Currently, the SPACEMIT_CCU entry is only a switch for enabling entry
SPACEMIT_K1_CCU. It does not guide the build for common clock codes
even if it is a tristate entry. This makes this entry useless.

Change the Makefile to add a separate build for common clock logic,
so the SPACEMIT_CCU entry takes effect, also add necessary
MODULE_LICENSE()/MODULE_DESCRIPTION()/EXPORT_SYMBOL() for the module
build.

Fixes: 1b72c59db0ad ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Yixun Lan <dlan@gentoo.org>
Link: https://lore.kernel.org/r/20251219012819.440972-2-inochiama@gmail.com
Signed-off-by: Yixun Lan <dlan@gentoo.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/spacemit/Makefile     | 9 +++++++--
 drivers/clk/spacemit/ccu-k1.c     | 1 +
 drivers/clk/spacemit/ccu_common.c | 6 ++++++
 drivers/clk/spacemit/ccu_ddn.c    | 1 +
 drivers/clk/spacemit/ccu_mix.c    | 9 +++++++++
 drivers/clk/spacemit/ccu_pll.c    | 1 +
 6 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/spacemit/ccu_common.c

diff --git a/drivers/clk/spacemit/Makefile b/drivers/clk/spacemit/Makefile
index 5ec6da61db98e..ad2bf315109b8 100644
--- a/drivers/clk/spacemit/Makefile
+++ b/drivers/clk/spacemit/Makefile
@@ -1,5 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_SPACEMIT_K1_CCU)	= spacemit-ccu-k1.o
-spacemit-ccu-k1-y		= ccu_pll.o ccu_mix.o ccu_ddn.o
+obj-$(CONFIG_SPACEMIT_CCU)	+= spacemit-ccu.o
+spacemit-ccu-y			+= ccu_common.o
+spacemit-ccu-y			+= ccu_pll.o
+spacemit-ccu-y			+= ccu_mix.o
+spacemit-ccu-y			+= ccu_ddn.o
+
+obj-$(CONFIG_SPACEMIT_K1_CCU)	+= spacemit-ccu-k1.o
 spacemit-ccu-k1-y		+= ccu-k1.o
diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index 4761bc1e3b6e6..01d9485b615d3 100644
--- a/drivers/clk/spacemit/ccu-k1.c
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -1204,6 +1204,7 @@ static struct platform_driver k1_ccu_driver = {
 };
 module_platform_driver(k1_ccu_driver);
 
+MODULE_IMPORT_NS("CLK_SPACEMIT");
 MODULE_DESCRIPTION("SpacemiT K1 CCU driver");
 MODULE_AUTHOR("Haylen Chu <heylenay@4d2.org>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/spacemit/ccu_common.c b/drivers/clk/spacemit/ccu_common.c
new file mode 100644
index 0000000000000..4412c4104dabb
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_common.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+
+MODULE_DESCRIPTION("SpacemiT CCU common clock driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/spacemit/ccu_ddn.c b/drivers/clk/spacemit/ccu_ddn.c
index 5b16e273bee5b..b5540e0781ffa 100644
--- a/drivers/clk/spacemit/ccu_ddn.c
+++ b/drivers/clk/spacemit/ccu_ddn.c
@@ -84,3 +84,4 @@ const struct clk_ops spacemit_ccu_ddn_ops = {
 	.determine_rate = ccu_ddn_determine_rate,
 	.set_rate	= ccu_ddn_set_rate,
 };
+EXPORT_SYMBOL_NS_GPL(spacemit_ccu_ddn_ops, "CLK_SPACEMIT");
diff --git a/drivers/clk/spacemit/ccu_mix.c b/drivers/clk/spacemit/ccu_mix.c
index 7b79908753723..67f8b12b4f5b7 100644
--- a/drivers/clk/spacemit/ccu_mix.c
+++ b/drivers/clk/spacemit/ccu_mix.c
@@ -198,24 +198,28 @@ const struct clk_ops spacemit_ccu_gate_ops = {
 	.enable		= ccu_gate_enable,
 	.is_enabled	= ccu_gate_is_enabled,
 };
+EXPORT_SYMBOL_NS_GPL(spacemit_ccu_gate_ops, "CLK_SPACEMIT");
 
 const struct clk_ops spacemit_ccu_factor_ops = {
 	.determine_rate = ccu_factor_determine_rate,
 	.recalc_rate	= ccu_factor_recalc_rate,
 	.set_rate	= ccu_factor_set_rate,
 };
+EXPORT_SYMBOL_NS_GPL(spacemit_ccu_factor_ops, "CLK_SPACEMIT");
 
 const struct clk_ops spacemit_ccu_mux_ops = {
 	.determine_rate = ccu_mix_determine_rate,
 	.get_parent	= ccu_mux_get_parent,
 	.set_parent	= ccu_mux_set_parent,
 };
+EXPORT_SYMBOL_NS_GPL(spacemit_ccu_mux_ops, "CLK_SPACEMIT");
 
 const struct clk_ops spacemit_ccu_div_ops = {
 	.determine_rate = ccu_mix_determine_rate,
 	.recalc_rate	= ccu_div_recalc_rate,
 	.set_rate	= ccu_mix_set_rate,
 };
+EXPORT_SYMBOL_NS_GPL(spacemit_ccu_div_ops, "CLK_SPACEMIT");
 
 const struct clk_ops spacemit_ccu_factor_gate_ops = {
 	.disable	= ccu_gate_disable,
@@ -226,6 +230,7 @@ const struct clk_ops spacemit_ccu_factor_gate_ops = {
 	.recalc_rate	= ccu_factor_recalc_rate,
 	.set_rate	= ccu_factor_set_rate,
 };
+EXPORT_SYMBOL_NS_GPL(spacemit_ccu_factor_gate_ops, "CLK_SPACEMIT");
 
 const struct clk_ops spacemit_ccu_mux_gate_ops = {
 	.disable	= ccu_gate_disable,
@@ -236,6 +241,7 @@ const struct clk_ops spacemit_ccu_mux_gate_ops = {
 	.get_parent	= ccu_mux_get_parent,
 	.set_parent	= ccu_mux_set_parent,
 };
+EXPORT_SYMBOL_NS_GPL(spacemit_ccu_mux_gate_ops, "CLK_SPACEMIT");
 
 const struct clk_ops spacemit_ccu_div_gate_ops = {
 	.disable	= ccu_gate_disable,
@@ -246,6 +252,7 @@ const struct clk_ops spacemit_ccu_div_gate_ops = {
 	.recalc_rate	= ccu_div_recalc_rate,
 	.set_rate	= ccu_mix_set_rate,
 };
+EXPORT_SYMBOL_NS_GPL(spacemit_ccu_div_gate_ops, "CLK_SPACEMIT");
 
 const struct clk_ops spacemit_ccu_mux_div_gate_ops = {
 	.disable	= ccu_gate_disable,
@@ -259,6 +266,7 @@ const struct clk_ops spacemit_ccu_mux_div_gate_ops = {
 	.recalc_rate	= ccu_div_recalc_rate,
 	.set_rate	= ccu_mix_set_rate,
 };
+EXPORT_SYMBOL_NS_GPL(spacemit_ccu_mux_div_gate_ops, "CLK_SPACEMIT");
 
 const struct clk_ops spacemit_ccu_mux_div_ops = {
 	.get_parent	= ccu_mux_get_parent,
@@ -268,3 +276,4 @@ const struct clk_ops spacemit_ccu_mux_div_ops = {
 	.recalc_rate	= ccu_div_recalc_rate,
 	.set_rate	= ccu_mix_set_rate,
 };
+EXPORT_SYMBOL_NS_GPL(spacemit_ccu_mux_div_ops, "CLK_SPACEMIT");
diff --git a/drivers/clk/spacemit/ccu_pll.c b/drivers/clk/spacemit/ccu_pll.c
index d92f0dae65a49..76d0244873d87 100644
--- a/drivers/clk/spacemit/ccu_pll.c
+++ b/drivers/clk/spacemit/ccu_pll.c
@@ -157,3 +157,4 @@ const struct clk_ops spacemit_ccu_pll_ops = {
 	.determine_rate = ccu_pll_determine_rate,
 	.is_enabled	= ccu_pll_is_enabled,
 };
+EXPORT_SYMBOL_NS_GPL(spacemit_ccu_pll_ops, "CLK_SPACEMIT");
-- 
2.51.0




