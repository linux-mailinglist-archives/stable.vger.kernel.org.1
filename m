Return-Path: <stable+bounces-144697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FB3ABADAD
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 05:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57253BCE57
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 03:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C4C13B2A4;
	Sun, 18 May 2025 03:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YZVFu5hN"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C4A152E02
	for <stable@vger.kernel.org>; Sun, 18 May 2025 03:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747539971; cv=none; b=rfn0JCqS5Z/WrbatOctQGvn9zztkLDPe4gyzm5VhWo6/7vW8WbGv8qHNZ+veH+ALunOevf1m2Df3CJZ1Z82T/9dxvbBTnt/JnzwnMn1tjcyDjTtnYZpVtvIzcpKG5oxhclinO0LaBV/C04zx+QCGp5AD0xk5e9KU/PBTK2DCvpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747539971; c=relaxed/simple;
	bh=aXvJKxmzfESpaedYEM0k3r230KTw/3k6G8+3Tse+Lhs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=SiVZk8Jl4U0a8hgyb8zuMpuDHNk5ffHKATlhwQKAJb2px+UaHkY3U+ImklLlqMIlKjIQ3dMyTJ/wnevgwsXeuzuMcjosG2NW5u6ZVcHjUx1TkcZEdpONymkOGd6Sg7o6rXPfulpxEzefvV0LaYlfNuuF2A31/TDCVnykbeOxjT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YZVFu5hN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id B905D20277FE; Sat, 17 May 2025 20:46:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B905D20277FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747539969;
	bh=lPGYH1glaOFQwG0Qf4sdwd5qCLAWVCDmPlEySsWR4Kg=;
	h=From:To:Cc:Subject:Date:From;
	b=YZVFu5hNn5B/6ZcyI8N+lV4bZjBscpuGSM4OQXHe+7+xV9aOIuYhpp06pyvXANrmZ
	 VitEc5x57JtQm06HuOapnJHzyXRcZ3VjNx1ZQdOc9nn7NFrN4fvEH6ZKGzk5YmnRrK
	 VWe23r16gYElr1eOVBzSUq8G7kRKSRqW+eZdA/Ls=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: ssengar@microsoft.com
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH net] hv_netvsc: fix potential deadlock in netvsc_vf_setxdp()
Date: Sat, 17 May 2025 20:46:07 -0700
Message-Id: <1747539967-10795-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The MANA driver's probe registers netdevice via the following call chain:

mana_probe()
  register_netdev()
    register_netdevice()

register_netdevice() calls notifier callback for netvsc driver,
holding the netdev mutex via netdev_lock_ops().

Further this netvsc notifier callback end up attempting to acquire the
same lock again in dev_xdp_propagate() leading to deadlock.

netvsc_netdev_event()
  netvsc_vf_setxdp()
    dev_xdp_propagate()

This deadlock was not observed so far because net_shaper_ops was never
set and this lock in noop in this case. Fix this by using
netif_xdp_propagate instead of dev_xdp_propagate to avoid recursive
locking in this path.

This issue has not observed so far because net_shaper_ops was unset,
making the lock path effectively a no-op. To prevent recursive locking
and avoid this deadlock, replace dev_xdp_propagate() with
netif_xdp_propagate(), which does not acquire the lock again.

Also, clean up the unregistration path by removing unnecessary call to
netvsc_vf_setxdp(), since unregister_netdevice_many_notify() already
performs this cleanup via dev_xdp_uninstall.

Fixes: 97246d6d21c2 ("net: hold netdev instance lock during ndo_bpf")
Cc: stable@vger.kernel.org
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/net/hyperv/netvsc_bpf.c | 2 +-
 drivers/net/hyperv/netvsc_drv.c | 2 --
 net/core/dev.c                  | 1 +
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
index e01c5997a551..1dd3755d9e6d 100644
--- a/drivers/net/hyperv/netvsc_bpf.c
+++ b/drivers/net/hyperv/netvsc_bpf.c
@@ -183,7 +183,7 @@ int netvsc_vf_setxdp(struct net_device *vf_netdev, struct bpf_prog *prog)
 	xdp.command = XDP_SETUP_PROG;
 	xdp.prog = prog;
 
-	ret = dev_xdp_propagate(vf_netdev, &xdp);
+	ret = netif_xdp_propagate(vf_netdev, &xdp);
 
 	if (ret && prog)
 		bpf_prog_put(prog);
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index d8b169ac0343..ee3aaf9c10e6 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2462,8 +2462,6 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
 
 	netdev_info(ndev, "VF unregistering: %s\n", vf_netdev->name);
 
-	netvsc_vf_setxdp(vf_netdev, NULL);
-
 	reinit_completion(&net_device_ctx->vf_add);
 	netdev_rx_handler_unregister(vf_netdev);
 	netdev_upper_dev_unlink(vf_netdev, ndev);
diff --git a/net/core/dev.c b/net/core/dev.c
index fccf2167b235..8c6c9d7fba26 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9953,6 +9953,7 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 
 	return dev->netdev_ops->ndo_bpf(dev, bpf);
 }
+EXPORT_SYMBOL_GPL(netif_xdp_propagate);
 
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
 {
-- 
2.43.0


