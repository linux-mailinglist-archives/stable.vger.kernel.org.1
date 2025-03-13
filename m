Return-Path: <stable+bounces-124366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A662A60291
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 616567A95A3
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE65B1F4606;
	Thu, 13 Mar 2025 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYsh+HhI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE711F417E
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897574; cv=none; b=LcQhRKsX/SWqNd/OA+CMh0hmv/XMaOAk3PnWgoF419s0qbWg6SEGOHqIcjsz8SqIO/dd9VitBQn+t1UEte151aCpwopkjkIproTJFtkkUTcYq2KiGMu2TZ+g8Lq/pZ5NBQTysoI0ECOQwln8/lUUthBSXzh/fDR+4oaH3ojOvBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897574; c=relaxed/simple;
	bh=dAupkshHSKeWiyTMAE96IHmT74XoAxfHapmZ8m9HMYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTSByJ5m1zFRN/Ry72LRxaXKxurf5+GFe+8PSisqCB5FVIGpjkEVSRpsuaR6PjSVIhr60UD6iO8RE+FXcf6t4+eawmy5Tqabh1kwHiUeMt20Toh4QJFU89RTXEIeCaa+eqJaFKbMkeucfny2GNRbb6DfGNif/0gk3CiF2gVaLt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYsh+HhI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223959039f4so30984435ad.3
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897572; x=1742502372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1+ovjuk/hwy8z1EYzoOpjFaNZiPmAgrK0adxe0j0mI=;
        b=XYsh+HhIH3H5zjX/zu15qLV0MLk2ZfgHIVyuEeqR3tat82zBeHYGB6OQe3SieA7VnN
         e6158MROje0hS1z9cbSS2uw8GMU7O7/Bm8pByBpHY9N5vAcuJceCV7ENY6pVtumW41aS
         MPlf741rApgf7nt2yTznT3mUK4LFhq7tLNwxs5x/fjHINfz9pleacAW290A8ej33Uxlp
         xxDOd+HIhL3G+LO2b0wJnsnc21bjtKgcMOchK2BrVUrNLG0NLPQnDrBnTAJaDdlSEgBu
         Oyo5uWoUtc28hv5+E1tYJIFAYveBnldbm9xIcBm7c/OnkkRUyEvQR9BFYaz8ooavDP/a
         NNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897572; x=1742502372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1+ovjuk/hwy8z1EYzoOpjFaNZiPmAgrK0adxe0j0mI=;
        b=ibbkH3tuBLlHNvY/xEe67EupB0xSK06ns13mbPhMNsToKCzGn6JV8jgX5j6mBqdifT
         Ap82wRer3gubcLvp5OYdJ8YSZv4w5twxne3r8bYFWk9Q4sKU/JeYqulNhvs80tTRsw3E
         bHHJDtGCph/npcprEnbVFVTUOL7Pn5psYnOvjuw42dy5d741xQli1fyzCQ9t40dX7E+o
         ceyX/IurfFAnqUdo2EovWqzzCv6wXo6r8x6IRtXIO6vyHCf05fe1YzsBpA5BdG/YBkYN
         bDAsaMsf4wtg3apxQq2MYj3Vl5BtL0ASryCwOZbIEiLF0D42+Q692NQQhnrI4f4Y7AYJ
         RTew==
X-Gm-Message-State: AOJu0YxeujOdNgGOPdNbtTNvwz0m4GRuVuObKtTjCrPDYh/KXg+xNMs1
	ireifrxUm/cndeY3Z1tAPw91f+4N24Q3I8ABgNIszOBn+2RoHFrq0YPFSrKE
X-Gm-Gg: ASbGncujYrL4Z7QPCt3WGj8t2b7PVXUjXFULjs0vHw8vkineu5KcLB4CQaiotSUCo1+
	Rbc75fFIBI6bWpUqC2C+PMD6BR23vX+QrXXXGMdSKDuJS5IyBDnniaIfH4KCz9V7boN/JLyVoSq
	gkAT2S/AAlRJNQoIT4uVhvSIAZMxdQjAbK8asvsucmxVsoVJY4LiXzzlG5DTMKj80Ays3xFh8gu
	vtfDH6nOGA1X3LVObZ4RayDEeXJZOdw+iaS+VuHu/1O4DodL/RP0Ph5UR5lbz8gWCPF81K3VFAG
	X37wJDLguwnCz8CMAcmugq6f/sb7wG/RR/y+8ftqJ52IDVnV0YVr0BQV9muKsybQJXbRjkdOqRV
	fywvfZQ==
