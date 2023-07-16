Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C44754E49
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 12:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGPKRA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 06:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjGPKQ7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 06:16:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA22186
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 03:16:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEB7B60BDC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 10:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEB9C433C7;
        Sun, 16 Jul 2023 10:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689502617;
        bh=W74iNA064K8KzCIRDo+ide1GzBpfkSTWO/rIOzEoimU=;
        h=Subject:To:Cc:From:Date:From;
        b=jd127HazgS8FLVvH0fKVYVg6v6Y0UPgbNf4uIedaISowmM4Yimf+uMUqCDMesbOqI
         1NgHVJdttAKHDcSeI9F2RjKevE3unZlN64AIGvt+o452hL17MkhPjmadLIdqoZpNVV
         o7cftslyQFn+AUgj3MZpmwUwyHBBivokRsiJHCEU=
Subject: FAILED: patch "[PATCH] btrfs: warn on invalid slot in tree mod log rewind" failed to apply to 5.15-stable tree
To:     boris@bur.io, dsterba@suse.com, fdmanana@suse.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 12:16:46 +0200
Message-ID: <2023071646-upheaval-antiquity-8775@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 95c8e349d8e8f190e28854e7ca96de866d2dc5a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071646-upheaval-antiquity-8775@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

95c8e349d8e8 ("btrfs: warn on invalid slot in tree mod log rewind")
e23efd8e8767 ("btrfs: add eb to btrfs_node_key_ptr_offset")
07e81dc94474 ("btrfs: move accessor helpers into accessors.h")
ad1ac5012c2b ("btrfs: move btrfs_map_token to accessors")
55e5cfd36da5 ("btrfs: remove fs_info::pending_changes and related code")
7966a6b5959b ("btrfs: move fs_info::flags enum to fs.h")
fc97a410bd78 ("btrfs: move mount option definitions to fs.h")
0d3a9cf8c306 ("btrfs: convert incompat and compat flag test helpers to macros")
ec8eb376e271 ("btrfs: move BTRFS_FS_STATE* definitions and helpers to fs.h")
9b569ea0be6f ("btrfs: move the printk helpers out of ctree.h")
e118578a8df7 ("btrfs: move assert helpers out of ctree.h")
c7f13d428ea1 ("btrfs: move fs wide helpers out of ctree.h")
63a7cb130718 ("btrfs: auto enable discard=async when possible")
7a66eda351ba ("btrfs: move the btrfs_verity_descriptor_item defs up in ctree.h")
956504a331a6 ("btrfs: move trans_handle_cachep out of ctree.h")
f1e5c6185ca1 ("btrfs: move flush related definitions to space-info.h")
ed4c491a3db2 ("btrfs: move BTRFS_MAX_MIRRORS into scrub.c")
4300c58f8090 ("btrfs: move btrfs on-disk definitions out of ctree.h")
d60d956eb41f ("btrfs: remove unused set/clear_pending_info helpers")
8bb808c6ad91 ("btrfs: don't print stack trace when transaction is aborted due to ENOMEM")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 95c8e349d8e8f190e28854e7ca96de866d2dc5a4 Mon Sep 17 00:00:00 2001
From: Boris Burkov <boris@bur.io>
Date: Thu, 1 Jun 2023 11:55:13 -0700
Subject: [PATCH] btrfs: warn on invalid slot in tree mod log rewind

The way that tree mod log tracks the ultimate length of the eb, the
variable 'n', eventually turns up the correct value, but at intermediate
steps during the rewind, n can be inaccurate as a representation of the
end of the eb. For example, it doesn't get updated on move rewinds, and
it does get updated for add/remove in the middle of the eb.

To detect cases with invalid moves, introduce a separate variable called
max_slot which tries to track the maximum valid slot in the rewind eb.
We can then warn if we do a move whose src range goes beyond the max
valid slot.

There is a commented caveat that it is possible to have this value be an
overestimate due to the challenge of properly handling 'add' operations
in the middle of the eb, but in practice it doesn't cause enough of a
problem to throw out the max idea in favor of tracking every valid slot.

CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index a555baa0143a..39545d1d2e9a 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -664,10 +664,27 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
 	unsigned long o_dst;
 	unsigned long o_src;
 	unsigned long p_size = sizeof(struct btrfs_key_ptr);
+	/*
+	 * max_slot tracks the maximum valid slot of the rewind eb at every
+	 * step of the rewind. This is in contrast with 'n' which eventually
+	 * matches the number of items, but can be wrong during moves or if
+	 * removes overlap on already valid slots (which is probably separately
+	 * a bug). We do this to validate the offsets of memmoves for rewinding
+	 * moves and detect invalid memmoves.
+	 *
+	 * Since a rewind eb can start empty, max_slot is a signed integer with
+	 * a special meaning for -1, which is that no slot is valid to move out
+	 * of. Any other negative value is invalid.
+	 */
+	int max_slot;
+	int move_src_end_slot;
+	int move_dst_end_slot;
 
 	n = btrfs_header_nritems(eb);
+	max_slot = n - 1;
 	read_lock(&fs_info->tree_mod_log_lock);
 	while (tm && tm->seq >= time_seq) {
+		ASSERT(max_slot >= -1);
 		/*
 		 * All the operations are recorded with the operator used for
 		 * the modification. As we're going backwards, we do the
@@ -684,6 +701,8 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
 			btrfs_set_node_ptr_generation(eb, tm->slot,
 						      tm->generation);
 			n++;
+			if (tm->slot > max_slot)
+				max_slot = tm->slot;
 			break;
 		case BTRFS_MOD_LOG_KEY_REPLACE:
 			BUG_ON(tm->slot >= n);
@@ -693,14 +712,37 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
 						      tm->generation);
 			break;
 		case BTRFS_MOD_LOG_KEY_ADD:
+			/*
+			 * It is possible we could have already removed keys
+			 * behind the known max slot, so this will be an
+			 * overestimate. In practice, the copy operation
+			 * inserts them in increasing order, and overestimating
+			 * just means we miss some warnings, so it's OK. It
+			 * isn't worth carefully tracking the full array of
+			 * valid slots to check against when moving.
+			 */
+			if (tm->slot == max_slot)
+				max_slot--;
 			/* if a move operation is needed it's in the log */
 			n--;
 			break;
 		case BTRFS_MOD_LOG_MOVE_KEYS:
+			ASSERT(tm->move.nr_items > 0);
+			move_src_end_slot = tm->move.dst_slot + tm->move.nr_items - 1;
+			move_dst_end_slot = tm->slot + tm->move.nr_items - 1;
 			o_dst = btrfs_node_key_ptr_offset(eb, tm->slot);
 			o_src = btrfs_node_key_ptr_offset(eb, tm->move.dst_slot);
+			if (WARN_ON(move_src_end_slot > max_slot ||
+				    tm->move.nr_items <= 0)) {
+				btrfs_warn(fs_info,
+"move from invalid tree mod log slot eb %llu slot %d dst_slot %d nr_items %d seq %llu n %u max_slot %d",
+					   eb->start, tm->slot,
+					   tm->move.dst_slot, tm->move.nr_items,
+					   tm->seq, n, max_slot);
+			}
 			memmove_extent_buffer(eb, o_dst, o_src,
 					      tm->move.nr_items * p_size);
+			max_slot = move_dst_end_slot;
 			break;
 		case BTRFS_MOD_LOG_ROOT_REPLACE:
 			/*

