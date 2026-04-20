Return-Path: <stable+bounces-239247-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMZTHzVP5mkgugEAu9opvQ
	(envelope-from <stable+bounces-239247-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:07:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E56DA42F01E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F8C5335B1B8
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1562D9EE4;
	Mon, 20 Apr 2026 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LKB+XJhm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216F2C08C8
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696570; cv=none; b=Tx4e8O+GDdvFxTcJFgQ1YqOCSjFfRVbQ7z+FhA65iIOh07JMtV3/nzRvliXinz6eAoMZImWRdOX/UiEa+lo8xAFom0+E3IEnkfF05f1EfvkFk9hoFNlZxOMgGxRyma9q1KbYw3A+MYV9MakEqhtaCi8lqiEUOXG2Pq9ZiWSSyeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696570; c=relaxed/simple;
	bh=CQTM7/MVskmvprpIt1GSpKHltL5GDrc7bRQ7UCtUQgc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jrdGX4Opg0wDa7HWN4dG84cBykj+ksIU+NkW3WFOUn0u9oAhTm2syfRJfcSgI31kvqcp29L97V7cs2rNsrI9gn5waV5PPzQxXrP6/EYnO+xuni1R5ju9lpzXrK9LuC/wuI19CqF4noxv/SsQmB4TrMQTDWUmO3Pb96Ti5vlK+So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LKB+XJhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A898C19425;
	Mon, 20 Apr 2026 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776696569;
	bh=CQTM7/MVskmvprpIt1GSpKHltL5GDrc7bRQ7UCtUQgc=;
	h=Subject:To:Cc:From:Date:From;
	b=LKB+XJhmqCPdqXyEnf3v0gAbA20TcE9m/+uMDPcseuf8MifbNFOOIuB4w8jYrhZt8
	 F2U5aWRQvniAKzSPYHUOiCogeJAEJx1dLU1M3r9Y22TbsMZW+LK+kPJrW6fBJKdSfC
	 wk57aI2u9boM6+q03dGbwJdVT55nSxq1jDXYlJFk=
Subject: FAILED: patch "[PATCH] mm: blk-cgroup: fix use-after-free in cgwb_release_workfn()" failed to apply to 5.15-stable tree
To: leitao@debian.org,akpm@linux-foundation.org,axboe@kernel.dk,david@kernel.org,dennis@kernel.org,hannes@cmpxchg.org,inwardvessel@gmail.com,josef@toxicpanda.com,liam.howlett@oracle.com,ljs@kernel.org,martin.lau@linux.dev,mhocko@suse.com,rppt@kernel.org,shakeel.butt@linux.dev,stable@vger.kernel.org,surenb@google.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Apr 2026 16:49:27 +0200
Message-ID: <2026042027-thinly-unrigged-91da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239247-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[debian.org,linux-foundation.org,kernel.dk,kernel.org,cmpxchg.org,gmail.com,toxicpanda.com,oracle.com,linux.dev,suse.com,vger.kernel.org,google.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,oracle.com:email,gregkh:email,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linux-foundation.org:email,toxicpanda.com:email]
X-Rspamd-Queue-Id: E56DA42F01E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8f5857be99f1ed1fa80991c72449541f634626ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042027-thinly-unrigged-91da@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8f5857be99f1ed1fa80991c72449541f634626ee Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Mon, 13 Apr 2026 03:09:19 -0700
Subject: [PATCH] mm: blk-cgroup: fix use-after-free in cgwb_release_workfn()

cgwb_release_workfn() calls css_put(wb->blkcg_css) and then later accesses
wb->blkcg_css again via blkcg_unpin_online().  If css_put() drops the last
reference, the blkcg can be freed asynchronously (css_free_rwork_fn ->
blkcg_css_free -> kfree) before blkcg_unpin_online() dereferences the
pointer to access blkcg->online_pin, resulting in a use-after-free:

  BUG: KASAN: slab-use-after-free in blkcg_unpin_online (./include/linux/instrumented.h:112 ./include/linux/atomic/atomic-instrumented.h:400 ./include/linux/refcount.h:389 ./include/linux/refcount.h:432 ./include/linux/refcount.h:450 block/blk-cgroup.c:1367)
  Write of size 4 at addr ff11000117aa6160 by task kworker/71:1/531
   Workqueue: cgwb_release cgwb_release_workfn
   Call Trace:
    <TASK>
     blkcg_unpin_online (./include/linux/instrumented.h:112 ./include/linux/atomic/atomic-instrumented.h:400 ./include/linux/refcount.h:389 ./include/linux/refcount.h:432 ./include/linux/refcount.h:450 block/blk-cgroup.c:1367)
     cgwb_release_workfn (mm/backing-dev.c:629)
     process_scheduled_works (kernel/workqueue.c:3278 kernel/workqueue.c:3385)

   Freed by task 1016:
    kfree (./include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6246 mm/slub.c:6561)
    css_free_rwork_fn (kernel/cgroup/cgroup.c:5542)
    process_scheduled_works (kernel/workqueue.c:3302 kernel/workqueue.c:3385)

** Stack based on commit 66672af7a095 ("Add linux-next specific files
for 20260410")

I am seeing this crash sporadically in Meta fleet across multiple kernel
versions.  A full reproducer is available at:
https://github.com/leitao/debug/blob/main/reproducers/repro_blkcg_uaf.sh

(The race window is narrow.  To make it easily reproducible, inject a
msleep(100) between css_put() and blkcg_unpin_online() in
cgwb_release_workfn().  With that delay and a KASAN-enabled kernel, the
reproducer triggers the splat reliably in less than a second.)

Fix this by moving blkcg_unpin_online() before css_put(), so the
cgwb's CSS reference keeps the blkcg alive while blkcg_unpin_online()
accesses it.

Link: https://lore.kernel.org/20260413-blkcg-v1-1-35b72622d16c@debian.org
Fixes: 59b57717fff8 ("blkcg: delay blkg destruction until after writeback has finished")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Cc: David Hildenbrand <david@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: JP Kobryn <inwardvessel@gmail.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 7a18fa6c7272..cecbcf9060a6 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -618,12 +618,13 @@ static void cgwb_release_workfn(struct work_struct *work)
 	wb_shutdown(wb);
 
 	css_put(wb->memcg_css);
-	css_put(wb->blkcg_css);
-	mutex_unlock(&wb->bdi->cgwb_release_mutex);
 
 	/* triggers blkg destruction if no online users left */
 	blkcg_unpin_online(wb->blkcg_css);
 
+	css_put(wb->blkcg_css);
+	mutex_unlock(&wb->bdi->cgwb_release_mutex);
+
 	fprop_local_destroy_percpu(&wb->memcg_completions);
 
 	spin_lock_irq(&cgwb_lock);


