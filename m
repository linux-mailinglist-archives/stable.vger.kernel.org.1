Return-Path: <stable+bounces-250996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIBvKArxDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-250996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:36:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 433B959412C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA3A43154D09
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222373EAC83;
	Wed, 20 May 2026 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hgL5kNmY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A83F20F0;
	Wed, 20 May 2026 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296831; cv=none; b=N5B7ciiNmZv5bh2+8JQTBgxME17CU0jQX146rL1wBUPkVgjpcB8MTFbCNbWGYxBS7/8Ks8qIBj0BwpCOXQUvQWnkU8Z1fQbLZFILCKBSehlENEjPb9AIDzPaYH8XGeWI0FyjI6EWi883yM7RktGKTOOcU7JvXCKIf4QKRj/Pvd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296831; c=relaxed/simple;
	bh=s+QJ/yNZ3onIAozLfFl4JpBhVe03tMtbPTM/jQMeT/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoTRm0qHqVF+Bjv/6oWWBnaVXwvg4bGD3uU1q7lcqi5JTVDKNnn0eVNznY1sUbGezxovMD7v0ML8/FuRYVdsTOXVCCi/yss9awJ64kbD0TQGrzAcdwrS8mrIfcp5wH3LONOroI3DJApwLlpih9KB1hH1VpjwL3hes7HpgU8xs7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hgL5kNmY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF401F00893;
	Wed, 20 May 2026 17:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296830;
	bh=32LypBusQoH8lyfLbY5q+WFFNnNfAPy0gsjeGVjDL24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hgL5kNmYlSqGwaC9sIrrJK++ZlVuV7+ClFBDNwT+V1b95brPg54GnU9cQuxt/nDvr
	 37nHyuAMQrI/H/YtcXXFDf6OkSb0uiBtgR4aZo/NfP8QJykegmZUxvBF0Sp/ozJiK2
	 dq7B5y3+HNJMq14zJwrmLEO8KLgaA3h9IY5vqzJU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com,
	Remi Denis-Courmont <courmisch@gmail.com>,
	Morduan Zang <zhangdandan@uniontech.com>,
	zhanjun <zhanjun@uniontech.com>,
	=?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0947/1146] net: phonet: do not BUG_ON() in pn_socket_autobind() on failed bind
Date: Wed, 20 May 2026 18:19:57 +0200
Message-ID: <20260520162209.664842491@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,gmail.com,uniontech.com,remlab.net,kernel.org];
	TAGGED_FROM(0.00)[bounces-250996-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,706f5eb79044e686c794];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,syzkaller.appspot.com:url,uniontech.com:email,remlab.net:email]
X-Rspamd-Queue-Id: 433B959412C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Morduan Zang <zhangdandan@uniontech.com>

[ Upstream commit 5b0c911bcdbd982f7748d11c0b39ec5808eae2de ]

syzbot reported a kernel BUG triggered from pn_socket_sendmsg() via
pn_socket_autobind():

  kernel BUG at net/phonet/socket.c:213!
  RIP: 0010:pn_socket_autobind net/phonet/socket.c:213 [inline]
  RIP: 0010:pn_socket_sendmsg+0x240/0x250 net/phonet/socket.c:421
  Call Trace:
   sock_sendmsg_nosec+0x112/0x150 net/socket.c:797
   __sock_sendmsg net/socket.c:812 [inline]
   __sys_sendto+0x402/0x590 net/socket.c:2280
   ...

pn_socket_autobind() calls pn_socket_bind() with port 0 and, on
-EINVAL, assumes the socket was already bound and asserts that the
port is non-zero:

  err = pn_socket_bind(sock, ..., sizeof(struct sockaddr_pn));
  if (err != -EINVAL)
          return err;
  BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));
  return 0; /* socket was already bound */

However pn_socket_bind() also returns -EINVAL when sk->sk_state is not
TCP_CLOSE, even when the socket has never been bound and pn_port() is
still 0.  In that case the BUG_ON() fires and panics the kernel from a
user-triggerable path.

Treat the "bind returned -EINVAL but pn_port() is still 0" case as a
regular error and propagate -EINVAL to the caller instead of crashing.
Existing callers already translate a non-zero return from
pn_socket_autobind() into -ENOBUFS/-EAGAIN, so returning -EINVAL here
only changes behaviour from panic to a normal errno.

Fixes: ba113a94b750 ("Phonet: common socket glue")
Reported-by: syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=706f5eb79044e686c794
Suggested-by: Remi Denis-Courmont <courmisch@gmail.com>
Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>
Signed-off-by: zhanjun <zhanjun@uniontech.com>
Acked-by: Rémi Denis-Courmont <remi@remlab.net>
Link: https://patch.msgid.link/87A8960A2045AF3C+20260423010557.138124-1-zhangdandan@uniontech.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/phonet/socket.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/phonet/socket.c b/net/phonet/socket.c
index 4423d483c630a..bbd710d95b975 100644
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -208,9 +208,15 @@ static int pn_socket_autobind(struct socket *sock)
 	sa.spn_family = AF_PHONET;
 	err = pn_socket_bind(sock, (struct sockaddr_unsized *)&sa,
 			     sizeof(struct sockaddr_pn));
-	if (err != -EINVAL)
+	/*
+	 * pn_socket_bind() also returns -EINVAL when sk_state != TCP_CLOSE
+	 * without a prior bind, so -EINVAL alone is not sufficient to infer
+	 * that the socket was already bound.  Only treat it as "already
+	 * bound" when the port is non-zero; otherwise propagate the error
+	 * instead of crashing the kernel.
+	 */
+	if (err != -EINVAL || unlikely(!pn_port(pn_sk(sock->sk)->sobject)))
 		return err;
-	BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));
 	return 0; /* socket was already bound */
 }
 
-- 
2.53.0




