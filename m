Return-Path: <stable+bounces-245145-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACUZIWuKAWpJcwEAu9opvQ
	(envelope-from <stable+bounces-245145-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:51:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C018F509930
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEAF430488DB
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725A839D6E2;
	Mon, 11 May 2026 07:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="CnMXMawL"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6D39901A
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485416; cv=none; b=sy5iTXOSNqx2/Qb1Qd+SBN0qLB/GLGjcHROcUn3vTRAw1aLB+vwH2/UBrNn7cygnS+G4EdPAdlYF6v7oVpbBBDoezp9CIv7k37MakmwoPDtxmg6vr+Jbfd0LIuVd4AThnZMD4i4UWSGfFnKmY0fJiPxnfcXNkGa1ByGq5BWdqfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485416; c=relaxed/simple;
	bh=tjm3ZEhc35VabzZoFADkw8/QhRvgUHCjDmHFqBejJf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qFZejMbpqwIEt0PgEU063l4N195yAGXDdFMjDTHlFdgiPwszBT/YT3glXxGqLo/J7/6vkiKsWxHX+Teo/08pqIPf6lbYhrhkPHttTlzHeMFIaqWefNDzW1yah6tRrtjplDIpCi3IiAj27Lc34s4inKZG+ev6RflT8l4tLqKsHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=CnMXMawL; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778485362;
	bh=KjdIqJHowoxVpEK7WVFd42JsQdYJl6fMxtjS9qhH7MQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=CnMXMawLg3vbYATUJKU7JFQ40PV69aZBA8D8zUQer1WB3N0ON0lJLKnuHsAS7kqlX
	 KwnZA7xUmnjH85/S5gjwpS+0831cvEU+sGOz9QJzbHKZCB4qMTH6mXowElgEElTeVl
	 RLKAPf7wUV196BieVM1mAhW0FgsJv/ILUriuUqcQ=
X-QQ-mid: zesmtpip2t1778485357te043757f
X-QQ-Originating-IP: 9usmcOnLIzUH4xZHMpLtmursJLIlygSy6CFxM1eyxao=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 May 2026 15:42:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7996480324036906134
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: dhowells@redhat.com,
	guanwentao@uniontech.com,
	imv4bel@gmail.com,
	jiayuan.chen@linux.dev,
	stable@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 6.12.y v3 2/2] rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present
