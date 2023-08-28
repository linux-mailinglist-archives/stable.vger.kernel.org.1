Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D6278AC2B
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjH1Khs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjH1KhJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:37:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33479A6
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C599E613F8
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F4EC433C8;
        Mon, 28 Aug 2023 10:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219026;
        bh=DqyjDvyxG+F+DK49GAM4H3nos1DDDVo7kgQm1j3ItDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FXTPVGykHvyBUnWMbLazy8LqSjet4x2WrcQLXPtcnftfvkhWE0Q4phitCNmeXu9in
         TSbxcvkt5fyG8tB7xeLegrUIkqJnUhbFFFOOdueDxsBiiqUh2Fw6jBO64fJqEXIDJj
         7XFFbStP8+xieeSKfy1jltBUABIXPs5GhvErdraI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 047/158] tracing/probes: Have process_fetch_insn() take a void * instead of pt_regs
Date:   Mon, 28 Aug 2023 12:12:24 +0200
Message-ID: <20230828101158.927717174@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

[ Upstream commit 8565a45d0858078b63c7d84074a21a42ba9ebf01 ]

In preparation to allow event probes to use the process_fetch_insn()
callback in trace_probe_tmpl.h, change the data passed to it from a
pointer to pt_regs, as the event probe will not be using regs, and make it
a void pointer instead.

Update the process_fetch_insn() callers for kprobe and uprobe events to
have the regs defined in the function and just typecast the void pointer
parameter.

Link: https://lkml.kernel.org/r/20210819041842.291622924@goodmis.org

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Stable-dep-of: e38e2c6a9efc ("tracing/probes: Fix to update dynamic data counter if fetcharg uses it")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_kprobe.c     | 3 ++-
 kernel/trace/trace_probe_tmpl.h | 6 +++---
 kernel/trace/trace_uprobe.c     | 3 ++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a422cf6a0358b..0b95277396fcd 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1134,9 +1134,10 @@ probe_mem_read_user(void *dest, void *src, size_t size)
 
 /* Note that we don't verify it, since the code does not come from user space */
 static int
-process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
+process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 		   void *base)
 {
+	struct pt_regs *regs = rec;
 	unsigned long val;
 
 retry:
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 29348874ebde7..bbb479b3ba8fd 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -54,7 +54,7 @@ fetch_apply_bitfield(struct fetch_insn *code, void *buf)
  * If dest is NULL, don't store result and return required dynamic data size.
  */
 static int
-process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs,
+process_fetch_insn(struct fetch_insn *code, void *rec,
 		   void *dest, void *base);
 static nokprobe_inline int fetch_store_strlen(unsigned long addr);
 static nokprobe_inline int
@@ -190,7 +190,7 @@ __get_data_size(struct trace_probe *tp, struct pt_regs *regs)
 
 /* Store the value of each argument */
 static nokprobe_inline void
-store_trace_args(void *data, struct trace_probe *tp, struct pt_regs *regs,
+store_trace_args(void *data, struct trace_probe *tp, void *rec,
 		 int header_size, int maxlen)
 {
 	struct probe_arg *arg;
@@ -205,7 +205,7 @@ store_trace_args(void *data, struct trace_probe *tp, struct pt_regs *regs,
 		/* Point the dynamic data area if needed */
 		if (unlikely(arg->dynamic))
 			*dl = make_data_loc(maxlen, dyndata - base);
-		ret = process_fetch_insn(arg->code, regs, dl, base);
+		ret = process_fetch_insn(arg->code, rec, dl, base);
 		if (unlikely(ret < 0 && arg->dynamic)) {
 			*dl = make_data_loc(0, dyndata - base);
 		} else {
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index efb51a23a14f2..1a566bc675485 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -217,9 +217,10 @@ static unsigned long translate_user_vaddr(unsigned long file_offset)
 
 /* Note that we don't verify it, since the code does not come from user space */
 static int
-process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
+process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 		   void *base)
 {
+	struct pt_regs *regs = rec;
 	unsigned long val;
 
 	/* 1st stage: get value from context */
-- 
2.40.1



