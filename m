Return-Path: <stable+bounces-85803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BDC99E934
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F143282DA1
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1441EBA1E;
	Tue, 15 Oct 2024 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zZ+E3DPB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FCF1EBA0A;
	Tue, 15 Oct 2024 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994351; cv=none; b=rjmB+V0AWGuuPDrzXeB6Hg3F7BbyhkoFJXg/JpMCfEspumXfzMJSoSvK8xW3xlpRvA8Kaqw/A9ga6U3k7hsFnK5KIdUWruooiGLOJiMTBpETrpOtnsSWre3BgRIHU/e4QRVd1vkJJT8Zjot5TT5D1hE7mr1I72J5vkvH1RhnrvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994351; c=relaxed/simple;
	bh=tCUt+Ia1YQxZOMHsge08nIN0cmurYjnsrtrmC6Vj0oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOGY0toRWtIwZelpZF/P82XpRY0SFhJmHHY0EL/Inz5WWXhrFW3cF5p8JoqS33BqH1WZcpWC0Jp9+OvNxpUTgetnNIzLUCjcboSIGKPeqOJRmsx1LgZ+f/GZc+DWxDYWMrrwK3Z3xRCU9ycJ0/NEjBp8D/Xb4V/ikgWssPXsM2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zZ+E3DPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA2FC4CEC6;
	Tue, 15 Oct 2024 12:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728994351;
	bh=tCUt+Ia1YQxZOMHsge08nIN0cmurYjnsrtrmC6Vj0oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zZ+E3DPBzCggbCu5DEGexEakhWwhu25eccfr46oaQPxq1BZxypyx9FN/HOdL3QDPM
	 OgYX5yKls5iLbPE53/clE8NP6HeoXnhl8CRr2j5ISA6kFvXPKkqwfodz/fW6K1rK3H
	 qiciW4znucOvfY6uXzsrOJd1v7brX12Qa8G6V1NM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 656/691] mctp: Handle error of rtnl_register_module().
Date: Tue, 15 Oct 2024 13:30:04 +0200
Message-ID: <20241015112506.362072427@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit d51705614f668254cc5def7490df76f9680b4659 ]

Since introduced, mctp has been ignoring the returned value of
rtnl_register_module(), which could fail silently.

Handling the error allows users to view a module as an all-or-nothing
thing in terms of the rtnetlink functionality.  This prevents syzkaller
from reporting spurious errors from its tests, where OOM often occurs
and module is automatically loaded.

Let's handle the errors by rtnl_register_many().

Fixes: 583be982d934 ("mctp: Add device handling and netlink interface")
Fixes: 831119f88781 ("mctp: Add neighbour netlink interface")
Fixes: 06d2f4c583a7 ("mctp: Add netlink route management")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/mctp.h |  2 +-
 net/mctp/af_mctp.c |  6 +++++-
 net/mctp/device.c  | 30 ++++++++++++++++++------------
 net/mctp/neigh.c   | 31 +++++++++++++++++++------------
 net/mctp/route.c   | 33 +++++++++++++++++++++++----------
 5 files changed, 66 insertions(+), 36 deletions(-)

diff --git a/include/net/mctp.h b/include/net/mctp.h
index ffd2c23bd76d5..8c225091e46cf 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -226,7 +226,7 @@ void mctp_neigh_remove_dev(struct mctp_dev *mdev);
 int mctp_routes_init(void);
 void mctp_routes_exit(void);
 
-void mctp_device_init(void);
+int mctp_device_init(void);
 void mctp_device_exit(void);
 
 #endif /* __NET_MCTP_H */
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 77137a8627d06..0ca031866ce1a 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -384,10 +384,14 @@ static __init int mctp_init(void)
 	if (rc)
 		goto err_unreg_routes;
 
-	mctp_device_init();
+	rc = mctp_device_init();
+	if (rc)
+		goto err_unreg_neigh;
 
 	return 0;
 
+err_unreg_neigh:
+	mctp_neigh_exit();
 err_unreg_routes:
 	mctp_routes_exit();
 err_unreg_proto:
diff --git a/net/mctp/device.c b/net/mctp/device.c
index b9f38e765f619..c00a2550e2e0e 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -399,25 +399,31 @@ static struct notifier_block mctp_dev_nb = {
 	.priority = ADDRCONF_NOTIFY_PRIORITY,
 };
 
-void __init mctp_device_init(void)
+static const struct rtnl_msg_handler mctp_device_rtnl_msg_handlers[] = {
+	{THIS_MODULE, PF_MCTP, RTM_NEWADDR, mctp_rtm_newaddr, NULL, 0},
+	{THIS_MODULE, PF_MCTP, RTM_DELADDR, mctp_rtm_deladdr, NULL, 0},
+	{THIS_MODULE, PF_MCTP, RTM_GETADDR, NULL, mctp_dump_addrinfo, 0},
+};
+
+int __init mctp_device_init(void)
 {
-	register_netdevice_notifier(&mctp_dev_nb);
+	int err;
 
-	rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_GETADDR,
-			     NULL, mctp_dump_addrinfo, 0);
-	rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_NEWADDR,
-			     mctp_rtm_newaddr, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_DELADDR,
-			     mctp_rtm_deladdr, NULL, 0);
+	register_netdevice_notifier(&mctp_dev_nb);
 	rtnl_af_register(&mctp_af_ops);
