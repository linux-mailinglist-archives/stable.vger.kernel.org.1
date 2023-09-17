Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4125E7A3AF8
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbjIQULR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240550AbjIQUKy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:10:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2E6B5
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:10:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59B5C433C7;
        Sun, 17 Sep 2023 20:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981449;
        bh=sRlh+OtRaEJGGS1KCDe7nDzhEKHPAfyJpOKDsIbllvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qpBbhzmEiNbKXplpEOVoBGKPoHbEnwgoDf9E/4RH0iSWRfzWn1YNGOjYNPk9YyCqT
         RwI9SSbCoXrhcDab0E8M8ZpnFdq7HZ9G78FL5emE/84/mJtVUbBjVcJesnViiyvWZm
         9U9VH+DrGTc8pibzo0bzMeQeVy2nqGUWRQN/0DGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 125/219] bpf: Invoke __bpf_prog_exit_sleepable_recur() on recursion in kern_sys_bpf().
Date:   Sun, 17 Sep 2023 21:14:12 +0200
Message-ID: <20230917191045.504071998@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 7645629f7dc88cd777f98970134bf1a54c8d77e3 ]

If __bpf_prog_enter_sleepable_recur() detects recursion then it returns
0 without undoing rcu_read_lock_trace(), migrate_disable() or
decrementing the recursion counter. This is fine in the JIT case because
the JIT code will jump in the 0 case to the end and invoke the matching
exit trampoline (__bpf_prog_exit_sleepable_recur()).

This is not the case in kern_sys_bpf() which returns directly to the
caller with an error code.

Add __bpf_prog_exit_sleepable_recur() as clean up in the recursion case.

Fixes: b1d18a7574d0d ("bpf: Extend sys_bpf commands for bpf_syscall programs.")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/20230830080405.251926-2-bigeasy@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7afec961c5728..76484137233a3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5138,6 +5138,7 @@ int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 		run_ctx.saved_run_ctx = NULL;
 		if (!__bpf_prog_enter_sleepable_recur(prog, &run_ctx)) {
 			/* recursion detected */
+			__bpf_prog_exit_sleepable_recur(prog, 0, &run_ctx);
 			bpf_prog_put(prog);
 			return -EBUSY;
 		}
-- 
2.40.1



