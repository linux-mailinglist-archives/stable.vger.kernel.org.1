Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F4C755450
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjGPU3E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjGPU3D (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:29:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB5CD3
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:29:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BC1560EBB
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB1FC433C7;
        Sun, 16 Jul 2023 20:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539341;
        bh=zhv7/yKnff0rHuQjc5y5w20/q61JCsYFvyDBchEBnNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kfkubu1mSFzj8tqzlbQ9y0R2NZA0cpYNXBhv4Yty0M5A6Zh/DX2HztUpJs6//uU1e
         eu6b1gSWbKVWJd9KtH7QcgaBIMDWeH+TVfJ5xvjpfuHmxEQOtipTgS0ujLBoNhl6la
         lNtA4zNfpT8CYDlfDA6oF9nOcVxe/uhyGJzVXhfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        Boris Burkov <boris@bur.io>, David Sterba <dsterba@suse.com>
Subject: [PATCH 6.4 756/800] btrfs: warn on invalid slot in tree mod log rewind
Date:   Sun, 16 Jul 2023 21:50:09 +0200
Message-ID: <20230716195006.703082100@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Boris Burkov <boris@bur.io>

commit 95c8e349d8e8f190e28854e7ca96de866d2dc5a4 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-mod-log.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -719,10 +719,27 @@ static void tree_mod_log_rewind(struct b
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
@@ -739,6 +756,8 @@ static void tree_mod_log_rewind(struct b
 			btrfs_set_node_ptr_generation(eb, tm->slot,
 						      tm->generation);
 			n++;
+			if (tm->slot > max_slot)
+				max_slot = tm->slot;
 			break;
 		case BTRFS_MOD_LOG_KEY_REPLACE:
 			BUG_ON(tm->slot >= n);
@@ -748,14 +767,37 @@ static void tree_mod_log_rewind(struct b
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


