Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E7C775BE7
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjHILWG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjHILWF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:22:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDE72126
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10D49631F7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23562C433C9;
        Wed,  9 Aug 2023 11:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580116;
        bh=g7JKSqivtcA1ZxQt5+G+tLt5Lkt5nQIiMQbb5r9Z4ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z8vzxpsvSAa9aMDQiPA35h2pooSAYDOnVFVHQnQEd3zbJeEoep1RqzY5zj42GYRxq
         zeePvW9fUKLyv04cr7Xn53lTYoY/nNnAIo66XV9xdqQ7cVfT+gEM0PCnSw4lIBWmHV
         c2l0US+e85jZA+rzv+tfCZsF/Yckv7RoJhgG81/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Abaci Robot <abaci@linux.alibaba.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 232/323] ftrace: Check if pages were allocated before calling free_pages()
Date:   Wed,  9 Aug 2023 12:41:10 +0200
Message-ID: <20230809103708.708497295@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

[ Upstream commit 59300b36f85f254260c81d9dd09195fa49eb0f98 ]

It is possible that on error pg->size can be zero when getting its order,
which would return a -1 value. It is dangerous to pass in an order of -1
to free_pages(). Check if order is greater than or equal to zero before
calling free_pages().

Link: https://lore.kernel.org/lkml/20210330093916.432697c7@gandalf.local.home/

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Stable-dep-of: 26efd79c4624 ("ftrace: Fix possible warning on checking all pages used in ftrace_process_locs()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ftrace.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 48ab4d750c650..1b92a22086f50 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3095,7 +3095,8 @@ ftrace_allocate_pages(unsigned long num_to_init)
 	pg = start_pg;
 	while (pg) {
 		order = get_count_order(pg->size / ENTRIES_PER_PAGE);
-		free_pages((unsigned long)pg->records, order);
+		if (order >= 0)
+			free_pages((unsigned long)pg->records, order);
 		start_pg = pg->next;
 		kfree(pg);
 		pg = start_pg;
@@ -5843,7 +5844,8 @@ void ftrace_release_mod(struct module *mod)
 		clear_mod_from_hashes(pg);
 
 		order = get_count_order(pg->size / ENTRIES_PER_PAGE);
-		free_pages((unsigned long)pg->records, order);
+		if (order >= 0)
+			free_pages((unsigned long)pg->records, order);
 		tmp_page = pg->next;
 		kfree(pg);
 		ftrace_number_of_pages -= 1 << order;
@@ -6192,7 +6194,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		if (!pg->index) {
 			*last_pg = pg->next;
 			order = get_count_order(pg->size / ENTRIES_PER_PAGE);
-			free_pages((unsigned long)pg->records, order);
+			if (order >= 0)
+				free_pages((unsigned long)pg->records, order);
 			ftrace_number_of_pages -= 1 << order;
 			ftrace_number_of_groups--;
 			kfree(pg);
-- 
2.39.2



