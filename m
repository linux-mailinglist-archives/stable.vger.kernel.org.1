Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0CA7ECD06
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjKOTeA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbjKOTdz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:33:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC79D1BD
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:33:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99546C433C7;
        Wed, 15 Nov 2023 19:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076830;
        bh=WOk78VvdMoN96dfhr1QCkhx0QZwx4fzD3AyiIKnvjqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nf9n5K1SUZ24wMnwnHIoewZmvvO8LaU7BHGHjBgPLZyVAkOmSAtSLkV0TGuFOkK31
         ytkbQtns7PDZBnIVOxHYjdGv+nuz2GzdnsIIQCGzob65Zp5CWOCZtcUCrt1NN5B/EU
         m6Rdahqa4cThJeW4SpBN+9mzuvwOThy2iDSuBFcU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Haren Myneni <haren@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 436/550] powerpc/vas: Limit open window failure messages in log bufffer
Date:   Wed, 15 Nov 2023 14:17:00 -0500
Message-ID: <20231115191630.997009553@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haren Myneni <haren@linux.ibm.com>

[ Upstream commit 73b25505ce043b561028e5571d84dc82aa53c2b4 ]

The VAS open window call prints error message and returns -EBUSY
after the migration suspend event initiated and until the resume
event completed on the destination system. It can cause the log
buffer filled with these error messages if the user space issues
continuous open window calls.  Similar case even for DLPAR CPU
remove event when no credits are available until the credits are
freed or with the other DLPAR CPU add event.

So changes in the patch to use pr_err_ratelimited() instead of
pr_err() to display open window failure and not-available credits
error messages.

Use pr_fmt() and make the corresponding changes to have the
consistencein prefix all pr_*() messages (vas-api.c).

Fixes: 37e6764895ef ("powerpc/pseries/vas: Add VAS migration handler")
Signed-off-by: Haren Myneni <haren@linux.ibm.com>
[mpe: Use "vas-api" as the prefix to match the file name.]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231019215033.1335251-1-haren@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/book3s/vas-api.c | 34 ++++++++++++-------------
 arch/powerpc/platforms/pseries/vas.c    |  4 +--
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/book3s/vas-api.c b/arch/powerpc/platforms/book3s/vas-api.c
index 77ea9335fd049..f381b177ea06a 100644
--- a/arch/powerpc/platforms/book3s/vas-api.c
+++ b/arch/powerpc/platforms/book3s/vas-api.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2019 Haren Myneni, IBM Corp
  */
 
