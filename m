Return-Path: <stable+bounces-115127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB0A33E77
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 12:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F42E3A4FE7
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 11:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6391521422A;
	Thu, 13 Feb 2025 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Q5vCMla1"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF72211A06
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447582; cv=none; b=URcbc8X8ivsxdy3XckRwcEh1yn1/oWbI4noT6qty0KK9QqKOG5kKBF3NnBBcg0nXn5xFgnrn/3H1uYGPVBB2sR9e0aAh1od/4dwauiSOzzrWXs6GxugLOLFCvFmlWb3kNg4SWvYJaZcxPzgsdxB8w3EjwibB79dcr+rVthwyf3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447582; c=relaxed/simple;
	bh=PEDU2V9jLhsUydX0kyeJE2iCM3McVCgnwVv6RbI1tUA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Ze3ks+ZxZtFG61aQshNmLAdt9uNW7yhplYZAj+OTrfddyhNCRGBftN522z6hwNNoP2TSCPPNPHst1uIcSfe9njBwtHnv9+9OjtSfLVWf5lgsAQT+CEq5xTDzaYaSVz7b6eb6Y+PltG2DIIpeT4R5yehEUAwqdFCzAf9zqvFFlyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Q5vCMla1; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739447569; bh=fQrCX2rcjv2N90oR6MccQf1RJl9VjINjASLx5Wvu878=;
	h=From:To:Cc:Subject:Date;
	b=Q5vCMla1Fn/VatmJ11clt2tufPqIm901ffzYkAEFSBg4IXUBziRudaEJq1vlSjaL3
	 D8fc0p5l1hpEc1OcFqPlQKj8tQ/Dc26mnbQ7HkFxd8PuMk9iwSTpsKHxmos2GKwFMO
	 iOzWZ/RYd6Pk0zwJ7pZc2+sRGffg1WbRpzjCP9OE=
Received: from public ([120.244.194.25])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id B952C65E; Thu, 13 Feb 2025 19:46:21 +0800
X-QQ-mid: xmsmtpt1739447181tymsl9h9d
Message-ID: <tencent_950F86B5018E36B766EA4357D2C8BA1AC705@qq.com>
X-QQ-XMAILINFO: NsBBv6AnqV8OfrY2UWn/+pXbnzEl0wdVXfbmqmOv6N1H2B6FI4OMhVa4WIaZYN
	 qVqm812Hga3NkJGPdKbd22SCNXlvaBV42W2CESdF0YMDuwE3InswJ/RL1KTTsCUrkoH6+bofPBtZ
	 YC74zWo2c8xL3XiYQvLDpkMh4Dk/uZYNlkn4XmIhlwrW8tp3/2RbGgmxEq+FpOcEdh9HQOQ+9jtQ
	 uiPQJVXkPo6QtnB3SMbPLbtLfwv9NH5nHoocLag1JEaWWRQxBD558bvWwJuuv435HG0k6LUGAVpQ
	 XIE/TFNq07E7U+2+taVNwcJgCv04Q9Rr6ZEOgCSNQODTSik6DsNo+To54Us1QQBZMWGAaM08SeXm
	 TXkSmIVdg/sKpGSvELOnio0YHbwB7A7x0f1dF5f6L+a8QhT+G8CxLlSUOS681C/Ek9V+Gk2T0fcj
	 ngpJWVOJ8bJj47SgkgUid/plLy5M3FOAKQw3QLhcfHeur02CGB8NM/PxCRlUGGida5Y97IruZRw9
	 QiWXMug5aqnMs870BMV4yddFexGI8dcZkdI6PWG62EmK8MddmhfeFdn+eDb4Lr59LYuURnUJsyM4
	 mhO+QQ5f3hBpq7at7BChKTSm4kQcUW9vy7Y7M4XD2zd9hcNOBKaoKUTngaRdEjusImXZ9eRwGeDs
	 k7NaKC+lYRNvGuslwuiKBlcdlvGtOvTfs122stApRpACL3abVMc8X0HYCK7kAbYRy56mH/c7hPAN
	 fOjbTN2feM54kQoAepDQcJeDgevlM2oa3D6jmu8KE9BMHU6JiwdWvGV3NQK/pfh/PIbBT9ZKanUG
	 825C1U97Z7aVxcJ1FDPKEH3OlHuhq5KSM5NP115B5K8u39wO0k4hIKrErkFEMCJW41zN7UR63KBN
	 g7vcXrcGSfhO9K/17y7pXYgxJFQFXOVExj9piMiVTHNlWfaZf2xKv0lQVCfJ/99iTOeiaNQUs0M2
	 RVAbDBgErq1BeAtlOhI6YANXnZ2/q9Eihiy6LxgUVPXr8uoaZvcBaFqBO0CdAQV19+pilf5Hc=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: lanbincn@qq.com
