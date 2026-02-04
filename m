Return-Path: <stable+bounces-213723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPFwE9Zfg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:03:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B54E7D4A
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 049BE301C6E4
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB5429AB1D;
	Wed,  4 Feb 2026 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LLnP1f+Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA427F163;
	Wed,  4 Feb 2026 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217292; cv=none; b=VZBRaIO9zqrkfX9qF9qmPZK1pnwNt7Xi55+QCs/UvEFAJYQakuIihF+3krf50uGiByDP/qfHTjxoz0NrPS8mm45YiTIMUWTr9Et7RDRjuXJ8PMozyrwGLp6t32au+/DqELLSMwdw3aeQGKpLi2JD/H9L0puh8rBGEFg0o+aFIyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217292; c=relaxed/simple;
	bh=P7uHkPehPC/GdiZm50BbVuwlkszXKE3ICt/gDwfJ2P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehwwJ8DBMWUVOsAWD8vyYRNBQkZ8DCZjnYZFAZIH0DlLI2o+YbrdnmBY9DGIdZdV3ajd0eB737t1iDO7UewOZZv2FxyDHLpq483A1p/C+XLyc9ZcW0+ZY1gu6Q3TlS7VkMGKX1tKsb0f2ecgRxl2bvgyfJ4+EYlk5b79cnjLJcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LLnP1f+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E1CC4CEF7;
	Wed,  4 Feb 2026 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217292;
	bh=P7uHkPehPC/GdiZm50BbVuwlkszXKE3ICt/gDwfJ2P4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LLnP1f+Q4xw2qM+jqHF+T0FTiHrlXwuAAkgZU+ndJX7GOv2z06Y2ILe9PXOPHZrxi
	 l3OepRxCobbcqMoqC5gdlZa96LUYmeVPUb1x4itJV6ai2S7KMyR6DG2rnk5lslPPEZ
	 LstFjRV+6JcWpYXxnKxg9PGuKs0a/O/4E2zuXNMM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shubham Rana <s9.rana@samsung.com>,
	Maninder Singh <maninder1.s@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 5.15 181/206] NFSD: fix race between nfsd registration and exports_proc
Date: Wed,  4 Feb 2026 15:40:12 +0100
Message-ID: <20260204143904.737091927@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,samsung.com,kernel.org,oracle.com,163.com];
	TAGGED_FROM(0.00)[bounces-213723-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email,oracle.com:email]
X-Rspamd-Queue-Id: B5B54E7D4A
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maninder Singh <maninder1.s@samsung.com>

[ Upstream commit f7fb730cac9aafda8b9813b55d04e28a9664d17c ]

As of now nfsd calls create_proc_exports_entry() at start of init_nfsd
and cleanup by remove_proc_entry() at last of exit_nfsd.

Which causes kernel OOPs if there is race between below 2 operations:
(i) exportfs -r
(ii) mount -t nfsd none /proc/fs/nfsd

for 5.4 kernel ARM64:

CPU 1:
el1_irq+0xbc/0x180
arch_counter_get_cntvct+0x14/0x18
running_clock+0xc/0x18
preempt_count_add+0x88/0x110
prep_new_page+0xb0/0x220
get_page_from_freelist+0x2d8/0x1778
__alloc_pages_nodemask+0x15c/0xef0
__vmalloc_node_range+0x28c/0x478
__vmalloc_node_flags_caller+0x8c/0xb0
kvmalloc_node+0x88/0xe0
nfsd_init_net+0x6c/0x108 [nfsd]
ops_init+0x44/0x170
register_pernet_operations+0x114/0x270
register_pernet_subsys+0x34/0x50
init_nfsd+0xa8/0x718 [nfsd]
do_one_initcall+0x54/0x2e0

CPU 2 :
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010

PC is at : exports_net_open+0x50/0x68 [nfsd]

Call trace:
exports_net_open+0x50/0x68 [nfsd]
exports_proc_open+0x2c/0x38 [nfsd]
proc_reg_open+0xb8/0x198
do_dentry_open+0x1c4/0x418
vfs_open+0x38/0x48
path_openat+0x28c/0xf18
do_filp_open+0x70/0xe8
do_sys_open+0x154/0x248

