Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E1379AED9
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357920AbjIKWGy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbjIKN72 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:59:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6ECCE5
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:59:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7423C433C8;
        Mon, 11 Sep 2023 13:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440763;
        bh=WQXEP1AM/tpC0OwmoZtHkfQmwOYbOBUrDefZ2bWiR9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xF/sGXIaTOHsohMjaqvuUgU/c02DQHOBlWILpue1wr1oxMJoaYN1xSLioJbwIvIif
         KcSxWLPfxOyObxyCBKQqaKVKvSBL0rVHS0RDF4KtKRwD2b9mB5StSmuJXdw4ixZ33u
         BbRxlO5UjGEUnAwArfc/EUvqf7ZRYizjHsr78RpY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qi Zheng <zhengqi.arch@bytedance.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Muchun Song <muchun.song@linux.dev>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 177/739] arm64: mm: use ptep_clear() instead of pte_clear() in clear_flush()
Date:   Mon, 11 Sep 2023 15:39:36 +0200
Message-ID: <20230911134656.138531837@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

From: Qi Zheng <zhengqi.arch@bytedance.com>

[ Upstream commit 00de2c9f26b15f1a6f2af516dd8ec5f8d28189b7 ]

In clear_flush(), the original pte may be a present entry, so we should
use ptep_clear() to let page_table_check track the pte clearing operation,
otherwise it may cause false positive in subsequent set_pte_at().

Link: https://lkml.kernel.org/r/20230810093241.1181142-1-qi.zheng@linux.dev
Fixes: 42b2547137f5 ("arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 21716c9406821..9c52718ea7509 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -236,7 +236,7 @@ static void clear_flush(struct mm_struct *mm,
 	unsigned long i, saddr = addr;
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
-		pte_clear(mm, addr, ptep);
+		ptep_clear(mm, addr, ptep);
 
 	flush_tlb_range(&vma, saddr, addr);
 }
-- 
2.40.1



