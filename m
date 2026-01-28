Return-Path: <stable+bounces-211954-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Dd8AS/ueWmO1AEAu9opvQ
	(envelope-from <stable+bounces-211954-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 12:08:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDBC9FFC1
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 12:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E35F03013A89
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 11:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4572EA15C;
	Wed, 28 Jan 2026 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="N46p8G60"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D91A2DA769
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769598425; cv=none; b=b0ezpTFto97+cWP0jvkUcZWYKpNVt6fuYZmqvv/puspbJVV9lFl7jpgzcOD6SOiJblOaqFqdX+f1/EeI5bak6IYTM4SXvpbqaDeAwIzh3321jdekRLgEqGkE4dhk1KXqxfuSGGIw6DtDgvt+mNMVv+KL35bRQSMrQTMielUNHlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769598425; c=relaxed/simple;
	bh=LTa8BcT6huDN6R3UM6Ee1vroyYdbUgzCwztoxqOp8Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4hFcLqvZ7PpHvDsPWcH3ufeCGYVcRbqqJdHvak5puVE26Din6bjQaol+DE1vRZtw6Z0XOqrOmPo2zoOVV8jVD2INoQkRIsxV/yJNyhMDTlluHpp/R16USArURiK6KrjPfFHX+X/zDOaVTdhV1Cphu9vWGUL27loDrRv2pcDL+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=N46p8G60; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=N46p8G60SQ95aRWBg4p3g3KLSVu8NbU/v2msxqyQM16Wif/WRiT77JtyfE2GFa8L+p4PePPSsTpnr
	 UR0wOpUXNZZ1AU8q6EAFZQjeT/M008HlGTu8jseCTGKtzQhDDQuxs93tTPbJI/QKnNzVFTyHbnONH9
	 z2eRa1kX67d3kPDs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from ubuntu24.corp.ad.wrs.com (unknown[120.244.194.8])
	by rmsmtp-lg-appmail-04-12082 (RichMail) with SMTP id 2f326979ede6c3a-647c0;
	Wed, 28 Jan 2026 19:07:27 +0800 (CST)
X-RM-TRANSID:2f326979ede6c3a-647c0
From: Bin Lan <lanbincn@139.com>
To: stable@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 5.15.y] espintcp: fix skb leaks
Date: Wed, 28 Jan 2026 11:06:35 +0000
Message-ID: <20260128110635.4109-1-lanbincn@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[139.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[139.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-211954-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[139.com:-];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[lanbincn@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[queasysnail.net,kernel.org,secunet.com,139.com];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.991];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:email,queasysnail.net:email]
X-Rspamd-Queue-Id: 0DDBC9FFC1
X-Rspamd-Action: no action

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 63c1f19a3be3169e51a5812d22a6d0c879414076 ]

A few error paths are missing a kfree_skb.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
[ Minor context change fixed. ]
Signed-off-by: Bin Lan <lanbincn@139.com>
---
 net/ipv4/esp4.c     | 4 +++-
 net/ipv6/esp6.c     | 4 +++-
 net/xfrm/espintcp.c | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index e578d065d904..53170ecb2de0 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -196,8 +196,10 @@ static int esp_output_tcp_finish(struct xfrm_state *x, struct sk_buff *skb)
 
 	sk = esp_find_tcp_sk(x);
 	err = PTR_ERR_OR_ZERO(sk);
-	if (err)
+	if (err) {
+		kfree_skb(skb);
 		goto out;
+	}
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk))
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index a4b8c70ae527..cbe575ade34d 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -214,8 +214,10 @@ static int esp_output_tcp_finish(struct xfrm_state *x, struct sk_buff *skb)
 
 	sk = esp6_find_tcp_sk(x);
 	err = PTR_ERR_OR_ZERO(sk);
-	if (err)
+	if (err) {
+		kfree_skb(skb);
 		goto out;
+	}
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk))
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 24ca49ecebea..ebb9ee8906f4 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -170,8 +170,10 @@ int espintcp_queue_out(struct sock *sk, struct sk_buff *skb)
 {
 	struct espintcp_ctx *ctx = espintcp_getctx(sk);
 
-	if (skb_queue_len(&ctx->out_queue) >= READ_ONCE(netdev_max_backlog))
+	if (skb_queue_len(&ctx->out_queue) >= READ_ONCE(netdev_max_backlog)) {
+		kfree_skb(skb);
 		return -ENOBUFS;
+	}
 
 	__skb_queue_tail(&ctx->out_queue, skb);
 
-- 
2.43.0



