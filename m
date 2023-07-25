Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA93761556
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjGYL1q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjGYL1q (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:27:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D062A6
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:27:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 062556168E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13428C433C9;
        Tue, 25 Jul 2023 11:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284464;
        bh=9ZwEcm4U4G5WCSnIpDN3TmaeAjzX10U+TYWhhAg8HiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FC23ELtJOv17U95xzcElfr17jEelq68ei/WJckiZ1MVad2P2aToB9twBpTqPXn1Mr
         YnNEOI3EgZBzT5e/rUqhDL6UEsoMwp30FVfMcCh0TQgHzqt8Xk7rU561jjcMX33NJP
         K9PnNeFiN2lrP4ozS6Na1ksd9CB+JEpK8z8xymI8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 365/509] riscv: bpf: Avoid breaking W^X
Date:   Tue, 25 Jul 2023 12:45:04 +0200
Message-ID: <20230725104610.438294866@linuxfoundation.org>
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

From: Jisheng Zhang <jszhang@kernel.org>

[ Upstream commit fc8504765ec5e812135b8ccafca7101069a0c6d8 ]

We allocate Non-executable pages, then call bpf_jit_binary_lock_ro()
to enable executable permission after mapping them read-only. This is
to prepare for STRICT_MODULE_RWX in following patch.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Stable-dep-of: c56fb2aab235 ("riscv, bpf: Fix inconsistent JIT image generation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/net/bpf_jit_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index e295c9eed9e93..5d247198c30d3 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -153,6 +153,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	bpf_flush_icache(jit_data->header, ctx->insns + ctx->ninsns);
 
 	if (!prog->is_func || extra_pass) {
+		bpf_jit_binary_lock_ro(jit_data->header);
 out_offset:
 		kfree(ctx->offset);
 		kfree(jit_data);
@@ -170,7 +171,7 @@ void *bpf_jit_alloc_exec(unsigned long size)
 {
 	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
 				    BPF_JIT_REGION_END, GFP_KERNEL,
-				    PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
+				    PAGE_KERNEL, 0, NUMA_NO_NODE,
 				    __builtin_return_address(0));
 }
 
-- 
2.39.2



