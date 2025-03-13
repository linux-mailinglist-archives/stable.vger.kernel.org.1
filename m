Return-Path: <stable+bounces-124372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54651A60296
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1BC19C5936
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034291F3FEE;
	Thu, 13 Mar 2025 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZiEM+FT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376BE1F419D
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897580; cv=none; b=bTq+W7l/l9mMXrKahGo/DIXqAtOC6JYmxnh2BvQghwokWnWm6Pr89qczUlf6aH5xodJWscULN1OyMrSr3lhOM/fX0vKc1WHI7Y/WcX/XCrOwQgkJIYKIueXgWYX1dA+pC/HZZF6DIKbEJRq63HitacP0i7S7DmdsRA8zcm1mogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897580; c=relaxed/simple;
	bh=SRTfdh/KrsOpDndxUaSRJSb2RLxnogz46VQxCxZom48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u75e2IvZoOV00TA/xdzWkxyHN/LEPcVCRx318w+868zVZxLrcsmcoeC6bJ9Yfu1AAfFDUEHzd7LTBRfoXO2/bIOOXXnUGjTkZW+RvTalNM5dzcB2DYM9JyrTRdIRYujRXroaPU6LGKrehKExx3FpYTSqhedBGB6ABeZMYmXdkrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZiEM+FT; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso2611679a91.3
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897578; x=1742502378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rvw8BykJbmYn4Zh9gjtAl1PZyb2wr12nMRt7ddSwnvI=;
        b=mZiEM+FT1/J0GAKXaHupQW4t7ddo5AoAj+mGnGlN6RqxWz9TpUwVEPaxfRXFAjLOTN
         wGRwpX6VO7LX2Ak+WTDJ6zvLWzFkqqxlHEX6rqhO0o0MO0IhVd+ltbM2l7q0ablPrRDP
         D0C210jzuUciDp50oR5S9Ynf1uIvkU4WzIzSRVAkK/vygY9poQ6AZxNMtvwwY4Z+oMnv
         hq/rKtBZOpvLEDCBKasmO3nhopxaLiBDsnwlHA1jOjwOJ6X3sdGJnML16Gac4tVCi3pM
         Td7l6aHAAUhMkG75zVamSOgFA2RL0+tB6dbCqZaV7Z9Dl8N31y6bLHtAhDJxKTEynA0n
         jR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897578; x=1742502378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rvw8BykJbmYn4Zh9gjtAl1PZyb2wr12nMRt7ddSwnvI=;
        b=XTm3DZ1PpL/OvyE4uPFzLBZroUXClK76WFgouKFsZZ1QLwQLlgdZR6+us4eYx1t6aa
         PKwAQJsHIlVA7vMaktimuHAnp3Z4EQ7R/5MZXYJ/MPMwGVD9FMknD9uJwgQvitYujkAd
         MSrOvYzMGm5EWNF0rgs96NS6J6OSNjFG2T6/+9GHJy246ot4Npt18xwpscOE8Tx5Uc88
         3CD91v34JA4JUk3IWDwjQp6FLVI8sMYN/f3ShgiyURlWh87vKKBg+Rhixa8dj4cQj+n1
         AWZvJ2l8UcOvjVp+8QboDUUK2HAqWsACIpCk5vuwR/Faol+anMdlIaEChHpm3U/zOhXL
         HHQQ==
X-Gm-Message-State: AOJu0YyCEu4eoNaimS+c7gg6FVcNjFGUbuw4mKcArNrLfp4bGrOfOT22
	PlNUH98ovmXOmVVuNZXG9qGQWyQ/8Ww4EzfGHo7o8XqTmMmy3De68kt02tQy
X-Gm-Gg: ASbGncvWKUis99cSSUPzQ7A8disKwZal5yhAK9bpQSQDTnK3UnNrf1ZO4LA2RIlKW1i
	MBElno4jYQCE+0QiVnnL64HGhogmjo8ShdD6d8BQ7CplYnVq/pnKLTMbi9daMKOisvCL6x+qO7v
	7b7Wxur6pMbNtaYaAW1ztEedJ8vnurmCJg78GjbxdsXlM3sWHDYEoyZgEfaI+UHWmx2hLxTVYSW
	bl+V2mHhjNenmtrHuD8ewOLo5cpkbd3wi+Tbg6e5aXGB6ik8UAdu5cDBtvZC1brZH2fmWEVmG1l
	KDXkBlwuYkpm6yOdzLT9ssk9TdMEipGuqSh4+R2hUruoRXpZfbawKhJgjgBnHujUkwxtjlk=
