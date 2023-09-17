Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797C27A39A9
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbjIQTxH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240182AbjIQTws (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:52:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09031195
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:52:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A900C433C9;
        Sun, 17 Sep 2023 19:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980323;
        bh=59OISQo5yJm9nwZ+bUhiSNP5EokUGs98oC78DXua8lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FipLwws+gCT8JLqBFked0Z0xCdt5giztplJSFS4ff+nAI/99Mp1huE7wJTFz2q87I
         /AyEAr08m/BrrFCUpngbhSEwfcUWGluA/6uKG1Lvv5eyktCvhCxkhSK+urJbBNYlp8
         rQP7cJ5UB++NVgDzDs7A86WsC0DTUvvbO/kN8aQc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 158/285] bpf: Assign bpf_tramp_run_ctx::saved_run_ctx before recursion check.
Date:   Sun, 17 Sep 2023 21:12:38 +0200
Message-ID: <20230917191057.146769732@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 6764e767f4af1e35f87f3497e1182d945de37f93 ]

__bpf_prog_enter_recur() assigns bpf_tramp_run_ctx::saved_run_ctx before
performing the recursion check which means in case of a recursion
__bpf_prog_exit_recur() uses the previously set bpf_tramp_run_ctx::saved_run_ctx
value.

__bpf_prog_enter_sleepable_recur() assigns bpf_tramp_run_ctx::saved_run_ctx
after the recursion check which means in case of a recursion
__bpf_prog_exit_sleepable_recur() uses an uninitialized value. This does not
look right. If I read the entry trampoline code right, then bpf_tramp_run_ctx
isn't initialized upfront.

Align __bpf_prog_enter_sleepable_recur() with __bpf_prog_enter_recur() and
set bpf_tramp_run_ctx::saved_run_ctx before the recursion check is made.
Remove the assignment of saved_run_ctx in kern_sys_bpf() since it happens
a few cycles later.

Fixes: e384c7b7b46d0 ("bpf, x86: Create bpf_tramp_run_ctx on the caller thread's stack")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/20230830080405.251926-3-bigeasy@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c    | 1 -
 kernel/bpf/trampoline.c | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c925c270ed8b4..1480b6cf12f06 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5304,7 +5304,6 @@ int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 		}
 
 		run_ctx.bpf_cookie = 0;
-		run_ctx.saved_run_ctx = NULL;
 		if (!__bpf_prog_enter_sleepable_recur(prog, &run_ctx)) {
 			/* recursion detected */
 			__bpf_prog_exit_sleepable_recur(prog, 0, &run_ctx);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 78acf28d48732..53ff50cac61ea 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -926,13 +926,12 @@ u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 	migrate_disable();
 	might_fault();
 
+	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
+
 	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
 		bpf_prog_inc_misses_counter(prog);
 		return 0;
 	}
-
-	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
-
 	return bpf_prog_start_time();
 }
 
-- 
2.40.1