+
+	err = rtnl_register_many(mctp_device_rtnl_msg_handlers);
+	if (err) {
+		rtnl_af_unregister(&mctp_af_ops);
+		unregister_netdevice_notifier(&mctp_dev_nb);
+	}
+
+	return err;
 }
 
 void __exit mctp_device_exit(void)
 {
+	rtnl_unregister_many(mctp_device_rtnl_msg_handlers);
 	rtnl_af_unregister(&mctp_af_ops);
-	rtnl_unregister(PF_MCTP, RTM_DELADDR);
-	rtnl_unregister(PF_MCTP, RTM_NEWADDR);
-	rtnl_unregister(PF_MCTP, RTM_GETADDR);
-
 	unregister_netdevice_notifier(&mctp_dev_nb);
 }
diff --git a/net/mctp/neigh.c b/net/mctp/neigh.c
index 90ed2f02d1fb0..bc75a263719c7 100644
--- a/net/mctp/neigh.c
+++ b/net/mctp/neigh.c
@@ -321,22 +321,29 @@ static struct pernet_operations mctp_net_ops = {
 	.exit = mctp_neigh_net_exit,
 };
 
+static const struct rtnl_msg_handler mctp_neigh_rtnl_msg_handlers[] = {
+	{THIS_MODULE, PF_MCTP, RTM_NEWNEIGH, mctp_rtm_newneigh, NULL, 0},
+	{THIS_MODULE, PF_MCTP, RTM_DELNEIGH, mctp_rtm_delneigh, NULL, 0},
+	{THIS_MODULE, PF_MCTP, RTM_GETNEIGH, NULL, mctp_rtm_getneigh, 0},
+};
+
 int __init mctp_neigh_init(void)
 {
-	rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_NEWNEIGH,
-			     mctp_rtm_newneigh, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_DELNEIGH,
-			     mctp_rtm_delneigh, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_GETNEIGH,
-			     NULL, mctp_rtm_getneigh, 0);
-
-	return register_pernet_subsys(&mctp_net_ops);
+	int err;
+
+	err = register_pernet_subsys(&mctp_net_ops);
+	if (err)
+		return err;
+
+	err = rtnl_register_many(mctp_neigh_rtnl_msg_handlers);
+	if (err)
+		unregister_pernet_subsys(&mctp_net_ops);
+
+	return err;
 }
 
-void __exit mctp_neigh_exit(void)
+void mctp_neigh_exit(void)
 {
+	rtnl_unregister_many(mctp_neigh_rtnl_msg_handlers);
 	unregister_pernet_subsys(&mctp_net_ops);
-	rtnl_unregister(PF_MCTP, RTM_GETNEIGH);
-	rtnl_unregister(PF_MCTP, RTM_DELNEIGH);
-	rtnl_unregister(PF_MCTP, RTM_NEWNEIGH);
 }
diff --git a/net/mctp/route.c b/net/mctp/route.c
index 5ef6b3b0a3d99..48d32bfd38636 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -1134,25 +1134,38 @@ static struct pernet_operations mctp_net_ops = {
 	.exit = mctp_routes_net_exit,
 };
 
+static const struct rtnl_msg_handler mctp_route_rtnl_msg_handlers[] = {
+	{THIS_MODULE, PF_MCTP, RTM_NEWROUTE, mctp_newroute, NULL, 0},
+	{THIS_MODULE, PF_MCTP, RTM_DELROUTE, mctp_delroute, NULL, 0},
+	{THIS_MODULE, PF_MCTP, RTM_GETROUTE, NULL, mctp_dump_rtinfo, 0},
+};
+
 int __init mctp_routes_init(void)
 {
+	int err;
+
 	dev_add_pack(&mctp_packet_type);
 
-	rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_GETROUTE,
-			     NULL, mctp_dump_rtinfo, 0);
-	rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_NEWROUTE,
-			     mctp_newroute, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_MCTP, RTM_DELROUTE,
-			     mctp_delroute, NULL, 0);
+	err = register_pernet_subsys(&mctp_net_ops);
+	if (err)
+		goto err_pernet;
+
+	err = rtnl_register_many(mctp_route_rtnl_msg_handlers);
+	if (err)
+		goto err_rtnl;
 
-	return register_pernet_subsys(&mctp_net_ops);
+	return 0;
+
+err_rtnl:
+	unregister_pernet_subsys(&mctp_net_ops);
+err_pernet:
+	dev_remove_pack(&mctp_packet_type);
+	return err;
 }
 
 void mctp_routes_exit(void)
 {
+	rtnl_unregister_many(mctp_route_rtnl_msg_handlers);
 	unregister_pernet_subsys(&mctp_net_ops);
-	rtnl_unregister(PF_MCTP, RTM_DELROUTE);
-	rtnl_unregister(PF_MCTP, RTM_NEWROUTE);
-	rtnl_unregister(PF_MCTP, RTM_GETROUTE);
 	dev_remove_pack(&mctp_packet_type);
 }
-- 
2.43.0




