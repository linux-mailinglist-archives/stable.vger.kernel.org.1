Return-Path: <stable+bounces-124373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B85A60297
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6829217CD7F
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7051F4180;
	Thu, 13 Mar 2025 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHVkOuA3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3947E1F4604
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897581; cv=none; b=rQpriu7m4kZ1yXjVx+VanOdN+SAHYnfGzQjAkRIiISAWfOqtbKgUhmlx1gJGh8qPzt7tOa4Is91waehePWAgS6LjAMnAFf+9zCNmaDUm0QyMheo8DYGOQ3fFp2XOS2IXG5Xj0vd5lOlNTbdb0LUSFRyJqIGA2WpofL4hfZPnTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897581; c=relaxed/simple;
	bh=oTNT3zrlZX7ZHQxz7WjuwUoTuD8vhbI4nv7nMycwUQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcFr3RzFDPOKNdspy/b/yDqoLV2M0JpLiVUgSez59pMKyZSGwIr713KFWxFVw0BSX72BPwsfomGFxvSq2/jaZXf5L9YU9c88v/okEhhfNvPjvB395xopZqtyPtdoSzkikxbf1kpPjUPbL1bf/L//8j4IoeLqAhscCqhIUsMC1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHVkOuA3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22398e09e39so30288385ad.3
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897579; x=1742502379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVpYRjFmGfIvAowYm40B4QrYHOxDCydefnDPUi9Uy80=;
        b=nHVkOuA3RbifpJumMbcySXHtnj0J/6lxoBWlWMofwJZqri1ajy+fd/XzoJ+lPllHWN
         Q61QBceoCAqCnSNXwIrYhK5vv5y4qwG63oMwF+KWj2VuQai53FudjaoQM3oQ+8xanE2E
         xNvjN3vraQx0HfjpN2spOC6SqAXZh9iwzsvJ9RWllmrEc9uD0pWaBc5mCCLIk6KB0PrL
         iGQXLiIdsfbWgxdgg2efZPA69183o48uLAcFwHlKO+uYO+PvjzKnWU5nVWeDHEEbjVJP
         9qHfMO3gBuUnaAkHNG1FbqkEoF6LpkRyvokDn1ePPB9oO68vwuMNVTwXnfHAWIxRNhnA
         7ylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897579; x=1742502379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVpYRjFmGfIvAowYm40B4QrYHOxDCydefnDPUi9Uy80=;
        b=mMmYCPdn0WNIcHqGhd+WtHGCsVYxO8B7qiFu9nhc0cN86GYN9wmub5lHi+c9o9qxfQ
         ZOZXHL3M61j1vw4AIDVkch8LTbgR47x6paUZfLc6lCMbW2mjGamNQB+FFDacnvsrc2sl
         ZJBVkXVmmYldfJx89HE78KJHK/2+luW9laI9tlrqxqQre+0mer01xe8BLYgY9OGk1Vfr
         Lgk2cf8jnv4IWplVIs2mhtJpqLOmrIa5nvLZI33bcNwbIKVKKNTg4O4qEHCor9xhKIDm
         DTUticaEE57McSYHVm2hBumuIYyfwEtIxF/UDE2Hbj7MwsUAVO7+Y8bAKO6gVzpB2jpu
         41lg==
X-Gm-Message-State: AOJu0YzBygcn146L8uUDbtdh21cTgR5E16UEqa/ur0ZHAJB9s6LGPqqu
	I/f6x8VbSV4lo2JDXgH+PH2R4dfwHGOq3dft5STrf31MBc7ujmQns9cGBHNQ
