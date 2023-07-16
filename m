Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857FF7551BA
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjGPT7h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjGPT7g (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:59:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700DEF7
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:59:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0849560EA2
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC7AC433C8;
        Sun, 16 Jul 2023 19:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537574;
        bh=znMCHaVmtZ+T9MYF6KsrB2BszaTI2N/WrfL3EXTa/gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NCw9zeIEdTCjco7EjPrgz1WUHleE4AnmJicI8jUwZI3wRmpkE2vIgJXJSJ90otPK0
         qgDL5YvSFkgX1VlIdl3ecegu7lp5CwUPjqIxf2/Pwq8zKzdRGom8RAbiMBdYkTeaVK
         GJ28zk3Fqv/U8R/7UMFqPQCPZaDsZIVnoF0W3d6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 143/800] bpf: Fix __bpf_{list,rbtree}_adds beginning-of-node calculation
Date:   Sun, 16 Jul 2023 21:39:56 +0200
Message-ID: <20230716194952.416913425@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Dave Marchevsky <davemarchevsky@fb.com>

[ Upstream commit cc0d76cafebbd3e1ffab9c4252d48ecc9e0737f6 ]

Given the pointer to struct bpf_{rb,list}_node within a local kptr and
the byte offset of that field within the kptr struct, the calculation changed
by this patch is meant to find the beginning of the kptr so that it can
be passed to bpf_obj_drop.

Unfortunately instead of doing

  ptr_to_kptr = ptr_to_node_field - offset_bytes

the calculation is erroneously doing

  ptr_to_ktpr = ptr_to_node_field - (offset_bytes * sizeof(struct bpf_rb_node))

or the bpf_list_node equivalent.

This patch fixes the calculation.

Fixes: d2dcc67df910 ("bpf: Migrate bpf_rbtree_add and bpf_list_push_{front,back} to possibly fail")
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Link: https://lore.kernel.org/r/20230602022647.1571784-4-davemarchevsky@fb.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8d368fa353f99..27b9f78195b2c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1943,7 +1943,7 @@ static int __bpf_list_add(struct bpf_list_node *node, struct bpf_list_head *head
 		INIT_LIST_HEAD(h);
 	if (!list_empty(n)) {
 		/* Only called from BPF prog, no need to migrate_disable */
-		__bpf_obj_drop_impl(n - off, rec);
+		__bpf_obj_drop_impl((void *)n - off, rec);
 		return -EINVAL;
 	}
 
@@ -2025,7 +2025,7 @@ static int __bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
 
 	if (!RB_EMPTY_NODE(n)) {
 		/* Only called from BPF prog, no need to migrate_disable */
-		__bpf_obj_drop_impl(n - off, rec);
+		__bpf_obj_drop_impl((void *)n - off, rec);
 		return -EINVAL;
 	}
 
-- 
2.39.2



