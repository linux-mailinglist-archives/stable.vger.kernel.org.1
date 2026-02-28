Return-Path: <stable+bounces-220815-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGhPCYpWo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220815-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:56:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A031D1C8A32
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5C3E34E7D51
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0569B495500;
	Sat, 28 Feb 2026 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HehLMOPm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B945B352927;
	Sat, 28 Feb 2026 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300700; cv=none; b=AdENbF2A16N8M0V84P5fUAtVwCYkr/e6b5/pNXJLNLwbkX0Q5nlnAxgRU820kRBOGegzj5d5kngwhd/cjtis4w6dfT46ORayjkhGT2DZksjth6nTWC8IS85+wCAJU0FErcXUaXg61pkqCYM+YmQMFerYJeqIiluIXsAU4qUnot4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300700; c=relaxed/simple;
	bh=S7eFNdkVrO8QDXkHBh+Sia2xcyU4ekGamgMGgDtYibg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImfK8Rgfex5MW0PbPJgqrc3KDvwaeO4Hk24qYjz2jrKhMwt1JPBaMH2/qpyZ+B6vdW2WXwEZgJj+bWeZ/PcCoi1eUCUAsg5E9clDcwJObNculTr1NmENm6V8rE85YFp2Oslj8brsGq4ySAyrevRFRxIWDRkuzOkiD+LkUEjWI08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HehLMOPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF41EC19425;
	Sat, 28 Feb 2026 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300700;
	bh=S7eFNdkVrO8QDXkHBh+Sia2xcyU4ekGamgMGgDtYibg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HehLMOPmqP9/bsJ+haageM84kMz1sDcz/k2/VvEhnqWrvlBZj9bvqQcJ9NA6ITmuJ
	 +elZ8PQt7aA388CwHwQ/K9UK91VG/JMAwudwdpBfoG/Y3seoICQMXJQDppCCjLRPuT
	 BUjY//zXc9CgHusV7Wnp14JAZ/S0NQuIMugBtpBi9ixQRKCtN+ckhOE3KNRYpY53Fp
	 v32wtHNlF7y/RipQAo6TbrD/4l/dS5vW3fXJY9TPTD35OW1nn0NZwxbxLM9weD0Q6J
	 EWFAQsGMf2fZKKcdXHF+InpWmxYhr8dRHUjQjXOtY1HESd6X0juGALVH/kVYVv1N7G
	 60119u4JROVqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 736/844] perf/arm-cmn: Reject unsupported hardware configurations
Date: Sat, 28 Feb 2026 12:30:49 -0500
Message-ID: <20260228173244.1509663-737-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220815-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email,amperecomputing.com:email]
X-Rspamd-Queue-Id: A031D1C8A32
X-Rspamd-Action: no action

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 36c0de02575ce59dfd879eb4ef63d53a68bbf9ce ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


