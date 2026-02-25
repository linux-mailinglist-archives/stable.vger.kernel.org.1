Return-Path: <stable+bounces-218155-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNFqLAJRnmmNUgQAu9opvQ
	(envelope-from <stable+bounces-218155-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:31:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1A818EE24
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8F1D3078BFD
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B97C251793;
	Wed, 25 Feb 2026 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nBAYakNa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2B621D596;
	Wed, 25 Feb 2026 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982939; cv=none; b=iDEzM5hTQaHkFO/sxOm8QhFiZketXyUJfXzdL8xoJilo/4gV5uFek1U2b1BIT5Jwn8W43DLmJ8X/7DBw5BeS0DOxUzkJqeMyzQLs8IkeICi+Z4ePc2pmYThNIPgQ6QYx4l/b8MMqhuINpeINAET4WkAHsP6qa8SoIVlIePQ83Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982939; c=relaxed/simple;
	bh=7rqpWopB7wUmLzkvQNQViUtvAp+NtjIZOTR+HDyHzNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZefcMNdCKxG+MrqCaNGARiNBXbAVmssbavg9H1oLhtDQnoVTM4tg/JINQoHSaK4KnILLuFyv72n3cfCQZnriHGF2VPJ4nzS6YW9ctnUyAxtaUrfQTcOEiQMroXJkc82iH/jQd4PiKTcfAuKIerPZpPgc0MvYjq9IdmulXRU52M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nBAYakNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA29C19423;
	Wed, 25 Feb 2026 01:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982938;
	bh=7rqpWopB7wUmLzkvQNQViUtvAp+NtjIZOTR+HDyHzNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nBAYakNaN8/iiS7OmU33/kzQKaXnkhMY4JC9QHk1Ys4ZB74/3ddXlC7KpKVuE3hdu
	 iowxHIMCnafpJPnUP98NhErKN6AIFV8OlICpwkSAZCEBvGBvV15tLW4F/cP0GxQHn2
	 V9qG899TnV/zij+845YxYYArDlCKTVb6XGK135d0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 072/781] bpf: bpf_scc_visit instance and backedges accumulation for bpf_loop()
Date: Tue, 24 Feb 2026 17:13:01 -0800
Message-ID: <20260225012401.469285850@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-218155-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,debian.org,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1D1A818EE24
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit f597664454bde5ac45ceaf24da55b590ccfa60e3 ]

Calls like bpf_loop() or bpf_for_each_map_elem() introduce loops that
are not explicitly present in the control-flow graph. The verifier
processes such calls by repeatedly interpreting the callback function
body within the same verification path (until the current state
converges with a previous state).

Such loops require a bpf_scc_visit instance in order to allow the
accumulation of the state graph backedges. Otherwise, certain
checkpoint states created within the bodies of such loops will have
incomplete precision marks.

See the next patch for an example of a program that leads to the
verifier accepting an unsafe program.

Fixes: 96c6aa4c63af ("bpf: compute SCCs in program control flow graph")
Fixes: c9e31900b54c ("bpf: propagate read/precision marks over state graph backedges")
Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Tested-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/r/20251229-scc-for-callbacks-v1-1-ceadfe679900@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3135643d56955..646025bae96db 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19835,8 +19835,10 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				}
 			}
 			if (bpf_calls_callback(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, RANGE_WITHIN))
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
+					loop = true;
 					goto hit;
+				}
 				goto skip_inf_loop_check;
 			}
 			/* attempt to detect infinite loop to avoid unnecessary doomed work */
@@ -25076,15 +25078,18 @@ static int compute_scc(struct bpf_verifier_env *env)
 			}
 			/*
 			 * Assign SCC number only if component has two or more elements,
-			 * or if component has a self reference.
+			 * or if component has a self reference, or if instruction is a
+			 * callback calling function (implicit loop).
 			 */
-			assign_scc = stack[stack_sz - 1] != w;
-			for (j = 0; j < succ->cnt; ++j) {
+			assign_scc = stack[stack_sz - 1] != w;	/* two or more elements? */
+			for (j = 0; j < succ->cnt; ++j) {	/* self reference? */
 				if (succ->items[j] == w) {
 					assign_scc = true;
 					break;
 				}
 			}
+			if (bpf_calls_callback(env, w)) /* implicit loop? */
+				assign_scc = true;
 			/* Pop component elements from stack */
 			do {
 				t = stack[--stack_sz];
-- 
2.51.0




