Return-Path: <stable+bounces-14860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2BA8382EB
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C991C295EE
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB705FEEE;
	Tue, 23 Jan 2024 01:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TFMfF0Fu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD145FDBB;
	Tue, 23 Jan 2024 01:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974662; cv=none; b=ndw7DI+Xuww1cUwKcDKncX+TW4pXi8eZ5MmhskJxhKkD9NDwvE8d2l+g7eE9urboWXB8LkseErvxlpI2AtWq9CsAr3qouZ3Kan7fG6Fb750k23MuiOwvM6bafw6uAfDNj0dIwagA9bVtC7xLim/xVRBy7Sdgwwpu5+WVM1xFuDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974662; c=relaxed/simple;
	bh=uqcDoSYQCRu13k0LnoxsJWbsnoWCWAklBr3ACg1sAvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHzdtAGXQNnmnDruV2i8xaQq16t4IWuZ55M5cYyz0Z3XJ0di3Gi0AhfBblXJihGfmTFmFVlZ5Zbi77VWQrRTFbe18rYrWZlqzf3db5X0g6hzyoGtWzeZbrbfNyX8lIvQE9bj9gQaf/rpt+9pXtxuxOMXJoseVi917QMR6xjxzh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TFMfF0Fu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F62C43390;
	Tue, 23 Jan 2024 01:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974661;
	bh=uqcDoSYQCRu13k0LnoxsJWbsnoWCWAklBr3ACg1sAvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TFMfF0Fu9m/e7jFckDtx200N4JCWLuSjXvn9e3mFV8WUTmxRN/SRLMJZQqfTbKUPi
	 p4YGpvxWjcwOpwULhb819hapoibnQ1Z83n1vMuNIJ+8bq1KJz5ZrlNkST+XdmSXVJK
	 Tu1svZextfaBszPjWdTs2aeqletXlFq55jEe0gys=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Sergey Gorenko <sergeygo@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 238/374] IB/iser: Prevent invalidating wrong MR
Date: Mon, 22 Jan 2024 15:58:14 -0800
Message-ID: <20240122235753.014043749@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 9f6ac0a09a78..35cc0a57e697 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -321,12 +321,10 @@ struct iser_device {
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
index 27a6f75a9912..9ea88dd6a414 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -602,7 +602,10 @@ iser_inv_desc(struct iser_fr_desc *desc, u32 rkey)
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
index 9776b755d848..c362043e7f17 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -250,7 +250,7 @@ iser_reg_sig_mr(struct iscsi_iser_task *iser_task,
 
 	iser_set_prot_checks(iser_task->sc, &sig_attrs->check_mask);
 
-	if (rsc->mr_valid)
+	if (rsc->sig_mr->need_inval)
 		iser_inv_rkey(&tx_desc->inv_wr, mr, cqe, &wr->wr);
 
 	ib_update_fast_reg_key(mr, ib_inc_rkey(mr->rkey));
@@ -274,7 +274,7 @@ iser_reg_sig_mr(struct iscsi_iser_task *iser_task,
 	wr->access = IB_ACCESS_LOCAL_WRITE |
 		     IB_ACCESS_REMOTE_READ |
 		     IB_ACCESS_REMOTE_WRITE;
-	rsc->mr_valid = 1;
+	rsc->sig_mr->need_inval = true;
 
 	sig_reg->sge.lkey = mr->lkey;
 	sig_reg->rkey = mr->rkey;
@@ -299,7 +299,7 @@ static int iser_fast_reg_mr(struct iscsi_iser_task *iser_task,
 	struct ib_reg_wr *wr = &tx_desc->reg_wr;
 	int n;
 
-	if (rsc->mr_valid)
+	if (rsc->mr->need_inval)
 		iser_inv_rkey(&tx_desc->inv_wr, mr, cqe, &wr->wr);
 
 	ib_update_fast_reg_key(mr, ib_inc_rkey(mr->rkey));
@@ -322,7 +322,7 @@ static int iser_fast_reg_mr(struct iscsi_iser_task *iser_task,
 		     IB_ACCESS_REMOTE_WRITE |
 		     IB_ACCESS_REMOTE_READ;
 
-	rsc->mr_valid = 1;
+	rsc->mr->need_inval = true;
 
 	reg->sge.lkey = mr->lkey;
 	reg->rkey = mr->rkey;
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index b566f7cb7797..8656664a15c5 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -136,7 +136,6 @@ iser_create_fastreg_desc(struct iser_device *device,
 			goto err_alloc_mr_integrity;
 		}
 	}
-	desc->rsc.mr_valid = 0;
 
 	return desc;
 
-- 
2.43.0




