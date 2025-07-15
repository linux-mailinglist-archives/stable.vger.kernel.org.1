Return-Path: <stable+bounces-162797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6EEB05FE0
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4EE586E6F
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4195C2E889F;
	Tue, 15 Jul 2025 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Kw79f3y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12992E8898;
	Tue, 15 Jul 2025 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587501; cv=none; b=ulrhQ4RFUXHxsdGUg/sRdN5uGPYmLMsBAuFuO5seahz3VqYNqZ/qxx8SgXVSc/qNbS5gLCnTr9Iv67VGaAxifHuGT39grJ4YBnPPGA7eC09H1p8STycy6tLBQhBDnQe+Ul5ANEFmLliAsYxOYQxnsRFKifX/ccV7egMTuKMxtMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587501; c=relaxed/simple;
	bh=9JSxp7CfWyth6DuinStyfCr15+qyMsqCVAMwoZJBgLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vF2MAv8slDjVRlLhjvtjG20v8bl/aClbtYd/BmtqXoqEcYLpVOdN3QwJai3ani9oGGCusyAvts6Is4z1kuxYLeM+V45LTLc5sJFDkHsXRdZw9cflNAGxzWoqQAfwcC9TH/sqipva7jePK8cZJ+PkO2itQrOEkgnBKQwdWNr6dWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Kw79f3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C77C4CEE3;
	Tue, 15 Jul 2025 13:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587500;
	bh=9JSxp7CfWyth6DuinStyfCr15+qyMsqCVAMwoZJBgLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0Kw79f3y36Oq8EcvgNDQnFrKZ91ZmD2+t3YStkmKFwbFqbeSzE5RMnqUa20f7mDcQ
	 b2Vcha0Bq7K7lY6iilg2eUEsv443JPsEzpr3IZR3ubEx+RvCb9tJKeny6IfytQoRF9
	 X4pGPZjSLCz/NYhrKpGLh3NSusP465JxXC5AyGCk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 036/208] RDMA/iwcm: Fix use-after-free of work objects after cm_id destruction
Date: Tue, 15 Jul 2025 15:12:25 +0200
Message-ID: <20250715130812.406314734@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130810.830580412@linuxfoundation.org>
References: <20250715130810.830580412@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[ Upstream commit 6883b680e703c6b2efddb4e7a8d891ce1803d06b ]

