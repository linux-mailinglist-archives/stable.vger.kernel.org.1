Return-Path: <stable+bounces-211273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP7yBcRjcmnfjQAAu9opvQ
	(envelope-from <stable+bounces-211273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:52:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFD46BB8F
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7619B316D000
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D167336A026;
	Thu, 22 Jan 2026 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="inCslENd"
X-Original-To: stable@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D834F466;
	Thu, 22 Jan 2026 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102293; cv=none; b=G91zZBE4NfoMlhpl9ZPOxseS5voNgwszLiFbHrMbjQQZgt+mLTOnOcIoQnaSQu2JRDHLSOcteBKIjU13SJ4dWeJbI/Vc5njtSE7X9uzvfQiF8DrE1w9fh8ELPzXiPccIjGoh4qzLa+WRCcoscH5mFcxpoYmFvtVZBDUEnIlJx20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102293; c=relaxed/simple;
	bh=250cL9+9NqqZNgobs8NbfoXmqisn0ETolzUz0eJ/6fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmbecJ8aN3wyv7vBFutJXvetPdvP4wlF0euQ9h0jcG4VPNU8ZkoiHU++NCB2RfwFJ1rQjf6gX6IYs8t528jKwzLhKNB0nO5uJxFGGr9Ax5joL26Tf2QVv0BbcUIg1dh3nO92jZDNbAXEVxU3Jvb9AnKZEiC5sgE2REdox17L1Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=inCslENd; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=Cu3s3UVqlV3jXo4mNPjEzR4+choiioBXbWumx2VvZuw=; b=inCslENdETQKb3AMUImXAp8tyt
	8iJX2pDU3KyJMhSEq1cDmLtIbDFn3octzavQK1OLjl3f8doWv2i3RzwkDw72caStV9d4misoIJFOv
	oDA2faIL3Fz2a8IXPTuMw5rBi/44AOSsAnEKxUatLKQSkSMd+n7NK5PzdIZ8JjmBJIEDx5EXwHlqP
	hoB7XtgAxkR3DOM/Mal27kYMGxkuJJkoIUyDcqo5Q3Q0qJq4GOaPmdIXkYil6d57feju9H7PpZW24
	iG695p5UzV+dxfzevRxwUBEAe9blJxKaccTY8t+ndPer1IFJbENzWvr0nBfTglMAdDi8ubjEDFfo1
	Jp3rnpW+bXD/+/qGkxc1Oh4g58fhCWCR8lr0YNYEvdwnY84nqRdru3XV/NHVmTkiCkKStt/6Zlqvl
	p2Ni4K+pk5eCtm8CVTPf2nueXKzdx+DQhGCRUnlJMvkHd08jXTLzbc0CfwrrEVuwco7g+YRf16IyE
	0ZW/B3W2gJ4BgkXHbG4/Wp0Y;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1viyJl-00000001pof-0weW;
	Thu, 22 Jan 2026 17:18:01 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	stable@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2 09/20] smb: client: let recv_done() queue a refill when the peer is low on credits
Date: Thu, 22 Jan 2026 18:16:49 +0100
Message-ID: <004a666f07d6058731489f9565bcbaab512e76ab.1769101771.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769101771.git.metze@samba.org>
References: <cover.1769101771.git.metze@samba.org>
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
	FREEMAIL_CC(0.00)[samba.org,vger.kernel.org,gmail.com,talpey.com,microsoft.com,kernel.org];
	GREYLIST(0.00)[pass,meta];
	TAGGED_FROM(0.00)[bounces-211273-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[samba.org:s=42];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[samba.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samba.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.927];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talpey.com:email,samba.org:email,samba.org:dkim,samba.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AFFD46BB8F
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
index 6679abbb9797..61693b4a83fc 100644
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


