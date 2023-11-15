Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92287ECF7B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbjKOTsr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbjKOTso (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:48:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755B2189
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:48:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E551CC433CA;
        Wed, 15 Nov 2023 19:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077721;
        bh=KSJXqv1FS9yiChj4cY92BFCvHgg1krgaQOWSOnpS4OE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQG17sDn9YfRfNw87DM+Cx+iI0jJMgOA7lYggQv7XZfTgThQuiHQJMT7oKrRPnkz8
         +mGRoCSFLiJZXAEdGj2Ra9ETooaF93RNLcr1RLpkR2GfCRP9vW6ngsJ+dASVRVJxME
         XQgbszoza8OHS6InnjzSRvJ9l/Y7T3rtICIPL3J8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sachin Sant <sachinp@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 478/603] powerpc/vmcore: Add MMU information to vmcoreinfo
Date:   Wed, 15 Nov 2023 14:17:03 -0500
Message-ID: <20231115191645.508387063@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aditya Gupta <adityag@linux.ibm.com>

[ Upstream commit 36e826b568e412f61d68fedc02a67b4d8b7583cc ]

Since below commit, address mapping for vmemmap has changed for Radix
MMU, where address mapping is stored in kernel page table itself,
instead of earlier used 'vmemmap_list'.

    commit 368a0590d954 ("powerpc/book3s64/vmemmap: switch radix to use
    a different vmemmap handling function")

Hence with upstream kernel, in case of Radix MMU, makedumpfile fails
to do address translation for vmemmap addresses, as it depended on
vmemmap_list, which can now be empty.

While fixing the address translation in makedumpfile, it was identified
that currently makedumpfile cannot distinguish between Hash MMU and
Radix MMU, unless VMLINUX is passed with -x flag to makedumpfile. And
hence fails to assign offsets and shifts correctly (such as in L4 to
PGDIR offset calculation in makedumpfile).

For getting the MMU, makedumpfile uses `cur_cpu_spec.mmu_features`.

Add `cur_cpu_spec` symbol and offset of `mmu_features` in the `cpu_spec`
struct, to VMCOREINFO, so that makedumpfile can assign the offsets
correctly, without needing a VMLINUX.

Also, even along with `cur_cpu_spec->mmu_features` makedumpfile has to
depend on the 'MMU_FTR_TYPE_RADIX' flag in mmu_features, implying kernel
developers need to be cautious of changes to 'MMU_FTR_*' defines.

A more stable approach was suggested in the below thread by contributors:
 https://lore.kernel.org/linuxppc-dev/20230920105706.853626-1-adityag@linux.ibm.com/

The suggestion was to add whether 'RADIX_MMU' is enabled in vmcoreinfo

This patch also implements the suggestion, by adding 'RADIX_MMU' in
vmcoreinfo, which makedumpfile can use to get whether the crashed system
had RADIX MMU (in which case 'NUMBER(RADIX_MMU)=1') or not (in which
case 'NUMBER(RADIX_MMU)=0')

Fixes: 368a0590d954 ("powerpc/book3s64/vmemmap: switch radix to use a different vmemmap handling function")
Reported-by: Sachin Sant <sachinp@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231023072612.50874-1-adityag@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kexec/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index de64c79629912..005269ac3244c 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -74,6 +74,9 @@ void arch_crash_save_vmcoreinfo(void)
 	VMCOREINFO_STRUCT_SIZE(mmu_psize_def);
 	VMCOREINFO_OFFSET(mmu_psize_def, shift);
 #endif
+	VMCOREINFO_SYMBOL(cur_cpu_spec);
+	VMCOREINFO_OFFSET(cpu_spec, mmu_features);
+	vmcoreinfo_append_str("NUMBER(RADIX_MMU)=%d\n", early_radix_enabled());
 	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
 }
 
-- 
2.42.0



