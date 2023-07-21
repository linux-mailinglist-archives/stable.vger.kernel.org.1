Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160B675BF4E
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjGUHFc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjGUHFa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:05:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931F02D54
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:05:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E628D61337
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA372C433C7;
        Fri, 21 Jul 2023 07:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689923125;
        bh=ylkVOvK7r0BfymA82t8Vtsh+buUG337Crqjcnh/ZxXo=;
        h=Subject:To:Cc:From:Date:From;
        b=2iS8SGc9R+IdBNoOf6lErr8/wMJD6fBKYgXL/OFKvFUjzjt2JKShI25gDkAeKrZ6E
         m0DtEk0/YqOJiWj+JcDBI+SxFEh0M9azvGBpx4IifwocziGu/Y3kuIvNLaZykxzhb6
         bHkgi/Vpq7SmE/nqV88PY8HeK08qmtvxL6/Hdz28=
Subject: FAILED: patch "[PATCH] scsi: lpfc: Fix double free in lpfc_cmpl_els_logo_acc()" failed to apply to 5.15-stable tree
To:     justin.tee@broadcom.com, error27@gmail.com,
        martin.petersen@oracle.com, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:05:22 +0200
Message-ID: <2023072122-stumbling-unproven-d06f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 97f975823f8196d970bd795087b514271214677a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072122-stumbling-unproven-d06f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

97f975823f81 ("scsi: lpfc: Fix double free in lpfc_cmpl_els_logo_acc() caused by lpfc_nlp_not_used()")
d51cf5bd926c ("scsi: lpfc: Fix field overload in lpfc_iocbq data structure")
0e082d926f59 ("scsi: lpfc: SLI path split: Refactor BSG paths")
31a59f75702f ("scsi: lpfc: SLI path split: Refactor Abort paths")
3512ac094293 ("scsi: lpfc: SLI path split: Refactor SCSI paths")
61910d6a5243 ("scsi: lpfc: SLI path split: Refactor CT paths")
2d1928c57df6 ("scsi: lpfc: SLI path split: Refactor misc ELS paths")
351849800157 ("scsi: lpfc: SLI path split: Refactor VMID paths")
9d41f08aa2eb ("scsi: lpfc: SLI path split: Refactor FDISC paths")
e0367dfe90d6 ("scsi: lpfc: SLI path split: Refactor LS_RJT paths")
3f607dcb43f1 ("scsi: lpfc: SLI path split: Refactor LS_ACC paths")
3bea83b68d54 ("scsi: lpfc: SLI path split: Refactor the RSCN/SCR/RDF/EDC/FARPR paths")
cad93a089031 ("scsi: lpfc: SLI path split: Refactor PLOGI/PRLI/ADISC/LOGO paths")
6831ce129f19 ("scsi: lpfc: SLI path split: Refactor base ELS paths and the FLOGI path")
561341425bcc ("scsi: lpfc: SLI path split: Introduce lpfc_prep_wqe")
1b64aa9eae28 ("scsi: lpfc: SLI path split: Refactor fast and slow paths to native SLI4")
a680a9298e7b ("scsi: lpfc: SLI path split: Refactor lpfc_iocbq")
0956ba63bd94 ("scsi: lpfc: Fix non-recovery of remote ports following an unsolicited LOGO")
1854f53ccd88 ("scsi: lpfc: Fix link down processing to address NULL pointer dereference")
ec65e6beb02e ("Merge branch '5.15/scsi-fixes' into 5.16/scsi-staging")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 97f975823f8196d970bd795087b514271214677a Mon Sep 17 00:00:00 2001
From: Justin Tee <justin.tee@broadcom.com>
Date: Mon, 17 Apr 2023 12:15:53 -0700
Subject: [PATCH] scsi: lpfc: Fix double free in lpfc_cmpl_els_logo_acc()
 caused by lpfc_nlp_not_used()

Smatch detected a double free path because lpfc_nlp_not_used() releases an
ndlp object before reaching lpfc_nlp_put() at the end of
lpfc_cmpl_els_logo_acc().

Remove the outdated lpfc_nlp_not_used() routine.  In
lpfc_mbx_cmpl_ns_reg_login(), replace the call with lpfc_nlp_put().  In
lpfc_cmpl_els_logo_acc(), replace the call with lpfc_unreg_rpi() and keep
the lpfc_nlp_put() at the end of the routine.  If ndlp's rpi was
registered, then lpfc_unreg_rpi()'s completion routine performs the final
ndlp clean up after lpfc_nlp_put() is called from lpfc_cmpl_els_logo_acc().
Otherwise if ndlp has no rpi registered, the lpfc_nlp_put() at the end of
lpfc_cmpl_els_logo_acc() is the final ndlp clean up.

Fixes: 4430f7fd09ec ("scsi: lpfc: Rework locations of ndlp reference taking")
Cc: <stable@vger.kernel.org> # v5.11+
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/all/Y3OefhyyJNKH%2Fiaf@kili/
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20230417191558.83100-3-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index b833b983e69d..0b9edde26abd 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -134,7 +134,6 @@ void lpfc_check_nlp_post_devloss(struct lpfc_vport *vport,
 				 struct lpfc_nodelist *ndlp);
 void lpfc_ignore_els_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			  struct lpfc_iocbq *rspiocb);
