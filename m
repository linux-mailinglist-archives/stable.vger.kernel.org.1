Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4109761223
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjGYK7v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjGYK71 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:59:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93851FE3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55F8E61656
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59129C433C8;
        Tue, 25 Jul 2023 10:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282583;
        bh=AL0LzlPmcDIGVrl0V9oSLUaMZbWPhfrJbnbn/gTQGJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=InMjwX3Mdzq+IcWPHVcZQEeyTxgA3nGZ+K6UJx9ieBQ4q5YOBjb7dNpcJ2d1yJtys
         KUGGoXz5uqRMt2Yvej11FZt5YE2M3jx1n4x+RqcFtDXj6gqy7f5JfN36Cw6wXfs2qZ
         NduPh+YTsqZdPwXliHU0aO3QYFPCnORCHi/n30zM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 181/227] bpf: Repeat check_max_stack_depth for async callbacks
Date:   Tue, 25 Jul 2023 12:45:48 +0200
Message-ID: <20230725104522.317164268@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
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

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

[ Upstream commit b5e9ad522c4ccd32d322877515cff8d47ed731b9 ]

While the check_max_stack_depth function explores call chains emanating
from the main prog, which is typically enough to cover all possible call
chains, it doesn't explore those rooted at async callbacks unless the
async callback will have been directly called, since unlike non-async
callbacks it skips their instruction exploration as they don't
contribute to stack depth.

It could be the case that the async callback leads to a callchain which
exceeds the stack depth, but this is never reachable while only
exploring the entry point from main subprog. Hence, repeat the check for
the main subprog *and* all async callbacks marked by the symbolic
execution pass of the verifier, as execution of the program may begin at
any of them.

Consider functions with following stack depths:
main: 256
async: 256
foo: 256

main:
    rX = async
    bpf_timer_set_callback(...)

async:
    foo()

Here, async is not descended as it does not contribute to stack depth of
main (since it is referenced using bpf_pseudo_func and not
bpf_pseudo_call). However, when async is invoked asynchronously, it will
end up breaching the MAX_BPF_STACK limit by calling foo.

Hence, in addition to main, we also need to explore call chains
beginning at all async callback subprogs in a program.

Fixes: 7ddc80a476c2 ("bpf: Teach stack depth check about async callbacks.")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20230717161530.1238-3-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e95bfe45fd890..4fbfe1d086467 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5381,16 +5381,17 @@ static int update_stack_depth(struct bpf_verifier_env *env,
  * Since recursion is prevented by check_cfg() this algorithm
  * only needs a local stack of MAX_CALL_FRAMES to remember callsites
  */
-static int check_max_stack_depth(struct bpf_verifier_env *env)
+static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
 {
-	int depth = 0, frame = 0, idx = 0, i = 0, subprog_end;
 	struct bpf_subprog_info *subprog = env->subprog_info;
 	struct bpf_insn *insn = env->prog->insnsi;
+	int depth = 0, frame = 0, i, subprog_end;
 	bool tail_call_reachable = false;
 	int ret_insn[MAX_CALL_FRAMES];
 	int ret_prog[MAX_CALL_FRAMES];
 	int j;
 
+	i = subprog[idx].start;
 process_func:
 	/* protect against potential stack overflow that might happen when
 	 * bpf2bpf calls get combined with tailcalls. Limit the caller's stack
@@ -5491,6 +5492,22 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 	goto continue_func;
 }
 
+static int check_max_stack_depth(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	int ret;
+
+	for (int i = 0; i < env->subprog_cnt; i++) {
+		if (!i || si[i].is_async_cb) {
+			ret = check_max_stack_depth_subprog(env, i);
+			if (ret < 0)
+				return ret;
+		}
+		continue;
+	}
+	return 0;
+}
+
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 static int get_callee_stack_depth(struct bpf_verifier_env *env,
 				  const struct bpf_insn *insn, int idx)
-- 
2.39.2



