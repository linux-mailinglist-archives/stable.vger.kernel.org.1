Return-Path: <stable+bounces-243450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHSOGJGp+Gm6xgIAu9opvQ
	(envelope-from <stable+bounces-243450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:13:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8E84BED89
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4202F30387BF
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B767F3CF664;
	Mon,  4 May 2026 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tv0g2QQm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8253B19D1;
	Mon,  4 May 2026 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903915; cv=none; b=mnIMpG1A5MXU2j2gLZRFUBtJk8AQvgs9+H0kNh5TkU8QgzLTqNNUGYB+CTrcapIiHRVV6yxeskk3uyvGKfSgWHoaN9+RJpRhgrrZSDfKXbEWW6sKt9TNm4TAkqvzSg2J2Qk0607ba0YUltpehrAonwwMdSJLM2IwA1tIP1e1/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903915; c=relaxed/simple;
	bh=NcZGgN+Z58Nl4nske0FSyCmvBp7T4+NQ1I72lz+pIf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2HkngdL0U0RmrjR/uLH7ViiCInJjkobOS7G4RmSVi6AItIibwNJSfE2gucnGOZ5i9+q8fBPhzPMgm5trkRYBn6bKn+amX4C0g2U1+spIOIq25u5brfwNGMuFNP8wUaeISj0f/Rl5ppMA/PNKq5723t1R7Zd95EbVqbGRiFN7Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tv0g2QQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10601C2BCB8;
	Mon,  4 May 2026 14:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903915;
	bh=NcZGgN+Z58Nl4nske0FSyCmvBp7T4+NQ1I72lz+pIf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tv0g2QQmOG8HirauYa/OyKJs5ICkWkm7ntD5ZoviOnK7pTheogy6N36BHGigh45ZG
	 b5vu7coBL/npjm5pDfUdxKeRz0V826uB8SsD/QKDISWHZnGNd/JDtpXR0lDo64WceU
	 npRGyEG1z/kutNlLbuAChGkRAE5ZvV9Hb2qujzXU=
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
Subject: [PATCH 6.18 111/275] rxrpc: Fix rxkad crypto unalignment handling
Date: Mon,  4 May 2026 15:50:51 +0200
Message-ID: <20260504135147.034839193@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 0C8E84BED89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243450-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,msgid.link:url,sashiko.dev:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,auristor.com:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit def304aae2edf321d2671fd6ca766a93c21f877e upstream.

Fix handling of a packet with a misaligned crypto length.  Also handle
non-ENOMEM errors from decryption by aborting.  Further, remove the
WARN_ON_ONCE() so that it can't be remotely triggered (a trace line can
still be emitted).

Fixes: f93af41b9f5f ("rxrpc: Fix missing error checks for rxkad encryption/decryption failure")
Closes: https://sashiko.dev/#/patchset/20260408121252.2249051-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260422161438.2593376-3-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/trace/events/rxrpc.h |    1 +
 net/rxrpc/rxkad.c            |    9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -37,6 +37,7 @@
 	EM(rxkad_abort_1_short_encdata,		"rxkad1-short-encdata")	\
 	EM(rxkad_abort_1_short_header,		"rxkad1-short-hdr")	\
 	EM(rxkad_abort_2_short_check,		"rxkad2-short-check")	\
+	EM(rxkad_abort_2_crypto_unaligned,	"rxkad2-crypto-unaligned") \
 	EM(rxkad_abort_2_short_data,		"rxkad2-short-data")	\
 	EM(rxkad_abort_2_short_header,		"rxkad2-short-hdr")	\
 	EM(rxkad_abort_2_short_len,		"rxkad2-short-len")	\
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -510,6 +510,9 @@ static int rxkad_verify_packet_2(struct
 		return rxrpc_abort_eproto(call, skb, RXKADSEALEDINCON,
 					  rxkad_abort_2_short_header);
 
+	/* Don't let the crypto algo see a misaligned length. */
+	sp->len = round_down(sp->len, 8);
+
 	/* Decrypt the skbuff in-place.  TODO: We really want to decrypt
 	 * directly into the target buffer.
 	 */
@@ -543,8 +546,10 @@ static int rxkad_verify_packet_2(struct
 	if (sg != _sg)
 		kfree(sg);
 	if (ret < 0) {
-		WARN_ON_ONCE(ret != -ENOMEM);
-		return ret;
+		if (ret == -ENOMEM)
+			return ret;
+		return rxrpc_abort_eproto(call, skb, RXKADSEALEDINCON,
+					  rxkad_abort_2_crypto_unaligned);
 	}
 
 	/* Extract the decrypted packet length */



