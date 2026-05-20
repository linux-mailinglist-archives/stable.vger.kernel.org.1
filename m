Return-Path: <stable+bounces-251715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJjtF4sADmp+5QUAu9opvQ
	(envelope-from <stable+bounces-251715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:42:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E22D59709A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 500A1311BE2D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D493EBF35;
	Wed, 20 May 2026 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JQJJyxkn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E164E3B0AD6;
	Wed, 20 May 2026 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298705; cv=none; b=RjBdwjS2SQBYi6UXRBiq15T4EBITat1ur0K4tCJhT9RXzyIcuL/P7Cuy0TRpOFhVazLWgOUSfkJYnNCtT1Kya3dtb0ZOK0WBU/ye+i0I+jy/RuzD5hxu8O+d3keHMe2euG9RjNbDrzOkAG5en8M/M7HngjvM1s49aeDUdHWGG1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298705; c=relaxed/simple;
	bh=eFqLU/Kpp+7Sih2Z6JBcJjeOzTJOr23pUrEVPLx4NFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RD+klaKFfvak12Qa0KnQ3DL0fbj1gII24IRb57GBQAnw9KrnzQU1EQ0eTyrAXrY82txrva6dAXxMpjfpLj1RIZyR+sD3yKBDedNbgPNV7nOIjJcs3niaCrkMtZkVmyMiq7hPJy9bjzlsJgZCp4gaJ7WUMVAnE52lWUY5Wh8CXEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JQJJyxkn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D341F000E9;
	Wed, 20 May 2026 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298703;
	bh=+c9aN16svoH6gTo/JuBxx3WKpnOVgKKAhG+OP2PYyvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JQJJyxkncVQnMW+FwYI44KJdB3wgHdDHi7z90PB8hX+6kCrdoLQk4WP4ax6Ezu0UX
	 YAJZbnS1aIzWns/TtoxFfZY1ptBHxNpMamFSRrB2vgGa12bV+iIJWtrJhy0byhh4N0
	 mOupqGXqAXTd1uIcIt7kw7yN5kYJ9ebvNb/1TdBg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Borkmann <daniel@iogearbox.net>,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 485/957] bpf, arm64: Fix off-by-one in check_imm signed range check
Date: Wed, 20 May 2026 18:16:08 +0200
Message-ID: <20260520162145.043154464@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251715-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8E22D59709A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 1dd8be4ec722ce54e4cace59f3a4ba658111b3ec ]

check_imm(bits, imm) is used in the arm64 BPF JIT to verify that
a branch displacement (in arm64 instruction units) fits into the
signed N-bit immediate field of a B, B.cond or CBZ/CBNZ encoding
before it is handed to the encoder. The macro currently tests for
(imm > 0 && imm >> bits) || (imm < 0 && ~imm >> bits) which admits
values in [-2^N, 2^N) — effectively a signed (N+1)-bit range. A
signed N-bit field only holds [-2^(N-1), 2^(N-1)), so the check
admits one extra bit of range on each side.

In particular, for check_imm19(), values in [2^18, 2^19) slip past
the check but do not fit into the 19-bit signed imm19 field of
B.cond. aarch64_insn_encode_immediate() then masks the raw value
into the 19-bit field, setting bit 18 (the sign bit) and flipping
a forward branch into a backward one. Same class of issue exists
for check_imm26() and the B/BL encoding. Shift by (bits - 1)
instead of bits so the actual signed N-bit range is enforced.

Fixes: e54bcde3d69d ("arm64: eBPF JIT compiler")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Link: https://lore.kernel.org/r/20260415121403.639619-2-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 107eb71b533a0..4b2aacdd43221 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -35,8 +35,8 @@
 #define ARENA_VM_START (MAX_BPF_JIT_REG + 5)
 
 #define check_imm(bits, imm) do {				\
-	if ((((imm) > 0) && ((imm) >> (bits))) ||		\
-	    (((imm) < 0) && (~(imm) >> (bits)))) {		\
+	if ((((imm) > 0) && ((imm) >> ((bits) - 1))) ||		\
+	    (((imm) < 0) && (~(imm) >> ((bits) - 1)))) {	\
 		pr_info("[%2d] imm=%d(0x%x) out of range\n",	\
 			i, imm, imm);				\
 		return -EINVAL;					\
-- 
2.53.0




