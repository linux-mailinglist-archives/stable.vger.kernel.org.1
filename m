Return-Path: <stable+bounces-181266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0341B93005
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03EA3B7AA3
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD64E2F291B;
	Mon, 22 Sep 2025 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NbE7hQ4H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70800311948;
	Mon, 22 Sep 2025 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570104; cv=none; b=I4F35BmLkb5TFEdSvDRaGWVHKdEfNWui0o/KiefyiVsp9YVQFOLkbDPVO4NdMOWrpsMsqsRuSFqu/1EdaNKFZcFQ+WMSC5/7GewHG9fPfbwzrzoWoZ9/2Vkt9QiAJDgvRsZhHOH5Ob8NkWwICf+R883YcCImhFxEq+ZRDXcTblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570104; c=relaxed/simple;
	bh=YRIWjwsEpQeQGW4hDX9ynQPQQDNyChvn6lEL2iwwmK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoMqRgXBnfPp2plP+72JR9NDyLuxTVLfEDb3kpzkHBxg6iTZoC8rQT9AWAKv2Xr0VVFGNDuuHbdrwFXP8La2JgVSk3wo29BRfzKfAUD5AEZaclnxMARE1zFiaqJJw61VzM/43nzxTVwgxHRJ1gTeHfcguu2xgZDYqgoiQGMJXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NbE7hQ4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF017C4CEF5;
	Mon, 22 Sep 2025 19:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570104;
	bh=YRIWjwsEpQeQGW4hDX9ynQPQQDNyChvn6lEL2iwwmK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NbE7hQ4HXGEt/7nlJNHIKzlrtuHzAoVzE+1JpKFrmeFB4fsNJvlqvqLcSR4NxYpH1
	 FT1N6diiCEMqNAB03evdREeTK0xIKD1DsXyND0uZPI2fb7o5AvNhb+ib+mxPn+9RUE
	 Lof6tdT6e6QLBq3pu/j9RLCtHUui7g3E4nb7F0hg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 019/149] rxrpc: Fix unhandled errors in rxgk_verify_packet_integrity()
Date: Mon, 22 Sep 2025 21:28:39 +0200
Message-ID: <20250922192413.363417610@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 64863f4ca4945bdb62ce2b30823f39ea9fe95415 ]

rxgk_verify_packet_integrity() may get more errors than just -EPROTO from
rxgk_verify_mic_skb().  Pretty much anything other than -ENOMEM constitutes
an unrecoverable error.  In the case of -ENOMEM, we can just drop the
packet and wait for a retransmission.

Similar happens with rxgk_decrypt_skb() and its callers.

Fix rxgk_decrypt_skb() or rxgk_verify_mic_skb() to return a greater variety
of abort codes and fix their callers to abort the connection on any error
apart from -ENOMEM.

