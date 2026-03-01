Return-Path: <stable+bounces-222020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNp0F4Gro2myJgUAu9opvQ
	(envelope-from <stable+bounces-222020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:59:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1AC1CE1D3
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0670033C3AE2
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BD72E06E6;
	Sun,  1 Mar 2026 01:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYIzFfgL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD6A2FE577
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329707; cv=none; b=Uqz/jNmBBFSX7aSL8xTG0dm3vz51wQLyElwUmLtYt0YcTY7ja3IK6TcqiPJpfH/ODcgUBNh2eS5tAHn2PFpkZi5DPqzYq5mnOSqaIIgF14QNnj8qG7DD75ofUy9hPx7XIevLMv74kQbtAoD6FrEeO0LKI+1EaSBfHv/Mx/0rRBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329707; c=relaxed/simple;
	bh=saogXpU7tj3LcXLj/K0WlLH7eYSXNHx3KEPyEex1TVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PVqwUI+x8XsPliILOo6jQ7mUs4FukgeFNSUANd2FsXnMifSyN3dZtE5KsFbQO+01BGicHlZFGDJHLhJSqyVDot2pA/jB3CZRVgbGDRMeoa8JhxHpDGluywgfMX+mS3sxGMy6uAhUFE80QgrfEwWhOGEmxT6fFLBLilo9YHNZkV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYIzFfgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31C4C19421;
	Sun,  1 Mar 2026 01:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329707;
	bh=saogXpU7tj3LcXLj/K0WlLH7eYSXNHx3KEPyEex1TVc=;
	h=From:To:Cc:Subject:Date:From;
	b=hYIzFfgLBnmyzDQGlGXLHZMC3H0v2kyVGYXkZNdPRXfgvnSF/JCE523NKiDAItr5j
	 z707mRiGcGhCkrH75PiobIp7Ees4KRZQkQp5TCnqgp3avomD3f5WWElnIbLftHXI9T
	 TgOGbLZndYHorzBSKuwFd+GaHQel3Gw91xYPyC6aDyd8+2TGVX57O+6xJCNuoU1qGt
	 Ct2ZoA1ZUEvzAYwTvitqCyaBRHV9MsAIxLQnNFSK4fPaodV0oSnX0yqHc7KEGKPevc
	 8heiNWLe0J5+CIXebrTKLuxMB/y9o+fBEUMwrEoyA78+oo3fCn/kCcRU8b9TvJ+7m9
	 1JOwYrIS0D0CA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	olvaffe@gmail.com
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Steven Price <steven.price@arm.com>,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm/panthor: fix for dma-fence safe access rules" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:48:25 -0500
Message-ID: <20260301014825.1712609-1-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222020-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CF1AC1CE1D3
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From efe24898485c5c831e629d9c6fb9350c35cb576f Mon Sep 17 00:00:00 2001
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 4 Dec 2025 09:45:45 -0800
Subject: [PATCH] drm/panthor: fix for dma-fence safe access rules

Commit 506aa8b02a8d6 ("dma-fence: Add safe access helpers and document
the rules") details the dma-fence safe access rules. The most common
culprit is that drm_sched_fence_get_timeline_name may race with
group_free_queue.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Steven Price <steven.price@arm.com>
Link: https://patch.msgid.link/20251204174545.399059-1-olvaffe@gmail.com
---
 drivers/gpu/drm/panthor/panthor_sched.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index a17b067a04392..0f83e778d89aa 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/rcupdate.h>
 
 #include "panthor_devfreq.h"
 #include "panthor_device.h"
@@ -943,6 +944,9 @@ static void group_release_work(struct work_struct *work)
 						   release_work);
 	u32 i;
 
+	/* dma-fences may still be accessing group->queues under rcu lock. */
+	synchronize_rcu();
+
 	for (i = 0; i < group->queue_count; i++)
 		group_free_queue(group, group->queues[i]);
 
-- 
2.51.0





