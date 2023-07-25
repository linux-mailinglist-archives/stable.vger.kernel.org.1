Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B56761557
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjGYL1t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjGYL1t (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:27:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4789BA1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:27:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAE4A6168E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9C1C433C8;
        Tue, 25 Jul 2023 11:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284467;
        bh=DBAnGhkIG0GD1gojO8HdhwmgPgMpW92RFgfObtQxaKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rA7Znn9TXVosmzhmGFSvzc+Na9F6pmkc7tWiK6cMWrLgtvhw3TNPAaIfBsTpjXoqM
         vk+0UGD7MKtzubpgZVpXHX0g/F18PFGyr/SPnYUaT2Wm2ke0pNHS3bYz2DQBZUR82B
         YSndavwcorqVhcT6Bvs+mHtF8twz0TlEwKYCVRxw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pu Lehui <pulehui@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 366/509] bpf, riscv: Support riscv jit to provide bpf_line_info
Date:   Tue, 25 Jul 2023 12:45:05 +0200
Message-ID: <20230725104610.481770618@linuxfoundation.org>
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

From: Pu Lehui <pulehui@huawei.com>

[ Upstream commit 3cb70413041fdf028fa1ba3986fd0c6aec9e3dcb ]

Add support for riscv jit to provide bpf_line_info. We need to
consider the prologue offset in ctx->offset, but unlike x86 and
arm64, ctx->offset of riscv does not provide an extra slot for
the prologue, so here we just calculate the len of prologue and
add it to ctx->offset at the end. Both RV64 and RV32 have been
tested.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20220530092815.1112406-3-pulehui@huawei.com
Stable-dep-of: c56fb2aab235 ("riscv, bpf: Fix inconsistent JIT image generation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/net/bpf_jit.h      | 1 +
 arch/riscv/net/bpf_jit_core.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 75c1e99968675..ab0cd6d10ccf3 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -69,6 +69,7 @@ struct rv_jit_context {
 	struct bpf_prog *prog;
 	u16 *insns;		/* RV insns */
 	int ninsns;
+	int body_len;
 	int epilogue_offset;
 	int *offset;		/* BPF to RV */
 	unsigned long flags;
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 5d247198c30d3..750b15c319d5d 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -43,7 +43,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
 	bool tmp_blinded = false, extra_pass = false;
 	struct bpf_prog *tmp, *orig_prog = prog;
-	int pass = 0, prev_ninsns = 0, i;
+	int pass = 0, prev_ninsns = 0, prologue_len, i;
 	struct rv_jit_data *jit_data;
 	struct rv_jit_context *ctx;
 	unsigned int image_size = 0;
@@ -95,6 +95,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			prog = orig_prog;
 			goto out_offset;
 		}
+		ctx->body_len = ctx->ninsns;
 		bpf_jit_build_prologue(ctx);
 		ctx->epilogue_offset = ctx->ninsns;
 		bpf_jit_build_epilogue(ctx);
@@ -154,6 +155,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	if (!prog->is_func || extra_pass) {
 		bpf_jit_binary_lock_ro(jit_data->header);
+		prologue_len = ctx->epilogue_offset - ctx->body_len;
+		for (i = 0; i < prog->len; i++)
+			ctx->offset[i] = ninsns_rvoff(prologue_len +
+						      ctx->offset[i]);
+		bpf_prog_fill_jited_linfo(prog, ctx->offset);
 out_offset:
 		kfree(ctx->offset);
 		kfree(jit_data);
-- 
2.39.2



