Return-Path: <stable+bounces-238969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCznBDkz5mmOtQEAu9opvQ
	(envelope-from <stable+bounces-238969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:07:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE59F42CAD6
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DCAE309A3D1
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4818A3F0747;
	Mon, 20 Apr 2026 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxvaBZzg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084463BD634;
	Mon, 20 Apr 2026 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691530; cv=none; b=G+1fr3eZrIHmgsg/VUa3v6fZjoT+MWkjGQIryrGQ8V6GA6G8tCKgsdFd47JfQGarpPPkvirBz3qgtscTRGVS8FOngXn2HlJbamTLnkyLjAMQ/Cs2j4A59tp2QVlllDsgyNkv+62S8ZiNsKtqFeTPv8laEVy6PRxukdhDDoP5XqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691530; c=relaxed/simple;
	bh=lxLSueBLttRkcbbmKvm5YA5aOprqDc7YxCet6gcJ4Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ku06StSHNPqok7BoXh49CvqzVFXYaXSODNo9BSQANFQlaV98GikmCz5bBF8Fhhf5OgmmeaI0Q7o0zcwREdR5OgBcChNcFSyt/HyJZfPmxCmSmlqbRu0spoMUicXCZ1aRElaaJvmAl8DZZCCHH+7oCkEEoXaJNy/xOJBegeuROJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxvaBZzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A933BC2BCB4;
	Mon, 20 Apr 2026 13:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691529;
	bh=lxLSueBLttRkcbbmKvm5YA5aOprqDc7YxCet6gcJ4Yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxvaBZzgfFYhxOXXhK0it/6d45H1dOUynd2m8GG1ygCFDrQ26vO6DAiCgzMRkQa6t
	 UlvsNDULnycazmhmnctAPhwQ1lLyhnWgwBiVdQGIuVIfdmI6Cu8MEJ/Ni0gtU0dMhT
	 bHpS6zecXpsfMK4LZKS+BufLliagDt6ozZDd4RoI/59UQG0xtOxExMTYiOknvkjVrg
	 QxqDQLTGqHEFZX3TXi25UEG97KoS1UNNpgxZ6NjBj56IBmMHMmU2GLXzozwgwbd/mB
	 66V163Ha6Vhy7wIOWAf6aHIRuwOaFKtnlT1xacGSP4LOVNkXmC+EveUoBL32SvSoUx
	 ccqikb3qst1NA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] xfrm: Wait for RCU readers during policy netns exit
Date: Mon, 20 Apr 2026 09:17:57 -0400
Message-ID: <20260420132314.1023554-83-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238969-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,strlen.de:email]
X-Rspamd-Queue-Id: CE59F42CAD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Steffen Klassert <steffen.klassert@secunet.com>

[ Upstream commit 069daad4f2ae9c5c108131995529d5f02392c446 ]

xfrm_policy_fini() frees the policy_bydst hash tables after flushing the
policy work items and deleting all policies, but it does not wait for
concurrent RCU readers to leave their read-side critical sections first.

The policy_bydst tables are published via rcu_assign_pointer() and are
looked up through rcu_dereference_check(), so netns teardown must also
wait for an RCU grace period before freeing the table memory.

Fix this by adding synchronize_rcu() before freeing the policy hash tables.

Fixes: e1e551bc5630 ("xfrm: policy: prepare policy_bydst hash for rcu lookups")
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 net/xfrm/xfrm_policy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c32d34c441ee0..4526c9078b136 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4290,6 +4290,8 @@ static void xfrm_policy_fini(struct net *net)
 #endif
 	xfrm_policy_flush(net, XFRM_POLICY_TYPE_MAIN, false);
 
+	synchronize_rcu();
+
 	WARN_ON(!list_empty(&net->xfrm.policy_all));
 
 	for (dir = 0; dir < XFRM_POLICY_MAX; dir++) {
-- 
2.53.0


