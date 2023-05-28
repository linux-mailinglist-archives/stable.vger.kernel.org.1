Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE70713F65
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjE1To7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjE1To6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:44:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8519E
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:44:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22FBA61F3F
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EE3C4339B;
        Sun, 28 May 2023 19:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303096;
        bh=gapljJqKSbufkbGXlgMmAggUktYg7zqOrsV/4YsczjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OsANoOKkKXGuV+ByYm+C6OHC//3NQGf1f06KgLAS9ufyvPjHwoEOpc4NSy59PelVs
         IAfp6LwZ34s40HC/ROyYK4+vy7fxk+cXu+IqghihS0UM9pZcE3YWn773g7xAz5V/kX
         CzHkBKA1eWcHDTn0gxbti49tnRyxFrxVZKFi2BWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 5.10 153/211] KVM: arm64: Link position-independent string routines into .hyp.text
Date:   Sun, 28 May 2023 20:11:14 +0100
Message-Id: <20230528190847.312277436@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Will Deacon <will@kernel.org>

commit 7b4a7b5e6fefd15f708f959dd43e188444e252ec upstream

Pull clear_page(), copy_page(), memcpy() and memset() into the nVHE hyp
code and ensure that we always execute the '__pi_' entry point on the
offchance that it changes in future.

[ qperret: Commit title nits and added linker script alias ]

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210319100146.1149909-3-qperret@google.com
[sudip: adjust context]
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/hyp_image.h |    3 +++
 arch/arm64/kernel/image-vars.h     |   11 +++++++++++
 arch/arm64/kvm/hyp/nvhe/Makefile   |    4 ++++
 3 files changed, 18 insertions(+)

--- a/arch/arm64/include/asm/hyp_image.h
+++ b/arch/arm64/include/asm/hyp_image.h
@@ -31,6 +31,9 @@
  */
 #define KVM_NVHE_ALIAS(sym)	kvm_nvhe_sym(sym) = sym;
 
+/* Defines a linker script alias for KVM nVHE hyp symbols */
+#define KVM_NVHE_ALIAS_HYP(first, sec)	kvm_nvhe_sym(first) = kvm_nvhe_sym(sec);
+
 #endif /* LINKER_SCRIPT */
 
 #endif /* __ARM64_HYP_IMAGE_H__ */
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -103,6 +103,17 @@ KVM_NVHE_ALIAS(gic_nonsecure_priorities)
 KVM_NVHE_ALIAS(__start___kvm_ex_table);
 KVM_NVHE_ALIAS(__stop___kvm_ex_table);
 
+/* Position-independent library routines */
+KVM_NVHE_ALIAS_HYP(clear_page, __pi_clear_page);
+KVM_NVHE_ALIAS_HYP(copy_page, __pi_copy_page);
+KVM_NVHE_ALIAS_HYP(memcpy, __pi_memcpy);
+KVM_NVHE_ALIAS_HYP(memset, __pi_memset);
+
+#ifdef CONFIG_KASAN
+KVM_NVHE_ALIAS_HYP(__memcpy, __pi_memcpy);
+KVM_NVHE_ALIAS_HYP(__memset, __pi_memset);
+#endif
+
 #endif /* CONFIG_KVM */
 
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -6,9 +6,13 @@
 asflags-y := -D__KVM_NVHE_HYPERVISOR__
 ccflags-y := -D__KVM_NVHE_HYPERVISOR__
 
+lib-objs := clear_page.o copy_page.o memcpy.o memset.o
+lib-objs := $(addprefix ../../../lib/, $(lib-objs))
+
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o hyp-main.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o
+obj-y += $(lib-objs)
 
 ##
 ## Build rules for compiling nVHE hyp code


