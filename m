Return-Path: <stable+bounces-231653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGSgLJ34y2kXNAYAu9opvQ
	(envelope-from <stable+bounces-231653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:38:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5D336CE5B
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21F5F3097DE8
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069263E95A9;
	Tue, 31 Mar 2026 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gUfYPRIb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9722EE262;
	Tue, 31 Mar 2026 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974721; cv=none; b=EadyWQvJRYEw3oiGIR9WQ0WL2NJPjJdM3Gorv092yw1sGwkmmH67TSFIn65orpijK6yvRTvzGFBxhheE1pxMfRJK1n2zzBoCBTAojbVI8u9t+clHv61pR4ZZ383WvPDeKKQEC93dNIRkFsLJdIXriLi/HTbubEPqEgfJFIXkl4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974721; c=relaxed/simple;
	bh=q1FGwtdDoQsGJVI5dNvA7RAveksZuVnID/zogqFbgHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CpfjchJ8Jgsd1zh1Xyw5ICg4Ppz2t9eoPhffCkArT6AglS1nJxciKfOtrhfNbKt/tpJBXL3NOdaVGT4Qm7sbaXBV6mM/HJay4qws/VLuuWYeGBF7mNHXrYx3/6THMEqYRZ3cSUs1P9ZPkaWaovqkqjS8yvt7gwrz5wwzFszbLmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gUfYPRIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0870DC19424;
	Tue, 31 Mar 2026 16:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974721;
	bh=q1FGwtdDoQsGJVI5dNvA7RAveksZuVnID/zogqFbgHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUfYPRIbJXUKca8/3vgUqgpyL5fPknhp+AFVqw7KMg8BE/9P+pO63TaGNPSXqorVt
	 DfjUrtmWuG5aLQ1IxibrRcucj7/LWeM3ZfBZw5pNGPIUl1tTcSJhYzZxX3tktlOkY5
	 qNfugbigpKRU/IkqudGEj0unFxXb68TAEO3kJgeU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Puranjay Mohan <puranjay@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Sachin Kumar <xcyfun@protonmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 004/342] bpf: Fix constant blinding for PROBE_MEM32 stores
Date: Tue, 31 Mar 2026 18:17:17 +0200
Message-ID: <20260331161759.074103536@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,etsalapatis.com,protonmail.com,iogearbox.net];
	TAGGED_FROM(0.00)[bounces-231653-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,etsalapatis.com:email,protonmail.com:email,iogearbox.net:email]
X-Rspamd-Queue-Id: 7B5D336CE5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sachin Kumar <xcyfun@protonmail.com>

[ Upstream commit 2321a9596d2260310267622e0ad8fbfa6f95378f ]

BPF_ST | BPF_PROBE_MEM32 immediate stores are not handled by
bpf_jit_blind_insn(), allowing user-controlled 32-bit immediates to
survive unblinded into JIT-compiled native code when bpf_jit_harden >= 1.

The root cause is that convert_ctx_accesses() rewrites BPF_ST|BPF_MEM
to BPF_ST|BPF_PROBE_MEM32 for arena pointer stores during verification,
before bpf_jit_blind_constants() runs during JIT compilation. The
blinding switch only matches BPF_ST|BPF_MEM (mode 0x60), not
BPF_ST|BPF_PROBE_MEM32 (mode 0xa0). The instruction falls through
unblinded.

Add BPF_ST|BPF_PROBE_MEM32 cases to bpf_jit_blind_insn() alongside the
existing BPF_ST|BPF_MEM cases. The blinding transformation is identical:
load the blinded immediate into BPF_REG_AX via mov+xor, then convert
the immediate store to a register store (BPF_STX).

The rewritten STX instruction must preserve the BPF_PROBE_MEM32 mode so
the architecture JIT emits the correct arena addressing (R12-based on
x86-64). Cannot use the BPF_STX_MEM() macro here because it hardcodes
BPF_MEM mode; construct the instruction directly instead.

Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Sachin Kumar <xcyfun@protonmail.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/Y6IT5VvNRchPBLI5D7JZHBzZrU9rb0ycRJPJzJSXGj7kJlX8RJwZFSM2YZjcDxoQKABkxt1T8Os2gi23PYyFuQe6KkZGWVyfz8K5afdy9ak=@protonmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 85c0feaae0d3c..1b32333d8f8c6 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1419,6 +1419,27 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
 		*to++ = BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
 		*to++ = BPF_STX_MEM(from->code, from->dst_reg, BPF_REG_AX, from->off);
 		break;
+
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
+		*to++ = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^
+				      from->imm);
+		*to++ = BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
+		/*
+		 * Cannot use BPF_STX_MEM() macro here as it
+		 * hardcodes BPF_MEM mode, losing PROBE_MEM32
+		 * and breaking arena addressing in the JIT.
+		 */
+		*to++ = (struct bpf_insn) {
+			.code  = BPF_STX | BPF_PROBE_MEM32 |
+				 BPF_SIZE(from->code),
+			.dst_reg = from->dst_reg,
+			.src_reg = BPF_REG_AX,
+			.off   = from->off,
+		};
+		break;
 	}
 out:
 	return to - to_buff;
-- 
2.51.0




