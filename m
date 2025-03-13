Return-Path: <stable+bounces-124371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805BEA60295
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABFAA17CC1D
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A581F4170;
	Thu, 13 Mar 2025 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPJ5lRvw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA4D1F4192
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897580; cv=none; b=GvY+o7HEMvt+uTLMrM7pETyWoM9WY1MGTMjwTtnRpTfzyxxz1FUvAXhIP/FlpfmbqUZDQ4ofvK888kNxg4V+xwkQjyT7UZgZJxl4l7pjFfRwiHWfdOectIafh7Yr4Z6AOAbZ1isxwh7C2PygK0sjz+P7srTtV91UeORgpjSBolI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897580; c=relaxed/simple;
	bh=hEDkipGBElOKYTQAW87JiFMUKLz8D7SK1PPqdBM9sjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3FiloWMAeGMJv7UTsW9M80ghM5lr1KNbLnYofvkysxtqb+q5gR7XEL2qW2NeCi5C4bcBZcKr7lXXDIrxn/Mu3RwhFBeRtZG173TK628A10rPUq/hS9r095dtxTb6GRVLqkAvqotUN9Q3kT2spL8xqWkR9Tq1+LOBd3Onvk5cp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPJ5lRvw; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so3134270a91.3
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897577; x=1742502377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePDI7WdusS2njkPNg7e721D0Mf44SquiJfH75FcyjIo=;
        b=WPJ5lRvwcl3NK3MonNv++o99ITaLJqe4BEv6u+fACQzZGiDhNXpXucTQad9GxXB446
         4r3QM2QhNiMQKbdQydNQ1NEDqz+7etKpWaUmeUQiTxAhGOLDeHRapp1gPg31JL/r2GrN
         3CvvbKX6Yqzg6w5EFIzXS1YMZQ+IIgQad86XNson2zrtKYxwAbIk6NfR5+VFYJhA0Hg7
         x+5dispWfdfyMFxIEBOhe7MggLJ2pkMC78aumPKZP1+A94Hege63uFIPQP8S3EobStSe
         pkHbRgz4b+fuz6hRSgpnDDWMEbxHkEn2VFaRQjGm+sWPTgVknduAD4wuUIdaWjLdjZnw
         DMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897577; x=1742502377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePDI7WdusS2njkPNg7e721D0Mf44SquiJfH75FcyjIo=;
        b=nFbI9/BIaXduNssqqOeSgsex/aEX9T7OQOMaofUHy30/vOh2y6Lb983xpAN6SQR6uk
         xRWnVdLbkAfAbQVG9WKl9BBKniK56Q0+lc+o6EJ7+hvKoGK3MNcsn7q0gVHw1Hf3Lt9j
         9zRGny47lmJBz39ZIzLKU/nt+3I1c2CYsHA5VS5casmYW46SjoKXd1nqOXi7eNmpkm2A
         WR8JI+8ID6lUyo5YLXzjAAzMqDhv2WnRrJly/3trVtznOeZ7ayhaIJsoCfNN7Y5YrymW
         rKUckdDNJpb1P1nHI7Q/mBa0pOqARs9UbHRjspJzg7nZkE2nLuNBHQZxmsgBG2hXfNX2
         TZXQ==
X-Gm-Message-State: AOJu0YxKiJ2XaSd6vfaK+zmSfwVCm0fsvvudw2b7TH+rgj+2Ls9LpugO
	Czf69qLFlbg68ywFkeN4l6FUuXccgPQwoT04Xc/dzoTiClbnnox2P3Zy3vHo
X-Gm-Gg: ASbGnct6Ol6yABdBXqzPVp+Q7tOrRq4/dNZ5ZhhFgJDGOT33bIvjIC1xPRsvFxtGTEF
	Dq2AyfbOXjwadu326VOErV4xn7qYoailLJlI4Q9bFUG2vnj1afC1evREZka9kuBbFyOA+Er3wQ+
	6zKxu86tjmGEM6VvgcwCn/2W/xZ68VeI/G+W2zftshLtUEnGa8d6HrZ6Zxg5xFT9fd5/q/3MvUR
	TTg3RGDYW86Iy31zHBBaERQMQjqegcjdh6UxqMYPKiSGEQ28BGljT+PKQa4nbJ4rA6A42JmNsht
	1ZyITLwNR8PzZeXI4t3ew2NYHjkDhMCIbm1nIuJ4jRiSYHLpFx/zvzAtxhf+ywMJJxzEuSA=
