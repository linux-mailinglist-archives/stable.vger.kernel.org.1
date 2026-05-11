Return-Path: <stable+bounces-245098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBloFupwAWoSZgEAu9opvQ
	(envelope-from <stable+bounces-245098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:02:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DEB5085C7
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B575E30028B7
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 06:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62623377EA7;
	Mon, 11 May 2026 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oyK5Rc63"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E217352C52
	for <stable@vger.kernel.org>; Mon, 11 May 2026 06:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778479333; cv=none; b=UXQTQw/De5xhINM1X5HMvwLbgi4j48x7FasnrPBmSMp614lB3Qul7wjvdDKMy7MbmOKwxuYx9hRM2StUqDqScNsbTA7tMee+Y44jk+wUFUgXmbbDQ/iFGtwBQTbkK7w9Wm5gCkQDNAgwCRRzMkS8HYfACPFrQIQpVky7hVzuGiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778479333; c=relaxed/simple;
	bh=ZcuqRPQ78FNR2pVqAoiBnXJPFJEaRr1Gp8wk6ku7kmw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I50OThYwJP3s8EfrJ3ZBLVX2nyNwu8JxXmLCONJtU1bgEcEhA/88M4V4pPJP+Md2XAR/OCmE/kMW0Xe0u4dkvbbEy7bgSkx4uNcmv0H4RSbeduuad3Gea9b+kZg4/piGKTjEOY2j6I2arWhtlC/Ho0XZCrBLxXmAJ+ztzOotDE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oyK5Rc63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EF7C2BCB0;
	Mon, 11 May 2026 06:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778479332;
	bh=ZcuqRPQ78FNR2pVqAoiBnXJPFJEaRr1Gp8wk6ku7kmw=;
	h=Subject:To:Cc:From:Date:From;
	b=oyK5Rc63JJk2MxgReT2CcV5RcJkPECa+GTiudLtkAnyy6dbstCVD7zSmunatUh3dJ
	 PPM+LThyOb1j+hdgv+4NBvA68YjKCXiisYrsaQemSk36YASEQseUjNYR85hwISq5ft
	 Fa9yOd+31T90jDG5QLRuo3vtwgfONzaevSH0GESw=
Subject: FAILED: patch "[PATCH] rxrpc: Also unshare DATA/RESPONSE packets when paged frags" failed to apply to 6.12-stable tree
To: imv4bel@gmail.com,dhowells@redhat.com,jiayuan.chen@linux.dev,torvalds@linux-foundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 May 2026 08:02:09 +0200
Message-ID: <2026051109-ocelot-dwindle-a7e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C5DEB5085C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245098-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,linux.dev,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,linux-foundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x aa54b1d27fe0c2b78e664a34fd0fdf7cd1960d71
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051109-ocelot-dwindle-a7e9@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aa54b1d27fe0c2b78e664a34fd0fdf7cd1960d71 Mon Sep 17 00:00:00 2001
From: Hyunwoo Kim <imv4bel@gmail.com>
Date: Fri, 8 May 2026 17:53:09 +0900
Subject: [PATCH] rxrpc: Also unshare DATA/RESPONSE packets when paged frags
 are present

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

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index fdd683261226..2b19b252225e 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -334,7 +334,9 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 
 			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
 			    sp->hdr.securityIndex != 0 &&
-			    skb_cloned(skb)) {
+			    (skb_cloned(skb) ||
+			     skb_has_frag_list(skb) ||
+			     skb_has_shared_frag(skb))) {
 				/* Unshare the packet so that it can be
 				 * modified by in-place decryption.
 				 */
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index a2130d25aaa9..442414d90ba1 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -245,7 +245,8 @@ static int rxrpc_verify_response(struct rxrpc_connection *conn,
 {
 	int ret;
 
-	if (skb_cloned(skb)) {
+	if (skb_cloned(skb) || skb_has_frag_list(skb) ||
+	    skb_has_shared_frag(skb)) {
 		/* Copy the packet if shared so that we can do in-place
 		 * decryption.
 		 */