X-Google-Smtp-Source: AGHT+IEpMsrwsJIaGV4mfcspoX9A5LP6qR4A/G6GTIipJV2YgPLtffV5tc+i8bcsdk7UjsFAZIgqEA==
X-Received: by 2002:a05:6a20:6007:b0:1f5:6d00:ba05 with SMTP id adf61e73a8af0-1f5c1322775mr58571637.38.1741897578354;
        Thu, 13 Mar 2025 13:26:18 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:17 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 15/29] xfs: pass the xfs_defer_pending object to iop_recover
Date: Thu, 13 Mar 2025 13:25:35 -0700
Message-ID: <20250313202550.2257219-16-leah.rumancik@gmail.com>
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

[ Upstream commit a050acdfa8003a44eae4558fddafc7afb1aef458 ]

Now that log intent item recovery recreates the xfs_defer_pending state,
we should pass that into the ->iop_recover routines so that the intent
item can finish the recreation work.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_attr_item.c     | 3 ++-
 fs/xfs/xfs_bmap_item.c     | 3 ++-
 fs/xfs/xfs_extfree_item.c  | 3 ++-
 fs/xfs/xfs_log_recover.c   | 2 +-
 fs/xfs/xfs_refcount_item.c | 3 ++-
 fs/xfs/xfs_rmap_item.c     | 3 ++-
 fs/xfs/xfs_trans.h         | 4 +++-
 7 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index a32716b8cbbd..6119a7a480a0 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -543,13 +543,14 @@ xfs_attri_validate(
  * Process an attr intent item that was recovered from the log.  We need to
  * delete the attr that it describes.
  */
 STATIC int
 xfs_attri_item_recover(
-	struct xfs_log_item		*lip,
+	struct xfs_defer_pending	*dfp,
 	struct list_head		*capture_list)
 {
+	struct xfs_log_item		*lip = dfp->dfp_intent;
 	struct xfs_attri_log_item	*attrip = ATTRI_ITEM(lip);
 	struct xfs_attr_intent		*attr;
 	struct xfs_mount		*mp = lip->li_log->l_mp;
 	struct xfs_inode		*ip;
 	struct xfs_da_args		*args;
diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 8d08252e1953..30c05eb862d6 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -451,15 +451,16 @@ xfs_bui_validate(
  * Process a bmap update intent item that was recovered from the log.
  * We need to update some inode's bmbt.
  */
 STATIC int
 xfs_bui_item_recover(
-	struct xfs_log_item		*lip,
+	struct xfs_defer_pending	*dfp,
 	struct list_head		*capture_list)
 {
 	struct xfs_bmap_intent		fake = { };
 	struct xfs_trans_res		resv;
+	struct xfs_log_item		*lip = dfp->dfp_intent;
 	struct xfs_bui_log_item		*buip = BUI_ITEM(lip);
 	struct xfs_trans		*tp;
 	struct xfs_inode		*ip = NULL;
 	struct xfs_mount		*mp = lip->li_log->l_mp;
 	struct xfs_map_extent		*map;
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index fd9fe51bcc31..6cfd9339f872 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -593,14 +593,15 @@ xfs_efi_validate_ext(
  * Process an extent free intent item that was recovered from
  * the log.  We need to free the extents that it describes.
  */
 STATIC int
 xfs_efi_item_recover(
-	struct xfs_log_item		*lip,
+	struct xfs_defer_pending	*dfp,
 	struct list_head		*capture_list)
 {
 	struct xfs_trans_res		resv;
+	struct xfs_log_item		*lip = dfp->dfp_intent;
 	struct xfs_efi_log_item		*efip = EFI_ITEM(lip);
 	struct xfs_mount		*mp = lip->li_log->l_mp;
 	struct xfs_efd_log_item		*efdp;
 	struct xfs_trans		*tp;
 	int				i;
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 65041ed7833d..303bf9728c03 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2584,11 +2584,11 @@ xlog_recover_process_intents(
 		 * replayed in the wrong order!
 		 *
 		 * The recovery function can free the log item, so we must not
 		 * access lip after it returns.
 		 */
-		error = ops->iop_recover(lip, &capture_list);
+		error = ops->iop_recover(dfp, &capture_list);
 		if (error) {
 			trace_xlog_intent_recovery_failed(log->l_mp, error,
 					ops->iop_recover);
 			break;
 		}
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index 1e047107d2f2..e158dd9f86b0 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -448,14 +448,15 @@ xfs_cui_validate_phys(
  * Process a refcount update intent item that was recovered from the log.
  * We need to update the refcountbt.
  */
 STATIC int
 xfs_cui_item_recover(
-	struct xfs_log_item		*lip,
+	struct xfs_defer_pending	*dfp,
 	struct list_head		*capture_list)
 {
 	struct xfs_trans_res		resv;
+	struct xfs_log_item		*lip = dfp->dfp_intent;
 	struct xfs_cui_log_item		*cuip = CUI_ITEM(lip);
 	struct xfs_cud_log_item		*cudp;
 	struct xfs_trans		*tp;
 	struct xfs_btree_cur		*rcur = NULL;
 	struct xfs_mount		*mp = lip->li_log->l_mp;
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 12ae8ab6a69d..b3b4de68b41b 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -487,14 +487,15 @@ xfs_rui_validate_map(
  * Process an rmap update intent item that was recovered from the log.
  * We need to update the rmapbt.
  */
 STATIC int
 xfs_rui_item_recover(
-	struct xfs_log_item		*lip,
+	struct xfs_defer_pending	*dfp,
 	struct list_head		*capture_list)
 {
 	struct xfs_trans_res		resv;
+	struct xfs_log_item		*lip = dfp->dfp_intent;
 	struct xfs_rui_log_item		*ruip = RUI_ITEM(lip);
 	struct xfs_map_extent		*rmap;
 	struct xfs_rud_log_item		*rudp;
 	struct xfs_trans		*tp;
 	struct xfs_btree_cur		*rcur = NULL;
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index 55819785941c..0f2b62f3ca19 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -64,23 +64,25 @@ struct xfs_log_item {
 	{ (1u << XFS_LI_ABORTED),	"ABORTED" }, \
 	{ (1u << XFS_LI_FAILED),	"FAILED" }, \
 	{ (1u << XFS_LI_DIRTY),		"DIRTY" }, \
 	{ (1u << XFS_LI_WHITEOUT),	"WHITEOUT" }
 
+struct xfs_defer_pending;
+
 struct xfs_item_ops {
 	unsigned flags;
 	void (*iop_size)(struct xfs_log_item *, int *, int *);
 	void (*iop_format)(struct xfs_log_item *, struct xfs_log_vec *);
 	void (*iop_pin)(struct xfs_log_item *);
 	void (*iop_unpin)(struct xfs_log_item *, int remove);
 	uint64_t (*iop_sort)(struct xfs_log_item *lip);
 	int (*iop_precommit)(struct xfs_trans *tp, struct xfs_log_item *lip);
 	void (*iop_committing)(struct xfs_log_item *lip, xfs_csn_t seq);
 	xfs_lsn_t (*iop_committed)(struct xfs_log_item *, xfs_lsn_t);
 	uint (*iop_push)(struct xfs_log_item *, struct list_head *);
 	void (*iop_release)(struct xfs_log_item *);
-	int (*iop_recover)(struct xfs_log_item *lip,
+	int (*iop_recover)(struct xfs_defer_pending *dfp,
 			   struct list_head *capture_list);
 	bool (*iop_match)(struct xfs_log_item *item, uint64_t id);
 	struct xfs_log_item *(*iop_relog)(struct xfs_log_item *intent,
 			struct xfs_trans *tp);
 	struct xfs_log_item *(*iop_intent)(struct xfs_log_item *intent_done);
-- 
2.49.0.rc1.451.g8f38331e32-goog


