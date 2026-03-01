Return-Path: <stable+bounces-221811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL1SOgiao2kwIAUAu9opvQ
	(envelope-from <stable+bounces-221811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:44:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9B51CB83D
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A31A5307A43B
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9712EC0A1;
	Sun,  1 Mar 2026 01:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPTZatHq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E92E5B1B
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329195; cv=none; b=F1xxw/6Di8AnJ7Los7HuOY2Cvb9bzLtRo1MUx8/t9H1GiHx7BAjfffvw3ii3TapvkhT8uWlCQ3aZYUSweEtONCq8pJW8KU5OWucn2ZyhNVRk6kKdLZ+89zYjiTDx6/+Avx5lSPUT2YM3KDrTPHaO+p6Gke/Ocg5rmeKGXLQrLUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329195; c=relaxed/simple;
	bh=7fHVgM3cnjLo1FnmfhwFNIUS5jXt44mN2T0kR0b2yns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gW6kfIyW6R/vA0aFFi053g6BF+icraIznxkhHudzfgcyi82RPY0HVfj0Ayuzb84qlm2h6vm+R4b+iVmbCoaq/SvzR/stgaGwbuNWvYvhLttWO4Jb4IrWI78Uz0fGMEToT9Zf7MUzOV4nMnK8AWgR0Dl1npVzKvCGgVQwUDexx5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPTZatHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EA4C19425;
	Sun,  1 Mar 2026 01:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329195;
	bh=7fHVgM3cnjLo1FnmfhwFNIUS5jXt44mN2T0kR0b2yns=;
	h=From:To:Cc:Subject:Date:From;
	b=GPTZatHqUeV+8VFfY12j6KvdRe57MTi15l/q6DdAHKOTxCmTp6gHTJs4raxbiniOu
	 U6tcxgWNJZik9r11UbH2wLZa3ybYJawBZoTA47cgMCp/QHYZitsF+F0gB/6+v8TFy0
	 hXIPESNmzGHdRyhutFgGUobMCQyE9EToe+abdLAVHLNun19IFWTiAvkacd39fIdTee
	 SVorkA3+Nu8Hta3bvPO922UXr+iyUF7zB6tIR+HZ+cxPOn2rVMaVcnnEszZaJDJ62B
	 k389o04p21/bTKACoNkd/WpAiLOG5QsJILxxw6JuRmNp0gwwAs7u4OwTqdrpWhDuEn
	 G5DAGeJhc0GqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	olvaffe@gmail.com
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Steven Price <steven.price@arm.com>,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm/panthor: fix for dma-fence safe access rules" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:39:53 -0500
Message-ID: <20260301013953.1701005-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221811-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:email,collabora.com:email]
X-Rspamd-Queue-Id: AD9B51CB83D
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
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





