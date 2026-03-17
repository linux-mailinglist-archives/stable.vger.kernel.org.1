Return-Path: <stable+bounces-226368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEIENxaHuWncJAIAu9opvQ
	(envelope-from <stable+bounces-226368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:53:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AD64C2AE99C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33A3E3030DB5
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126FA3F23AA;
	Tue, 17 Mar 2026 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VaYrz/ha"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD83EAC6F;
	Tue, 17 Mar 2026 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766388; cv=none; b=aJBrzj5zbELVJjfTFVdlPfSKncyL5V8MaxtKaj0sLOqwWXmQFq4K0NwjSH1QiulxrUSIbSfvWtUyNbyIb4PUoZXNYp4XDdeSYMqh0SFvM41Cg/iNjZ8PTM8OItdv80uo5Eq5x7ywQfpWsxnmx+hylyZhiOl76iQA7caedl0Wyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766388; c=relaxed/simple;
	bh=EN7F63DggcC149eXgZ6Dyksjz/8SLYfjcLlrGfpK3WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhMes79+OqaR20VU/cABXv1PJAejV8b+YiuriIdxEYrmFYWDDBuT8RG3ceC7nOy8CsdCLVGGUUuMxldOKJ3+h/n56tmcQzszPvX6LpYJlesT2VCn7BE2jnjtYTx0292daYX6qz8DE274Uj7/riX3N2VvlGWvAUbOIH6OgYRjDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VaYrz/ha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE5DC4CEF7;
	Tue, 17 Mar 2026 16:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766388;
	bh=EN7F63DggcC149eXgZ6Dyksjz/8SLYfjcLlrGfpK3WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VaYrz/hab12wLGNdnkLQjgrSZg+5NYv6IRuo7YNNOm74GZRAuRSCCI2iBXv2wTPzg
	 uymsWmL4UuEnKnwIF9ddlKSfL+cYcW5YqQmoAnqKjgrzyBaU4BjnfYApRStHhqfPMQ
	 oLrx3CiShVuy8pp49R4IGyp4TbJ3v8WqSl4gQUGY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ye Bin <yebin10@huawei.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.19 203/378] kprobes: avoid crash when rmmod/insmod after ftrace killed
Date: Tue, 17 Mar 2026 17:32:40 +0100
Message-ID: <20260317163014.479569644@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226368-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,goodmis.org:email,huawei.com:email]
X-Rspamd-Queue-Id: AD64C2AE99C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

commit e113f0b46d19626ec15388bcb91432c9a4fd6261 upstream.

After we hit ftrace is killed by some errors, the kernel crash if
we remove modules in which kprobe probes.

BUG: unable to handle page fault for address: fffffbfff805000d
PGD 817fcc067 P4D 817fcc067 PUD 817fc8067 PMD 101555067 PTE 0
Oops: Oops: 0000 [#1] SMP KASAN PTI
CPU: 4 UID: 0 PID: 2012 Comm: rmmod Tainted: G        W  OE
Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
RIP: 0010:kprobes_module_callback+0x89/0x790
RSP: 0018:ffff88812e157d30 EFLAGS: 00010a02
RAX: 1ffffffff805000d RBX: dffffc0000000000 RCX: ffffffff86a8de90
RDX: ffffed1025c2af9b RSI: 0000000000000008 RDI: ffffffffc0280068
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed1025c2af9a
R10: ffff88812e157cd7 R11: 205d323130325420 R12: 0000000000000002
R13: ffffffffc0290488 R14: 0000000000000002 R15: ffffffffc0280040
FS:  00007fbc450dd740(0000) GS:ffff888420331000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff805000d CR3: 000000010f624000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 notifier_call_chain+0xc6/0x280
 blocking_notifier_call_chain+0x60/0x90
 __do_sys_delete_module.constprop.0+0x32a/0x4e0
 do_syscall_64+0x5d/0xfa0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

This is because the kprobe on ftrace does not correctly handles
the kprobe_ftrace_disabled flag set by ftrace_kill().

To prevent this error, check kprobe_ftrace_disabled in
__disarm_kprobe_ftrace() and skip all ftrace related operations.

Link: https://lore.kernel.org/all/176473947565.1727781.13110060700668331950.stgit@mhiramat.tok.corp.google.com/

Reported-by: Ye Bin <yebin10@huawei.com>
Closes: https://lore.kernel.org/all/20251125020536.2484381-1-yebin@huaweicloud.com/
Fixes: ae6aa16fdc16 ("kprobes: introduce ftrace based optimization")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/kprobes.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1104,6 +1104,10 @@ static int __disarm_kprobe_ftrace(struct
 	int ret;
 
 	lockdep_assert_held(&kprobe_mutex);
+	if (unlikely(kprobe_ftrace_disabled)) {
+		/* Now ftrace is disabled forever, disarm is already done. */
+		return 0;
+	}
 
 	if (*cnt == 1) {
 		ret = unregister_ftrace_function(ops);



