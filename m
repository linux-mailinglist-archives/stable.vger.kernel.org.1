Return-Path: <stable+bounces-248170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBE8ML1LB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:37:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 608565539BD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2ECBF305FA8D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD453EFFB2;
	Fri, 15 May 2026 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QR/mROXu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB103E00A2;
	Fri, 15 May 2026 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861052; cv=none; b=YBlB2JWPA4OrVNXi47wiXjNf9mKf19ARVIC/eMT5g3AWHSyEsntCRr2DWzxyOBc7D8/kqHU7OR/D12hQopBXXNLuNWacCbMfyMLJD8Y+FyJJ09l4bsKu+vusVtn1zxohaF0B/HTHPHX4rcbkU4IXXB9YYuue6Y2Bgx+NWpXIbmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861052; c=relaxed/simple;
	bh=WI0XuORugAr83sb6RlVLck241ifok+K9aZ41TMwTHlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxbkzrZ0ozVayV/Ja5D4+B8n1lyHZ906QjrkJ/qQZIpBaGqAUYhTK4XaleLBmIeJooG9Vna4XIe2WjiFFooJ611G+aJt5JT8YeU7a/0dNAIOHwV8FDiiI2xfZUmwI1wpdQO2ZSZrE8V7UeEvRPSUKHF4y/Uz5XhHj/7qje86QwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QR/mROXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6A2C2BCFA;
	Fri, 15 May 2026 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861052;
	bh=WI0XuORugAr83sb6RlVLck241ifok+K9aZ41TMwTHlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QR/mROXuI8hgZtHjYnxR6V4zRNNF4CHlbSNtd0pIURHqR/ENRvoL3XAHlyv9eV7tq
	 gtHgSONBIQxQQ6H+0Rm7YkWtyGQZyjr2dBotFA65UQIHvN9KPUp70bp7M7cy2IjePp
	 knJ8z7K9RpOfkyW0HbAQYUz9O8viTgVjEAInbuC0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 180/474] bpf: handle fake register spill to stack with BPF_ST_MEM instruction
Date: Fri, 15 May 2026 17:44:49 +0200
Message-ID: <20260515154718.918646855@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 608565539BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-248170-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,suse.com,iogearbox.net];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iogearbox.net:email,suse.com:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 482d548d40b0af9af730e4869903d4433e44f014 ]

When verifier validates BPF_ST_MEM instruction that stores known
constant to stack (e.g., *(u64 *)(r10 - 8) = 123), it effectively spills
a fake register with a constant (but initially imprecise) value to
a stack slot. Because read-side logic treats it as a proper register
fill from stack slot, we need to mark such stack slot initialization as
INSN_F_STACK_ACCESS instruction to stop precision backtracking from
missing it.

Fixes: 41f6f64e6999 ("bpf: support non-r10 register spill/fill to/from stack in precision tracking")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231209010958.66758-1-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 705582bdda681..f6040169ef749 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4678,7 +4678,6 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		__mark_reg_known(&fake_reg, insn->imm);
 		fake_reg.type = SCALAR_VALUE;
 		save_register_state(env, state, spi, &fake_reg, size);
-		insn_flags = 0; /* not a register spill */
 	} else if (reg && is_spillable_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
 		if (size != BPF_REG_SIZE) {
-- 
2.53.0




