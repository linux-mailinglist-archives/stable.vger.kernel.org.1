Return-Path: <stable+bounces-65118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9970A943ECD
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF091F2297A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6321A6161;
	Thu,  1 Aug 2024 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlOcyHhD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293271DAC76;
	Thu,  1 Aug 2024 00:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472492; cv=none; b=cMvJzWwaT/KTFgdorGXOX6QCjx+lI0MG1XTohUvbMbbzETF+G8MqCe9ckWGW7QUof/m7lEi9TBgddPR/WAI7jnGNCpY4MlNhDSi1FLgDstyI+q6tyiFZI/THkG8q5MxPtsxHTx50WqZFvhtjmah9pis0+POsSob4NFBnSI7+67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472492; c=relaxed/simple;
	bh=n7vWZjyWV/GaxQtxgyPbyC5TObQk4ygvhVDuU6Al6Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBm4KGPlLyrp7Tdmu3YABc3HBxv5PO7xFrmD/7Oz7VZAh7mBCNEpHg2hjx3w4jNDUmr3glsbkeLTPQi5kaC6+r1TS9tZpk5SprnC7rx1X1i7mYexBh2KO0rhxPcuRa9gjiYUtpR/gfjP0+ZOBFOzAln4McTzwYZfLPwLnCOeD0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlOcyHhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A700CC4AF0E;
	Thu,  1 Aug 2024 00:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472491;
	bh=n7vWZjyWV/GaxQtxgyPbyC5TObQk4ygvhVDuU6Al6Tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jlOcyHhDIjO4gtKQThMAiq89yUuy50IUU+spj2yVXKQWv2T1KrS2pmH0ScTp4kYFL
	 Fa0hgvSL5FZdwSBiB2sE6f4+AqXWAoItZsMcCKLyazezKY6g5D6MlLf9N2FYKtkMl1
	 4cmPYYS87ZZUdK1KEFc27I/PYbkzE9JGFTetXhGhH0Q+K7fXY1uVJsGKGh6kDZ3ccm
	 ZgBTAhAmIqEE7yxd5gk0mRAJnk343edRwINHH+CSNgnSrtDFbDgPC+32oydjMobNVC
	 KFObBgKvyAi6dGr9FSWtehvzzDbEIgfO0caw9WuQu7VPNTp3HNm+kjExyTu69FyLee
	 C8XyBioUTxYDA==
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
Subject: [PATCH AUTOSEL 5.15 28/47] smack: tcp: ipv4, fix incorrect labeling
Date: Wed, 31 Jul 2024 20:31:18 -0400
Message-ID: <20240801003256.3937416-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index e9d2ef3deccd1..25c46b56fae8d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4225,7 +4225,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 	rcu_read_unlock();
 
 	if (hskp == NULL)
-		rc = netlbl_req_setattr(req, &skp->smk_netlabel);
+		rc = netlbl_req_setattr(req, &ssp->smk_out->smk_netlabel);
 	else
 		netlbl_req_delattr(req);
 
-- 
2.43.0


