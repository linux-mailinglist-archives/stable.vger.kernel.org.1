Return-Path: <stable+bounces-222215-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG2zM0ato2kmJwUAu9opvQ
	(envelope-from <stable+bounces-222215-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:06:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0115C1CE381
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2FB732C58B5
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F2E2F999F;
	Sun,  1 Mar 2026 01:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nz6Guyov"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9762D9EFF;
	Sun,  1 Mar 2026 01:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330325; cv=none; b=OiAyW7M4xsjviiymRzg4Msx8gCDtHELrGfb7Q9dSiNRqc5p2mUF0Dc4YZeYN2qXdgqElggb6NQUWpzXlk0O7zkv9kqRu0PqlTvnVDxfWIENmAtB0D0H/J2ev69+2aUg+y+9IGa1nczZ3t8dUQTiJuKW7nNkYQS5pF5eHU1jx7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330325; c=relaxed/simple;
	bh=jjQsGJzZIdXuKSGmbymMAftWK8PbGeFSQuhz1M3uBJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZU5WZLEngj7Y07IXR/fU1kwTXdyUfSznpTOYyiHErajefwFOo3TD88hgBtzvHIdIH8+bc9gkMbnAt961o70gBTQWRGwLj+WVe8b62eSjrzr0u5311X5A3c6TWfSky9zfzn6x0MnxrRRz6yaqPL15M64gsUQiMM0oyD5FP0DwbEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nz6Guyov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9F5C19424;
	Sun,  1 Mar 2026 01:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330325;
	bh=jjQsGJzZIdXuKSGmbymMAftWK8PbGeFSQuhz1M3uBJg=;
	h=From:To:Cc:Subject:Date:From;
	b=nz6GuyovywMtMLvcxCz4Asnk4ILP5lJHZLY1ALgmYJ04JdwYj0AfaEQU6KIC4u+P9
	 7+hofqvzBHGluckqNYR59lLLeSN3THTnMOA9vG5afkwLMyQ60ze7jHg3av3sxvDvor
	 pf2NptIq8wEVRscWvy7KZ4Ibm0BNYoc+DBh0+W6E/+XZoaSJP9+vvxzpbVbH0WIS+B
	 KwzMgo9axgxeiJ7taBYdN2QkJOTY5cW5/gwabdlmX5VERPMnfqqGsjw30XvmiPxklO
	 E5R12ifHAbr8Tg0T42igBgClwJM20EqwQTk+/Cg6yL+ohXxAZXz3ZhQOaxFYFued/v
	 ogwCoJHMde+YA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	den@valinux.co.jp
Cc: Frank Li <Frank.Li@nxp.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jon Mason <jdmason@kudzu.us>,
	ntb@lists.linux.dev
Subject: FAILED: Patch "NTB: ntb_transport: Fix too small buffer for debugfs_name" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:58:43 -0500
Message-ID: <20260301015843.1724298-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-222215-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,intel.com:email,valinux.co.jp:email,kudzu.us:email]
X-Rspamd-Queue-Id: 0115C1CE381
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6a4b50585d74fe45d3ade1e3e86ba8aae79761a5 Mon Sep 17 00:00:00 2001
From: Koichiro Den <den@valinux.co.jp>
Date: Wed, 7 Jan 2026 13:24:57 +0900
Subject: [PATCH] NTB: ntb_transport: Fix too small buffer for debugfs_name

The buffer used for "qp%d" was only 4 bytes, which truncates names like
"qp10" to "qp1" and causes multiple queues to share the same directory.

Enlarge the buffer and use sizeof() to avoid truncation.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Cc: <stable@vger.kernel.org> # v3.9+
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 drivers/ntb/ntb_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index a7dd983adf7b0..50f3b1f1b9262 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1252,9 +1252,9 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->tx_max_entry = tx_size / qp->tx_max_frame;
 
 	if (nt->debugfs_node_dir) {
-		char debugfs_name[4];
+		char debugfs_name[8];
 
-		snprintf(debugfs_name, 4, "qp%d", qp_num);
+		snprintf(debugfs_name, sizeof(debugfs_name), "qp%d", qp_num);
 		qp->debugfs_dir = debugfs_create_dir(debugfs_name,
 						     nt->debugfs_node_dir);
 
-- 
2.51.0





