Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC92713E0C
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjE1Tbb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjE1Tbb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:31:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4ABE3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:31:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32E8161D82
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523EBC4339B;
        Sun, 28 May 2023 19:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302282;
        bh=pUAKwf3zhXLaBNzZ0xxf0OgSjVgRAHlphqO07gg83tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Z79ViwM466ErAJmtipnEjrNUY4zrJvgB86XetCk/MJPCi3OER7nyhk9deJnoO6z5
         9036DZi7Fgs61hyB5BVSA1Y0EHWJ/pounxB1gsjNgrjTQLhFb4aL9iXL8UFWt+76zD
         PhqBHveQZQPZIZfvCBRlJ8SMuWRECeur+yoQj724=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Anton Protopopov <aspsk@isovalent.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH 6.3 073/127] bpf: fix a memory leak in the LRU and LRU_PERCPU hash maps
Date:   Sun, 28 May 2023 20:10:49 +0100
Message-Id: <20230528190838.762707857@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Anton Protopopov <aspsk@isovalent.com>

commit b34ffb0c6d23583830f9327864b9c1f486003305 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/hashtab.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1197,7 +1197,7 @@ static long htab_lru_map_update_elem(str
 
 	ret = htab_lock_bucket(htab, b, hash, &flags);
 	if (ret)
-		return ret;
+		goto err_lock_bucket;
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1218,6 +1218,7 @@ static long htab_lru_map_update_elem(str
 err:
 	htab_unlock_bucket(htab, b, hash, flags);
 
+err_lock_bucket:
 	if (ret)
 		htab_lru_push_free(htab, l_new);
 	else if (l_old)
@@ -1320,7 +1321,7 @@ static long __htab_lru_percpu_map_update
 
 	ret = htab_lock_bucket(htab, b, hash, &flags);
 	if (ret)
-		return ret;
+		goto err_lock_bucket;
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1343,6 +1344,7 @@ static long __htab_lru_percpu_map_update
 	ret = 0;
 err:
 	htab_unlock_bucket(htab, b, hash, flags);
+err_lock_bucket:
 	if (l_new)
 		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
 	return ret;


