Return-Path: <stable+bounces-171774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FB3B2C292
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 14:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B00E68286B
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 12:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C6E31576F;
	Tue, 19 Aug 2025 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQb1dC1E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBF51F1932
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604890; cv=none; b=NVeY9osEmLotkwUfp2xjsyvhzZSbb0H22706uFB5pc3+VbFsCiznbqg4HvdoUsa9+j9kkjTGXbn/yDHTOT/5IIZouADXORLszZOY5oyWsmUseN2nKyFuA2l9zBAzDbKCEm1DzDIp3sTC6REgCwCVKUxpo4nUuIJlK/Zawd3HgTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604890; c=relaxed/simple;
	bh=Btb+4Xei3oQePEF9+W9kn6yk9uV+wYU2WG/YoGUHETk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ssa7Y++rI+JNx3Fn7gEviibKcFSVn26/nY6Hs//uCFsdqTuSmWvVvccxzRePEvoctNlTrEjMhobVnLewtpns59NjojsI68vAUnsv3mHFlUs6mFyUlzvyGEpVl59VLOiPUhIeA/m7P6ay7McIXZxuoSh8ZN1847Dab1/lnBx2kds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQb1dC1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946CCC4CEF1;
	Tue, 19 Aug 2025 12:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755604890;
	bh=Btb+4Xei3oQePEF9+W9kn6yk9uV+wYU2WG/YoGUHETk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQb1dC1EeqOuFFS4zVVR5U+byX69TCGbkJfE2/BN2e/w1Xg0gaEtaHSKsyPiLayCg
	 myfcxjc1ElzOo/WGNMV7amnIrTjamguPflY4Su1bXE9M0sBOYQPZ9QapN6NQfUiZ36
	 JS5ldsgJEw+mTN5LbBapjoNyZ6Tg1oXGLB+EBl6WMk7AgSAhaV3LJq+rzAhD55R8U3
	 XUxZ1RH/U3JcMwBJgpJ17+WlujlcpcxcCUlJ/a/iR8VO+xC6ugPaRoNPySk/mU4Wv3
	 4RyKlEGmrXk4JUC5OavFWmO4ZQ+Nk/6fqJMTSIZNadMhXR/MH7ZXQSGkfa1087hfPR
	 Vb9kvcFutCR3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] hv_netvsc: Fix panic during namespace deletion with VF
Date: Tue, 19 Aug 2025 08:01:27 -0400
Message-ID: <20250819120127.451817-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081828-apprehend-wielder-0625@gregkh>
References: <2025081828-apprehend-wielder-0625@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Upstream commit 33caa208dba6fa639e8a92fd0c8320b652e5550c ]

The existing code move the VF NIC to new namespace when NETDEV_REGISTER is
received on netvsc NIC. During deletion of the namespace,
default_device_exit_batch() >> default_device_exit_net() is called. When
netvsc NIC is moved back and registered to the default namespace, it
automatically brings VF NIC back to the default namespace. This will cause
the default_device_exit_net() >> for_each_netdev_safe loop unable to detect
the list end, and hit NULL ptr:

