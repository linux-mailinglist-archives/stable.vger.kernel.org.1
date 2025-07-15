Return-Path: <stable+bounces-162418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9609B05DDA
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9231E1C26E0D
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD6C2E6125;
	Tue, 15 Jul 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cEuaeef2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8B42E610D;
	Tue, 15 Jul 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586502; cv=none; b=S+hPHErHzqHCPrppZJaFL67L2smDEYC8xxJZKJxVQCATPvcnZtWqze7/j8nZZROd/RF4CsblMSKz2pZJqJdGWAFuRpB/yyYI20jsOpLDCGYrSaGxQFia74PsN0eTxFGUREymiA4QFwsPsL+hrfecHOz/pweXmdfD7UdXjLhzi3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586502; c=relaxed/simple;
	bh=Or4iJUtJm7yygzatVXXtKlsCW2+mBUoAjGqe3E1wO8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkqEuWZw70YXADaV0HWYb5vne0Jq22E6RyOrRg09MK21aM81sEN9Ln9CPyCTPz+Oot4hm/dprAc47sNKpkhzxypYIDYQA+v+LhAj6iFuuKR3WeZwvWqf3Ha4Fem6BCuSLIrUlWYcfy9AO6hIG0onnLBCjCWu4Ixz/tbRZkXiKc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cEuaeef2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A3EC4CEF1;
	Tue, 15 Jul 2025 13:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586502;
	bh=Or4iJUtJm7yygzatVXXtKlsCW2+mBUoAjGqe3E1wO8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEuaeef2c3xE/X21UrHqLqqde1nHaLezYd24zVWWq4oIBwLJKKMUkAdAImDMpqQIl
	 TEHD1rLMQ1mNuE1aRZYtJilaE+6+OLvnoX4C6SCqcZEY8re/LNa7o8kr9kLO4mbrFX
	 vy8+p0TmgN0cozZpZokajn4rrP6NtTxqCFMms2GA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 089/148] btrfs: use btrfs_record_snapshot_destroy() during rmdir
Date: Tue, 15 Jul 2025 15:13:31 +0200
Message-ID: <20250715130803.880344161@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130800.293690950@linuxfoundation.org>
References: <20250715130800.293690950@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 157501b0469969fc1ba53add5049575aadd79d80 ]

We are setting the parent directory's last_unlink_trans directly which
may result in a concurrent task starting to log the directory not see the
update and therefore can log the directory after we removed a child
directory which had a snapshot within instead of falling back to a
transaction commit. Replaying such a log tree would result in a mount
failure since we can't currently delete snapshots (and subvolumes) during
log replay. This is the type of failure described in commit 1ec9a1ae1e30
("Btrfs: fix unreplayable log after snapshot delete + parent dir fsync").

Fix this by using btrfs_record_snapshot_destroy() which updates the
last_unlink_trans field while holding the inode's log_mutex lock.

Fixes: 44f714dae50a ("Btrfs: improve performance on fsync against new inode after rename/unlink")
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8f92f998dc37b..757111e529948 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4772,7 +4772,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	 * deletes for directory foo.
 	 */
 	if (BTRFS_I(inode)->last_unlink_trans >= trans->transid)
-		BTRFS_I(dir)->last_unlink_trans = BTRFS_I(inode)->last_unlink_trans;
+		btrfs_record_snapshot_destroy(trans, BTRFS_I(dir));
 
 	if (unlikely(btrfs_ino(BTRFS_I(inode)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
 		err = btrfs_unlink_subvol(trans, dir, dentry);
-- 
2.39.5




