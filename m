Return-Path: <stable+bounces-74183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C01972DEB
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977141C23DF3
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE3B18A6D2;
	Tue, 10 Sep 2024 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vhmdOXlw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DA3188A1E;
	Tue, 10 Sep 2024 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961057; cv=none; b=WeQDbhFiz0yetOw8bNc1lMPbZ8NPK/pIhv5pNSjnsAqHsq8Hq2sTklyAa2Ao/tP+QH1pCxjGRAIXmGbLalkMbSXAFbF6vZY8pf+ufdCg/j8UZ2Kx7PHRIcFgBvimMQNd3Gwd8TqmvJSwqVpFIBFI6SUI/ziPoAmY7HXkmYEj5AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961057; c=relaxed/simple;
	bh=JwxEE8/YApkEvH75SUSwYErhZRCCk7E3t1u66GYnESc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNzpZdanO3pKXrUnAbvrI4AKvwOs9ke7Z4PhlSio6KRWKb7KMe3oriTNruQ8IKiYhIrVoQ7+yFzcdEEPzZm+yDsc31u6Wyp6hSH/oSEkVM20H7yNjJrgeGSyNIRYxjD8ac5jCihieBprF+7T+RQ7Q4ZVhXk0pfiewNpxxRttq00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vhmdOXlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89F3C4CEC3;
	Tue, 10 Sep 2024 09:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961057;
	bh=JwxEE8/YApkEvH75SUSwYErhZRCCk7E3t1u66GYnESc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vhmdOXlwPVXhIWBLq2tE8mylEDAFvAeXGSEkH7kEYQDdvl7THyKmtrWpmdurQc7ED
	 Bj7n0aJhFhz3Re3Sjt7KAyIInzZ/dQQjtstD3uqMu8YWmBDv/Rrot9C1wsJQVi/kMo
	 Tpj5lDK8iyLp/vcaDAHqyZLOOydEdVbc6Holl4xQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Andreev <andreev@swemel.ru>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 11/96] smack: tcp: ipv4, fix incorrect labeling
Date: Tue, 10 Sep 2024 11:31:13 +0200
Message-ID: <20240910092541.899440805@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092541.383432924@linuxfoundation.org>
References: <20240910092541.383432924@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index d9bff4ba7f2e..158f4df39be4 100644
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




