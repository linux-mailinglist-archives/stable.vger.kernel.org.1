Return-Path: <stable+bounces-254434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG1JMjvzFWrYfwcAu9opvQ
	(envelope-from <stable+bounces-254434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:23:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFB35DBF2F
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8CEB3016B44
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BF43AF665;
	Tue, 26 May 2026 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="sdvhjHg8"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB49219301;
	Tue, 26 May 2026 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823416; cv=none; b=H+n7Ll34hALOuCDhOSJBa/GEQNtEo78H+yRaIuphPVg3LD+j5KTK5w8RjdP1PCWzU/N3+jDdD42+KvYqCfA3YGMHw5ErjAWs7Bp1RT77+4AX/lu/5Z4aepQfAOLbxF7Rc+8LIMs+fXtwmaSJki7LYbRPQKqsbshu+AsuSVUWpRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823416; c=relaxed/simple;
	bh=xSAHuzhnv6e8U1m3dmcLOx7TglmUIAozHqyQTb713eM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=puFKFDySgqaOoMY3v1RZmk6KD3Tj7HOo8rrTTz5WLz4fHQlgxMtiEoW4jenLVzQN3+w2rKcyOfTAf0XpczFGo0FxBSCv4gwEp9kL4d+zypEGqV+lC45GZIxfJoDvwYkXQ2nQefcnzEJRajOh/5xi9N0Xx/3MLYRmVomQiECXOQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=sdvhjHg8; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1779823415; x=1811359415;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sgajywb0c9W4z+XMC1HocV4U0cjHkMGlj+AS3vvfOb4=;
  b=sdvhjHg8VTJVAg6ZcZG9oCa4ScMMplX/xtx436g8yfAWmN+KHzVZqpjI
   8ZUHTvROk8sI9MBBafpjHzAcBQCGiVUur20mSmwj1Og/mSZl1qVxvILeV
   qswAF5wbPd4wL6ux1PhcmnpR+342RlezmcxNiESppDOfOZKvsHoe8VwvI
   +z5VFFhWxk6qm3jk9vV7xyOyfrmUEsf8gkfiEmdeG9zqbzMvlUJRDsJ+7
   WVPkO/dirytJkul8GVx2qniAM/s+ep/TCJ+nmeP/3EFwGmfananPQ1Enn
   IBIm6Xv0F9C6zTb+MmM7GpJ3zNZFCG/AAWKek+UnyLhdx9ydJeWhjfBG9
   A==;
X-CSE-ConnectionGUID: krsg8C1SQ8G4tS0prj+bsQ==
X-CSE-MsgGUID: utt+6dtbQzCWytuJUknqQg==
X-IronPort-AV: E=Sophos;i="6.24,170,1774310400"; 
   d="scan'208";a="20301064"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 19:23:35 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:4829]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.237:2525] with esmtp (Farcaster)
 id 7977181f-585a-4c4d-8b8e-f1d45d1e5235; Tue, 26 May 2026 19:23:34 +0000 (UTC)
X-Farcaster-Flow-ID: 7977181f-585a-4c4d-8b8e-f1d45d1e5235
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 19:23:34 +0000
Received: from dev-dsk-gyokhan-1b-83b48b3c.eu-west-1.amazon.com (10.13.234.1)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 19:23:32 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>
CC: <jolsa@kernel.org>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Andrii Nakryiko
	<andrii@kernel.org>, Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: [PATCH 6.12] x86/fgraph: Fix return_to_handler regs.rsp value
Date: Tue, 26 May 2026 19:23:24 +0000
Message-ID: <20260526192324.79459-1-gyokhan@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-254434-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amazon.de:email,amazon.de:mid,amazon.de:dkim];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gyokhan@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.de:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6AFB35DBF2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Olsa <jolsa@kernel.org>

commit 8bc11700e0d23d4fdb7d8d5a73b2e95de427cabc upstream.

The previous change (Fixes commit) messed up the rsp register value,
which is wrong because it's already adjusted with FRAME_SIZE, we need
the original rsp value.

This change does not affect fprobe current kernel unwind, the !perf_hw_regs
path perf_callchain_kernel:

        if (perf_hw_regs(regs)) {
                if (perf_callchain_store(entry, regs->ip))
                        return;
                unwind_start(&state, current, regs, NULL);
        } else {
                unwind_start(&state, current, NULL, (void *)regs->sp);
        }

which uses pt_regs.sp as first_frame boundary (FRAME_SIZE shift makes
no difference, unwind stil stops at the right frame).

This change fixes the other path when we want to unwind directly from
pt_regs sp/fp/ip state, which is coming in following change.

Fixes: 20a0bc10272f ("x86/fgraph,bpf: Fix stack ORC unwind from kprobe_multi return probe")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/bpf/20260126211837.472802-2-jolsa@kernel.org
Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.de>
---
 arch/x86/kernel/ftrace_64.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 8a3cff618692..143fc62bf6f8 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -349,6 +349,9 @@ SYM_CODE_START(return_to_handler)
 	UNWIND_HINT_UNDEFINED
 	ANNOTATE_NOENDBR
 
+	/* Store original rsp for pt_regs.sp value. */
+	movq %rsp, %rdi
+
 	/* Restore return_to_handler value that got eaten by previous ret instruction. */
 	subq $8, %rsp
 	UNWIND_HINT_FUNC
@@ -359,7 +362,7 @@ SYM_CODE_START(return_to_handler)
 	movq %rax, RAX(%rsp)
 	movq %rdx, RDX(%rsp)
 	movq %rbp, RBP(%rsp)
-	movq %rsp, RSP(%rsp)
+	movq %rdi, RSP(%rsp)
 	movq %rsp, %rdi
 
 	call ftrace_return_to_handler
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


