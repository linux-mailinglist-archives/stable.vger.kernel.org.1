Return-Path: <stable+bounces-216085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHmSEf0rj2kPKwEAu9opvQ
	(envelope-from <stable+bounces-216085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:49:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA8B1367D5
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3680C30027CB
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F9313DBA0;
	Fri, 13 Feb 2026 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AIn2U5mO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F7350A37;
	Fri, 13 Feb 2026 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990583; cv=none; b=iHX97/1GtawQze97C/eTFv2ZK3xfIB28IEwUfDMZcJtphV/d/kheKQ10vbwUOMR740dCFtuz1NFMRTSHp9iPvyOK7J7BG1hsEQft5aprRv3Th1CewJpCwexx8RNp4CfE5vVF/Jhnh7foDGCp4aWYMsdZ5fMgmad41sVwKKiB7kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990583; c=relaxed/simple;
	bh=U6mTZIpwSQC48LPUDLcDQWjtdFTfRC+xvFXEEJQtwec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXT8GBoJ+Bz5KJP7bGxmcIVVjoMmh4bonzJEXq/IzVYzlQE4JPHWoGVjkJusl3Wkc0CtLRCW79nZjfkargRKOw1dYvp2JgOl3Aeo07IfpzGK6bfEY4oCtB3gRBWuQLBtzL01jJvIQwEFs4WbJY6Ws70Bz+pNw6BdDBe6P7iDZJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AIn2U5mO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5003C116C6;
	Fri, 13 Feb 2026 13:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770990583;
	bh=U6mTZIpwSQC48LPUDLcDQWjtdFTfRC+xvFXEEJQtwec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AIn2U5mOa4oJAr2Zb5AhK4jCFgZsDNBlFF0CO32IWNnUH8vQh5nFrHR+j0cwqTSkQ
	 t6xotTTccqLkqvDnc8qHLc2rUfO/oXYRLHNfVH2JC0D/ekWrcrWQIwnOqmvIEtqvUY
	 /EM4dJpOdqTYZe1097wbGY5QtHYMLx10Lc+R+mwA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Stefan Metzmacher <metze@samba.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.19 14/49] smb: client: make use of smbdirect_socket.recv_io.credits.available
Date: Fri, 13 Feb 2026 14:47:33 +0100
Message-ID: <20260213134709.249935700@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213134708.713126210@linuxfoundation.org>
References: <20260213134708.713126210@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216085-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,talpey.com,microsoft.com,kernel.org,vger.kernel.org,lists.samba.org,samba.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samba.org:email,talpey.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: EEA8B1367D5
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Metzmacher <metze@samba.org>

commit 9911b1ed187a770a43950bf51f340ad4b7beecba upstream.

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
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smbdirect.c |   34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -618,6 +618,7 @@ static void smbd_post_send_credits(struc
 	struct smbdirect_recv_io *response;
 	struct smbdirect_socket *sc =
 		container_of(work, struct smbdirect_socket, recv_io.posted.refill_work);
+	int posted = 0;
 
 	if (sc->status != SMBDIRECT_SOCKET_CONNECTED) {
 		return;
@@ -640,9 +641,12 @@ static void smbd_post_send_credits(struc
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
@@ -1033,19 +1037,38 @@ dma_mapping_failed:
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
 
@@ -1217,7 +1240,6 @@ wait_credit:
 	packet->credits_requested = cpu_to_le16(sp->send_credit_target);
 
 	new_credits = manage_credits_prior_sending(sc);
-	atomic_add(new_credits, &sc->recv_io.credits.count);
 	packet->credits_granted = cpu_to_le16(new_credits);
 
 	packet->flags = 0;



