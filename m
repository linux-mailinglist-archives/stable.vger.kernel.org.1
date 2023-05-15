Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF7703A8D
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjEORwX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242507AbjEORwE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:52:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19E616907
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:49:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3937562F47
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CBDC433EF;
        Mon, 15 May 2023 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172996;
        bh=jX0aeYP0sREy6eyDwm7ySohAkb/Ajf8hT4PmiR67O4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d3L3noXokupdm3kd7U1CBkMfIcN430p0VWGJY0knuEvgFEHliLS5pE7gfhX0Up30W
         3WRhqGB74hCeN6XqIxosjUaXK0323qxNEN+WjEiRQt30haXO3jkvIkYhZLKg7mLZ4k
         NY3LWUlaNILp8qF4vXatlR9KKSXCuHvvU3k6Vev0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.10 335/381] btrfs: dont free qgroup space unless specified
Date:   Mon, 15 May 2023 18:29:46 +0200
Message-Id: <20230515161751.976070405@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit d246331b78cbef86237f9c22389205bc9b4e1cc1 upstream.

Boris noticed in his simple quotas testing that he was getting a leak
with Sweet Tea's change to subvol create that stopped doing a
transaction commit.  This was just a side effect of that change.

In the delayed inode code we have an optimization that will free extra
reservations if we think we can pack a dir item into an already modified
leaf.  Previously this wouldn't be triggered in the subvolume create
case because we'd commit the transaction, it was still possible but
much harder to trigger.  It could actually be triggered if we did a
mkdir && subvol create with qgroups enabled.

This occurs because in btrfs_insert_delayed_dir_index(), which gets
called when we're adding the dir item, we do the following:

  btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, NULL);

if we're able to skip reserving space.

The problem here is that trans->block_rsv points at the temporary block
rsv for the subvolume create, which has qgroup reservations in the block
rsv.

This is a problem because btrfs_block_rsv_release() will do the
following:

  if (block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
	  qgroup_to_release = block_rsv->qgroup_rsv_reserved -
		  block_rsv->qgroup_rsv_size;
	  block_rsv->qgroup_rsv_reserved = block_rsv->qgroup_rsv_size;
  }

The temporary block rsv just has ->qgroup_rsv_reserved set,
->qgroup_rsv_size == 0.  The optimization in
btrfs_insert_delayed_dir_index() sets ->qgroup_rsv_reserved = 0.  Then
later on when we call btrfs_subvolume_release_metadata() which has

  btrfs_block_rsv_release(fs_info, rsv, (u64)-1, &qgroup_to_release);
  btrfs_qgroup_convert_reserved_meta(root, qgroup_to_release);

qgroup_to_release is set to 0, and we do not convert the reserved
metadata space.

The problem here is that the block rsv code has been unconditionally
messing with ->qgroup_rsv_reserved, because the main place this is used
is delalloc, and any time we call btrfs_block_rsv_release() we do it
with qgroup_to_release set, and thus do the proper accounting.

The subvolume code is the only other code that uses the qgroup
reservation stuff, but it's intermingled with the above optimization,
and thus was getting its reservation freed out from underneath it and
thus leaking the reserved space.

The solution is to simply not mess with the qgroup reservations if we
don't have qgroup_to_release set.  This works with the existing code as
anything that messes with the delalloc reservations always have
qgroup_to_release set.  This fixes the leak that Boris was observing.

Reviewed-by: Qu Wenruo <wqu@suse.com>
CC: stable@vger.kernel.org # 5.4+
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/block-rsv.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -121,7 +121,8 @@ static u64 block_rsv_release_bytes(struc
 	} else {
 		num_bytes = 0;
 	}
-	if (block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
+	if (qgroup_to_release_ret &&
+	    block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
 		qgroup_to_release = block_rsv->qgroup_rsv_reserved -
 				    block_rsv->qgroup_rsv_size;
 		block_rsv->qgroup_rsv_reserved = block_rsv->qgroup_rsv_size;


