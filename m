Return-Path: <stable+bounces-211165-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GN5I7Jdcmn5iwAAu9opvQ
	(envelope-from <stable+bounces-211165-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:26:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C87AF6B3A1
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7F8686B0C6
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B3C3939D3;
	Wed, 21 Jan 2026 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="Kcj1Xy+D"
X-Original-To: stable@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072E7296BCB;
	Wed, 21 Jan 2026 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025104; cv=none; b=PahaeFXIJneNDmMlN5hRk2ZXQNvGa12kMmaPSD2OZ86p9mNMVnJs0VjASjsvs59jm0pBUiS89NDWKzk9jKdQlH0H03hgQziWnRIjFGJR9ApPzxlja5Ss011lb/yfPzeYAxEzSqVg3BgjHpCjF8qxRKFHOExumTilQCl0Hdo+vXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025104; c=relaxed/simple;
	bh=YKjVdlxgX+k07RFxcJp6qev4ppXt6i2yFYvMHLcm9cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMAhgtfyOFFwy9W3xUNna7syYxeUbKzvCoKNg20AqPmXfH8MWm2R/7keaWbxsBLFU/22zwphmPjK8kuZz0uAxzLwgPGUgLYcV/fjsckVh/4Im5Ip5b/GZgLkLvgNpYQgCHh+nonfyRNtGauJ00XJ4GsyX3XPsBF7/Fi2v72EL6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=Kcj1Xy+D; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=/wzSvU1gIr44MtYwR8Jcfl+CclA6K5KajKRwe3nfuiM=; b=Kcj1Xy+DUKR3fj+MXDf4r5ZkaV
	reYIeym6bG2QLetAZjjQ/fGXeNIebZLKKStJJjsj87A/2s0hckQWkjOMcIhqNX3Sy5tBACkqEKG3C
	VUtXXTm8hVEkEgBpEb9WYusRO92sD/GLFW5jlEfV/xapIucupRnLCE3AnjKA97LUlXRbJEKJVUPDb
	15/kktg6eufmDZTWtfhy/T1rGxs71WBUf+maJWsAdodADke6bDrT6bRGqbQz3baAVrgxHfeLon71S
	uJpZaJmR+TsJf7QtIbNjM0aqNNn+aFfm47943CJHP70AUe/O9wCpLlQTVG+0pIZEI3DqByCXh3pMB
	ee9ry86tuzF8EhJIHG+2EGE78mm5EJfZDgCrzFXHBbp6erEb4uBEOPl/XPboBDtOf8MP/D9FIKZTe
	eOt2uz9JIXCCfonEagJ8bP2xc/u5FQINURPQxJqnisb4j2+axsd8AieUdVHR0zIid8bKLVjERzDyR
	BI+XhdO6DcyEqxb7hmR2Um2N;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vieEt-00000001e3E-204n;
	Wed, 21 Jan 2026 19:51:39 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	stable@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 09/19] smb: client: let recv_done() queue a refill when the peer is low on credits
Date: Wed, 21 Jan 2026 20:50:19 +0100
Message-ID: <d99a54d035d8e0f6b1a6a0eea14b29c6bc2c114d.1769024269.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769024269.git.metze@samba.org>
References: <cover.1769024269.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_SPAM(0.00)[0.892];
	TAGGED_FROM(0.00)[bounces-211165-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[samba.org,vger.kernel.org,gmail.com,talpey.com,microsoft.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	R_DKIM_ALLOW(0.00)[samba.org:s=42];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[samba.org,quarantine];
	DKIM_TRACE(0.00)[samba.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,talpey.com:email,samba.org:email,samba.org:dkim,samba.org:mid]
X-Rspamd-Queue-Id: C87AF6B3A1
X-Rspamd-Action: add header
X-Spam: Yes

In captures I saw that Windows was granting 191 credits in a batch
when its peer posted a lot of messages. We are asking for a
credit target of 255 and 191 is 252*3/4.

So we also use that logic in order to fill the
recv buffers available to the peer.

Fixes: 02548c477a90 ("smb: client: queue post_recv_credits_work also if the peer raises the credit target")
Cc: <stable@vger.kernel.org> # 6.18.x
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 fs/smb/client/smbdirect.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 797dcf6e29bc..826fe7cc6ab6 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -663,6 +663,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		container_of(wc->wr_cqe, struct smbdirect_recv_io, cqe);
 	struct smbdirect_socket *sc = response->socket;
 	struct smbdirect_socket_parameters *sp = &sc->parameters;
+	int current_recv_credits;
 	u16 old_recv_credit_target;
 	u32 data_offset = 0;
 	u32 data_length = 0;
@@ -747,7 +748,8 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		}
 
 		atomic_dec(&sc->recv_io.posted.count);
-		atomic_dec(&sc->recv_io.credits.count);
+		current_recv_credits = atomic_dec_return(&sc->recv_io.credits.count);
+
 		old_recv_credit_target = sc->recv_io.credits.target;
 		sc->recv_io.credits.target =
 			le16_to_cpu(data_transfer->credits_requested);
@@ -783,7 +785,8 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		 * reassembly queue and wake up the reading thread
 		 */
 		if (data_length) {
-			if (sc->recv_io.credits.target > old_recv_credit_target)
+			if (current_recv_credits <= (sc->recv_io.credits.target / 4) ||
+			    sc->recv_io.credits.target > old_recv_credit_target)
 				queue_work(sc->workqueue, &sc->recv_io.posted.refill_work);
 
 			enqueue_reassembly(sc, response, data_length);
-- 
2.43.0


