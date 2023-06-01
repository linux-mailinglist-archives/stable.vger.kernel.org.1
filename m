Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4015719DA6
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjFANZb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjFANZP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:25:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5468C13D
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:24:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 345D66448D
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB48C433D2;
        Thu,  1 Jun 2023 13:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625889;
        bh=+Mk+VYvkMlckKui1f1GkmIsThMGH+C3ZuDWXyzlMc9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=07kc2R4em0w43NQP/y5yCM3Yn9Zsk1luz6ADSVbo1CP78GxwRLBicaQVHMfeSRD97
         fLsjQqutevlV65C6qK9LohfOG3eo3WkQSwz8Q+293aZHiUk+iO98pjbB5m454tKrY7
         FWAsWP9TXvam+sFo4C3/1rewHKRzd3xHji/DWgvA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Anton Protopopov <aspsk@isovalent.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 07/42] bpf: fix a memory leak in the LRU and LRU_PERCPU hash maps
Date:   Thu,  1 Jun 2023 14:20:54 +0100
Message-Id: <20230601131937.023519899@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131936.699199833@linuxfoundation.org>
References: <20230601131936.699199833@linuxfoundation.org>
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

[ Upstream commit b34ffb0c6d23583830f9327864b9c1f486003305 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/hashtab.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 10b37773d9e47..a63c68f5945cd 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1165,7 +1165,7 @@ static int htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
 
 	ret = htab_lock_bucket(htab, b, hash, &flags);
 	if (ret)
-		return ret;
+		goto err_lock_bucket;
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1186,6 +1186,7 @@ static int htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
 err:
 	htab_unlock_bucket(htab, b, hash, flags);
 
+err_lock_bucket:
 	if (ret)
 		htab_lru_push_free(htab, l_new);
 	else if (l_old)
@@ -1288,7 +1289,7 @@ static int __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 
 	ret = htab_lock_bucket(htab, b, hash, &flags);
 	if (ret)
-		return ret;
+		goto err_lock_bucket;
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1311,6 +1312,7 @@ static int __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	ret = 0;
 err:
 	htab_unlock_bucket(htab, b, hash, flags);
+err_lock_bucket:
 	if (l_new)
 		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
 	return ret;
-- 
2.39.2