X-Google-Smtp-Source: AGHT+IHZzP7doJzVt91adIlxkg7c+SI1XphnAgCeJQleEiZBedSeO/ctjH1CvXyHYMZ7uEvVEY/hXw==
X-Received: by 2002:a05:6a20:1595:b0:1f5:a577:dd10 with SMTP id adf61e73a8af0-1f5c134c429mr81879637.36.1741897577424;
        Thu, 13 Mar 2025 13:26:17 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:17 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 14/29] xfs: use xfs_defer_pending objects to recover intent items
Date: Thu, 13 Mar 2025 13:25:34 -0700
Message-ID: <20250313202550.2257219-15-leah.rumancik@gmail.com>
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

[ Upstream commit 03f7767c9f6120ac933378fdec3bfd78bf07bc11 ]

[ 6.1: resovled conflict in xfs_defer.c ]

One thing I never quite got around to doing is porting the log intent
item recovery code to reconstruct the deferred pending work state.  As a
result, each intent item open codes xfs_defer_finish_one in its recovery
method, because that's what the EFI code did before xfs_defer.c even
existed.

This is a gross thing to have left unfixed -- if an EFI cannot proceed
due to busy extents, we end up creating separate new EFIs for each
unfinished work item, which is a change in behavior from what runtime
would have done.

Worse yet, Long Li pointed out that there's a UAF in the recovery code.
The ->commit_pass2 function adds the intent item to the AIL and drops
the refcount.  The one remaining refcount is now owned by the recovery
mechanism (aka the log intent items in the AIL) with the intent of
giving the refcount to the intent done item in the ->iop_recover
function.

However, if something fails later in recovery, xlog_recover_finish will
walk the recovered intent items in the AIL and release them.  If the CIL
hasn't been pushed before that point (which is possible since we don't
force the log until later) then the intent done release will try to free
its associated intent, which has already been freed.

This patch starts to address this mess by having the ->commit_pass2
functions recreate the xfs_defer_pending state.  The next few patches
will fix the recovery functions.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_defer.c       | 103 +++++++++++++++++++++--------
 fs/xfs/libxfs/xfs_defer.h       |   5 ++
 fs/xfs/libxfs/xfs_log_recover.h |   3 +
 fs/xfs/xfs_attr_item.c          |  10 +--
 fs/xfs/xfs_bmap_item.c          |   9 +--
 fs/xfs/xfs_extfree_item.c       |   9 +--
 fs/xfs/xfs_log.c                |   1 +
 fs/xfs/xfs_log_priv.h           |   1 +
 fs/xfs/xfs_log_recover.c        | 113 ++++++++++++++++----------------
 fs/xfs/xfs_refcount_item.c      |   9 +--
 fs/xfs/xfs_rmap_item.c          |   9 +--
 11 files changed, 157 insertions(+), 115 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
index 92470ed3fcbd..64005ea1e8af 100644
--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -243,37 +243,66 @@ xfs_defer_create_intents(
 		ret |= ret2;
 	}
 	return ret;
 }
 
