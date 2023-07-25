Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014FA761526
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbjGYL0G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjGYL0E (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:26:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CB29D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:26:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F1436166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9FFC433C8;
        Tue, 25 Jul 2023 11:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284360;
        bh=pDQ+42DLVyZ1/fBjlDtEeF83k49JIUS5J8F2fQIqZ2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ziL8Ufy4klV9mLsBbRC1htpCFfD13jh37NMj0jYqryELZKVQ4K/dIqye18EFNIbyp
         Mv7P9mNTTsY/uCrFW6nW89m8az5p/Wf4GjnyeEHXYRuaAswc19Iea8s+hrrBnWFhFH
         ARo7Q7kk4n6JXavJnG6fLYaJCy1gzyXfdh37uehk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Palmer <daniel@thingy.jp>,
        Rob Landley <rob@landley.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rich Felker <dalias@libc.org>
Subject: [PATCH 5.10 311/509] sh: pgtable-3level: Fix cast to pointer from integer of different size
Date:   Tue, 25 Jul 2023 12:44:10 +0200
Message-ID: <20230725104607.979386993@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 8518e694203d0bfd202ea4a80356785b6992322e upstream.

If X2TLB=y (CPU_SHX2=y or CPU_SHX3=y, e.g. migor_defconfig), pgd_t.pgd
is "unsigned long long", causing:

    In file included from arch/sh/include/asm/pgtable.h:13,
		     from include/linux/pgtable.h:6,
		     from include/linux/mm.h:33,
		     from arch/sh/kernel/asm-offsets.c:14:
    arch/sh/include/asm/pgtable-3level.h: In function ‘pud_pgtable’:
    arch/sh/include/asm/pgtable-3level.h:37:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
       37 |  return (pmd_t *)pud_val(pud);
	  |         ^

Fix this by adding an intermediate cast to "unsigned long", which is
basically what the old code did before.

Fixes: 9cf6fa2458443118 ("mm: rename pud_page_vaddr to pud_pgtable and make it return pmd_t *")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Daniel Palmer <daniel@thingy.jp>
Acked-by: Rob Landley <rob@landley.net>
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Rich Felker <dalias@libc.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sh/include/asm/pgtable-3level.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/sh/include/asm/pgtable-3level.h
+++ b/arch/sh/include/asm/pgtable-3level.h
@@ -34,7 +34,7 @@ typedef struct { unsigned long long pmd;
 
 static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return (pmd_t *)pud_val(pud);
+	return (pmd_t *)(unsigned long)pud_val(pud);
 }
 
 /* only used by the stubbed out hugetlb gup code, should never be called */


