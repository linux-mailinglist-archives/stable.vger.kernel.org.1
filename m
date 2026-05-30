Return-Path: <stable+bounces-257605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNJNBJgdG2qV/QgAu9opvQ
	(envelope-from <stable+bounces-257605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:25:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DC360F9CD
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DD683023316
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E710C30E847;
	Sat, 30 May 2026 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rgVtB4hW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F091C5799;
	Sat, 30 May 2026 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161559; cv=none; b=AdN11qEJVQTK/4hldToe0qOn9HPTHfuQGkz6ST5SIaQ1Hk3/0oTX4GR3mH+Mi5C69VVByIbEOgsHfphj+VayDZTsuMLny/e3RoYR02UUOtl3wLQQxDXTLKnkhWQwibIP33cU7Z3X8+XOCF+l5xjaLKgryLR53TVCaWzHugDfLx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161559; c=relaxed/simple;
	bh=qUxAR7gr3uwpS1Wskn8cMANmCgJyq4HZzhpl3NS5/N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTz7w1vPl3/hIvtO+G5KlBpDHIHDG9INWTjGlzAWZ5OlY3nwETJtkc7bb7dBN/o7AeqNrk4w7JWk3mevs08SQvLfLahdHzDNoUdCkNVQMYe55CZRDK8CHELgL7YvuV3xXOYOaz9pqrvJU1hjwhAZVzBSgjF1hVwedVjyDemc0nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rgVtB4hW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DE21F00893;
	Sat, 30 May 2026 17:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161558;
	bh=W402Wa8oX2OJftE3tAozYCNLbGicqRPrhqUG9Ju1eCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rgVtB4hW6Uc8H3Ixt+R8qXEf1nPLlScP4d7/fBNDD5cWf27bCKYI0m8sVjJVy53M/
	 trLgP+tEJ/LX12LqUiF9PrSmeikJx10eStOOsy3G8eyfmBuGBzxuII2xbm/fSX8B3p
	 jKUeEfqZW3YJvaWpg7ZpMvi3GtqGnVYS/p2HxYhA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 659/969] clk: imx: imx6q: Fix device node reference leak in of_assigned_ldb_sels()
Date: Sat, 30 May 2026 18:03:03 +0200
Message-ID: <20260530160318.674315631@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nxp.com,oss.qualcomm.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257605-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 78DC360F9CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 9faf207208951460f3f7eefbc112246c8d28ff1b ]

The function of_assigned_ldb_sels() calls of_parse_phandle_with_args()
but never calls of_node_put() to release the reference, causing a memory
leak.

Fix this by adding proper cleanup calls on all exit paths.

Fixes: 5d283b083800 ("clk: imx6: Fix procedure to switch the parent of LDB_DI_CLK")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Link: https://patch.msgid.link/20260203-clk-imx6q-v3-2-6cd2696bb371@gmail.com
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx6q.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index b14c1606466d7..a95f07718b653 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -183,9 +183,11 @@ static void of_assigned_ldb_sels(struct device_node *node,
 		}
 		if (clkspec.np != node || clkspec.args[0] >= IMX6QDL_CLK_END) {
 			pr_err("ccm: parent clock %d not in ccm\n", index);
+			of_node_put(clkspec.np);
 			return;
 		}
 		parent = clkspec.args[0];
+		of_node_put(clkspec.np);
 
 		rc = of_parse_phandle_with_args(node, "assigned-clocks",
 				"#clock-cells", index, &clkspec);
@@ -193,9 +195,11 @@ static void of_assigned_ldb_sels(struct device_node *node,
 			return;
 		if (clkspec.np != node || clkspec.args[0] >= IMX6QDL_CLK_END) {
 			pr_err("ccm: child clock %d not in ccm\n", index);
+			of_node_put(clkspec.np);
 			return;
 		}
 		child = clkspec.args[0];
+		of_node_put(clkspec.np);
 
 		if (child != IMX6QDL_CLK_LDB_DI0_SEL &&
 		    child != IMX6QDL_CLK_LDB_DI1_SEL)
-- 
2.53.0




