Return-Path: <stable+bounces-210682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACLWDGFTcGlvXQAAu9opvQ
	(envelope-from <stable+bounces-210682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:17:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F8750EB5
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1E254EA6DE
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94898318B83;
	Wed, 21 Jan 2026 04:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HNnpUl7C"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82949318B8D;
	Wed, 21 Jan 2026 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768969042; cv=none; b=ERjM0T8Zf0ia3L73yQwH7anICO1De9z0U7aYhA+XIeN/vybcW7SPDlSzlYNewL0B4JbVNRd8pdCeHjDavApAFG1BTssoUmR1h8c5d1p+MXir6138uqZ1A8y4MER7cFT4IZDargStvkQ5smkJmv2GxOY0Lps0W0cPfc1bqOI2Dbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768969042; c=relaxed/simple;
	bh=dN1YbO7Lb2GTYBbYB4fELIlyr1tQTfWae3sAnntf0OM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ulo7yaT7lME5BXFarakGX0k8Zbl1kZxnN1YVd+TbXuvUnPUOgAK1LJgBLHeGK11HxzAAl6zm7MCRsmzOUick43pDBr1W9Zg2icKvtzNbjxgU1S6b5a/+UaJRFGa5aS+T7+3Rtj+Mn9HMEHnn2HZHfKqPIqpeIunljg6wkzWW+xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HNnpUl7C; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=YV
	9eHYKWyj5YuijtGDrIAQ5pEQ6c5DWaXs8Noov/ULU=; b=HNnpUl7CfvNYFLNUX0
	GJZf4Pz0X2nq6JJ2Yq6f8DUkyFwcb10RMxv2arVHMAFUwYSHsuYH/Dbv2M7NAqoD
	f77rLL/EdqbLY/MnQtkU32+95aBcKUV8nqM37blYrleDH0MjkuH/yI1VkTZNs5Pa
	1YBfstY/0gbPHv3f/drN2lIGc=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3it4kU3BpyA7JLQ--.25S2;
	Wed, 21 Jan 2026 12:16:38 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Maninder Singh <maninder1.s@samsung.com>,
	Shubham Rana <s9.rana@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH v6.6] NFSD: fix race between nfsd registration and exports_proc
Date: Wed, 21 Jan 2026 12:16:18 +0800
Message-Id: <20260121041618.3534193-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3it4kU3BpyA7JLQ--.25S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFWrGF4UCFWrur1xAFy3twb_yoW7Xr4xpa
	n3urW5Kr4vqw1UJw45Gan0yF10qF4kKay8u3s3W3ySvwsIg3sFva4FvF4q9FyDAFW8XayD
	Gw1UGr4F9w1ruaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_q2MxUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC+QZU7WlwUyayNQAA3t
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210682-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,samsung.com,kernel.org,oracle.com,163.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[163.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	R_SPF_SOFTFAIL(0.00)[~all];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 51F8750EB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
("NFSD: add rpc_status netlink support")
and the proper adoption is done. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 fs/nfsd/nfsctl.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 887035b74467..cacfcd9c92a6 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1583,12 +1583,9 @@ static int __init init_nfsd(void)
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
@@ -1596,18 +1593,20 @@ static int __init init_nfsd(void)
 	if (retval)
 		goto out_free_cld;
 	retval = register_filesystem(&nfsd_fs_type);
+	if (retval)
+		goto out_free_nfsd4;
+	retval = create_proc_exports_entry();
 	if (retval)
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
@@ -1620,13 +1619,13 @@ static int __init init_nfsd(void)
 
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
-- 
2.34.1


