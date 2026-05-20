Return-Path: <stable+bounces-250233-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHWOO0zkDWpN4gUAu9opvQ
	(envelope-from <stable+bounces-250233-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:41:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F4359242A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53E49306B578
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EFC3B27D8;
	Wed, 20 May 2026 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oOmH7WMz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0FD36A37D;
	Wed, 20 May 2026 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294878; cv=none; b=k90C85RA3/XRtERmJz1Z82Z8QoYSeAXsK59F97dB5ngPNZQaBaIvAXROBfrU91g4g57ZepWiLO6nNGtNNu33R/B/4pBER7qW8eHH57gdfpn513MDMA45KpGvD2sQ8i9hUmxjT+U8+TyF/jXqZgoVvGtNIQF2HrDnK/ycXon4Z+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294878; c=relaxed/simple;
	bh=H+QPOWCIaEZb9zz4277qJ2a6/Auw0Bb8NvAGcXxpUIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIXK9U89XDJ20RjKCtzuLbhD8h6TWyJMKU1+mMumMxL5FNztNVbQqtCNpbSu1Worb4nv7Akszyew1NDI2JFritdgXJJfsvO14sGBI+7qa8hdrdgGVyIA5YkBfEunwM0h+4Jm2iyibKvF8QiYcYAfIi362m+49+o0BfewMhERkgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oOmH7WMz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3261F000E9;
	Wed, 20 May 2026 16:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294876;
	bh=xwNbSoZTlDwiNjMl7ePOu9U2LFbVCKi54b1j1/F0iCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oOmH7WMzE1uSnFyaxlsXXFdPwRFVop5ZMc2FcgtAHPpn08OUdFdQ+NuSNwzQXmX63
	 dxehsqSm7oHOvIPcFA9lXAEHoQyQBXbfzC0E+MPbualxpURAnhYDMt5Lle2IiXh1/m
	 Xavzj6wvH+smTXxSspTInMDpVIDTCe+o47ojDDI0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Borkmann <daniel@iogearbox.net>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0169/1146] bpf: Remove static qualifier from local subprog pointer
Date: Wed, 20 May 2026 18:06:59 +0200
Message-ID: <20260520162152.114127361@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-250233-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,iogearbox.net,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 69F4359242A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 9dba0ae973e75051b63cbdd5b3532bb24aa63b3f ]

The local subprog pointer in create_jt() and visit_abnormal_return_insn()
was declared static.

It is unconditionally assigned via bpf_find_containing_subprog() before
every use. Thus, the static qualifier serves no purpose and rather creates
confusion. Just remove it.

Fixes: e40f5a6bf88a ("bpf: correct stack liveness for tail calls")
Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
Link: https://lore.kernel.org/r/20260408191242.526279-3-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 71c078d18683a..bf5e146692e0a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18764,7 +18764,7 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
 static struct bpf_iarray *
 create_jt(int t, struct bpf_verifier_env *env)
 {
-	static struct bpf_subprog_info *subprog;
+	struct bpf_subprog_info *subprog;
 	int subprog_start, subprog_end;
 	struct bpf_iarray *jt;
 	int i;
@@ -18839,7 +18839,7 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
  */
 static int visit_abnormal_return_insn(struct bpf_verifier_env *env, int t)
 {
-	static struct bpf_subprog_info *subprog;
+	struct bpf_subprog_info *subprog;
 	struct bpf_iarray *jt;
 
 	if (env->insn_aux_data[t].jt)
-- 
2.53.0




