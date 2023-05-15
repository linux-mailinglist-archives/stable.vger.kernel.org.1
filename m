Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7040703873
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244362AbjEORcn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244231AbjEORcU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:32:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F1B11636
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:29:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA91B62083
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61F3C433D2;
        Mon, 15 May 2023 17:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171754;
        bh=4LjBI5KL8/JNMtAu02Op0SecTeiWUAidqmNK6zUHwt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qvcam/jlmcncxlgx4dBiC4NVK1+AFlROQptVWVfF7hFcuXsnV4ezsPncwLWcqvyvA
         wKFcm3FQP6XbHW5Aw5wZk4zjqFpvQEpLSBiOMZkT+avbRb4mrhAndAUhaGdHz4D4SJ
         zfKhM/ngQHBkfc3RBL2kS9JxZmGBZFvurYyyylXA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Anand Jain <anand.jain@oracle.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.15 067/134] btrfs: fix space cache inconsistency after error loading it from disk
Date:   Mon, 15 May 2023 18:29:04 +0200
Message-Id: <20230515161705.387363599@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Filipe Manana <fdmanana@suse.com>

commit 0004ff15ea26015a0a3a6182dca3b9d1df32e2b7 upstream.

When loading a free space cache from disk, at __load_free_space_cache(),
if we fail to insert a bitmap entry, we still increment the number of
total bitmaps in the btrfs_free_space_ctl structure, which is incorrect
since we failed to add the bitmap entry. On error we then empty the
cache by calling __btrfs_remove_free_space_cache(), which will result
in getting the total bitmaps counter set to 1.

A failure to load a free space cache is not critical, so if a failure
happens we just rebuild the cache by scanning the extent tree, which
happens at block-group.c:caching_thread(). Yet the failure will result
in having the total bitmaps of the btrfs_free_space_ctl always bigger
by 1 then the number of bitmap entries we have. So fix this by having
the total bitmaps counter be incremented only if we successfully added
the bitmap entry.

Fixes: a67509c30079 ("Btrfs: add a io_ctl struct and helpers for dealing with the space cache")
Reviewed-by: Anand Jain <anand.jain@oracle.com>
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/free-space-cache.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -825,15 +825,16 @@ static int __load_free_space_cache(struc
 			}
 			spin_lock(&ctl->tree_lock);
 			ret = link_free_space(ctl, e);
-			ctl->total_bitmaps++;
-			recalculate_thresholds(ctl);
-			spin_unlock(&ctl->tree_lock);
 			if (ret) {
+				spin_unlock(&ctl->tree_lock);
 				btrfs_err(fs_info,
 					"Duplicate entries in free space cache, dumping");
 				kmem_cache_free(btrfs_free_space_cachep, e);
 				goto free_cache;
 			}
+			ctl->total_bitmaps++;
+			recalculate_thresholds(ctl);
+			spin_unlock(&ctl->tree_lock);
 			list_add_tail(&e->list, &bitmaps);
 		}
 


