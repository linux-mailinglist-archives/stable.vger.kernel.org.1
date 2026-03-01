Return-Path: <stable+bounces-222118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qE/BCqedo2l2IQUAu9opvQ
	(envelope-from <stable+bounces-222118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:00:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 955DB1CC8CD
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45C6A30E98DD
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBC02FDC20;
	Sun,  1 Mar 2026 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0yypgzt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A06221FBB
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329947; cv=none; b=AlDzwuHNocWHY4HrRJsUhiNzVvnfJaGlasxVT4hy6aPQcMUBPWZAksx+PdbKocwe6dZjdnQX76FRlzPyPZOoQl2l9jFEApwUzHk9JF+7rUUbqEo4ZVlzBJkPPk7DuhLD/0mJWNINrkp68XkQJVGCkq6GtwqKMkizxRFrYb0bO1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329947; c=relaxed/simple;
	bh=eSH/epSalkFOYEVt6UOhEJpECxpdgQxRvntgP02NzTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RR3XRyKaQibF91HvibKXfLa2fw5Cd+Yn8vzEvMooBKWS+uPS2/z3yuULcmVxoA8u768PEY03jLlzqLPYTlI+9ft0jUoUjvePYYyvZiavXwKjtX4BDfbZWrf6HSB2lJFDTfwLa8KuF7SDjqCMrR/KPy95buIp+QAfp6rEUMjo+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0yypgzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A63BC19421;
	Sun,  1 Mar 2026 01:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329947;
	bh=eSH/epSalkFOYEVt6UOhEJpECxpdgQxRvntgP02NzTE=;
	h=From:To:Cc:Subject:Date:From;
	b=I0yypgztqHYHudhBA6ByA6knGUXoboWc2PlZ+XhbgEniQWl5akFhn6IQfYkd0Wjs0
	 qzicJi12uTR2v/UKr+qFY1E8mPeqnhsdaOtVJTp3dneWEig21BSimo5UF+BK+I+9za
	 nlxGMqFz02xAG9LswMnw6XagAmh5CgBNpNQJfpjIUsjC9ri+p3ffDv6p27A5MrhcnN
	 CVPkmxdMWa4791DvD7t1j0H9Z0BXrcsyEzrihEoEu1U7E6pCG4ci9EQRNg8NGsV3UC
	 pD0uRqd4L6kvqBNSlWlv/mnKeA7blIVJ0NCiXQ1/h1YUBJfRcnHEt7DNWMheLyKXtL
	 i55ZzeVDmRqHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kartikey406@gmail.com
Cc: syzbot+d8d4c31d40f868eaea30@syzkaller.appspotmail.com,
	Uladzislau Rezki <urezki@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Subject: FAILED: Patch "mm/vmalloc: prevent RCU stalls in kasan_release_vmalloc_node" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:52:24 -0500
Message-ID: <20260301015225.1718913-1-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,gmail.com,sina.com,linux-foundation.org,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222118-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,d8d4c31d40f868eaea30];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email,appspotmail.com:email,sina.com:email]
X-Rspamd-Queue-Id: 955DB1CC8CD
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5747435e0fd474c24530ef1a6822f47e7d264b27 Mon Sep 17 00:00:00 2001
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Mon, 12 Jan 2026 16:06:12 +0530
Subject: [PATCH] mm/vmalloc: prevent RCU stalls in kasan_release_vmalloc_node

When CONFIG_PAGE_OWNER is enabled, freeing KASAN shadow pages during
vmalloc cleanup triggers expensive stack unwinding that acquires RCU read
locks.  Processing a large purge_list without rescheduling can cause the
task to hold CPU for extended periods (10+ seconds), leading to RCU stalls
and potential OOM conditions.

The issue manifests in purge_vmap_node() -> kasan_release_vmalloc_node()
where iterating through hundreds or thousands of vmap_area entries and
freeing their associated shadow pages causes:

  rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  rcu: Tasks blocked on level-0 rcu_node (CPUs 0-1): P6229/1:b..l
  ...
  task:kworker/0:17 state:R running task stack:28840 pid:6229
  ...
  kasan_release_vmalloc_node+0x1ba/0xad0 mm/vmalloc.c:2299
  purge_vmap_node+0x1ba/0xad0 mm/vmalloc.c:2299

Each call to kasan_release_vmalloc() can free many pages, and with
page_owner tracking, each free triggers save_stack() which performs stack
unwinding under RCU read lock.  Without yielding, this creates an
unbounded RCU critical section.

Add periodic cond_resched() calls within the loop to allow:
- RCU grace periods to complete
- Other tasks to run
- Scheduler to preempt when needed

The fix uses need_resched() for immediate response under load, with a
batch count of 32 as a guaranteed upper bound to prevent worst-case stalls
even under light load.

Link: https://lkml.kernel.org/r/20260112103612.627247-1-kartikey406@gmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Reported-by: syzbot+d8d4c31d40f868eaea30@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d8d4c31d40f868eaea30
Link: https://lore.kernel.org/all/20260112084723.622910-1-kartikey406@gmail.com/T/ [v1]
Suggested-by: Uladzislau Rezki <urezki@gmail.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/vmalloc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 32d6ee92d4ff8..ca4c653286870 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2273,11 +2273,14 @@ decay_va_pool_node(struct vmap_node *vn, bool full_decay)
 	reclaim_list_global(&decay_list);
 }
 
+#define KASAN_RELEASE_BATCH_SIZE 32
+
 static void
 kasan_release_vmalloc_node(struct vmap_node *vn)
 {
 	struct vmap_area *va;
 	unsigned long start, end;
+	unsigned int batch_count = 0;
 
 	start = list_first_entry(&vn->purge_list, struct vmap_area, list)->va_start;
 	end = list_last_entry(&vn->purge_list, struct vmap_area, list)->va_end;
@@ -2287,6 +2290,11 @@ kasan_release_vmalloc_node(struct vmap_node *vn)
 			kasan_release_vmalloc(va->va_start, va->va_end,
 				va->va_start, va->va_end,
 				KASAN_VMALLOC_PAGE_RANGE);
+
+		if (need_resched() || (++batch_count >= KASAN_RELEASE_BATCH_SIZE)) {
+			cond_resched();
+			batch_count = 0;
+		}
 	}
 
 	kasan_release_vmalloc(start, end, start, end, KASAN_VMALLOC_TLB_FLUSH);
-- 
2.51.0