-STATIC void
+static inline void
 xfs_defer_pending_abort(
+	struct xfs_mount		*mp,
+	struct xfs_defer_pending	*dfp)
+{
+	const struct xfs_defer_op_type	*ops = defer_op_types[dfp->dfp_type];
+
+	trace_xfs_defer_pending_abort(mp, dfp);
+
+	if (dfp->dfp_intent && !dfp->dfp_done) {
+		ops->abort_intent(dfp->dfp_intent);
+		dfp->dfp_intent = NULL;
+	}
+}
+
+static inline void
+xfs_defer_pending_cancel_work(
+	struct xfs_mount		*mp,
+	struct xfs_defer_pending	*dfp)
+{
+	const struct xfs_defer_op_type	*ops = defer_op_types[dfp->dfp_type];
+	struct list_head		*pwi;
+	struct list_head		*n;
+
+	trace_xfs_defer_cancel_list(mp, dfp);
+
+	list_del(&dfp->dfp_list);
+	list_for_each_safe(pwi, n, &dfp->dfp_work) {
+		list_del(pwi);
+		dfp->dfp_count--;
+		ops->cancel_item(pwi);
+	}
+	ASSERT(dfp->dfp_count == 0);
+	kmem_cache_free(xfs_defer_pending_cache, dfp);
+}
+
+STATIC void
+xfs_defer_pending_abort_list(
 	struct xfs_mount		*mp,
 	struct list_head		*dop_list)
 {
 	struct xfs_defer_pending	*dfp;
-	const struct xfs_defer_op_type	*ops;
 
 	/* Abort intent items that don't have a done item. */
-	list_for_each_entry(dfp, dop_list, dfp_list) {
-		ops = defer_op_types[dfp->dfp_type];
-		trace_xfs_defer_pending_abort(mp, dfp);
-		if (dfp->dfp_intent && !dfp->dfp_done) {
-			ops->abort_intent(dfp->dfp_intent);
-			dfp->dfp_intent = NULL;
-		}
-	}
+	list_for_each_entry(dfp, dop_list, dfp_list)
+		xfs_defer_pending_abort(mp, dfp);
 }
 
 /* Abort all the intents that were committed. */
 STATIC void
 xfs_defer_trans_abort(
 	struct xfs_trans		*tp,
 	struct list_head		*dop_pending)
 {
 	trace_xfs_defer_trans_abort(tp, _RET_IP_);
-	xfs_defer_pending_abort(tp->t_mountp, dop_pending);
+	xfs_defer_pending_abort_list(tp->t_mountp, dop_pending);
 }
 
 /*
  * Capture resources that the caller said not to release ("held") when the
  * transaction commits.  Caller is responsible for zero-initializing @dres.
@@ -387,30 +416,17 @@ xfs_defer_cancel_list(
 	struct xfs_mount		*mp,
 	struct list_head		*dop_list)
 {
 	struct xfs_defer_pending	*dfp;
 	struct xfs_defer_pending	*pli;
-	struct list_head		*pwi;
-	struct list_head		*n;
-	const struct xfs_defer_op_type	*ops;
 
 	/*
 	 * Free the pending items.  Caller should already have arranged
 	 * for the intent items to be released.
 	 */
-	list_for_each_entry_safe(dfp, pli, dop_list, dfp_list) {
-		ops = defer_op_types[dfp->dfp_type];
-		trace_xfs_defer_cancel_list(mp, dfp);
-		list_del(&dfp->dfp_list);
-		list_for_each_safe(pwi, n, &dfp->dfp_work) {
-			list_del(pwi);
-			dfp->dfp_count--;
-			ops->cancel_item(pwi);
-		}
-		ASSERT(dfp->dfp_count == 0);
-		kmem_cache_free(xfs_defer_pending_cache, dfp);
-	}
+	list_for_each_entry_safe(dfp, pli, dop_list, dfp_list)
+		xfs_defer_pending_cancel_work(mp, dfp);
 }
 
 /*
  * Prevent a log intent item from pinning the tail of the log by logging a
  * done item to release the intent item; and then log a new intent item.
@@ -661,10 +677,43 @@ xfs_defer_add(
 
 	list_add_tail(li, &dfp->dfp_work);
 	dfp->dfp_count++;
 }
 
+/*
+ * Create a pending deferred work item to replay the recovered intent item
+ * and add it to the list.
+ */
+void
+xfs_defer_start_recovery(
+	struct xfs_log_item		*lip,
+	enum xfs_defer_ops_type		dfp_type,
+	struct list_head		*r_dfops)
+{
+	struct xfs_defer_pending	*dfp;
+
+	dfp = kmem_cache_zalloc(xfs_defer_pending_cache,
+			GFP_NOFS | __GFP_NOFAIL);
+	dfp->dfp_type = dfp_type;
+	dfp->dfp_intent = lip;
+	INIT_LIST_HEAD(&dfp->dfp_work);
+	list_add_tail(&dfp->dfp_list, r_dfops);
+}
+
+/*
+ * Cancel a deferred work item created to recover a log intent item.  @dfp
+ * will be freed after this function returns.
+ */
+void
+xfs_defer_cancel_recovery(
+	struct xfs_mount		*mp,
+	struct xfs_defer_pending	*dfp)
+{
+	xfs_defer_pending_abort(mp, dfp);
+	xfs_defer_pending_cancel_work(mp, dfp);
+}
+
 /*
  * Move deferred ops from one transaction to another and reset the source to
  * initial state. This is primarily used to carry state forward across
  * transaction rolls with pending dfops.
  */
