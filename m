Return-Path: <stable+bounces-13524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A50837C76
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31676281202
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91921353EC;
	Tue, 23 Jan 2024 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EnN3IGRj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B7842A8C;
	Tue, 23 Jan 2024 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969625; cv=none; b=HjgKocf1xOWzHvbMPIlDDFTpnrV+fyAXEZMYIB110dRjCLIW6OECOh0nuyrAqogcqSM50UDXGCkUFsfR3vxKYJGQY1EGHrpoIpLS18lLOAXjtXFzF169C/mqXveSkEHm+xBipqZG1K5bl4PUTL4v5YwY2T0J6GjGzp+HFH1QCLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969625; c=relaxed/simple;
	bh=XmqnJUFGr0GtEW0CAmI70tqSsj8QbOmoJW+Qr4enqKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uf5rRq0DIuXEBVB9jm7yaB+eRYAgQmPSTBOV7lRT9fjBOUTwFKWvE79PxkVlFKurVB/f8750lfNMBbGJ8rAC9FrLKlsRJe4XEZpIYNzkw1yf1u5hczZeXqxuIFyyCXoq2Jxf+ycoJvLSPG4OnHTW0EH6bvqk4ZN+yjPobJh+H4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EnN3IGRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9FCC433F1;
	Tue, 23 Jan 2024 00:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969625;
	bh=XmqnJUFGr0GtEW0CAmI70tqSsj8QbOmoJW+Qr4enqKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EnN3IGRjfmpGxnmt+pnAbfWXMJhF9cfitPc92M6ql4+qg7OLhqaHiQ4pYTOpjglmK
	 6ugDWSNc+4n1flNEjijQrZZb2AEUVFAKVnNLiO5uKqlnzsi/+ptllljAQtyJ17Ggm5
	 2D8VEvuPzinRkd/k4IHsUCs/M5VeqsictPNNqNVI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Sergey Gorenko <sergeygo@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 366/641] IB/iser: Prevent invalidating wrong MR
Date: Mon, 22 Jan 2024 15:54:30 -0800
Message-ID: <20240122235829.404767763@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Gorenko <sergeygo@nvidia.com>

[ Upstream commit 2f1888281e67205bd80d3e8f54dbd519a9653f26 ]

The iser_reg_resources structure has two pointers to MR but only one
mr_valid field. The implementation assumes that we use only *sig_mr when
pi_enable is true. Otherwise, we use only *mr. However, it is only
sometimes correct. Read commands without protection information occur even
when pi_enble is true. For example, the following SCSI commands have a
Data-In buffer but never have protection information: READ CAPACITY (16),
INQUIRY, MODE SENSE(6), MAINTENANCE IN. So, we use
*sig_mr for some SCSI commands and *mr for the other SCSI commands.

In most cases, it works fine because the remote invalidation is applied.
However, there are two cases when the remote invalidation is not
applicable.
 1. Small write commands when all data is sent as an immediate.
 2. The target does not support the remote invalidation feature.

The lazy invalidation is used if the remote invalidation is impossible.
Since, at the lazy invalidation, we always invalidate the MR we want to
use, the wrong MR may be invalidated.

To fix the issue, we need a field per MR that indicates the MR needs
invalidation. Since the ib_mr structure already has such a field, let's
use ib_mr.need_inval instead of iser_reg_resources.mr_valid.

Fixes: b76a439982f8 ("IB/iser: Use IB_WR_REG_MR_INTEGRITY for PI handover")
Link: https://lore.kernel.org/r/20231219072311.40989-1-sergeygo@nvidia.com
Acked-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Sergey Gorenko <sergeygo@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/iser/iscsi_iser.h     | 2 --
 drivers/infiniband/ulp/iser/iser_initiator.c | 5 ++++-
 drivers/infiniband/ulp/iser/iser_memory.c    | 8 ++++----
 drivers/infiniband/ulp/iser/iser_verbs.c     | 1 -
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index dee8c97ff056..d967d5532459 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -317,12 +317,10 @@ struct iser_device {
  *
  * @mr:         memory region
  * @sig_mr:     signature memory region
- * @mr_valid:   is mr valid indicator
  */
 struct iser_reg_resources {
 	struct ib_mr                     *mr;
 	struct ib_mr                     *sig_mr;
-	u8				  mr_valid:1;
 };
 
 /**
diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
index 39ea73f69016..f5f090dc4f1e 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -581,7 +581,10 @@ static inline int iser_inv_desc(struct iser_fr_desc *desc, u32 rkey)
 		return -EINVAL;
 	}
 
-	desc->rsc.mr_valid = 0;
+	if (desc->sig_protected)
+		desc->rsc.sig_mr->need_inval = false;
+	else
+		desc->rsc.mr->need_inval = false;
 
 	return 0;
 }
diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index 29ae2c6a250a..6efcb79c8efe 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -264,7 +264,7 @@ static int iser_reg_sig_mr(struct iscsi_iser_task *iser_task,
 
 	iser_set_prot_checks(iser_task->sc, &sig_attrs->check_mask);
 
-	if (rsc->mr_valid)
+	if (rsc->sig_mr->need_inval)
 		iser_inv_rkey(&tx_desc->inv_wr, mr, cqe, &wr->wr);
 
 	ib_update_fast_reg_key(mr, ib_inc_rkey(mr->rkey));
@@ -288,7 +288,7 @@ static int iser_reg_sig_mr(struct iscsi_iser_task *iser_task,
 	wr->access = IB_ACCESS_LOCAL_WRITE |
 		     IB_ACCESS_REMOTE_READ |
 		     IB_ACCESS_REMOTE_WRITE;
-	rsc->mr_valid = 1;
+	rsc->sig_mr->need_inval = true;
 
 	sig_reg->sge.lkey = mr->lkey;
 	sig_reg->rkey = mr->rkey;
@@ -313,7 +313,7 @@ static int iser_fast_reg_mr(struct iscsi_iser_task *iser_task,
 	struct ib_reg_wr *wr = &tx_desc->reg_wr;
 	int n;
 
-	if (rsc->mr_valid)
+	if (rsc->mr->need_inval)
 		iser_inv_rkey(&tx_desc->inv_wr, mr, cqe, &wr->wr);
 
 	ib_update_fast_reg_key(mr, ib_inc_rkey(mr->rkey));
@@ -336,7 +336,7 @@ static int iser_fast_reg_mr(struct iscsi_iser_task *iser_task,
 		     IB_ACCESS_REMOTE_WRITE |
 		     IB_ACCESS_REMOTE_READ;
 
-	rsc->mr_valid = 1;
+	rsc->mr->need_inval = true;
 
 	reg->sge.lkey = mr->lkey;
 	reg->rkey = mr->rkey;
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index 95b8eebf7e04..6801b70dc9e0 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -129,7 +129,6 @@ iser_create_fastreg_desc(struct iser_device *device,
 			goto err_alloc_mr_integrity;
 		}
 	}
-	desc->rsc.mr_valid = 0;
 
 	return desc;
 
-- 
2.43.0




