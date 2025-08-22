Return-Path: <stable+bounces-172476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFBEB32124
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46C51D61A4F
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 17:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8391531352F;
	Fri, 22 Aug 2025 17:09:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D47310624;
	Fri, 22 Aug 2025 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882545; cv=none; b=pUSVTjcP4Nx3E5GsOKH/wc+2L6MaYCuZzfE0DpMsBfpFRmokrnyoPsO7GqC0oA7k7Co3k6vlgJseyWwp7cX9/AP21II/dq5o/uJE4JHxdF0jW7+/H+f2OeUzvArJGgRFVQ/YVgUGsWcthz8G5eYJGuXfSh03lRT54wv8UQiPiQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882545; c=relaxed/simple;
	bh=ahzZ/0mvs0l2sMIO3U7UUbHaORgWwhdGQPeal2ZB710=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GwyhkpTGv+NCRdiu2l9KRvgdZkv1xO707MpqoQWKmKEgbnTHhHDBbjcmx9j3StiUJ63jRv0GIfWMomyarCpswbELdVJUdjk6i/SaSIZkV/GPqCE7aNMqWl9Eate7wKQrF+a2alzT/meYc8p0QIW/lRbRo6kcFEn6hTMUQBT5a2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
From: Brett A C Sheffield <bacs@librecast.net>
To: regressions@lists.linux.dev
Cc: Brett A C Sheffield <bacs@librecast.net>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	oscmaes92@gmail.com,
	kuba@kernel.org
Subject: [REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in broadcast routes
Date: Fri, 22 Aug 2025 16:50:51 +0000
Message-ID: <20250822165231.4353-4-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the regression introduced in 9e30ecf23b1b whereby IPv4 broadcast
packets were having their ethernet destination field mangled.  This
broke WOL magic packets and likely other IPv4 broadcast.

The regression can be observed by sending an IPv4 WOL packet using
the wakeonlan program to any ethernet address:

 wakeonlan 46:3b:ad:61:e0:5d

and capturing the packet with tcpdump:

 tcpdump -i eth0 -w /tmp/bad.cap dst port 9

The ethernet destination MUST be ff:ff:ff:ff:ff:ff for broadcast, but is
mangled with 9e30ecf23b1b applied.

Revert the change made in 9e30ecf23b1b and ensure the MTU value for
broadcast routes is retained by calling ip_dst_init_metrics() directly,
avoiding the need to enter the main code block in rt_set_nexthop().

Simplify the code path taken for broadcast packets back to the original
before the regression, adding only the call to ip_dst_init_metrics().

The broadcast_pmtu.sh selftest provided with the original patch still
passes with this patch applied.

Fixes: 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
---
 net/ipv4/route.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f639a2ae881a..eaf78e128aca 100644
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
+		if (type == RTN_BROADCAST) {
+			/* ensure MTU value for broadcast routes is retained */
+			ip_dst_init_metrics(&rth->dst, res->fi->fib_metrics);
+		}
 #ifdef CONFIG_IP_MROUTE
-		if (type == RTN_MULTICAST) {
+		else if (type == RTN_MULTICAST) {
 			if (IN_DEV_MFORWARD(in_dev) &&
 			    !ipv4_is_local_multicast(fl4->daddr)) {
 				rth->dst.input = ip_mr_input;

base-commit: 01b9128c5db1b470575d07b05b67ffa3cb02ebf1
-- 
2.49.1


