Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77A579B628
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244527AbjIKWZc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbjIKO5T (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:57:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FE6E4B
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:57:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07FFC433C8;
        Mon, 11 Sep 2023 14:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444234;
        bh=MSd7iezZa7lw+Cbj2SnA6ne9QLI4lpFaAOkzT13rhEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xzx/ECor+RhXG+ou6I0Tu7EFKLUPHLJhGEpO2YcnyFXobCRkCD/7QSLYfHUYz5JI+
         m03yETUaxHu4FHwI3g4Gs9e3TftqkJ7LoCKKDZczDR7X9RY8rpDKBl6fVp3TDtaf6u
         FSGKvT+o2mb7LULEglpZGFIuzHP8mSUACcT3974E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 6.4 658/737] XArray: Do not return sibling entries from xa_load()
Date:   Mon, 11 Sep 2023 15:48:37 +0200
Message-ID: <20230911134708.907275103@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox (Oracle) <willy@infradead.org>

commit cbc02854331edc6dc22d8b77b6e22e38ebc7dd51 upstream.

It is possible for xa_load() to observe a sibling entry pointing to
another sibling entry.  An example:

Thread A:		Thread B:
			xa_store_range(xa, entry, 188, 191, gfp);
xa_load(xa, 191);
entry = xa_entry(xa, node, 63);
[entry is a sibling of 188]
			xa_store_range(xa, entry, 184, 191, gfp);
if (xa_is_sibling(entry))
offset = xa_to_sibling(entry);
entry = xa_entry(xas->xa, node, offset);
[entry is now a sibling of 184]

It is sufficient to go around this loop until we hit a non-sibling entry.
Sibling entries always point earlier in the node, so we are guaranteed
to terminate this search.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/xarray.c                          |    2 -
 tools/testing/radix-tree/multiorder.c |   68 +++++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 3 deletions(-)

--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -206,7 +206,7 @@ static void *xas_descend(struct xa_state
 	void *entry = xa_entry(xas->xa, node, offset);
 
 	xas->xa_node = node;
-	if (xa_is_sibling(entry)) {
+	while (xa_is_sibling(entry)) {
 		offset = xa_to_sibling(entry);
 		entry = xa_entry(xas->xa, node, offset);
 		if (node->shift && xa_is_node(entry))
--- a/tools/testing/radix-tree/multiorder.c
+++ b/tools/testing/radix-tree/multiorder.c
@@ -159,7 +159,7 @@ void multiorder_tagged_iteration(struct
 	item_kill_tree(xa);
 }
 
-bool stop_iteration = false;
+bool stop_iteration;
 
 static void *creator_func(void *ptr)
 {
@@ -201,6 +201,7 @@ static void multiorder_iteration_race(st
 	pthread_t worker_thread[num_threads];
 	int i;
 
+	stop_iteration = false;
 	pthread_create(&worker_thread[0], NULL, &creator_func, xa);
 	for (i = 1; i < num_threads; i++)
 		pthread_create(&worker_thread[i], NULL, &iterator_func, xa);
@@ -211,6 +212,61 @@ static void multiorder_iteration_race(st
 	item_kill_tree(xa);
 }
 
+static void *load_creator(void *ptr)
+{
+	/* 'order' is set up to ensure we have sibling entries */
+	unsigned int order;
+	struct radix_tree_root *tree = ptr;
+	int i;
+
+	rcu_register_thread();
+	item_insert_order(tree, 3 << RADIX_TREE_MAP_SHIFT, 0);
+	item_insert_order(tree, 2 << RADIX_TREE_MAP_SHIFT, 0);
+	for (i = 0; i < 10000; i++) {
+		for (order = 1; order < RADIX_TREE_MAP_SHIFT; order++) {
+			unsigned long index = (3 << RADIX_TREE_MAP_SHIFT) -
+						(1 << order);
+			item_insert_order(tree, index, order);
+			item_delete_rcu(tree, index);
+		}
+	}
+	rcu_unregister_thread();
+
+	stop_iteration = true;
+	return NULL;
+}
+
+static void *load_worker(void *ptr)
+{
+	unsigned long index = (3 << RADIX_TREE_MAP_SHIFT) - 1;
+
+	rcu_register_thread();
+	while (!stop_iteration) {
+		struct item *item = xa_load(ptr, index);
+		assert(!xa_is_internal(item));
+	}
+	rcu_unregister_thread();
+
+	return NULL;
+}
+
+static void load_race(struct xarray *xa)
+{
+	const int num_threads = sysconf(_SC_NPROCESSORS_ONLN) * 4;
+	pthread_t worker_thread[num_threads];
+	int i;
+
+	stop_iteration = false;
+	pthread_create(&worker_thread[0], NULL, &load_creator, xa);
+	for (i = 1; i < num_threads; i++)
+		pthread_create(&worker_thread[i], NULL, &load_worker, xa);
+
+	for (i = 0; i < num_threads; i++)
+		pthread_join(worker_thread[i], NULL);
+
+	item_kill_tree(xa);
+}
+
 static DEFINE_XARRAY(array);
 
 void multiorder_checks(void)
@@ -218,12 +274,20 @@ void multiorder_checks(void)
 	multiorder_iteration(&array);
 	multiorder_tagged_iteration(&array);
 	multiorder_iteration_race(&array);
+	load_race(&array);
 
 	radix_tree_cpu_dead(0);
 }
 
-int __weak main(void)
+int __weak main(int argc, char **argv)
 {
+	int opt;
+
+	while ((opt = getopt(argc, argv, "ls:v")) != -1) {
+		if (opt == 'v')
+			test_verbose++;
+	}
+
 	rcu_register_thread();
 	radix_tree_init();
 	multiorder_checks();


