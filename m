Return-Path: <stable+bounces-140099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 920D7AAA517
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7F83A5729
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724C23098B2;
	Mon,  5 May 2025 22:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR0ngE+g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3243098AA;
	Mon,  5 May 2025 22:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484104; cv=none; b=NodsQP4oep06Z2ltbR0InHV6jI/G+XZhWX7vtdtQKXtBBIwhqB6hMwSQsHYUCiEpMdQu8kNt/A63jcUioac6WWG4R2DNFAf1g4zYBcW8PfnqeZk/C1+eSNCnQAOUskVLZOgTxUanwpRXRk+yuDUp6mHz3FKP+p6ypAQMN0KSVjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484104; c=relaxed/simple;
	bh=kq9fHEPx197vzMACozH3NPuOtxrDilFdFT8zwhN40kM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i3mG/uOtgIzgunGTVvJJF0JOOY4JjD/ccmhbhMaS5FrQp8ts8bGWX7aG5zEzYxSRCjRcrSV5Hrmo4RkG4LxnC5TMdXtGsuGxpgIynWVV/Z1d3FN2NGNdE7eVxQkJes1hazWxrVRuVVS1bFw923va/4rIja3RIfjPbJwwu9GkwFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IR0ngE+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7344C4CEE4;
	Mon,  5 May 2025 22:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484104;
	bh=kq9fHEPx197vzMACozH3NPuOtxrDilFdFT8zwhN40kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IR0ngE+gPbiD5LX1KLGmyjc00MmIltx4s4JARpAHNfr803fzw+l6OcofAyc5t3ija
	 Duxo3oL1SuyX6QEuAWT7MJpJGoByAB/+rcQM88YzeMooqe6ScKqnytVlhhrH1YUB6u
	 TDTM6WNI6coBEigEXGO7bRaMJBzpUO62YpgbSKcl+sBGbdxJ5n8oY8dfnZS6VNHXwY
	 eRv1kjOlujib34cwOObVeLQRE8GRdY4j/Gas7/Zy2XbibIdiC00L+g1tH89rB2WCS7
	 2t2rVFrxDDeEn6AyhH6eM6fuVEU13wf8pNVehxghlqet3RqbPu+ZAYKn0+NObkTj98
	 MXY3t2/0nfOSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 352/642] rtnetlink: Lookup device in target netns when creating link
Date: Mon,  5 May 2025 18:09:28 -0400
Message-Id: <20250505221419.2672473-352-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Xiao Liang <shaw.leon@gmail.com>

[ Upstream commit ec061546c6cffbb8929495bba3953f0cc5e177fa ]

When creating link, lookup for existing device in target net namespace
instead of current one.
For example, two links created by:

  # ip link add dummy1 type dummy
  # ip link add netns ns1 dummy1 type dummy

should have no conflict since they are in different namespaces.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250219125039.18024-2-shaw.leon@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/rtnetlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 80e006940f51a..ab7041150f295 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3865,20 +3865,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 {
 	struct nlattr ** const tb = tbs->tb;
 	struct net *net = sock_net(skb->sk);
+	struct net *device_net;
 	struct net_device *dev;
 	struct ifinfomsg *ifm;
 	bool link_specified;
 
+	/* When creating, lookup for existing device in target net namespace */
+	device_net = (nlh->nlmsg_flags & NLM_F_CREATE) &&
+		     (nlh->nlmsg_flags & NLM_F_EXCL) ?
+		     tgt_net : net;
+
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
-		dev = __dev_get_by_index(net, ifm->ifi_index);
+		dev = __dev_get_by_index(device_net, ifm->ifi_index);
 	} else if (ifm->ifi_index < 0) {
 		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
 		return -EINVAL;
 	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
 		link_specified = true;
-		dev = rtnl_dev_get(net, tb);
+		dev = rtnl_dev_get(device_net, tb);
 	} else {
 		link_specified = false;
 		dev = NULL;
-- 
2.39.5


