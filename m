Return-Path: <stable+bounces-35703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716AD896FBB
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 15:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6CAAB228E0
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 13:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635661482E8;
	Wed,  3 Apr 2024 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dkQWbw6M"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AC3146D4A
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149275; cv=none; b=quQVUsCkqgOzXLtJwRpO/ybiBbIQRgh4aVqYuFu8lCfjixXxnxjfwHX94u4iaFnWj8pnED9QW7Dg5BJZ76HcOJOE3jEIbyLIgiLgjemHldKNWQuu8GX1ZZNY7za+uPHvi6mzAksMV4XXkhquQDq2nWWMK0peYG8hjBvJw3hgU5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149275; c=relaxed/simple;
	bh=2q3a6mxs9oMxWzT3Yzu5Dm2PqN7SMmdfudoG8MmFPGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atY8IrFNCaaxq+jGjya6rrYtD4bA2msyKS4EMXnR9W5EzI0u3/z/PKx4yLXtPrTSKs0iF4YTQ+pDGy8Asr7PQ7Sl6m5n3f+MRZGUkC5nyyX+nSp/a3WPKkCn6RqmhtmdfdGh488QwedIC0mzJ2h1kdjetG/y9ZB9lfzWvbop4zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dkQWbw6M; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712149274; x=1743685274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GKRb+WXQ/nV4FUOpWEXxJjV1fWRFFGVh5DFIqRx9+5c=;
  b=dkQWbw6M1IMJDIH0/qHRnd/XmTFDz7IeKiV4vQTgVxzx3no68W0l2T3q
   0rr/5cBHmJJF5k0wiYa/O4WKFaJ5dOWO/a9VnUGQ14AugH7oaMqisOPnG
   BOOHSCsLOHp2bvSYdi9w1ovzQp1weSvmq6ktDPscsLd7niv0wQjkiz0iM
   E=;
X-IronPort-AV: E=Sophos;i="6.07,177,1708387200"; 
   d="scan'208";a="408799027"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 13:01:06 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:43632]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.206:2525] with esmtp (Farcaster)
 id 1c3895eb-bd46-4dba-b256-80f65a14346e; Wed, 3 Apr 2024 13:01:05 +0000 (UTC)
X-Farcaster-Flow-ID: 1c3895eb-bd46-4dba-b256-80f65a14346e
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 13:01:05 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 3 Apr 2024 13:01:05 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id 1B2DABE6; Wed,  3 Apr 2024 15:01:05 +0200 (CEST)
From: Mahmoud Adam <mngyadam@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <djwong@kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 6.1 2/6] xfs: fix log recovery when unknown rocompat bits are set
Date: Wed, 3 Apr 2024 14:59:49 +0200
Message-ID: <20240403125949.33676-3-mngyadam@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240403125949.33676-1-mngyadam@amazon.com>
References: <20240403125949.33676-1-mngyadam@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: "Darrick J. Wong" <djwong@kernel.org>

commit 74ad4693b6473950e971b3dc525b5ee7570e05d0 upstream.

Log recovery has always run on read only mounts, even where the primary
superblock advertises unknown rocompat bits.  Due to a misunderstanding
between Eric and Darrick back in 2018, we accidentally changed the
superblock write verifier to shutdown the fs over that exact scenario.
As a result, the log cleaning that occurs at the end of the mounting
process fails if there are unknown rocompat bits set.

As we now allow writing of the superblock if there are unknown rocompat
bits set on a RO mount, we no longer want to turn off RO state to allow
log recovery to succeed on a RO mount.  Hence we also remove all the
(now unnecessary) RO state toggling from the log recovery path.

Fixes: 9e037cb7972f ("xfs: check for unknown v5 feature bits in superblock write verifier"
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
---
 fs/xfs/libxfs/xfs_sb.c |  3 ++-
 fs/xfs/xfs_log.c       | 17 -----------------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index b6a584e044be..7fae732486a9 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -266,7 +266,8 @@ xfs_validate_sb_write(
 		return -EFSCORRUPTED;
 	}

-	if (xfs_sb_has_ro_compat_feature(sbp, XFS_SB_FEAT_RO_COMPAT_UNKNOWN)) {
+	if (!xfs_is_readonly(mp) &&
+	    xfs_sb_has_ro_compat_feature(sbp, XFS_SB_FEAT_RO_COMPAT_UNKNOWN)) {
 		xfs_alert(mp,
 "Corruption detected in superblock read-only compatible features (0x%x)!",
 			(sbp->sb_features_ro_compat &
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index f02a0dd522b3..83381d38efbe 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -730,15 +730,7 @@ xfs_log_mount(
 	 * just worked.
 	 */
 	if (!xfs_has_norecovery(mp)) {
-		/*
-		 * log recovery ignores readonly state and so we need to clear
-		 * mount-based read only state so it can write to disk.
-		 */
-		bool	readonly = test_and_clear_bit(XFS_OPSTATE_READONLY,
-						&mp->m_opstate);
 		error = xlog_recover(log);
-		if (readonly)
-			set_bit(XFS_OPSTATE_READONLY, &mp->m_opstate);
 		if (error) {
 			xfs_warn(mp, "log mount/recovery failed: error %d",
 				error);
@@ -787,7 +779,6 @@ xfs_log_mount_finish(
 	struct xfs_mount	*mp)
 {
 	struct xlog		*log = mp->m_log;
-	bool			readonly;
 	int			error = 0;

 	if (xfs_has_norecovery(mp)) {
@@ -795,12 +786,6 @@ xfs_log_mount_finish(
 		return 0;
 	}

-	/*
-	 * log recovery ignores readonly state and so we need to clear
-	 * mount-based read only state so it can write to disk.
-	 */
-	readonly = test_and_clear_bit(XFS_OPSTATE_READONLY, &mp->m_opstate);
-
 	/*
 	 * During the second phase of log recovery, we need iget and
 	 * iput to behave like they do for an active filesystem.
@@ -850,8 +835,6 @@ xfs_log_mount_finish(
 	xfs_buftarg_drain(mp->m_ddev_targp);

 	clear_bit(XLOG_RECOVERY_NEEDED, &log->l_opstate);
-	if (readonly)
-		set_bit(XFS_OPSTATE_READONLY, &mp->m_opstate);

 	/* Make sure the log is dead if we're returning failure. */
 	ASSERT(!error || xlog_is_shutdown(log));
--
2.40.1

