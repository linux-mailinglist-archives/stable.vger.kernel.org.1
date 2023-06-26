Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3520F73E96C
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjFZSfy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjFZSfw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:35:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB2BAC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:35:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30E0E60F45
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C63DC433C9;
        Mon, 26 Jun 2023 18:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804549;
        bh=lvinI8XWT+0Hpfs2lWjT7YFSZScXMgdmHKg0CmjXk1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ayAYJZ/gFHbCIhCQQuDO+TmL4qhVziYQ6fB8XpzbSE5UuHKh0CDvVm0tEdUb0QE3
         r8GZ487gfwXdCWiuTU+ZJYTNn8gxMfBy2tol+et4kp3DIXXXDRdV1aTFv4jhNpJuHk
         RCYeXl1fpON7LkB8X/YG6dShNq0RI/e9pG8nfnJc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 03/60] list: add "list_del_init_careful()" to go with "list_empty_careful()"
Date:   Mon, 26 Jun 2023 20:11:42 +0200
Message-ID: <20230626180739.683954679@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180739.558575012@linuxfoundation.org>
References: <20230626180739.558575012@linuxfoundation.org>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit c6fe44d96fc1536af5b11cd859686453d1b7bfd1 ]

That gives us ordering guarantees around the pair.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: 2192bba03d80 ("epoll: ep_autoremove_wake_function should use list_del_init_careful")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/list.h | 20 +++++++++++++++++++-
 kernel/sched/wait.c  |  2 +-
 mm/filemap.c         |  7 +------
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index ce19c6b632a59..231ff089f7d1c 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -268,6 +268,24 @@ static inline int list_empty(const struct list_head *head)
 	return READ_ONCE(head->next) == head;
 }
 
+/**
+ * list_del_init_careful - deletes entry from list and reinitialize it.
+ * @entry: the element to delete from the list.
+ *
+ * This is the same as list_del_init(), except designed to be used
+ * together with list_empty_careful() in a way to guarantee ordering
+ * of other memory operations.
+ *
+ * Any memory operations done before a list_del_init_careful() are
+ * guaranteed to be visible after a list_empty_careful() test.
+ */
+static inline void list_del_init_careful(struct list_head *entry)
+{
+	__list_del_entry(entry);
+	entry->prev = entry;
+	smp_store_release(&entry->next, entry);
+}
+
 /**
  * list_empty_careful - tests whether a list is empty and not being modified
  * @head: the list to test
@@ -283,7 +301,7 @@ static inline int list_empty(const struct list_head *head)
  */
 static inline int list_empty_careful(const struct list_head *head)
 {
-	struct list_head *next = head->next;
+	struct list_head *next = smp_load_acquire(&head->next);
 	return (next == head) && (next == head->prev);
 }
 
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 7d668b31dbc6d..c76fe1d4d91e2 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -384,7 +384,7 @@ int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, i
 	int ret = default_wake_function(wq_entry, mode, sync, key);
 
 	if (ret)
-		list_del_init(&wq_entry->entry);
+		list_del_init_careful(&wq_entry->entry);
 
 	return ret;
 }
diff --git a/mm/filemap.c b/mm/filemap.c
index 83b324420046b..a106d63e84679 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1085,13 +1085,8 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 	 * since after list_del_init(&wait->entry) the wait entry
 	 * might be de-allocated and the process might even have
 	 * exited.
-	 *
-	 * We _really_ should have a "list_del_init_careful()" to
-	 * properly pair with the unlocked "list_empty_careful()"
-	 * in finish_wait().
 	 */
-	smp_mb();
-	list_del_init(&wait->entry);
+	list_del_init_careful(&wait->entry);
 	return ret;
 }
 
-- 
2.39.2



