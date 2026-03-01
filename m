Return-Path: <stable+bounces-221461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC+/OvyVo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:27:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0391CAA61
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1EA53037481
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8E128466C;
	Sun,  1 Mar 2026 01:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAnOB9an"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C194F283C89;
	Sun,  1 Mar 2026 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328322; cv=none; b=dXzzdUFwVTWFDP378ALdkkuODLc+S7DbMRfbZ578oXvqRrlUVEiOEZpDEsTmiGNRftndaYQpWR+3fA1eeNnvo3n3aeMp+8l+Y4j4tw7hZ49l1j8AwcaIM/cHrOcJxsGpDHJ9ejcqG/swxbtVOW25xhqMu2gydLu3YPPLxBcipeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328322; c=relaxed/simple;
	bh=p1l63WeXc4D9MuN7I3Wqx11wL6kIqX8nQK0itJKGcQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bsowhm8jl2FSgK9Z3wBX61gXScI2P2Mn2D/4u5VS0kVeA21DgRepHdPL69yhYKd8Ls88h2uHPbTevr3neUyjCY1jTagrOzTNoSZCKlvWhpR3nCK0SYPNaRb6yOadAw0aW05KSSYvuK1f31DRvv1eZmjVEkVcFZizNOIBTmwX7jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAnOB9an; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2502C19424;
	Sun,  1 Mar 2026 01:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328322;
	bh=p1l63WeXc4D9MuN7I3Wqx11wL6kIqX8nQK0itJKGcQI=;
	h=From:To:Cc:Subject:Date:From;
	b=EAnOB9an4Rt20OfuYaBR6+H2e4RHgXdlWqzo7kVyTBDu8aAyhQUAI8Onb1oOwet2i
	 Wrmgybr0V5C4prR/Qjm70bp3kb9hQe2h540dCt5+9AodzysIDLLMoHL8QwgvyRBqJI
	 PFyvIhSMSFfx3JMcxgB83FW33+UgPDRIjTL2BzAX5k/WNN2G4g5n78UXi7pNxt5mxL
	 TBfM5DmmZTwF4I9TN6qVUZLcbmuW/iTQdYNCG8eu/E/TE0r3RsXTi99q6uchoZ7kJt
	 XkzzWu6gQ0q2HT7sbCcPdB+a2CnsJn1FFX6o2UySThcsHEQcz/VMeiTV4txiYzz+lz
	 hTs5sVSiI7YFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	peng.fan@nxp.com
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-remoteproc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: FAILED: Patch "remoteproc: imx_rproc: Fix invalid loaded resource table detection" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:25:20 -0500
Message-ID: <20260301012520.1682420-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221461-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 8A0391CAA61
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 26aa5295010ffaebcf8f1991c53fa7cf2ee1b20d Mon Sep 17 00:00:00 2001
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 29 Jan 2026 09:44:48 +0800
Subject: [PATCH] remoteproc: imx_rproc: Fix invalid loaded resource table
 detection

imx_rproc_elf_find_loaded_rsc_table() may incorrectly report a loaded
resource table even when the current firmware does not provide one.

When the device tree contains a "rsc-table" entry, priv->rsc_table is
non-NULL and denotes where a resource table would be located if one is
present in memory. However, when the current firmware has no resource
table, rproc->table_ptr is NULL. The function still returns
priv->rsc_table, and the remoteproc core interprets this as a valid loaded
resource table.

Fix this by returning NULL from imx_rproc_elf_find_loaded_rsc_table() when
there is no resource table for the current firmware (i.e. when
rproc->table_ptr is NULL). This aligns the function's semantics with the
remoteproc core: a loaded resource table is only reported when a valid
table_ptr exists.

With this change, starting firmware without a resource table no longer
triggers a crash.

Fixes: e954a1bd1610 ("remoteproc: imx_rproc: Use imx specific hook for find_loaded_rsc_table")
Cc: stable@vger.kernel.org
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/20260129-imx-rproc-fix-v3-1-fc4e41e6e750@nxp.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/imx_rproc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 375de79168a1c..f5f916d679051 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -729,6 +729,10 @@ imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *
 {
 	struct imx_rproc *priv = rproc->priv;
 
+	/* No resource table in the firmware */
+	if (!rproc->table_ptr)
+		return NULL;
+
 	if (priv->rsc_table)
 		return (struct resource_table *)priv->rsc_table;
 
-- 
2.51.0





