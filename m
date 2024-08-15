Return-Path: <stable+bounces-68327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D929531AD
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146161F22203
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A91A19FA87;
	Thu, 15 Aug 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BiaQD+WI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B4F19EEB6;
	Thu, 15 Aug 2024 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730215; cv=none; b=rLqwCIzm30bOsp2EzNzYYL7f+bqKj7V2bcTW6GtJciTnQjFQkEkqJx9Lamaf14djoH17MAWN70vbnICR+RCBxus2jg4IqeunxRNoGgKKW6iQh3kUqZKXzLGCNjQ04ea48HrTjp0pQOFnc6Y8aeYqSiTBcj+Jd3JBbrWVoet3u0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730215; c=relaxed/simple;
	bh=OGnxVniWB7f/rFFKpBJFUHqoCjKkkmYLFOmJ42UUlYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rl+r0t04WvOoOSfReFzerQoLHlLXYrLSUUhtYcnhqc45UfJv4aCh3LK1sr46fTtNJRiaWgeN6SYwHnfsM8TK7h26TER5UVpY9nMsH2SU0k4sQYLiEsAKdvCesN6n5NsVXp/ZD+4Z7dZMZW9AA/NxQfYKzViG2jr9rISplRYhptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BiaQD+WI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499DFC32786;
	Thu, 15 Aug 2024 13:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730215;
	bh=OGnxVniWB7f/rFFKpBJFUHqoCjKkkmYLFOmJ42UUlYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BiaQD+WIXudXJRynZ8BE3SkjRy97xsLHO55MJHyYWlmf3uBV6C6hs8DftdN4Gp7a/
	 dKCts82U3jSOc3dzT2d4YtSjgA8+lq/grs0zY3kJoqzmkFXu1FoYU7LuUPU78lMmEU
	 Qui5XUR3dwPiuIXkMUtSzczb6hs9dla7Xa2bxBgI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiri Pirko <jiri@mellanox.com>,
	Florent Fourcot <florent.fourcot@wifirst.fr>,
	Brian Baboch <brian.baboch@wifirst.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 332/484] rtnetlink: enable alt_ifname for setlink/newlink
Date: Thu, 15 Aug 2024 15:23:10 +0200
Message-ID: <20240815131954.235667274@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florent Fourcot <florent.fourcot@wifirst.fr>

[ Upstream commit 5ea08b5286f66ee5ac0150668c92d1718e83e1ad ]

buffer called "ifname" given in function rtnl_dev_get
is always valid when called by setlink/newlink,
but contains only empty string when IFLA_IFNAME is not given. So
IFLA_ALT_IFNAME is always ignored

This patch fixes rtnl_dev_get function with a remove of ifname argument,
and move ifname copy in do_setlink when required.

It extends feature of commit 76c9ac0ee878,
"net: rtnetlink: add possibility to use alternative names as message
handle""

CC: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florent Fourcot <florent.fourcot@wifirst.fr>
Signed-off-by: Brian Baboch <brian.baboch@wifirst.fr>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 9415d375d852 ("rtnetlink: Don't ignore IFLA_TARGET_NETNSID when ifname is specified in rtnl_dellink().")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/rtnetlink.c | 69 +++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index d25632fbfa892..4284406740932 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2617,17 +2617,23 @@ static int do_set_proto_down(struct net_device *dev,
 static int do_setlink(const struct sk_buff *skb,
 		      struct net_device *dev, struct ifinfomsg *ifm,
 		      struct netlink_ext_ack *extack,
-		      struct nlattr **tb, char *ifname, int status)
+		      struct nlattr **tb, int status)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
+	char ifname[IFNAMSIZ];
 	int err;
 
 	err = validate_linkmsg(dev, tb, extack);
 	if (err < 0)
 		return err;
 
