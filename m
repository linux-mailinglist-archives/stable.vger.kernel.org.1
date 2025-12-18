Return-Path: <stable+bounces-202984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6FACCC0A4
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 14:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3897300769D
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 13:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC2F246768;
	Thu, 18 Dec 2025 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hjWyjfPz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82A12F3621
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766065114; cv=none; b=ulDzAhIUsV38P1zHtdB76LfzSA0F7MG3/bf7ija04n9Ha3wVZllYPg2cNfkcr5wVEj/DotnQUicmo42t3agBa8ymHae3Zd1QtnVZAFq5iwskFBqwhfo6Wb+Y3KWtI9BUEdIWekGiNYH6QiMO3EmxuwosTB0PDW7F792P58VOiPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766065114; c=relaxed/simple;
	bh=Xe7umJ5ONAlfzhCxqk4q9NeOLsI8K2/1fG4G9HTmQt0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nHl8zyGvFeHyFXJKl41HZhODAieWlt+dLUB4qOI0+lZGkQOrromiKKzAxntZ5Wy5T9K8K0u5iCpdFNLL8+51/XIDwXvIusWrbJkiI7FdD/ewAyyxhhXwUv6uhtLPW0GdWidSIPEPIQB/7MXQTwLVjYLONikPKAGJc93nDVBla7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hjWyjfPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B2DC4CEFB;
	Thu, 18 Dec 2025 13:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766065112;
	bh=Xe7umJ5ONAlfzhCxqk4q9NeOLsI8K2/1fG4G9HTmQt0=;
	h=Subject:To:Cc:From:Date:From;
	b=hjWyjfPzZa530dfV6SfX0/Q2xc01bOaMH6m/jhY+zXuoNQeG5/qoKt6vnrdDQPlZj
	 d/fKuWqhcVgUTaaoxOgL3s77RECpGt9bv4yuBh+2EFmnzRIqDR1Z4rkMIby1jf8FBq
	 h1/PXOcAcYDHNSB3OmMKnwXnag5i18q3wjcphWdc=
Subject: FAILED: patch "[PATCH] hsr: hold rcu and dev lock for hsr_get_port_ndev" failed to apply to 6.12-stable tree
To: liuhangbin@gmail.com,horms@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 18 Dec 2025 14:38:29 +0100
Message-ID: <2025121829-aloof-cresting-f057@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 847748fc66d08a89135a74e29362a66ba4e3ab15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025121829-aloof-cresting-f057@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 847748fc66d08a89135a74e29362a66ba4e3ab15 Mon Sep 17 00:00:00 2001
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Fri, 5 Sep 2025 09:15:33 +0000
Subject: [PATCH] hsr: hold rcu and dev lock for hsr_get_port_ndev

hsr_get_port_ndev calls hsr_for_each_port, which need to hold rcu lock.
On the other hand, before return the port device, we need to hold the
device reference to avoid UaF in the caller function.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Fixes: 9c10dd8eed74 ("net: hsr: Create and export hsr_get_port_ndev()")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250905091533.377443-4-liuhangbin@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index dadce6009791..e42d0fdefee1 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -654,7 +654,7 @@ static void icssg_prueth_hsr_fdb_add_del(struct prueth_emac *emac,
 
 static int icssg_prueth_hsr_add_mcast(struct net_device *ndev, const u8 *addr)
 {
-	struct net_device *real_dev;
+	struct net_device *real_dev, *port_dev;
 	struct prueth_emac *emac;
 	u8 vlan_id, i;
 
@@ -663,11 +663,15 @@ static int icssg_prueth_hsr_add_mcast(struct net_device *ndev, const u8 *addr)
 
 	if (is_hsr_master(real_dev)) {
 		for (i = HSR_PT_SLAVE_A; i < HSR_PT_INTERLINK; i++) {
-			emac = netdev_priv(hsr_get_port_ndev(real_dev, i));
-			if (!emac)
+			port_dev = hsr_get_port_ndev(real_dev, i);
+			emac = netdev_priv(port_dev);
+			if (!emac) {
+				dev_put(port_dev);
 				return -EINVAL;
+			}
 			icssg_prueth_hsr_fdb_add_del(emac, addr, vlan_id,
 						     true);
+			dev_put(port_dev);
 		}
 	} else {
 		emac = netdev_priv(real_dev);
@@ -679,7 +683,7 @@ static int icssg_prueth_hsr_add_mcast(struct net_device *ndev, const u8 *addr)
 
 static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
 {
-	struct net_device *real_dev;
+	struct net_device *real_dev, *port_dev;
 	struct prueth_emac *emac;
 	u8 vlan_id, i;
 
@@ -688,11 +692,15 @@ static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
 
 	if (is_hsr_master(real_dev)) {
 		for (i = HSR_PT_SLAVE_A; i < HSR_PT_INTERLINK; i++) {
-			emac = netdev_priv(hsr_get_port_ndev(real_dev, i));
-			if (!emac)
+			port_dev = hsr_get_port_ndev(real_dev, i);
+			emac = netdev_priv(port_dev);
+			if (!emac) {
+				dev_put(port_dev);
 				return -EINVAL;
+			}
 			icssg_prueth_hsr_fdb_add_del(emac, addr, vlan_id,
 						     false);
+			dev_put(port_dev);
 		}
 	} else {
 		emac = netdev_priv(real_dev);
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 702da1f9aaa9..fbbc3ccf9df6 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -675,9 +675,14 @@ struct net_device *hsr_get_port_ndev(struct net_device *ndev,
 	struct hsr_priv *hsr = netdev_priv(ndev);
 	struct hsr_port *port;
 
+	rcu_read_lock();
 	hsr_for_each_port(hsr, port)
-		if (port->type == pt)
+		if (port->type == pt) {
+			dev_hold(port->dev);
+			rcu_read_unlock();
 			return port->dev;
+		}
+	rcu_read_unlock();
 	return NULL;
 }
 EXPORT_SYMBOL(hsr_get_port_ndev);