@@ -765,11 +814,11 @@ xfs_defer_ops_capture_abort(
 	struct xfs_mount		*mp,
 	struct xfs_defer_capture	*dfc)
 {
 	unsigned short			i;
 
-	xfs_defer_pending_abort(mp, &dfc->dfc_dfops);
+	xfs_defer_pending_abort_list(mp, &dfc->dfc_dfops);
 	xfs_defer_cancel_list(mp, &dfc->dfc_dfops);
 
 	for (i = 0; i < dfc->dfc_held.dr_bufs; i++)
 		xfs_buf_relse(dfc->dfc_held.dr_bp[i]);
 
diff --git a/fs/xfs/libxfs/xfs_defer.h b/fs/xfs/libxfs/xfs_defer.h
index 8788ad5f6a73..5dce938ba3d5 100644
--- a/fs/xfs/libxfs/xfs_defer.h
+++ b/fs/xfs/libxfs/xfs_defer.h
@@ -123,9 +123,14 @@ void xfs_defer_ops_continue(struct xfs_defer_capture *d, struct xfs_trans *tp,
 		struct xfs_defer_resources *dres);
 void xfs_defer_ops_capture_abort(struct xfs_mount *mp,
 		struct xfs_defer_capture *d);
 void xfs_defer_resources_rele(struct xfs_defer_resources *dres);
 
+void xfs_defer_start_recovery(struct xfs_log_item *lip,
+		enum xfs_defer_ops_type dfp_type, struct list_head *r_dfops);
+void xfs_defer_cancel_recovery(struct xfs_mount *mp,
+		struct xfs_defer_pending *dfp);
+
 int __init xfs_defer_init_item_caches(void);
 void xfs_defer_destroy_item_caches(void);
 
 #endif /* __XFS_DEFER_H__ */
diff --git a/fs/xfs/libxfs/xfs_log_recover.h b/fs/xfs/libxfs/xfs_log_recover.h
index a5100a11faf9..271a4ce7375c 100644
--- a/fs/xfs/libxfs/xfs_log_recover.h
+++ b/fs/xfs/libxfs/xfs_log_recover.h
@@ -151,6 +151,9 @@ xlog_recover_resv(const struct xfs_trans_res *r)
 	};
 
 	return ret;
 }
 
+void xlog_recover_intent_item(struct xlog *log, struct xfs_log_item *lip,
+		xfs_lsn_t lsn, unsigned int dfp_type);
+
 #endif	/* __XFS_LOG_RECOVER_H__ */
diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index 11e88a76a33c..a32716b8cbbd 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -770,18 +770,12 @@ xlog_recover_attri_commit_pass2(
 			attri_formatp->alfi_value_len);
 
 	attrip = xfs_attri_init(mp, nv);
 	memcpy(&attrip->attri_format, attri_formatp, len);
 
