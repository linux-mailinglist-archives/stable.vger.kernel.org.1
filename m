Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06509775C6A
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjHIL1M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjHIL1L (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:27:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCF9FA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:27:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F7DC6324C
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B248FC433C8;
        Wed,  9 Aug 2023 11:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580430;
        bh=sftnswOuJU47Y3jnjWsUs3kn1k3dujQUxEA0/mFR7Vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o7YS0tUTdjQ9Wpd9qw/UzEim8gffQssyoiSgyOZENSnqY4GVduw3QUBkmdru3hYWZ
         1elKEIvdo0pictwui4oSVCHA/PedN+Lvb4ve+f8yqrQwT47O7mtDJ6dt/+X4wZeOM+
         LdNIymRoas6FZ0TxESLouROO1nHTyHXjNe/l3TYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 009/154] btrfs: qgroup: catch reserved space leaks at unmount time
Date:   Wed,  9 Aug 2023 12:40:40 +0200
Message-ID: <20230809103637.228356121@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 5958253cf65de42493f17f36877a901486a90365 ]

Before this patch, qgroup completely relies on per-inode extent io tree
to detect reserved data space leak.

However previous bug has already shown how release page before
btrfs_finish_ordered_io() could lead to leak, and since it's
QGROUP_RESERVED bit cleared without triggering qgroup rsv, it can't be
detected by per-inode extent io tree.

So this patch adds another (and hopefully the final) safety net to catch
qgroup data reserved space leak.  At least the new safety net catches
all the leaks during development, so it should be pretty useful in the
real world.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 8a4a0b2a3eaf ("btrfs: fix race between quota disable and relocation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c |  5 +++++
 fs/btrfs/qgroup.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/qgroup.h  |  1 +
 3 files changed, 49 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7e9d914369a02..d98cf8aba753b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4106,6 +4106,11 @@ void close_ctree(struct btrfs_fs_info *fs_info)
 	ASSERT(list_empty(&fs_info->delayed_iputs));
 	set_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags);
 
+	if (btrfs_check_quota_leak(fs_info)) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_err(fs_info, "qgroup reserved space leaked");
+	}
+
 	btrfs_free_qgroup_config(fs_info);
 	ASSERT(list_empty(&fs_info->delalloc_roots));
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index db8f83ab55f63..7821bef061fe6 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -504,6 +504,49 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 	return ret < 0 ? ret : 0;
 }
 
+static u64 btrfs_qgroup_subvolid(u64 qgroupid)
+{
+	return (qgroupid & ((1ULL << BTRFS_QGROUP_LEVEL_SHIFT) - 1));
+}
+
+/*
+ * Called in close_ctree() when quota is still enabled.  This verifies we don't
+ * leak some reserved space.
+ *
+ * Return false if no reserved space is left.
+ * Return true if some reserved space is leaked.
+ */
+bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info)
+{
+	struct rb_node *node;
+	bool ret = false;
+
+	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+		return ret;
+	/*
+	 * Since we're unmounting, there is no race and no need to grab qgroup
+	 * lock.  And here we don't go post-order to provide a more user
+	 * friendly sorted result.
+	 */
+	for (node = rb_first(&fs_info->qgroup_tree); node; node = rb_next(node)) {
+		struct btrfs_qgroup *qgroup;
+		int i;
+
+		qgroup = rb_entry(node, struct btrfs_qgroup, node);
+		for (i = 0; i < BTRFS_QGROUP_RSV_LAST; i++) {
+			if (qgroup->rsv.values[i]) {
+				ret = true;
+				btrfs_warn(fs_info,
+		"qgroup %llu/%llu has unreleased space, type %d rsv %llu",
+				   btrfs_qgroup_level(qgroup->qgroupid),
+				   btrfs_qgroup_subvolid(qgroup->qgroupid),
+				   i, qgroup->rsv.values[i]);
+			}
+		}
+	}
+	return ret;
+}
+
 /*
  * This is called from close_ctree() or open_ctree() or btrfs_quota_disable(),
  * first two are in single-threaded paths.And for the third one, we have set
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 0a2659685ad65..94bdfb89505e8 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -416,5 +416,6 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
 int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 		struct btrfs_root *root, struct extent_buffer *eb);
 void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans);
+bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info);
 
 #endif
-- 
2.39.2