Also preclear the variables used to hold the abort code returned from
rxgk_decrypt_skb() or rxgk_verify_mic_skb() to eliminate uninitialised
variable warnings.

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lists.infradead.org/pipermail/linux-afs/2025-April/009739.html
Closes: https://lists.infradead.org/pipermail/linux-afs/2025-April/009740.html
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/2038804.1757631496@warthog.procyon.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/rxgk.c        | 18 ++++++++++--------
 net/rxrpc/rxgk_app.c    | 10 ++++++----
 net/rxrpc/rxgk_common.h | 14 ++++++++++++--
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index 1e19c605bcc82..dce5a3d8a964f 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -475,7 +475,7 @@ static int rxgk_verify_packet_integrity(struct rxrpc_call *call,
 	struct krb5_buffer metadata;
 	unsigned int offset = sp->offset, len = sp->len;
 	size_t data_offset = 0, data_len = len;
-	u32 ac;
+	u32 ac = 0;
 	int ret = -ENOMEM;
 
 	_enter("");
@@ -499,9 +499,10 @@ static int rxgk_verify_packet_integrity(struct rxrpc_call *call,
 	ret = rxgk_verify_mic_skb(gk->krb5, gk->rx_Kc, &metadata,
 				  skb, &offset, &len, &ac);
 	kfree(hdr);
-	if (ret == -EPROTO) {
-		rxrpc_abort_eproto(call, skb, ac,
-				   rxgk_abort_1_verify_mic_eproto);
+	if (ret < 0) {
+		if (ret != -ENOMEM)
+			rxrpc_abort_eproto(call, skb, ac,
+					   rxgk_abort_1_verify_mic_eproto);
 	} else {
 		sp->offset = offset;
 		sp->len = len;
@@ -524,15 +525,16 @@ static int rxgk_verify_packet_encrypted(struct rxrpc_call *call,
 	struct rxgk_header hdr;
 	unsigned int offset = sp->offset, len = sp->len;
 	int ret;
-	u32 ac;
+	u32 ac = 0;
 
 	_enter("");
 
 	ret = rxgk_decrypt_skb(gk->krb5, gk->rx_enc, skb, &offset, &len, &ac);
-	if (ret == -EPROTO)
-		rxrpc_abort_eproto(call, skb, ac, rxgk_abort_2_decrypt_eproto);
-	if (ret < 0)
+	if (ret < 0) {
+		if (ret != -ENOMEM)
+			rxrpc_abort_eproto(call, skb, ac, rxgk_abort_2_decrypt_eproto);
 		goto error;
+	}
 
 	if (len < sizeof(hdr)) {
 		ret = rxrpc_abort_eproto(call, skb, RXGK_PACKETSHORT,
diff --git a/net/rxrpc/rxgk_app.c b/net/rxrpc/rxgk_app.c
index b94b77a1c3178..df684b5a85314 100644
--- a/net/rxrpc/rxgk_app.c
+++ b/net/rxrpc/rxgk_app.c
@@ -187,7 +187,7 @@ int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
 	struct key *server_key;
 	unsigned int ticket_offset, ticket_len;
 	u32 kvno, enctype;
-	int ret, ec;
+	int ret, ec = 0;
 
 	struct {
 		__be32 kvno;
@@ -236,9 +236,11 @@ int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
 			       &ticket_offset, &ticket_len, &ec);
 	crypto_free_aead(token_enc);
 	token_enc = NULL;
-	if (ret < 0)
-		return rxrpc_abort_conn(conn, skb, ec, ret,
-					rxgk_abort_resp_tok_dec);
+	if (ret < 0) {
+		if (ret != -ENOMEM)
+			return rxrpc_abort_conn(conn, skb, ec, ret,
+						rxgk_abort_resp_tok_dec);
+	}
 
 	ret = conn->security->default_decode_ticket(conn, skb, ticket_offset,
 						    ticket_len, _key);
diff --git a/net/rxrpc/rxgk_common.h b/net/rxrpc/rxgk_common.h
index 7370a56559853..80164d89e19c0 100644
--- a/net/rxrpc/rxgk_common.h
+++ b/net/rxrpc/rxgk_common.h
@@ -88,11 +88,16 @@ int rxgk_decrypt_skb(const struct krb5_enctype *krb5,
 		*_offset += offset;
 		*_len = len;
 		break;
+	case -EBADMSG: /* Checksum mismatch. */
 	case -EPROTO:
-	case -EBADMSG:
 		*_error_code = RXGK_SEALEDINCON;
 		break;
+	case -EMSGSIZE:
+		*_error_code = RXGK_PACKETSHORT;
+		break;
+	case -ENOPKG: /* Would prefer RXGK_BADETYPE, but not available for YFS. */
 	default:
+		*_error_code = RXGK_INCONSISTENCY;
 		break;
 	}
 
@@ -127,11 +132,16 @@ int rxgk_verify_mic_skb(const struct krb5_enctype *krb5,
 		*_offset += offset;
 		*_len = len;
 		break;
+	case -EBADMSG: /* Checksum mismatch */
 	case -EPROTO:
-	case -EBADMSG:
 		*_error_code = RXGK_SEALEDINCON;
 		break;
+	case -EMSGSIZE:
+		*_error_code = RXGK_PACKETSHORT;
+		break;
+	case -ENOPKG: /* Would prefer RXGK_BADETYPE, but not available for YFS. */
 	default:
+		*_error_code = RXGK_INCONSISTENCY;
 		break;
 	}
 
-- 
2.51.0




