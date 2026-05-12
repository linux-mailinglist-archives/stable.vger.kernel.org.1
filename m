Return-Path: <stable+bounces-245823-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM/eIPtOA2r63gEAu9opvQ
	(envelope-from <stable+bounces-245823-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:02:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BFC524466
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BD9130B03A7
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DFC390601;
	Tue, 12 May 2026 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="YP5wdFNK"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC861E492D
	for <stable@vger.kernel.org>; Tue, 12 May 2026 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599503; cv=none; b=au8Elmcc2+TIE34PiQEyeyOfXwA/DF+QaT4Mtqiy3CiFjQjooEwDtXI6leDWF6MJvUhAOY4YdKENFInQ7at4XOrI2gMWraWlUsURIgIqLjBQXdi13E3brotX6cV3s1sBkLHkBrX7G70HvFnpTxiwLV1cFlmxuxnAabJorLtfm5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599503; c=relaxed/simple;
	bh=quxPGs9nzfnwYzvHhlGTKV1dPXCu/5sBJrYGsmupLS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bX5c3ZdSlgQbqQolLC6h6B86vjnd5sdoM283rixf8qQMZDQ9caOdjuEPbco4bVbUg4IreRnAT3nDQWnrBnH8xna4IfWSPcDFq7DWdMWL1DCdm09SBV1YSYv4FHTl1ZqKqd3QFvQcWfC4HUto8d6dPkUvFCWlRKINq/+gDfnoc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=YP5wdFNK; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778599435;
	bh=CmMW71TcGznMQd1FUH7r+qTpc8wT8PJeTCg1K5xQzN0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=YP5wdFNK9/iE9NwfVv6mMO2iBkK/Xpm/UeSxX8nWr/02U6psf/we/XjTTZsnvMDtz
	 FoFDvog9zi0tdEJl/J9+ENtN9k50dYFd4H0UxUCSpC0Ddhr+jwGENnnepidlqodHmK
	 WyLViX/WptyO0Aue5Nq2TUpn7vJBKuW41JdVJ4Y0=
X-QQ-mid: zesmtpip4t1778599430t016fe8a8
X-QQ-Originating-IP: huR6NJh4jYD4rEg+XI7X9vmhB1m7yOQQ0XblAWBOjMs=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 May 2026 23:23:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3217761544997056761
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: dhowells@redhat.com,
	imv4bel@gmail.com,
	jiayuan.chen@linux.dev,
	stable@vger.kernel.org,
	torvalds@linux-foundation.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y 2/2] rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present
Date: Tue, 12 May 2026 23:22:31 +0800
Message-Id: <20260512152231.91032-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026051113-sponge-uproar-1d30@gregkh>
References: <2026051113-sponge-uproar-1d30@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MMZ4zjFo82kXLYy0GRYsFWy3rWWAQJMXwsgP2WDHKA+v5dTRVQgGz3Ar
	G0NP9Rd1AYkQ3ru6P0n7Dnk6kn9k4KhdaJI8K6dzbRlFih4jUkqS+oq/QHyWdRzf/lfZF7C
	vaMq4oJrrzc0J419ywkLqKMNHEpLC3O7mutUeWFC9BW4bSVxdFVOUzVLVQscXsXzS2sDLG+
	yRH+W6a0vvpnDsMsOg8D66UtykfVUhpStAOlJzi0A2ucCB/k2ctZ3eqVz7v2v2u33ZsQ/L7
	poeCtRJanRysm2wTreoaVHKuRqRwgZoBABjspsEpmO4GJNJE5g7CFKM//UBXuRFuaF8YBXu
	1Cb8gY5IVRi7Ynd3PiO9AcL1VqGHQTys50h4VbVQZFpGY7KYn+HKV1/XA0qo2VdUXf6y6t3
	oFymmHykPWHyKAdm3T1EDZkr6HP9DjzovrMhjcEc2OLv2EY5pKeCSRNLYEX6x/3aF0rmSDx
	tuZ6bo9QZl8DgPLLumD9+bqD2VDbeRt6GCQFkAzpEuID1s0y6Hq1r4n/ZKOhMh8C9cqkBwx
	zOnyNWWCxu0wd1CriA/LwgnHjEM4BRX9EeSNNttTjiIp9ac4jIEmGusI/h9WotLi3uIYDhi
	DvbGGtdxAPt/2YIGhgva+702a5+u4m6lOdUSY6vVabFgFs+MSqwM1vLQNgGWJMnXd0rvhg7
	2ZeY+47SFdSiuW5915pauctBQUfsvmvRN2AUGtpK9nWmnuCX7ByB0gaIxwsBVioDt3bzond
	yqvWg+VbWcnvtsxqo/An3A1uBbFFS0zDBER7DPoY2DIIhTW8LL+QQUKDA8ONM5Fb1wyKqJs
	NEdj2HVHjbdb/QaXkJUKguqJA6vWt4ouavsgrYy1wty+mP9/paVCiK6EdvWoUbf9c57rTTf
	mtIctgSazemsL9oigFErBlSYPrM7tQM3OjaS6RQmZNi/kHa/NKmDQsPmT0QkMDzXOXitG2Z
	xGLEhy7BBS2JIieSVwITCUE+QcA0RaiQWLKRwjowzbD8BingH2ntuhyZ3wZIpP8o0PBzBQy
	OiY9JOC2rDS5afC+Yb+XuSEPszVD4EHDpYWume58pzE96tbtP0G6HzmnEbBi4=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 02BFC524466
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.dev,vger.kernel.org,linux-foundation.org,uniontech.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245823-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email]
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
index d6dfc7c08cf04..07b2d81145d62 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -461,7 +461,9 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 
 		if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
 		    sp->hdr.securityIndex != 0 &&
-		    skb_cloned(skb)) {
+		    (skb_cloned(skb) ||
+		     skb_has_frag_list(skb) ||
+		     skb_has_shared_frag(skb))) {
 			/* Unshare the packet so that it can be modified by
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


