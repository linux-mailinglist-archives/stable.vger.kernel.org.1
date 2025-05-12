Return-Path: <stable+bounces-143668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E0EAB40D0
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8FD467753
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738CE25A2C5;
	Mon, 12 May 2025 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x/H3JoFz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C4A1E505;
	Mon, 12 May 2025 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072696; cv=none; b=KkWIe6QkAqEUiKt9aCaAXPOOKEikcFggdJetWjOF+K28qooq5adQcdUUUqQHRhZjw2NADz+EEw+/yxAmsBlrePmI9FTMJDbb23FtAE6fuAj41zL4quAWMreuu+zrbj3bAtbK6e9wMA5Zaj5Vgf/wo3zSTRFLoogPOMgMO0phdS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072696; c=relaxed/simple;
	bh=r0bfkwMIIFxB/zA11TQBumM8vDkI1ePM8iUKbV/KcX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAg73zGBkfOpmlabdMUimlzzZ5okW1LlhWetbtQ4KGVVwKQbsqkykKQM0eFEsxyp4vtqjtFNUDAZYFnUwzWpnE7PWjuRJKMBl2cGiO39TxqAMdW31FCBRj7y/yxMlghPjNf7cVkVtewYvu/I9OGl9BDr1BJFS+0Kns4ehPSiJTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x/H3JoFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D189C4CEE7;
	Mon, 12 May 2025 17:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072696;
	bh=r0bfkwMIIFxB/zA11TQBumM8vDkI1ePM8iUKbV/KcX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x/H3JoFzmC46RNApUZTyrjgB4xADTLV2A/sh4W907BLHuzxDi/iPSFsNb0JraJyHy
	 3T5djBWQoTZ6OSzR+8usmpSSbEYQldIpQJl8lzTJLgug2CJuoYAf9Rl0k2OKrP5gzA
	 anWzI7AjNQBcUlEZNrrqN6kpvPOa1pjeH8WA1NyQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 027/184] can: gw: fix RCU/BH usage in cgw_create_job()
Date: Mon, 12 May 2025 19:43:48 +0200
Message-ID: <20250512172042.819742356@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
References: <20250512172041.624042835@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Hartkopp <socketcan@hartkopp.net>

[ Upstream commit 511e64e13d8cc72853275832e3f372607466c18c ]

As reported by Sebastian Andrzej Siewior the use of local_bh_disable()
is only feasible in uni processor systems to update the modification rules.
The usual use-case to update the modification rules is to update the data
of the modifications but not the modification types (AND/OR/XOR/SET) or
the checksum functions itself.

To omit additional memory allocations to maintain fast modification
switching times, the modification description space is doubled at gw-job
creation time so that only the reference to the active modification
description is changed under rcu protection.

Rename cgw_job::mod to cf_mod and make it a RCU pointer. Allocate in
cgw_create_job() and free it together with cgw_job in
cgw_job_free_rcu(). Update all users to dereference cgw_job::cf_mod with
a RCU accessor and if possible once.

[bigeasy: Replace mod1/mod2 from the Oliver's original patch with dynamic
allocation, use RCU annotation and accessor]

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Closes: https://lore.kernel.org/linux-can/20231031112349.y0aLoBrz@linutronix.de/
Fixes: dd895d7f21b2 ("can: cangw: introduce optional uid to reference created routing jobs")
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://patch.msgid.link/20250429070555.cs-7b_eZ@linutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/can/gw.c | 149 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 90 insertions(+), 59 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index 37528826935e7..e65500c52bf5c 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -130,7 +130,7 @@ struct cgw_job {
 	u32 handled_frames;
 	u32 dropped_frames;
 	u32 deleted_frames;
-	struct cf_mod mod;
+	struct cf_mod __rcu *cf_mod;
 	union {
 		/* CAN frame data source */
 		struct net_device *dev;
@@ -459,6 +459,7 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	struct cgw_job *gwj = (struct cgw_job *)data;
 	struct canfd_frame *cf;
 	struct sk_buff *nskb;
+	struct cf_mod *mod;
 	int modidx = 0;
 
 	/* process strictly Classic CAN or CAN FD frames */
@@ -506,7 +507,8 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	 * When there is at least one modification function activated,
 	 * we need to copy the skb as we want to modify skb->data.
 	 */
-	if (gwj->mod.modfunc[0])
+	mod = rcu_dereference(gwj->cf_mod);
+	if (mod->modfunc[0])
 		nskb = skb_copy(skb, GFP_ATOMIC);
 	else
 		nskb = skb_clone(skb, GFP_ATOMIC);
@@ -529,8 +531,8 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	cf = (struct canfd_frame *)nskb->data;
 
 	/* perform preprocessed modification functions if there are any */
-	while (modidx < MAX_MODFUNCTIONS && gwj->mod.modfunc[modidx])
-		(*gwj->mod.modfunc[modidx++])(cf, &gwj->mod);
+	while (modidx < MAX_MODFUNCTIONS && mod->modfunc[modidx])
+		(*mod->modfunc[modidx++])(cf, mod);
 
 	/* Has the CAN frame been modified? */
 	if (modidx) {
@@ -546,11 +548,11 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		}
 
 		/* check for checksum updates */
-		if (gwj->mod.csumfunc.crc8)
-			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
+		if (mod->csumfunc.crc8)
+			(*mod->csumfunc.crc8)(cf, &mod->csum.crc8);
 
-		if (gwj->mod.csumfunc.xor)
-			(*gwj->mod.csumfunc.xor)(cf, &gwj->mod.csum.xor);
+		if (mod->csumfunc.xor)
+			(*mod->csumfunc.xor)(cf, &mod->csum.xor);
 	}
 
 	/* clear the skb timestamp if not configured the other way */