-int  lpfc_nlp_not_used(struct lpfc_nodelist *ndlp);
 struct lpfc_nodelist *lpfc_setup_disc_node(struct lpfc_vport *, uint32_t);
 void lpfc_disc_list_loopmap(struct lpfc_vport *);
 void lpfc_disc_start(struct lpfc_vport *);
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 6a15f879e517..a3c8550e9985 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -5205,14 +5205,9 @@ lpfc_els_free_iocb(struct lpfc_hba *phba, struct lpfc_iocbq *elsiocb)
  *
  * This routine is the completion callback function to the Logout (LOGO)
  * Accept (ACC) Response ELS command. This routine is invoked to indicate
- * the completion of the LOGO process. It invokes the lpfc_nlp_not_used() to
- * release the ndlp if it has the last reference remaining (reference count
- * is 1). If succeeded (meaning ndlp released), it sets the iocb ndlp
- * field to NULL to inform the following lpfc_els_free_iocb() routine no
- * ndlp reference count needs to be decremented. Otherwise, the ndlp
- * reference use-count shall be decremented by the lpfc_els_free_iocb()
- * routine. Finally, the lpfc_els_free_iocb() is invoked to release the
- * IOCB data structure.
+ * the completion of the LOGO process. If the node has transitioned to NPR,
+ * this routine unregisters the RPI if it is still registered. The
+ * lpfc_els_free_iocb() is invoked to release the IOCB data structure.
  **/
 static void
 lpfc_cmpl_els_logo_acc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
@@ -5253,19 +5248,9 @@ lpfc_cmpl_els_logo_acc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		    (ndlp->nlp_last_elscmd == ELS_CMD_PLOGI))
 			goto out;
 
-		/* NPort Recovery mode or node is just allocated */
-		if (!lpfc_nlp_not_used(ndlp)) {
-			/* A LOGO is completing and the node is in NPR state.
-			 * Just unregister the RPI because the node is still
-			 * required.
-			 */
+		if (ndlp->nlp_flag & NLP_RPI_REGISTERED)
 			lpfc_unreg_rpi(vport, ndlp);
-		} else {
-			/* Indicate the node has already released, should
-			 * not reference to it from within lpfc_els_free_iocb.
-			 */
-			cmdiocb->ndlp = NULL;
-		}
+
 	}
  out:
 	/*
@@ -5285,9 +5270,8 @@ lpfc_cmpl_els_logo_acc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
  * RPI (Remote Port Index) mailbox command to the @phba. It simply releases
  * the associated lpfc Direct Memory Access (DMA) buffer back to the pool and
  * decrements the ndlp reference count held for this completion callback
- * function. After that, it invokes the lpfc_nlp_not_used() to check
- * whether there is only one reference left on the ndlp. If so, it will
- * perform one more decrement and trigger the release of the ndlp.
+ * function. After that, it invokes the lpfc_drop_node to check
+ * whether it is appropriate to release the node.
  **/
 void
 lpfc_mbx_cmpl_dflt_rpi(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 5ba3a9ad9501..67bfdddb897c 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -4333,13 +4333,14 @@ lpfc_mbx_cmpl_ns_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 
 		/* If the node is not registered with the scsi or nvme
 		 * transport, remove the fabric node.  The failed reg_login
-		 * is terminal.
+		 * is terminal and forces the removal of the last node
+		 * reference.
 		 */
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD))) {
 			spin_lock_irq(&ndlp->lock);
 			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
 			spin_unlock_irq(&ndlp->lock);
-			lpfc_nlp_not_used(ndlp);
+			lpfc_nlp_put(ndlp);
 		}
 
 		if (phba->fc_topology == LPFC_TOPOLOGY_LOOP) {
@@ -6704,25 +6705,6 @@ lpfc_nlp_put(struct lpfc_nodelist *ndlp)
 	return ndlp ? kref_put(&ndlp->kref, lpfc_nlp_release) : 0;
 }
 
-/* This routine free's the specified nodelist if it is not in use
- * by any other discovery thread. This routine returns 1 if the
- * ndlp has been freed. A return value of 0 indicates the ndlp is
- * not yet been released.
- */
-int
-lpfc_nlp_not_used(struct lpfc_nodelist *ndlp)
-{
-	lpfc_debugfs_disc_trc(ndlp->vport, LPFC_DISC_TRC_NODE,
-		"node not used:   did:x%x flg:x%x refcnt:x%x",
-		ndlp->nlp_DID, ndlp->nlp_flag,
-		kref_read(&ndlp->kref));
-
-	if (kref_read(&ndlp->kref) == 1)
-		if (lpfc_nlp_put(ndlp))
-			return 1;
-	return 0;
-}
-
 /**
  * lpfc_fcf_inuse - Check if FCF can be unregistered.
  * @phba: Pointer to hba context object.

