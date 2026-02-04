Return-Path: <stable+bounces-213721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOjwMtBfg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:03:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CEAE7D43
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D891301AA91
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CB027F163;
	Wed,  4 Feb 2026 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WgvNIIh/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3C1285404;
	Wed,  4 Feb 2026 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217285; cv=none; b=ZbZ8ABJefZV0POE5BMh6EyB5Uxw2UGoQIcEGjMCyLcIUm0+cJlF7zESdL7xL5J9r6ylYCm7naxSLsrL1I+Ed8MhN+JP30F3QehBwQgiyWQvNFZlenOdK4Sh84hjz6ZMEHgUKyRxRmT7goJbFnO3k2GeR3JcqkyRqzkk9cCsjQEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217285; c=relaxed/simple;
	bh=PbmeEVhJLWXSR8RIhrPZa0gArUN8jK7rRuF5RbqMULs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngun3wc20lSyUroPvIEX2UaVneViGm229+Tlj4L8MGl+aCWNvOSPqnIwjGzpXAALY/6tzftkQeYOvm1Z6Ptx3r91G20WPZ0T74C8aqxf3KXe/Ca1ukqkgX30dDGXZiIgsWegtRj/OwLi928nHV2MM9+uGRJxrWabTv2qcOaNOXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WgvNIIh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B453C4CEF7;
	Wed,  4 Feb 2026 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217285;
	bh=PbmeEVhJLWXSR8RIhrPZa0gArUN8jK7rRuF5RbqMULs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WgvNIIh/dWn8e3OtA/a4Rvp9lL1ZrQqeTRPSuSt8NXQSpBbuBB9rqBZdZFzxCSmhu
	 8TZ2yCDA1hQlIHsqi7Iyub9ho/dUAE/+L3+PWCzfpZ0gT9pAXgp/zTOgQmJu18PZpH
	 nAvcxY6VnTpHeTe7Au+Tk80CZR4sgJDrMGkr59wQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 5.15 179/206] espintcp: fix skb leaks
Date: Wed,  4 Feb 2026 15:40:10 +0100
Message-ID: <20260204143904.663516480@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,queasysnail.net,kernel.org,secunet.com,139.com];
	TAGGED_FROM(0.00)[bounces-213721-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,secunet.com:email]
X-Rspamd-Queue-Id: 13CEAE7D43
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 63c1f19a3be3169e51a5812d22a6d0c879414076 ]

A few error paths are missing a kfree_skb.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
[ Minor context change fixed. ]
Signed-off-by: Bin Lan <lanbincn@139.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/esp4.c     |    4 +++-
 net/ipv6/esp6.c     |    4 +++-
 net/xfrm/espintcp.c |    4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -196,8 +196,10 @@ static int esp_output_tcp_finish(struct
 
 	sk = esp_find_tcp_sk(x);
 	err = PTR_ERR_OR_ZERO(sk);
-	if (err)
+	if (err) {
+		kfree_skb(skb);
 		goto out;
+	}
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk))
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -214,8 +214,10 @@ static int esp_output_tcp_finish(struct
 
 	sk = esp6_find_tcp_sk(x);
 	err = PTR_ERR_OR_ZERO(sk);
-	if (err)
+	if (err) {
+		kfree_skb(skb);
 		goto out;
+	}
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk))
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -170,8 +170,10 @@ int espintcp_queue_out(struct sock *sk,
 {
 	struct espintcp_ctx *ctx = espintcp_getctx(sk);
 
-	if (skb_queue_len(&ctx->out_queue) >= READ_ONCE(netdev_max_backlog))
+	if (skb_queue_len(&ctx->out_queue) >= READ_ONCE(netdev_max_backlog)) {
+		kfree_skb(skb);
 		return -ENOBUFS;
+	}
 
 	__skb_queue_tail(&ctx->out_queue, skb);
 



