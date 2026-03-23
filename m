Return-Path: <stable+bounces-229885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB6JMlBwwWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:54:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6342F9133
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A13831A0E86
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A561D3B38A4;
	Mon, 23 Mar 2026 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YVf6d90w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68115283FC8;
	Mon, 23 Mar 2026 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283126; cv=none; b=cJSs0PtwN3U4DGTm1d6DBqXgMkyTT0t2MGsjd9H7b90/5gP3wdVmZyL5LxzVcMEWHglH/3cjB9p648MVC8lMpeM4wJpfVaWwWFfq89YM0VQm6uAUk8W1q49wUlGgYh+oIi22WZv7i0L93hcfBsuuWymOkpQK9EL45d+BIkY2fro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283126; c=relaxed/simple;
	bh=FEXtK86SsHLjt3/bsFKUfg5WcZp0JNnKc29Q8Z+y0Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X68nJKrajWgHpF1/LJtF4q3jIWEam9fReWcR2j8NhSYttGzihL+XTT2fUOP0I6OiDYkERCPaQbYCEVCBhopS008ZsPUy9sw98AVtulr/VTkNeS/A5yhuT8P+5diuiXlU7XDBfybwdaUHPDR7w4xjdzIngPUjMfkKfjzDb++IdhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YVf6d90w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54C2C4CEF7;
	Mon, 23 Mar 2026 16:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774283126;
	bh=FEXtK86SsHLjt3/bsFKUfg5WcZp0JNnKc29Q8Z+y0Dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YVf6d90wpLwWtv5Mfw5s2YY7w1vzkSlhXETqXqJmZgPuE0BP3PEwQLCqFQpBJhxVX
	 chm4Jn1jbfcYl90Z1hPrOZgtR63adCyoGJCQXFgVFdnF8SXiEdZF3SJP6Ox07yxMDc
	 SXyepSBUI9is4u+m6E0nNRFV23M+/TaOX7W1Jbks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+d00f90e0af54102fb271@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 410/481] net/rose: fix NULL pointer dereference in rose_transmit_link on reconnect
Date: Mon, 23 Mar 2026 14:46:32 +0100
Message-ID: <20260323134535.173361395@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-229885-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,d00f90e0af54102fb271];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6B6342F9133
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiayuan Chen <jiayuan.chen@shopee.com>

[ Upstream commit e1f0a18c9564cdb16523c802e2c6fe5874e3d944 ]

syzkaller reported a bug [1], and the reproducer is available at [2].

ROSE sockets use four sk->sk_state values: TCP_CLOSE, TCP_LISTEN,
TCP_SYN_SENT, and TCP_ESTABLISHED. rose_connect() already rejects
calls for TCP_ESTABLISHED (-EISCONN) and TCP_CLOSE with SS_CONNECTING
(-ECONNREFUSED), but lacks a check for TCP_SYN_SENT.

When rose_connect() is called a second time while the first connection
attempt is still in progress (TCP_SYN_SENT), it overwrites
rose->neighbour via rose_get_neigh(). If that returns NULL, the socket
is left with rose->state == ROSE_STATE_1 but rose->neighbour == NULL.
When the socket is subsequently closed, rose_release() sees
ROSE_STATE_1 and calls rose_write_internal() ->
rose_transmit_link(skb, NULL), causing a NULL pointer dereference.

Per connect(2), a second connect() while a connection is already in
progress should return -EALREADY. Add this missing check for
TCP_SYN_SENT to complete the state validation in rose_connect().

[1] https://syzkaller.appspot.com/bug?extid=d00f90e0af54102fb271
[2] https://gist.github.com/mrpre/9e6779e0d13e2c66779b1653fef80516

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+d00f90e0af54102fb271@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69694d6f.050a0220.58bed.0027.GAE@google.com/T/
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260311070611.76913-1-jiayuan.chen@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rose/af_rose.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index d13ec76a1fec3..066e2d91ce3d6 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -810,6 +810,11 @@ static int rose_connect(struct socket *sock, struct sockaddr *uaddr, int addr_le
 		goto out_release;
 	}
 
+	if (sk->sk_state == TCP_SYN_SENT) {
+		err = -EALREADY;
+		goto out_release;
+	}
+
 	sk->sk_state   = TCP_CLOSE;
 	sock->state = SS_UNCONNECTED;
 
-- 
2.51.0




