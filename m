Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7939F75E9B8
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 04:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjGXC3d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 22:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjGXC3b (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 22:29:31 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597CEF9
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 19:29:19 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R8PGg73dlz1KBhs;
        Mon, 24 Jul 2023 10:28:27 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 10:29:17 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <rostedt@goodmis.org>, <stable@vger.kernel.org>,
        <zhengyejian1@huawei.com>
Subject: [PATCH 5.10 1/2] ftrace: Store the order of pages allocated in ftrace_page
Date:   Mon, 24 Jul 2023 10:29:23 +0800
Message-ID: <20230724022924.3478612-2-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724022924.3478612-1-zhengyejian1@huawei.com>
References: <2023072114-giblet-unzip-f1db@gregkh>
 <20230724022924.3478612-1-zhengyejian1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit db42523b4f3e83ff86b53cdda219a9767c8b047f upstream.

Instead of saving the size of the records field of the ftrace_page, store
the order it uses to allocate the pages, as that is what is needed to know
in order to free the pages. This simplifies the code.

Link: https://lore.kernel.org/lkml/CAHk-=whyMxheOqXAORt9a7JK9gc9eHTgCJ55Pgs4p=X3RrQubQ@mail.gmail.com/

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[ change log written by Steven Rostedt ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/ftrace.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3dab978c156d..acba76c0c5c3 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1091,7 +1091,7 @@ struct ftrace_page {
 	struct ftrace_page	*next;
 	struct dyn_ftrace	*records;
 	int			index;
-	int			size;
+	int			order;
 };
 
 #define ENTRY_SIZE sizeof(struct dyn_ftrace)
@@ -3188,7 +3188,7 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 	ftrace_number_of_groups++;
 
 	cnt = (PAGE_SIZE << order) / ENTRY_SIZE;
-	pg->size = cnt;
+	pg->order = order;
 
 	if (cnt > count)
 		cnt = count;
@@ -3201,7 +3201,6 @@ ftrace_allocate_pages(unsigned long num_to_init)
 {
 	struct ftrace_page *start_pg;
 	struct ftrace_page *pg;
-	int order;
 	int cnt;
 
 	if (!num_to_init)
@@ -3237,13 +3236,13 @@ ftrace_allocate_pages(unsigned long num_to_init)
  free_pages:
 	pg = start_pg;
 	while (pg) {
-		order = get_count_order(pg->size / ENTRIES_PER_PAGE);
-		if (order >= 0)
-			free_pages((unsigned long)pg->records, order);
+		if (pg->records) {
+			free_pages((unsigned long)pg->records, pg->order);
+			ftrace_number_of_pages -= 1 << pg->order;
+		}
 		start_pg = pg->next;
 		kfree(pg);
 		pg = start_pg;
-		ftrace_number_of_pages -= 1 << order;
 		ftrace_number_of_groups--;
 	}
 	pr_info("ftrace: FAILED to allocate memory for functions\n");
@@ -6239,6 +6238,7 @@ static int ftrace_process_locs(struct module *mod,
 	p = start;
 	pg = start_pg;
 	while (p < end) {
+		unsigned long end_offset;
 		addr = ftrace_call_adjust(*p++);
 		/*
 		 * Some architecture linkers will pad between
@@ -6249,7 +6249,8 @@ static int ftrace_process_locs(struct module *mod,
 		if (!addr)
 			continue;
 
-		if (pg->index == pg->size) {
+		end_offset = (pg->index+1) * sizeof(pg->records[0]);
+		if (end_offset > PAGE_SIZE << pg->order) {
 			/* We should have allocated enough */
 			if (WARN_ON(!pg->next))
 				break;
@@ -6418,7 +6419,6 @@ void ftrace_release_mod(struct module *mod)
 	struct ftrace_page **last_pg;
 	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
-	int order;
 
 	mutex_lock(&ftrace_lock);
 
@@ -6469,12 +6469,12 @@ void ftrace_release_mod(struct module *mod)
 		/* Needs to be called outside of ftrace_lock */
 		clear_mod_from_hashes(pg);
 
-		order = get_count_order(pg->size / ENTRIES_PER_PAGE);
-		if (order >= 0)
-			free_pages((unsigned long)pg->records, order);
+		if (pg->records) {
+			free_pages((unsigned long)pg->records, pg->order);
+			ftrace_number_of_pages -= 1 << pg->order;
+		}
 		tmp_page = pg->next;
 		kfree(pg);
-		ftrace_number_of_pages -= 1 << order;
 		ftrace_number_of_groups--;
 	}
 }
@@ -6792,7 +6792,6 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	struct ftrace_mod_map *mod_map = NULL;
 	struct ftrace_init_func *func, *func_next;
 	struct list_head clear_hash;
-	int order;
 
 	INIT_LIST_HEAD(&clear_hash);
 
@@ -6830,10 +6829,10 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		ftrace_update_tot_cnt--;
 		if (!pg->index) {
 			*last_pg = pg->next;
-			order = get_count_order(pg->size / ENTRIES_PER_PAGE);
-			if (order >= 0)
-				free_pages((unsigned long)pg->records, order);
-			ftrace_number_of_pages -= 1 << order;
+			if (pg->records) {
+				free_pages((unsigned long)pg->records, pg->order);
+				ftrace_number_of_pages -= 1 << pg->order;
+			}
 			ftrace_number_of_groups--;
 			kfree(pg);
 			pg = container_of(last_pg, struct ftrace_page, next);
-- 
2.25.1

