Return-Path: <stable+bounces-236076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHGLOnHn3GmUYAkAu9opvQ
	(envelope-from <stable+bounces-236076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:54:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF573EC3A9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E60B0300C308
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2995A3C9EE7;
	Mon, 13 Apr 2026 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GIyRkDbk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D303C4579
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776084847; cv=none; b=bWh6Dth7rHhRMubsyezd7ZjF6WYQqnlBwBVaR3rXthY+9fJMQPtFGBR2V0Opb5bI+CZl5QBM7LjIJa+zEed/Ua1q1yOVJZsf5E+K9nWqcAHnBZk/SG2ciZ9n4jcl7/oziemO6L3w0nJq4EE6j/ts8486QVwYCSYYFRiycGWJQlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776084847; c=relaxed/simple;
	bh=1xY8g03x99EumS2H3iBOzNLxVvqDnHPRitU6X8T7Dmw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B243S7DVgHOhFhjwM9dgIFazR6SUqWSyc1OlYlkuz1VpDOEMW9IFbJLM7FyG9rgWKA6BlISpAbij/HqEewZJfOz4Cg9WQNg3o9QAremGb77LDLNl/Zu4WsBWEASQxDuuXNBRA16NSxQo0Z3F2ELA1gSmHwHNZyNJC4bEKCbILvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GIyRkDbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D9CC2BCAF;
	Mon, 13 Apr 2026 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776084846;
	bh=1xY8g03x99EumS2H3iBOzNLxVvqDnHPRitU6X8T7Dmw=;
	h=Subject:To:Cc:From:Date:From;
	b=GIyRkDbk1tctT36upznMG5IjPYdHHzDsT55O+TgBgj+Tb4NvMorNwiQrTjahw3rva
	 PClmxpMHSFW1pdXem1Y9BHxTgT6KOwkH1i8DK4un4VNG5K5QyX3REk/e2f1s3pDk1Y
	 AKKJT8yZ1hJXR4PQmg1x+DWLYq0KpSCf251aXEIQ=
Subject: FAILED: patch "[PATCH] rxrpc: reject undecryptable rxkad response tickets" failed to apply to 5.15-stable tree
To: xuyuqiabc@gmail.com,bird@lzu.edu.cn,dhowells@redhat.com,enjou1224z@gmail.com,horms@kernel.org,kuba@kernel.org,marc.dionne@auristor.com,n05ec@lzu.edu.cn,tomapufckgml@gmail.com,yifanwucs@gmail.com,yuantan098@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Apr 2026 14:40:19 +0200
Message-ID: <2026041319-ethanol-outflank-3480@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236076-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lzu.edu.cn,redhat.com,kernel.org,auristor.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8AF573EC3A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fe4447cd95623b1cfacc15f280aab73a6d7340b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026041319-ethanol-outflank-3480@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fe4447cd95623b1cfacc15f280aab73a6d7340b2 Mon Sep 17 00:00:00 2001
From: Yuqi Xu <xuyuqiabc@gmail.com>
Date: Wed, 8 Apr 2026 13:12:39 +0100
Subject: [PATCH] rxrpc: reject undecryptable rxkad response tickets

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

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index e923d6829008..0f79d694cb08 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -958,6 +958,7 @@ static int rxkad_decrypt_ticket(struct rxrpc_connection *conn,
 	struct in_addr addr;
 	unsigned int life;
 	time64_t issue, now;
+	int ret;
 	bool little_endian;
 	u8 *p, *q, *name, *end;
 
@@ -977,8 +978,11 @@ static int rxkad_decrypt_ticket(struct rxrpc_connection *conn,
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


