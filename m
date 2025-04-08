Return-Path: <stable+bounces-131335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 658C6A80A12
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61258C6A28
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533BD26B0BE;
	Tue,  8 Apr 2025 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K6yoSGuu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5C26982F;
	Tue,  8 Apr 2025 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116119; cv=none; b=VV+sIkgFN51ccgkIh5b077MtFK2q3SDI8v0FhNSgUxUZpMquuTvYE5NFYfV3sMQnL1FPEnQQHE57DfalPzQRyN1exINAzCO029VIVjhTnkTtYusw1G+hMTRu4uTBtnsi12S7U0UNn8cafyUpfS95HHDywBxJRCIKShbBgNWfY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116119; c=relaxed/simple;
	bh=vPu1rdJnE1ClU6siyti6UNIQtiCaEm1H9wB0lMRfkC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyd/GmjjB/gvkFthKqWOrXhZXDKNKka9z4imo1KZXuXBjadk9zwM8FslaYBEdA14ElAId+HPC7a1AjwYTfbsJuFQaowBGR0KSm3aoK+Q3KhwjpFR9Y+N4TbtxyrnxtcTS+OWSJtIUNz+ROgGXirHI+zSzEnmjqSzXvDYaUIcvJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K6yoSGuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F1AC4CEE5;
	Tue,  8 Apr 2025 12:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116118;
	bh=vPu1rdJnE1ClU6siyti6UNIQtiCaEm1H9wB0lMRfkC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6yoSGuuQBJSbgovhr2ryyt9KvnSdrm8g/1VET/+iYeVWIT6SW8WawGZ/puP7tZBb
	 FfZZBW+ZRLPytCY/x4ekCOjspWVBYHcwIBz/PT1u+AonCZwGXZQV7QhFsBuQexHpgs
	 lWsMjzeKIGNT199VB3l41pSq/vKrzjUgOlNeDi8Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Andreev <andreev@swemel.ru>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 005/423] smack: ipv4/ipv6: tcp/dccp/sctp: fix incorrect child socket label
Date: Tue,  8 Apr 2025 12:45:31 +0200
Message-ID: <20250408104845.823485284@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Andreev <andreev@swemel.ru>

[ Upstream commit 6cce0cc3861337b3ad8d4ac131d6e47efa0954ec ]

Since inception [1], SMACK initializes ipv* child socket security
for connection-oriented communications (tcp/sctp/dccp)
during accept() syscall, in the security_sock_graft() hook:

| void smack_sock_graft(struct sock *sk, ...)
| {
|     // only ipv4 and ipv6 are eligible here
|     // ...
|     ssp = sk->sk_security; // socket security
|     ssp->smk_in = skp;     // process label: smk_of_current()
|     ssp->smk_out = skp;    // process label: smk_of_current()
| }

This approach is incorrect for two reasons:

A) initialization occurs too late for child socket security:

   The child socket is created by the kernel once the handshake
   completes (e.g., for tcp: after receiving ack for syn+ack).

   Data can legitimately start arriving to the child socket
   immediately, long before the application calls accept()
   on the socket.

   Those data are (currently — were) processed by SMACK using
   incorrect child socket security attributes.

B) Incoming connection requests are handled using the listening
   socket's security, hence, the child socket must inherit the
   listening socket's security attributes.

   smack_sock_graft() initilizes the child socket's security with
   a process label, as is done for a new socket()

   But ... the process label is not necessarily the same as the
   listening socket label. A privileged application may legitimately
   set other in/out labels for a listening socket.

   When this happens, SMACK processes incoming packets using
   incorrect socket security attributes.

In [2] Michael Lontke noticed (A) and fixed it in [3] by adding
socket initialization into security_sk_clone_security() hook like

| void smack_sk_clone_security(struct sock *oldsk, struct sock *newsk)
| {
|    *(struct socket_smack *)newsk->sk_security =
|    *(struct socket_smack *)oldsk->sk_security;
| }

