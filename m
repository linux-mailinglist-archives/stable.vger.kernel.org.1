Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5828A7D9D3A
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 17:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346203AbjJ0Pnk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 11:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345780AbjJ0Pnj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 11:43:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D7ACC;
        Fri, 27 Oct 2023 08:43:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D8DC433C9;
        Fri, 27 Oct 2023 15:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698421416;
        bh=zBXzV8gBcudo5xZH7k0IDW1zRsKp9Aa4Wlv1ciRXnyQ=;
        h=Date:To:From:Subject:From;
        b=LuF2wubipQaR+pnexlUoU0QX3mjtqj5a89PFaCVhQwsksjaaFrlrSooaXEzHvIq3E
         u9d5z9uyrPoEhv0sWfSRojNSXZtW1FgVSFatLax5DMvPA67zFnQzbbSYQNXbZ4lRzx
         Yr4OKo9VDDxkikxJ1RaifcvZ2roYyvKq9cpfKMAs=
Date:   Fri, 27 Oct 2023 08:43:36 -0700
To:     mm-commits@vger.kernel.org, vbabka@suse.cz, stable@vger.kernel.org,
        osalvador@suse.de, mgorman@techsingularity.net, david@redhat.com,
        dan.j.williams@intel.com, aneesh.kumar@linux.ibm.com,
        quic_charante@quicinc.com, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-sparsemem-fix-race-in-accessing-memory_section-usage-v2.patch added to mm-hotfixes-unstable branch
Message-Id: <20231027154336.D9D8DC433C9@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: mm/sparsemem: fix race in accessing memory_section->usage
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-sparsemem-fix-race-in-accessing-memory_section-usage-v2.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-sparsemem-fix-race-in-accessing-memory_section-usage-v2.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Charan Teja Kalla <quic_charante@quicinc.com>
Subject: mm/sparsemem: fix race in accessing memory_section->usage
Date: Fri, 27 Oct 2023 16:19:38 +0530

use kfree_rcu() in place of synchronize_rcu(), per David

Link: https://lkml.kernel.org/r/1698403778-20938-1-git-send-email-quic_charante@quicinc.com
Fixes: f46edbd1b151 ("mm/sparsemem: add helpers track active portions of a section at boot")
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/mmzone.h |    3 ++-
 mm/sparse.c            |    5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/include/linux/mmzone.h~mm-sparsemem-fix-race-in-accessing-memory_section-usage-v2
+++ a/include/linux/mmzone.h
@@ -1770,6 +1770,7 @@ static inline unsigned long section_nr_t
 #define SUBSECTION_ALIGN_DOWN(pfn) ((pfn) & PAGE_SUBSECTION_MASK)
 
 struct mem_section_usage {
+	struct rcu_head rcu;
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
 #endif
@@ -1963,7 +1964,7 @@ static inline int pfn_section_valid(stru
 {
 	int idx = subsection_map_index(pfn);
 
-	return test_bit(idx, ms->usage->subsection_map);
+	return test_bit(idx, READ_ONCE(ms->usage)->subsection_map);
 }
 #else
 static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
--- a/mm/sparse.c~mm-sparsemem-fix-race-in-accessing-memory_section-usage-v2
+++ a/mm/sparse.c
@@ -806,9 +806,8 @@ static void section_deactivate(unsigned
 		 * was allocated during boot.
 		 */
 		if (!PageReserved(virt_to_page(ms->usage))) {
-			synchronize_rcu();
-			kfree(ms->usage);
-			ms->usage = NULL;
+			kfree_rcu(ms->usage, rcu);
+			WRITE_ONCE(ms->usage, NULL);
 		}
 		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
 	}
_

Patches currently in -mm which might be from quic_charante@quicinc.com are

mm-sparsemem-fix-race-in-accessing-memory_section-usage.patch
mm-sparsemem-fix-race-in-accessing-memory_section-usage-v2.patch

