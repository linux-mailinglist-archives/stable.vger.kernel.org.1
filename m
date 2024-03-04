Return-Path: <stable+bounces-26402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C1E870E6B
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8BF1C20E56
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C8C1EB5A;
	Mon,  4 Mar 2024 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wERzQuNb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C6310A35;
	Mon,  4 Mar 2024 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588628; cv=none; b=LJYiMWuC1JSD5UWw0wiqd4i/3gxHXMnValYIpZqdllKhIkuzfcuRr02z2houwvjaZn1scy9K6Jp9WmiB1ISX2Lwn2xf+zqLBsnRNt0Sdjj4/96XPw2hNI6bDVwx60NrCCJYqFtI/HlzNKCNMyodRDw9EeJPPQxk0/VjSTKFVcjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588628; c=relaxed/simple;
	bh=fHK2R+lhpq0yz42Fuw/SKvnUF9tqFK+zvXTpiQIiDvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjEMkoVBAhftUf38HlL/loeHPNTkSq7/a22+wHdCG8LthyVqHIefuVyFBQzsGtXsYiEE8dBgi0CaXzcL82XKaPryZILa+9NelOYiGUvl+2x/haEFHeGry/ze5/W6g1ufAX7TbKZGwByx4CAGjMP/MmLUKN0H5KqV883dOM1QGvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wERzQuNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5FBC433F1;
	Mon,  4 Mar 2024 21:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588627;
	bh=fHK2R+lhpq0yz42Fuw/SKvnUF9tqFK+zvXTpiQIiDvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wERzQuNb8UZ/Dcx9UGxEQyhzSbm4Of7hi2BKcPP9T+03Xx2gk+d57hKXoJ6QBgeeT
	 yey4nRQIcMzQC1mPEhqCccJG3E5RKQAMYQy1fGFaHxbHXBhnfh7JxojrvVz9mkZ0GY
	 G+sk0eRieyQ5qXjy9bPjmXNfyBLgHhQquO8VdTsI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 035/215] ipv6: fix potential "struct net" leak in inet6_rtm_getaddr()
Date: Mon,  4 Mar 2024 21:21:38 +0000
Message-ID: <20240304211558.107658660@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
References: <20240304211556.993132804@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 10bfd453da64a057bcfd1a49fb6b271c48653cdb ]

It seems that if userspace provides a correct IFA_TARGET_NETNSID value
but no IFA_ADDRESS and IFA_LOCAL attributes, inet6_rtm_getaddr()
returns -EINVAL with an elevated "struct net" refcount.

Fixes: 6ecf4c37eb3e ("ipv6: enable IFA_TARGET_NETNSID for RTM_GETADDR")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Ahern <dsahern@kernel.org>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/addrconf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 46527b5cc8f0c..1648373692a99 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5473,9 +5473,10 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	}
 
 	addr = extract_addr(tb[IFA_ADDRESS], tb[IFA_LOCAL], &peer);
-	if (!addr)
-		return -EINVAL;
-
+	if (!addr) {
+		err = -EINVAL;
+		goto errout;
+	}
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifa_index)
 		dev = dev_get_by_index(tgt_net, ifm->ifa_index);
-- 
2.43.0




