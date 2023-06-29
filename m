Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA6B742C45
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjF2Spt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjF2Sps (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:45:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9350F2681
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20E8B615E8
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08530C433C9;
        Thu, 29 Jun 2023 18:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064346;
        bh=0y5DqGd5KmxdNEG6v1B7kgsznTONDOct/413mfGoDVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sCtr4nl4YKsH6BF3chTGM7sorwmSagLEzwRwLBiWnnmJgGJNRCkmUz2UuKCbY73z6
         AmYGLHYVlE1pbro4XUHcEvRe+YnX4za2szz3dMBFp46h+4xuIyyZptErzYqkoQaaVS
         tKnRNmk8aDsn7WirA6FJh4PTd/Wz4mIi2VkslZiA=
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
Subject: [PATCH 6.1 05/30] mm, hwpoison: when copy-on-write hits poison, take page offline
Date:   Thu, 29 Jun 2023 20:43:24 +0200
Message-ID: <20230629184151.888900516@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.651069086@linuxfoundation.org>
References: <20230629184151.651069086@linuxfoundation.org>
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

From: Tony Luck <tony.luck@intel.com>

commit d302c2398ba269e788a4f37ae57c07a7fcabaa42 upstream.

Cannot call memory_failure() directly from the fault handler because
mmap_lock (and others) are held.

It is important, but not urgent, to mark the source page as h/w poisoned
and unmap it from other tasks.

Use memory_failure_queue() to request a call to memory_failure() for the
page with the error.

Also provide a stub version for CONFIG_MEMORY_FAILURE=n

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
@@ -3295,7 +3295,6 @@ enum mf_flags {
 int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 		      unsigned long count, int mf_flags);
 extern int memory_failure(unsigned long pfn, int flags);
-extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
 extern int sysctl_memory_failure_early_kill;
@@ -3304,8 +3303,12 @@ extern void shake_page(struct page *p);
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
@@ -2861,8 +2861,10 @@ static inline int __wp_page_copy_user(st
 	unsigned long addr = vmf->address;
 
 	if (likely(src)) {
-		if (copy_mc_user_highpage(dst, src, addr, vma))
+		if (copy_mc_user_highpage(dst, src, addr, vma)) {
+			memory_failure_queue(page_to_pfn(src), 0);
 			return -EHWPOISON;
+		}
 		return 0;
 	}
 


