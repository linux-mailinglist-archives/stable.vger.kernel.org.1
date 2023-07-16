Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F96755202
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGPUCo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjGPUCo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:02:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F62FD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C489560EAA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7D1C433C7;
        Sun, 16 Jul 2023 20:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537762;
        bh=SC4IyBpX5OR+s1YHB6JohulQqyxk4TbNVUzdYEcIj5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZY6C9Ed+1zjBRVkhhQUkGFjw3MSBnnL1rfYjfzk0qdMO/NKTJT2G6sQKz+LUJuL1L
         kYM8GRKWk2B9g7pEHTfO7BL5wG6P/44sWCr8RmcadMl4Y1ppI9Yb9JYxr3J1X2IdkL
         E2jnj3Ah4IBgAsnhVGjB9z9AxSskQ3oVcqZmXnqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <yujie.liu@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Aaron Lu <aaron.lu@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com,
        Feng Tang <feng.tang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 182/800] mm: move mm_count into its own cache line
Date:   Sun, 16 Jul 2023 21:40:35 +0200
Message-ID: <20230716194953.330923661@linuxfoundation.org>
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

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

[ Upstream commit c1753fd02a0058ea43cbb31ab26d25be2f6cfe08 ]

The mm_struct mm_count field is frequently updated by mmgrab/mmdrop
performed by context switch.  This causes false-sharing for surrounding
mm_struct fields which are read-mostly.

This has been observed on a 2sockets/112core/224cpu Intel Sapphire Rapids
server running hackbench, and by the kernel test robot will-it-scale
testcase.

Move the mm_count field into its own cache line to prevent false-sharing
with other mm_struct fields.

Move mm_count to the first field of mm_struct to minimize the amount of
padding required: rather than adding padding before and after the mm_count
field, padding is only added after mm_count.

Note that I noticed this odd comment in mm_struct:

commit 2e3025434a6b ("mm: relocate 'write_protect_seq' in struct mm_struct")

                /*
                 * With some kernel config, the current mmap_lock's offset
                 * inside 'mm_struct' is at 0x120, which is very optimal, as
                 * its two hot fields 'count' and 'owner' sit in 2 different
                 * cachelines,  and when mmap_lock is highly contended, both
                 * of the 2 fields will be accessed frequently, current layout
                 * will help to reduce cache bouncing.
                 *
                 * So please be careful with adding new fields before
                 * mmap_lock, which can easily push the 2 fields into one
                 * cacheline.
                 */
                struct rw_semaphore mmap_lock;

This comment is rather odd for a few reasons:

- It requires addition/removal of mm_struct fields to carefully consider
  field alignment of _other_ fields,
- It expresses the wish to keep an "optimal" alignment for a specific
  kernel config.

I suspect that the author of this comment may want to revisit this topic
and perhaps introduce a split-struct approach for struct rw_semaphore,
if the need is to place various fields of this structure in different
cache lines.

Link: https://lkml.kernel.org/r/20230515143536.114960-1-mathieu.desnoyers@efficios.com
Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
Link: https://lore.kernel.org/lkml/7a0c1db1-103d-d518-ed96-1584a28fbf32@efficios.com
Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/oe-lkp/202305151017.27581d75-yujie.liu@intel.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Aaron Lu <aaron.lu@intel.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Olivier Dion <odion@efficios.com>
Cc: <michael.christie@oracle.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mm_types.h | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 306a3d1a0fa65..de10fc797c8e9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -583,6 +583,21 @@ struct mm_cid {
 struct kioctx_table;
 struct mm_struct {
 	struct {
+		/*
+		 * Fields which are often written to are placed in a separate
+		 * cache line.
+		 */
+		struct {
+			/**
+			 * @mm_count: The number of references to &struct
+			 * mm_struct (@mm_users count as 1).
+			 *
+			 * Use mmgrab()/mmdrop() to modify. When this drops to
+			 * 0, the &struct mm_struct is freed.
+			 */
+			atomic_t mm_count;
+		} ____cacheline_aligned_in_smp;
+
 		struct maple_tree mm_mt;
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
@@ -620,14 +635,6 @@ struct mm_struct {
 		 */
 		atomic_t mm_users;
 
-		/**
-		 * @mm_count: The number of references to &struct mm_struct
-		 * (@mm_users count as 1).
-		 *
-		 * Use mmgrab()/mmdrop() to modify. When this drops to 0, the
-		 * &struct mm_struct is freed.
-		 */
-		atomic_t mm_count;
 #ifdef CONFIG_SCHED_MM_CID
 		/**
 		 * @pcpu_cid: Per-cpu current cid.
-- 
2.39.2



