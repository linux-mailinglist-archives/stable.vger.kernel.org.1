Return-Path: <stable+bounces-236394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCSwJ58Y3Wn3ZwkAu9opvQ
	(envelope-from <stable+bounces-236394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:23:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 187ED3EECC2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAF2C30A8488
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E756A279DAF;
	Mon, 13 Apr 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HtVVd797"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D02727E2;
	Mon, 13 Apr 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096792; cv=none; b=c2Xt5EO8oEQqrgSswUVkcKokjimeXEmn1KIKUT55Q9L43GCdZ8h018fNmCu/hea6AhT27Yzv3EduXKH7aOjN9CmNVIjaBIASmRt/uj277qZ3eMO6cAcCyGpEZupMmvP9h5sxvVVo2XbYcpmBnhZqHl+Wid/G6KP2PhEJDcAhV1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096792; c=relaxed/simple;
	bh=7M9I2h8ODuGUKGF8+Qot9RL8RDIkfhHZWbflrlU2t/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNQ1sYgnN0clB8AYeTVGEe1WpOaEfTHA4G0jQt2ciAI0waUp+Ld07cZauDLTKFxFrPDbSXbtNaImkkyC/mN3836spSOnilofS2uO54SAyQurz1KFKdqbxc/s0x4zB+TCsJ7G01rLgc6VifzoL+t1g1jbL8mYj4zSHUFTQrryII0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HtVVd797; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17276C2BCB4;
	Mon, 13 Apr 2026 16:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096792;
	bh=7M9I2h8ODuGUKGF8+Qot9RL8RDIkfhHZWbflrlU2t/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HtVVd797vkGJ6ZgHPlmd4rirx4shCeNoyFZrTlYp+OEvJygeDwv94YFP31A2vDLOa
	 iJC7Zkl0WUEMrKQMdcHbKOCju43Exw+hCV0ECyNK7x8TnsaLwwCJyjFbArk/pCX5m2
	 RDtrQZ8Lkipome6pTIvFizTszOHH7L2dev46wnm0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <enjou1224z@gmail.com>,
	Yuqi Xu <xuyuqiabc@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 65/70] rxrpc: reject undecryptable rxkad response tickets
Date: Mon, 13 Apr 2026 18:01:00 +0200
Message-ID: <20260413155730.604497433@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
References: <20260413155728.181580293@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236394-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,redhat.com,auristor.com,kernel.org,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[auristor.com:email,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,lzu.edu.cn:email,msgid.link:url]
X-Rspamd-Queue-Id: 187ED3EECC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuqi Xu <xuyuqiabc@gmail.com>

commit fe4447cd95623b1cfacc15f280aab73a6d7340b2 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/rxkad.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -870,6 +870,7 @@ static int rxkad_decrypt_ticket(struct r
 	struct in_addr addr;
 	unsigned int life;
 	time64_t issue, now;
+	int ret;
 	bool little_endian;
 	u8 *p, *q, *name, *end;
 
@@ -889,8 +890,11 @@ static int rxkad_decrypt_ticket(struct r
 	sg_init_one(&sg[0], ticket, ticket_len);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, sg, sg, ticket_len, iv.x);
-	crypto_skcipher_decrypt(req);
+	ret = crypto_skcipher_decrypt(req);
 	skcipher_request_free(req);
+	if (ret < 0)
+		return rxrpc_abort_conn(conn, skb, RXKADBADTICKET, -EPROTO,
+					rxkad_abort_resp_tkt_short);
 
 	p = ticket;
 	end = p + ticket_len;



