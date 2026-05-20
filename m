Return-Path: <stable+bounces-250211-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sL52LvYNDmo35wUAu9opvQ
	(envelope-from <stable+bounces-250211-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:39:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE705988F2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 198AA33E1B7B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EAE3E9C3D;
	Wed, 20 May 2026 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CqNnRcBJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3D83F23D9;
	Wed, 20 May 2026 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294820; cv=none; b=utrXDGf+pOk6z0wE2BpHJG9sQB4FvGpk/mVAHi49w2PDwyZIpHEQLZ5XP7thPaQS2859en0nAQIKWRoXALNXe9B6uFFP0e/epQ0Oasr+U4zPg+uVTYmglDVIlAezzwUUocAlvwQGTy9gf1wA6XPfZL8CV72r2TFWyVT8YpVSlkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294820; c=relaxed/simple;
	bh=KAmfhLdTesoKwy6AtHi7LV2hMMLV5K3N8PqiMkwKwS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0OVOv5GpF0txRc6PbKd3oOK83hoVGOcN2hWLdqU4Zvn6CMY9YT6UiHfPlqB30gLDUY2S/YD/0AK2yMxegmFLcWMXn8OO0ISzSUUx8R2AaGNeCtHEM2qHPwoaRpjYNQkK7RFr1VRqVUM0LJiPyYfUuBaWOXWKm2F0kVdaYaKW0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CqNnRcBJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F08B1F000E9;
	Wed, 20 May 2026 16:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294818;
	bh=RoYlrdDlbyCWiIS/Z+dfPnb1bTcm8AcUdBjJ9j0z2bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CqNnRcBJmJiLVyijXRhqHXrgpPSFgO8ry/1UCprg/AHnTzNe13jSaKg/UCKHhs8lK
	 2MK/52h7OvXaO8RZ7S5+8QIGZBh/Ri92ZtMnpmJ7OXtYFFATf9PWXOXzcB7U4n+NGA
	 Y+exHrNalGZxgA0wnHFRtBqv6S9hUp7wNfBV0fBw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0167/1146] bpf: Propagate error from visit_tailcall_insn
Date: Wed, 20 May 2026 18:06:57 +0200
Message-ID: <20260520162152.069758235@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250211-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iogearbox.net:email]
X-Rspamd-Queue-Id: 2CE705988F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 6bd96e40f31dde8f8cd79772b4df0f171cf8a915 ]

Commit e40f5a6bf88a ("bpf: correct stack liveness for tail calls") added
visit_tailcall_insn() but did not check its return value.

Fixes: e40f5a6bf88a ("bpf: correct stack liveness for tail calls")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/20260408191242.526279-1-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0507df13fe2d6..2949cdc7565f7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18894,8 +18894,11 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 				mark_subprog_might_sleep(env, t);
 			if (bpf_helper_changes_pkt_data(insn->imm))
 				mark_subprog_changes_pkt_data(env, t);
-			if (insn->imm == BPF_FUNC_tail_call)
-				visit_tailcall_insn(env, t);
+			if (insn->imm == BPF_FUNC_tail_call) {
+				ret = visit_tailcall_insn(env, t);
+				if (ret)
+					return ret;
+			}
 		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_kfunc_call_arg_meta meta;
 
-- 
2.53.0




