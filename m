Return-Path: <stable+bounces-250872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G+sCgsVDmoW6AUAu9opvQ
	(envelope-from <stable+bounces-250872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:09:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 976FE59932F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0761D34628A1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F1F3F54DB;
	Wed, 20 May 2026 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jyZ9j+7+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E73F44EA;
	Wed, 20 May 2026 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296526; cv=none; b=WIMW1AQlMigl2+GL+xOSfhjSy3EUBhJn1nJdfLuUqYCcWiKrGTqJ9E4O0l6AzvSNWoQWqxoPZp2DdyfcYCAoLfXFx8bp5jGkTPCkUZpjqpBwzVrBZxWvoaCzE8w7qJMsD/SscqGRg5nAV6pqgFbn7uTwcdwYsEuiAGzhrhjegFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296526; c=relaxed/simple;
	bh=r9FLj31QSPKuoMq43fcow4hKMC2XLpo6f/nyHFN+s2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iM25yAF0rPDQ0tiybekR/DUB9XVp3oBN1c1+CuxIX+sGHf5oduHKyBI0D0d1dY/RNI/TGmtEUiIZwZ9fhxPffiP3CZZjL5acHC5lTHx7d3i5ASZfFuQq3SqXyOUSyz/iuImXctbIZpZre30Ct92DxdutwfAOidKtNuqXm4h+pBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jyZ9j+7+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8791F000E9;
	Wed, 20 May 2026 17:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296524;
	bh=CpcOCVzvh7byRFcTVcinZWn8+aVtvXOiGd/Oxu/9WGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jyZ9j+7+9luZqhQe7WKRyG/rChFOj29AQMSG3Rhq745PKBVLut12GnCGUmV6MxoZo
	 5I2t6TcbZ9C8jFBL8x67kHODX8dm0zqz8YNEfPOXEDp0CusUiqVKvgoORu8b0W8mXp
	 ChQ7FcNXtR6LaDPc2KC4y95g2Gl5m1x/B7By9iL8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xin Long <lucien.xin@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0833/1146] sctp: fix sockets_allocated imbalance after sk_clone()
Date: Wed, 20 May 2026 18:18:03 +0200
Message-ID: <20260520162207.081451463@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,google.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250872-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 976FE59932F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 7c9b012d6367a335f1e91da28401a7c612305a46 ]

sk_clone() increments sockets_allocated and sets the socket refcount to 2.
SCTP performs additional accounting in sctp_clone_sock(), so the clone-time
increment must be undone to avoid double counting.

Note we cannot simply remove the SCTP-side increment, because the SCTP
destroy path in sctp_destroy_sock() only decrements sockets_allocated when
sp->ep is set, which may not be true for all failure paths in
sctp_clone_sock().

Fixes: 16942cf4d3e3 ("sctp: Use sk_clone() in sctp_accept().")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/af8d66f928dec3e9fcbee8d4a85b7d5a6b86f515.1776460180.git.lucien.xin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/socket.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 6c58ad092e512..aeffa10ff2d34 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4864,8 +4864,9 @@ static struct sock *sctp_clone_sock(struct sock *sk,
 	if (!newsk)
 		return ERR_PTR(err);
 
-	/* sk_clone() sets refcnt to 2 */
+	/* sk_clone() sets refcnt to 2 and increments sockets_allocated */
 	sock_put(newsk);
+	sk_sockets_allocated_dec(newsk);
 
 	newinet = inet_sk(newsk);
 	newsp = sctp_sk(newsk);
-- 
2.53.0




