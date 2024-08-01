Return-Path: <stable+bounces-64991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 560F8943D52
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129B12827B2
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503CC1C4D94;
	Thu,  1 Aug 2024 00:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOUX4yLK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097DC1C4D8E;
	Thu,  1 Aug 2024 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471870; cv=none; b=oOdrVJNKD8R6e0XkdbRhCgZUaKEWbaBjGX3Ll8krBrke22F9d3kH0JZvH5kzSgwDpwNCbT1BFas3IfHfYAd9c7MaRTijzw3NFK94Mq9e1ic3Zms8zg9xf8sDDV6RWB6YYoC/F3b9gPe7A7aavvbcEgmjyMTLw8BSSOFNK60sGqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471870; c=relaxed/simple;
	bh=mUhjbUXrrYk668ogsQXgQPaDYshazHlMOT3FFMgDRzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYX1SGZLXJwjxhRqXM8n53JQJa5vjS/4AcsTlOD4jDL6FNoruUdeTmT5BkrWWK8XBPLnTMbEFI33L9isOilp+jrzwSXMTDEH1HtMcSFVGwXGYup1QLG6o89e8tY1v3qp5ko7Ouh6CpEu4f6t/nPpM9764EL2GBwCSRg3OUUlQ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOUX4yLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B71C4AF0C;
	Thu,  1 Aug 2024 00:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471869;
	bh=mUhjbUXrrYk668ogsQXgQPaDYshazHlMOT3FFMgDRzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOUX4yLK2lgfLInQL9EJmmdC3paojscWVD1L0HohUB2IX7kznloYt6MeSU4w9cImf
	 q5xBKYpC4GwAqhxeNoVDAoy6FrL0254Di/KtlsR9Y9ZTU28NTYo97y3mEaJoD4u8Bh
	 pspK7HpU6SuhXSkzpuRCkYVvoQXbvuBFiGaqHMarrhOEoFjNAVPdi9HlP2e9jAjNvh
	 4xINH312fGuJgr9ORyGpoERJMMEmi9ojvUkmuf6RwCJOjznin91ZzxzeF+2n50SDQk
	 bFCEphW7cH+yDJEQ1TBGSaIZVRz6JSB2k7C45ERmO0yo54vLEVZ1eMjoGMwW8mtrrb
	 szG/ZCk/cdtxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Casey Schaufler <casey@schaufler-ca.com>,
	Konstantin Andreev <andreev@swemel.ru>,
	Sasha Levin <sashal@kernel.org>,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 45/83] smack: tcp: ipv4, fix incorrect labeling
Date: Wed, 31 Jul 2024 20:18:00 -0400
Message-ID: <20240801002107.3934037-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Casey Schaufler <casey@schaufler-ca.com>

[ Upstream commit 2fe209d0ad2e2729f7e22b9b31a86cc3ff0db550 ]

Currently, Smack mirrors the label of incoming tcp/ipv4 connections:
when a label 'foo' connects to a label 'bar' with tcp/ipv4,
'foo' always gets 'foo' in returned ipv4 packets. So,
1) returned packets are incorrectly labeled ('foo' instead of 'bar')
2) 'bar' can write to 'foo' without being authorized to write.

Here is a scenario how to see this:

* Take two machines, let's call them C and S,
   with active Smack in the default state
   (no settings, no rules, no labeled hosts, only builtin labels)

* At S, add Smack rule 'foo bar w'
   (labels 'foo' and 'bar' are instantiated at S at this moment)

* At S, at label 'bar', launch a program
   that listens for incoming tcp/ipv4 connections

* From C, at label 'foo', connect to the listener at S.
   (label 'foo' is instantiated at C at this moment)
   Connection succeedes and works.

* Send some data in both directions.
* Collect network traffic of this connection.

All packets in both directions are labeled with the CIPSO
of the label 'foo'. Hence, label 'bar' writes to 'foo' without
being authorized, and even without ever being known at C.

If anybody cares: exactly the same happens with DCCP.

This behavior 1st manifested in release 2.6.29.4 (see Fixes below)
and it looks unintentional. At least, no explanation was provided.

I changed returned packes label into the 'bar',
to bring it into line with the Smack documentation claims.

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 49d9da878ac61..aa95d034b6655 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4354,7 +4354,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 	rcu_read_unlock();
 
 	if (hskp == NULL)
-		rc = netlbl_req_setattr(req, &skp->smk_netlabel);
+		rc = netlbl_req_setattr(req, &ssp->smk_out->smk_netlabel);
 	else
 		netlbl_req_delattr(req);
 
-- 
2.43.0


