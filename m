Return-Path: <stable+bounces-219294-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SErNExmfnmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219294-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:04:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE26F192E5C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7210D3160EF6
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A312D77EA;
	Wed, 25 Feb 2026 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uG42f7RB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094322D839C;
	Wed, 25 Feb 2026 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002622; cv=none; b=SGBCX9vs8954PWao9B9tDatyNMcZ20OqFEEcp+yoX3bSzsCvj027HDqpt7vg7KXiTp+Hz5+1k0zBWhNFLxYdtC2KoGjAfgC4yPyz9JX8lRB80T4hDcjN3/c0ZNjFslBUJIico/oRvMwEHC6Ivy90iqaFJS+YZqtN0bDZUAug1v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002622; c=relaxed/simple;
	bh=f8xV2xXUxdAHeO02DW524ihdaeVyCeBDsiCcb99U6rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOMs/1n+gyt51svu63mZp6LFv7L9IpgMr5duD9wW9XpdHNjlKrhE3KzYeum6biJKZT3jzie0gyG+eAgMAQDPGO9JSe7Po8OSHTXdzAxQWNdvR5/sjymyELNV+Qm+ni+ZjeFPWGcb/29ZlU445efaOvkuAVFJHy7J/w5aa0V2emI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uG42f7RB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E16C116D0;
	Wed, 25 Feb 2026 06:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002621;
	bh=f8xV2xXUxdAHeO02DW524ihdaeVyCeBDsiCcb99U6rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uG42f7RB4MXAyzM4TntzvdxjTV3+Ilsfg/Su/dROLx8+XAUC2FcWIJv3ythnylsrT
	 cZNWTariVMN6ayk12hEFqoZPVb7wUshbM70FUmpOC76VtoKrCFMqJDUBoUrKpUAzs+
	 ToTUsKaQI09hWrFfbGrV/SD0eM1Kp3pCOnwtZtLA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 336/641] af_unix: Fix memleak of newsk in unix_stream_connect().
Date: Tue, 24 Feb 2026 17:21:02 -0800
Message-ID: <20260225012356.819148648@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219294-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE26F192E5C
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 6884028cd7f275f8bcb854a347265cb1fb0e4bea ]

When prepare_peercred() fails in unix_stream_connect(),
unix_release_sock() is not called for newsk, and the memory
is leaked.

Let's move prepare_peercred() before unix_create1().

Fixes: fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for reaped sk->sk_peer_pid")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260207232236.2557549-1-kuniyu@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/af_unix.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index c634a7fc86090..9dad3af700af3 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1671,10 +1671,9 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 
 	timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
 
-	/* First of all allocate resources.
-	 * If we will make it after state is locked,
-	 * we will have to recheck all again in any case.
-	 */
+	err = prepare_peercred(&peercred);
+	if (err)
+		goto out;
 
 	/* create new sock for complete connection */
 	newsk = unix_create1(net, NULL, 0, sock->type);
@@ -1683,10 +1682,6 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out;
 	}
 
-	err = prepare_peercred(&peercred);
-	if (err)
-		goto out;
-
 	/* Allocate skb for sending to listening sock */
 	skb = sock_wmalloc(newsk, 1, 0, GFP_KERNEL);
 	if (!skb) {
-- 
2.51.0