X-Google-Smtp-Source: AGHT+IEtRoh/CmBEp/dN5vZ8dbLf0qpvvvBFfLCv+V0tNXOz4Ce2G2QSWqEYu1TkRPdryWLeP18Ybw==
X-Received: by 2002:a05:6a21:4508:b0:1f5:97c3:419c with SMTP id adf61e73a8af0-1f5c119ce87mr118520637.6.1741897571935;
        Thu, 13 Mar 2025 13:26:11 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:11 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Wengang Wang <wen.gang.wang@oracle.com>,
	Srikanth C S <srikanth.c.s@oracle.com>,
	Dave Chinner <dchinner@redhat.com>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 09/29] xfs: reserve less log space when recovering log intent items
Date: Thu, 13 Mar 2025 13:25:29 -0700
Message-ID: <20250313202550.2257219-10-leah.rumancik@gmail.com>
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

[ Upstream commit 3c919b0910906cc69d76dea214776f0eac73358b ]

Wengang Wang reports that a customer's system was running a number of
truncate operations on a filesystem with a very small log.  Contention
on the reserve heads lead to other threads stalling on smaller updates
(e.g.  mtime updates) long enough to result in the node being rebooted
on account of the lack of responsivenes.  The node failed to recover
because log recovery of an EFI became stuck waiting for a grant of
reserve space.  From Wengang's report:

"For the file deletion, log bytes are reserved basing on
xfs_mount->tr_itruncate which is:

    tr_logres = 175488,
    tr_logcount = 2,
    tr_logflags = XFS_TRANS_PERM_LOG_RES,

"You see it's a permanent log reservation with two log operations (two
transactions in rolling mode).  After calculation (xlog_calc_unit_res()
adds space for various log headers), the final log space needed per
transaction changes from  175488 to 180208 bytes.  So the total log
space needed is 360416 bytes (180208 * 2).  [That quantity] of log space
(360416 bytes) needs to be reserved for both run time inode removing
(xfs_inactive_truncate()) and EFI recover (xfs_efi_item_recover())."

In other words, runtime pre-reserves 360K of space in anticipation of
running a chain of two transactions in which each transaction gets a
180K reservation.

Now that we've allocated the transaction, we delete the bmap mapping,
log an EFI to free the space, and roll the transaction as part of
finishing the deferops chain.  Rolling creates a new xfs_trans which
shares its ticket with the old transaction.  Next, xfs_trans_roll calls
__xfs_trans_commit with regrant == true, which calls xlog_cil_commit
with the same regrant parameter.

xlog_cil_commit calls xfs_log_ticket_regrant, which decrements t_cnt and
subtracts t_curr_res from the reservation and write heads.

If the filesystem is fresh and the first transaction only used (say)
20K, then t_curr_res will be 160K, and we give that much reservation
back to the reservation head.  Or if the file is really fragmented and
the first transaction actually uses 170K, then t_curr_res will be 10K,
and that's what we give back to the reservation.

Having done that, we're now headed into the second transaction with an
EFI and 180K of reservation.  Other threads apparently consumed all the
reservation for smaller transactions, such as timestamp updates.

Now let's say the first transaction gets written to disk and we crash
without ever completing the second transaction.  Now we remount the fs,
log recovery finds the unfinished EFI, and calls xfs_efi_recover to
finish the EFI.  However, xfs_efi_recover starts a new tr_itruncate
tranasction, which asks for 360K log reservation.  This is a lot more
than the 180K that we had reserved at the time of the crash.  If the
first EFI to be recovered is also pinning the tail of the log, we will
be unable to free any space in the log, and recovery livelocks.

Wengang confirmed this:

