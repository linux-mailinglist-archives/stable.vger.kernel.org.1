Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA22761555
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjGYL1o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjGYL1n (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:27:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A655497
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:27:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3340C615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4365DC433C7;
        Tue, 25 Jul 2023 11:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284461;
        bh=53P30V4/Tuztb7AwkQE5I7+/kbNl6iH9+/UJx9DtV/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPrFqSAU4ZiMVRYD1miRBA4aaq7bdRR/4B1OLo7iIgWtxyS+UMz8J+gph/wOS6Cfy
         bdQbg6mvKp6PKZN2XUIqRq1XdOZqZCn12ttogTsiLZxIcEU+Z/cgmW0lKtoj49DX1Z
         dRSm6rrwqYhmuCLWY+elimpAvOuXITpggwdBr19E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jisheng Zhang <jszhang@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 364/509] riscv: bpf: Move bpf_jit_alloc_exec() and bpf_jit_free_exec() to core
Date:   Tue, 25 Jul 2023 12:45:03 +0200
Message-ID: <20230725104610.389502592@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

[ Upstream commit 1d27d854425faec98f352cf88ec3e2a8844429a4 ]

We will drop the executable permissions of the code pages from the
mapping at allocation time soon. Move bpf_jit_alloc_exec() and
bpf_jit_free_exec() to bpf_jit_core.c so that they can be shared by
both RV64I and RV32I.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Luke Nelson <luke.r.nels@gmail.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Stable-dep-of: c56fb2aab235 ("riscv, bpf: Fix inconsistent JIT image generation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/net/bpf_jit_comp64.c | 13 -------------
 arch/riscv/net/bpf_jit_core.c   | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index c113ae818b14e..053dc83e323b6 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1144,16 +1144,3 @@ void bpf_jit_build_epilogue(struct rv_jit_context *ctx)
 {
 	__build_epilogue(false, ctx);
 }
-
-void *bpf_jit_alloc_exec(unsigned long size)
-{
-	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
-				    BPF_JIT_REGION_END, GFP_KERNEL,
-				    PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
-				    __builtin_return_address(0));
-}
-
-void bpf_jit_free_exec(void *addr)
-{
-	return vfree(addr);
-}
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index cbf7d2414886e..e295c9eed9e93 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -165,3 +165,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 					   tmp : orig_prog);
 	return prog;
 }
+
+void *bpf_jit_alloc_exec(unsigned long size)
+{
+	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
+				    BPF_JIT_REGION_END, GFP_KERNEL,
+				    PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
+				    __builtin_return_address(0));
+}
+
+void bpf_jit_free_exec(void *addr)
+{
+	return vfree(addr);
+}
-- 
2.39.2



