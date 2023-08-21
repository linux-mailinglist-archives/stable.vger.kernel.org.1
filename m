Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E7C783382
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjHUT4J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjHUT4I (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:56:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0136AFD
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:56:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30D26645E0
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E41C433C7;
        Mon, 21 Aug 2023 19:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647762;
        bh=qq5Fe3PXGVT+HhHRFpzx37gR/MWWTTvFI4NUp0DsI2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jRFg7bCj9zBpYYfYDN8nANcX+b6kSfPVZqaNZVILAGLuBvor/z67rYJxgeiHw69u/
         orhAtMGPiLMjuns0hJed/XI5xGJ6EB6/6B78A8DyYiZkYXOtuNcHM8Ouh/5XVeqjdV
         YSICZ+XOv5La3JG23nfhKulBlOjsYQrQczepdZIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 100/194] btrfs: fix incorrect splitting in btrfs_drop_extent_map_range
Date:   Mon, 21 Aug 2023 21:41:19 +0200
Message-ID: <20230821194127.083161731@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit c962098ca4af146f2625ed64399926a098752c9c upstream.

In production we were seeing a variety of WARN_ON()'s in the extent_map
code, specifically in btrfs_drop_extent_map_range() when we have to call
add_extent_mapping() for our second split.

Consider the following extent map layout

	PINNED
	[0 16K)  [32K, 48K)

and then we call btrfs_drop_extent_map_range for [0, 36K), with
skip_pinned == true.  The initial loop will have

	start = 0
	end = 36K
	len = 36K

we will find the [0, 16k) extent, but since we are pinned we will skip
it, which has this code

	start = em_end;
	if (end != (u64)-1)
		len = start + len - em_end;

em_end here is 16K, so now the values are

	start = 16K
	len = 16K + 36K - 16K = 36K

len should instead be 20K.  This is a problem when we find the next
extent at [32K, 48K), we need to split this extent to leave [36K, 48k),
however the code for the split looks like this

	split->start = start + len;
	split->len = em_end - (start + len);

In this case we have

	em_end = 48K
	split->start = 16K + 36K       // this should be 16K + 20K
	split->len = 48K - (16K + 36K) // this overflows as 16K + 36K is 52K

and now we have an invalid extent_map in the tree that potentially
overlaps other entries in the extent map.  Even in the non-overlapping
case we will have split->start set improperly, which will cause problems
with any block related calculations.

We don't actually need len in this loop, we can simply use end as our
end point, and only adjust start up when we find a pinned extent we need
to skip.

Adjust the logic to do this, which keeps us from inserting an invalid
extent map.

We only skip_pinned in the relocation case, so this is relatively rare,
except in the case where you are running relocation a lot, which can
happen with auto relocation on.

Fixes: 55ef68990029 ("Btrfs: Fix btrfs_drop_extent_cache for skip pinned case")
CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent_map.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -784,8 +784,6 @@ void btrfs_drop_extent_map_range(struct
 
 		if (skip_pinned && test_bit(EXTENT_FLAG_PINNED, &em->flags)) {
 			start = em_end;
-			if (end != (u64)-1)
-				len = start + len - em_end;
 			goto next;
 		}
 
@@ -853,8 +851,8 @@ void btrfs_drop_extent_map_range(struct
 				if (!split)
 					goto remove_em;
 			}
-			split->start = start + len;
-			split->len = em_end - (start + len);
+			split->start = end;
+			split->len = em_end - end;
 			split->block_start = em->block_start;
 			split->flags = flags;
 			split->compress_type = em->compress_type;