"Now we have the second transaction which has 180208 log bytes reserved
too. The second transaction is supposed to process intents including
extent freeing.  With my hacking patch, I blocked the extent freeing 5
hours. So in that 5 hours, 180208 (NOT 360416) log bytes are reserved.

"With my test case, other transactions (update timestamps) then happen.
As my hacking patch pins the journal tail, those timestamp-updating
transactions finally use up (almost) all the left available log space
(in memory in on disk).  And finally the on disk (and in memory)
available log space goes down near to 180208 bytes.  Those 180208 bytes
are reserved by [the] second (extent-free) transaction [in the chain]."

Wengang and I noticed that EFI recovery starts a transaction, completes
one step of the chain, and commits the transaction without completing
any other steps of the chain.  Those subsequent steps are completed by
xlog_finish_defer_ops, which allocates yet another transaction to
finish the rest of the chain.  That transaction gets the same tr_logres
as the head transaction, but with tr_logcount = 1 to force regranting
with every roll to avoid livelocks.

In other words, we already figured this out in commit 929b92f64048d
("xfs: xfs_defer_capture should absorb remaining transaction
reservation"), but should have applied that logic to each intent item's
recovery function.  For Wengang's case, the xfs_trans_alloc call in the
EFI recovery function should only be asking for a single transaction's
worth of log reservation -- 180K, not 360K.

Quoting Wengang again:

"With log recovery, during EFI recovery, we use tr_itruncate again to
reserve two transactions that needs 360416 log bytes.  Reserving 360416
bytes fails [stalls] because we now only have about 180208 available.

"Actually during the EFI recover, we only need one transaction to free
the extents just like the 2nd transaction at RUNTIME.  So it only needs
to reserve 180208 rather than 360416 bytes.  We have (a bit) more than
180208 available log bytes on disk, so [if we decrease the reservation
to 180K] the reservation goes and the recovery [finishes].  That is to
say: we can fix the log recover part to fix the issue. We can introduce
a new xfs_trans_res xfs_mount->tr_ext_free

{
  tr_logres = 175488,
  tr_logcount = 0,
  tr_logflags = 0,
}

"and use tr_ext_free instead of tr_itruncate in EFI recover."

However, I don't think it quite makes sense to create an entirely new
transaction reservation type to handle single-stepping during log
recovery.  Instead, we should copy the transaction reservation
information in the xfs_mount, change tr_logcount to 1, and pass that
into xfs_trans_alloc.  We know this won't risk changing the min log size
computation since we always ask for a fraction of the reservation for
all known transaction types.

This looks like it's been lurking in the codebase since commit
3d3c8b5222b92, which changed the xfs_trans_reserve call in
xlog_recover_process_efi to use the tr_logcount in tr_itruncate.
That changed the EFI recovery transaction from making a
non-XFS_TRANS_PERM_LOG_RES request for one transaction's worth of log
space to a XFS_TRANS_PERM_LOG_RES request for two transactions worth.

Fixes: 3d3c8b5222b92 ("xfs: refactor xfs_trans_reserve() interface")
Complements: 929b92f64048d ("xfs: xfs_defer_capture should absorb remaining transaction reservation")
Suggested-by: Wengang Wang <wen.gang.wang@oracle.com>
Cc: Srikanth C S <srikanth.c.s@oracle.com>
[djwong: apply the same transformation to all log intent recovery]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_log_recover.h | 22 ++++++++++++++++++++++
 fs/xfs/xfs_attr_item.c          |  7 ++++---
 fs/xfs/xfs_bmap_item.c          |  4 +++-
 fs/xfs/xfs_extfree_item.c       |  4 +++-
 fs/xfs/xfs_refcount_item.c      |  6 ++++--
 fs/xfs/xfs_rmap_item.c          |  6 ++++--
 6 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_log_recover.h b/fs/xfs/libxfs/xfs_log_recover.h
index 2420865f3007..a5100a11faf9 100644
--- a/fs/xfs/libxfs/xfs_log_recover.h
+++ b/fs/xfs/libxfs/xfs_log_recover.h
@@ -129,6 +129,28 @@ void xlog_free_buf_cancel_table(struct xlog *log);
 void xlog_check_buf_cancel_table(struct xlog *log);
 #else
 #define xlog_check_buf_cancel_table(log) do { } while (0)
 #endif
 
+/*
+ * Transform a regular reservation into one suitable for recovery of a log
+ * intent item.
+ *
+ * Intent recovery only runs a single step of the transaction chain and defers
+ * the rest to a separate transaction.  Therefore, we reduce logcount to 1 here
+ * to avoid livelocks if the log grant space is nearly exhausted due to the
+ * recovered intent pinning the tail.  Keep the same logflags to avoid tripping
+ * asserts elsewhere.  Struct copies abound below.
+ */
+static inline struct xfs_trans_res
+xlog_recover_resv(const struct xfs_trans_res *r)
+{
+	struct xfs_trans_res ret = {
+		.tr_logres	= r->tr_logres,
+		.tr_logcount	= 1,
+		.tr_logflags	= r->tr_logflags,
+	};
+
+	return ret;
+}
+
 #endif	/* __XFS_LOG_RECOVER_H__ */
diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index 2788a6f2edcd..36fe2abb16e6 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -545,11 +545,11 @@ xfs_attri_item_recover(
 	struct xfs_attr_intent		*attr;
 	struct xfs_mount		*mp = lip->li_log->l_mp;
 	struct xfs_inode		*ip;
 	struct xfs_da_args		*args;
 	struct xfs_trans		*tp;
-	struct xfs_trans_res		tres;
+	struct xfs_trans_res		resv;
 	struct xfs_attri_log_format	*attrp;
 	struct xfs_attri_log_nameval	*nv = attrip->attri_nameval;
 	int				error;
 	int				total;
 	int				local;
@@ -616,12 +616,13 @@ xfs_attri_item_recover(
 		ASSERT(0);
 		error = -EFSCORRUPTED;
 		goto out;
 	}
 
-	xfs_init_attr_trans(args, &tres, &total);
-	error = xfs_trans_alloc(mp, &tres, total, 0, XFS_TRANS_RESERVE, &tp);
+	xfs_init_attr_trans(args, &resv, &total);
+	resv = xlog_recover_resv(&resv);
+	error = xfs_trans_alloc(mp, &resv, total, 0, XFS_TRANS_RESERVE, &tp);
 	if (error)
 		goto out;
 
 	args->trans = tp;
 	done_item = xfs_trans_get_attrd(tp, attrip);
diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 13aa5359c02f..1058603db3ac 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -455,36 +455,38 @@ STATIC int
 xfs_bui_item_recover(
 	struct xfs_log_item		*lip,
 	struct list_head		*capture_list)
 {
 	struct xfs_bmap_intent		fake = { };
+	struct xfs_trans_res		resv;
 	struct xfs_bui_log_item		*buip = BUI_ITEM(lip);
 	struct xfs_trans		*tp;
 	struct xfs_inode		*ip = NULL;
 	struct xfs_mount		*mp = lip->li_log->l_mp;
 	struct xfs_map_extent		*map;
 	struct xfs_bud_log_item		*budp;
 	int				iext_delta;
 	int				error = 0;
 
 	if (!xfs_bui_validate(mp, buip)) {
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 				&buip->bui_format, sizeof(buip->bui_format));
 		return -EFSCORRUPTED;
 	}
 
 	map = &buip->bui_format.bui_extents[0];
 	fake.bi_whichfork = (map->me_flags & XFS_BMAP_EXTENT_ATTR_FORK) ?
 			XFS_ATTR_FORK : XFS_DATA_FORK;
 	fake.bi_type = map->me_flags & XFS_BMAP_EXTENT_TYPE_MASK;
 
 	error = xlog_recover_iget(mp, map->me_owner, &ip);
 	if (error)
 		return error;
 
 	/* Allocate transaction and do the work. */
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate,
+	resv = xlog_recover_resv(&M_RES(mp)->tr_itruncate);
+	error = xfs_trans_alloc(mp, &resv,
 			XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK), 0, 0, &tp);
 	if (error)
 		goto err_rele;
 
 	budp = xfs_trans_get_bud(tp, buip);
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index b670863d8467..3ed25c352269 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -596,33 +596,35 @@ xfs_efi_validate_ext(
 STATIC int
 xfs_efi_item_recover(
 	struct xfs_log_item		*lip,
 	struct list_head		*capture_list)
 {
+	struct xfs_trans_res		resv;
 	struct xfs_efi_log_item		*efip = EFI_ITEM(lip);
 	struct xfs_mount		*mp = lip->li_log->l_mp;
 	struct xfs_efd_log_item		*efdp;
 	struct xfs_trans		*tp;
 	int				i;
 	int				error = 0;
 
 	/*
 	 * First check the validity of the extents described by the
 	 * EFI.  If any are bad, then assume that all are bad and
 	 * just toss the EFI.
 	 */
 	for (i = 0; i < efip->efi_format.efi_nextents; i++) {
 		if (!xfs_efi_validate_ext(mp,
 					&efip->efi_format.efi_extents[i])) {
 			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 					&efip->efi_format,
 					sizeof(efip->efi_format));
 			return -EFSCORRUPTED;
 		}
 	}
 
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
+	resv = xlog_recover_resv(&M_RES(mp)->tr_itruncate);
+	error = xfs_trans_alloc(mp, &resv, 0, 0, 0, &tp);
 	if (error)
 		return error;
 	efdp = xfs_trans_get_efd(tp, efip, efip->efi_format.efi_nextents);
 
 	for (i = 0; i < efip->efi_format.efi_nextents; i++) {
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index ff4d5087ba00..dfd7b824e32b 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -451,10 +451,11 @@ xfs_cui_validate_phys(
 STATIC int
 xfs_cui_item_recover(
 	struct xfs_log_item		*lip,
 	struct list_head		*capture_list)
 {
+	struct xfs_trans_res		resv;
 	struct xfs_cui_log_item		*cuip = CUI_ITEM(lip);
 	struct xfs_cud_log_item		*cudp;
 	struct xfs_trans		*tp;
 	struct xfs_btree_cur		*rcur = NULL;
 	struct xfs_mount		*mp = lip->li_log->l_mp;
@@ -488,12 +489,13 @@ xfs_cui_item_recover(
 	 * refcount update.  However, we're in log recovery here, so we
 	 * use the passed in defer_ops and to finish up any work that
 	 * doesn't fit.  We need to reserve enough blocks to handle a
 	 * full btree split on either end of the refcount range.
 	 */
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate,
-			mp->m_refc_maxlevels * 2, 0, XFS_TRANS_RESERVE, &tp);
+	resv = xlog_recover_resv(&M_RES(mp)->tr_itruncate);
+	error = xfs_trans_alloc(mp, &resv, mp->m_refc_maxlevels * 2, 0,
+			XFS_TRANS_RESERVE, &tp);
 	if (error)
 		return error;
 
 	cudp = xfs_trans_get_cud(tp, cuip);
 
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 534504ede1a3..2043cea261c0 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -490,10 +490,11 @@ xfs_rui_validate_map(
 STATIC int
 xfs_rui_item_recover(
 	struct xfs_log_item		*lip,
 	struct list_head		*capture_list)
 {
+	struct xfs_trans_res		resv;
 	struct xfs_rui_log_item		*ruip = RUI_ITEM(lip);
 	struct xfs_map_extent		*rmap;
 	struct xfs_rud_log_item		*rudp;
 	struct xfs_trans		*tp;
 	struct xfs_btree_cur		*rcur = NULL;
@@ -517,12 +518,13 @@ xfs_rui_item_recover(
 					sizeof(ruip->rui_format));
 			return -EFSCORRUPTED;
 		}
 	}
 
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate,
-			mp->m_rmap_maxlevels, 0, XFS_TRANS_RESERVE, &tp);
+	resv = xlog_recover_resv(&M_RES(mp)->tr_itruncate);
+	error = xfs_trans_alloc(mp, &resv, mp->m_rmap_maxlevels, 0,
+			XFS_TRANS_RESERVE, &tp);
 	if (error)
 		return error;
 	rudp = xfs_trans_get_rud(tp, ruip);
 
 	for (i = 0; i < ruip->rui_format.rui_nextents; i++) {
-- 
2.49.0.rc1.451.g8f38331e32-goog


