Return-Path: <stable+bounces-172581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F90AB32880
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 14:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EB51C263F1
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 12:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5559525A325;
	Sat, 23 Aug 2025 12:15:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7F62561AB;
	Sat, 23 Aug 2025 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755951336; cv=none; b=g3FEygF3302SIDwH57byaZssD453dzrlhZSvo7h9AXC5sbUUhFnNsGCLWGyvzNCoX6yzoJbd++t+RU6fP3Ta0upflOCmZeTbIADq7546DzMiEY3JflX/fEP0cXTM2w3V1UGvNVR6CzgLTcr9yOd1FRbG148Ct988NDhCeu0nrAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755951336; c=relaxed/simple;
	bh=lSuDN4eAoAl8Zs7nlCY60BE/FVp0jIeN/NStffVK/R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3ZX5v7aF+pt88BzcoIylumUdgwrQ3NXtD1a8Ynks6zD1ljiltZxT8Pvkz1HkK/XowQ5WxE8kmjlE4h/8PEwpn7mkLq7Q5kHtWqyBHgZG7eUVIo/9JRv8XvX7W94I7kKBiaraP723L7ofz6quUKQsqAGdfRzmLTJ6IPOeRy6P2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
From: Brett A C Sheffield <bacs@librecast.net>
To: regressions@lists.linux.dev
Cc: netdev@vger.kernel.org,
	stable@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	oscmaes92@gmail.com,
	kuba@kernel.org,
	Brett A C Sheffield <bacs@librecast.net>
Subject: [PATCH v2 2/2] net: ipv4: fix regression in broadcast routes
Date: Sat, 23 Aug 2025 12:13:38 +0000
Message-ID: <20250823121336.18492-4-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250822183250.2a9cb92c@kernel.org>
References: <20250822183250.2a9cb92c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the regression introduced in 9e30ecf23b1b whereby IPv4 broadcast
packets were having their ethernet destination field mangled.  The
problem was first observed with WOL magic packets but affects all UDP
IPv4 broadcast packets.

The regression can be observed by sending an IPv4 WOL packet using
the wakeonlan program to any ethernet address:

 wakeonlan 46:3b:ad:61:e0:5d

and capturing the packet with tcpdump:

 tcpdump -i eth0 -w /tmp/bad.cap dst port 9

The ethernet destination MUST be ff:ff:ff:ff:ff:ff for broadcast, but is
mangled in affected kernels.

Revert the change made in 9e30ecf23b1b and ensure the MTU value for
broadcast routes is retained by calling ip_dst_init_metrics() directly,
avoiding the need to enter the main code block in rt_set_nexthop().

Simplify the code path taken for broadcast packets back to the original
before the regression, adding only the call to ip_dst_init_metrics().

The broadcast_pmtu.sh selftest provided with the original patch still
passes with this patch applied.

Cc: stable@vger.kernel.org
Fixes: 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
Link: https://lore.kernel.org/regressions/20250822165231.4353-4-bacs@librecast.net
Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
---
 net/ipv4/route.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f639a2ae881a..ab4d72a59c7b 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2588,6 +2588,7 @@ static struct rtable *__mkroute_output(const struct fib_result *res,
 	do_cache = true;
 	if (type == RTN_BROADCAST) {
 		flags |= RTCF_BROADCAST | RTCF_LOCAL;
+		fi = NULL;
 	} else if (type == RTN_MULTICAST) {
 		flags |= RTCF_MULTICAST | RTCF_LOCAL;
 		if (!ip_check_mc_rcu(in_dev, fl4->daddr, fl4->saddr,
@@ -2657,8 +2658,12 @@ static struct rtable *__mkroute_output(const struct fib_result *res,
 			rth->dst.output = ip_mc_output;
 			RT_CACHE_STAT_INC(out_slow_mc);
 		}
+		if (type == RTN_BROADCAST && res->fi) {
+			/* ensure MTU value for broadcast routes is retained */
+			ip_dst_init_metrics(&rth->dst, res->fi->fib_metrics);
+		}
 #ifdef CONFIG_IP_MROUTE
-		if (type == RTN_MULTICAST) {
+		else if (type == RTN_MULTICAST) {
 			if (IN_DEV_MFORWARD(in_dev) &&
 			    !ipv4_is_local_multicast(fl4->daddr)) {
 				rth->dst.input = ip_mr_input;
-- 
2.49.1


