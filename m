Return-Path: <stable+bounces-102251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044459EF20E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C3E189D01F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F89236FAE;
	Thu, 12 Dec 2024 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rgxN5go2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C761A22653B;
	Thu, 12 Dec 2024 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020547; cv=none; b=B64+M+A8+C5E+JXOXMK4PfEk17OB2xZnhDKzz3bsHN6gTnw2VoWEZTM0DcrsXwWSSbccDI405Wh/jE5dsytEhxV5clie4QTG8N8zKNrjViFcLOfGO6ufgptnBgpyhFT2jrTZ8fFny/CeghlvCV9PJo1Ymmlx7PYL/oUf7dE2Cgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020547; c=relaxed/simple;
	bh=ZTuu+NDqYV9ZPDjYdDW3NF8hX57bdmDtmEELosykl5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCv1CmtJvSX8n53Gav+p+gVYHhNTDHMokPeMG3bju3vC5UkaMszgejtpwhF5M8BCb7MdMWHyXms7zkOCbXuxAQicwhurt9j9ab43/NkONqo/pFTsXMRQDwUDFPe61kqRbqPmucTRUUFFNGsrRtvrIjDPnyazubuCBDepbrjxBjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rgxN5go2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F08C4CECE;
	Thu, 12 Dec 2024 16:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020547;
	bh=ZTuu+NDqYV9ZPDjYdDW3NF8hX57bdmDtmEELosykl5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgxN5go2W5Ay9ZZ6kbHOFFbu+DkXjDwa+75pbBGb9WgkESqnk2LBqNiq57x+1xPLM
	 YiQopO4vWFj7CeBkTrO72Op1QXIWUkATD3fuVtx+tV827Wz68rDJjWSDBtqg2/ahEs
	 eHpbP+Q3gzpjdfPyESYt3Jh3szqSqaEF/NHV+T5Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Yang Erkun <yangerkun@huawei.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.1 496/772] nfsd: fix nfs4_openowner leak when concurrent nfsd4_open occur
Date: Thu, 12 Dec 2024 15:57:21 +0100
Message-ID: <20241212144410.444774044@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Erkun <yangerkun@huawei.com>

commit 98100e88dd8865999dc6379a3356cd799795fe7b upstream.

The action force umount(umount -f) will attempt to kill all rpc_task even
umount operation may ultimately fail if some files remain open.
Consequently, if an action attempts to open a file, it can potentially
send two rpc_task to nfs server.

                   NFS CLIENT
thread1                             thread2
open("file")
...
nfs4_do_open
 _nfs4_do_open
  _nfs4_open_and_get_state
   _nfs4_proc_open
    nfs4_run_open_task
     /* rpc_task1 */
     rpc_run_task
     rpc_wait_for_completion_task

                                    umount -f
                                    nfs_umount_begin
                                     rpc_killall_tasks
                                      rpc_signal_task
     rpc_task1 been wakeup
     and return -512
 _nfs4_do_open // while loop
    ...
    nfs4_run_open_task
     /* rpc_task2 */
     rpc_run_task
     rpc_wait_for_completion_task

While processing an open request, nfsd will first attempt to find or
allocate an nfs4_openowner. If it finds an nfs4_openowner that is not
marked as NFS4_OO_CONFIRMED, this nfs4_openowner will released. Since
two rpc_task can attempt to open the same file simultaneously from the
client to server, and because two instances of nfsd can run
concurrently, this situation can lead to lots of memory leak.
Additionally, when we echo 0 to /proc/fs/nfsd/threads, warning will be
triggered.

                    NFS SERVER
nfsd1                  nfsd2       echo 0 > /proc/fs/nfsd/threads

nfsd4_open
 nfsd4_process_open1
  find_or_alloc_open_stateowner
   // alloc oo1, stateid1
                       nfsd4_open
                        nfsd4_process_open1
                        find_or_alloc_open_stateowner
                        // find oo1, without NFS4_OO_CONFIRMED
                         release_openowner
                          unhash_openowner_locked
                          list_del_init(&oo->oo_perclient)
                          // cannot find this oo
                          // from client, LEAK!!!
                         alloc_stateowner // alloc oo2

 nfsd4_process_open2
  init_open_stateid
  // associate oo1
  // with stateid1, stateid1 LEAK!!!
  nfs4_get_vfs_file
  // alloc nfsd_file1 and nfsd_file_mark1
  // all LEAK!!!

                         nfsd4_process_open2
                         ...

                                    write_threads
                                     ...
                                     nfsd_destroy_serv
                                      nfsd_shutdown_net
                                       nfs4_state_shutdown_net
                                        nfs4_state_destroy_net
                                         destroy_client
                                          __destroy_client
                                          // won't find oo1!!!
                                     nfsd_shutdown_generic
                                      nfsd_file_cache_shutdown
                                       kmem_cache_destroy
                                       for nfsd_file_slab
                                       and nfsd_file_mark_slab
                                       // bark since nfsd_file1
                                       // and nfsd_file_mark1
                                       // still alive