Sometimes it crashes at exports_net_open() and sometimes cache_seq_next_rcu().

and same is happening on latest 6.14 kernel as well:

[    0.000000] Linux version 6.14.0-rc5-next-20250304-dirty
...
[  285.455918] Unable to handle kernel paging request at virtual address 00001f4800001f48
...
[  285.464902] pc : cache_seq_next_rcu+0x78/0xa4
...
[  285.469695] Call trace:
[  285.470083]  cache_seq_next_rcu+0x78/0xa4 (P)
[  285.470488]  seq_read+0xe0/0x11c
[  285.470675]  proc_reg_read+0x9c/0xf0
[  285.470874]  vfs_read+0xc4/0x2fc
[  285.471057]  ksys_read+0x6c/0xf4
[  285.471231]  __arm64_sys_read+0x1c/0x28
[  285.471428]  invoke_syscall+0x44/0x100
[  285.471633]  el0_svc_common.constprop.0+0x40/0xe0
[  285.471870]  do_el0_svc_compat+0x1c/0x34
[  285.472073]  el0_svc_compat+0x2c/0x80
[  285.472265]  el0t_32_sync_handler+0x90/0x140
[  285.472473]  el0t_32_sync+0x19c/0x1a0
[  285.472887] Code: f9400885 93407c23 937d7c27 11000421 (f86378a3)
[  285.473422] ---[ end trace 0000000000000000 ]---

It reproduced simply with below script:
while [ 1 ]
do
/exportfs -r
done &

while [ 1 ]
do
insmod /nfsd.ko
mount -t nfsd none /proc/fs/nfsd
umount /proc/fs/nfsd
rmmod nfsd
done &

So exporting interfaces to user space shall be done at last and
cleanup at first place.

With change there is no Kernel OOPs.

Co-developed-by: Shubham Rana <s9.rana@samsung.com>
Signed-off-by: Shubham Rana <s9.rana@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ The context change is due to the commit bd9d6a3efa97
("NFSD: add rpc_status netlink support") in v6.7
and the proper adoption is done. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfsctl.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1511,12 +1511,9 @@ static int __init init_nfsd(void)
 	if (retval)
 		goto out_free_pnfs;
 	nfsd_lockd_init();	/* lockd->nfsd callbacks */
-	retval = create_proc_exports_entry();
-	if (retval)
-		goto out_free_lockd;
 	retval = register_pernet_subsys(&nfsd_net_ops);
 	if (retval < 0)
-		goto out_free_exports;
+		goto out_free_lockd;
 	retval = register_cld_notifier();
 	if (retval)
 		goto out_free_subsys;
@@ -1525,17 +1522,19 @@ static int __init init_nfsd(void)
 		goto out_free_cld;
 	retval = register_filesystem(&nfsd_fs_type);
 	if (retval)
+		goto out_free_nfsd4;
+	retval = create_proc_exports_entry();
+	if (retval)
 		goto out_free_all;
 	return 0;
 out_free_all:
+	unregister_filesystem(&nfsd_fs_type);
+out_free_nfsd4:
 	nfsd4_destroy_laundry_wq();
 out_free_cld:
 	unregister_cld_notifier();
 out_free_subsys:
 	unregister_pernet_subsys(&nfsd_net_ops);
-out_free_exports:
-	remove_proc_entry("fs/nfs/exports", NULL);
-	remove_proc_entry("fs/nfs", NULL);
 out_free_lockd:
 	nfsd_lockd_shutdown();
 	nfsd_drc_slab_free();
@@ -1548,13 +1547,13 @@ out_free_slabs:
 
 static void __exit exit_nfsd(void)
 {
+	remove_proc_entry("fs/nfs/exports", NULL);
+	remove_proc_entry("fs/nfs", NULL);
 	unregister_filesystem(&nfsd_fs_type);
 	nfsd4_destroy_laundry_wq();
 	unregister_cld_notifier();
 	unregister_pernet_subsys(&nfsd_net_ops);
 	nfsd_drc_slab_free();
-	remove_proc_entry("fs/nfs/exports", NULL);
-	remove_proc_entry("fs/nfs", NULL);
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();
 	nfsd4_exit_pnfs();



