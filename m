Return-Path: <stable+bounces-114299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A281CA2CC93
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 20:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF96C3A750D
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 19:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38161A3143;
	Fri,  7 Feb 2025 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3BO899o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E55218DB0E;
	Fri,  7 Feb 2025 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956503; cv=none; b=KU5ObedIxPzCBCEKDgPb/letyXDNc/ytAiqLqQEX5dtNsDVWCEUcGhc38tqBJssiYakzEn/goj6IEpMcQME9YDvMulCj86WJ/o1IXHeb7Uo6KL2pWV3yYMqZoJvlnfSGdbwpUK1jbYRu6TGEXfBS6To5R0jPXuLgMU20hDmWrOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956503; c=relaxed/simple;
	bh=4ZECNobaFzxt9Or5NvV4cggnExEAX6q3z1LlwRVSvnM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TR8sKs6b43/pHUF6xgQ+zxR9NHpIkcLSljFeYqdoY9V5DgdeLlQXI2hzakCFxy0h7MjgEEYANrEDzFaho0bc7ZwH/ZmCYMOvjP4ljQVzLV4CkYZBHTsBSrm5YiIGv3Lk9wM5fJlam4o+EWc9ZHOJRXZT8yOiiFXc9Ub4+hYuPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3BO899o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B50C4CED1;
	Fri,  7 Feb 2025 19:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738956503;
	bh=4ZECNobaFzxt9Or5NvV4cggnExEAX6q3z1LlwRVSvnM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=d3BO899om4c7HCSjP3Qoubw7p/3DuR30dQJo7REH8MTrTiBLCcXy2GCsiZogwLdeZ
	 yubTRlGC9TFb/kvQ+tck0UAFI0O66WI9/rFZMiR1rTb1q/ddWc4uAt9ozmyNnJk4S6
	 +LEmyxNLD1P8LoHc68GZCCbIddFggHoErNXhtioF76uCyRDbA3afTE/6tad/UUZzCU
	 qDNxKOHHCH0RGEy9qEOSDJ5iGjfZgXeFejgkpeXSXBbaH2ZKtgT9DL6ADm/jARFAh5
	 0zM8iAEpbGpl9PoOXGGDnvSGCxgShBl/d5RTyhwll3F3Ia4xQVkTyZUX9G0f/ICoAs
	 guE/bgynDUBzQ==
Date: Fri, 07 Feb 2025 11:28:22 -0800
Subject: [PATCH 08/11] xfs: don't over-report free space or inodes in statvfs
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, xfs-stable@lists.linux.dev
Cc: eflorac@intellique.com, hch@lst.de, stable@vger.kernel.org
Message-ID: <173895601533.3373740.2618546126593574372.stgit@frogsfrogsfrogs>
In-Reply-To: <173895601380.3373740.10524153147164865557.stgit@frogsfrogsfrogs>
References: <173895601380.3373740.10524153147164865557.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

commit 4b8d867ca6e2fc6d152f629fdaf027053b81765a upstream

Emmanual Florac reports a strange occurrence when project quota limits
are enabled, free space is lower than the remaining quota, and someone
runs statvfs:

  # mkfs.xfs -f /dev/sda
  # mount /dev/sda /mnt -o prjquota
  # xfs_quota  -x -c 'limit -p bhard=2G 55' /mnt
  # mkdir /mnt/dir
  # xfs_io -c 'chproj 55' -c 'chattr +P' -c 'stat -vvvv' /mnt/dir
  # fallocate -l 19g /mnt/a
  # df /mnt /mnt/dir
  Filesystem      Size  Used Avail Use% Mounted on
  /dev/sda         20G   20G  345M  99% /mnt
  /dev/sda        2.0G     0  2.0G   0% /mnt

I think the bug here is that xfs_fill_statvfs_from_dquot unconditionally
assigns to f_bfree without checking that the filesystem has enough free
space to fill the remaining project quota.  However, this is a
longstanding behavior of xfs so it's unclear what to do here.

Cc: <stable@vger.kernel.org> # v2.6.18
Fixes: 932f2c323196c2 ("[XFS] statvfs component of directory/project quota support, code originally by Glen.")
Reported-by: Emmanuel Florac <eflorac@intellique.com>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_qm_bhv.c |   27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)


diff --git a/fs/xfs/xfs_qm_bhv.c b/fs/xfs/xfs_qm_bhv.c
index a11436579877d5..410a2a9c18ec52 100644
--- a/fs/xfs/xfs_qm_bhv.c
+++ b/fs/xfs/xfs_qm_bhv.c
@@ -26,21 +26,28 @@ xfs_fill_statvfs_from_dquot(
 	limit = dqp->q_blk.softlimit ?
 		dqp->q_blk.softlimit :
 		dqp->q_blk.hardlimit;
-	if (limit && statp->f_blocks > limit) {
-		statp->f_blocks = limit;
-		statp->f_bfree = statp->f_bavail =
-			(statp->f_blocks > dqp->q_blk.reserved) ?
-			 (statp->f_blocks - dqp->q_blk.reserved) : 0;
+	if (limit) {
+		uint64_t	remaining = 0;
+
+		if (limit > dqp->q_blk.reserved)
+			remaining = limit - dqp->q_blk.reserved;
+
+		statp->f_blocks = min(statp->f_blocks, limit);
+		statp->f_bfree = min(statp->f_bfree, remaining);
+		statp->f_bavail = min(statp->f_bavail, remaining);
 	}
 
 	limit = dqp->q_ino.softlimit ?
 		dqp->q_ino.softlimit :
 		dqp->q_ino.hardlimit;
-	if (limit && statp->f_files > limit) {
-		statp->f_files = limit;
-		statp->f_ffree =
-			(statp->f_files > dqp->q_ino.reserved) ?
-			 (statp->f_files - dqp->q_ino.reserved) : 0;
+	if (limit) {
+		uint64_t	remaining = 0;
+
+		if (limit > dqp->q_ino.reserved)
+			remaining = limit - dqp->q_ino.reserved;
+
+		statp->f_files = min(statp->f_files, limit);
+		statp->f_ffree = min(statp->f_ffree, remaining);
 	}
 }
 


