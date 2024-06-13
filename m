Return-Path: <stable+bounces-50812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C416E906CDE
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A5D1C227BB
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5378A14883E;
	Thu, 13 Jun 2024 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G29gJUQF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F296F148833;
	Thu, 13 Jun 2024 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279458; cv=none; b=spVrSfPdOsfCBA6rGClGhqSp55iATI8BP6lNjERi1OJAZIr7F5ElxpbYl1MCtsgIFYN5Er8Rsw+Wn4Nd/jIYDxGh4kDy25pK9xHUQmaeFbpsxun6+tKa2rJ8gjKT0McrH3UdkKLpw0tmgVlwwQU9e46DLxDYH9uPfhJp+uJ35g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279458; c=relaxed/simple;
	bh=bBq3pL4LmUnBO6deKlLCb6wdxpl+xNCuxLoRWO4BD6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pot1t3RQXBtGUbMqeJEaamqc3O4TkbTzG4Tqf00vh9aHDm0P1FYPtHgI9mQnDybalEoE6Jl0vtOK7Zma74b27iTUiZfB713aA24BsTOhiBgeby4SNtAPz8vZIU2qhBjypulaiRhzy6FlGPCMMTwosVB9utyqSDwl2ywrsMoEjAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G29gJUQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268C0C4AF1A;
	Thu, 13 Jun 2024 11:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279457;
	bh=bBq3pL4LmUnBO6deKlLCb6wdxpl+xNCuxLoRWO4BD6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G29gJUQF5hkUTyK+gBKAQZCRQP7EzbB3qVtAD3j5ClGABL4HIHecaOjYZQnql/NZk
	 Ciymbzj/zXsgLWeZXqQXKkIQgHhd5g23WsUR1WzCM/QwwfUmFD6tcqfMXTHSjgwhiu
	 c5g5l2buB5dBefcnJ96c7kVYVSBAxf2QWzkBopn8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fan Yu <fan.yu9@zte.com.cn>,
	xu xin <xu.xin16@zte.com.cn>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.9 082/157] net/ipv6: Fix route deleting failure when metric equals 0
Date: Thu, 13 Jun 2024 13:33:27 +0200
Message-ID: <20240613113230.596675236@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>
References: <20240613113227.389465891@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: xu xin <xu.xin16@zte.com.cn>

commit bb487272380d120295e955ad8acfcbb281b57642 upstream.

Problem
=========
After commit 67f695134703 ("ipv6: Move setting default metric for routes"),
we noticed that the logic of assigning the default value of fc_metirc
changed in the ioctl process. That is, when users use ioctl(fd, SIOCADDRT,
rt) with a non-zero metric to add a route,  then they may fail to delete a
route with passing in a metric value of 0 to the kernel by ioctl(fd,
SIOCDELRT, rt). But iproute can succeed in deleting it.

As a reference, when using iproute tools by netlink to delete routes with
a metric parameter equals 0, like the command as follows:

	ip -6 route del fe80::/64 via fe81::5054:ff:fe11:3451 dev eth0 metric 0

the user can still succeed in deleting the route entry with the smallest
metric.

Root Reason
===========
After commit 67f695134703 ("ipv6: Move setting default metric for routes"),
When ioctl() pass in SIOCDELRT with a zero metric, rtmsg_to_fib6_config()
will set a defalut value (1024) to cfg->fc_metric in kernel, and in
ip6_route_del() and the line 4074 at net/ipv3/route.c, it will check by

	if (cfg->fc_metric && cfg->fc_metric != rt->fib6_metric)
		continue;

and the condition is true and skip the later procedure (deleting route)
because cfg->fc_metric != rt->fib6_metric. But before that commit,
cfg->fc_metric is still zero there, so the condition is false and it
will do the following procedure (deleting).

Solution
========
In order to keep a consistent behaviour across netlink() and ioctl(), we
should allow to delete a route with a metric value of 0. So we only do
the default setting of fc_metric in route adding.

CC: stable@vger.kernel.org # 5.4+
Fixes: 67f695134703 ("ipv6: Move setting default metric for routes")
Co-developed-by: Fan Yu <fan.yu9@zte.com.cn>
Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20240514201102055dD2Ba45qKbLlUMxu_DTHP@zte.com.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4446,7 +4446,7 @@ static void rtmsg_to_fib6_config(struct
 		.fc_table = l3mdev_fib_table_by_index(net, rtmsg->rtmsg_ifindex) ?
 			 : RT6_TABLE_MAIN,
 		.fc_ifindex = rtmsg->rtmsg_ifindex,
-		.fc_metric = rtmsg->rtmsg_metric ? : IP6_RT_PRIO_USER,
+		.fc_metric = rtmsg->rtmsg_metric,
 		.fc_expires = rtmsg->rtmsg_info,
 		.fc_dst_len = rtmsg->rtmsg_dst_len,
 		.fc_src_len = rtmsg->rtmsg_src_len,
@@ -4476,6 +4476,9 @@ int ipv6_route_ioctl(struct net *net, un
 	rtnl_lock();
 	switch (cmd) {
 	case SIOCADDRT:
+		/* Only do the default setting of fc_metric in route adding */
+		if (cfg.fc_metric == 0)
+			cfg.fc_metric = IP6_RT_PRIO_USER;
 		err = ip6_route_add(&cfg, GFP_KERNEL, NULL);
 		break;
 	case SIOCDELRT:



