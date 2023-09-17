Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118827A390C
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239933AbjIQToE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239964AbjIQTns (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:43:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF86DB
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:43:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF10C433C8;
        Sun, 17 Sep 2023 19:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979822;
        bh=IhGXr0g6XvYQARCbeRx4gTyRHRK7OujvTCkrP5BsfHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1sExpdvwPByzNeBmYuQmu3ENuARBWmSAJi9DrknvqbiPT8X0a5d345/H0+AWJPBpK
         r3bREvjFcuQLQiD0j7RA9cspHUZw0I80VqaA/FBjq+Yb4YSe7fTpJ8UraR96hCH4/0
         uXaxZGl6538CR5PwdBNOtHkFBPQ78MibMsMVNF+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.5 017/285] scsi: qla2xxx: Fix firmware resource tracking
Date:   Sun, 17 Sep 2023 21:10:17 +0200
Message-ID: <20230917191052.218158876@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <qutran@marvell.com>

commit e370b64c7db96384a0886a09a9d80406e4c663d7 upstream.

The storage was not draining I/Os and the work load was not spread out
across different CPUs evenly. This led to firmware resource counters
getting overrun on the busy CPU. This overrun prevented error recovery from
happening in a timely manner.

By switching the counter to atomic, it allows the count to be little more
accurate to prevent the overrun.

Cc: stable@vger.kernel.org
Fixes: da7c21b72aa8 ("scsi: qla2xxx: Fix command flush during TMF")
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230821130045.34850-4-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_def.h    |   11 +++++++
 drivers/scsi/qla2xxx/qla_dfs.c    |   10 ++++++
 drivers/scsi/qla2xxx/qla_init.c   |    8 +++++
 drivers/scsi/qla2xxx/qla_inline.h |   57 +++++++++++++++++++++++++++++++++++++-
 drivers/scsi/qla2xxx/qla_os.c     |    5 ++-
 5 files changed, 88 insertions(+), 3 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -3742,6 +3742,16 @@ struct qla_fw_resources {
 	u16 pad;
 };
 
+struct qla_fw_res {
+	u16      iocb_total;
+	u16      iocb_limit;
+	atomic_t iocb_used;
+
+	u16      exch_total;
+	u16      exch_limit;
+	atomic_t exch_used;
+};
+
 #define QLA_IOCB_PCT_LIMIT 95
 
 struct  qla_buf_pool {
@@ -4799,6 +4809,7 @@ struct qla_hw_data {
 	struct els_reject elsrej;
 	u8 edif_post_stop_cnt_down;
 	struct qla_vp_map *vp_map;
+	struct qla_fw_res fwres ____cacheline_aligned;
 };
 
 #define RX_ELS_SIZE (roundup(sizeof(struct enode) + ELS_MAX_PAYLOAD, SMP_CACHE_BYTES))
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -276,6 +276,16 @@ qla_dfs_fw_resource_cnt_show(struct seq_
 
 		seq_printf(s, "estimate exchange used[%d] high water limit [%d] n",
 			   exch_used, ha->base_qpair->fwres.exch_limit);
+
+		if (ql2xenforce_iocb_limit == 2) {
+			iocbs_used = atomic_read(&ha->fwres.iocb_used);
+			exch_used  = atomic_read(&ha->fwres.exch_used);
+			seq_printf(s, "        estimate iocb2 used [%d] high water limit [%d]\n",
+					iocbs_used, ha->fwres.iocb_limit);
+
+			seq_printf(s, "        estimate exchange2 used[%d] high water limit [%d] \n",
+					exch_used, ha->fwres.exch_limit);
+		}
 	}
 
 	return 0;
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4216,6 +4216,14 @@ void qla_init_iocb_limit(scsi_qla_host_t
 			ha->queue_pair_map[i]->fwres.exch_used = 0;
 		}
 	}
+
+	ha->fwres.iocb_total = ha->orig_fw_iocb_count;
+	ha->fwres.iocb_limit = (ha->orig_fw_iocb_count * QLA_IOCB_PCT_LIMIT) / 100;
+	ha->fwres.exch_total = ha->orig_fw_xcb_count;
+	ha->fwres.exch_limit = (ha->orig_fw_xcb_count * QLA_IOCB_PCT_LIMIT) / 100;
+
+	atomic_set(&ha->fwres.iocb_used, 0);
+	atomic_set(&ha->fwres.exch_used, 0);
 }
 
 void qla_adjust_iocb_limit(scsi_qla_host_t *vha)
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -386,6 +386,7 @@ enum {
 	RESOURCE_IOCB = BIT_0,
 	RESOURCE_EXCH = BIT_1,  /* exchange */
 	RESOURCE_FORCE = BIT_2,
+	RESOURCE_HA = BIT_3,
 };
 
 static inline int
@@ -393,7 +394,7 @@ qla_get_fw_resources(struct qla_qpair *q
 {
 	u16 iocbs_used, i;
 	u16 exch_used;
-	struct qla_hw_data *ha = qp->vha->hw;
+	struct qla_hw_data *ha = qp->hw;
 
 	if (!ql2xenforce_iocb_limit) {
 		iores->res_type = RESOURCE_NONE;
@@ -428,15 +429,69 @@ qla_get_fw_resources(struct qla_qpair *q
 			return -ENOSPC;
 		}
 	}
+
+	if (ql2xenforce_iocb_limit == 2) {
+		if ((iores->iocb_cnt + atomic_read(&ha->fwres.iocb_used)) >=
+		    ha->fwres.iocb_limit) {
+			iores->res_type = RESOURCE_NONE;
+			return -ENOSPC;
+		}
+
+		if (iores->res_type & RESOURCE_EXCH) {
+			if ((iores->exch_cnt + atomic_read(&ha->fwres.exch_used)) >=
+			    ha->fwres.exch_limit) {
+				iores->res_type = RESOURCE_NONE;
+				return -ENOSPC;
+			}
+		}
+	}
+
 force:
 	qp->fwres.iocbs_used += iores->iocb_cnt;
 	qp->fwres.exch_used += iores->exch_cnt;
+	if (ql2xenforce_iocb_limit == 2) {
+		atomic_add(iores->iocb_cnt, &ha->fwres.iocb_used);
+		atomic_add(iores->exch_cnt, &ha->fwres.exch_used);
+		iores->res_type |= RESOURCE_HA;
+	}
 	return 0;
 }
 
+/*
+ * decrement to zero.  This routine will not decrement below zero
+ * @v:  pointer of type atomic_t
+ * @amount: amount to decrement from v
+ */
+static void qla_atomic_dtz(atomic_t *v, int amount)
+{
+	int c, old, dec;
+
+	c = atomic_read(v);
+	for (;;) {
+		dec = c - amount;
+		if (unlikely(dec < 0))
+			dec = 0;
+
+		old = atomic_cmpxchg((v), c, dec);
+		if (likely(old == c))
+			break;
+		c = old;
+	}
+}
+
 static inline void
 qla_put_fw_resources(struct qla_qpair *qp, struct iocb_resource *iores)
 {
+	struct qla_hw_data *ha = qp->hw;
+
+	if (iores->res_type & RESOURCE_HA) {
+		if (iores->res_type & RESOURCE_IOCB)
+			qla_atomic_dtz(&ha->fwres.iocb_used, iores->iocb_cnt);
+
+		if (iores->res_type & RESOURCE_EXCH)
+			qla_atomic_dtz(&ha->fwres.exch_used, iores->exch_cnt);
+	}
+
 	if (iores->res_type & RESOURCE_IOCB) {
 		if (qp->fwres.iocbs_used >= iores->iocb_cnt) {
 			qp->fwres.iocbs_used -= iores->iocb_cnt;
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -44,10 +44,11 @@ module_param(ql2xfulldump_on_mpifail, in
 MODULE_PARM_DESC(ql2xfulldump_on_mpifail,
 		 "Set this to take full dump on MPI hang.");
 
-int ql2xenforce_iocb_limit = 1;
+int ql2xenforce_iocb_limit = 2;
 module_param(ql2xenforce_iocb_limit, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(ql2xenforce_iocb_limit,
-		 "Enforce IOCB throttling, to avoid FW congestion. (default: 1)");
+		 "Enforce IOCB throttling, to avoid FW congestion. (default: 2) "
+		 "1: track usage per queue, 2: track usage per adapter");
 
 /*
  * CT6 CTX allocation cache


