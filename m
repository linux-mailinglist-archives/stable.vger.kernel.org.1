Return-Path: <stable+bounces-271043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UxA0HWSaRmp1ZwsAu9opvQ
	(envelope-from <stable+bounces-271043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:05:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 719BE6FAF7A
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:05:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ag2ixOP+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271043-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271043-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00AE33022D36
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB58A359A89;
	Thu,  2 Jul 2026 16:42:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B728A349CDB;
	Thu,  2 Jul 2026 16:41:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010520; cv=none; b=W6VMJDocoZi1NLfCdOOxKWk6ri/EJIE6Sncra0QIMaZshQMCfCaRhP/dC2vxk07Mwli9O9PPxmkWgjaEbtuMe/4TCOtNOQyT1qd1ke1MsfeCQtPY6KcquzRECGRcaDKqVdurzRNeGuiIMBlNbYnQsldyFYXG/+dBtdlTf8Ncwz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010520; c=relaxed/simple;
	bh=Ewvg/wgytIq0GG9hScf8OHQAKnOz1BseE1ZVFGdfS0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvdcPNOqk7jDlSWounRHAW9jdfJJZTLoQvUH6OFpKSnc3TdvQrq0pasRkVXlp3pZzGvpVBGyrxh7scdSYuLKpap1Yugm6khGCCN7Xzs+Gf/RVH3HGMcLYyc4Y/LhDPgWuT5iPU+d5YE135e3PsIeUVpLlW/UEYpdKvPpSEmAJYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ag2ixOP+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D131F000E9;
	Thu,  2 Jul 2026 16:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010519;
	bh=LXMahY4VQjQwf95UkH/Us6R5PrGWFC3GHnXJ+o7Obiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ag2ixOP+PFRKnclzKOe7nE/56bKqu9MpljusHPuJycOZGmOvcX9rUgazLKVRsD5xX
	 lf5tBcllz0vjQZzV+LCwvSE38xBNJOEarIj5nxydUJF2SpqfvSwLNVsE8gnnC12Y+z
	 XKL/Vk6N0SJfoBaxB9OL+CJQFjq1hWO9Ts1VrkIU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bryam Vargas <hexlabsecurity@proton.me>,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 6.12 139/204] apparmor: mediate the implicit connect of TCP fast open sendmsg
Date: Thu,  2 Jul 2026 18:19:56 +0200
Message-ID: <20260702155121.570672519@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271043-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:hexlabsecurity@proton.me,m:john.johansen@canonical.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:email,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,canonical.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 719BE6FAF7A

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bryam Vargas <hexlabsecurity@proton.me>

commit 4d587cd8a72155089a627130bbd4716ec0856e21 upstream.

sendmsg()/sendto() with MSG_FASTOPEN is a combination of connect(2) and
write(2): it opens the connection in the SYN. apparmor_socket_sendmsg()
only checks AA_MAY_SEND, so a profile that grants send but denies connect
lets a confined task open an outbound TCP/MPTCP connection that connect(2)
would have refused, bypassing connect mediation.

Mediate the implicit connect when MSG_FASTOPEN is set and a destination
is supplied. Add it to apparmor_socket_sendmsg() (not the shared
aa_sock_msg_perm() helper, which recvmsg also uses) and call aa_sk_perm()
directly, mirroring the selinux and tomoyo fixes. sk_is_tcp() does not
cover MPTCP fast open, so the SOCK_STREAM/IPPROTO_MPTCP arm is explicit.

Fixes: cf60af03ca4e ("net-tcp: Fast Open client - sendmsg(MSG_FASTOPEN)")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/apparmor/lsm.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1207,7 +1207,21 @@ static int aa_sock_msg_perm(const char *
 static int apparmor_socket_sendmsg(struct socket *sock,
 				   struct msghdr *msg, int size)
 {
-	return aa_sock_msg_perm(OP_SENDMSG, AA_MAY_SEND, sock, msg, size);
+	int error = aa_sock_msg_perm(OP_SENDMSG, AA_MAY_SEND, sock, msg, size);
+
+	if (error)
+		return error;
+
+	/* TCP fast open carries connect() semantics in sendmsg(); mediate
+	 * the implicit connect so it cannot bypass the connect permission.
+	 */
+	if ((msg->msg_flags & MSG_FASTOPEN) && msg->msg_name &&
+	    (sk_is_tcp(sock->sk) ||
+	     (sk_is_inet(sock->sk) && sock->sk->sk_type == SOCK_STREAM &&
+	      sock->sk->sk_protocol == IPPROTO_MPTCP)))
+		error = aa_sk_perm(OP_CONNECT, AA_MAY_CONNECT, sock->sk);
+
+	return error;
 }
 
 static int apparmor_socket_recvmsg(struct socket *sock,



