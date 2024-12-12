Return-Path: <stable+bounces-101976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155409EF04B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ECD2173AFD
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7639223C66;
	Thu, 12 Dec 2024 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wMK6c+lY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71926223C62;
	Thu, 12 Dec 2024 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019492; cv=none; b=H3OUNzep4TomWECNX5HBA2lb/3EcHjcPIEaaJYtLdvYJsk9/N2E6QlgK2wFlrxdeayuseLtCq7Af2eZ/bAXakqPbVnNN71D5JwWZ81HhqAJ+ZTUPEBXXcBKWi32oSTEbw6SgI92bP0ej2avvAKyHE1VQ65Y9GFMZJ6hw+SvQIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019492; c=relaxed/simple;
	bh=tiokdeQSHi7UjmI1S9Om51gdvkN7Zk0EvAcu7SXFomU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtsYDsaXbTsS84e9tdfVoibWzMM3p3G4JuhsmmH96fl0cl8tJ2yb+BzCFYKQwo9DPMv8nuJDAhk3RbEDuD03Tx/fvqg3drnIJADPjV5sd3eS+PO0wi0K5O71IDKx9hnepoAOpZboAMyFXrVLBz2jwIu2IO1+wwzLTkOPXS8M388=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wMK6c+lY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06AEC4CECE;
	Thu, 12 Dec 2024 16:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734019492;
	bh=tiokdeQSHi7UjmI1S9Om51gdvkN7Zk0EvAcu7SXFomU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wMK6c+lYurRpTlDBJKoiCcb9kOoyh01n4rJ3zHHeYX1xtoXhEO8OSmdsF7XOl55SZ
	 vXcJnJZl1YE4tPBVY1WzOhBwU2Wb0/L50UM4Atj82Xr6Rth7UDEH3zhWBLKVIcnJBH
	 7OCMvZqO4L5U+Lxi4BcOoTenA0Do9czANR481NjQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kajol Jain <kjain@linux.ibm.com>,
	"Nysal Jan K.A" <nysal@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 220/772] powerpc/pseries: Fix dtl_access_lock to be a rw_semaphore
Date: Thu, 12 Dec 2024 15:52:45 +0100
Message-ID: <20241212144359.002684329@linuxfoundation.org>
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

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit cadae3a45d23aa4f6485938a67cbc47aaaa25e38 ]

The dtl_access_lock needs to be a rw_sempahore, a sleeping lock, because
the code calls kmalloc() while holding it, which can sleep:

  # echo 1 > /proc/powerpc/vcpudispatch_stats
  BUG: sleeping function called from invalid context at include/linux/sched/mm.h:337
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 199, name: sh
  preempt_count: 1, expected: 0
  3 locks held by sh/199:
   #0: c00000000a0743f8 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x324/0x438
   #1: c0000000028c7058 (dtl_enable_mutex){+.+.}-{3:3}, at: vcpudispatch_stats_write+0xd4/0x5f4
   #2: c0000000028c70b8 (dtl_access_lock){+.+.}-{2:2}, at: vcpudispatch_stats_write+0x220/0x5f4
  CPU: 0 PID: 199 Comm: sh Not tainted 6.10.0-rc4 #152
  Hardware name: IBM pSeries (emulated by qemu) POWER9 (raw) 0x4e1202 0xf000005 of:SLOF,HEAD hv:linux,kvm pSeries
  Call Trace:
    dump_stack_lvl+0x130/0x148 (unreliable)
    __might_resched+0x174/0x410
    kmem_cache_alloc_noprof+0x340/0x3d0
    alloc_dtl_buffers+0x124/0x1ac
    vcpudispatch_stats_write+0x2a8/0x5f4
    proc_reg_write+0xf4/0x150
    vfs_write+0xfc/0x438
    ksys_write+0x88/0x148
    system_call_exception+0x1c4/0x5a0
    system_call_common+0xf4/0x258

Fixes: 06220d78f24a ("powerpc/pseries: Introduce rwlock to gatekeep DTLB usage")
Tested-by: Kajol Jain <kjain@linux.ibm.com>
Reviewed-by: Nysal Jan K.A <nysal@linux.ibm.com>
Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://patch.msgid.link/20240819122401.513203-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/dtl.h        | 4 ++--
 arch/powerpc/platforms/pseries/dtl.c  | 8 ++++----
 arch/powerpc/platforms/pseries/lpar.c | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/dtl.h b/arch/powerpc/include/asm/dtl.h
