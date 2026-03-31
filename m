Return-Path: <stable+bounces-231990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KC/J6D8y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:56:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 188E436D717
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F31DD3046F08
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF793E9299;
	Tue, 31 Mar 2026 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iMZ2tyST"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C8233120E;
	Tue, 31 Mar 2026 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975590; cv=none; b=ONrzjoiR71pCmFRh3PslEhv5epvnPKe6IedT69TygzNCecEVyzBafDFXH9dFZ3XKr78eeD4Td38Bnz35mCpIm7gRkT4+GcbWNqUgj587tqyQVe2iak3gkU1P0wgiw7zDzNLvXf8qScp7mA/WH6vu0qB/bRci3i5ocDVduqSfhtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975590; c=relaxed/simple;
	bh=hEutZKGfxSfl+YJBEXOCD1MSlklEsq2MC1BccqZ7jBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqLLEcyF/bRpIGbd7Z7882LtWm2k3UCz5utUwIP8RbajWHrm+/Es1kfxiZWRhgK4MsGvP+83lgxK99ywmaQrZtOklQrQA49z85k9pm7PkbwPcsNvvqt4oGQLhtSFjNL+1ODyo5dqN2y0giudgcR/PvXnkXm34r5BXJMeDBxYm1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iMZ2tyST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B04DC19423;
	Tue, 31 Mar 2026 16:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975590;
	bh=hEutZKGfxSfl+YJBEXOCD1MSlklEsq2MC1BccqZ7jBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iMZ2tySTCjb2/t8CxY+9GYwu2vDQVaJe2Kb1NUPxokRHGAKeHFFmWBBJ79D7iTCtg
	 t3fPWdbIoQFO8VY7EWUyz6mHJmRXAnDXZmOLooAi+zW7z06yvx86HVEg4GdrsES8B/
	 tR+d0p0+mdiEFyNvkI1Oau9p4GKo0/0TrvukHhic=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Wade <danjwade95@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 011/244] bpf: Fix unsound scalar forking in maybe_fork_scalars() for BPF_OR
Date: Tue, 31 Mar 2026 18:19:21 +0200
Message-ID: <20260331161742.122506506@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-231990-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 188E436D717
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Wade <danjwade95@gmail.com>

[ Upstream commit c845894ebd6fb43226b3118d6b017942550910c5 ]

maybe_fork_scalars() is called for both BPF_AND and BPF_OR when the
source operand is a constant.  When dst has signed range [-1, 0], it
forks the verifier state: the pushed path gets dst = 0, the current
path gets dst = -1.

For BPF_AND this is correct: 0 & K == 0.
For BPF_OR this is wrong:    0 | K == K, not 0.

The pushed path therefore tracks dst as 0 when the runtime value is K,
producing an exploitable verifier/runtime divergence that allows
out-of-bounds map access.

Fix this by passing env->insn_idx (instead of env->insn_idx + 1) to
push_stack(), so the pushed path re-executes the ALU instruction with
dst = 0 and naturally computes the correct result for any opcode.

Fixes: bffacdb80b93 ("bpf: Recognize special arithmetic shift in the verifier")
Signed-off-by: Daniel Wade <danjwade95@gmail.com>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20260314021521.128361-2-danjwade95@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a9e2380327b45..68fa30852051e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14206,7 +14206,7 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
 	else
 		return 0;
 
-	branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
+	branch = push_stack(env, env->insn_idx, env->insn_idx, false);
 	if (IS_ERR(branch))
 		return PTR_ERR(branch);
 
-- 
2.51.0




