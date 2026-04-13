Return-Path: <stable+bounces-236238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ8CBWUW3WmXZwkAu9opvQ
	(envelope-from <stable+bounces-236238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:14:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1DA3EE7D6
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A2A330C0CAE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50B9274B5F;
	Mon, 13 Apr 2026 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vv46Rjsu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8873626E6F8;
	Mon, 13 Apr 2026 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096398; cv=none; b=HO37mbnrIU89u05UeJPt7N9swyLNzIiLzP0klKb+RlocWyqklgX0LzNgaLrFIiXTmjZIBa5oHrhGeEbiYTPXjKiYv7ujy6mSkT1xNEM4jzg9teY3SMPD2TWKsuKZvB3yTEXgtfpgTpswjh7fDA44bjsA31JG1vBJubLQ93Z7DW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096398; c=relaxed/simple;
	bh=hRrIj5q9saMqCgV11scxZdcDaAckJ/qF9ieaHgaL0Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SU8KI+KS1teqAKqXhI55pOUDXDAYFokvII8++fYVCXQy/Me8N8IoKin1F1sP+WL3kFGaY8reCAIuqBQYk2C9Y7D6xfAKq8sZ9tlTeQUQkvzoHlBYbFbnDurhoAPdh0whFahqdQuksQPJm+1zwDHnITViO0R2BWkH99ozbK9NHjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vv46Rjsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95FEC2BCAF;
	Mon, 13 Apr 2026 16:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096398;
	bh=hRrIj5q9saMqCgV11scxZdcDaAckJ/qF9ieaHgaL0Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vv46Rjsuwv8lwaHtV/vxbrGm8Y/ildldbyOikkcj2hhYgv86yRqh9dzM/RGp9RKJX
	 f7BhI9ACjcpJrh1UOWSs0hWfchaovIwyJyZQMoZS2mvBdnZNAYUmxRRc9GqpLqxo3T
	 3vTXyLZ4s3ClxxY/JaSVPb8R8UrtyN2dTyTWYmdo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.19 83/86] rxrpc: Fix buffer overread in rxgk_do_verify_authenticator()
Date: Mon, 13 Apr 2026 18:00:30 +0200
Message-ID: <20260413155734.641701403@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
References: <20260413155731.568515178@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236238-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,auristor.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: BB1DA3EE7D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit f564af387c8c28238f8ebc13314c589d7ba8475d upstream.

Fix rxgk_do_verify_authenticator() to check the buffer size before checking
the nonce.

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Closes: https://sashiko.dev/#/patchset/20260401105614.1696001-10-dhowells@redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260408121252.2249051-20-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/rxgk.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -1085,6 +1085,9 @@ static int rxgk_do_verify_authenticator(
 
 	_enter("");
 
+	if ((end - p) * sizeof(__be32) < 24)
+		return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
+					rxgk_abort_resp_short_auth);
 	if (memcmp(p, conn->rxgk.nonce, 20) != 0)
 		return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
 					rxgk_abort_resp_bad_nonce);
@@ -1098,7 +1101,7 @@ static int rxgk_do_verify_authenticator(
 	p += xdr_round_up(app_len) / sizeof(__be32);
 	if (end - p < 4)
 		return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
-					rxgk_abort_resp_short_applen);
+					rxgk_abort_resp_short_auth);
 
 	level	= ntohl(*p++);
 	epoch	= ntohl(*p++);



