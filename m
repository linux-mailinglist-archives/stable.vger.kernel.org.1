Return-Path: <stable+bounces-231848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIAiKWoBzGk8NQYAu9opvQ
	(envelope-from <stable+bounces-231848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:16:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E6736E5BA
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DA2C329DE89
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5901426680;
	Tue, 31 Mar 2026 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BIFfTUdj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E53E3C5C;
	Tue, 31 Mar 2026 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975226; cv=none; b=f2US0k7nK27O52G1E3WnUfxf+9n0WRxs1VYmcG0ZqaiyJfbBxvRtcVDX+F7yk0WO+5kSbUnOmm/2UTeAYZw2bM1xe8/R3KZoGcx140oA0HO5Dpw0Y/BC11WVs+Ol3KFk7EgavwGyh3IR0kjZS2pntDiGI6qOkLOXdzSNp0fynGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975226; c=relaxed/simple;
	bh=jxTtfW9/SHQ7RgsLPtwvazPs97cTj7URqqYei6fR/t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zqq9W+s+UxP8G7RPZQ1/uSeZkT9r9UGLdmfDBFZErJuJNNM7XzPjydRQ3MjqwmEDhe5B5/FU0Z2RU54gVqKy7e+H4cXoPKf5AQbmlW+Q4BEmwFTadKhhtl6fa/AW/zyJ1W2PUbV7ryJDHNmDZvYZPvS8XiKgr5frvJ40Cz/72RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BIFfTUdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1FBC19423;
	Tue, 31 Mar 2026 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975226;
	bh=jxTtfW9/SHQ7RgsLPtwvazPs97cTj7URqqYei6fR/t4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BIFfTUdjEw8hMcYQfL4oLpXfDEExeKzfZsbsmJ3MBPaMnpyzaugnKWQKPYarG3k2R
	 wtTq99k/Wgum0/Q4M/nNb7lncYE8YatrbuQYpCGfaO9ARFKOzkZTHZ5n2FjhDEVnCw
	 aiTss4o8FSQpqzzX6cu8f1sm1YmDzTVVU5gx26so=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ali Norouzi <ali.norouzi@keysight.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.19 213/342] can: isotp: fix tx.buf use-after-free in isotp_sendmsg()
Date: Tue, 31 Mar 2026 18:20:46 +0200
Message-ID: <20260331161806.816904125@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-231848-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,hartkopp.net:email,keysight.com:email]
X-Rspamd-Queue-Id: 11E6736E5BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Hartkopp <socketcan@hartkopp.net>

commit 424e95d62110cdbc8fd12b40918f37e408e35a92 upstream.

isotp_sendmsg() uses only cmpxchg() on so->tx.state to serialize access
to so->tx.buf. isotp_release() waits for ISOTP_IDLE via
wait_event_interruptible() and then calls kfree(so->tx.buf).

If a signal interrupts the wait_event_interruptible() inside close()
while tx.state is ISOTP_SENDING, the loop exits early and release
proceeds to force ISOTP_SHUTDOWN and continues to kfree(so->tx.buf)
while sendmsg may still be reading so->tx.buf for the final CAN frame
in isotp_fill_dataframe().

The so->tx.buf can be allocated once when the standard tx.buf length needs
to be extended. Move the kfree() of this potentially extended tx.buf to
sk_destruct time when either isotp_sendmsg() and isotp_release() are done.

Fixes: 96d1c81e6a04 ("can: isotp: add module parameter for maximum pdu size")
Cc: stable@vger.kernel.org
Reported-by: Ali Norouzi <ali.norouzi@keysight.com>
Co-developed-by: Ali Norouzi <ali.norouzi@keysight.com>
Signed-off-by: Ali Norouzi <ali.norouzi@keysight.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260319-fix-can-gw-and-can-isotp-v2-2-c45d52c6d2d8@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/isotp.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1230,12 +1230,6 @@ static int isotp_release(struct socket *
 	so->ifindex = 0;
 	so->bound = 0;
 
-	if (so->rx.buf != so->rx.sbuf)
-		kfree(so->rx.buf);
-
-	if (so->tx.buf != so->tx.sbuf)
-		kfree(so->tx.buf);
-
 	sock_orphan(sk);
 	sock->sk = NULL;
 
@@ -1604,6 +1598,21 @@ static int isotp_notifier(struct notifie
 	return NOTIFY_DONE;
 }
 
+static void isotp_sock_destruct(struct sock *sk)
+{
+	struct isotp_sock *so = isotp_sk(sk);
+
+	/* do the standard CAN sock destruct work */
+	can_sock_destruct(sk);
+
+	/* free potential extended PDU buffers */
+	if (so->rx.buf != so->rx.sbuf)
+		kfree(so->rx.buf);
+
+	if (so->tx.buf != so->tx.sbuf)
+		kfree(so->tx.buf);
+}
+
 static int isotp_init(struct sock *sk)
 {
 	struct isotp_sock *so = isotp_sk(sk);
@@ -1648,6 +1657,9 @@ static int isotp_init(struct sock *sk)
 	list_add_tail(&so->notifier, &isotp_notifier_list);
 	spin_unlock(&isotp_notifier_lock);
 
+	/* re-assign default can_sock_destruct() reference */
+	sk->sk_destruct = isotp_sock_destruct;
+
 	return 0;
 }
 



