Return-Path: <stable+bounces-60964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7063F93A634
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238D01F23694
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C068156F3A;
	Tue, 23 Jul 2024 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fG+ObIJW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0C0156C6C;
	Tue, 23 Jul 2024 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759572; cv=none; b=UJDu871MGR9am76pathF8F8ktzYZufYdaY0Hd/evI6v1FfhJaUSZdttyy1+Ej90nr9eUl00kqX7bkkh4SMjH1/NIN1BkJ5IUg+CEce0VpEOyeV7wl02aqrqbpuZZhl5+ZMue05wMKi+3NuRezparbW5ussVeEOmyje3C0txIMjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759572; c=relaxed/simple;
	bh=WBALwJSXE5OIoGu4IVBjOxqzxq9F3YkuPavbK2pSHkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVs2G13hWAl1gWTKptQn7Z3kyDVWbMAhWAQq4dIok76aISszY19c9WXJTMIsojUmwHJVMHYbvmkLbsfxSkVxbdFnpciiZM92aEZ8Py0HqDjjoomrJ+dA7wVuSc+ldTjG3dYcxNoJ5M9n6lm5g+TxQX1fsFeDp66JYolIWBTIzEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fG+ObIJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59A2C4AF0B;
	Tue, 23 Jul 2024 18:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721759572;
	bh=WBALwJSXE5OIoGu4IVBjOxqzxq9F3YkuPavbK2pSHkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fG+ObIJWO81YP1Dn7l8Z1iNVmWxnmW5zt2uvOpxokR77ZzxBpOc1BcyzFZ/hIB1Rj
	 hOUcz0Ti29pl+wCh/nK//7lcml6+VtMHAQBynciqcSKaAS01KP8xiP5Co77wf+zd+h
	 Pa9qhVlnEqQKi5I94b7DWckaCQhu3afdanC3QdJE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 028/129] ila: block BH in ila_output()
Date: Tue, 23 Jul 2024 20:22:56 +0200
Message-ID: <20240723180405.878278499@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180404.759900207@linuxfoundation.org>
References: <20240723180404.759900207@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit cf28ff8e4c02e1ffa850755288ac954b6ff0db8c ]

As explained in commit 1378817486d6 ("tipc: block BH
before using dst_cache"), net/core/dst_cache.c
helpers need to be called with BH disabled.

ila_output() is called from lwtunnel_output()
possibly from process context, and under rcu_read_lock().

We might be interrupted by a softirq, re-enter ila_output()
and corrupt dst_cache data structures.

Fix the race by using local_bh_disable().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240531132636.2637995-5-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ila/ila_lwt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
index 8c1ce78956bae..9d37f7164e732 100644
--- a/net/ipv6/ila/ila_lwt.c
+++ b/net/ipv6/ila/ila_lwt.c
@@ -58,7 +58,9 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		return orig_dst->lwtstate->orig_output(net, sk, skb);
 	}
 
+	local_bh_disable();
 	dst = dst_cache_get(&ilwt->dst_cache);
+	local_bh_enable();
 	if (unlikely(!dst)) {
 		struct ipv6hdr *ip6h = ipv6_hdr(skb);
 		struct flowi6 fl6;
@@ -86,8 +88,11 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		if (ilwt->connected)
+		if (ilwt->connected) {
+			local_bh_disable();
 			dst_cache_set_ip6(&ilwt->dst_cache, dst, &fl6.saddr);
+			local_bh_enable();
+		}
 	}
 
 	skb_dst_set(skb, dst);
-- 
2.43.0




