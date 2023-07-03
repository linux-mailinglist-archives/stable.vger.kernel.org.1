Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B21B746315
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 20:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGCS5a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 14:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjGCS5a (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 14:57:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028D3E7C
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 11:57:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F5F661015
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B65AC433C8;
        Mon,  3 Jul 2023 18:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688410648;
        bh=paQtj+XL6yGQBYKxfefjHOdMiOlKqWAHduRdiqF4VnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PWX5gKT5PuwHCJk/U6IFC9W3IryBVfOridjwZMfcBRPKcxKzlrRSl4pflRCFigNol
         CxQrrwUfIuThHe1kBI+NQ5FOkbdB1EZB5FRh+Ge03FwCP079p/5jyx5oN1n2YchEZG
         H+T9uxARBO82ZVbsDHtZaHkeetDMtvbGEMJyY5hU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dan Williams <dan.j.williams@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jane Chu <jane.chu@oracle.com>
Subject: [PATCH 5.15 04/15] mm, hwpoison: when copy-on-write hits poison, take page offline
Date:   Mon,  3 Jul 2023 20:54:49 +0200
Message-ID: <20230703184519.016619078@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703184518.896751186@linuxfoundation.org>
References: <20230703184518.896751186@linuxfoundation.org>
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

From: Jane Chu <jane.chu@oracle.com>

From: Tony Luck <tony.luck@intel.com>

commit d302c2398ba269e788a4f37ae57c07a7fcabaa42 upstream.

Cannot call memory_failure() directly from the fault handler because
mmap_lock (and others) are held.

It is important, but not urgent, to mark the source page as h/w poisoned
and unmap it from other tasks.

Use memory_failure_queue() to request a call to memory_failure() for the
page with the error.

Also provide a stub version for CONFIG_MEMORY_FAILURE=n

Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20221021200120.175753-3-tony.luck@intel.com
Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Due to missing commits
  e591ef7d96d6e ("mm,hwpoison,hugetlb,memory_hotplug: hotremove memory section with hwpoisoned hugepage")
  5033091de814a ("mm/hwpoison: introduce per-memory_block hwpoison counter")
  The impact of e591ef7d96d6e is its introduction of an additional flag in
  __get_huge_page_for_hwpoison() that serves as an indication a hwpoisoned
  hugetlb page should have its migratable bit cleared.
  The impact of 5033091de814a is contexual.
  Resolve by ignoring both missing commits. - jane]
Signed-off-by: Jane Chu <jane.chu@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mm.h |    5 ++++-
 mm/memory.c        |    4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3124,7 +3124,6 @@ enum mf_flags {
 	MF_SOFT_OFFLINE = 1 << 3,
 };
 extern int memory_failure(unsigned long pfn, int flags);
-extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
 extern int sysctl_memory_failure_early_kill;
@@ -3133,8 +3132,12 @@ extern void shake_page(struct page *p);
 extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(unsigned long pfn, int flags);
 #ifdef CONFIG_MEMORY_FAILURE
+extern void memory_failure_queue(unsigned long pfn, int flags);
 extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags);
 #else
+static inline void memory_failure_queue(unsigned long pfn, int flags)
+{
+}
 static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 {
 	return 0;
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2771,8 +2771,10 @@ static inline int cow_user_page(struct p
 	unsigned long addr = vmf->address;
 
 	if (likely(src)) {
-		if (copy_mc_user_highpage(dst, src, addr, vma))
+		if (copy_mc_user_highpage(dst, src, addr, vma)) {
+			memory_failure_queue(page_to_pfn(src), 0);
 			return -EHWPOISON;
+		}
 		return 0;
 	}
 