+	if (tb[IFLA_IFNAME])
+		nla_strscpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
+	else
+		ifname[0] = '\0';
+
 	if (tb[IFLA_NET_NS_PID] || tb[IFLA_NET_NS_FD] || tb[IFLA_TARGET_NETNSID]) {
-		const char *pat = ifname && ifname[0] ? ifname : NULL;
+		const char *pat = ifname[0] ? ifname : NULL;
 		struct net *net;
 		int new_ifindex;
 
@@ -2974,21 +2980,16 @@ static int do_setlink(const struct sk_buff *skb,
 }
 
 static struct net_device *rtnl_dev_get(struct net *net,
-				       struct nlattr *ifname_attr,
-				       struct nlattr *altifname_attr,
-				       char *ifname)
-{
-	char buffer[ALTIFNAMSIZ];
-
-	if (!ifname) {
-		ifname = buffer;
-		if (ifname_attr)
-			nla_strscpy(ifname, ifname_attr, IFNAMSIZ);
-		else if (altifname_attr)
-			nla_strscpy(ifname, altifname_attr, ALTIFNAMSIZ);
-		else
-			return NULL;
-	}
+				       struct nlattr *tb[])
+{
+	char ifname[ALTIFNAMSIZ];
+
+	if (tb[IFLA_IFNAME])
+		nla_strscpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
+	else if (tb[IFLA_ALT_IFNAME])
+		nla_strscpy(ifname, tb[IFLA_ALT_IFNAME], ALTIFNAMSIZ);
+	else
+		return NULL;
 
 	return __dev_get_by_name(net, ifname);
 }
@@ -3001,7 +3002,6 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net_device *dev;
 	int err;
 	struct nlattr *tb[IFLA_MAX+1];
-	char ifname[IFNAMSIZ];
 
 	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFLA_MAX,
 				     ifla_policy, extack);
@@ -3012,17 +3012,12 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
-	if (tb[IFLA_IFNAME])
-		nla_strscpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
-	else
-		ifname[0] = '\0';
-
 	err = -EINVAL;
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(net, ifm->ifi_index);
 	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
-		dev = rtnl_dev_get(net, NULL, tb[IFLA_ALT_IFNAME], ifname);
+		dev = rtnl_dev_get(net, tb);
 	else
 		goto errout;
 
@@ -3031,7 +3026,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto errout;
 	}
 
-	err = do_setlink(skb, dev, ifm, extack, tb, ifname, 0);
+	err = do_setlink(skb, dev, ifm, extack, tb, 0);
 errout:
 	return err;
 }
@@ -3120,8 +3115,7 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(tgt_net, ifm->ifi_index);
 	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
-		dev = rtnl_dev_get(net, tb[IFLA_IFNAME],
-				   tb[IFLA_ALT_IFNAME], NULL);
+		dev = rtnl_dev_get(net, tb);
 	else if (tb[IFLA_GROUP])
 		err = rtnl_group_dellink(tgt_net, nla_get_u32(tb[IFLA_GROUP]));
 	else
@@ -3267,7 +3261,7 @@ static int rtnl_group_changelink(const struct sk_buff *skb,
 
 	for_each_netdev_safe(net, dev, aux) {
 		if (dev->group == group) {
-			err = do_setlink(skb, dev, ifm, extack, tb, NULL, 0);
+			err = do_setlink(skb, dev, ifm, extack, tb, 0);
 			if (err < 0)
 				return err;
 		}
@@ -3309,11 +3303,6 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
-	if (tb[IFLA_IFNAME])
-		nla_strscpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
-	else
-		ifname[0] = '\0';
-
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
@@ -3323,7 +3312,7 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EINVAL;
 	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
 		link_specified = true;
-		dev = rtnl_dev_get(net, NULL, tb[IFLA_ALT_IFNAME], ifname);
+		dev = rtnl_dev_get(net, tb);
 	} else {
 		link_specified = false;
 		dev = NULL;
@@ -3426,7 +3415,7 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			status |= DO_SETLINK_NOTIFY;
 		}
 
-		return do_setlink(skb, dev, ifm, extack, tb, ifname, status);
+		return do_setlink(skb, dev, ifm, extack, tb, status);
 	}
 
 	if (!(nlh->nlmsg_flags & NLM_F_CREATE)) {
@@ -3463,7 +3452,9 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!ops->alloc && !ops->setup)
 		return -EOPNOTSUPP;
 
-	if (!ifname[0]) {
+	if (tb[IFLA_IFNAME]) {
+		nla_strscpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
+	} else {
 		snprintf(ifname, IFNAMSIZ, "%s%%d", ops->kind);
 		name_assign_type = NET_NAME_ENUM;
 	}
@@ -3635,8 +3626,7 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(tgt_net, ifm->ifi_index);
 	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
-		dev = rtnl_dev_get(tgt_net, tb[IFLA_IFNAME],
-				   tb[IFLA_ALT_IFNAME], NULL);
+		dev = rtnl_dev_get(tgt_net, tb);
 	else
 		goto out;
 
@@ -3731,8 +3721,7 @@ static int rtnl_linkprop(int cmd, struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(net, ifm->ifi_index);
 	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
-		dev = rtnl_dev_get(net, tb[IFLA_IFNAME],
-				   tb[IFLA_ALT_IFNAME], NULL);
+		dev = rtnl_dev_get(net, tb);
 	else
 		return -EINVAL;
 
-- 
2.43.0




