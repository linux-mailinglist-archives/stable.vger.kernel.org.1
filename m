Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A3172178D
	for <lists+stable@lfdr.de>; Sun,  4 Jun 2023 16:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjFDOBL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 4 Jun 2023 10:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjFDOBK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 4 Jun 2023 10:01:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B9690
        for <stable@vger.kernel.org>; Sun,  4 Jun 2023 07:01:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B17160E86
        for <stable@vger.kernel.org>; Sun,  4 Jun 2023 14:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C92C433D2;
        Sun,  4 Jun 2023 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685887268;
        bh=N4OFkIofJcG4jbiBZuJM/QCykJe9kktreLtBi08BAQU=;
        h=From:To:Cc:Subject:Date:From;
        b=jqMaBPppWjwld7hKoaTIAQgPbMaSl19LBnAhB4B1ud4EnbyMZuzkwdsXp2HSn5+iy
         m/JehzdLvij9nc4i8mO1wt2oWkQrD8yFKhSfkLqxO7Qk2Of0q/Yw3lksQ0Q4V3wt0I
         XU8iV5jCXxSIfb5u/VfAqrF+UFDsm/n2jf6GVmOuQ8HY08ndA7Sj4X7PxTOc6KhX6m
         IaOF81WfYVAVyHAgOhwfhd1S8Pkb3xXYi6efQmo2EBM5FwIgOKpTyRtQT2/AWjQUUB
         NRZ+DVMQzlzFJlQlsi81YUcqUynSwQxbBP4cYiQDnm+udonloqkfGjSPdyC8CYcCIW
         Y/ZBRPjmeMh3A==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     stable@vger.kernel.org,
        Anastasios Papagiannis <tasos.papagiannnis@gmail.com>,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf] bpf: Add extra path pointer check to d_path helper
Date:   Sun,  4 Jun 2023 16:01:03 +0200
Message-Id: <20230604140103.3542071-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

Anastasios reported crash on stable 5.15 kernel with following
bpf attached to lsm hook:

  SEC("lsm.s/bprm_creds_for_exec")
  int BPF_PROG(bprm_creds_for_exec, struct linux_binprm *bprm)
  {
          struct path *path = &bprm->executable->f_path;
          char p[128] = { 0 };

          bpf_d_path(path, p, 128);
          return 0;
  }

but bprm->executable can be NULL, so bpf_d_path call will crash:

  BUG: kernel NULL pointer dereference, address: 0000000000000018
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
  ...
  RIP: 0010:d_path+0x22/0x280
  ...
  Call Trace:
   <TASK>
   bpf_d_path+0x21/0x60
   bpf_prog_db9cf176e84498d9_bprm_creds_for_exec+0x94/0x99
   bpf_trampoline_6442506293_0+0x55/0x1000
   bpf_lsm_bprm_creds_for_exec+0x5/0x10
   security_bprm_creds_for_exec+0x29/0x40
   bprm_execve+0x1c1/0x900
   do_execveat_common.isra.0+0x1af/0x260
   __x64_sys_execve+0x32/0x40

It's problem for all stable trees with bpf_d_path helper, which was
added in 5.9.

This issue is fixed in current bpf code, where we identify and mark
trusted pointers, so the above code would fail to load.

For the sake of the stable trees and to workaround potentially broken
verifier in the future, adding the code that reads the path object from
the passed pointer and verifies it's valid in kernel space.

Cc: stable@vger.kernel.org # v5.9+
Fixes: 6e22ab9da793 ("bpf: Add d_path helper")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Reported-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9a050e36dc6c..aecd98ee73dc 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -900,12 +900,22 @@ static const struct bpf_func_proto bpf_send_signal_thread_proto = {
 
 BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
 {
+	struct path copy;
 	long len;
 	char *p;
 
 	if (!sz)
 		return 0;
 
+	/*
+	 * The path pointer is verified as trusted and safe to use,
+	 * but let's double check it's valid anyway to workaround
+	 * potentially broken verifier.
+	 */
+	len = copy_from_kernel_nofault(&copy, path, sizeof(*path));
+	if (len < 0)
+		return len;
+
 	p = d_path(path, buf, sz);
 	if (IS_ERR(p)) {
 		len = PTR_ERR(p);
-- 
2.40.1

