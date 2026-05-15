Return-Path: <stable+bounces-248169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HOfIbdLB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:37:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3187F5539B3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EC9530F592C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409263E0081;
	Fri, 15 May 2026 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WNWXT9Zu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ACD30568A;
	Fri, 15 May 2026 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861049; cv=none; b=jLsfuLBIuSeKjb1hYrP02rM+RcX3DHaTgPlLStBeO6KNvRDcnHvcnNc0bk2kjwN/GZqde0b1gfDgnkNFmrzM564gIi/XEelLwVjmBgg/1EcOogcKewMuQvEW1zKRjE0OdNsqXFQugK8MwHCoxicuO4rQJ3ZLUEiZbKPNF2NJCDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861049; c=relaxed/simple;
	bh=ZxFmOIZdlH01ics5gM/E74B6CoGM7SUa6p05nfdLAUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5ap+bhAt/7cTuEfY32RTv5gNZFWG4lJaOiJ50Fff/7/m7ZS9jgyHniwVaGI/fSrsKQusMXXqdwnKUfeRwM05RKw5faQ1ihTf2jvOLPimPO0Ws34NHQmZKCqUaOBSgxWlyyWyxT/DzbnK70dg8mBhBn01vsSsfdh82S81IPm0ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WNWXT9Zu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658DAC2BCB0;
	Fri, 15 May 2026 16:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861048;
	bh=ZxFmOIZdlH01ics5gM/E74B6CoGM7SUa6p05nfdLAUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNWXT9Zu5nKfk90vTNcJx7Moe53bcUGVd3eimQ4gT3k2j6pBhlY6x5TPtTgTOl4GD
	 2q6SDr/PndWRcYrCkwb/9PndnXinM6NnLRgIabqLHtZdQgSgvWhjvW0Q5XFqKFEbkA
	 0+AgcCMX9QuSjyNZaT8EiNHoSaBVY1CgdjtaMDE8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 179/474] selftests/bpf: validate precision logic in partial_stack_load_preserves_zeros
Date: Fri, 15 May 2026 17:44:48 +0200
Message-ID: <20260515154718.897467136@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 3187F5539B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-248169-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,suse.com,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iogearbox.net:email,suse.com:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 064e0bea19b356c5d5f48a4549d80a3c03ce898b ]

Enhance partial_stack_load_preserves_zeros subtest with detailed
precision propagation log checks. We know expect fp-16 to be spilled,
initially imprecise, zero const register, which is later marked as
precise even when partial stack slot load is performed, even if it's not
a register fill (!).

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20231205184248.1502704-10-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/bpf/progs/verifier_spill_fill.c    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 41fd61299eab0..df4920da34728 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -495,6 +495,22 @@ char single_byte_buf[1] SEC(".data.single_byte_buf");
 SEC("raw_tp")
 __log_level(2)
 __success
+/* make sure fp-8 is all STACK_ZERO */
+__msg("2: (7a) *(u64 *)(r10 -8) = 0          ; R10=fp0 fp-8_w=00000000")
+/* but fp-16 is spilled IMPRECISE zero const reg */
+__msg("4: (7b) *(u64 *)(r10 -16) = r0        ; R0_w=0 R10=fp0 fp-16_w=0")
+/* and now check that precision propagation works even for such tricky case */
+__msg("10: (71) r2 = *(u8 *)(r10 -9)         ; R2_w=P0 R10=fp0 fp-16_w=0")
+__msg("11: (0f) r1 += r2")
+__msg("mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r2 stack= before 10: (71) r2 = *(u8 *)(r10 -9)")
+__msg("mark_precise: frame0: regs= stack=-16 before 9: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs= stack=-16 before 8: (73) *(u8 *)(r1 +0) = r2")
+__msg("mark_precise: frame0: regs= stack=-16 before 7: (0f) r1 += r2")
+__msg("mark_precise: frame0: regs= stack=-16 before 6: (71) r2 = *(u8 *)(r10 -1)")
+__msg("mark_precise: frame0: regs= stack=-16 before 5: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs= stack=-16 before 4: (7b) *(u64 *)(r10 -16) = r0")
+__msg("mark_precise: frame0: regs=r0 stack= before 3: (b7) r0 = 0")
 __naked void partial_stack_load_preserves_zeros(void)
 {
 	asm volatile (
-- 
2.53.0




