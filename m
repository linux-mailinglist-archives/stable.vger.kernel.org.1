Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E64B7A7A97
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjITLn7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbjITLn6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:43:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45837A3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:43:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906CBC433C8;
        Wed, 20 Sep 2023 11:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210232;
        bh=sHx0/kE+hyIoguxb6+JzPMjrFC2bswJ/HlvKXoFa/8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LvIQbsp16U8938y8OKg/zAxJisJPL6HfH/g/lvQoE4yiJZvLzB828PEjTRJTyomfP
         kO64cZoDorsFdG1inzvJRJkAIlFbg0aalIuOWvnLWZjJj1tEjwms+e6OD4XUWQO2XJ
         UZg5r2JQVaysGEGGzoFzV7tbE5ZoC4fyOn9FJUyA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 014/211] s390/boot: cleanup number of page table levels setup
Date:   Wed, 20 Sep 2023 13:27:38 +0200
Message-ID: <20230920112846.266477365@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit 8ddccc8a7d06f7ea4d8579970c95609d1b1de77b ]

The separate vmalloc area size check against _REGION2_SIZE
is needed in case user provided insanely large value using
vmalloc= kernel command line parameter. That could lead to
overflow and selecting 3 page table levels instead of 4.

Use size_add() for the overflow check and get rid of the
extra vmalloc area check.

With the current values of CONFIG_MAX_PHYSMEM_BITS and
PAGES_PER_SECTION the sum of maximal possible size of
identity mapping and vmemmap area (derived from these
macros) plus modules area size MODULES_LEN can not
overflow. Thus, that sum is used as first addend while
vmalloc area size is second addend for size_add().

Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/boot/startup.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 64bd7ac3e35d1..f8d0550e5d2af 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -176,6 +176,7 @@ static unsigned long setup_kernel_memory_layout(void)
 	unsigned long asce_limit;
 	unsigned long rte_size;
 	unsigned long pages;
+	unsigned long vsize;
 	unsigned long vmax;
 
 	pages = ident_map_size / PAGE_SIZE;
@@ -183,11 +184,9 @@ static unsigned long setup_kernel_memory_layout(void)
 	vmemmap_size = SECTION_ALIGN_UP(pages) * sizeof(struct page);
 
 	/* choose kernel address space layout: 4 or 3 levels. */
-	vmemmap_start = round_up(ident_map_size, _REGION3_SIZE);
-	if (IS_ENABLED(CONFIG_KASAN) ||
-	    vmalloc_size > _REGION2_SIZE ||
-	    vmemmap_start + vmemmap_size + vmalloc_size + MODULES_LEN >
-		    _REGION2_SIZE) {
+	vsize = round_up(ident_map_size, _REGION3_SIZE) + vmemmap_size + MODULES_LEN;
+	vsize = size_add(vsize, vmalloc_size);
+	if (IS_ENABLED(CONFIG_KASAN) || (vsize > _REGION2_SIZE)) {
 		asce_limit = _REGION1_SIZE;
 		rte_size = _REGION2_SIZE;
 	} else {
-- 
2.40.1