Date: Mon, 11 May 2026 15:41:19 +0800
Message-Id: <20260511074119.60900-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026051132-equity-umbrella-a786@gregkh>
References: <2026051132-equity-umbrella-a786@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NR3PJyWXADsZt0plwt8mq8KHsZDZ0pNB1pqJmKoFHRGxGiCWzaexcJ6Q
	rMPPu/z8Rb8XNsENwDlBwyL6eKm5ZSfAKPRhJ6YGxI+Uw+x3C1+WEnQRObyXHnnFrXwyxNr
	MeO0uwWGyk07/WX8Mt2clUN9e4yCUaSqVX9aDT4fKqyqrJvuNS9/Sdy3ifNJZo9o8HkqeLJ
	TsjSV5miYXKuigaN2yZ20rmRQK61B7OjOianWAvYL86h3m3/F0yqSVOTuLSia9qGgRCEuxU
	AL7nruIkjr7I0v4fpI0BZXt5vHTf9G5a4rM2X1GZVzJC7gGISJ7E1skrSz2eCgK0jJ/TheO
	yP72DRLdJIY0ugSt8SNl/KDlRYVzd3KBzDp9n9+ZsJ9OuH1RlEoAOZaTBAC04WkWkhZAe/C
	7yXR2zXF1HX0RV9PXiM4UcvENObeS/GCZXoAyb92WN0tUAU7wg7gqzNjA7ly0I/yGL9K2lQ
	YfzqDFvZt429WXpGrlJgju1DELRlOgqanMRVyELh2JsJEB+at0xl4iytmDgrJiI8EIP4wiT
	zvFNj6N9BOlIyh3dWCSKnkaM1pFFhpCky0Gll79DrSPVmNw0IMWW4VQALPoKoj7gN9jnYhW
	oDhInYyitEhr6wApvmkMdpXMqUBZDi1EUct9iFmEu66l+c7IayMfGh3Ux3BoXPCG6K4uMsY
	ddiyBJQ1uk0kYv7SO1i7xGZX7KikS0JxxwfPrzx7E8EwXt0mIGbabpK/DGe2AcSrSuaodWG
	wJonBVLNYuY4zTBdfZD00zH338VhHdtRGEz4pEyYG8SGDuDEBi8GofPs+/VSGXshn86G8ms
	7ePjMJ8FIHZ/5wUD7RVJ0lOIzU+XKjg3fS1RKL4bXYo51YODLfAic+mFEumDEZVsgPfFD9Q
	o31u+cnrCg8wZjuUpiWjnCi+N0wJFqlAfdDvUw4rshfTKV58swNubhMenEi+Hv/s5JMBn+C
	IX56fIZUiWmbO/QGUauNiKNBCgi530ZlFHPfmFbchTy/giY7NH7ZAcd6ZLhkMAhWbVVwTey
	nDnZvEFcx6DZft9nIEPaIVb/GxjDXYsX59k1OQNCFZPCMAkLTWeqScOGpnhG2G/ymvrn9Jh
	SMRgQCh+vuuxo0QfySig3XsrUluK//hnuaEj04ucii3Ph4KhJrIsLIRsNHGFj82pgeKmHMJ
	L18CxgXMkUZzfV4=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: C018F509930
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245145-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,uniontech.com,gmail.com,linux.dev,vger.kernel.org,linux-foundation.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,uniontech.com:mid,uniontech.com:dkim,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Action: no action

From: Hyunwoo Kim <imv4bel@gmail.com>

The DATA-packet handler in rxrpc_input_call_event() and the RESPONSE
handler in rxrpc_verify_response() copy the skb to a linear one before
calling into the security ops only when skb_cloned() is true.  An skb
that is not cloned but still carries externally-owned paged fragments
(e.g. SKBFL_SHARED_FRAG set by splice() into a UDP socket via
__ip_append_data, or a chained skb_has_frag_list()) falls through to
the in-place decryption path, which binds the frag pages directly into
the AEAD/skcipher SGL via skb_to_sgvec().

Extend the gate to also unshare when skb_has_frag_list() or
skb_has_shared_frag() is true.  This catches the splice-loopback vector
and other externally-shared frag sources while preserving the
zero-copy fast path for skbs whose frags are kernel-private (e.g. NIC
page_pool RX, GRO).  The OOM/trace handling already in place is reused.

Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit aa54b1d27fe0c2b78e664a34fd0fdf7cd1960d71)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/rxrpc/call_event.c | 4 +++-
 net/rxrpc/conn_event.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 62ddaa129ce5a..fda16b39e8e73 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -347,7 +347,9 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 
 		if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
 		    sp->hdr.securityIndex != 0 &&
-		    skb_cloned(skb)) {
+		    (skb_cloned(skb) ||
+		     skb_has_frag_list(skb) ||
+		     skb_has_shared_frag(skb))) {
 			/* Unshare the packet so that it can be modified for
 			 * in-place decryption.
 			 */
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 6dcfaed1f7485..3a58fb9210383 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -231,7 +231,8 @@ static int rxrpc_verify_response(struct rxrpc_connection *conn,
 {
 	int ret;
 
-	if (skb_cloned(skb)) {
+	if (skb_cloned(skb) || skb_has_frag_list(skb) ||
+	    skb_has_shared_frag(skb)) {
 		/* Copy the packet if shared so that we can do in-place
 		 * decryption.
 		 */
-- 
2.30.2


