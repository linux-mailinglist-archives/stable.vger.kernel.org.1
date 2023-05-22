Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9879970C6B5
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjEVTV1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjEVTV1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:21:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7BF93
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:21:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9862062811
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D82C433EF;
        Mon, 22 May 2023 19:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783285;
        bh=KLJjIdXH6hRB8Ucwnx1cimJU8YWmGsHYLp12iSeGY34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qOpe8unftEJ3dNomG8Q3FMNc3Ayn/TttREzujBRJ/CDpBaSfSIfQmAKg6ymZ0e4UB
         XF0ws0/bqhq4dcFQPhghNb5uCUxfdq+pF/czHEQmdWrDqb87f4TosMKy/0BmOUq92h
         qNYA2b6BmaEmxhW3trpyLUjyVzq3jUudOCLeYrWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Dan=20Hor=C3=A1k?= <dan@danny.cz>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.15 198/203] powerpc/64s/radix: Fix soft dirty tracking
Date:   Mon, 22 May 2023 20:10:22 +0100
Message-Id: <20230522190400.518497158@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

From: Michael Ellerman <mpe@ellerman.id.au>

commit 66b2ca086210732954a7790d63d35542936fc664 upstream.

It was reported that soft dirty tracking doesn't work when using the
Radix MMU.

The tracking is supposed to work by clearing the soft dirty bit for a
mapping and then write protecting the PTE. If/when the page is written
to, a page fault occurs and the soft dirty bit is added back via
pte_mkdirty(). For example in wp_page_reuse():

	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
	if (ptep_set_access_flags(vma, vmf->address, vmf->pte, entry, 1))
		update_mmu_cache(vma, vmf->address, vmf->pte);

Unfortunately on radix _PAGE_SOFTDIRTY is being dropped by
radix__ptep_set_access_flags(), called from ptep_set_access_flags(),
meaning the soft dirty bit is not set even though the page has been
written to.

Fix it by adding _PAGE_SOFTDIRTY to the set of bits that are able to be
changed in radix__ptep_set_access_flags().

Fixes: b0b5e9b13047 ("powerpc/mm/radix: Add radix pte #defines")
Cc: stable@vger.kernel.org # v4.7+
Reported-by: Dan Horák <dan@danny.cz>
Link: https://lore.kernel.org/r/20230511095558.56663a50f86bdc4cd97700b7@danny.cz
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230511114224.977423-1-mpe@ellerman.id.au
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1045,8 +1045,8 @@ void radix__ptep_set_access_flags(struct
 				  pte_t entry, unsigned long address, int psize)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
-					      _PAGE_RW | _PAGE_EXEC);
+	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_SOFT_DIRTY |
+					      _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
 
 	unsigned long change = pte_val(entry) ^ pte_val(*ptep);
 	/*