-	/*
-	 * The ATTRI has two references. One for the ATTRD and one for ATTRI to
-	 * ensure it makes it into the AIL. Insert the ATTRI into the AIL
-	 * directly and drop the ATTRI reference. Note that
-	 * xfs_trans_ail_update() drops the AIL lock.
-	 */
-	xfs_trans_ail_insert(log->l_ailp, &attrip->attri_item, lsn);
-	xfs_attri_release(attrip);
+	xlog_recover_intent_item(log, &attrip->attri_item, lsn,
+			XFS_DEFER_OPS_TYPE_ATTR);
 	xfs_attri_log_nameval_put(nv);
 	return 0;
 }
 
 /*
diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 1058603db3ac..8d08252e1953 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -644,16 +644,13 @@ xlog_recover_bui_commit_pass2(
 	}
 
 	buip = xfs_bui_init(mp);
 	xfs_bui_copy_format(&buip->bui_format, bui_formatp);
 	atomic_set(&buip->bui_next_extent, bui_formatp->bui_nextents);
-	/*
-	 * Insert the intent into the AIL directly and drop one reference so
-	 * that finishing or canceling the work will drop the other.
-	 */
-	xfs_trans_ail_insert(log->l_ailp, &buip->bui_item, lsn);
-	xfs_bui_release(buip);
+
+	xlog_recover_intent_item(log, &buip->bui_item, lsn,
+			XFS_DEFER_OPS_TYPE_BMAP);
 	return 0;
 }
 
 const struct xlog_recover_item_ops xlog_bui_item_ops = {
 	.item_type		= XFS_LI_BUI,
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index 3ed25c352269..fd9fe51bcc31 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -734,16 +734,13 @@ xlog_recover_efi_commit_pass2(
 	if (error) {
 		xfs_efi_item_free(efip);
 		return error;
 	}
 	atomic_set(&efip->efi_next_extent, efi_formatp->efi_nextents);
-	/*
-	 * Insert the intent into the AIL directly and drop one reference so
-	 * that finishing or canceling the work will drop the other.
-	 */
-	xfs_trans_ail_insert(log->l_ailp, &efip->efi_item, lsn);
-	xfs_efi_release(efip);
+
+	xlog_recover_intent_item(log, &efip->efi_item, lsn,
+			XFS_DEFER_OPS_TYPE_FREE);
 	return 0;
 }
 
 const struct xlog_recover_item_ops xlog_efi_item_ops = {
 	.item_type		= XFS_LI_EFI,
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index ce6b303484cf..d39ee05ac1f2 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1538,10 +1538,11 @@ xlog_alloc_log(
 	log->l_logBBstart  = blk_offset;
 	log->l_logBBsize   = num_bblks;
 	log->l_covered_state = XLOG_STATE_COVER_IDLE;
 	set_bit(XLOG_ACTIVE_RECOVERY, &log->l_opstate);
 	INIT_DELAYED_WORK(&log->l_work, xfs_log_worker);
+	INIT_LIST_HEAD(&log->r_dfops);
 
 	log->l_prev_block  = -1;
 	/* log->l_tail_lsn = 0x100000000LL; cycle = 1; current block = 0 */
 	xlog_assign_atomic_lsn(&log->l_tail_lsn, 1, 0);
 	xlog_assign_atomic_lsn(&log->l_last_sync_lsn, 1, 0);
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index 1bd2963e8fbd..8677ba92d317 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -401,10 +401,11 @@ struct xlog {
 	struct workqueue_struct	*l_ioend_workqueue; /* for I/O completions */
 	struct delayed_work	l_work;		/* background flush work */
 	long			l_opstate;	/* operational state */
 	uint			l_quotaoffs_flag; /* XFS_DQ_*, for QUOTAOFFs */
 	struct list_head	*l_buf_cancel_table;
+	struct list_head	r_dfops;	/* recovered log intent items */
 	int			l_iclog_hsize;  /* size of iclog header */
 	int			l_iclog_heads;  /* # of iclog header sectors */
 	uint			l_sectBBsize;   /* sector size in BBs (2^n) */
 	int			l_iclog_size;	/* size of log in bytes */
 	int			l_iclog_bufs;	/* number of iclog buffers */
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index e009bb23d8a2..65041ed7833d 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -1721,34 +1721,28 @@ xlog_clear_stale_blocks(
  * Release the recovered intent item in the AIL that matches the given intent
  * type and intent id.
  */
 void
 xlog_recover_release_intent(
-	struct xlog		*log,
-	unsigned short		intent_type,
-	uint64_t		intent_id)
+	struct xlog			*log,
+	unsigned short			intent_type,
+	uint64_t			intent_id)
 {
-	struct xfs_ail_cursor	cur;
-	struct xfs_log_item	*lip;
-	struct xfs_ail		*ailp = log->l_ailp;
+	struct xfs_defer_pending	*dfp, *n;
+
+	list_for_each_entry_safe(dfp, n, &log->r_dfops, dfp_list) {
+		struct xfs_log_item	*lip = dfp->dfp_intent;
 
-	spin_lock(&ailp->ail_lock);
-	for (lip = xfs_trans_ail_cursor_first(ailp, &cur, 0); lip != NULL;
-	     lip = xfs_trans_ail_cursor_next(ailp, &cur)) {
 		if (lip->li_type != intent_type)
 			continue;
 		if (!lip->li_ops->iop_match(lip, intent_id))
 			continue;
 
-		spin_unlock(&ailp->ail_lock);
-		lip->li_ops->iop_release(lip);
-		spin_lock(&ailp->ail_lock);
-		break;
-	}
+		ASSERT(xlog_item_is_intent(lip));
 
-	xfs_trans_ail_cursor_done(&cur);
-	spin_unlock(&ailp->ail_lock);
+		xfs_defer_cancel_recovery(log->l_mp, dfp);
+	}
 }
 
 int
 xlog_recover_iget(
 	struct xfs_mount	*mp,
@@ -1937,10 +1931,33 @@ xlog_buf_readahead(
 {
 	if (!xlog_is_buffer_cancelled(log, blkno, len))
 		xfs_buf_readahead(log->l_mp->m_ddev_targp, blkno, len, ops);
 }
 
+/*
+ * Create a deferred work structure for resuming and tracking the progress of a
+ * log intent item that was found during recovery.
+ */
+void
+xlog_recover_intent_item(
+	struct xlog			*log,
+	struct xfs_log_item		*lip,
+	xfs_lsn_t			lsn,
+	unsigned int			dfp_type)
+{
+	ASSERT(xlog_item_is_intent(lip));
+
+	xfs_defer_start_recovery(lip, dfp_type, &log->r_dfops);
+
+	/*
+	 * Insert the intent into the AIL directly and drop one reference so
+	 * that finishing or canceling the work will drop the other.
+	 */
+	xfs_trans_ail_insert(log->l_ailp, lip, lsn);
+	lip->li_ops->iop_unpin(lip, 0);
+}
+
 STATIC int
 xlog_recover_items_pass2(
 	struct xlog                     *log,
 	struct xlog_recover             *trans,
 	struct list_head                *buffer_list,
@@ -2534,104 +2551,88 @@ xlog_abort_defer_ops(
  * have started recovery on all the pending intents when we find an non-intent
  * item in the AIL.
  */
 STATIC int
 xlog_recover_process_intents(
-	struct xlog		*log)
+	struct xlog			*log)
 {
 	LIST_HEAD(capture_list);
-	struct xfs_ail_cursor	cur;
-	struct xfs_log_item	*lip;
-	struct xfs_ail		*ailp;
-	int			error = 0;
+	struct xfs_defer_pending	*dfp, *n;
+	int				error = 0;
 #if defined(DEBUG) || defined(XFS_WARN)
-	xfs_lsn_t		last_lsn;
-#endif
+	xfs_lsn_t			last_lsn;
 
-	ailp = log->l_ailp;
-	spin_lock(&ailp->ail_lock);
-#if defined(DEBUG) || defined(XFS_WARN)
 	last_lsn = xlog_assign_lsn(log->l_curr_cycle, log->l_curr_block);
 #endif
-	for (lip = xfs_trans_ail_cursor_first(ailp, &cur, 0);
-	     lip != NULL;
-	     lip = xfs_trans_ail_cursor_next(ailp, &cur)) {
-		const struct xfs_item_ops	*ops;
 
-		if (!xlog_item_is_intent(lip))
-			break;
+	list_for_each_entry_safe(dfp, n, &log->r_dfops, dfp_list) {
+		struct xfs_log_item	*lip = dfp->dfp_intent;
+		const struct xfs_item_ops *ops = lip->li_ops;
+
+		ASSERT(xlog_item_is_intent(lip));
 
 		/*
 		 * We should never see a redo item with a LSN higher than
 		 * the last transaction we found in the log at the start
 		 * of recovery.
 		 */
 		ASSERT(XFS_LSN_CMP(last_lsn, lip->li_lsn) >= 0);
 
 		/*
 		 * NOTE: If your intent processing routine can create more
 		 * deferred ops, you /must/ attach them to the capture list in
 		 * the recover routine or else those subsequent intents will be
 		 * replayed in the wrong order!
 		 *
 		 * The recovery function can free the log item, so we must not
 		 * access lip after it returns.
 		 */
-		spin_unlock(&ailp->ail_lock);
-		ops = lip->li_ops;
 		error = ops->iop_recover(lip, &capture_list);
-		spin_lock(&ailp->ail_lock);
 		if (error) {
 			trace_xlog_intent_recovery_failed(log->l_mp, error,
 					ops->iop_recover);
 			break;
 		}
-	}
 
-	xfs_trans_ail_cursor_done(&cur);
-	spin_unlock(&ailp->ail_lock);
+		/*
+		 * XXX: @lip could have been freed, so detach the log item from
+		 * the pending item before freeing the pending item.  This does
+		 * not fix the existing UAF bug that occurs if ->iop_recover
+		 * fails after creating the intent done item.
+		 */
+		dfp->dfp_intent = NULL;
+		xfs_defer_cancel_recovery(log->l_mp, dfp);
+	}
 	if (error)
 		goto err;
 
 	error = xlog_finish_defer_ops(log->l_mp, &capture_list);
 	if (error)
 		goto err;
 
 	return 0;
 err:
 	xlog_abort_defer_ops(log->l_mp, &capture_list);
 	return error;
 }
 
 /*
  * A cancel occurs when the mount has failed and we're bailing out.  Release all
  * pending log intent items that we haven't started recovery on so they don't
  * pin the AIL.
  */
 STATIC void
 xlog_recover_cancel_intents(
-	struct xlog		*log)
+	struct xlog			*log)
 {
-	struct xfs_log_item	*lip;
-	struct xfs_ail_cursor	cur;
-	struct xfs_ail		*ailp;
-
-	ailp = log->l_ailp;
-	spin_lock(&ailp->ail_lock);
-	lip = xfs_trans_ail_cursor_first(ailp, &cur, 0);
-	while (lip != NULL) {
-		if (!xlog_item_is_intent(lip))
-			break;
+	struct xfs_defer_pending	*dfp, *n;
 
-		spin_unlock(&ailp->ail_lock);
-		lip->li_ops->iop_release(lip);
-		spin_lock(&ailp->ail_lock);
-		lip = xfs_trans_ail_cursor_next(ailp, &cur);
-	}
+	list_for_each_entry_safe(dfp, n, &log->r_dfops, dfp_list) {
+		ASSERT(xlog_item_is_intent(dfp->dfp_intent));
 
-	xfs_trans_ail_cursor_done(&cur);
-	spin_unlock(&ailp->ail_lock);
+		xfs_defer_cancel_recovery(log->l_mp, dfp);
+	}
 }
 
 /*
  * This routine performs a transaction to null out a bad inode pointer
  * in an agi unlinked inode hash bucket.
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index dfd7b824e32b..1e047107d2f2 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -666,16 +666,13 @@ xlog_recover_cui_commit_pass2(
 	}
 
 	cuip = xfs_cui_init(mp, cui_formatp->cui_nextents);
 	xfs_cui_copy_format(&cuip->cui_format, cui_formatp);
 	atomic_set(&cuip->cui_next_extent, cui_formatp->cui_nextents);
-	/*
-	 * Insert the intent into the AIL directly and drop one reference so
-	 * that finishing or canceling the work will drop the other.
-	 */
-	xfs_trans_ail_insert(log->l_ailp, &cuip->cui_item, lsn);
-	xfs_cui_release(cuip);
+
+	xlog_recover_intent_item(log, &cuip->cui_item, lsn,
+			XFS_DEFER_OPS_TYPE_REFCOUNT);
 	return 0;
 }
 
 const struct xlog_recover_item_ops xlog_cui_item_ops = {
 	.item_type		= XFS_LI_CUI,
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 2043cea261c0..12ae8ab6a69d 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -680,16 +680,13 @@ xlog_recover_rui_commit_pass2(
 	}
 
 	ruip = xfs_rui_init(mp, rui_formatp->rui_nextents);
 	xfs_rui_copy_format(&ruip->rui_format, rui_formatp);
 	atomic_set(&ruip->rui_next_extent, rui_formatp->rui_nextents);
-	/*
-	 * Insert the intent into the AIL directly and drop one reference so
-	 * that finishing or canceling the work will drop the other.
-	 */
-	xfs_trans_ail_insert(log->l_ailp, &ruip->rui_item, lsn);
-	xfs_rui_release(ruip);
+
+	xlog_recover_intent_item(log, &ruip->rui_item, lsn,
+			XFS_DEFER_OPS_TYPE_RMAP);
 	return 0;
 }
 
 const struct xlog_recover_item_ops xlog_rui_item_ops = {
 	.item_type		= XFS_LI_RUI,
-- 
2.49.0.rc1.451.g8f38331e32-goog


