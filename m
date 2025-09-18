Return-Path: <stable+bounces-180002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B364B7E4AD
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E5818890FB
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9CC31A80B;
	Wed, 17 Sep 2025 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uoKQHb+q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C76C2EC0A8;
	Wed, 17 Sep 2025 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113069; cv=none; b=anu5GLaU/UBlriuRV4+QZcx+iZz3FuXR8UBKBs4jF0phxL/SjsJM3ClP2ndYn6zUP+db9cXJyK2A3ZDDqa9ijVcV2IhoB0K6fDkPTih6qZyfQPty/nJUe38msXREdNCY/FugBpXKF2WdYfXnoU5Dfb4TzM2pBw6il3fF9tGBH94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113069; c=relaxed/simple;
	bh=B5Vezxou9dOQxP8ltvcb+MX6uslwqyS4s9OXGgyNZHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxpluke+U02C0BG7JBtYSvRb+jpUpnVu6Vwt1mzsihXcZNJT2vIVh7QL7hBEc1vujq4yDuvWkEnYnZxT8kMxd/tAJHLF4M2vqNgydfisK2FY1djqrZ/tpN8wZTz3y/kCfv6AsLnpe3hpDFSwWQz3n49nsd9YXKZqg3l6nZIhPXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uoKQHb+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DF9C4CEF7;
	Wed, 17 Sep 2025 12:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113068;
	bh=B5Vezxou9dOQxP8ltvcb+MX6uslwqyS4s9OXGgyNZHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uoKQHb+qIJWNq8PSTZoeQjy3iyPUT+o0lBhrCf3yhrfj0ULW4vfFvIi9aSDJ4y3PK
	 8JiBkM7Unk9m9OE7NJSPRQy0cJxd3WwhtafM/REkaFYBOgh5AGag0KaK8xYFnbzXE3
	 MTKcil7HsHvUe0hJd4L0tnrkWwoGhJu88bE19qzg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 163/189] hsr: use rtnl lock when iterating over ports
Date: Wed, 17 Sep 2025 14:34:33 +0200
Message-ID: <20250917123355.856749370@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
References: <20250917123351.839989757@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 8884c693991333ae065830554b9b0c96590b1bb2 ]

hsr_for_each_port is called in many places without holding the RCU read
lock, this may trigger warnings on debug kernels. Most of the callers
are actually hold rtnl lock. So add a new helper hsr_for_each_port_rtnl
to allow callers in suitable contexts to iterate ports safely without
explicit RCU locking.

This patch only fixed the callers that is hold rtnl lock. Other caller
issues will be fixed in later patches.

Fixes: c5a759117210 ("net/hsr: Use list_head (and rcu) instead of array for slave devices.")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250905091533.377443-2-liuhangbin@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_device.c | 18 +++++++++---------
 net/hsr/hsr_main.c   |  2 +-
 net/hsr/hsr_main.h   |  3 +++
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 88657255fec12..bce7b4061ce08 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -49,7 +49,7 @@ static bool hsr_check_carrier(struct hsr_port *master)
 
 	ASSERT_RTNL();
 
-	hsr_for_each_port(master->hsr, port) {
+	hsr_for_each_port_rtnl(master->hsr, port) {
 		if (port->type != HSR_PT_MASTER && is_slave_up(port->dev)) {
 			netif_carrier_on(master->dev);
 			return true;
@@ -105,7 +105,7 @@ int hsr_get_max_mtu(struct hsr_priv *hsr)
 	struct hsr_port *port;
 
 	mtu_max = ETH_DATA_LEN;
-	hsr_for_each_port(hsr, port)
+	hsr_for_each_port_rtnl(hsr, port)
 		if (port->type != HSR_PT_MASTER)
 			mtu_max = min(port->dev->mtu, mtu_max);
 
@@ -139,7 +139,7 @@ static int hsr_dev_open(struct net_device *dev)
 
 	hsr = netdev_priv(dev);
 
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
@@ -172,7 +172,7 @@ static int hsr_dev_close(struct net_device *dev)
 	struct hsr_priv *hsr;
 
 	hsr = netdev_priv(dev);
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
@@ -205,7 +205,7 @@ static netdev_features_t hsr_features_recompute(struct hsr_priv *hsr,
 	 * may become enabled.
 	 */
 	features &= ~NETIF_F_ONE_FOR_ALL;
-	hsr_for_each_port(hsr, port)
+	hsr_for_each_port_rtnl(hsr, port)
 		features = netdev_increment_features(features,
 						     port->dev->features,
 						     mask);
@@ -484,7 +484,7 @@ static void hsr_set_rx_mode(struct net_device *dev)
 
 	hsr = netdev_priv(dev);
 
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
@@ -506,7 +506,7 @@ static void hsr_change_rx_flags(struct net_device *dev, int change)
 
 	hsr = netdev_priv(dev);
 
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
@@ -534,7 +534,7 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
 
 	hsr = netdev_priv(dev);
 
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER ||
 		    port->type == HSR_PT_INTERLINK)
 			continue;
@@ -580,7 +580,7 @@ static int hsr_ndo_vlan_rx_kill_vid(struct net_device *dev,
 
 	hsr = netdev_priv(dev);
 
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		switch (port->type) {
 		case HSR_PT_SLAVE_A:
 		case HSR_PT_SLAVE_B:
diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index 192893c3f2ec7..ac1eb1db1a52b 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -22,7 +22,7 @@ static bool hsr_slave_empty(struct hsr_priv *hsr)
 {
 	struct hsr_port *port;
 
-	hsr_for_each_port(hsr, port)
+	hsr_for_each_port_rtnl(hsr, port)
 		if (port->type != HSR_PT_MASTER)
 			return false;
 	return true;
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 135ec5fce0196..33b0d2460c9bc 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -224,6 +224,9 @@ struct hsr_priv {
 #define hsr_for_each_port(hsr, port) \
 	list_for_each_entry_rcu((port), &(hsr)->ports, port_list)
 
+#define hsr_for_each_port_rtnl(hsr, port) \
+	list_for_each_entry_rcu((port), &(hsr)->ports, port_list, lockdep_rtnl_is_held())
+
 struct hsr_port *hsr_port_get_hsr(struct hsr_priv *hsr, enum hsr_port_type pt);
 
 /* Caller must ensure skb is a valid HSR frame */
-- 
2.51.0




