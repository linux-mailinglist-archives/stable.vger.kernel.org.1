Return-Path: <stable+bounces-271802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id is9XGZnGR2p5fAAAu9opvQ
	(envelope-from <stable+bounces-271802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:26:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D5C70363D
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:26:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm3 header.b=Uk1UU94Q;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=ixfGLEG7;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271802-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-271802-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A03D30264C5
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 14:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064CF3DA7DD;
	Fri,  3 Jul 2026 14:21:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4E834D382;
	Fri,  3 Jul 2026 14:21:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088507; cv=none; b=ZWDVp2FwmFFk0oqj+pRWOpsMX9yrhXDvU1rtuyDtVbzu6/zxugJVjN6J6MTfNUgSgF5FP/wIPfmLARTG9k65SJqomkAhjqsiELRJDuKuWurc1aMluGCPmncDr34pG00EShAgmSNSWxOChYUblWOQrrZplwc9gkZEOWEWp4s+gNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088507; c=relaxed/simple;
	bh=ZmUcwKm+KZlq7WK01NO6SHAJ0Ds1ZzGQwUBqhcTvqLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LlSRiNo/05gZS2xJG794Z4R5uNhpFWjEgG1SMsX5vEGES0pWDefF6yaCAg9QKolTuqrBRfmdZikfCCAu7GSlS8AyG3bmboh7/03wruo9WjxA9KBsdeU5xytjd6ZTMc8671znlRY/m0gRUgWnEmhmF+XjbnQVNhrt605mH6DjNEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Uk1UU94Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ixfGLEG7; arc=none smtp.client-ip=103.168.172.149
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 31015EC0101;
	Fri,  3 Jul 2026 10:21:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 03 Jul 2026 10:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1783088503; x=1783174903; bh=ezhtSL7HtG
	xakgLsRNQdK22QsTbck77uvJplT2Hy5Ig=; b=Uk1UU94Qv+hlVzhtf+/wInMJyC
	sYbVCezliz75pUwMKdT77oNF/tQ7Qotp69eI16R0WzlROVtFUlOTPgf43PHCJTdO
	6tHAFExY6b87CsGlwJA5JoFrRtCMWPvSEy/Bq7RxAUHQEul0RTXR53kvIL4ElA5I
	mTdgZhJqSdmjP7KzRW2rZmFLip2C0ymEifSS1mGe91zeJwrGZG74Qgg2/SmTtO3d
	vON6yTHxj+1+5vl7RN1TuoYw8xJT0jnToSS6BOLeOCN5pRSkmcgDva6cT+dD5z94
	FKhkRdKh5hIlRQiEWymifHQOZG6gPHXNYit3Lx63b/ytFsQ7HhynGyM88spQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783088503; x=1783174903; bh=ezhtSL7HtGxakgLsRNQdK22QsTbck77uvJp
	lT2Hy5Ig=; b=ixfGLEG7DIzH9I7dGoS+UsNa2EfRgPOcx+zJbwne3O4k0eWl1PA
	ofPPJZMNIDQhp7XMTzFQUdI9ncJnl5+K92KuG6ERdGAV3iF/M6l48x+Pp5ZppbpN
	anBjKRe+GKr3qWc0V84R6bzqR5fA22Syq2ZmkFYIj4hUjr5ng25SJM/0Z7lw36DD
	ogtFYyaKyOuLDDLxfc4eB92lG7CQPS8iT0q2lN4xuxCJy0LVUdUI1l9vwoQJNbJo
	BZTABBAam2WT3nXqb+55KiIGEeBUvdW712LAnU92hBySDLrhDL4XUz879afinqa9
	ovUiGN1KYr1dA4HuGZBtSYQmNcjjWB2nxsQ==
X-ME-Sender: <xms:dcVHaobJL9paqhZCPoD5yM7ME6ALw2J4IKQmYf8f1vwNhEomd71D4Q>
    <xme:dcVHalo2vc9hz1t8Jou9h2HcWVTdPEY-z8hKhSKECDnr0fr3fLeInsCP2rdEuZhan
    r8FD-_yCad8ntuMvqF-03QvNJ8hCyzrspk7KEAvWZ2B-2tSvSMV7Q>
X-ME-Received: <xmr:dcVHalPcoIRfwhibxrGH5PH8JzwvegrM7Z8XRFhrS9jB_LpRdSUhJC1oN2M>
X-ME-Proxy-Cause: dmFkZTE55wu+goJ+54ULjU+dqcMmSK9JX7q3Vn7pvd4IIGhTmEmsQSvaa60mz4vZKDJO/p
    u2rhjkZfH7OGrOfkEAAEjvTcBQyihQZOWlEf9DlP1guTg6EXI5GB97bwjXsKR0rTXax4/R
    FQCUxSqJqgJjcjkoZKImUUU22pVg5PiViqMG8lrDH8PFaTwHAV/D5dWkOjOu7LOQuH+Iy0
    AQVgrkhgBztJrjKWmGhRPihmQN1wQXHclY6s0ApvFkNa3vbWK1Cn9LcMns1Gu9IoTbV33t
    2QDtWATBLOjJMLJzGocWeBU65FA9NxZcXyqU4h4nhUY2qhQcxJ+qYSORTDWkswCxfX5ZZr
    nKiicGCDjWrYRNidpJ7XRSYohQMSZtR06Oz8BYNWQYxBC001WtPCQG0IoOyo3Nu4H7cPPa
    wx3ps7ZMwtJLBLPrjPT89jHgVfI5mTKhECmUqUOA+mDlRNi1KwSJpCP713HhPhK+N2xJdL
    dRKxeShCvLjwRVT6FC2memB4PKPEBBclC/zjkdnEMhoJ0TaiWYaiIbQaabGieglqdpVRr1
    HnMQdVgO7VXowi4nN2QALGH4RrlX5DMCE4Y+o6K362esWnu8+lA0dJNNntRLJZ5Z0pPxuH
    xMWNjGm36SX4+JRXoXTYMK8EtBrzkNBCwz7kz+Aq4p/Am7tGK/ATVVFkq/Zw
X-ME-Proxy: <xmx:dcVHaorPo6NljBu8OlvSi5eacJWZy3SOdMYQ3LwsUGl6ZJbpjWMR5w>
    <xmx:dcVHaicuIiD2zPByMWOeZWO0aCCLFh-rq1cEXsKcmZoyhdyjchTQeQ>
    <xmx:dcVHamQQRhTxQpqAHgNFRstRLeUQKR2kzMFlKkTBzSJJTQ_jujlHew>
    <xmx:dcVHajYumdzVXcRkqKq81UPmlm3SIUua52sz151C1wZB5XhedQximQ>
    <xmx:d8VHaivjeW9_3TgzYYnoxYyqBDcUL5x_L5NqT579nbJv7TqxCrHhkQAb>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 10:21:41 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>,
	stable@vger.kernel.org,
	zdi-disclosures@trendmicro.com
Subject: [PATCH ipsec] xfrm: espintcp: fix UAF during close
Date: Fri,  3 Jul 2026 16:21:12 +0200
Message-ID: <50e2ab4348eb8177581058f0152394cfae6a8d27.1783071494.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271802-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:sd@queasysnail.net,m:stable@vger.kernel.org,m:zdi-disclosures@trendmicro.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[sd@queasysnail.net,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trendmicro.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,queasysnail.net:from_mime,queasysnail.net:email,queasysnail.net:mid,queasysnail.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5D5C70363D

ZDI reported and analyzed a race condition during close for espintcp
sockets:

    espintcp_close() frees emsg->skb via kfree_skb() without holding
    any socket lock. Concurrently, the xfrm_trans_reinject work queue
    invokes esp_output_tcp_finish() -> espintcp_push_skb() ->
    espintcp_push_msgs() -> skb_send_sock_locked(), which reads the
    same skb as a data source.

Fix this by adding a synchronize_rcu() call after resetting sk_prot,
since esp_output_tcp_finish() runs under RCU and won't use a socket
with sk_prot == &tcp_prot.  Simply taking the socket lock in
espintcp_close() could lead to leaks, if esp_output_tcp_finish()
re-adds an skb in the slot we just freed.

Cc: stable@vger.kernel.org
Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Reported-by: zdi-disclosures@trendmicro.com
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/espintcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 374e1b964438..f09b5dd85db8 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -517,6 +517,8 @@ static void espintcp_close(struct sock *sk, long timeout)
 	sk->sk_prot = &tcp_prot;
 	barrier();
 
+	synchronize_rcu();
+
 	disable_work_sync(&ctx->work);
 	strp_done(&ctx->strp);
 
-- 
2.54.0