[  231.449420] mana 7870:00:00.0 enP30832s1: Moved VF to namespace with: eth0
[  231.449656] BUG: kernel NULL pointer dereference, address: 0000000000000010
[  231.450246] #PF: supervisor read access in kernel mode
[  231.450579] #PF: error_code(0x0000) - not-present page
[  231.450916] PGD 17b8a8067 P4D 0
[  231.451163] Oops: Oops: 0000 [#1] SMP NOPTI
[  231.451450] CPU: 82 UID: 0 PID: 1394 Comm: kworker/u768:1 Not tainted 6.16.0-rc4+ #3 VOLUNTARY
[  231.452042] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 11/21/2024
[  231.452692] Workqueue: netns cleanup_net
[  231.452947] RIP: 0010:default_device_exit_batch+0x16c/0x3f0
[  231.453326] Code: c0 0c f5 b3 e8 d5 db fe ff 48 85 c0 74 15 48 c7 c2 f8 fd ca b2 be 10 00 00 00 48 8d 7d c0 e8 7b 77 25 00 49 8b 86 28 01 00 00 <48> 8b 50 10 4c 8b 2a 4c 8d 62 f0 49 83 ed 10 4c 39 e0 0f 84 d6 00
[  231.454294] RSP: 0018:ff75fc7c9bf9fd00 EFLAGS: 00010246
[  231.454610] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 61c8864680b583eb
[  231.455094] RDX: ff1fa9f71462d800 RSI: ff75fc7c9bf9fd38 RDI: 0000000030766564
[  231.455686] RBP: ff75fc7c9bf9fd78 R08: 0000000000000000 R09: 0000000000000000
[  231.456126] R10: 0000000000000001 R11: 0000000000000004 R12: ff1fa9f70088e340
[  231.456621] R13: ff1fa9f70088e340 R14: ffffffffb3f50c20 R15: ff1fa9f7103e6340
[  231.457161] FS:  0000000000000000(0000) GS:ff1faa6783a08000(0000) knlGS:0000000000000000
[  231.457707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  231.458031] CR2: 0000000000000010 CR3: 0000000179ab2006 CR4: 0000000000b73ef0
[  231.458434] Call Trace:
[  231.458600]  <TASK>
[  231.458777]  ops_undo_list+0x100/0x220
[  231.459015]  cleanup_net+0x1b8/0x300
[  231.459285]  process_one_work+0x184/0x340

To fix it, move the ns change to a workqueue, and take rtnl_lock to avoid
changing the netdev list when default_device_exit_net() is using it.

Cc: stable@vger.kernel.org
Fixes: 4c262801ea60 ("hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Link: https://patch.msgid.link/1754511711-11188-1-git-send-email-haiyangz@linux.microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/hyperv_net.h |  3 +++
 drivers/net/hyperv/netvsc_drv.c | 29 ++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 15652d7951f9..4ee5ee2eb852 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -985,6 +985,7 @@ struct net_device_context {
 	struct net_device __rcu *vf_netdev;
 	struct netvsc_vf_pcpu_stats __percpu *vf_stats;
 	struct delayed_work vf_takeover;
+	struct delayed_work vfns_work;
 
 	/* 1: allocated, serial number is valid. 0: not allocated */
 	u32 vf_alloc;
@@ -999,6 +1000,8 @@ struct net_device_context {
 	struct netvsc_device_info *saved_netvsc_dev_info;
 };
 
+void netvsc_vfns_work(struct work_struct *w);
+
 /* Per channel data */
 struct netvsc_channel {
 	struct vmbus_channel *channel;
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 9ae4f88ab455..f9f10800968b 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2541,6 +2541,7 @@ static int netvsc_probe(struct hv_device *dev,
 	spin_lock_init(&net_device_ctx->lock);
 	INIT_LIST_HEAD(&net_device_ctx->reconfig_events);
 	INIT_DELAYED_WORK(&net_device_ctx->vf_takeover, netvsc_vf_setup);
+	INIT_DELAYED_WORK(&net_device_ctx->vfns_work, netvsc_vfns_work);
 
 	net_device_ctx->vf_stats
 		= netdev_alloc_pcpu_stats(struct netvsc_vf_pcpu_stats);
@@ -2679,6 +2680,8 @@ static int netvsc_remove(struct hv_device *dev)
 	cancel_delayed_work_sync(&ndev_ctx->dwork);
 
 	rtnl_lock();
+	cancel_delayed_work_sync(&ndev_ctx->vfns_work);
+
 	nvdev = rtnl_dereference(ndev_ctx->nvdev);
 	if (nvdev) {
 		cancel_work_sync(&nvdev->subchan_work);
@@ -2721,6 +2724,7 @@ static int netvsc_suspend(struct hv_device *dev)
 	cancel_delayed_work_sync(&ndev_ctx->dwork);
 
 	rtnl_lock();
+	cancel_delayed_work_sync(&ndev_ctx->vfns_work);
 
 	nvdev = rtnl_dereference(ndev_ctx->nvdev);
 	if (nvdev == NULL) {
@@ -2814,6 +2818,27 @@ static void netvsc_event_set_vf_ns(struct net_device *ndev)
 	}
 }
 
+void netvsc_vfns_work(struct work_struct *w)
+{
+	struct net_device_context *ndev_ctx =
+		container_of(w, struct net_device_context, vfns_work.work);
+	struct net_device *ndev;
+
+	if (!rtnl_trylock()) {
+		schedule_delayed_work(&ndev_ctx->vfns_work, 1);
+		return;
+	}
+
+	ndev = hv_get_drvdata(ndev_ctx->device_ctx);
+	if (!ndev)
+		goto out;
+
+	netvsc_event_set_vf_ns(ndev);
+
+out:
+	rtnl_unlock();
+}
+
 /*
  * On Hyper-V, every VF interface is matched with a corresponding
  * synthetic interface. The synthetic interface is presented first
@@ -2824,10 +2849,12 @@ static int netvsc_netdev_event(struct notifier_block *this,
 			       unsigned long event, void *ptr)
 {
 	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
+	struct net_device_context *ndev_ctx;
 	int ret = 0;
 
 	if (event_dev->netdev_ops == &device_ops && event == NETDEV_REGISTER) {
-		netvsc_event_set_vf_ns(event_dev);
+		ndev_ctx = netdev_priv(event_dev);
+		schedule_delayed_work(&ndev_ctx->vfns_work, 0);
 		return NOTIFY_DONE;
 	}
 
-- 
2.50.1


