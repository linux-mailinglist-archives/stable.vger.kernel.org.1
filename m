Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECB37BDE24
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377000AbjJINQ0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376431AbjJINQO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:16:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11EA91
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:16:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC66C433C9;
        Mon,  9 Oct 2023 13:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857372;
        bh=78pO4vFjxdXA+zadLLG3QzRnCP8LjGF308X9a8X0dMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oyYNK893jXR/1RpWgsyNfr5DwUlks9bzmvxi1jAhigu1kq6K97JSeM5IIuRQygQYZ
         mnAqPe8ArpGL+pdQdoyDYdHPGyhzVOMZFX6bJEUoO8cDRwWwRQKB17OL0DO7gOXOYg
         u3lTDsWU62OTukbqghPS1JkTT8U6D5ID1abg7wP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jane Chu <jane.chu@oracle.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 025/162] mm/mempolicy: convert queue_pages_pmd() to queue_folios_pmd()
Date:   Mon,  9 Oct 2023 15:00:06 +0200
Message-ID: <20231009130123.640602223@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vishal Moola (Oracle) <vishal.moola@gmail.com>

[ Upstream commit de1f5055523e9a035b38533f25a56df03d45034a ]

The function now operates on a folio instead of the page associated with a
pmd.

This change is in preparation for the conversion of queue_pages_required()
to queue_folio_required() and migrate_page_add() to migrate_folio_add().

Link: https://lkml.kernel.org/r/20230130201833.27042-3-vishal.moola@gmail.com
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: "Yin, Fengwei" <fengwei.yin@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 24526268f4e3 ("mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and MPOL_MF_MOVE are specified")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mempolicy.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 7d36dd95d1fff..3a291026e1896 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -442,21 +442,21 @@ static inline bool queue_pages_required(struct page *page,
 }
 
 /*
- * queue_pages_pmd() has three possible return values:
- * 0 - pages are placed on the right node or queued successfully, or
+ * queue_folios_pmd() has three possible return values:
+ * 0 - folios are placed on the right node or queued successfully, or
  *     special page is met, i.e. huge zero page.
- * 1 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
+ * 1 - there is unmovable folio, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
  *     specified.
  * -EIO - is migration entry or only MPOL_MF_STRICT was specified and an
- *        existing page was already on a node that does not follow the
+ *        existing folio was already on a node that does not follow the
  *        policy.
  */
-static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
+static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
 	__releases(ptl)
 {
 	int ret = 0;
-	struct page *page;
+	struct folio *folio;
 	struct queue_pages *qp = walk->private;
 	unsigned long flags;
 
@@ -464,19 +464,19 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 		ret = -EIO;
 		goto unlock;
 	}
-	page = pmd_page(*pmd);
-	if (is_huge_zero_page(page)) {
+	folio = pfn_folio(pmd_pfn(*pmd));
+	if (is_huge_zero_page(&folio->page)) {
 		walk->action = ACTION_CONTINUE;
 		goto unlock;
 	}
-	if (!queue_pages_required(page, qp))
+	if (!queue_pages_required(&folio->page, qp))
 		goto unlock;
 
 	flags = qp->flags;
-	/* go to thp migration */
+	/* go to folio migration */
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
 		if (!vma_migratable(walk->vma) ||
-		    migrate_page_add(page, qp->pagelist, flags)) {
+		    migrate_page_add(&folio->page, qp->pagelist, flags)) {
 			ret = 1;
 			goto unlock;
 		}
@@ -512,7 +512,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl)
-		return queue_pages_pmd(pmd, ptl, addr, end, walk);
+		return queue_folios_pmd(pmd, ptl, addr, end, walk);
 
 	if (pmd_trans_unstable(pmd))
 		return 0;
-- 
2.40.1



