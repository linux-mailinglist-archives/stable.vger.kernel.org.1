Return-Path: <stable+bounces-253494-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FPDDqbYDmr2CQYAu9opvQ
	(envelope-from <stable+bounces-253494-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:04:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C765A2E4A
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E3C3307BA14
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC037E300;
	Thu, 21 May 2026 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dZKFvA7/"
X-Original-To: stable@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6737CD3E;
	Thu, 21 May 2026 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357039; cv=none; b=paBMX91tOnhLxEbpTyW+a+Q4SIszZOpiPIrmXnhWQbZNcL0QqufgLZRY1PwYzvB1FXnf+EMGC13oyUxMw4ps04PeDa0XmTKEowaI1DQTeEUR8z4BaqgIgd3k+WP1VVPG0JzTBWDtUZ6SWG+FqEy8cPKhx+CjNUjKUby9aeEgOVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357039; c=relaxed/simple;
	bh=3rcJfuxrYgXQHfgx9OasIboFgqJGybAc4F2etKUHlig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FluAfrJfkfEifUzrsFO+iLpVvsKtAsn5kyO9u9VaimY39avRMQygGmWoWnMpbH+axsUi8lPshXUtu8aoVTjhwJJKB4s0yb9efz/KZHJsZaRhHe98i4zIj35fCu4yrEcME1EZVvwvKZQpBSNQmqWLPmLqjDP2+gidT2foHX+rk+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dZKFvA7/; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779357030; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=J6ETTwMgFFcgsydN1Iah3JeGRk9qugvowEPUDsgsXn4=;
	b=dZKFvA7/IHOcCnO+RplSTyNw7drgrbZUdRsUSrJMxvArXqDTxPiFkfVZu0uec15DDvsXSteQoinh6T9qtELwArnbK802pjomMwvPUdNNNaIa2pqOkS5gMtu35YiY1Dfe9jUJzMAobjg5WNkFD0kYax899kkC67jGRCHpSvDoSzk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X3LSGLA_1779357029;
Received: from x31h02109.sqa.na131.tbsite.net(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X3LSGLA_1779357029 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 May 2026 17:50:29 +0800
From: Baokun Li <libaokun@linux.alibaba.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 1/3] writeback: fix race between cgroup_writeback_umount() and inode_switch_wbs()
Date: Thu, 21 May 2026 17:50:14 +0800
Message-ID: <20260521095016.2791354-2-libaokun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260521095016.2791354-1-libaokun@linux.alibaba.com>
References: <20260521095016.2791354-1-libaokun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253494-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[libaokun@linux.alibaba.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,suse.cz:email]
X-Rspamd-Queue-Id: 34C765A2E4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a container exits, the following BUG_ON() is occasionally triggered:

==================================================================
 VFS: Busy inodes after unmount of sdb (ext4)
 ------------[ cut here ]------------
 kernel BUG at fs/super.c:695!
 CPU: 3 PID: 6 Comm: containerd-shim Tainted: G OE K 6.6 #1
 pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
 pc : generic_shutdown_super+0xf0/0x100
 lr : generic_shutdown_super+0xf0/0x100
 Call trace:
  generic_shutdown_super+0xf0/0x100
  kill_block_super+0x20/0x48
  ext4_kill_sb+0x28/0x60
  deactivate_locked_super+0x54/0x130
  deactivate_super+0x84/0xa0
  cleanup_mnt+0xa4/0x140
  __cleanup_mnt+0x18/0x28
  task_work_run+0x78/0xe0
  do_notify_resume+0x204/0x240
==================================================================

The root cause is a race between cgroup_writeback_umount() and
inode_switch_wbs()/cleanup_offline_cgwb(). There is a window between
inode_prepare_wbs_switch() returning true and the subsequent
wb_queue_isw() call. Following is the process that triggers the issue:

      CPU A (umount)           |          CPU B (writeback)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                 inode_switch_wbs/cleanup_offline_cgwb
                                  atomic_inc(&isw_nr_in_flight)
                                  inode_prepare_wbs_switch
                                   -> passes SB_ACTIVE check
                                   __iget(inode)
 generic_shutdown_super
  sb->s_flags &= ~SB_ACTIVE
  cgroup_writeback_umount(sb)
   smp_mb()
   atomic_read(&isw_nr_in_flight)
   rcu_barrier()
    -> no pending RCU callbacks
   flush_workqueue(isw_wq)
    -> nothing queued, returns
  evict_inodes(sb)
   -> Inode skipped as isw still holds a ref.
  sop->put_super(sb)
   /* destroys percpu counters */
  -> VFS: Busy inodes after unmount!
                                  wb_queue_isw()
                                   queue_work(isw_wq, ...)
                                  /* later in work function */
                                  inode_switch_wbs_work_fn
                                   process_inode_switch_wbs
                                    iput() -> evict
                                     percpu_counter_dec() // UAF!

Fix this by extending the RCU read-side critical section in
inode_switch_wbs() and cleanup_offline_cgwb() to cover from
inode_prepare_wbs_switch() through wb_queue_isw().  Since there is
no sleep in this window, rcu_read_lock() can be used.  Then add a
synchronize_rcu() in cgroup_writeback_umount() before the existing
rcu_barrier(), so that all in-flight switchers that have passed the
SB_ACTIVE check have completed queue_work() before flush_workqueue()
is called.

The existing rcu_barrier() is intentionally retained so this fix can
be backported unchanged to stable kernels (5.10.y, 6.6.y, ...) that
still queue switches via queue_rcu_work(). It is a no-op on current
mainline (since commit e1b849cfa6b6 ("writeback: Avoid contention on
wb->list_lock when switching inodes")) and is removed in a follow-up
patch.

Fixes: a1a0e23e4903 ("writeback: flush inode cgroup wb switches instead of pinning super_block")
Cc: stable@vger.kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/all/mxnjq2l6guusfchvauxr3v7c4bwjasybxlleqbbh4efloeqspz@iqylk76ohufz
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
---
 fs/fs-writeback.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a65694cbfe68..6766de9f9d75 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -660,12 +660,19 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 
 	atomic_inc(&isw_nr_in_flight);
 
-	/* find and pin the new wb */
+	/*
+	 * Paired with synchronize_rcu() in cgroup_writeback_umount():
+	 * holding rcu_read_lock across inode_prepare_wbs_switch()
+	 * (covering the SB_ACTIVE check and the inode grab) and
+	 * wb_queue_isw() ensures synchronize_rcu() cannot return until
+	 * the work is queued, so the subsequent flush_workqueue() will
+	 * wait for the switch.
+	 */
 	rcu_read_lock();
+	/* find and pin the new wb */
 	memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
 	if (memcg_css && !css_tryget(memcg_css))
 		memcg_css = NULL;
-	rcu_read_unlock();
 	if (!memcg_css)
 		goto out_free;
 
@@ -681,9 +688,11 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 
 	trace_inode_switch_wbs_queue(inode->i_wb, new_wb, 1);
 	wb_queue_isw(new_wb, isw);
+	rcu_read_unlock();
 	return;
 
 out_free:
+	rcu_read_unlock();
 	atomic_dec(&isw_nr_in_flight);
 	if (new_wb)
 		wb_put(new_wb);
@@ -741,6 +750,14 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 		new_wb = &wb->bdi->wb; /* wb_get() is noop for bdi's wb */
 
 	nr = 0;
+	/*
+	 * Paired with synchronize_rcu() in cgroup_writeback_umount().
+	 * Holding rcu_read_lock across the SB_ACTIVE check, the inode grab
+	 * and wb_queue_isw() ensures synchronize_rcu() cannot return until
+	 * the work is queued, so the subsequent flush_workqueue() will wait
+	 * for the switch.
+	 */
+	rcu_read_lock();
 	spin_lock(&wb->list_lock);
 	/*
 	 * In addition to the inodes that have completed writeback, also switch
@@ -758,6 +775,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 
 	/* no attached inodes? bail out */
 	if (nr == 0) {
+		rcu_read_unlock();
 		atomic_dec(&isw_nr_in_flight);
 		wb_put(new_wb);
 		kfree(isw);
@@ -766,6 +784,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 
 	trace_inode_switch_wbs_queue(wb, new_wb, nr);
 	wb_queue_isw(new_wb, isw);
+	rcu_read_unlock();
 
 	return restart;
 }
@@ -1221,6 +1240,14 @@ void cgroup_writeback_umount(struct super_block *sb)
 	smp_mb();
 
 	if (atomic_read(&isw_nr_in_flight)) {
+		/*
+		 * Paired with rcu_read_lock() in inode_switch_wbs() and
+		 * cleanup_offline_cgwb().  synchronize_rcu() waits for any
+		 * in-flight switcher that already passed the SB_ACTIVE check
+		 * to finish queueing its work, so flush_workqueue() below
+		 * will then drain it.
+		 */
+		synchronize_rcu();
 		/*
 		 * Use rcu_barrier() to wait for all pending callbacks to
 		 * ensure that all in-flight wb switches are in the workqueue.
-- 
2.43.7


