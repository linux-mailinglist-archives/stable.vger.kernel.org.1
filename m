Return-Path: <stable+bounces-211164-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGHEDp9NcmnpfAAAu9opvQ
	(envelope-from <stable+bounces-211164-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:17:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE1169BB3
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 434BF7CB6C3
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA35A22A4CC;
	Wed, 21 Jan 2026 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="zknGOleK"
X-Original-To: stable@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559483559C0;
	Wed, 21 Jan 2026 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025099; cv=none; b=oR+hmcuLAjvpzCaRkCeVDKsG6w+cLQeotU6Dlc27Kioxjx1xrYNmjsH579ecoYQaxKI4pAnyRkMCMXZHB9i7Yh9n8zUBpk7ZgqsXE4pLZp/1UYy+qqjtZo1aFi5/b5sciUx8ts4LjtTdUHC7DLA+ZRY9rmSH3vPbJRtJqMI3eug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025099; c=relaxed/simple;
	bh=RWRnY+JXM5hHAHQ5p79HU+WYD5c1l5YTQJfLiDRFyZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwX63Q/iup6Y7HMO1zRowZqJTl7nWLH8cdJMSx+4HwWbPMAD7qNz6OzL6yN9UNUrRsPOo9NxKtoqE4dBwsQla0CloxK7csjJwxfibqhZIcalRtJ+Y05ef2IUPkPgCWY/t7nvcl63TZnlhIAu4Y/wYCCYzUqV/Sighs9wJSvA+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=zknGOleK; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=WSi2/gBepakiiWLY235b06t5y1YAqf6bIL7yh21lHSA=; b=zknGOleKHEaAqW+A9q8rfokr7W
	bRMX0gLWYZhZ1A3NRjARs4+MRP0MatSfT48Ys4WFPkGH1ex0AjdG2x9JEg4blpohuj7hUX0G+OQxJ
	rn8DM2abRFq1Rbxh8b6758JMTsCWcMOnTRiOT/YCcNNp+7pI9sXsO3XJwg8EwkW3uHypZjrbBrrny
	zmbQLFO18QTfJxBeQP6ch+ek5kgruRulRG/dA/NGBzl0ZKb/iZKXDy6HHNGN8KgaIucuu3RXvOPR6
	vA+fkVeY1bqZbHc/74KJ+nPQ5MeTZIr39igLYoIH4S7zW79m6wuk5KQcGZAkvdVV/vfAoTgVR4S2t
	b29bBlF42lV8kYAHzs+hWlHiO62K9jnvdWEkCS97Tk/eO8yNfcVmLB/Z6LYXSEpM3CaSkLg0QUJk3
	S7hXziqoCT9YYQlfBTSmNjpIJjgeNR0sfLDEB2PHghi6/AgsDI7B8CFysNLFXhe6V6ks2KPZQVlUE
	bmHbbdFQGggojxSUHy+zqA3x;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vieEn-00000001e1T-2mL5;
	Wed, 21 Jan 2026 19:51:33 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	stable@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 08/19] smb: client: make use of smbdirect_socket.recv_io.credits.available
Date: Wed, 21 Jan 2026 20:50:18 +0100
Message-ID: <1172be6e0dbefae7211b68ec57cfc9ac25b8044e.1769024269.git.metze@samba.org>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[samba.org,vger.kernel.org,gmail.com,talpey.com,microsoft.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-211164-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[samba.org:s=42];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[samba.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samba.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,samba.org:email,samba.org:dkim,samba.org:mid,talpey.com:email]
X-Rspamd-Queue-Id: 1FE1169BB3
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

Fixes: 5fb9b459b368 ("smb: client: count the number of posted recv_io messages in order to calculated credits")
Cc: <stable@vger.kernel.org> # 6.18.x
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 fs/smb/client/smbdirect.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 788a0670c4a8..797dcf6e29bc 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -618,6 +618,7 @@ static void smbd_post_send_credits(struct work_struct *work)
 	struct smbdirect_recv_io *response;
 	struct smbdirect_socket *sc =
 		container_of(work, struct smbdirect_socket, recv_io.posted.refill_work);
+	int posted = 0;
 
 	if (sc->status != SMBDIRECT_SOCKET_CONNECTED) {
 		return;
@@ -640,9 +641,12 @@ static void smbd_post_send_credits(struct work_struct *work)
 			}
 
 			atomic_inc(&sc->recv_io.posted.count);
+			posted += 1;
 		}
 	}
 
+	atomic_add(posted, &sc->recv_io.credits.available);
+
 	/* Promptly send an immediate packet as defined in [MS-SMBD] 3.1.1.1 */
 	if (atomic_read(&sc->recv_io.credits.count) <
 		sc->recv_io.credits.target - 1) {
@@ -1033,19 +1037,38 @@ static int smbd_post_send_negotiate_req(struct smbdirect_socket *sc)
  */
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
+	atomic_add(new_credits, &sc->recv_io.credits.count);
 	return new_credits;
 }
 
-- 
2.43.0


