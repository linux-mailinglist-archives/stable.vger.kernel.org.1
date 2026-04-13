Return-Path: <stable+bounces-236236-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Hr9CbQa3WknaAkAu9opvQ
	(envelope-from <stable+bounces-236236-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:32:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0963EF35A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C0B931C52D6
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41112877E5;
	Mon, 13 Apr 2026 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YDL6IqHd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E1625332E;
	Mon, 13 Apr 2026 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096393; cv=none; b=Yq6m23zUf29/8uRUV5HfXLKbOyuE2T47VSdUjD/rOTEvCzkg6+yYzf2rgP8vAVCrTv8nzliQfFOWasUdX6NIVVw0gd+rjALvYJOnYMiQpD8ZmnCqyJI9Q0+5eNc+pRSZqoxqt/RKd5HBafZkZbe5sSNuSDDQFO2GJEcmmP47tFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096393; c=relaxed/simple;
	bh=Z8fgruLQ7AiexRUlVxkgarPVYb9y52brBQjrwU2jb+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsAP1tbOFyHmlLoXQDPDHEdBrRKByiDxu0e0GCFhnfQ/8qTAq0AFxKKZqcBJhWXifoxR0+f8kc1iw3zdv9LbS3QvSghZ6VQsqJxZ/DHLxmJtLottnhvNuHGdyRSi1Kokmdi+f9bsWu4FCDVfbHGfDc8Y5onrnT38Co+XXedxnSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YDL6IqHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB641C2BCAF;
	Mon, 13 Apr 2026 16:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096393;
	bh=Z8fgruLQ7AiexRUlVxkgarPVYb9y52brBQjrwU2jb+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDL6IqHd3Q9pC95GLvh6/iDb/NN/YCAaacZp+O+HQ1kWslin8WACR5SD+NCSTyCuc
	 LmS/2e1m+l8JKGs00bIkPc4VcLrAiduDpcwG/OD8cb6MKoGStTV5VIhEMy7KgMNdQe
	 CI2IAe5tcAtrfQXICJlw3uzFw8lQra2PF3AOD1GU=
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
Subject: [PATCH 6.19 81/86] rxrpc: Fix integer overflow in rxgk_verify_response()
Date: Mon, 13 Apr 2026 18:00:28 +0200
Message-ID: <20260413155734.561688890@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236236-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,auristor.com:email]
X-Rspamd-Queue-Id: AA0963EF35A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 699e52180f4231c257821c037ed5c99d5eb0edb8 upstream.

In rxgk_verify_response(), there's a potential integer overflow due to
rounding up token_len before checking it, thereby allowing the length check to
be bypassed.

Fix this by checking the unrounded value against len too (len is limited as
the response must fit in a single UDP packet).

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Closes: https://sashiko.dev/#/patchset/20260401105614.1696001-10-dhowells@redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260408121252.2249051-18-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/rxgk.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -1209,7 +1209,8 @@ static int rxgk_verify_response(struct r
 
 	token_offset	= offset;
 	token_len	= ntohl(rhdr.token_len);
-	if (xdr_round_up(token_len) + sizeof(__be32) > len)
+	if (token_len > len ||
+	    xdr_round_up(token_len) + sizeof(__be32) > len)
 		goto short_packet;
 
 	trace_rxrpc_rx_response(conn, sp->hdr.serial, 0, sp->hdr.cksum, token_len);



