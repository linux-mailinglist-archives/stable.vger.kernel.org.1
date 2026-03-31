Return-Path: <stable+bounces-232221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P6PE4j/y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-232221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:08:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B47836DF12
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E530B306E05A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968FE29DB8F;
	Tue, 31 Mar 2026 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OrhVepQf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597CD40710B;
	Tue, 31 Mar 2026 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976189; cv=none; b=Mqaj+GRsVSm4OY+mRtD9q5ZgfKFS/5kjDkatb7wcyna6qGibmGInDgwWry5wjI18cEYccIuHmbrwTkzh4DbdS9BAZ2socgQZesu8wzZSlM+LYZoZLcGCDn4CCcFOt0yMu1KJZxw9jE2J33aSwqp8nAvtOqurl0bXlT1dQ0cvprk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976189; c=relaxed/simple;
	bh=b1wOhEH4Erx0DglCph2nLGfeDgQ/I5tdflb6vjA4zCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdwZ3SBlajuDxGvm0lHt8kMea91HQc4oetOyOtkwvEmpb8u4rsBgaAB0Ms3SdNBxVUo3IDr9jQwJwewRb9oZF6XiI/fEd4K00YAbVRCxelXV1b+3Espdk2rFpXCxO2amCNNAqBJKUXObw4KeyXrDP1A+bKyoGcktH/EaaGW/DHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OrhVepQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3949C19423;
	Tue, 31 Mar 2026 16:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976189;
	bh=b1wOhEH4Erx0DglCph2nLGfeDgQ/I5tdflb6vjA4zCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OrhVepQfLD/Epa/RXKQ3jYCDX8rYjRO2xVAU1oA0L25AofMzgNb4HGPRMOuznlH9q
	 JRP+j0ZlCY3yE74Mv8dnP/8hbI58BZ4UqbN9po0R0uG9/b995mT+Gfq5Og2t3QYwKJ
	 WCPgJgmsxr74erge2gQOsigD1rsQT/CSNBBy9b5I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicholas Carlini <npc@anthropic.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 240/244] futex: Require sys_futex_requeue() to have identical flags
Date: Tue, 31 Mar 2026 18:23:10 +0200
Message-ID: <20260331161750.622311345@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232221-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,anthropic.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 1B47836DF12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 19f94b39058681dec64a10ebeb6f23fe7fc3f77a ]

Nicholas reported that his LLM found it was possible to create a UaF
when sys_futex_requeue() is used with different flags. The initial
motivation for allowing different flags was the variable sized futex,
but since that hasn't been merged (yet), simply mandate the flags are
identical, as is the case for the old style sys_futex() requeue
operations.

Fixes: 0f4b5f972216 ("futex: Add sys_futex_requeue()")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex/syscalls.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 880c9bf2f3150..99723189c8cf7 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -459,6 +459,14 @@ SYSCALL_DEFINE4(futex_requeue,
 	if (ret)
 		return ret;
 
+	/*
+	 * For now mandate both flags are identical, like the sys_futex()
+	 * interface has. If/when we merge the variable sized futex support,
+	 * that patch can modify this test to allow a difference in size.
+	 */
+	if (futexes[0].w.flags != futexes[1].w.flags)
+		return -EINVAL;
+
 	cmpval = futexes[0].w.val;
 
 	return futex_requeue(u64_to_user_ptr(futexes[0].w.uaddr), futexes[0].w.flags,
-- 
2.53.0




