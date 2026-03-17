Return-Path: <stable+bounces-226563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BuHHp6KuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:08:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F29CF2AF078
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CB30304A904
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2E63F54C2;
	Tue, 17 Mar 2026 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fEYYTU6q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27C83E8C49;
	Tue, 17 Mar 2026 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767243; cv=none; b=Woc1B6sfLrwFlczDXKc5BKLLEWsZ48taCGKzJXE1sR8YHO6eH8AlyFk05rw6fD9XzrqHTxcu6tkyLZU+BQY4lBf3ef8U4SLvuawz/OqxMF/88We9oRcsDHDYyjTxQfEk5mIYp9fqXe6GSzPqrMZ4va6zyr/WqUAxFzQJq8uTeic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767243; c=relaxed/simple;
	bh=bPR/DQl0BJCScCrLah9+5RjxQlTmDIjd51TP1a4WCac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hC5W8sbB1F+VEj3tkehicMAj5M6T7vVp+RHMqgi/BgTCs+h7+WoHZ9VqMzcVP8mkf688J8ZQ1eMvOI5WBNBoH1GCmrOzRBohtWNNoKNFlAxkHnX0/UsStAmTyrf/pLzD11NNnlBQreG4+/Bs2qkuOEsaUuwT1Sj/R9++qPsHGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fEYYTU6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F47C4CEF7;
	Tue, 17 Mar 2026 17:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767243;
	bh=bPR/DQl0BJCScCrLah9+5RjxQlTmDIjd51TP1a4WCac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fEYYTU6qloQEkXwB8R2s7NaZMlZlNwcf7FwVMXZeedHFzJ9oplSA/GMoxZkC2y9ob
	 hXJ2+/94A3o2vBPTmLcqXuiD9DiE+U1Vmp81IY16sniEvj35CAV8YqDb59SoIBt5QU
	 EZpZffLKXM8N823KsSOy3wLSYbUosWGSYzW0uWFY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miaoqian Lin <linmq006@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 046/333] rxrpc, afs: Fix missing error pointer check after rxrpc_kernel_lookup_peer()
Date: Tue, 17 Mar 2026 17:31:15 +0100
Message-ID: <20260317163001.073712937@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com,auristor.com,kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-226563-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,infradead.org:email,auristor.com:email]
X-Rspamd-Queue-Id: F29CF2AF078
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 4245a79003adf30e67f8e9060915bd05cb31d142 ]

rxrpc_kernel_lookup_peer() can also return error pointers in addition to
NULL, so just checking for NULL is not sufficient.

Fix this by:

 (1) Changing rxrpc_kernel_lookup_peer() to return -ENOMEM rather than NULL
     on allocation failure.

 (2) Making the callers in afs use IS_ERR() and PTR_ERR() to pass on the
     error code returned.

Fixes: 72904d7b9bfb ("rxrpc, afs: Allow afs to pin rxrpc_peer objects")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Co-developed-by: David Howells <dhowells@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
Link: https://patch.msgid.link/368272.1772713861@warthog.procyon.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/addr_list.c   | 8 ++++----
 net/rxrpc/af_rxrpc.c | 8 +++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index e941da5b6dd92..b1704de3d95f5 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -298,8 +298,8 @@ int afs_merge_fs_addr4(struct afs_net *net, struct afs_addr_list *alist,
 	srx.transport.sin.sin_addr.s_addr = xdr;
 
 	peer = rxrpc_kernel_lookup_peer(net->socket, &srx, GFP_KERNEL);
-	if (!peer)
-		return -ENOMEM;
+	if (IS_ERR(peer))
+		return PTR_ERR(peer);
 
 	for (i = 0; i < alist->nr_ipv4; i++) {
 		if (peer == alist->addrs[i].peer) {
@@ -342,8 +342,8 @@ int afs_merge_fs_addr6(struct afs_net *net, struct afs_addr_list *alist,
 	memcpy(&srx.transport.sin6.sin6_addr, xdr, 16);
 
 	peer = rxrpc_kernel_lookup_peer(net->socket, &srx, GFP_KERNEL);
-	if (!peer)
-		return -ENOMEM;
+	if (IS_ERR(peer))
+		return PTR_ERR(peer);
 
 	for (i = alist->nr_ipv4; i < alist->nr_addrs; i++) {
 		if (peer == alist->addrs[i].peer) {
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 36df0274d7b74..d369e37525388 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -267,12 +267,13 @@ static int rxrpc_listen(struct socket *sock, int backlog)
  * Lookup or create a remote transport endpoint record for the specified
  * address.
  *
- * Return: The peer record found with a reference, %NULL if no record is found
- * or a negative error code if the address is invalid or unsupported.
+ * Return: The peer record found with a reference or a negative error code if
+ * the address is invalid or unsupported.
  */
 struct rxrpc_peer *rxrpc_kernel_lookup_peer(struct socket *sock,
 					    struct sockaddr_rxrpc *srx, gfp_t gfp)
 {
+	struct rxrpc_peer *peer;
 	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
 	int ret;
 
@@ -280,7 +281,8 @@ struct rxrpc_peer *rxrpc_kernel_lookup_peer(struct socket *sock,
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	return rxrpc_lookup_peer(rx->local, srx, gfp);
+	peer = rxrpc_lookup_peer(rx->local, srx, gfp);
+	return peer ?: ERR_PTR(-ENOMEM);
 }
 EXPORT_SYMBOL(rxrpc_kernel_lookup_peer);
 
-- 
2.51.0




