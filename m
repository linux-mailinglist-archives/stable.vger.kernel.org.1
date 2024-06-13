Return-Path: <stable+bounces-51224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3003C906EE2
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD7C1F23049
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21647145A1D;
	Thu, 13 Jun 2024 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gK5WOy/M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48FF13D881;
	Thu, 13 Jun 2024 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280670; cv=none; b=BXfxTfzYBMo2HYYv34Icf2xrIbFlUb/LySVjhKYS9bhvQbEqowXstJkHBL36ndxl6xPYtFZwo9oqWQUmB5gTId9fCAM31GJlpK5CWVcb6LOy2EmFkaTjHGudUZ+raZo10e7WuucJIt/bgwWq8dF/O3hBt6bKOTCf+V6mPip4Yjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280670; c=relaxed/simple;
	bh=qA+Z/OM+yzaNFgN8yN/ioCx/l6mAzWiNzmwEfKGKwvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBLWzwnD6OzyiZU5k5P838gxpaVMV831CuzzeilsIkcz1ZL4X4odBUi4la87RSvaYXQuhMWicEu0y/H+pwAC+thZtOXZ0N1D75HkOX6HHaGLU+SmmjOCHsWv9uOnkWTNkOvVK/+Mz482gXg3WuXCse/1oUqtwwjJv2xn3MFBS8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gK5WOy/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B371C2BBFC;
	Thu, 13 Jun 2024 12:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280670;
	bh=qA+Z/OM+yzaNFgN8yN/ioCx/l6mAzWiNzmwEfKGKwvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gK5WOy/MVObaFaXS/IMp7NqudqKzL7718DdTJKtIsoinZneYZXAdN9Cqntin4Lkuw
	 hr7vryb0ofeiuebwI1eWOOGkwaf+6F9bNjVKs3ArD3rTyB02c1Kftl9Eiju/YeIHgq
	 X1dqMfthd/a4LU9qNpuIXxhAs+1CeaizLGbAD40Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+0fecc032fa134afd49df@syzkaller.appspotmail.com,
	Josef Bacik <josef@toxicpanda.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6 132/137] btrfs: fix leak of qgroup extent records after transaction abort
Date: Thu, 13 Jun 2024 13:35:12 +0200
Message-ID: <20240613113228.421217297@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
References: <20240613113223.281378087@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit fb33eb2ef0d88e75564983ef057b44c5b7e4fded upstream.

Qgroup extent records are created when delayed ref heads are created and
then released after accounting extents at btrfs_qgroup_account_extents(),
called during the transaction commit path.

If a transaction is aborted we free the qgroup records by calling
btrfs_qgroup_destroy_extent_records() at btrfs_destroy_delayed_refs(),
unless we don't have delayed references. We are incorrectly assuming
that no delayed references means we don't have qgroup extents records.

We can currently have no delayed references because we ran them all
during a transaction commit and the transaction was aborted after that
due to some error in the commit path.

So fix this by ensuring we btrfs_qgroup_destroy_extent_records() at
btrfs_destroy_delayed_refs() even if we don't have any delayed references.

Reported-by: syzbot+0fecc032fa134afd49df@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/0000000000004e7f980619f91835@google.com/
Fixes: 81f7eb00ff5b ("btrfs: destroy qgroup extent records on transaction abort")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/disk-io.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4594,18 +4594,10 @@ static void btrfs_destroy_delayed_refs(s
 				       struct btrfs_fs_info *fs_info)
 {
 	struct rb_node *node;
-	struct btrfs_delayed_ref_root *delayed_refs;
+	struct btrfs_delayed_ref_root *delayed_refs = &trans->delayed_refs;
 	struct btrfs_delayed_ref_node *ref;
 
-	delayed_refs = &trans->delayed_refs;
-
 	spin_lock(&delayed_refs->lock);
-	if (atomic_read(&delayed_refs->num_entries) == 0) {
-		spin_unlock(&delayed_refs->lock);
-		btrfs_debug(fs_info, "delayed_refs has NO entry");
-		return;
-	}
-
 	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
 		struct btrfs_delayed_ref_head *head;
 		struct rb_node *n;