X-Gm-Gg: ASbGncsezUUn1hTYh52EBG0zjiLL1i21aoP9/w/ImUKcXkF0frHRzs/YS5RHFDJlQop
	KzzsBEEkOC7R6kOS/PvfqjhcYaGCKnBwcaWj1DPk6qtZvrW84jxASZB69HOXClerOEYICwc7msP
	dExh/4bowybkK77teK1AXSpUID5Hl3Ps6BPAyeCxkleqvG2pSpyXFSOfKDwFSv+Gx6Vf9LKxYVq
	quAJlbxH+2D1mVFEv2F+iPz0qOUAGjVWUbFz0yxE/szgKpNI1/aAmmpXjAu54ek0OD1DjRZT2bK
	UYNCPQVdB/efbhHbfv+ytL76j/FU6LGzFWLKBI5KkLMnu5okMS6TXE6WgLxJqZoaycAr9PMMN5p
	Gzm/W8w==
X-Google-Smtp-Source: AGHT+IGvlCa2ajcIanRg3HmWWgZaemkpRB3U45n2bJJ9fkb5OTwX3dH6m02OAMNlsqTU5IOy9ZPgeQ==
X-Received: by 2002:a05:6a20:43a2:b0:1f5:709d:e0b7 with SMTP id adf61e73a8af0-1f5c1132be7mr119499637.6.1741897579273;
        Thu, 13 Mar 2025 13:26:19 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:18 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 16/29] xfs: transfer recovered intent item ownership in ->iop_recover
Date: Thu, 13 Mar 2025 13:25:36 -0700
Message-ID: <20250313202550.2257219-17-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
In-Reply-To: <20250313202550.2257219-1-leah.rumancik@gmail.com>
References: <20250313202550.2257219-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit deb4cd8ba87f17b12c72b3827820d9c703e9fd95 ]

Now that we pass the xfs_defer_pending object into the intent item
recovery functions, we know exactly when ownership of the sole refcount
passes from the recovery context to the intent done item.  At that
point, we need to null out dfp_intent so that the recovery mechanism
won't release it.  This should fix the UAF problem reported by Long Li.

Note that we still want to recreate the full deferred work state.  That
will be addressed in the next patches.

Fixes: 2e76f188fd90 ("xfs: cancel intents immediately if process_intents fails")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_log_recover.h |  2 ++
 fs/xfs/xfs_attr_item.c          |  1 +
 fs/xfs/xfs_bmap_item.c          |  2 ++
 fs/xfs/xfs_extfree_item.c       |  2 ++
 fs/xfs/xfs_log_recover.c        | 19 ++++++++++++-------
 fs/xfs/xfs_refcount_item.c      |  1 +
 fs/xfs/xfs_rmap_item.c          |  2 ++
 7 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_log_recover.h b/fs/xfs/libxfs/xfs_log_recover.h
index 271a4ce7375c..13583df9f239 100644
--- a/fs/xfs/libxfs/xfs_log_recover.h
+++ b/fs/xfs/libxfs/xfs_log_recover.h
@@ -153,7 +153,9 @@ xlog_recover_resv(const struct xfs_trans_res *r)
 	return ret;
 }
 
 void xlog_recover_intent_item(struct xlog *log, struct xfs_log_item *lip,
 		xfs_lsn_t lsn, unsigned int dfp_type);
+void xlog_recover_transfer_intent(struct xfs_trans *tp,
+		struct xfs_defer_pending *dfp);
 
 #endif	/* __XFS_LOG_RECOVER_H__ */
diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index 6119a7a480a0..82775e9537df 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -630,10 +630,11 @@ xfs_attri_item_recover(
 	if (error)
 		goto out;
 
 	args->trans = tp;
 	done_item = xfs_trans_get_attrd(tp, attrip);
+	xlog_recover_transfer_intent(tp, dfp);
 
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	xfs_trans_ijoin(tp, ip, 0);
 
 	error = xfs_xattri_finish_update(attr, done_item);
diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 30c05eb862d6..317cf49e6cd6 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -489,10 +489,12 @@ xfs_bui_item_recover(
 			XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK), 0, 0, &tp);
 	if (error)
 		goto err_rele;
 
 	budp = xfs_trans_get_bud(tp, buip);
