Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCD773E8F4
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjFZSav (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjFZSab (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:30:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F270499
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D34060F1E
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C02C433C0;
        Mon, 26 Jun 2023 18:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804230;
        bh=VYLH5n8IPeIldbYbhbsNlQ1X+8ADqiCq0EGLs32y/6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x8onOMc95cdYAHFGnh5EsPOaygfqolRocjDsbaOd+GzrfUQAZJVkNU9p834z1Ifrj
         0O7yP5bRh493TgyAeugL9OXu9OKMzYsS7pdr1eb9a5GRCPlI+XqzqFGAGbhlV2W6Mv
         TpposRYbs99qmF3S2x6yBTA50OujiG2djoo85Xgw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>,
        Lee Jones <lee@kernel.org>
Subject: [PATCH 6.1 078/170] x86/mm: Avoid using set_pgd() outside of real PGD pages
Date:   Mon, 26 Jun 2023 20:10:47 +0200
Message-ID: <20230626180804.106833289@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

From: Lee Jones <lee@kernel.org>

commit d082d48737c75d2b3cc1f972b8c8674c25131534 upstream.

KPTI keeps around two PGDs: one for userspace and another for the
kernel. Among other things, set_pgd() contains infrastructure to
ensure that updates to the kernel PGD are reflected in the user PGD
as well.

One side-effect of this is that set_pgd() expects to be passed whole
pages.  Unfortunately, init_trampoline_kaslr() passes in a single entry:
'trampoline_pgd_entry'.

When KPTI is on, set_pgd() will update 'trampoline_pgd_entry' (an
8-Byte globally stored [.bss] variable) and will then proceed to
replicate that value into the non-existent neighboring user page
(located +4k away), leading to the corruption of other global [.bss]
stored variables.

Fix it by directly assigning 'trampoline_pgd_entry' and avoiding
set_pgd().

[ dhansen: tweak subject and changelog ]

Fixes: 0925dda5962e ("x86/mm/KASLR: Use only one PUD entry for real mode trampoline")
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/all/20230614163859.924309-1-lee@kernel.org/g
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/kaslr.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -172,10 +172,10 @@ void __meminit init_trampoline_kaslr(voi
 		set_p4d(p4d_tramp,
 			__p4d(_KERNPG_TABLE | __pa(pud_page_tramp)));
 
-		set_pgd(&trampoline_pgd_entry,
-			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
+		trampoline_pgd_entry =
+			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp));
 	} else {
-		set_pgd(&trampoline_pgd_entry,
-			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
+		trampoline_pgd_entry =
+			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
 	}
 }