To: stable@vger.kernel.org
Cc: Yang Erkun <yangerkun@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Bin Lan <lanbincn@qq.com>
Subject: [PATCH 6.1.y] nfsd: release svc_expkey/svc_export with rcu_work
Date: Thu, 13 Feb 2025 19:46:22 +0800
X-OQ-MSGID: <20250213114622.1091-1-lanbincn@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Erkun <yangerkun@huawei.com>

commit f8c989a0c89a75d30f899a7cabdc14d72522bb8d upstream.

The last reference for `cache_head` can be reduced to zero in `c_show`
and `e_show`(using `rcu_read_lock` and `rcu_read_unlock`). Consequently,
`svc_export_put` and `expkey_put` will be invoked, leading to two
issues:

1. The `svc_export_put` will directly free ex_uuid. However,
   `e_show`/`c_show` will access `ex_uuid` after `cache_put`, which can
   trigger a use-after-free issue, shown below.

   ==================================================================
   BUG: KASAN: slab-use-after-free in svc_export_show+0x362/0x430 [nfsd]
   Read of size 1 at addr ff11000010fdc120 by task cat/870

   CPU: 1 UID: 0 PID: 870 Comm: cat Not tainted 6.12.0-rc3+ #1
   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
   1.16.1-2.fc37 04/01/2014
   Call Trace:
    <TASK>
    dump_stack_lvl+0x53/0x70
    print_address_description.constprop.0+0x2c/0x3a0
    print_report+0xb9/0x280
    kasan_report+0xae/0xe0
    svc_export_show+0x362/0x430 [nfsd]
    c_show+0x161/0x390 [sunrpc]
    seq_read_iter+0x589/0x770
    seq_read+0x1e5/0x270
    proc_reg_read+0xe1/0x140
    vfs_read+0x125/0x530
    ksys_read+0xc1/0x160
    do_syscall_64+0x5f/0x170
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

   Allocated by task 830:
    kasan_save_stack+0x20/0x40
    kasan_save_track+0x14/0x30
    __kasan_kmalloc+0x8f/0xa0
    __kmalloc_node_track_caller_noprof+0x1bc/0x400
    kmemdup_noprof+0x22/0x50
    svc_export_parse+0x8a9/0xb80 [nfsd]
    cache_do_downcall+0x71/0xa0 [sunrpc]
    cache_write_procfs+0x8e/0xd0 [sunrpc]
    proc_reg_write+0xe1/0x140
    vfs_write+0x1a5/0x6d0
    ksys_write+0xc1/0x160
    do_syscall_64+0x5f/0x170
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

   Freed by task 868:
    kasan_save_stack+0x20/0x40
    kasan_save_track+0x14/0x30
    kasan_save_free_info+0x3b/0x60
    __kasan_slab_free+0x37/0x50
    kfree+0xf3/0x3e0
    svc_export_put+0x87/0xb0 [nfsd]
    cache_purge+0x17f/0x1f0 [sunrpc]
    nfsd_destroy_serv+0x226/0x2d0 [nfsd]
    nfsd_svc+0x125/0x1e0 [nfsd]
    write_threads+0x16a/0x2a0 [nfsd]
    nfsctl_transaction_write+0x74/0xa0 [nfsd]
    vfs_write+0x1a5/0x6d0
    ksys_write+0xc1/0x160
    do_syscall_64+0x5f/0x170
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

