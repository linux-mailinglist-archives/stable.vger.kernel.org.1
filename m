Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D84872C005
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjFLKtR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjFLKsp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:48:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6865BB4
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC13C623E8
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB009C433D2;
        Mon, 12 Jun 2023 10:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566010;
        bh=M9EkFxKaETGzG3U/8dMOLWOKxrJazkugMGU8uo+V/KU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=txlT8icBz/BeKIw/lRfLxkXqZyxk9ksutefAWTia2NQe+Roh40p1JFGRzDcqACaKn
         V62/BLYEPWcx13k6q9cePKjHkD2Bh2FH1o3i4qq5cuQtgHnFMw35u5aX0SEMVE0Yiu
         fRs8Ab1yFY+5+ctRDG4+SfS4eTPwjJchuK0Chwjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Anastasios Papagiannis <tasos.papagiannnis@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Yonghong Song <yhs@fb.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 30/68] bpf: Add extra path pointer check to d_path helper
Date:   Mon, 12 Jun 2023 12:26:22 +0200
Message-ID: <20230612101659.670230359@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
References: <20230612101658.437327280@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit f46fab0e36e611a2389d3843f34658c849b6bd60 ]

Anastasios reported crash on stable 5.15 kernel with following
BPF attached to lsm hook:

  SEC("lsm.s/bprm_creds_for_exec")
  int BPF_PROG(bprm_creds_for_exec, struct linux_binprm *bprm)
  {
          struct path *path = &bprm->executable->f_path;
          char p[128] = { 0 };

          bpf_d_path(path, p, 128);
          return 0;
  }

But bprm->executable can be NULL, so bpf_d_path call will crash:

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
trusted pointers, so the above code would fail even to load.

For the sake of the stable trees and to workaround potentially broken
verifier in the future, adding the code that reads the path object from
the passed pointer and verifies it's valid in kernel space.

Fixes: 6e22ab9da793 ("bpf: Add d_path helper")
Reported-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20230606181714.532998-1-jolsa@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/bpf_trace.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 94e51d36fb497..9e90d1e7af2c8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1128,13 +1128,23 @@ static const struct bpf_func_proto bpf_send_signal_thread_proto = {
 
 BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
 {
+	struct path copy;
 	long len;
 	char *p;
 
 	if (!sz)
 		return 0;
 
-	p = d_path(path, buf, sz);
+	/*
+	 * The path pointer is verified as trusted and safe to use,
+	 * but let's double check it's valid anyway to workaround
+	 * potentially broken verifier.
+	 */
+	len = copy_from_kernel_nofault(&copy, path, sizeof(*path));
+	if (len < 0)
+		return len;
+
+	p = d_path(&copy, buf, sz);
 	if (IS_ERR(p)) {
 		len = PTR_ERR(p);
 	} else {
-- 
2.39.2



