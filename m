Return-Path: <stable+bounces-221479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCSREj+Wo2lPHgUAu9opvQ
	(envelope-from <stable+bounces-221479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:28:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F6A1CAB8D
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 563BD3030761
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C80285C84;
	Sun,  1 Mar 2026 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJww96LF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0424F2727EB;
	Sun,  1 Mar 2026 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328366; cv=none; b=FSxMW/E/1Cr7rYeWcS7tqqptdmcX9H4UprrArwDV8rviL65ue1gfhnw7BdNUmYjolf5PG7LhdVx0mFpd16rEmzAfaKC0WuwKI1BO7RSJIo+g9/1xfkmEH6LQ5WN6sjZMcf+/858cJJQDmdUHtgxF91oKwoYvIa04XL8xmA/8F1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328366; c=relaxed/simple;
	bh=86uw8YO4p4L60SebErshqvZ6IyR//TRBstelzZJheCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J3noADD6fSUpHPR2NYmffniMATs6JTBLPtW+SoD/8KhLpygapgA0sV7hEx0NcbRAtQNtYAEojfF6DzZEfDeTHClCAce1pFaAevjUyKvOD/RznGcpOfpNT5NEhKuW3IRVF8e/tZ7T+OMSJ8WTg+8jdrqCtp/VmFRVeHYeC6hJr54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJww96LF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36218C19421;
	Sun,  1 Mar 2026 01:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328365;
	bh=86uw8YO4p4L60SebErshqvZ6IyR//TRBstelzZJheCI=;
	h=From:To:Cc:Subject:Date:From;
	b=lJww96LFdFs9wmcl42nkIao1n+egToTg5qWDycV/4ErSP5qpA6pKKnQaQL7HjvqZT
	 EhBXv8Ix0ITe5eW4Nzolkxg0a9HmVLJqXB/kTpKOFj199GmxCix5mmDYnEkQJE0Jld
	 CqsTtvvdj2C4ZTJYttsy03m1jfDzB01ayAIHOG95AoPE63qOnl+ChHd16Zr2lYa4L/
	 hgIkwWUpiY+jH9TNZB0dSVd1MU7apuO8KqGiZV+hDIfj9/79rYp9Fzgq3A7UnZgxvG
	 IDt1TFmLe+W0JjcmHVduXAFUpuU8jTZ7qHRh6A0xe7C41U7pzdngnmnHmAbrvSsW4B
	 /eh7g2aHUnHqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hodgesd@meta.com
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Subject: FAILED: Patch "tipc: fix RCU dereference race in tipc_aead_users_dec()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:26:03 -0500
Message-ID: <20260301012604.1683379-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221479-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,meta.com:email]
X-Rspamd-Queue-Id: F0F6A1CAB8D
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6a65c0cb0ff20b3cbc5f1c87b37dd22cdde14a1c Mon Sep 17 00:00:00 2001
From: Daniel Hodges <hodgesd@meta.com>
Date: Tue, 3 Feb 2026 09:56:21 -0500
Subject: [PATCH] tipc: fix RCU dereference race in tipc_aead_users_dec()

tipc_aead_users_dec() calls rcu_dereference(aead) twice: once to store
in 'tmp' for the NULL check, and again inside the atomic_add_unless()
call.

Use the already-dereferenced 'tmp' pointer consistently, matching the
correct pattern used in tipc_aead_users_inc() and tipc_aead_users_set().

Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Cc: stable@vger.kernel.org
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Daniel Hodges <hodgesd@meta.com>
Link: https://patch.msgid.link/20260203145621.17399-1-git@danielhodges.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/tipc/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 970db62bd029b..a3f9ca28c3d53 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -460,7 +460,7 @@ static void tipc_aead_users_dec(struct tipc_aead __rcu *aead, int lim)
 	rcu_read_lock();
 	tmp = rcu_dereference(aead);
 	if (tmp)
-		atomic_add_unless(&rcu_dereference(aead)->users, -1, lim);
+		atomic_add_unless(&tmp->users, -1, lim);
 	rcu_read_unlock();
 }
 
-- 
2.51.0





