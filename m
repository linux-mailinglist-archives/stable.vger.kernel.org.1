Return-Path: <stable+bounces-136938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11065A9F8B7
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CC51A8515A
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA8727A92F;
	Mon, 28 Apr 2025 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+w3Dpb2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD961BBBFD;
	Mon, 28 Apr 2025 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745865561; cv=none; b=lPF4gLuQfnoNmICxdzpntofOn3Gpd4QKW5I84zNCg4ocb9V9VIBNdQfEri/SVZxkEEt+SwFIopwVxfKJWyn1HvdLuJs4svDpjS309C3QGS03SX0j+JjHVFGS/1jUQ/tTep4pUCb6lJsr9zJo6fH0eCUH+0xLBmF+Cts4rR/zK9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745865561; c=relaxed/simple;
	bh=mYzNm7dvSwQcGW9FeZcx/ZqsvYu8Skq5g/8/uxIr28s=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNkZQ/NFhFLWDRWrlvTvgOSIYqu0I0YTH1dXiB4ISUHDnyv3uD55rE3RmSFiXKfLL46ONTCRoWr6nzo4ZXOtpvtVjebvsdFAJTn8Dm7vE4iPZDW4XsSdu732RTF5yv2eaPiZPi0dnPQEbESXOVnzHOzs023ZbDQrNY8Md35BUbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+w3Dpb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E04DC4CEE4;
	Mon, 28 Apr 2025 18:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745865560;
	bh=mYzNm7dvSwQcGW9FeZcx/ZqsvYu8Skq5g/8/uxIr28s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=t+w3Dpb2/KDR16EmpkIrX61/hzbLklUTU8fwNqsA9fxl5DQ1GocPh40vKdIupn8Uz
	 FjhWfhyQ2DbUez2eOLe3soNh/JJz/y7/+zNNL3vKrre1mZWUoBcwQq+e8qpeee4NyJ
	 TUUHsv8dH5sPCWmFnJpvJoqPat/pkpdIQvlchLjif0vcBJv2utbCIPn4OfSPeHnaBI
	 4oQq81VmxCdQXRTNl9s4/eBrlrkau4H9ZG4DDVooQpIEvtarw8ThPsiZC3xEg/tyg/
	 nOi3ckSOJ+CVEu+w/ekLkGerP/DRJj6Zdn6WeTWULTfHf7vxuo/ldjz3usn1uA4e82
	 KF+aa/Efbrbgg==
Date: Mon, 28 Apr 2025 11:39:19 -0700
Subject: [PATCH 1/4] xfs: do not check NEEDSREPAIR if ro,norecovery mount.
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, xfs-stable@lists.linux.dev
Cc: cem@kernel.org, dchinner@redhat.com, lukas@herbolt.com,
 sandeen@redhat.com, stable@vger.kernel.org
Message-ID: <174586545399.480536.11556523767440235148.stgit@frogsfrogsfrogs>
In-Reply-To: <174586545357.480536.7498456094082551730.stgit@frogsfrogsfrogs>
References: <174586545357.480536.7498456094082551730.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Lukas Herbolt <lukas@herbolt.com>

Commit 9e00163c31676c6b43d2334fdf5b406232f42dee upstream

If there is corrutpion on the filesystem andxfs_repair
fails to repair it. The last resort of getting the data
is to use norecovery,ro mount. But if the NEEDSREPAIR is
set the filesystem cannot be mounted. The flag must be
cleared out manually using xfs_db, to get access to what
left over of the corrupted fs.

Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_super.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)


diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 8f7c9eaeb36090..201a86b3574da5 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1619,8 +1619,12 @@ xfs_fs_fill_super(
 #endif
 	}
 
-	/* Filesystem claims it needs repair, so refuse the mount. */
-	if (xfs_has_needsrepair(mp)) {
+	/*
+	 * Filesystem claims it needs repair, so refuse the mount unless
+	 * norecovery is also specified, in which case the filesystem can
+	 * be mounted with no risk of further damage.
+	 */
+	if (xfs_has_needsrepair(mp) && !xfs_has_norecovery(mp)) {
 		xfs_warn(mp, "Filesystem needs repair.  Please run xfs_repair.");
 		error = -EFSCORRUPTED;
 		goto out_free_sb;


