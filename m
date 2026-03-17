Return-Path: <stable+bounces-226813-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KvqIzGUuWnKKgIAu9opvQ
	(envelope-from <stable+bounces-226813-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:49:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D292B02EB
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1963530E504C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97772DECC6;
	Tue, 17 Mar 2026 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hFqy0BmW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E1A320CCF;
	Tue, 17 Mar 2026 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768297; cv=none; b=ibgHOgBzsC9HPFFIw26z+cO6Ox/Eu9GJu1qjDpOeTI8Sxg2KE6Mvm/tCXfy4gJZfNaCd44ZepW7vOBzSGbX5Qgl7d8y/tN9Cn/3K+y7VCZemHkWIuifgkSAuvTIzdEBKyCgNxIrmLg0QaFaadS4kruAKQw0YOR54Ni9wsqHhhwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768297; c=relaxed/simple;
	bh=W86eWVco4xpx6AROAWWta/6riL1se2ZF1ZAcQWwogeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaP1e2+5VkxA3mfuj7NHFnbdfmKaj+TYT3nEE0kF8VMUfu6idWIvaK0UzosImgplOa2Mt43x27pAfi1J2EQflcNCNFoJRoI/rmrJDIkRKSglEjUteVOYFpKpKHVer0qr/z0xHfssu7CyfVqSFU6ie0MM3vJux6h1zgC5LlnHTAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hFqy0BmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4466C4CEF7;
	Tue, 17 Mar 2026 17:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768297;
	bh=W86eWVco4xpx6AROAWWta/6riL1se2ZF1ZAcQWwogeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hFqy0BmW9pjBYE9MNYuYKnlbQAEk39skzpz1/sVBs0qXQJixlbzv3H3ZSMcvcuriq
	 ABJ2Cyp5uv/T7N4EMt+Wg+L58pVt+5LG9Wkdxvogjq3yGxnR454yI5bn7duOoFtL2Y
	 gp30Ia8O5ps0nEXnP4zaSB94pYEXdgkkgbw3zwUg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abhishek Dubey <adubey@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 6.18 277/333] powerpc64/bpf: fix the address returned by bpf_get_func_ip
Date: Tue, 17 Mar 2026 17:35:06 +0100
Message-ID: <20260317163009.667678652@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226813-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: C9D292B02EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hari Bathini <hbathini@linux.ibm.com>

commit 157820264ac3dadfafffad63184b883eb28f9ae0 upstream.

bpf_get_func_ip() helper function returns the address of the traced
function. It relies on the IP address stored at ctx - 16 by the bpf
trampoline. On 64-bit powerpc, this address is recovered from LR
accounting for OOL trampoline. But the address stored here was off
by 4-bytes. Ensure the address is the actual start of the traced
function.

Reported-by: Abhishek Dubey <adubey@linux.ibm.com>
Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
Cc: stable@vger.kernel.org
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20260303181031.390073-3-hbathini@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/net/bpf_jit_comp.c |   28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -722,9 +722,9 @@ static int __arch_prepare_bpf_trampoline
 	 *       retval_off             [ return value      ]
 	 *                              [ reg argN          ]
 	 *                              [ ...               ]
-	 *       regs_off               [ reg_arg1          ] prog ctx context
-	 *       nregs_off              [ args count        ]
-	 *       ip_off                 [ traced function   ]
+	 *       regs_off               [ reg_arg1          ] prog_ctx
+	 *       nregs_off              [ args count        ] ((u64 *)prog_ctx)[-1]
+	 *       ip_off                 [ traced function   ] ((u64 *)prog_ctx)[-2]
 	 *                              [ ...               ]
 	 *       run_ctx_off            [ bpf_tramp_run_ctx ]
 	 *                              [ reg argN          ]
@@ -824,7 +824,7 @@ static int __arch_prepare_bpf_trampoline
 
 	bpf_trampoline_save_args(image, ctx, func_frame_offset, nr_regs, regs_off);
 
-	/* Save our return address */
+	/* Save our LR/return address */
 	EMIT(PPC_RAW_MFLR(_R3));
 	if (IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE))
 		EMIT(PPC_RAW_STL(_R3, _R1, alt_lr_off));
@@ -832,24 +832,34 @@ static int __arch_prepare_bpf_trampoline
 		EMIT(PPC_RAW_STL(_R3, _R1, bpf_frame_size + PPC_LR_STKOFF));
 
 	/*
-	 * Save ip address of the traced function.
-	 * We could recover this from LR, but we will need to address for OOL trampoline,
-	 * and optional GEP area.
+	 * Derive IP address of the traced function.
+	 * In case of CONFIG_PPC_FTRACE_OUT_OF_LINE or BPF program, LR points to the instruction
+	 * after the 'bl' instruction in the OOL stub. Refer to ftrace_init_ool_stub() and
+	 * bpf_arch_text_poke() for OOL stub of kernel functions and bpf programs respectively.
+	 * Relevant stub sequence:
+	 *
+	 *               bl <tramp>
+	 *   LR (R3) =>  mtlr r0
+	 *               b <func_addr+4>
+	 *
+	 * Recover kernel function/bpf program address from the unconditional
+	 * branch instruction at the end of OOL stub.
 	 */
 	if (IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) || flags & BPF_TRAMP_F_IP_ARG) {
 		EMIT(PPC_RAW_LWZ(_R4, _R3, 4));
 		EMIT(PPC_RAW_SLWI(_R4, _R4, 6));
 		EMIT(PPC_RAW_SRAWI(_R4, _R4, 6));
 		EMIT(PPC_RAW_ADD(_R3, _R3, _R4));
-		EMIT(PPC_RAW_ADDI(_R3, _R3, 4));
 	}
 
 	if (flags & BPF_TRAMP_F_IP_ARG)
 		EMIT(PPC_RAW_STL(_R3, _R1, ip_off));
 
-	if (IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE))
+	if (IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE)) {
 		/* Fake our LR for unwind */
+		EMIT(PPC_RAW_ADDI(_R3, _R3, 4));
 		EMIT(PPC_RAW_STL(_R3, _R1, bpf_frame_size + PPC_LR_STKOFF));
+	}
 
 	/* Save function arg count -- see bpf_get_func_arg_cnt() */
 	EMIT(PPC_RAW_LI(_R3, nr_regs));



