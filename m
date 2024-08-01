Return-Path: <stable+bounces-65202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DD8943FAA
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4050F1F213EA
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD89B139CEE;
	Thu,  1 Aug 2024 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZBJWmQo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971621A9D1D;
	Thu,  1 Aug 2024 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472852; cv=none; b=LkP9KySz7KYlosnOiZ0qaoxBFdww7Y3ItbREQfAOlu4gPWeo3MEU4AUv9YcxylwI1VF8oEfAHuo0yOpMkDs44fkysk8pee1eAkkc2e58yhJohpoPBaru+6s1LetdFesxYLgslNdgPg/Cc78yr8p5KLonEzQslvsOXB9WYQkdtcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472852; c=relaxed/simple;
	bh=gC4+abmNMAF5g0LkhGJRgCKbkYJwH5npRoFm8eUWqow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbp7hy/HOJbugh/hAwuDg06pgbuFb8n5gjBFuAR1HwGpkBJ8oeBrJ9M+paxq+dhgnDDbIi72DgWi00Bs4eLIDaf5OjyzR6wd3uQvvoM2+vNGTddxjO3JHvxv/m2XrZnrTD6FNHz3gCK3n0tI7EiXlCSwj/WnmWapGcWPFNoeE68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZBJWmQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C03C32786;
	Thu,  1 Aug 2024 00:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472852;
	bh=gC4+abmNMAF5g0LkhGJRgCKbkYJwH5npRoFm8eUWqow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZBJWmQobL75W9AfaVdmmvvdTnr83kTyxe7IB3K+Sh1cbKUf0Jw+atU90hg9VHmCl
	 4b/C+S7Z2jrVAp0hDIY2Qu9dqgsagwiTsFOqbk1ffTHqfh2YSZE+zK5qqNCK7aPNGb
	 /3ohqcpOUeyBgCiQy9KrOJvly6d6kbtlZDzRyq3WAHmM5OGeaaKE1+bEESNiYLXyky
	 ZGdf77XZ+ILbYfXqx9i07ZmdHyBfuKFXCD6VtCM4uxLpAVkjq7FZENehIIwhB9RpTp
	 p10ZA2QHicWZITxy/yo4JxE0HPJBau7yMqy6U0stBVUpMFM7qF7ltkkzHsgqBauRqN
	 hdOcSlupES5sw==
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
Subject: [PATCH AUTOSEL 4.19 05/14] smack: tcp: ipv4, fix incorrect labeling
Date: Wed, 31 Jul 2024 20:40:13 -0400
Message-ID: <20240801004037.3939932-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801004037.3939932-1-sashal@kernel.org>
References: <20240801004037.3939932-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
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
index d9bff4ba7f2e8..158f4df39be44 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4291,7 +4291,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	rcu_read_unlock();
 
 	if (hskp == NULL)
-		rc = netlbl_req_setattr(req, &skp->smk_netlabel);
+		rc = netlbl_req_setattr(req, &ssp->smk_out->smk_netlabel);
 	else
 		netlbl_req_delattr(req);
 
-- 
2.43.0


