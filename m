Return-Path: <stable+bounces-255975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAteO4qnGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:37:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C185F9228
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 395ED302F18B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E61B25F7B9;
	Thu, 28 May 2026 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2QzjXCeW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FFB2C15AC;
	Thu, 28 May 2026 20:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000403; cv=none; b=UAaQxcBVWg9NdCiAasRmmyVTvwiL3BaPgT1GvANuQV9dhhggfISdFGwDatz1j/e0DNcpMqw4LC8Jls8aJ4pLTUQDE14liKW9bm/a7Po0LdrXDuVkp0z8/7R3x6ThJrhd7VdzGhZiyrGg8jTVd34XqYd3T/PoSLj68xn2mbiHNmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000403; c=relaxed/simple;
	bh=lafHSACwYpsey980Ky2WIg2qAOkBzKQuTsGDZfTWUFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baONQIWdvMC7i1N2HfEC2A8OsJHJNCpOQUsA0QeuHkN14ak26HE2BJTl0xmW4Z+TSxXHQrTA5eQdINxh8Rsa0UQvIr/LRqf5xdxrdCsosgHkvilKOLGmhgOcorKVoLtHR+Bmv2dwBxSeBy5ZBxryFbWjK5irKgDUgNBK7xmPFi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2QzjXCeW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC09F1F000E9;
	Thu, 28 May 2026 20:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000402;
	bh=jmpIBO94319hfOzg+ZbQeZ0DEWv4tTPA9wTOuFC4mmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2QzjXCeWV9zoVJmU8Qhk4AdDiL/Kr8xEBCH9wFX5x8hTLFE36E15P8t0STLF6s97e
	 DiOMF1M9roX4UYWQ4F49X9T/G1RJ2cWib2dXOybX93ov56NxD8UJlsJcV5WTeZouhq
	 d4KsMIZ5qNxkTQG5YZlPO170GMO58rXubVewwmOs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Feng Yang <yangfeng@kylinos.cn>,
	Jiri Olsa <jolsa@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Will Deacon <will@kernel.org>,
	Gyokhan Kochmarla <gyokhan@amazon.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 032/272] tracing: Fix the bug where bpf_get_stackid returns -EFAULT on the ARM64
Date: Thu, 28 May 2026 21:46:46 +0200
Message-ID: <20260528194630.288960950@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255975-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amazon.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,kylinos.cn:email]
X-Rspamd-Queue-Id: 97C185F9228
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/ftrace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 10e56522122aa..46d4300dd48d3 100644
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
2.53.0