This initializes the child socket security with the parent (listening)
socket security at the appropriate time.

I was forced to revisit this old story because

smack_sock_graft() was left in place by [3] and continues overwriting
the child socket's labels with the process label,
and there might be a reason for this, so I undertook a study.

If the process label differs from the listening socket's labels,
the following occurs for ipv4:

assigning the smk_out is not accompanied by netlbl_sock_setattr,
so the outgoing packet's cipso label does not change.

So, the only effect of this assignment for interhost communications
is a divergence between the program-visible “out” socket label and
the cipso network label. For intrahost communications this label,
however, becomes visible via secmark netfilter marking, and is
checked for access rights by the client, receiving side.

Assigning the smk_in affects both interhost and intrahost
communications: the server begins to check access rights against
an wrong label.

Access check against wrong label (smk_in or smk_out),
unsurprisingly fails, breaking the connection.

The above affects protocols that calls security_sock_graft()
during accept(), namely: {tcp,dccp,sctp}/{ipv4,ipv6}
One extra security_sock_graft() caller, crypto/af_alg.c`af_alg_accept
is not affected, because smack_sock_graft() does nothing for PF_ALG.

To reproduce, assign non-default in/out labels to a listening socket,
setup rules between these labels and client label, attempt to connect
and send some data.

Ipv6 specific: ipv6 packets do not convey SMACK labels. To reproduce
the issue in interhost communications set opposite labels in
/smack/ipv6host on both hosts.
Ipv6 intrahost communications do not require tricking, because SMACK
labels are conveyed via secmark netfilter marking.

So, currently smack_sock_graft() is not useful, but harmful,
therefore, I have removed it.

This fixes the issue for {tcp,dccp}/{ipv4,ipv6},
but not sctp/{ipv4,ipv6}.

Although this change is necessary for sctp+smack to function
correctly, it is not sufficient because:
sctp/ipv4 does not call security_sk_clone() and
sctp/ipv6 ignores SMACK completely.

These are separate issues, belong to other subsystem,
and should be addressed separately.

[1] 2008-02-04,
Fixes: e114e473771c ("Smack: Simplified Mandatory Access Control Kernel")

[2] Michael Lontke, 2022-08-31, SMACK LSM checks wrong object label
                                during ingress network traffic
Link: https://lore.kernel.org/linux-security-module/6324997ce4fc092c5020a4add075257f9c5f6442.camel@elektrobit.com/

[3] 2022-08-31, michael.lontke,
    commit 4ca165fc6c49 ("SMACK: Add sk_clone_security LSM hook")

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smack_lsm.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c066c38c50882..9e13fd3920630 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4357,29 +4357,6 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 	return 0;
 }
 
-/**
- * smack_sock_graft - Initialize a newly created socket with an existing sock
- * @sk: child sock
- * @parent: parent socket
- *
- * Set the smk_{in,out} state of an existing sock based on the process that
- * is creating the new socket.
- */
-static void smack_sock_graft(struct sock *sk, struct socket *parent)
-{
-	struct socket_smack *ssp;
-	struct smack_known *skp = smk_of_current();
-
-	if (sk == NULL ||
-	    (sk->sk_family != PF_INET && sk->sk_family != PF_INET6))
-		return;
-
-	ssp = smack_sock(sk);
-	ssp->smk_in = skp;
-	ssp->smk_out = skp;
-	/* cssp->smk_packet is already set in smack_inet_csk_clone() */
-}
-
 /**
  * smack_inet_conn_request - Smack access check on connect
  * @sk: socket involved
@@ -5168,7 +5145,6 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(sk_free_security, smack_sk_free_security),
 #endif
 	LSM_HOOK_INIT(sk_clone_security, smack_sk_clone_security),
-	LSM_HOOK_INIT(sock_graft, smack_sock_graft),
 	LSM_HOOK_INIT(inet_conn_request, smack_inet_conn_request),
 	LSM_HOOK_INIT(inet_csk_clone, smack_inet_csk_clone),
 
-- 
2.39.5




