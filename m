Return-Path: <stable+bounces-153398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCBFADD457
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0D0406D86
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBADF2ED844;
	Tue, 17 Jun 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jMNHf3le"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F82ED17C;
	Tue, 17 Jun 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175831; cv=none; b=g5mh4rntAgv0jXeYuwC6uJn5MQUDFPKegoLZTxTEOsdMXN35voYP7a/XIMLG01980217kAp0dotEDwgBRmTjlkxIbirVsi+fpqC1nba8ukNhSoMC/GvZKTYecxU13ITZOlvlwnNYpnjWT6wu53otJG4tkDorlynNHWoBzqYEK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175831; c=relaxed/simple;
	bh=f+37sT0wk98b1czavWThPGk4jg8sjFzV9s0pmQjdpd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnzxM5wFwuuCUrYCcDHyJiQkMwDFpRHAFiG0dt3BPktp4sGG/y0x+JSRzvDo837bQ8PbIy8YBOcEyq3ZlvrmnDq9lVEhGmt2VjkG3j2THnqSag5ZH6kV9IKTwXlqkvijnQkgQnbpnWRGmBOeW+r2SWeCWTj0C7phY9QR/V7yOZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jMNHf3le; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08BEC4CEF0;
	Tue, 17 Jun 2025 15:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175831;
	bh=f+37sT0wk98b1czavWThPGk4jg8sjFzV9s0pmQjdpd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jMNHf3ley671rXYV1R8uhVyBS45zoA7SQ+HhpJhtmapPknK+QnEX4Di/EX4hv8NaU
	 Zd1OjeT3mPLvACLTqdT9ydqzbNPHhjYNhaTrgo54vPsTjXAxlerg/EkNRKaUni4oXc
	 XEHIxzYef+N0N85iAjmhOsjR2bApyn8lese51g64=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+45b0c89a0fc7ae8dbadc@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 167/512] bpf: Fix WARN() in get_bpf_raw_tp_regs
Date: Tue, 17 Jun 2025 17:22:13 +0200
Message-ID: <20250617152426.385319415@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tao Chen <chen.dylane@linux.dev>

[ Upstream commit 3880cdbed1c4607e378f58fa924c5d6df900d1d3 ]

syzkaller reported an issue:

WARNING: CPU: 3 PID: 5971 at kernel/trace/bpf_trace.c:1861 get_bpf_raw_tp_regs+0xa4/0x100 kernel/trace/bpf_trace.c:1861
Modules linked in:
CPU: 3 UID: 0 PID: 5971 Comm: syz-executor205 Not tainted 6.15.0-rc5-syzkaller-00038-g707df3375124 #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:get_bpf_raw_tp_regs+0xa4/0x100 kernel/trace/bpf_trace.c:1861
RSP: 0018:ffffc90003636fa8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff81c6bc4c
RDX: ffff888032efc880 RSI: ffffffff81c6bc83 RDI: 0000000000000005
RBP: ffff88806a730860 R08: 0000000000000005 R09: 0000000000000003
R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000000004
R13: 0000000000000001 R14: ffffc90003637008 R15: 0000000000000900
FS:  0000000000000000(0000) GS:ffff8880d6cdf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7baee09130 CR3: 0000000029f5a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1934 [inline]
 bpf_get_stack_raw_tp+0x24/0x160 kernel/trace/bpf_trace.c:1931
 bpf_prog_ec3b2eefa702d8d3+0x43/0x47
 bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2363 [inline]
 bpf_trace_run3+0x23f/0x5a0 kernel/trace/bpf_trace.c:2405
 __bpf_trace_mmap_lock_acquire_returned+0xfc/0x140 include/trace/events/mmap_lock.h:47
 __traceiter_mmap_lock_acquire_returned+0x79/0xc0 include/trace/events/mmap_lock.h:47
 __do_trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
 trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
 __mmap_lock_do_trace_acquire_returned+0x138/0x1f0 mm/mmap_lock.c:35
 __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
 mmap_read_trylock include/linux/mmap_lock.h:204 [inline]
 stack_map_get_build_id_offset+0x535/0x6f0 kernel/bpf/stackmap.c:157
 __bpf_get_stack+0x307/0xa10 kernel/bpf/stackmap.c:483
 ____bpf_get_stack kernel/bpf/stackmap.c:499 [inline]
 bpf_get_stack+0x32/0x40 kernel/bpf/stackmap.c:496
 ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1941 [inline]
 bpf_get_stack_raw_tp+0x124/0x160 kernel/trace/bpf_trace.c:1931
 bpf_prog_ec3b2eefa702d8d3+0x43/0x47

Tracepoint like trace_mmap_lock_acquire_returned may cause nested call
as the corner case show above, which will be resolved with more general
method in the future. As a result, WARN_ON_ONCE will be triggered. As
Alexei suggested, remove the WARN_ON_ONCE first.

Fixes: 9594dc3c7e71 ("bpf: fix nested bpf tracepoints with per-cpu data")
Reported-by: syzbot+45b0c89a0fc7ae8dbadc@syzkaller.appspotmail.com
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250513042747.757042-1-chen.dylane@linux.dev

Closes: https://lore.kernel.org/bpf/8bc2554d-1052-4922-8832-e0078a033e1d@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 042263e739e29..66075e86b691c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1828,7 +1828,7 @@ static struct pt_regs *get_bpf_raw_tp_regs(void)
 	struct bpf_raw_tp_regs *tp_regs = this_cpu_ptr(&bpf_raw_tp_regs);
 	int nest_level = this_cpu_inc_return(bpf_raw_tp_nest_level);
 
-	if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(tp_regs->regs))) {
+	if (nest_level > ARRAY_SIZE(tp_regs->regs)) {
 		this_cpu_dec(bpf_raw_tp_nest_level);
 		return ERR_PTR(-EBUSY);
 	}
-- 
2.39.5