index 4bcb9f9ac7649..859af5de3c2f9 100644
--- a/arch/powerpc/include/asm/dtl.h
+++ b/arch/powerpc/include/asm/dtl.h
@@ -1,8 +1,8 @@
 #ifndef _ASM_POWERPC_DTL_H
 #define _ASM_POWERPC_DTL_H
 
+#include <linux/rwsem.h>
 #include <asm/lppaca.h>
-#include <linux/spinlock_types.h>
 
 /*
  * Layout of entries in the hypervisor's dispatch trace log buffer.
@@ -35,7 +35,7 @@ struct dtl_entry {
 #define DTL_LOG_ALL		(DTL_LOG_CEDE | DTL_LOG_PREEMPT | DTL_LOG_FAULT)
 
 extern struct kmem_cache *dtl_cache;
-extern rwlock_t dtl_access_lock;
+extern struct rw_semaphore dtl_access_lock;
 
 extern void register_dtl_buffer(int cpu);
 extern void alloc_dtl_buffers(unsigned long *time_limit);
diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index 3f1cdccebc9c1..ecc04ef8c53e3 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -191,7 +191,7 @@ static int dtl_enable(struct dtl *dtl)
 		return -EBUSY;
 
 	/* ensure there are no other conflicting dtl users */
-	if (!read_trylock(&dtl_access_lock))
+	if (!down_read_trylock(&dtl_access_lock))
 		return -EBUSY;
 
 	n_entries = dtl_buf_entries;
@@ -199,7 +199,7 @@ static int dtl_enable(struct dtl *dtl)
 	if (!buf) {
 		printk(KERN_WARNING "%s: buffer alloc failed for cpu %d\n",
 				__func__, dtl->cpu);
-		read_unlock(&dtl_access_lock);
+		up_read(&dtl_access_lock);
 		return -ENOMEM;
 	}
 
@@ -217,7 +217,7 @@ static int dtl_enable(struct dtl *dtl)
 	spin_unlock(&dtl->lock);
 
 	if (rc) {
-		read_unlock(&dtl_access_lock);
+		up_read(&dtl_access_lock);
 		kmem_cache_free(dtl_cache, buf);
 	}
 
@@ -232,7 +232,7 @@ static void dtl_disable(struct dtl *dtl)
 	dtl->buf = NULL;
 	dtl->buf_entries = 0;
 	spin_unlock(&dtl->lock);
-	read_unlock(&dtl_access_lock);
+	up_read(&dtl_access_lock);
 }
 
 /* file interface */
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 29d235b02f062..98f8e0a39eb2f 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -167,7 +167,7 @@ struct vcpu_dispatch_data {
  */
 #define NR_CPUS_H	NR_CPUS
 
-DEFINE_RWLOCK(dtl_access_lock);
+DECLARE_RWSEM(dtl_access_lock);
 static DEFINE_PER_CPU(struct vcpu_dispatch_data, vcpu_disp_data);
 static DEFINE_PER_CPU(u64, dtl_entry_ridx);
 static DEFINE_PER_CPU(struct dtl_worker, dtl_workers);
@@ -461,7 +461,7 @@ static int dtl_worker_enable(unsigned long *time_limit)
 {
 	int rc = 0, state;
 
-	if (!write_trylock(&dtl_access_lock)) {
+	if (!down_write_trylock(&dtl_access_lock)) {
 		rc = -EBUSY;
 		goto out;
 	}
@@ -477,7 +477,7 @@ static int dtl_worker_enable(unsigned long *time_limit)
 		pr_err("vcpudispatch_stats: unable to setup workqueue for DTL processing\n");
 		free_dtl_buffers(time_limit);
 		reset_global_dtl_mask();
-		write_unlock(&dtl_access_lock);
+		up_write(&dtl_access_lock);
 		rc = -EINVAL;
 		goto out;
 	}
@@ -492,7 +492,7 @@ static void dtl_worker_disable(unsigned long *time_limit)
 	cpuhp_remove_state(dtl_worker_state);
 	free_dtl_buffers(time_limit);
 	reset_global_dtl_mask();
-	write_unlock(&dtl_access_lock);
+	up_write(&dtl_access_lock);
 }
 
 static ssize_t vcpudispatch_stats_write(struct file *file, const char __user *p,
-- 
2.43.0