2. We cannot sleep while using `rcu_read_lock`/`rcu_read_unlock`.
   However, `svc_export_put`/`expkey_put` will call path_put, which
   subsequently triggers a sleeping operation due to the following
   `dput`.

   =============================
   WARNING: suspicious RCU usage
   5.10.0-dirty #141 Not tainted
   -----------------------------
   ...
   Call Trace:
   dump_stack+0x9a/0xd0
   ___might_sleep+0x231/0x240
   dput+0x39/0x600
   path_put+0x1b/0x30
   svc_export_put+0x17/0x80
   e_show+0x1c9/0x200
   seq_read_iter+0x63f/0x7c0
   seq_read+0x226/0x2d0
   vfs_read+0x113/0x2c0
   ksys_read+0xc9/0x170
   do_syscall_64+0x33/0x40
   entry_SYSCALL_64_after_hwframe+0x67/0xd1

Fix these issues by using `rcu_work` to help release
`svc_expkey`/`svc_export`. This approach allows for an asynchronous
context to invoke `path_put` and also facilitates the freeing of
`uuid/exp/key` after an RCU grace period.

Fixes: 9ceddd9da134 ("knfsd: Allow lockless lookups of the exports")
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Bin Lan <lanbincn@qq.com>
---
 fs/nfsd/export.c | 31 +++++++++++++++++++++++++------
 fs/nfsd/export.h |  4 ++--
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 39228bd7492a..78db46f6cbc6 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -40,15 +40,24 @@
 #define	EXPKEY_HASHMAX		(1 << EXPKEY_HASHBITS)
 #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
 
-static void expkey_put(struct kref *ref)
+static void expkey_put_work(struct work_struct *work)
 {
-	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
+	struct svc_expkey *key =
+		container_of(to_rcu_work(work), struct svc_expkey, ek_rcu_work);
 
 	if (test_bit(CACHE_VALID, &key->h.flags) &&
 	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
 		path_put(&key->ek_path);
 	auth_domain_put(key->ek_client);
-	kfree_rcu(key, ek_rcu);
+	kfree(key);
+}
+
+static void expkey_put(struct kref *ref)
+{
+	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
+
+	INIT_RCU_WORK(&key->ek_rcu_work, expkey_put_work);
+	queue_rcu_work(system_wq, &key->ek_rcu_work);
 }
 
 static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
@@ -351,16 +360,26 @@ static void export_stats_destroy(struct export_stats *stats)
 					     EXP_STATS_COUNTERS_NUM);
 }
 
-static void svc_export_put(struct kref *ref)
+static void svc_export_put_work(struct work_struct *work)
 {
-	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
+	struct svc_export *exp =
+		container_of(to_rcu_work(work), struct svc_export, ex_rcu_work);
+
 	path_put(&exp->ex_path);
 	auth_domain_put(exp->ex_client);
 	nfsd4_fslocs_free(&exp->ex_fslocs);
 	export_stats_destroy(exp->ex_stats);
 	kfree(exp->ex_stats);
 	kfree(exp->ex_uuid);
-	kfree_rcu(exp, ex_rcu);
+	kfree(exp);
+}
+
+static void svc_export_put(struct kref *ref)
+{
+	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
+
+	INIT_RCU_WORK(&exp->ex_rcu_work, svc_export_put_work);
+	queue_rcu_work(system_wq, &exp->ex_rcu_work);
 }
 
 static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index f73e23bb24a1..fa545d8dcc36 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -75,7 +75,7 @@ struct svc_export {
 	u32			ex_layout_types;
 	struct nfsd4_deviceid_map *ex_devid_map;
 	struct cache_detail	*cd;
-	struct rcu_head		ex_rcu;
+	struct rcu_work		ex_rcu_work;
 	struct export_stats	*ex_stats;
 };
 
@@ -91,7 +91,7 @@ struct svc_expkey {
 	u32			ek_fsid[6];
 
 	struct path		ek_path;
-	struct rcu_head		ek_rcu;
+	struct rcu_work		ek_rcu_work;
 };
 
 #define EX_ISSYNC(exp)		(!((exp)->ex_flags & NFSEXP_ASYNC))
-- 
2.43.0


