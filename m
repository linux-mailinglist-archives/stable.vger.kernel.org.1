Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C8170C987
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbjEVTtK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbjEVTtB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:49:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A18B5
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:48:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5978962ACE
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65556C433EF;
        Mon, 22 May 2023 19:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784936;
        bh=vZagBaa+JbxtCw1JUIqU5NUF3D039O55WMBBKN/kiYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oiHj1do4570JLfcfokYUnl/IxEvdt+G7X8JncNUhRhSs4q9Lcbe8kB1nD0g+1gACq
         MtWWENYteRRel2VWw0o6QSX38zclzf6VGs9DkjmYERYopWxkBC1O9MOUEWpiPWZ2lR
         Jiszl6terh5BodmqDQJGbwBfw3GuJTYvXcakMAnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Moshe Shemesh <moshe@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 223/364] devlink: change per-devlink netdev notifier to static one
Date:   Mon, 22 May 2023 20:08:48 +0100
Message-Id: <20230522190418.283871665@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiri Pirko <jiri@nvidia.com>

[ Upstream commit e93c9378e33f68b61ea9318580d841caa22fb9ea ]

The commit 565b4824c39f ("devlink: change port event netdev notifier
from per-net to global") changed original per-net notifier to be
per-devlink instance. That fixed the issue of non-receiving events
of netdev uninit if that moved to a different namespace.
That worked fine in -net tree.

However, later on when commit ee75f1fc44dd ("net/mlx5e: Create
separate devlink instance for ethernet auxiliary device") and
commit 72ed5d5624af ("net/mlx5: Suspend auxiliary devices only in
case of PCI device suspend") were merged, a deadlock was introduced
when removing a namespace with devlink instance with another nested
instance.

Here there is the bad flow example resulting in deadlock with mlx5:
net_cleanup_work -> cleanup_net (takes down_read(&pernet_ops_rwsem) ->
devlink_pernet_pre_exit() -> devlink_reload() ->
mlx5_devlink_reload_down() -> mlx5_unload_one_devl_locked() ->
mlx5_detach_device() -> del_adev() -> mlx5e_remove() ->
mlx5e_destroy_devlink() -> devlink_free() ->
unregister_netdevice_notifier() (takes down_write(&pernet_ops_rwsem)

Steps to reproduce:
$ modprobe mlx5_core
$ ip netns add ns1
$ devlink dev reload pci/0000:08:00.0 netns ns1
$ ip netns del ns1

Resolve this by converting the notifier from per-devlink instance to
a static one registered during init phase and leaving it registered
forever. Use this notifier for all devlink port instances created
later on.

Note what a tree needs this fix only in case all of the cited fixes
commits are present.

Reported-by: Moshe Shemesh <moshe@nvidia.com>
Fixes: 565b4824c39f ("devlink: change port event netdev notifier from per-net to global")
Fixes: ee75f1fc44dd ("net/mlx5e: Create separate devlink instance for ethernet auxiliary device")
Fixes: 72ed5d5624af ("net/mlx5: Suspend auxiliary devices only in case of PCI device suspend")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230510144621.932017-1-jiri@resnulli.us
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/devlink/core.c          | 16 +++++++---------
 net/devlink/devl_internal.h |  1 -
 net/devlink/leftover.c      |  5 ++---
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 777b091ef74df..0e58eee44bdb2 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -204,11 +204,6 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	if (ret < 0)
 		goto err_xa_alloc;
 
-	devlink->netdevice_nb.notifier_call = devlink_port_netdevice_event;
-	ret = register_netdevice_notifier(&devlink->netdevice_nb);
-	if (ret)
-		goto err_register_netdevice_notifier;
-
 	devlink->dev = dev;
 	devlink->ops = ops;
 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
@@ -233,8 +228,6 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 
 	return devlink;
 
-err_register_netdevice_notifier:
-	xa_erase(&devlinks, devlink->index);
 err_xa_alloc:
 	kfree(devlink);
 	return NULL;
@@ -266,8 +259,6 @@ void devlink_free(struct devlink *devlink)
 	xa_destroy(&devlink->params);
 	xa_destroy(&devlink->ports);
 
-	WARN_ON_ONCE(unregister_netdevice_notifier(&devlink->netdevice_nb));
-
 	xa_erase(&devlinks, devlink->index);
 
 	devlink_put(devlink);
@@ -303,6 +294,10 @@ static struct pernet_operations devlink_pernet_ops __net_initdata = {
 	.pre_exit = devlink_pernet_pre_exit,
 };
 
+static struct notifier_block devlink_port_netdevice_nb __net_initdata = {
+	.notifier_call = devlink_port_netdevice_event,
+};
+
 static int __init devlink_init(void)
 {
 	int err;
@@ -311,6 +306,9 @@ static int __init devlink_init(void)
 	if (err)
 		goto out;
 	err = register_pernet_subsys(&devlink_pernet_ops);
+	if (err)
+		goto out;
+	err = register_netdevice_notifier(&devlink_port_netdevice_nb);
 
 out:
 	WARN_ON(err);
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index e133f423294a2..62921b2eb0d3f 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -50,7 +50,6 @@ struct devlink {
 	u8 reload_failed:1;
 	refcount_t refcount;
 	struct rcu_work rwork;
-	struct notifier_block netdevice_nb;
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index dffca2f9bfa7f..cd02549680767 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -7073,10 +7073,9 @@ int devlink_port_netdevice_event(struct notifier_block *nb,
 	struct devlink_port *devlink_port = netdev->devlink_port;
 	struct devlink *devlink;
 
-	devlink = container_of(nb, struct devlink, netdevice_nb);
-
-	if (!devlink_port || devlink_port->devlink != devlink)
+	if (!devlink_port)
 		return NOTIFY_OK;
+	devlink = devlink_port->devlink;
 
 	switch (event) {
 	case NETDEV_POST_INIT:
-- 
2.39.2



