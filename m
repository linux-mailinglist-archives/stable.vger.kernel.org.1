Return-Path: <stable+bounces-221718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN4+JI2bo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-221718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:51:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB361CC03A
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF55F304FB97
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062ED270552;
	Sun,  1 Mar 2026 01:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM7jSZng"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCE013B58A;
	Sun,  1 Mar 2026 01:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328971; cv=none; b=BtkXOEUms4omAIEZCautjmgp60XFoGhbHplDKG4B0fwcxwV6PY7lB7ei/f1I3W0r+ifUjHtPOP4ZuTwp+au+kEN6cZo8mu/XnZGCxnG0YnE4Mv3+iSGjvDsaTtBzfLKvkcXeCN2SUlCATqHj/cjtTdfzYpQgVYagYNEj4t7Ujk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328971; c=relaxed/simple;
	bh=rs+AdXbvY/4s8ufqTaidjEupHKh2m0diNhzMc5x8NWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLZzIUe2pFIqUEtpQIQbVFNiX0F1jSLFSP073BKyUH7h/dcC5i9DeQyQXycMPrOBfyf4O12PffzESzR7f22khjEQdUbdBEO4bFCenZAIrEY45SBBiQjmXNeJFV6Mdnmrh8B47IJkRCirmOsHRtksLlkfkzYkaOkhtmRwv7fTGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RM7jSZng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E97C19421;
	Sun,  1 Mar 2026 01:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328971;
	bh=rs+AdXbvY/4s8ufqTaidjEupHKh2m0diNhzMc5x8NWk=;
	h=From:To:Cc:Subject:Date:From;
	b=RM7jSZngZHZ3Y3lnct8qta9pGgQZs6PysJ/11TpWWvelzgdyfz43PxuyPTuoITtpo
	 0+nyo7F4qKTkYGi/Y+bUpV4hYt9mAZLG/kSicWLMiSEeumLY9bxhKzacCNoOU3c+pG
	 2l6HdJ831Rfk6OoxPBQiw5oDYIUWRP4DqlmfrvednNxNJ2MMstJZyZc0liI3z8uWhd
	 TSU4CXrC6YWxY3GSVfZi4Z0QEiCW2knM95blovFmExzSNpSxgd6El4VsoyuY+lM3GS
	 bjSfwoFlF4ARyL1zG+9M8ttOBVzE8pOhr/eKURcY4t4qqUQvRozwF8wCiIrMPjetbC
	 7g06dqPVae9LQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	robin.murphy@arm.com
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: FAILED: Patch "perf/arm-cmn: Reject unsupported hardware configurations" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:36:09 -0500
Message-ID: <20260301013609.1696038-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221718-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: 6EB361CC03A
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 36c0de02575ce59dfd879eb4ef63d53a68bbf9ce Mon Sep 17 00:00:00 2001
From: Robin Murphy <robin.murphy@arm.com>
Date: Tue, 3 Feb 2026 14:07:29 +0000
Subject: [PATCH] perf/arm-cmn: Reject unsupported hardware configurations

So far we've been fairly lax about accepting both unknown CMN models
(at least with a warning), and unknown revisions of those which we
do know, as although things do frequently change between releases,
typically enough remains the same to be somewhat useful for at least
some basic bringup checks. However, we also make assumptions of the
maximum supported sizes and numbers of things in various places, and
there's no guarantee that something new might not be bigger and lead
to nasty array overflows. Make sure we only try to run on things that
actually match our assumptions and so will not risk memory corruption.

We have at least always failed on completely unknown node types, so
update that error message for clarity and consistency too.

Cc: stable@vger.kernel.org
Fixes: 7819e05a0dce ("perf/arm-cmn: Revamp model detection")
Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/perf/arm-cmn.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 651edd73bfcb1..4fbafc4b79843 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2422,6 +2422,15 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 			arm_cmn_init_node_info(cmn, reg & CMN_CHILD_NODE_ADDR, dn);
 			dn->portid_bits = xp->portid_bits;
 			dn->deviceid_bits = xp->deviceid_bits;
+			/*
+			 * Logical IDs are assigned from 0 per node type, so as
+			 * soon as we see one bigger than expected, we can assume
+			 * there are more than we can cope with.
+			 */
+			if (dn->logid > CMN_MAX_NODES_PER_EVENT) {
+				dev_err(cmn->dev, "Node ID invalid for supported CMN versions: %d\n", dn->logid);
+				return -ENODEV;
+			}
 
 			switch (dn->type) {
 			case CMN_TYPE_DTC:
@@ -2471,7 +2480,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 				break;
 			/* Something has gone horribly wrong */
 			default:
-				dev_err(cmn->dev, "invalid device node type: 0x%x\n", dn->type);
+				dev_err(cmn->dev, "Device node type invalid for supported CMN versions: 0x%x\n", dn->type);
 				return -ENODEV;
 			}
 		}
@@ -2499,6 +2508,10 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 		cmn->mesh_x = cmn->num_xps;
 	cmn->mesh_y = cmn->num_xps / cmn->mesh_x;
 
+	if (max(cmn->mesh_x, cmn->mesh_y) > CMN_MAX_DIMENSION) {
+		dev_err(cmn->dev, "Mesh size invalid for supported CMN versions: %dx%d\n", cmn->mesh_x, cmn->mesh_y);
+		return -ENODEV;
+	}
 	/* 1x1 config plays havoc with XP event encodings */
 	if (cmn->num_xps == 1)
 		dev_warn(cmn->dev, "1x1 config not fully supported, translate XP events manually\n");
-- 
2.51.0





