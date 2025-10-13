Return-Path: <stable+bounces-185181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46600BD514C
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1322F486462
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDEA30B52A;
	Mon, 13 Oct 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wwi9fn/p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F0E308F39;
	Mon, 13 Oct 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369563; cv=none; b=hFfTZ9zoVOWxmSEyofzZipYRlbTeAX+swVIxnMGyUh8NHom7WkWvZu7TCfaG21PT3qGM6XQz6eWdWpla4lxp9SCOkCINurRyQCBvMHz/XVJP4xS8q8F6miHH6wpSEsbuAdBdnU/pwkCdEAs9P171YCbE/7LY/gChTTVzIvr6QQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369563; c=relaxed/simple;
	bh=lXpxlVeVGtBz5KuZhBQCSR/qKmNpLg9ZlUhuPuDPCyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBxTkklEx/E/jZf61x3LNwl/5xZ3fT+2LnkVKCNiMXv7jpbfM1+Dbh5511AnZMLrF98ea3C/YIguGdfHhq1EYW4bloBWRMEZnpElNBHZP2RYwMAcWHK2tBbhZtUdcZ71YRmsKGRPZ4vu4XjCy/pxFtmBv9LiEn5MiiZsyaWbP5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wwi9fn/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92BFC4CEE7;
	Mon, 13 Oct 2025 15:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760369563;
	bh=lXpxlVeVGtBz5KuZhBQCSR/qKmNpLg9ZlUhuPuDPCyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wwi9fn/ptsDIOE9EMoeflh+z9Q07UXyUTd9NbrqdmmR1aWUv0D8gUsY65QxC/OVBW
	 pL5H7KY6/WAviBBk79SPTQzAcKywDM1BnOODWe4VGDBMZ9aIl6diI6jYcK0lhh2Lyk
	 UOYP6kcMZwt+8wb8THa9yM3h4fh801PWqNNUALYY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 290/563] tcp_metrics: use dst_dev_net_rcu()
Date: Mon, 13 Oct 2025 16:42:31 +0200
Message-ID: <20251013144421.775451107@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 50c127a69cd6285300931853b352a1918cfa180f ]

Replace three dst_dev() with a lockdep enabled helper.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250828195823.3958522-7-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_metrics.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 03c068ea27b6a..10e86f1008e9d 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -170,7 +170,7 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
 	struct net *net;
 
 	spin_lock_bh(&tcp_metrics_lock);
-	net = dev_net_rcu(dst_dev(dst));
+	net = dst_dev_net_rcu(dst);
 
 	/* While waiting for the spin-lock the cache might have been populated
 	 * with this entry and so we have to check again.
@@ -273,7 +273,7 @@ static struct tcp_metrics_block *__tcp_get_metrics_req(struct request_sock *req,
 		return NULL;
 	}
 
-	net = dev_net_rcu(dst_dev(dst));
+	net = dst_dev_net_rcu(dst);
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
@@ -318,7 +318,7 @@ static struct tcp_metrics_block *tcp_get_metrics(struct sock *sk,
 	else
 		return NULL;
 
-	net = dev_net_rcu(dst_dev(dst));
+	net = dst_dev_net_rcu(dst);
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
-- 
2.51.0




