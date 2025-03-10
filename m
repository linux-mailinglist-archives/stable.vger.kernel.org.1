Return-Path: <stable+bounces-122886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E242A5A1CD
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0E7D7A6F8F
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2DB233725;
	Mon, 10 Mar 2025 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ijv6SwOV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DB423370B;
	Mon, 10 Mar 2025 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630427; cv=none; b=uSEej5rpc66EXUnnMzVjOo6muaQ05QWRKQN/zOOogE13H5Q8DxXlj7JrmEfyY7BaMtynA1MtxiuZAK9YZ9MtygrMbVxt+/1WZOHj2j8dlRAdPvLmOXiD23at0t1rYsL9T5DKi3Kpmjd4YkigzmzRveiQ04p4yK76RbvFQ5vI1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630427; c=relaxed/simple;
	bh=biOioQ75eMYZ9TurSPcCWRWVHeTF/yq6jgvDmGnSGpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rqz38Zb1EvmTyebSetsKa2jvwKT8UXu9Qax/lUbs1kYZgKoexAcOF+K0Bf9pJTU2hcvD7KxCFajZOdTAbu9sPIMTGyf0ezPufcgenzIPdhlkrtdyyH8WfMQG+IOA8ANh0svMXc1TmpCCqdSGT3dYRRK0RF4CbgoIxigciYtjhTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ijv6SwOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366B4C4CEE5;
	Mon, 10 Mar 2025 18:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741630426;
	bh=biOioQ75eMYZ9TurSPcCWRWVHeTF/yq6jgvDmGnSGpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijv6SwOVXB0uRtdvrQ24uaiywSdsnDLjsj9gmSZdipMGaXu8Tl7EDhUlAAy7s+Pdi
	 9eHxrGmpO+xsWBc0VxscTQzLbfLFsUvsY3Sg/3v55Agnc+OsuuJ0ymVgadifRLPvus
	 m96KqDve1XxWKLYBA62Hjxk+q4FpSU1D819usZUk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 402/620] ipv6: use RCU protection in ip6_default_advmss()
Date: Mon, 10 Mar 2025 18:04:08 +0100
Message-ID: <20250310170601.460275736@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 3c8ffcd248da34fc41e52a46e51505900115fc2a ]

ip6_default_advmss() needs rcu protection to make
sure the net structure it reads does not disappear.

Fixes: 5578689a4e3c ("[NETNS][IPV6] route6 - make route6 per namespace")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250205155120.1676781-11-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/route.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b7f494cca3e5c..94526436b91e8 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3184,13 +3184,18 @@ static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
 	struct net_device *dev = dst->dev;
 	unsigned int mtu = dst_mtu(dst);
-	struct net *net = dev_net(dev);
+	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
 
+	rcu_read_lock();
+
+	net = dev_net_rcu(dev);
 	if (mtu < net->ipv6.sysctl.ip6_rt_min_advmss)
 		mtu = net->ipv6.sysctl.ip6_rt_min_advmss;
 
+	rcu_read_unlock();
+
 	/*
 	 * Maximal non-jumbo IPv6 payload is IPV6_MAXPLEN and
 	 * corresponding MSS is IPV6_MAXPLEN - tcp_header_size.
-- 
2.39.5




