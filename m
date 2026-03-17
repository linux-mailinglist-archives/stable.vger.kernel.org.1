Return-Path: <stable+bounces-226686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO1jBSmOuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:23:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 880972AF7BA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3EDD328D678
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9162128B7DB;
	Tue, 17 Mar 2026 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J2kbIjdG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F21255F2C;
	Tue, 17 Mar 2026 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767814; cv=none; b=Xi/2QWiHAy0C5J2lTkiQKorgMEAfQGI0kd1QsCeb28w4MRya/vPrv/ioGPNjU1Rz12lwHKyThJwzRgNrWdsxoDgN8qXeKD4lOkteL6+avl3LLpbpp4BQ8sFJKzJJK+98q8pKqq+r0mRPupRArTJiYf9KnFRcJnlrxItDYwtyZCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767814; c=relaxed/simple;
	bh=myBuIs4Zt31ZitEe7401BQl5m3/jHckCWzsmynR4JEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFovUk5gD/d4gu1Q5LxdvCLd3pWES98y/6x07pNdk51fplNDrhY8zKII11BQwhg1xW9CDIzSAZZ34HaWAOcyUrIcng8bFZ7WaXGSAAYU91Eg2ZHeUfYT59vmufEhY/VbHW1WjB/NLyLPg3ZjWsTkovwlTTnv4ecUEUwI0DV9TH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J2kbIjdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE49C19424;
	Tue, 17 Mar 2026 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767814;
	bh=myBuIs4Zt31ZitEe7401BQl5m3/jHckCWzsmynR4JEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J2kbIjdGM99EqMenxa6VcirS7gACCM893hgLdN9yjmHoslUA+m9SvONludYTQco0g
	 FVNsURXRjlCBaxSrPDR57utadrzyThXRBvlsOe8eKz52neB0yG/GpsLuoIXVB3hx76
	 PVsLIXNMRquzpFtdVzkVysuLUxWoEv8mQpFdZQGY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ye Bin <yebin10@huawei.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.18 163/333] kprobes: avoid crash when rmmod/insmod after ftrace killed
Date: Tue, 17 Mar 2026 17:33:12 +0100
Message-ID: <20260317163005.407080416@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226686-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,goodmis.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 880972AF7BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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



