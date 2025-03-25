Return-Path: <stable+bounces-126058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A27A6FEAA
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D54E3BEE37
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21074259CA2;
	Tue, 25 Mar 2025 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iHyxzBu+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ADA25743E;
	Tue, 25 Mar 2025 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905522; cv=none; b=CVlJtHsAzs33tb9nRVvWj6zxpbSbbJYge82bl1QhdIDphovrDvYCYdzWIndGTwiMfc/KKsfyqMoem5XPEqxooxKVfKcPdy93AWUbAo7jhd5QEnCjQMwHVisJMyZ/fpuqsoKQvab7759B+kElyoCgHFTHKZ/8DOsrFiUJ0JWHBN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905522; c=relaxed/simple;
	bh=q34DP8ZYHxUHMcREBlbb/o2AR9XXh4Egb1vsQeAgSig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtMVlSlarkZB/aNH8uZ+/Fr7Wu+Ktcto4f5H5EJor13F2bZFmOzhVytSmu6WQiaZFGhU65MhrwAdadgAg0iZ59UbtmXAOd5dlOu0SsYxbPtPiFC+tm/lERAOKW/kuz/O0KFc0iW46eujoCbcdE8tPk4p77HAaef0jufvyH/d+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iHyxzBu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDC2C4CEE9;
	Tue, 25 Mar 2025 12:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742905522;
	bh=q34DP8ZYHxUHMcREBlbb/o2AR9XXh4Egb1vsQeAgSig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iHyxzBu+iSwRRxTaKA7jNJsYo85/lQtn7vysWERnuEgpLVpt+hr40IGwGwQF0yumX
	 80+sR+5KrmcE1uunAk+W11GU+xU/AtzVLhg/TCm68csGT3vrkyS/JSNn4BqAUKYcit
	 MrM4X7nYzajc5tXYY5sO7vQxkv36D4di5XYTWIqM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amit Cohen <amcohen@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 021/198] net: switchdev: Convert blocking notification chain to a raw one
Date: Tue, 25 Mar 2025 08:19:43 -0400
Message-ID: <20250325122157.197684878@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122156.633329074@linuxfoundation.org>
References: <20250325122156.633329074@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amit Cohen <amcohen@nvidia.com>

[ Upstream commit 62531a1effa87bdab12d5104015af72e60d926ff ]

A blocking notification chain uses a read-write semaphore to protect the
integrity of the chain. The semaphore is acquired for writing when
adding / removing notifiers to / from the chain and acquired for reading
when traversing the chain and informing notifiers about an event.

In case of the blocking switchdev notification chain, recursive
notifications are possible which leads to the semaphore being acquired
twice for reading and to lockdep warnings being generated [1].

Specifically, this can happen when the bridge driver processes a
SWITCHDEV_BRPORT_UNOFFLOADED event which causes it to emit notifications
about deferred events when calling switchdev_deferred_process().

Fix this by converting the notification chain to a raw notification
chain in a similar fashion to the netdev notification chain. Protect
the chain using the RTNL mutex by acquiring it when modifying the chain.
Events are always informed under the RTNL mutex, but add an assertion in
call_switchdev_blocking_notifiers() to make sure this is not violated in
the future.

Maintain the "blocking" prefix as events are always emitted from process
context and listeners are allowed to block.

[1]:
WARNING: possible recursive locking detected
6.14.0-rc4-custom-g079270089484 #1 Not tainted
--------------------------------------------
ip/52731 is trying to acquire lock:
ffffffff850918d8 ((switchdev_blocking_notif_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x58/0xa0

but task is already holding lock:
ffffffff850918d8 ((switchdev_blocking_notif_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x58/0xa0

other info that might help us debug this:
Possible unsafe locking scenario:
CPU0
----
lock((switchdev_blocking_notif_chain).rwsem);
lock((switchdev_blocking_notif_chain).rwsem);

*** DEADLOCK ***
May be due to missing lock nesting notation
3 locks held by ip/52731:
 #0: ffffffff84f795b0 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x727/0x1dc0
 #1: ffffffff8731f628 (&net->rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x790/0x1dc0
 #2: ffffffff850918d8 ((switchdev_blocking_notif_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x58/0xa0

stack backtrace:
...
? __pfx_down_read+0x10/0x10
? __pfx_mark_lock+0x10/0x10
? __pfx_switchdev_port_attr_set_deferred+0x10/0x10
blocking_notifier_call_chain+0x58/0xa0
switchdev_port_attr_notify.constprop.0+0xb3/0x1b0
? __pfx_switchdev_port_attr_notify.constprop.0+0x10/0x10
? mark_held_locks+0x94/0xe0
? switchdev_deferred_process+0x11a/0x340
switchdev_port_attr_set_deferred+0x27/0xd0
switchdev_deferred_process+0x164/0x340
br_switchdev_port_unoffload+0xc8/0x100 [bridge]
br_switchdev_blocking_event+0x29f/0x580 [bridge]
notifier_call_chain+0xa2/0x440
blocking_notifier_call_chain+0x6e/0xa0
switchdev_bridge_port_unoffload+0xde/0x1a0
...

Fixes: f7a70d650b0b6 ("net: bridge: switchdev: Ensure deferred event delivery on unoffload")
Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Tested-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://patch.msgid.link/20250305121509.631207-1-amcohen@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/switchdev/switchdev.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 2e14d4c37e2dc..9aec24490e8fd 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -381,7 +381,7 @@ bool switchdev_port_obj_act_is_deferred(struct net_device *dev,
 EXPORT_SYMBOL_GPL(switchdev_port_obj_act_is_deferred);
 
 static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
-static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
+static RAW_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
 
 /**
  *	register_switchdev_notifier - Register notifier
@@ -427,17 +427,27 @@ EXPORT_SYMBOL_GPL(call_switchdev_notifiers);
 
 int register_switchdev_blocking_notifier(struct notifier_block *nb)
 {
-	struct blocking_notifier_head *chain = &switchdev_blocking_notif_chain;
+	struct raw_notifier_head *chain = &switchdev_blocking_notif_chain;
+	int err;
+
+	rtnl_lock();
+	err = raw_notifier_chain_register(chain, nb);
+	rtnl_unlock();
 
-	return blocking_notifier_chain_register(chain, nb);
+	return err;
 }
 EXPORT_SYMBOL_GPL(register_switchdev_blocking_notifier);
 
 int unregister_switchdev_blocking_notifier(struct notifier_block *nb)
 {
-	struct blocking_notifier_head *chain = &switchdev_blocking_notif_chain;
+	struct raw_notifier_head *chain = &switchdev_blocking_notif_chain;
+	int err;
 
-	return blocking_notifier_chain_unregister(chain, nb);
+	rtnl_lock();
+	err = raw_notifier_chain_unregister(chain, nb);
+	rtnl_unlock();
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(unregister_switchdev_blocking_notifier);
 
@@ -445,10 +455,11 @@ int call_switchdev_blocking_notifiers(unsigned long val, struct net_device *dev,
 				      struct switchdev_notifier_info *info,
 				      struct netlink_ext_ack *extack)
 {
+	ASSERT_RTNL();
 	info->dev = dev;
 	info->extack = extack;
-	return blocking_notifier_call_chain(&switchdev_blocking_notif_chain,
-					    val, info);
+	return raw_notifier_call_chain(&switchdev_blocking_notif_chain,
+				       val, info);
 }
 EXPORT_SYMBOL_GPL(call_switchdev_blocking_notifiers);
 
-- 
2.39.5




