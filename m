Return-Path: <stable+bounces-171588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D929B2AB21
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7161BC3154
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC0635A29C;
	Mon, 18 Aug 2025 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l2A+qoa1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CE335A297;
	Mon, 18 Aug 2025 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526439; cv=none; b=n7YFDLFdrFouQ3PP/ytbWDsX7HivoxdsAwrCDu52RBLUblSUaNtCu4fCHlS+5eFDyLnm23kkTMZeZ9idciWYxTPl1sZhcl9LdSOL9t07PYER16GAawKJzq2sVqIQDLlLJJUjS+slCYfwmPSLqCxdUaMaPJbiAj5ZBB6NzDkw8P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526439; c=relaxed/simple;
	bh=fyptKZTuHsQPTaxvL76jSBi+oi+1vl/uUCr5y5JZmdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoEoEZCHll73Irgm5pC79a3N6UOoPzTBpqY9KKR5hTbDJOEcDa15ZEtEPXo3dsFFr4Btfox0g9FgSe2AzUlkOscajzX/GV32bs2fMlgDQOEOb3V0UfvPxaLcy9nHxWt7E3X9AUAcIaXKcT0Q3Yj4aRf3kpibR9ayYxqQ+daYS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l2A+qoa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2C4C4CEEB;
	Mon, 18 Aug 2025 14:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755526439;
	bh=fyptKZTuHsQPTaxvL76jSBi+oi+1vl/uUCr5y5JZmdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l2A+qoa1sd94bGmFilh2FtB95skAQgHdQUifcx7sUuD/K17vQbdyVxkUHscmyC3VE
	 OkUG9MSxFAG4P4TPNvhfB7nHV7uZ18RArKtCdWPUpMt7Hypp3qcTjjD/IvQHqgCUjK
	 XFlPfgyjcUgI24XXzNiPuSQsBEFvvQR7TnoXLbic=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.16 523/570] btrfs: qgroup: fix qgroup create ioctl returning success after quotas disabled
Date: Mon, 18 Aug 2025 14:48:30 +0200
Message-ID: <20250818124526.014628694@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 08530d6e638427e7e1344bd67bacc03882ba95b9 upstream.

When quotas are disabled qgroup ioctls are supposed to return -ENOTCONN,
but the qgroup create ioctl stopped doing that when it races with a quota
disable operation, returning 0 instead. This change of behaviour happened
in commit 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot
creation").

The issue happens as follows:

1) Task A enters btrfs_ioctl_qgroup_create(), qgroups are enabled and so
   qgroup_enabled() returns true since fs_info->quota_root is not NULL;

2) Task B enters btrfs_ioctl_quota_ctl() -> btrfs_quota_disable() and
   disables qgroups, so now fs_info->quota_root is NULL;

3) Task A enters btrfs_create_qgroup() and calls btrfs_qgroup_mode(),
   which returns BTRFS_QGROUP_MODE_DISABLED since quotas are disabled,
   and then btrfs_create_qgroup() returns 0 to the caller, which makes
   the ioctl return 0 instead of -ENOTCONN.

   The check for fs_info->quota_root and returning -ENOTCONN if it's NULL
   is made only after the call btrfs_qgroup_mode().

Fix this by moving the check for disabled quotas with btrfs_qgroup_mode()
into transaction.c:create_pending_snapshot(), so that we don't abort the
transaction if btrfs_create_qgroup() returns -ENOTCONN and quotas are
disabled.

Fixes: 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot creation")
CC: stable@vger.kernel.org # 6.12+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/qgroup.c      |    3 ---
 fs/btrfs/transaction.c |    6 ++++--
 2 files changed, 4 insertions(+), 5 deletions(-)

--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1690,9 +1690,6 @@ int btrfs_create_qgroup(struct btrfs_tra
 	struct btrfs_qgroup *prealloc = NULL;
 	int ret = 0;
 
-	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
-		return 0;
-
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
 		ret = -ENOTCONN;
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1735,8 +1735,10 @@ static noinline int create_pending_snaps
 
 	ret = btrfs_create_qgroup(trans, objectid);
 	if (ret && ret != -EEXIST) {
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
+		if (ret != -ENOTCONN || btrfs_qgroup_enabled(fs_info)) {
+			btrfs_abort_transaction(trans, ret);
+			goto fail;
+		}
 	}
 
 	/*