+	xlog_recover_transfer_intent(tp, dfp);
+
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	xfs_trans_ijoin(tp, ip, 0);
 
 	if (fake.bi_type == XFS_BMAP_MAP)
 		iext_delta = XFS_IEXT_ADD_NOSPLIT_CNT;
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index 6cfd9339f872..9c726f082285 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -624,11 +624,13 @@ xfs_efi_item_recover(
 
 	resv = xlog_recover_resv(&M_RES(mp)->tr_itruncate);
 	error = xfs_trans_alloc(mp, &resv, 0, 0, 0, &tp);
 	if (error)
 		return error;
+
 	efdp = xfs_trans_get_efd(tp, efip, efip->efi_format.efi_nextents);
+	xlog_recover_transfer_intent(tp, dfp);
 
 	for (i = 0; i < efip->efi_format.efi_nextents; i++) {
 		struct xfs_extent_free_item	fake = {
 			.xefi_owner		= XFS_RMAP_OWN_UNKNOWN,
 			.xefi_agresv		= XFS_AG_RESV_NONE,
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 303bf9728c03..e7992a651740 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2591,17 +2591,10 @@ xlog_recover_process_intents(
 			trace_xlog_intent_recovery_failed(log->l_mp, error,
 					ops->iop_recover);
 			break;
 		}
 
-		/*
-		 * XXX: @lip could have been freed, so detach the log item from
-		 * the pending item before freeing the pending item.  This does
-		 * not fix the existing UAF bug that occurs if ->iop_recover
-		 * fails after creating the intent done item.
-		 */
-		dfp->dfp_intent = NULL;
 		xfs_defer_cancel_recovery(log->l_mp, dfp);
 	}
 	if (error)
 		goto err;
 
@@ -2631,10 +2624,22 @@ xlog_recover_cancel_intents(
 
 		xfs_defer_cancel_recovery(log->l_mp, dfp);
 	}
 }
 
+/*
+ * Transfer ownership of the recovered log intent item to the recovery
+ * transaction.
+ */
+void
+xlog_recover_transfer_intent(
+	struct xfs_trans		*tp,
+	struct xfs_defer_pending	*dfp)
+{
+	dfp->dfp_intent = NULL;
+}
+
 /*
  * This routine performs a transaction to null out a bad inode pointer
  * in an agi unlinked inode hash bucket.
  */
 STATIC void
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index e158dd9f86b0..2e8bdd598296 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -497,10 +497,11 @@ xfs_cui_item_recover(
 			XFS_TRANS_RESERVE, &tp);
 	if (error)
 		return error;
 
 	cudp = xfs_trans_get_cud(tp, cuip);
+	xlog_recover_transfer_intent(tp, dfp);
 
 	for (i = 0; i < cuip->cui_format.cui_nextents; i++) {
 		struct xfs_refcount_intent	fake = { };
 		struct xfs_phys_extent		*refc;
 
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index b3b4de68b41b..f29fadf68ed2 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -524,11 +524,13 @@ xfs_rui_item_recover(
 	resv = xlog_recover_resv(&M_RES(mp)->tr_itruncate);
 	error = xfs_trans_alloc(mp, &resv, mp->m_rmap_maxlevels, 0,
 			XFS_TRANS_RESERVE, &tp);
 	if (error)
 		return error;
+
 	rudp = xfs_trans_get_rud(tp, ruip);
+	xlog_recover_transfer_intent(tp, dfp);
 
 	for (i = 0; i < ruip->rui_format.rui_nextents; i++) {
 		rmap = &ruip->rui_format.rui_extents[i];
 		state = (rmap->me_flags & XFS_RMAP_EXTENT_UNWRITTEN) ?
 				XFS_EXT_UNWRITTEN : XFS_EXT_NORM;
-- 
2.49.0.rc1.451.g8f38331e32-goog


