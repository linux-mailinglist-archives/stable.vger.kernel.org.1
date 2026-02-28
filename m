Return-Path: <stable+bounces-221130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAEvHsxNo2nw/QQAu9opvQ
	(envelope-from <stable+bounces-221130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:19:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 122741C8347
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77BFE3009996
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA8B372237;
	Sat, 28 Feb 2026 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQI5BFVR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3151C372231;
	Sat, 28 Feb 2026 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301483; cv=none; b=Z5YzgUFKdaNumd2KQQLrK5elZJ6ZMbufPB/+DZ8i8eZTtfqtgDWdwIDHDoYjYst/665hxu2H00YUCtm96WoUb3JKfA67kRfSUljB4ldOLXgYcl/gQTNkfeF9xaX4OQQfjXn4QAHxrBf/Tdm1X01TkKUuqf9wwg5/0iD5V5LquhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301483; c=relaxed/simple;
	bh=SUf0qdZ6P+PWNQj5j9osWjREKs8+YSw/TMis7sPESjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgN5Mjzr5m3BdwcPPYaxxFf7Keo0kMoDZioVieUIvM1afvd0O8QzLxEtrhRAxZfmYpWttQaa8HdUG67xY5clNzW3nO2pNF5mRVnEPRMUtqFVywkvsJLy+Ac6A2031Ne4g4FPsVNwY3eH0jGzT5ck9Et5r9mNrc+UruFfojKsAqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQI5BFVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A712C19423;
	Sat, 28 Feb 2026 17:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301483;
	bh=SUf0qdZ6P+PWNQj5j9osWjREKs8+YSw/TMis7sPESjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQI5BFVRSu4pzY3PCdCs5t5NJxFPEUJjGlviY5wAG/UqEbvfxRuf3br0cUfUCQ5y1
	 w2KE15h+pi01N6GERBs4pgI2/8AVljTG7luBccIub+JGytnKYUmeMGsi+TbIJgye+4
	 fjFGd8CF/N+uM39RznRupiLrEjeU5vjw40fJqCl5jaSZDff0zBh9sp2THcuwOdit0R
	 uEYZfXq9dQIFxyl2FfDIucskn4nYJ1tsaOu+ousxdT83iQe1+ORKO8BSLD7d6ZsV+w
	 Oa3VaWlBiRVcVhYHf6o90EErksBpPNFjpJHdIp4IMvhOimbQ2+7HVF+IUVbR+yLy0N
	 bQPVvNe1bgPjw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Daniel Hodges <hodgesd@meta.com>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 668/752] tipc: fix RCU dereference race in tipc_aead_users_dec()
Date: Sat, 28 Feb 2026 12:46:19 -0500
Message-ID: <20260228174750.1542406-668-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
	TAGGED_FROM(0.00)[bounces-221130-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 122741C8347
X-Rspamd-Action: no action

From: Daniel Hodges <hodgesd@meta.com>

[ Upstream commit 6a65c0cb0ff20b3cbc5f1c87b37dd22cdde14a1c ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


