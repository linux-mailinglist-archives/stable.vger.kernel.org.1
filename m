Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCD7713A99
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 18:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjE1Qhy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 12:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjE1Qhx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 12:37:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791B0A7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 09:37:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07F7861629
        for <stable@vger.kernel.org>; Sun, 28 May 2023 16:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24981C433D2;
        Sun, 28 May 2023 16:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685291871;
        bh=B5xUJD27RQShu8ELVkzTR7VlglJCPfF8+zzlHwHMCAQ=;
        h=Subject:To:Cc:From:Date:From;
        b=CKIyLcPnnIV5sHhauhbMXMob5+b7t7+xjp/tWyJQgLRZyTgGGLXlK0fHlWqElLJNx
         afXRko+6LtOlhALwH/+G95RCs3g5dBEhCGYXB/V8xHOQEDqk+N7HZhuSY4m/u6DJUZ
         uwsIxeL7P3Wqu2Juq1Q1oY8NtY9ld9zAzDTaTHA4=
Subject: FAILED: patch "[PATCH] bpf: fix a memory leak in the LRU and LRU_PERCPU hash maps" failed to apply to 5.15-stable tree
To:     aspsk@isovalent.com, martin.lau@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 17:37:49 +0100
Message-ID: <2023052848-esquire-crisped-c290@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
git cherry-pick -x b34ffb0c6d23583830f9327864b9c1f486003305
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052848-esquire-crisped-c290@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

b34ffb0c6d23 ("bpf: fix a memory leak in the LRU and LRU_PERCPU hash maps")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b34ffb0c6d23583830f9327864b9c1f486003305 Mon Sep 17 00:00:00 2001
From: Anton Protopopov <aspsk@isovalent.com>
Date: Mon, 22 May 2023 15:45:58 +0000
Subject: [PATCH] bpf: fix a memory leak in the LRU and LRU_PERCPU hash maps

The LRU and LRU_PERCPU maps allocate a new element on update before locking the
target hash table bucket. Right after that the maps try to lock the bucket.
If this fails, then maps return -EBUSY to the caller without releasing the
allocated element. This makes the element untracked: it doesn't belong to
either of free lists, and it doesn't belong to the hash table, so can't be
re-used; this eventually leads to the permanent -ENOMEM on LRU map updates,
which is unexpected. Fix this by returning the element to the local free list
if bucket locking fails.

Fixes: 20b6cc34ea74 ("bpf: Avoid hashtab deadlock with map_locked")
Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Link: https://lore.kernel.org/r/20230522154558.2166815-1-aspsk@isovalent.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 00c253b84bf5..9901efee4339 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1215,7 +1215,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 
 	ret = htab_lock_bucket(htab, b, hash, &flags);
 	if (ret)
-		return ret;
+		goto err_lock_bucket;
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1236,6 +1236,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 err:
 	htab_unlock_bucket(htab, b, hash, flags);
 
+err_lock_bucket:
 	if (ret)
 		htab_lru_push_free(htab, l_new);
 	else if (l_old)
@@ -1338,7 +1339,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 
 	ret = htab_lock_bucket(htab, b, hash, &flags);
 	if (ret)
-		return ret;
+		goto err_lock_bucket;
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1361,6 +1362,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	ret = 0;
 err:
 	htab_unlock_bucket(htab, b, hash, flags);
+err_lock_bucket:
 	if (l_new)
 		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
 	return ret;

