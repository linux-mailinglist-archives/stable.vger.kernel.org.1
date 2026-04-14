Return-Path: <stable+bounces-237840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI9REk4t3mnxogkAu9opvQ
	(envelope-from <stable+bounces-237840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:04:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 922453F9C32
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A94AC304DCA8
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28B434EEED;
	Tue, 14 Apr 2026 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYl4KoZ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E4E1FC8
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167773; cv=none; b=rKG/lJ/S/cNcaQ1iLb/J6jC5BLSo/2q+Z0JbCCanG49RtfaIDndSjHLauzYq/Ro15DItGOb04ti+l4GNgz0yw/d57yj0OFD/L89wEOmBaV9BExsocjaFtU50ctjGDAjXSAW703yYtX3qJhrY6J6rISpdbKyGRPkeFYNiRevA8HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167773; c=relaxed/simple;
	bh=EQBGI9VP1BsghsyEgYeLGsl360/Q21GEup8Rcy4I85A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPEKbLfIE6CKWWrf7cj7O9LILoQg0qMWVvHxk+zwWcAhyX6KGBL8KH2indB1nC4FyLcm51b7abWdjC4KokW2R7uOtkKEK1frMlXotE4kOTOtLwfYEy7QkQ0FHedv6GsWU6HD028aUsW1UByhAYAAM1I64Ap8I5p2Y1ctGqv35I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYl4KoZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E900AC19425;
	Tue, 14 Apr 2026 11:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776167773;
	bh=EQBGI9VP1BsghsyEgYeLGsl360/Q21GEup8Rcy4I85A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYl4KoZ9erShgElXIXYCtjVN0qWqF4P/DXiW8w+qDgau2SHAJT7oB9ktWjyUMXLO5
	 pQGvdaqbNPGOfjhJWJqa7HocmyzUOFUWFuNLK7jNOuph7JsdrXqjGCoYyJaq3EScmB
	 7EFokUFUfKJZghAl1j/hWpkvuCMloZeFxi+v6ulf6EcQMURqCvSmvN+LnIE09Owimu
	 ctET36+cAqzGHPz/7UPkxJfS52v/3xK73rhaz8uWNxuqik+xdOlTGZTAZ0oPTm19QL
	 HbX8zUfleYr9NZdmOlBdml855554HABVDDFwd15TBvQNzPeXArZb0KhkUYsZ9BvCtq
	 NQDA8fx2S0pZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuqi Xu <xuyuqiabc@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <enjou1224z@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] rxrpc: reject undecryptable rxkad response tickets
Date: Tue, 14 Apr 2026 07:56:10 -0400
Message-ID: <20260414115610.548230-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041319-ethanol-outflank-3480@gregkh>
References: <2026041319-ethanol-outflank-3480@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	URIBL_MULTI_FAIL(0.00)[infradead.org:server fail,sea.lore.kernel.org:server fail];
	FREEMAIL_CC(0.00)[gmail.com,lzu.edu.cn,redhat.com,auristor.com,kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237840-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,msgid.link:url,auristor.com:email]
X-Rspamd-Queue-Id: 922453F9C32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yuqi Xu <xuyuqiabc@gmail.com>

[ Upstream commit fe4447cd95623b1cfacc15f280aab73a6d7340b2 ]

rxkad_decrypt_ticket() decrypts the RXKAD response ticket and then
parses the buffer as plaintext without checking whether
crypto_skcipher_decrypt() succeeded.

A malformed RESPONSE can therefore use a non-block-aligned ticket
length, make the decrypt operation fail, and still drive the ticket
parser with attacker-controlled bytes.

Check the decrypt result and abort the connection with RXKADBADTICKET
when ticket decryption fails.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260408121252.2249051-12-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adapted `rxrpc_abort_conn()` call to existing `goto other_error` error-handling pattern ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/rxkad.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index db47844f4ac99..45a64eafa2006 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -1013,8 +1013,13 @@ static int rxkad_decrypt_ticket(struct rxrpc_connection *conn,
 	sg_init_one(&sg[0], ticket, ticket_len);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, sg, sg, ticket_len, iv.x);
-	crypto_skcipher_decrypt(req);
+	ret = crypto_skcipher_decrypt(req);
 	skcipher_request_free(req);
+	if (ret < 0) {
+		abort_code = RXKADBADTICKET;
+		ret = -EPROTO;
+		goto other_error;
+	}
 
 	p = ticket;
 	end = p + ticket_len;
-- 
2.53.0


