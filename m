Return-Path: <stable+bounces-8761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C56248204C4
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02EEC1C20E20
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C3879EF;
	Sat, 30 Dec 2023 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GJkXMsGB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D307D79DD;
	Sat, 30 Dec 2023 12:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D97C433C7;
	Sat, 30 Dec 2023 12:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937694;
	bh=ljRg3R1ux7yL9hWVJW1E75/G4m0WURBKPuzwpxUlRXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJkXMsGBTkj/BlIEY1r4FypObgHKDewQAqGEzvW213lEn2OmJ29zukrMPms9lBmfs
	 cNeCdyncw0Y0Gf8mIoqDTZpYk9K2vCmxRJcj/P8Oi/rzPWZM0x+TzoiCVXH05yTZq0
	 VNXfRFZkTJt82FW3teW1NetUOXDRaCLNLqKkKYtk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 004/156] btrfs: qgroup: iterate qgroups without memory allocation for qgroup_reserve()
Date: Sat, 30 Dec 2023 11:57:38 +0000
Message-ID: <20231230115812.495894317@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
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

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 686c4a5a42635e0d2889e3eb461c554fd0b616b4 ]

Qgroup heavily relies on ulist to go through all the involved
qgroups, but since we're using ulist inside fs_info->qgroup_lock
spinlock, this means we're doing a lot of GFP_ATOMIC allocations.

This patch reduces the GFP_ATOMIC usage for qgroup_reserve() by
eliminating the memory allocation completely.

This is done by moving the needed memory to btrfs_qgroup::iterator
list_head, so that we can put all the involved qgroup into a on-stack
list, thus eliminating the need to allocate memory while holding
spinlock.

The only cost is the slightly higher memory usage, but considering the
reduce GFP_ATOMIC during a hot path, it should still be acceptable.

Function qgroup_reserve() is the perfect start point for this
conversion.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: b321a52cce06 ("btrfs: free qgroup pertrans reserve on transaction abort")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 61 ++++++++++++++++++++++-------------------------
 fs/btrfs/qgroup.h |  9 +++++++
 2 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 7c92494381549..32e5defe4eff4 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -208,6 +208,7 @@ static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&qgroup->groups);
 	INIT_LIST_HEAD(&qgroup->members);
 	INIT_LIST_HEAD(&qgroup->dirty);
+	INIT_LIST_HEAD(&qgroup->iterator);
 
 	rb_link_node(&qgroup->node, parent, p);
 	rb_insert_color(&qgroup->node, &fs_info->qgroup_tree);
@@ -1342,6 +1343,24 @@ static void qgroup_dirty(struct btrfs_fs_info *fs_info,
 		list_add(&qgroup->dirty, &fs_info->dirty_qgroups);
 }
 
+static void qgroup_iterator_add(struct list_head *head, struct btrfs_qgroup *qgroup)
+{
+	if (!list_empty(&qgroup->iterator))
+		return;
+
+	list_add_tail(&qgroup->iterator, head);
+}
+
+static void qgroup_iterator_clean(struct list_head *head)
+{
+	while (!list_empty(head)) {
+		struct btrfs_qgroup *qgroup;
+
+		qgroup = list_first_entry(head, struct btrfs_qgroup, iterator);
+		list_del_init(&qgroup->iterator);
+	}
+}
+
 /*
  * The easy accounting, we're updating qgroup relationship whose child qgroup
  * only has exclusive extents.
@@ -3125,8 +3144,7 @@ static int qgroup_reserve(struct btrfs_root *root, u64 num_bytes, bool enforce,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 ref_root = root->root_key.objectid;
 	int ret = 0;
-	struct ulist_node *unode;
-	struct ulist_iterator uiter;
+	LIST_HEAD(qgroup_list);
 
 	if (!is_fstree(ref_root))
 		return 0;
@@ -3146,49 +3164,28 @@ static int qgroup_reserve(struct btrfs_root *root, u64 num_bytes, bool enforce,
 	if (!qgroup)
 		goto out;
 
-	/*
-	 * in a first step, we check all affected qgroups if any limits would
-	 * be exceeded
-	 */
-	ulist_reinit(fs_info->qgroup_ulist);
-	ret = ulist_add(fs_info->qgroup_ulist, qgroup->qgroupid,
-			qgroup_to_aux(qgroup), GFP_ATOMIC);
-	if (ret < 0)
-		goto out;
-	ULIST_ITER_INIT(&uiter);
-	while ((unode = ulist_next(fs_info->qgroup_ulist, &uiter))) {
-		struct btrfs_qgroup *qg;
+	qgroup_iterator_add(&qgroup_list, qgroup);
+	list_for_each_entry(qgroup, &qgroup_list, iterator) {
 		struct btrfs_qgroup_list *glist;
 
-		qg = unode_aux_to_qgroup(unode);
-
-		if (enforce && !qgroup_check_limits(qg, num_bytes)) {
+		if (enforce && !qgroup_check_limits(qgroup, num_bytes)) {
 			ret = -EDQUOT;
 			goto out;
 		}
 
-		list_for_each_entry(glist, &qg->groups, next_group) {
-			ret = ulist_add(fs_info->qgroup_ulist,
-					glist->group->qgroupid,
-					qgroup_to_aux(glist->group), GFP_ATOMIC);
-			if (ret < 0)
-				goto out;
-		}
+		list_for_each_entry(glist, &qgroup->groups, next_group)
+			qgroup_iterator_add(&qgroup_list, glist->group);
 	}
+
 	ret = 0;
 	/*
 	 * no limits exceeded, now record the reservation into all qgroups
 	 */
-	ULIST_ITER_INIT(&uiter);
-	while ((unode = ulist_next(fs_info->qgroup_ulist, &uiter))) {
-		struct btrfs_qgroup *qg;
-
-		qg = unode_aux_to_qgroup(unode);
-
-		qgroup_rsv_add(fs_info, qg, num_bytes, type);
-	}
+	list_for_each_entry(qgroup, &qgroup_list, iterator)
+		qgroup_rsv_add(fs_info, qgroup, num_bytes, type);
 
 out:
+	qgroup_iterator_clean(&qgroup_list);
 	spin_unlock(&fs_info->qgroup_lock);
 	return ret;
 }
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 104c9bd3c3379..1203f06320991 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -220,6 +220,15 @@ struct btrfs_qgroup {
 	struct list_head groups;  /* groups this group is member of */
 	struct list_head members; /* groups that are members of this group */
 	struct list_head dirty;   /* dirty groups */
+
+	/*
+	 * For qgroup iteration usage.
+	 *
+	 * The iteration list should always be empty until qgroup_iterator_add()
+	 * is called.  And should be reset to empty after the iteration is
+	 * finished.
+	 */
+	struct list_head iterator;
 	struct rb_node node;	  /* tree of qgroups */
 
 	/*
-- 
2.43.0