@@ -581,9 +583,20 @@ static void cgw_job_free_rcu(struct rcu_head *rcu_head)
 {
 	struct cgw_job *gwj = container_of(rcu_head, struct cgw_job, rcu);
 
+	/* cgw_job::cf_mod is always accessed from the same cgw_job object within
+	 * the same RCU read section. Once cgw_job is scheduled for removal,
+	 * cf_mod can also be removed without mandating an additional grace period.
+	 */
+	kfree(rcu_access_pointer(gwj->cf_mod));
 	kmem_cache_free(cgw_cache, gwj);
 }
 
+/* Return cgw_job::cf_mod with RTNL protected section */
+static struct cf_mod *cgw_job_cf_mod(struct cgw_job *gwj)
+{
+	return rcu_dereference_protected(gwj->cf_mod, rtnl_is_locked());
+}
+
 static int cgw_notifier(struct notifier_block *nb,
 			unsigned long msg, void *ptr)
 {
@@ -616,6 +629,7 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 {
 	struct rtcanmsg *rtcan;
 	struct nlmsghdr *nlh;
+	struct cf_mod *mod;
 
 	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*rtcan), flags);
 	if (!nlh)
@@ -650,82 +664,83 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 			goto cancel;
 	}
 
+	mod = cgw_job_cf_mod(gwj);
 	if (gwj->flags & CGW_FLAGS_CAN_FD) {
 		struct cgw_fdframe_mod mb;
 
-		if (gwj->mod.modtype.and) {
-			memcpy(&mb.cf, &gwj->mod.modframe.and, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.and;
+		if (mod->modtype.and) {
+			memcpy(&mb.cf, &mod->modframe.and, sizeof(mb.cf));
+			mb.modtype = mod->modtype.and;
 			if (nla_put(skb, CGW_FDMOD_AND, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.or) {
-			memcpy(&mb.cf, &gwj->mod.modframe.or, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.or;
+		if (mod->modtype.or) {
+			memcpy(&mb.cf, &mod->modframe.or, sizeof(mb.cf));
+			mb.modtype = mod->modtype.or;
 			if (nla_put(skb, CGW_FDMOD_OR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.xor) {
-			memcpy(&mb.cf, &gwj->mod.modframe.xor, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.xor;
+		if (mod->modtype.xor) {
+			memcpy(&mb.cf, &mod->modframe.xor, sizeof(mb.cf));
+			mb.modtype = mod->modtype.xor;
 			if (nla_put(skb, CGW_FDMOD_XOR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.set) {
-			memcpy(&mb.cf, &gwj->mod.modframe.set, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.set;
+		if (mod->modtype.set) {
+			memcpy(&mb.cf, &mod->modframe.set, sizeof(mb.cf));
+			mb.modtype = mod->modtype.set;
 			if (nla_put(skb, CGW_FDMOD_SET, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 	} else {
 		struct cgw_frame_mod mb;
 
-		if (gwj->mod.modtype.and) {
-			memcpy(&mb.cf, &gwj->mod.modframe.and, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.and;
+		if (mod->modtype.and) {
+			memcpy(&mb.cf, &mod->modframe.and, sizeof(mb.cf));
+			mb.modtype = mod->modtype.and;
 			if (nla_put(skb, CGW_MOD_AND, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.or) {
-			memcpy(&mb.cf, &gwj->mod.modframe.or, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.or;
+		if (mod->modtype.or) {
+			memcpy(&mb.cf, &mod->modframe.or, sizeof(mb.cf));
+			mb.modtype = mod->modtype.or;
 			if (nla_put(skb, CGW_MOD_OR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.xor) {
-			memcpy(&mb.cf, &gwj->mod.modframe.xor, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.xor;
+		if (mod->modtype.xor) {
+			memcpy(&mb.cf, &mod->modframe.xor, sizeof(mb.cf));
+			mb.modtype = mod->modtype.xor;
 			if (nla_put(skb, CGW_MOD_XOR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.set) {
-			memcpy(&mb.cf, &gwj->mod.modframe.set, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.set;
+		if (mod->modtype.set) {
+			memcpy(&mb.cf, &mod->modframe.set, sizeof(mb.cf));
+			mb.modtype = mod->modtype.set;
 			if (nla_put(skb, CGW_MOD_SET, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 	}
 
-	if (gwj->mod.uid) {
-		if (nla_put_u32(skb, CGW_MOD_UID, gwj->mod.uid) < 0)
+	if (mod->uid) {
+		if (nla_put_u32(skb, CGW_MOD_UID, mod->uid) < 0)
 			goto cancel;
 	}
 
-	if (gwj->mod.csumfunc.crc8) {
+	if (mod->csumfunc.crc8) {
 		if (nla_put(skb, CGW_CS_CRC8, CGW_CS_CRC8_LEN,
-			    &gwj->mod.csum.crc8) < 0)
+			    &mod->csum.crc8) < 0)
 			goto cancel;
 	}
 
-	if (gwj->mod.csumfunc.xor) {
+	if (mod->csumfunc.xor) {
 		if (nla_put(skb, CGW_CS_XOR, CGW_CS_XOR_LEN,
-			    &gwj->mod.csum.xor) < 0)
+			    &mod->csum.xor) < 0)
 			goto cancel;
 	}
 
@@ -1059,7 +1074,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct rtcanmsg *r;
 	struct cgw_job *gwj;
-	struct cf_mod mod;
+	struct cf_mod *mod;
 	struct can_can_gw ccgw;
 	u8 limhops = 0;
 	int err = 0;
@@ -1078,37 +1093,48 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	if (r->gwtype != CGW_TYPE_CAN_CAN)
 		return -EINVAL;
 
-	err = cgw_parse_attr(nlh, &mod, CGW_TYPE_CAN_CAN, &ccgw, &limhops);
+	mod = kmalloc(sizeof(*mod), GFP_KERNEL);
+	if (!mod)
+		return -ENOMEM;
+
+	err = cgw_parse_attr(nlh, mod, CGW_TYPE_CAN_CAN, &ccgw, &limhops);
 	if (err < 0)
-		return err;
+		goto out_free_cf;
 
-	if (mod.uid) {
+	if (mod->uid) {
 		ASSERT_RTNL();
 
 		/* check for updating an existing job with identical uid */
 		hlist_for_each_entry(gwj, &net->can.cgw_list, list) {
-			if (gwj->mod.uid != mod.uid)
+			struct cf_mod *old_cf;
+
+			old_cf = cgw_job_cf_mod(gwj);
+			if (old_cf->uid != mod->uid)
 				continue;
 
 			/* interfaces & filters must be identical */
-			if (memcmp(&gwj->ccgw, &ccgw, sizeof(ccgw)))
-				return -EINVAL;
+			if (memcmp(&gwj->ccgw, &ccgw, sizeof(ccgw))) {
+				err = -EINVAL;
+				goto out_free_cf;
+			}
 
-			/* update modifications with disabled softirq & quit */
-			local_bh_disable();
-			memcpy(&gwj->mod, &mod, sizeof(mod));
-			local_bh_enable();
+			rcu_assign_pointer(gwj->cf_mod, mod);
+			kfree_rcu_mightsleep(old_cf);
 			return 0;
 		}
 	}
 
 	/* ifindex == 0 is not allowed for job creation */
-	if (!ccgw.src_idx || !ccgw.dst_idx)
-		return -ENODEV;
+	if (!ccgw.src_idx || !ccgw.dst_idx) {
+		err = -ENODEV;
+		goto out_free_cf;
+	}
 
 	gwj = kmem_cache_alloc(cgw_cache, GFP_KERNEL);
-	if (!gwj)
-		return -ENOMEM;
+	if (!gwj) {
+		err = -ENOMEM;
+		goto out_free_cf;
+	}
 
 	gwj->handled_frames = 0;
 	gwj->dropped_frames = 0;
@@ -1118,7 +1144,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	gwj->limit_hops = limhops;
 
 	/* insert already parsed information */
-	memcpy(&gwj->mod, &mod, sizeof(mod));
+	RCU_INIT_POINTER(gwj->cf_mod, mod);
 	memcpy(&gwj->ccgw, &ccgw, sizeof(ccgw));
 
 	err = -ENODEV;
@@ -1152,9 +1178,11 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	if (!err)
 		hlist_add_head_rcu(&gwj->list, &net->can.cgw_list);
 out:
-	if (err)
+	if (err) {
 		kmem_cache_free(cgw_cache, gwj);
-
+out_free_cf:
+		kfree(mod);
+	}
 	return err;
 }
 
@@ -1214,19 +1242,22 @@ static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	/* remove only the first matching entry */
 	hlist_for_each_entry_safe(gwj, nx, &net->can.cgw_list, list) {
+		struct cf_mod *cf_mod;
+
 		if (gwj->flags != r->flags)
 			continue;
 
 		if (gwj->limit_hops != limhops)
 			continue;
 
+		cf_mod = cgw_job_cf_mod(gwj);
 		/* we have a match when uid is enabled and identical */
-		if (gwj->mod.uid || mod.uid) {
-			if (gwj->mod.uid != mod.uid)
+		if (cf_mod->uid || mod.uid) {
+			if (cf_mod->uid != mod.uid)
 				continue;
 		} else {
 			/* no uid => check for identical modifications */
-			if (memcmp(&gwj->mod, &mod, sizeof(mod)))
+			if (memcmp(cf_mod, &mod, sizeof(mod)))
 				continue;
 		}
 
-- 
2.39.5




