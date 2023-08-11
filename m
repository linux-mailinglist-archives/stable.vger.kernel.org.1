Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3870779AEF
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 01:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbjHKXEM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 19:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbjHKXDH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 19:03:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0503F35B1;
        Fri, 11 Aug 2023 16:01:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A800F634A6;
        Fri, 11 Aug 2023 23:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FC1C433C7;
        Fri, 11 Aug 2023 23:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691794875;
        bh=yP+OIzP3vIQ7YbcyQlWr3/Nims+782IpswnvOG9I+EU=;
        h=Date:To:From:Subject:From;
        b=QC5It2UtlSRRRqevMpv5flKrUt9EIyYj+KNA6d0hu1ueMcfQxV/utzdTrsVHHXvdJ
         ARtaLNJr6HFIawzfkcGjHCy0AZKDYrCv8YL7+a/m8G9DIgPLHsqdPkvhpEL4QmiiMi
         1YBXLjQr3gfF9/Qb0jzlCtddTenNVagTGiWFvFzI=
Date:   Fri, 11 Aug 2023 16:01:14 -0700
To:     mm-commits@vger.kernel.org, xkernel.wang@foxmail.com,
        stable@vger.kernel.org, glider@google.com, ajd@linux.ibm.com,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-stable] lib-test_meminit-allocate-pages-up-to-order-max_order.patch removed from -mm tree
Message-Id: <20230811230115.06FC1C433C7@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The quilt patch titled
     Subject: lib/test_meminit: allocate pages up to order MAX_ORDER
has been removed from the -mm tree.  Its filename was
     lib-test_meminit-allocate-pages-up-to-order-max_order.patch

This patch was dropped because it was merged into the mm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Andrew Donnellan <ajd@linux.ibm.com>
Subject: lib/test_meminit: allocate pages up to order MAX_ORDER
Date: Fri, 14 Jul 2023 11:52:38 +1000

test_pages() tests the page allocator by calling alloc_pages() with
different orders up to order 10.

However, different architectures and platforms support different maximum
contiguous allocation sizes.  The default maximum allocation order
(MAX_ORDER) is 10, but architectures can use CONFIG_ARCH_FORCE_MAX_ORDER
to override this.  On platforms where this is less than 10, test_meminit()
will blow up with a WARN().  This is expected, so let's not do that.

Replace the hardcoded "10" with the MAX_ORDER macro so that we test
allocations up to the expected platform limit.

Link: https://lkml.kernel.org/r/20230714015238.47931-1-ajd@linux.ibm.com
Fixes: 5015a300a522 ("lib: introduce test_meminit module")
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Cc: Xiaoke Wang <xkernel.wang@foxmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/test_meminit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/test_meminit.c~lib-test_meminit-allocate-pages-up-to-order-max_order
+++ a/lib/test_meminit.c
@@ -93,7 +93,7 @@ static int __init test_pages(int *total_
 	int failures = 0, num_tests = 0;
 	int i;
 
-	for (i = 0; i < 10; i++)
+	for (i = 0; i <= MAX_ORDER; i++)
 		num_tests += do_alloc_pages_order(i, &failures);
 
 	REPORT_FAILURES_IN_FN();
_

Patches currently in -mm which might be from ajd@linux.ibm.com are