=======================================================================
BUG nfsd_file (Not tainted): Objects remaining in nfsd_file on
__kmem_cache_shutdown()
-----------------------------------------------------------------------

Slab 0xffd4000004438a80 objects=34 used=1 fp=0xff11000110e2ad28
flags=0x17ffffc0000240(workingset|head|node=0|zone=2|lastcpupid=0x1fffff)
CPU: 4 UID: 0 PID: 757 Comm: sh Not tainted 6.12.0-rc6+ #19
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.1-2.fc37 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x53/0x70
 slab_err+0xb0/0xf0
 __kmem_cache_shutdown+0x15c/0x310
 kmem_cache_destroy+0x66/0x160
 nfsd_file_cache_shutdown+0xac/0x210 [nfsd]
 nfsd_destroy_serv+0x251/0x2a0 [nfsd]
 nfsd_svc+0x125/0x1e0 [nfsd]
 write_threads+0x16a/0x2a0 [nfsd]
 nfsctl_transaction_write+0x74/0xa0 [nfsd]
 vfs_write+0x1ae/0x6d0
 ksys_write+0xc1/0x160
 do_syscall_64+0x5f/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Disabling lock debugging due to kernel taint
Object 0xff11000110e2ac38 @offset=3128
Allocated in nfsd_file_do_acquire+0x20f/0xa30 [nfsd] age=1635 cpu=3
pid=800
 nfsd_file_do_acquire+0x20f/0xa30 [nfsd]
 nfsd_file_acquire_opened+0x5f/0x90 [nfsd]
 nfs4_get_vfs_file+0x4c9/0x570 [nfsd]
 nfsd4_process_open2+0x713/0x1070 [nfsd]
 nfsd4_open+0x74b/0x8b0 [nfsd]
 nfsd4_proc_compound+0x70b/0xc20 [nfsd]
 nfsd_dispatch+0x1b4/0x3a0 [nfsd]
 svc_process_common+0x5b8/0xc50 [sunrpc]
 svc_process+0x2ab/0x3b0 [sunrpc]
 svc_handle_xprt+0x681/0xa20 [sunrpc]
 nfsd+0x183/0x220 [nfsd]
 kthread+0x199/0x1e0
 ret_from_fork+0x31/0x60
 ret_from_fork_asm+0x1a/0x30

Add nfs4_openowner_unhashed to help found unhashed nfs4_openowner, and
break nfsd4_open process to fix this problem.

Cc: stable@vger.kernel.org # v5.4+
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1628,6 +1628,14 @@ static void release_open_stateid(struct
 	free_ol_stateid_reaplist(&reaplist);
 }
 
+static bool nfs4_openowner_unhashed(struct nfs4_openowner *oo)
+{
+	lockdep_assert_held(&oo->oo_owner.so_client->cl_lock);
+
+	return list_empty(&oo->oo_owner.so_strhash) &&
+		list_empty(&oo->oo_perclient);
+}
+
 static void unhash_openowner_locked(struct nfs4_openowner *oo)
 {
 	struct nfs4_client *clp = oo->oo_owner.so_client;
@@ -4635,6 +4643,12 @@ retry:
 	spin_lock(&oo->oo_owner.so_client->cl_lock);
 	spin_lock(&fp->fi_lock);
 
+	if (nfs4_openowner_unhashed(oo)) {
+		mutex_unlock(&stp->st_mutex);
+		stp = NULL;
+		goto out_unlock;
+	}
+
 	retstp = nfsd4_find_existing_open(fp, open);
 	if (retstp)
 		goto out_unlock;
@@ -5709,6 +5723,11 @@ nfsd4_process_open2(struct svc_rqst *rqs
 
 	if (!stp) {
 		stp = init_open_stateid(fp, open);
+		if (!stp) {
+			status = nfserr_jukebox;
+			goto out;
+		}
+
 		if (!open->op_stp)
 			new_stp = true;
 	}