+#define pr_fmt(fmt)	"vas-api: " fmt
+
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
@@ -78,7 +80,7 @@ int get_vas_user_win_ref(struct vas_user_win_ref *task_ref)
 	task_ref->mm = get_task_mm(current);
 	if (!task_ref->mm) {
 		put_pid(task_ref->pid);
-		pr_err("VAS: pid(%d): mm_struct is not found\n",
+		pr_err("pid(%d): mm_struct is not found\n",
 				current->pid);
 		return -EPERM;
 	}
@@ -235,8 +237,7 @@ void vas_update_csb(struct coprocessor_request_block *crb,
 	rc = kill_pid_info(SIGSEGV, &info, pid);
 	rcu_read_unlock();
 
-	pr_devel("%s(): pid %d kill_proc_info() rc %d\n", __func__,
-			pid_vnr(pid), rc);
+	pr_devel("pid %d kill_proc_info() rc %d\n", pid_vnr(pid), rc);
 }
 
 void vas_dump_crb(struct coprocessor_request_block *crb)
@@ -294,7 +295,7 @@ static int coproc_ioc_tx_win_open(struct file *fp, unsigned long arg)
 
 	rc = copy_from_user(&uattr, uptr, sizeof(uattr));
 	if (rc) {
-		pr_err("%s(): copy_from_user() returns %d\n", __func__, rc);
+		pr_err("copy_from_user() returns %d\n", rc);
 		return -EFAULT;
 	}
 
@@ -311,7 +312,7 @@ static int coproc_ioc_tx_win_open(struct file *fp, unsigned long arg)
 	txwin = cp_inst->coproc->vops->open_win(uattr.vas_id, uattr.flags,
 						cp_inst->coproc->cop_type);
 	if (IS_ERR(txwin)) {
-		pr_err("%s() VAS window open failed, %ld\n", __func__,
+		pr_err_ratelimited("VAS window open failed rc=%ld\n",
 				PTR_ERR(txwin));
 		return PTR_ERR(txwin);
 	}
@@ -405,8 +406,7 @@ static vm_fault_t vas_mmap_fault(struct vm_fault *vmf)
 	 * window is not opened. Shouldn't expect this error.
 	 */
 	if (!cp_inst || !cp_inst->txwin) {
-		pr_err("%s(): Unexpected fault on paste address with TX window closed\n",
-				__func__);
+		pr_err("Unexpected fault on paste address with TX window closed\n");
 		return VM_FAULT_SIGBUS;
 	}
 
@@ -421,8 +421,7 @@ static vm_fault_t vas_mmap_fault(struct vm_fault *vmf)
 	 * issue NX request.
 	 */
 	if (txwin->task_ref.vma != vmf->vma) {
-		pr_err("%s(): No previous mapping with paste address\n",
-			__func__);
+		pr_err("No previous mapping with paste address\n");
 		return VM_FAULT_SIGBUS;
 	}
 
@@ -481,19 +480,19 @@ static int coproc_mmap(struct file *fp, struct vm_area_struct *vma)
 	txwin = cp_inst->txwin;
 
 	if ((vma->vm_end - vma->vm_start) > PAGE_SIZE) {
-		pr_debug("%s(): size 0x%zx, PAGE_SIZE 0x%zx\n", __func__,
+		pr_debug("size 0x%zx, PAGE_SIZE 0x%zx\n",
 				(vma->vm_end - vma->vm_start), PAGE_SIZE);
 		return -EINVAL;
 	}
 
 	/* Ensure instance has an open send window */
 	if (!txwin) {
-		pr_err("%s(): No send window open?\n", __func__);
+		pr_err("No send window open?\n");
 		return -EINVAL;
 	}
 
 	if (!cp_inst->coproc->vops || !cp_inst->coproc->vops->paste_addr) {
-		pr_err("%s(): VAS API is not registered\n", __func__);
+		pr_err("VAS API is not registered\n");
 		return -EACCES;
 	}
 
@@ -510,14 +509,14 @@ static int coproc_mmap(struct file *fp, struct vm_area_struct *vma)
 	 */
 	mutex_lock(&txwin->task_ref.mmap_mutex);
 	if (txwin->status != VAS_WIN_ACTIVE) {
-		pr_err("%s(): Window is not active\n", __func__);
+		pr_err("Window is not active\n");
 		rc = -EACCES;
 		goto out;
 	}
 
 	paste_addr = cp_inst->coproc->vops->paste_addr(txwin);
 	if (!paste_addr) {
-		pr_err("%s(): Window paste address failed\n", __func__);
+		pr_err("Window paste address failed\n");
 		rc = -EINVAL;
 		goto out;
 	}
@@ -533,8 +532,8 @@ static int coproc_mmap(struct file *fp, struct vm_area_struct *vma)
 	rc = remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
 			vma->vm_end - vma->vm_start, prot);
 
-	pr_devel("%s(): paste addr %llx at %lx, rc %d\n", __func__,
-			paste_addr, vma->vm_start, rc);
+	pr_devel("paste addr %llx at %lx, rc %d\n", paste_addr,
+			vma->vm_start, rc);
 
 	txwin->task_ref.vma = vma;
 	vma->vm_ops = &vas_vm_ops;
@@ -609,8 +608,7 @@ int vas_register_coproc_api(struct module *mod, enum vas_cop_type cop_type,
 		goto err;
 	}
 
-	pr_devel("%s: Added dev [%d,%d]\n", __func__, MAJOR(devno),
-			MINOR(devno));
+	pr_devel("Added dev [%d,%d]\n", MAJOR(devno), MINOR(devno));
 
 	return 0;
 
diff --git a/arch/powerpc/platforms/pseries/vas.c b/arch/powerpc/platforms/pseries/vas.c
index 3fbc2a6aa319d..23d1637242682 100644
--- a/arch/powerpc/platforms/pseries/vas.c
+++ b/arch/powerpc/platforms/pseries/vas.c
@@ -340,7 +340,7 @@ static struct vas_window *vas_allocate_window(int vas_id, u64 flags,
 
 	if (atomic_inc_return(&cop_feat_caps->nr_used_credits) >
 			atomic_read(&cop_feat_caps->nr_total_credits)) {
-		pr_err("Credits are not available to allocate window\n");
+		pr_err_ratelimited("Credits are not available to allocate window\n");
 		rc = -EINVAL;
 		goto out;
 	}
@@ -423,7 +423,7 @@ static struct vas_window *vas_allocate_window(int vas_id, u64 flags,
 
 	put_vas_user_win_ref(&txwin->vas_win.task_ref);
 	rc = -EBUSY;
-	pr_err("No credit is available to allocate window\n");
+	pr_err_ratelimited("No credit is available to allocate window\n");
 
 out_free:
 	/*
-- 
2.42.0