The commit 59c68ac31e15 ("iw_cm: free cm_id resources on the last
deref") simplified cm_id resource management by freeing cm_id once all
references to the cm_id were removed. The references are removed either
upon completion of iw_cm event handlers or when the application destroys
the cm_id. This commit introduced the use-after-free condition where
cm_id_private object could still be in use by event handler works during
the destruction of cm_id. The commit aee2424246f9 ("RDMA/iwcm: Fix a
use-after-free related to destroying CM IDs") addressed this use-after-
free by flushing all pending works at the cm_id destruction.

However, still another use-after-free possibility remained. It happens
with the work objects allocated for each cm_id_priv within
alloc_work_entries() during cm_id creation, and subsequently freed in
dealloc_work_entries() once all references to the cm_id are removed.
If the cm_id's last reference is decremented in the event handler work,
the work object for the work itself gets removed, and causes the use-
after-free BUG below:

  BUG: KASAN: slab-use-after-free in __pwq_activate_work+0x1ff/0x250
  Read of size 8 at addr ffff88811f9cf800 by task kworker/u16:1/147091

  CPU: 2 UID: 0 PID: 147091 Comm: kworker/u16:1 Not tainted 6.15.0-rc2+ #27 PREEMPT(voluntary)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
  Workqueue:  0x0 (iw_cm_wq)
  Call Trace:
   <TASK>
   dump_stack_lvl+0x6a/0x90
   print_report+0x174/0x554
   ? __virt_addr_valid+0x208/0x430
   ? __pwq_activate_work+0x1ff/0x250
   kasan_report+0xae/0x170
   ? __pwq_activate_work+0x1ff/0x250
   __pwq_activate_work+0x1ff/0x250
   pwq_dec_nr_in_flight+0x8c5/0xfb0
   process_one_work+0xc11/0x1460
   ? __pfx_process_one_work+0x10/0x10
   ? assign_work+0x16c/0x240
   worker_thread+0x5ef/0xfd0
   ? __pfx_worker_thread+0x10/0x10
   kthread+0x3b0/0x770
   ? __pfx_kthread+0x10/0x10
   ? rcu_is_watching+0x11/0xb0
   ? _raw_spin_unlock_irq+0x24/0x50
   ? rcu_is_watching+0x11/0xb0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x30/0x70
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>

  Allocated by task 147416:
   kasan_save_stack+0x2c/0x50
   kasan_save_track+0x10/0x30
   __kasan_kmalloc+0xa6/0xb0
   alloc_work_entries+0xa9/0x260 [iw_cm]
   iw_cm_connect+0x23/0x4a0 [iw_cm]
   rdma_connect_locked+0xbfd/0x1920 [rdma_cm]
   nvme_rdma_cm_handler+0x8e5/0x1b60 [nvme_rdma]
   cma_cm_event_handler+0xae/0x320 [rdma_cm]
   cma_work_handler+0x106/0x1b0 [rdma_cm]
   process_one_work+0x84f/0x1460
   worker_thread+0x5ef/0xfd0
   kthread+0x3b0/0x770
   ret_from_fork+0x30/0x70
   ret_from_fork_asm+0x1a/0x30

  Freed by task 147091:
   kasan_save_stack+0x2c/0x50
   kasan_save_track+0x10/0x30
   kasan_save_free_info+0x37/0x60
   __kasan_slab_free+0x4b/0x70
   kfree+0x13a/0x4b0
   dealloc_work_entries+0x125/0x1f0 [iw_cm]
   iwcm_deref_id+0x6f/0xa0 [iw_cm]
   cm_work_handler+0x136/0x1ba0 [iw_cm]
   process_one_work+0x84f/0x1460
   worker_thread+0x5ef/0xfd0
   kthread+0x3b0/0x770
   ret_from_fork+0x30/0x70
   ret_from_fork_asm+0x1a/0x30

  Last potentially related work creation:
   kasan_save_stack+0x2c/0x50
   kasan_record_aux_stack+0xa3/0xb0
   __queue_work+0x2ff/0x1390
   queue_work_on+0x67/0xc0
   cm_event_handler+0x46a/0x820 [iw_cm]
   siw_cm_upcall+0x330/0x650 [siw]
   siw_cm_work_handler+0x6b9/0x2b20 [siw]
   process_one_work+0x84f/0x1460
   worker_thread+0x5ef/0xfd0
   kthread+0x3b0/0x770
   ret_from_fork+0x30/0x70
   ret_from_fork_asm+0x1a/0x30

This BUG is reproducible by repeating the blktests test case nvme/061
for the rdma transport and the siw driver.

To avoid the use-after-free of cm_id_private work objects, ensure that
the last reference to the cm_id is decremented not in the event handler
works, but in the cm_id destruction context. For that purpose, move
iwcm_deref_id() call from destroy_cm_id() to the callers of
destroy_cm_id(). In iw_destroy_cm_id(), call iwcm_deref_id() after
flushing the pending works.

During the fix work, I noticed that iw_destroy_cm_id() is called from
cm_work_handler() and process_event() context. However, the comment of
iw_destroy_cm_id() notes that the function "cannot be called by the
event thread". Drop the false comment.

Closes: https://lore.kernel.org/linux-rdma/r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c/
Fixes: 59c68ac31e15 ("iw_cm: free cm_id resources on the last deref")
Cc: stable@vger.kernel.org
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://patch.msgid.link/20250510101036.1756439-1-shinichiro.kawasaki@wdc.com
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/iwcm.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 3e4941754b48d..ce41f235af253 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -367,12 +367,9 @@ EXPORT_SYMBOL(iw_cm_disconnect);
 /*
  * CM_ID <-- DESTROYING
  *
- * Clean up all resources associated with the connection and release
- * the initial reference taken by iw_create_cm_id.
- *
- * Returns true if and only if the last cm_id_priv reference has been dropped.
+ * Clean up all resources associated with the connection.
  */
-static bool destroy_cm_id(struct iw_cm_id *cm_id)
+static void destroy_cm_id(struct iw_cm_id *cm_id)
 {
 	struct iwcm_id_private *cm_id_priv;
 	struct ib_qp *qp;
@@ -441,20 +438,22 @@ static bool destroy_cm_id(struct iw_cm_id *cm_id)
 		iwpm_remove_mapinfo(&cm_id->local_addr, &cm_id->m_local_addr);
 		iwpm_remove_mapping(&cm_id->local_addr, RDMA_NL_IWCM);
 	}
-
-	return iwcm_deref_id(cm_id_priv);
 }
 
 /*
- * This function is only called by the application thread and cannot
- * be called by the event thread. The function will wait for all
- * references to be released on the cm_id and then kfree the cm_id
- * object.
+ * Destroy cm_id. If the cm_id still has other references, wait for all
+ * references to be released on the cm_id and then release the initial
+ * reference taken by iw_create_cm_id.
  */
 void iw_destroy_cm_id(struct iw_cm_id *cm_id)
 {
-	if (!destroy_cm_id(cm_id))
+	struct iwcm_id_private *cm_id_priv;
+
+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
+	destroy_cm_id(cm_id);
+	if (refcount_read(&cm_id_priv->refcount) > 1)
 		flush_workqueue(iwcm_wq);
+	iwcm_deref_id(cm_id_priv);
 }
 EXPORT_SYMBOL(iw_destroy_cm_id);
 
@@ -1037,8 +1036,10 @@ static void cm_work_handler(struct work_struct *_work)
 
 		if (!test_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags)) {
 			ret = process_event(cm_id_priv, &levent);
-			if (ret)
-				WARN_ON_ONCE(destroy_cm_id(&cm_id_priv->id));
+			if (ret) {
+				destroy_cm_id(&cm_id_priv->id);
+				WARN_ON_ONCE(iwcm_deref_id(cm_id_priv));
+			}
 		} else
 			pr_debug("dropping event %d\n", levent.event);
 		if (iwcm_deref_id(cm_id_priv))
-- 
2.39.5




