Return-Path: <stable+bounces-211268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COSICJNocmnckQAAu9opvQ
	(envelope-from <stable+bounces-211268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:12:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9C36C1AB
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31556308BA53
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98114374721;
	Thu, 22 Jan 2026 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="hzt6slvP"
X-Original-To: stable@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EFC36D4E2;
	Thu, 22 Jan 2026 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102260; cv=none; b=oaa2xreUCVK5iKCMLSLh+d+GjmYmaO5xOquLCgjNKATRLWm7DltQwo4LGYRWfsj/bMbeK+4RT2mEyc2OHRZs7nLy9GvvLx9jz816NCaprTz4Qu7qEzNTC1ne18iBiDn8SgR+sp9yC4lH3CNyPY7nn556UHYa9qbrg43vDYUYM1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102260; c=relaxed/simple;
	bh=CdNDbKrKi0sLQRDTf5m4+2lDaEM79mJU6UQjQhNWHp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeNVY/CWB9HD6GDw3RwHoVGA3yhPYvpbvyM2bj6zWT6uCr5LnGWkPtgTgvqhu66+gCtjj6lS4fbydZwuhZapNMI7JzPCcSuDnelrVQpAaH3aqD8RLq9ztJo8F8n5ABRGIn8WaP0TZYRpBiYql+9xpxMDrgsS7u6zYbQuYTChW/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=hzt6slvP; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=bvmeilW/ZMqg94/0tjFWHiAg/QLsv3yjkQmwtp7/jLY=; b=hzt6slvPMikFScRsMhjpDKzcM3
	kKmpxyPfcTREKLEDzfuN68uBw+Ma/XUpN0tOOyJEjemeunoRCDO8KKwcYZaVqihO1L0rYDJuEeOQw
	S/7w2OXFLYQeQ32vb/XNtQw05cEgFqVlJd2sqDvDJrd07nBT8Y3rtePQbUWJX1wHtWSy5pQFw0wAL
	HvePNfzkajwGCzs4iBInz2GPlJXBpxlf5WqW2H5sTqBEoYcRKjj/8KuekM/VVkeBEMxMwqOb9jbLf
	vxXfu6tMPn1nlCy+igMfCPaV7OTALSwVw6PcOn1vCuw4eJVvp0bCjt65ScmeGScZDb3NTwc3cv65a
	G37zg7j7dT3jp79z9rVCF1B25xtrU2r/QDesIQPkiiCK/cHp25NjTY5ie/886RVWcUOH8hlRQfrmk
	rKsVOqXSeMtsNI2DiSQRSjGsMM1J9LdE+UgOcFsaaK6Xt3838c/7Sh4u8OpBMdr5qp5XWM5pKlvRU
	gTVAQ7aR38Gr6pRzeNX9IKr6;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1viyJD-00000001pkn-2FAL;
	Thu, 22 Jan 2026 17:17:27 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH v2 03/20] smb: server: make use of smbdirect_socket.recv_io.credits.available
Date: Thu, 22 Jan 2026 18:16:43 +0100
Message-ID: <0a91e6523460654ffc25632968d57c56a0e3af41.1769101771.git.metze@samba.org>
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
	FREEMAIL_CC(0.00)[samba.org,vger.kernel.org,kernel.org,gmail.com,talpey.com];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-211268-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[samba.org:s=42];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[samba.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samba.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.935];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talpey.com:email,samba.org:email,samba.org:dkim,samba.org:mid]
X-Rspamd-Queue-Id: DC9C36C1AB
X-Rspamd-Action: add header
X-Spam: Yes

The logic off managing recv credits by counting posted recv_io and
granted credits is racy.

That's because the peer might already consumed a credit,
but between receiving the incoming recv at the hardware
and processing the completion in the 'recv_done' functions
we likely have a window where we grant credits, which
don't really exist.

So we better have a decicated counter for the
available credits, which will be incremented
when we posted new recv buffers and drained when
we grant the credits to the peer.

This fixes regression Namjae reported with
the 6.18 release.

Fixes: 89b021a72663 ("smb: server: manage recv credits by counting posted recv_io and granted credits")
Cc: <stable@vger.kernel.org> # 6.18.x
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/smb/server/transport_rdma.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 05f008ea51cd..c7abd621bd11 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -1028,6 +1028,8 @@ static void smb_direct_post_recv_credits(struct work_struct *work)
 		}
 	}
 
+	atomic_add(credits, &sc->recv_io.credits.available);
+
 	if (credits)
 		queue_work(sc->workqueue, &sc->idle.immediate_work);
 }
@@ -1074,19 +1076,37 @@ static void send_done(struct ib_cq *cq, struct ib_wc *wc)
 
 static int manage_credits_prior_sending(struct smbdirect_socket *sc)
 {
+	int missing;
+	int available;
 	int new_credits;
 
 	if (atomic_read(&sc->recv_io.credits.count) >= sc->recv_io.credits.target)
 		return 0;
 
-	new_credits = atomic_read(&sc->recv_io.posted.count);
-	if (new_credits == 0)
+	missing = (int)sc->recv_io.credits.target - atomic_read(&sc->recv_io.credits.count);
+	available = atomic_xchg(&sc->recv_io.credits.available, 0);
+	new_credits = (u16)min3(U16_MAX, missing, available);
+	if (new_credits <= 0) {
+		/*
+		 * If credits are available, but not granted
+		 * we need to re-add them again.
+		 */
+		if (available)
+			atomic_add(available, &sc->recv_io.credits.available);
 		return 0;
+	}
 
-	new_credits -= atomic_read(&sc->recv_io.credits.count);
-	if (new_credits <= 0)
-		return 0;
+	if (new_credits < available) {
+		/*
+		 * Readd the remaining available again.
+		 */
+		available -= new_credits;
+		atomic_add(available, &sc->recv_io.credits.available);
+	}
 
+	/*
+	 * Remember we granted the credits
+	 */
 	atomic_add(new_credits, &sc->recv_io.credits.count);
 	return new_credits;
 }
-- 
2.43.0


