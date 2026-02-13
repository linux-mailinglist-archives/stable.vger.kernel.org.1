Return-Path: <stable+bounces-216104-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PESAjosj2kPKwEAu9opvQ
	(envelope-from <stable+bounces-216104-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:50:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE9B136855
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2007301024B
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E777F35EDAB;
	Fri, 13 Feb 2026 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f9I+Rl5G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BC2175D53;
	Fri, 13 Feb 2026 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990647; cv=none; b=DLqHXG2JERrTD+xuKEnzhucb3ltwbRNgAL0hlDtITGsW5FmV14j/UwQi3Z2TyWU3xgcd19gmwNySbmeVHyDbD5/89XBIASnG/3JdzbLENEjMupjk3762Zauhj/acRd+BszO7QpOvD5RDmRWdt/RbRhEVpPY8MeTchOj5peSYm44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990647; c=relaxed/simple;
	bh=UMnXcL+7bEd++L685MmFVenymT2/8+a6r12+sKxxzmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6XeXAjsFqpB8BUgfLe0Rl5WRYminArS2+OgQ2tBZhgKW6Vb0kXmrRbOsw8fSR7gOt+vf1aFlwQB37TbSg3SME5OPUmS+TxVahLjHatXxYosVqZrLZCvqFB0MComzMpbTn14RoqaY9w2K3Pvmwc7LPVpob8y31uXr7u99lZAYOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f9I+Rl5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30400C116C6;
	Fri, 13 Feb 2026 13:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770990647;
	bh=UMnXcL+7bEd++L685MmFVenymT2/8+a6r12+sKxxzmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9I+Rl5GfrhpRYGb7x8EvsxGQ7i0Im8AFyNNeJ6PWXIXKECpcszCTP/WuLmNR4XVj
	 dWm/MjBfIqwu/M1SQ97AYc+veAjSykp1sF1fYWQiMGzTgImTVM7mBHZcEWfxcyTrw0
	 ALoZLAlYDvnXDZmNXrqwR177caN1cUSa1i/d0eao=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Stefan Metzmacher <metze@samba.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.19 09/49] smb: server: make use of smbdirect_socket.recv_io.credits.available
Date: Fri, 13 Feb 2026 14:47:28 +0100
Message-ID: <20260213134709.067091891@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216104-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,talpey.com,vger.kernel.org,lists.samba.org,samba.org,microsoft.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,talpey.com:email,samba.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: BBE9B136855
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Metzmacher <metze@samba.org>

commit 26ad87a2cfb8c1384620d1693a166ed87303046e upstream.

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
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/transport_rdma.c |   30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -1028,6 +1028,8 @@ static void smb_direct_post_recv_credits
 		}
 	}
 
+	atomic_add(credits, &sc->recv_io.credits.available);
+
 	if (credits)
 		queue_work(sc->workqueue, &sc->idle.immediate_work);
 }
@@ -1074,19 +1076,37 @@ static void send_done(struct ib_cq *cq,
 
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



