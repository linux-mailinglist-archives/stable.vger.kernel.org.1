Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A397F73E7C3
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjFZSTD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjFZSS6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:18:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF32E7F
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:18:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9754560F4B
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C186C433C8;
        Mon, 26 Jun 2023 18:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803513;
        bh=q6xU1RZXwjZczp8czatjCzEI2Ra6intsSlDKa27wJCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cHtKlHh/DGiUQpOKJk2i0vJHboZvWfM0e6STiF5BPA0BuWkbkXlMTcT634i9Cao2Z
         ZCPOA79AoEEk+6I3fLv2tA43aNx9u3txCn5b4qx9L8wmweLvV8AA5Rnn1048vHGW2h
         uRWneWPt13XqeXPSu6d9XBaH+QwKDY/zLkcQxX9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krister Johansen <kjlx@templeofstupid.com>,
        Yonghong Song <yhs@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 6.3 086/199] bpf: ensure main program has an extable
Date:   Mon, 26 Jun 2023 20:09:52 +0200
Message-ID: <20230626180809.372516125@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Krister Johansen <kjlx@templeofstupid.com>

commit 0108a4e9f3584a7a2c026d1601b0682ff7335d95 upstream.

When subprograms are in use, the main program is not jit'd after the
subprograms because jit_subprogs sets a value for prog->bpf_func upon
success.  Subsequent calls to the JIT are bypassed when this value is
non-NULL.  This leads to a situation where the main program and its
func[0] counterpart are both in the bpf kallsyms tree, but only func[0]
has an extable.  Extables are only created during JIT.  Now there are
two nearly identical program ksym entries in the tree, but only one has
an extable.  Depending upon how the entries are placed, there's a chance
that a fault will call search_extable on the aux with the NULL entry.

Since jit_subprogs already copies state from func[0] to the main
program, include the extable pointer in this state duplication.
Additionally, ensure that the copy of the main program in func[0] is not
added to the bpf_prog_kallsyms table. Instead, let the main program get
added later in bpf_prog_load().  This ensures there is only a single
copy of the main program in the kallsyms table, and that its tag matches
the tag observed by tooling like bpftool.

Cc: stable@vger.kernel.org
Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function programs")
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Link: https://lore.kernel.org/r/6de9b2f4b4724ef56efbb0339daaa66c8b68b1e7.1686616663.git.kjlx@templeofstupid.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16198,9 +16198,10 @@ static int jit_subprogs(struct bpf_verif
 	}
 
 	/* finally lock prog and jit images for all functions and
-	 * populate kallsysm
+	 * populate kallsysm. Begin at the first subprogram, since
+	 * bpf_prog_load will add the kallsyms for the main program.
 	 */
-	for (i = 0; i < env->subprog_cnt; i++) {
+	for (i = 1; i < env->subprog_cnt; i++) {
 		bpf_prog_lock_ro(func[i]);
 		bpf_prog_kallsyms_add(func[i]);
 	}
@@ -16226,6 +16227,8 @@ static int jit_subprogs(struct bpf_verif
 	prog->jited = 1;
 	prog->bpf_func = func[0]->bpf_func;
 	prog->jited_len = func[0]->jited_len;
+	prog->aux->extable = func[0]->aux->extable;
+	prog->aux->num_exentries = func[0]->aux->num_exentries;
 	prog->aux->func = func;
 	prog->aux->func_cnt = env->subprog_cnt;
 	bpf_prog_jit_attempt_done(prog);


