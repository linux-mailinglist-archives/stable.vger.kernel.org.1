Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6063D703839
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjEORaE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244160AbjEOR3X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:29:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446A1120AC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:27:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25BC262CB7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B50C433D2;
        Mon, 15 May 2023 17:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171625;
        bh=v2FjJd2V0/+q+5jzoEIchjJyOj54CXhm1HIZf4Bg5J8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FjdPHOoWPv+il/WNhEFxPZ8zvxsbpQhg+Z8tZpcKd3HVQaYDao+im4tZWvkbBcOLe
         A+MSWNLsfArPtUgFPoSn8SscNe9SA57jptsaptMb1z5w652NxBRtSixyWiZ1D50i3x
         PDvo0P1YWe3M2gh+pWm0ok4bmkucIsXWAmyg3g2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 027/134] RISC-V: mm: Enable huge page support to kernel_page_present() function
Date:   Mon, 15 May 2023 18:28:24 +0200
Message-Id: <20230515161703.948112652@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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

From: Sia Jee Heng <jeeheng.sia@starfivetech.com>

[ Upstream commit a15c90b67a662c75f469822a7f95c7aaa049e28f ]

Currently kernel_page_present() function doesn't support huge page
detection causes the function to mistakenly return false to the
hibernation core.

Add huge page detection to the function to solve the problem.

Fixes: 9e953cda5cdf ("riscv: Introduce huge page support for 32/64bit kernel")
Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20230330064321.1008373-4-jeeheng.sia@starfivetech.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/mm/pageattr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 86c56616e5dea..ea3d61de065b3 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -217,18 +217,26 @@ bool kernel_page_present(struct page *page)
 	pgd = pgd_offset_k(addr);
 	if (!pgd_present(*pgd))
 		return false;
+	if (pgd_leaf(*pgd))
+		return true;
 
 	p4d = p4d_offset(pgd, addr);
 	if (!p4d_present(*p4d))
 		return false;
+	if (p4d_leaf(*p4d))
+		return true;
 
 	pud = pud_offset(p4d, addr);
 	if (!pud_present(*pud))
 		return false;
+	if (pud_leaf(*pud))
+		return true;
 
 	pmd = pmd_offset(pud, addr);
 	if (!pmd_present(*pmd))
 		return false;
+	if (pmd_leaf(*pmd))
+		return true;
 
 	pte = pte_offset_kernel(pmd, addr);
 	return pte_present(*pte);
-- 
2.39.2



