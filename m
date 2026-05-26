Return-Path: <stable+bounces-254431-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJSAMG3zFWqzfwcAu9opvQ
	(envelope-from <stable+bounces-254431-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:24:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADFC5DBF54
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71633304A863
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ABC33FE33;
	Tue, 26 May 2026 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="pmMBiHaU"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A42F8BC3;
	Tue, 26 May 2026 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823249; cv=none; b=cAOSXPiJfKEwhcDsQ9oTAD0iCjl9tGiVFR3BuFQkupf3n7QIN2CBvOaZj7dhRSbXHcrYbYXouS3bSV1vMABQ0QBdOtwnZc8i/SKL9AX3CTNhnB2NuTXz5tocL59/VQjUj1k9TzTqgEyioAFzMpWf2Z3qUCRbGLafYJrIlxFjAvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823249; c=relaxed/simple;
	bh=ccS2IEN1yROm6MKV24kzUPb1oT0BwtewhqDOAduNA3U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DKYHjizBUayld2nzOpEGSCBIhV76ZAD84ed500Et+nMV2h41yeb8NCrAhxG5MvbNhKyEgeRKriZb17YdJq+Xhv++fQ+itkgiplLpqgJdfyGFNqzkTz/gantgBHusJFGKXah6YP/GYKvFl1bHqHwS0nxg8fAx/Pr/onusmQpBhhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=pmMBiHaU; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1779823248; x=1811359248;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dUbwGAbnnjrnTYIhityYHAbrTn/q4cPyenaTuTjrLdg=;
  b=pmMBiHaUPEk/toeveBtCfapbby1Ip+baZQfcOQEDwNIyM7XPkc6qoTXB
   n0sQzmr/fqxStDlPnI7SK9KfsgIduM3jLF9DEPn6u+tlHtxcV5M7vTfTy
   vOBGfJlXT+6/ZjZkFbqgHbxsiG0yZP0xkvZizGxLdLVzuGAgYpuhkekTX
   xVG3YNhDjkn/LSalbLoVMG5xawdlVZQGaLZnCU75cRKK6bRbQgcdbhJIU
   nU9Mry+rcHLszteyLWWLdk0Qo1n1JsBqJ9sjxtHtVeiwPeTV9XEsp1ViM
   J6Tqal83ot1V/TfnLpRc4mTAz7l5zvx+VbW7F93sbG90CPnQ+atsFmDvK
   w==;
X-CSE-ConnectionGUID: khoeNVcrREOEDhcejjvuYg==
X-CSE-MsgGUID: mKqm77QvQw22qtdHiSLDgg==
X-IronPort-AV: E=Sophos;i="6.24,170,1774310400"; 
   d="scan'208";a="20316884"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 19:20:45 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:7544]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.115:2525] with esmtp (Farcaster)
 id 53c53370-9a31-4bfa-8c5b-54a1678f5106; Tue, 26 May 2026 19:20:45 +0000 (UTC)
X-Farcaster-Flow-ID: 53c53370-9a31-4bfa-8c5b-54a1678f5106
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 19:20:44 +0000
Received: from dev-dsk-gyokhan-1b-83b48b3c.eu-west-1.amazon.com (10.13.234.1)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 19:20:42 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>
CC: <yangfeng@kylinos.cn>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mark.rutland@arm.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<jolsa@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <bpf@vger.kernel.org>, "Gyokhan
 Kochmarla" <gyokhan@amazon.de>
Subject: [PATCH 6.12] tracing: Fix the bug where bpf_get_stackid returns -EFAULT on the ARM64
Date: Tue, 26 May 2026 19:20:12 +0000
Message-ID: <20260526192012.76223-1-gyokhan@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-254431-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email,amazon.de:email,amazon.de:mid,amazon.de:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gyokhan@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.de:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6ADFC5DBF54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Feng Yang <yangfeng@kylinos.cn>

commit fd2f74f8f3d3c1a524637caf5bead9757fae4332 upstream.

When using bpf_program__attach_kprobe_multi_opts on ARM64 to hook a BPF program
that contains the bpf_get_stackid function, the BPF program fails
to obtain the stack trace and returns -EFAULT.

This is because ftrace_partial_regs omits the configuration of the pstate register,
leaving pstate at the default value of 0. When get_perf_callchain executes,
it uses user_mode(regs) to determine whether it is in kernel mode.
This leads to a misjudgment that the code is in user mode,
so perf_callchain_kernel is not executed and the function returns directly.
As a result, trace->nr becomes 0, and finally -EFAULT is returned.

Therefore, the assignment of the pstate register is added here.

Fixes: b9b55c8912ce ("tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs")
Closes: https://lore.kernel.org/bpf/20250919071902.554223-1-yangfeng59949@163.com/
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.de>
---
 arch/arm64/include/asm/ftrace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 10e56522122a..46d4300dd48d 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -145,6 +145,7 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
 	regs->pc = afregs->pc;
 	regs->regs[29] = afregs->fp;
 	regs->regs[30] = afregs->lr;
+	regs->pstate = PSR_MODE_EL1h;
 	return regs;
 }
 
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


