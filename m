Return-Path: <stable+bounces-243837-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLz3C/Wx+GkdzAIAu9opvQ
	(envelope-from <stable+bounces-243837-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:49:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FA34C00D2
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03B313056707
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22F13E1218;
	Mon,  4 May 2026 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g5ah2ucm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61533E120B;
	Mon,  4 May 2026 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904904; cv=none; b=QFSmO+hQV3lhJ7CahrmuMczzpbZQhEpfjws7wwII4IiPC110lzdpjHfRCKAB8gdo/hZssKP9SrYj3s2zG1I6f+Y4MlqwXTbZjVgoV1GAG47fIcGL33wnShdZW1sVqkJMknhGq8IHoiEE6mzrn9+0D7zwYnqZdoLgRI/Rb6iu2Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904904; c=relaxed/simple;
	bh=kig43vlusBNRlL7u35hRa+8p40lBjzU4S59sUJTQZmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcwZkj+Ie2GbbOZ9vyv0n77u9UC4HtfpqL5Bg3A28FiMVnLyITSdxWdmCivyhGcXKMkxgaWO02NDITqwLeAjL4l8eqjxNuQjGkOjd2VKWDMzRgVOKGcbRdyoj5O33iNAwLLFLPTOwszcIBFUSJRrzLduA2TftjCgumP/Yxv/1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g5ah2ucm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346DEC2BCB8;
	Mon,  4 May 2026 14:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904904;
	bh=kig43vlusBNRlL7u35hRa+8p40lBjzU4S59sUJTQZmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5ah2ucm9e50NqI7qpCxrfo43QiQQf//LEdNN7Ynm/WjaO54eNXyNe08pPkPyvmAa
	 FtE9Jwl8Pf2fXyl2R8QbrKw/7+aaTJHUY18v/WrBtZfrtHz3USHGhcm/crTYIp54RO
	 3P2JvV3Y7aZZa3ewV4WoGOVnZdjYg4pfHLpbK9gQ=
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
Subject: [PATCH 6.12 210/215] rxrpc: Fix rxrpc_input_call_event() to only unshare DATA packets
Date: Mon,  4 May 2026 15:53:49 +0200
Message-ID: <20260504135138.492578592@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 73FA34C00D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243837-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,infradead.org:email,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,auristor.com:email]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 55b2984c96c37f909bbfe8851f13152693951382 upstream.

Fix rxrpc_input_call_event() to only unshare DATA packets and not ACK,
ABORT, etc..

And with that, rxrpc_input_packet() doesn't need to take a pointer to the
pointer to the packet, so change that to just a pointer.

Fixes: 1f2740150f90 ("rxrpc: Fix potential UAF after skb_unshare() failure")
Closes: https://sashiko.dev/#/patchset/20260422161438.2593376-4-dhowells@redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260423200909.3049438-2-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/call_event.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -345,7 +345,8 @@ bool rxrpc_input_call_event(struct rxrpc
 	if (skb) {
 		struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 
-		if (sp->hdr.securityIndex != 0 &&
+		if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
+		    sp->hdr.securityIndex != 0 &&
 		    skb_cloned(skb)) {
 			/* Unshare the packet so that it can be modified for
 			 * in-place decryption.



