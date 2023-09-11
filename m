Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012D779BF08
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241584AbjIKVK1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242329AbjIKP14 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:27:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8153E4
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:27:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C508C433C9;
        Mon, 11 Sep 2023 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694446072;
        bh=3qHW9Z7P//enYTqQoEu+Jx8ZwR2CYis/p6tLa9p+6VU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkpLeXvasBK76mLgVSo+jzQpQNBJOJMiLvWtCfpC3R9IcaHwGmOz++0dUvtJj5igH
         U19vJS2N60apuYKdtg1Yr6s1Zq8PRdqMJjCm5LcKLrjp02OMhbpeIw7Y4Hnqa0/cUJ
         TmNNeb7KsKQ/PNGXnDIv1wfeqr3zsQI0Ge2jjc7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.1 543/600] LoongArch: mm: Add p?d_leaf() definitions
Date:   Mon, 11 Sep 2023 15:49:36 +0200
Message-ID: <20230911134649.648747560@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hongchen Zhang <zhanghongchen@loongson.cn>

commit 303be4b33562a5b689261ced1616bf16ad49efa7 upstream.

When I do LTP test, LTP test case ksm06 caused panic at
	break_ksm_pmd_entry
	  -> pmd_leaf (Huge page table but False)
	  -> pte_present (panic)

The reason is pmd_leaf() is not defined, So like commit 501b81046701
("mips: mm: add p?d_leaf() definitions") add p?d_leaf() definition for
LoongArch.

Fixes: 09cfefb7fa70 ("LoongArch: Add memory management")
Cc: stable@vger.kernel.org
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/include/asm/pgtable.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -560,6 +560,9 @@ static inline long pmd_protnone(pmd_t pm
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
+#define pmd_leaf(pmd)		((pmd_val(pmd) & _PAGE_HUGE) != 0)
+#define pud_leaf(pud)		((pud_val(pud) & _PAGE_HUGE) != 0)
+
 /*
  * We provide our own get_unmapped area to cope with the virtual aliasing
  * constraints placed on us by the cache architecture.


