Return-Path: <stable+bounces-136388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C45A99400
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 18:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16161BA13C7
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3503E294A14;
	Wed, 23 Apr 2025 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F40LfDU9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39D4279340;
	Wed, 23 Apr 2025 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422415; cv=none; b=FiM7GtQbeEVGWnOHX8eX9p2lO3Aoe/NyG4akjmxXIoSwGYPwBjIdwKM4YdFXSaH9Z8ElefQgytZEGqiBlhovAtZkvZEMxH58JLsOAsF9HR3w4Gez7kk0kmzI0WUih2BeMAMd/MgqpTybQA+wKR4QYdmk0KTNwej1xzinH0kA6LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422415; c=relaxed/simple;
	bh=zRUbEUgLCZTvemk6s2hklybNEXqOVpKAb0f69XdxBjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXft/qyfsKDmUNR3jdosY35kRjzKCh+EjmNpYLV7qbyeBcnNezDVpzDns/f27TkHsOQRTUAH81rOWDiAyBZtaCgNEztHjBBlOJeaK7CkWqmrclQdAik89Nj7UxRSlDK9Qoco3wEiF/v2rD8/ZddPdIp9VtM2SZpPYIGm/2LEMvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F40LfDU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781DDC4AF09;
	Wed, 23 Apr 2025 15:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745422414;
	bh=zRUbEUgLCZTvemk6s2hklybNEXqOVpKAb0f69XdxBjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F40LfDU9U2PhdmiIPE1dUuZLtu9VmZCnTA93ZbRGZYPxUXMlqLP92QcKhDoKEu/XS
	 fUmbj6Ym6dKRwzvpyku8gZMrkxUXerJXYeQ5WuUsy2XGbcKr9ET9pC2e8mXCoIaiIp
	 Exi1kkHq2C2ibijuVc1QHJziXhmwyAYKqIKs1vng=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
	Sharath Srinivasan <sharath.srinivasan@oracle.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 6.6 341/393] RDMA/cma: Fix workqueue crash in cma_netevent_work_handler
Date: Wed, 23 Apr 2025 16:43:57 +0200
Message-ID: <20250423142657.414549605@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sharath Srinivasan <sharath.srinivasan@oracle.com>

commit 45f5dcdd049719fb999393b30679605f16ebce14 upstream.

struct rdma_cm_id has member "struct work_struct net_work"
that is reused for enqueuing cma_netevent_work_handler()s
onto cma_wq.

Below crash[1] can occur if more than one call to
cma_netevent_callback() occurs in quick succession,
which further enqueues cma_netevent_work_handler()s for the
same rdma_cm_id, overwriting any previously queued work-item(s)
that was just scheduled to run i.e. there is no guarantee
the queued work item may run between two successive calls
to cma_netevent_callback() and the 2nd INIT_WORK would overwrite
the 1st work item (for the same rdma_cm_id), despite grabbing
id_table_lock during enqueue.

Also drgn analysis [2] indicates the work item was likely overwritten.

Fix this by moving the INIT_WORK() to __rdma_create_id(),
so that it doesn't race with any existing queue_work() or
its worker thread.

[1] Trimmed crash stack:
=============================================
BUG: kernel NULL pointer dereference, address: 0000000000000008
kworker/u256:6 ... 6.12.0-0...
Workqueue:  cma_netevent_work_handler [rdma_cm] (rdma_cm)
RIP: 0010:process_one_work+0xba/0x31a
Call Trace:
 worker_thread+0x266/0x3a0
 kthread+0xcf/0x100
 ret_from_fork+0x31/0x50
 ret_from_fork_asm+0x1a/0x30
=============================================

[2] drgn crash analysis:

>>> trace = prog.crashed_thread().stack_trace()
>>> trace
(0)  crash_setup_regs (./arch/x86/include/asm/kexec.h:111:15)
(1)  __crash_kexec (kernel/crash_core.c:122:4)
(2)  panic (kernel/panic.c:399:3)
(3)  oops_end (arch/x86/kernel/dumpstack.c:382:3)
...
(8)  process_one_work (kernel/workqueue.c:3168:2)
(9)  process_scheduled_works (kernel/workqueue.c:3310:3)
(10) worker_thread (kernel/workqueue.c:3391:4)
(11) kthread (kernel/kthread.c:389:9)

Line workqueue.c:3168 for this kernel version is in process_one_work():
3168	strscpy(worker->desc, pwq->wq->name, WORKER_DESC_LEN);

>>> trace[8]["work"]
*(struct work_struct *)0xffff92577d0a21d8 = {
	.data = (atomic_long_t){
		.counter = (s64)536870912,    <=== Note
	},
	.entry = (struct list_head){
		.next = (struct list_head *)0xffff924d075924c0,
		.prev = (struct list_head *)0xffff924d075924c0,
	},
	.func = (work_func_t)cma_netevent_work_handler+0x0 = 0xffffffffc2cec280,
}

Suspicion is that pwq is NULL:
>>> trace[8]["pwq"]
(struct pool_workqueue *)<absent>

In process_one_work(), pwq is assigned from:
struct pool_workqueue *pwq = get_work_pwq(work);

and get_work_pwq() is:
static struct pool_workqueue *get_work_pwq(struct work_struct *work)
{
 	unsigned long data = atomic_long_read(&work->data);

 	if (data & WORK_STRUCT_PWQ)
 		return work_struct_pwq(data);
 	else
 		return NULL;
}

WORK_STRUCT_PWQ is 0x4:
>>> print(repr(prog['WORK_STRUCT_PWQ']))
Object(prog, 'enum work_flags', value=4)

But work->data is 536870912 which is 0x20000000.
So, get_work_pwq() returns NULL and we crash in process_one_work():
3168	strscpy(worker->desc, pwq->wq->name, WORKER_DESC_LEN);
=============================================

Fixes: 925d046e7e52 ("RDMA/core: Add a netevent notifier to cma")
Cc: stable@vger.kernel.org
Co-developed-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Sharath Srinivasan <sharath.srinivasan@oracle.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Link: https://patch.msgid.link/bf0082f9-5b25-4593-92c6-d130aa8ba439@oracle.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/cma.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -72,6 +72,8 @@ static const char * const cma_events[] =
 static void cma_iboe_set_mgid(struct sockaddr *addr, union ib_gid *mgid,
 			      enum ib_gid_type gid_type);
 
+static void cma_netevent_work_handler(struct work_struct *_work);
+
 const char *__attribute_const__ rdma_event_msg(enum rdma_cm_event_type event)
 {
 	size_t index = event;
@@ -1017,6 +1019,7 @@ __rdma_create_id(struct net *net, rdma_c
 	get_random_bytes(&id_priv->seq_num, sizeof id_priv->seq_num);
 	id_priv->id.route.addr.dev_addr.net = get_net(net);
 	id_priv->seq_num &= 0x00ffffff;
+	INIT_WORK(&id_priv->id.net_work, cma_netevent_work_handler);
 
 	rdma_restrack_new(&id_priv->res, RDMA_RESTRACK_CM_ID);
 	if (parent)
@@ -5211,7 +5214,6 @@ static int cma_netevent_callback(struct
 		if (!memcmp(current_id->id.route.addr.dev_addr.dst_dev_addr,
 			   neigh->ha, ETH_ALEN))
 			continue;
-		INIT_WORK(&current_id->id.net_work, cma_netevent_work_handler);
 		cma_id_get(current_id);
 		queue_work(cma_wq, &current_id->id.net_work);
 	}



