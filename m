Return-Path: <stable+bounces-242142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIIrGgZ382mt4AEAu9opvQ
	(envelope-from <stable+bounces-242142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:36:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE864A4E3A
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C5C5302B67C
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2F22F6591;
	Thu, 30 Apr 2026 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KerBlWb7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130F22F3C1F
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562820; cv=none; b=BNoDrv7FgM+8v8zrW+NYT2PiwA2D7ynVGN9V28J3QZBN+bZYVw8ZM4+u7tmyZ5VQFNIHCBQY6dBRiFJHfLRWn0muSOVLUcLMtKHDsD5D5TzemKi9qdSz8trJhQXyqAzivSKxunwiuZDHCB3qSkurq/azuGUXIxkYVlKQaDxHzMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562820; c=relaxed/simple;
	bh=6F4FIqvRlAxLMiyzjB1a0Loef1xYOuziOaEvpkQ9tjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxkUJZHgFrMa6/pLjCBo0+u39zH21DI/hbXbI0Y1uD/6o68L+xy4TntJ7z91JrBZPnn4dZSs/9SNsMWkWcEiyf6pOfwf6uj+YFFrKRqUs6ciGklU/ZrR1rkfQn+kV6t6BC8RwlrVNAZPlTMd4CCTraUoA6NIyI82twOBp6J50ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KerBlWb7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488d2079582so11230375e9.2
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 08:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777562817; x=1778167617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MHpRBHdNTVeiHYde/smY3bJSKHcAn6/QCWkGp6rSLM=;
        b=KerBlWb7yOqd28BOJiJBdcMSQUAbQZReki+t+ubmAXUgGvtpxa/8sWQVvPhVrxsEVf
         zVCJZGQeS++RQj4hZk6PoEyJEh3vPYw8MtdZ7q+WdErsNGRBJ/USQkPMzrm8DbVEIVJ8
         VmZzVuBbK6aDXgVvXKvM/v7eJzCq7HUWcIx2R6WmumsinyUXz42vL9JwArw/JyUx1jWF
         y3G1HUPArFxsTTRh4M37lNRgL3++KnNJvCCvEMzY+Vdjh6O2xtP3Q/s0Eh3csSK5LRVA
         3u71n2ViUOcFaW9+a3DSeMsL5rK9zrgpIDXaxgwa7n6VCzC3PIEEnuMu6OreeqwK2+Mf
         6nQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777562817; x=1778167617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/MHpRBHdNTVeiHYde/smY3bJSKHcAn6/QCWkGp6rSLM=;
        b=TYL1vC19YL8OOYmg8Fx3asBS648lMs3KQxnwmv5Lt0GUMJ61ELgtLtBrx4yp0qIz14
         2Udai+fpatgH5xjP82ymGCn7+LgUFkfJrK9W6J6PjYQBMWLmK0CiKBpYoD/SKvgKpwDv
         H/009gsBShol0tWeznvEOU157mC0zTvWpGugppALQFDqN6sx5ehD9aozpVDHoh6kmzWf
         0s2NBSDJYuMtKmHNcNuAX5B954XynMXj59xL3dHRXgfnzGZkWkeBYoJNKfm+AWYHX07s
         2q3r83ituOPi363TvoAhkgExwmXQjLAOvst6DIrPo/qwIEf4P8HH49uCEJ7ZN0PIJOt2
         M5xg==
X-Gm-Message-State: AOJu0Yyw9aK6HVmYYtdtNOyAzIyXUQZTMWuoCKReDRDnPlxFDk00SWsh
	gXC8KOYm/Jdgw5S2q9b/OlZxU0vjMrog3SIjDom92xRMmMF8wom2fPdJ
X-Gm-Gg: AeBDiesGwHABcDIjv7NxeS+e5qeoBoW/DiE0EnW0KmSovgRhovWg4B7lMxpYiEYBhfK
	v6kjC6oVrXH7qE6ELB6MMuSqjKcSnTewVUclSCRD0gwQ0p9B9x5xpGg3WJDTn94chYsyJnvQz2/
	eC0Xa1fRv8OJ/3dA42zhU4SsgtI0CaSMInQdMeUx8DgwZ/zynIYpesXWUT9yy0LaG/bStt2TavW
	wCqG53NOi8jvl52s74LSoj0GXNumA0JP/BlVkomdwKd921kGpF5eAUvKMb+SLEPAOdZsicjj4+G
	xBsUEHUPiBSdsSGjyz6M/hFkUPBXnkeB2xU750NENpWyjQvlOgp8aR6MjyzDSRUZSt1tFvAd9VR
	d1/oW5MVH1d4t6Gpfs9dtl+tC9m6U8YSzjIP/85qrluiIU05LpSj2ojhq6/SrW5IZkY/BGVpXIt
	Fl7Z6i44gTUNuM8ijAwMpEJLgeYfrmdW0dAguHl0kOInnCLmqVgmgquCrPTWmYzZhSDLL2G05UM
	qQ9EAyag9EWeYbmLiEvnz7S4Ta9U4SEyycs9g==
X-Received: by 2002:a05:600c:198b:b0:488:a2ac:a334 with SMTP id 5b1f17b1804b1-48a83d66cb9mr58464225e9.3.1777562817130;
        Thu, 30 Apr 2026 08:26:57 -0700 (PDT)
Received: from localhost.localdomain ([2a00:a041:e04f:2600:a0c9:1d35:8283:f96b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c2d3811sm70049655e9.3.2026.04.30.08.26.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 08:26:56 -0700 (PDT)
From: "SnailSploit | Kai Aizen" <kai.aizen.dev@gmail.com>
X-Google-Original-From: SnailSploit | Kai Aizen <95986478+SnailSploit@users.noreply.github.com>
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	jmaloy@redhat.com,
	ying.xue@windriver.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tipc-discussion@lists.sourceforge.net,
	tung.q.nguyen@dektech.com.au,
	lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	syzkaller-bugs@googlegroups.com,
	"SnailSploit | Kai Aizen" <95986478+SnailSploit@users.noreply.github.com>,
	syzbot ci <syzbot+ci779e8ed86620f383@syzkaller.appspotmail.com>
Subject: [PATCH net v3] tipc: fix UAF race in tipc_mon_peer_up/down/remove_peer vs bearer teardown
Date: Thu, 30 Apr 2026 18:26:54 +0300
Message-ID: <80ae67e96de2f702028e5bacc89db4575e1531ca.1777559945.git.kai.aizen.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CALynFi5d0DuGW50xq7xQnsDPdEuN5jBGTqh8bcsUwxk6L-FAdA@mail.gmail.com>
References: <CALynFi5d0DuGW50xq7xQnsDPdEuN5jBGTqh8bcsUwxk6L-FAdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6AE864A4E3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-242142-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable,SnailSploit,ci779e8ed86620f383];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzbot.org:url,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]

From: "SnailSploit | Kai Aizen" <95986478+SnailSploit@users.noreply.github.com>

CVE-2025-40280 fixed tipc_mon_reinit_self() accessing monitors[] from a
workqueue without RTNL.  That patch closed the workqueue path by adding
rtnl_lock() around the call.

However, three additional functions in the same subsystem access
tipc_net->monitors[] from softirq context with no RCU protection at all:

  tipc_mon_peer_up()     - called from tipc_node_write_unlock()
  tipc_mon_peer_down()   - called from tipc_node_write_unlock()
  tipc_mon_remove_peer() - called from tipc_node_link_down()

These are invoked from the packet receive path (tipc_rcv ->
tipc_node_write_unlock / tipc_node_link_down) and hold only the per-node
rwlock, not RTNL.

Concurrently, bearer_disable() -- which always holds RTNL -- calls
tipc_mon_delete(), which sets tn->monitors[bearer_id] = NULL and then
kfree(mon) without an RCU grace period. A softirq reader can observe
the non-NULL slot, take a reference, get preempted, and resume after
kfree(mon) on another CPU, dereferencing freed memory.

Convert monitors[] to __rcu, use rcu_assign_pointer() on creation,
RCU_INIT_POINTER() + synchronize_rcu() on deletion before kfree(), and
the appropriate dereference variant at each read site:

  - tipc_monitor() returns rcu_dereference_bh(...) for softirq callers
    (tipc_mon_peer_up/down/remove_peer/rcv/prep/get_state).
  - tipc_monitor_rtnl() returns rtnl_dereference(...) for RTNL-held
    callers (tipc_mon_delete via bearer_disable, tipc_mon_reinit_self
    via tipc_net_finalize_work which wraps in rtnl_lock(), and the
    netlink dump handlers tipc_nl_add_monitor_peer /
    __tipc_nl_add_monitor).

Also, get_self() was a thin wrapper over tipc_monitor() + ->self deref,
duplicating the RCU-checked load that callers already perform on entry.
With monitors[] becoming __rcu, get_self()'s use of tipc_monitor()
generates a lockdep splat in tipc_mon_delete() (RTNL context) because
the inner load is rcu_dereference_bh().  syzbot CI reported this on
v1/v2 of this patch:

  WARNING: suspicious RCU usage in tipc_mon_delete
  net/tipc/monitor.c:108 suspicious rcu_dereference_check() usage!
  ...
  tipc_monitor_rcu_bh+0xf5/0x110  net/tipc/monitor.c:108
  get_self                        net/tipc/monitor.c:209
  tipc_mon_delete+0x10b/0x4d0     net/tipc/monitor.c:704

Drop get_self() entirely.  Each existing caller already has a valid
mon pointer from its initial RCU-correct load, and mon->self is the
result get_self() was returning.  Replace each "self = get_self(...)"
with "self = mon->self;".  This both removes the duplicate dereference
and fixes the lockdep splat.

synchronize_rcu() in tipc_mon_delete() is placed after
write_unlock_bh() and before timer_shutdown_sync() + kfree() so all
softirq readers that already observed the old pointer have completed
before the memory is freed.

Fixes: 35c55c9877f8 ("tipc: add neighbor monitoring framework")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604301148.jfXKC9HF-lkp@intel.com/
Reported-by: syzbot ci <syzbot+ci779e8ed86620f383@syzkaller.appspotmail.com>
Closes: https://ci.syzbot.org/series/6267bc07-4172-4821-b3e5-dac381479d9d
Signed-off-by: SnailSploit | Kai Aizen <95986478+SnailSploit@users.noreply.github.com>
---
 net/tipc/core.h    |  2 +-
 net/tipc/monitor.c | 42 +++++++++++++++++++++++-------------------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/net/tipc/core.h b/net/tipc/core.h
index 9ce5f9ff6..cd582f7a2 100644
--- a/net/tipc/core.h
+++ b/net/tipc/core.h
@@ -109,7 +109,7 @@ struct tipc_net {
 	u32 num_links;
 
 	/* Neighbor monitoring list */
-	struct tipc_monitor *monitors[MAX_BEARERS];
+	struct tipc_monitor __rcu *monitors[MAX_BEARERS];
 	int mon_threshold;
 
 	/* Bearer list */
diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index a94b9b36a..0095a62ae 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -99,7 +99,14 @@ struct tipc_monitor {
 
 static struct tipc_monitor *tipc_monitor(struct net *net, int bearer_id)
 {
-	return tipc_net(net)->monitors[bearer_id];
+	return rcu_dereference_bh(tipc_net(net)->monitors[bearer_id]);
+}
+
+/* tipc_monitor_rtnl - dereference monitors[] from RTNL-held control path. */
+static struct tipc_monitor * __maybe_unused
+tipc_monitor_rtnl(struct net *net, int bearer_id)
+{
+	return rtnl_dereference(tipc_net(net)->monitors[bearer_id]);
 }
 
 const int tipc_max_domain_size = sizeof(struct tipc_mon_domain);
@@ -192,13 +199,6 @@ static struct tipc_peer *get_peer(struct tipc_monitor *mon, u32 addr)
 	return NULL;
 }
 
-static struct tipc_peer *get_self(struct net *net, int bearer_id)
-{
-	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
-
-	return mon->self;
-}
-
 static inline bool tipc_mon_is_active(struct net *net, struct tipc_monitor *mon)
 {
 	struct tipc_net *tn = tipc_net(net);
@@ -358,7 +358,7 @@ void tipc_mon_remove_peer(struct net *net, u32 addr, int bearer_id)
 	if (!mon)
 		return;
 
-	self = get_self(net, bearer_id);
+	self = mon->self;
 	write_lock_bh(&mon->lock);
 	peer = get_peer(mon, addr);
 	if (!peer)
@@ -422,9 +422,12 @@ static bool tipc_mon_add_peer(struct tipc_monitor *mon, u32 addr,
 void tipc_mon_peer_up(struct net *net, u32 addr, int bearer_id)
 {
 	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
-	struct tipc_peer *self = get_self(net, bearer_id);
+	struct tipc_peer *self;
 	struct tipc_peer *peer, *head;
 
+	if (!mon)
+		return;
+	self = mon->self;
 	write_lock_bh(&mon->lock);
 	peer = get_peer(mon, addr);
 	if (!peer && !tipc_mon_add_peer(mon, addr, &peer))
@@ -449,7 +452,7 @@ void tipc_mon_peer_down(struct net *net, u32 addr, int bearer_id)
 	if (!mon)
 		return;
 
-	self = get_self(net, bearer_id);
+	self = mon->self;
 	write_lock_bh(&mon->lock);
 	peer = get_peer(mon, addr);
 	if (!peer) {
@@ -651,7 +654,7 @@ int tipc_mon_create(struct net *net, int bearer_id)
 	struct tipc_peer *self;
 	struct tipc_mon_domain *dom;
 
-	if (tn->monitors[bearer_id])
+	if (rtnl_dereference(tn->monitors[bearer_id]))
 		return 0;
 
 	mon = kzalloc_obj(*mon, GFP_ATOMIC);
@@ -663,7 +666,7 @@ int tipc_mon_create(struct net *net, int bearer_id)
 		kfree(dom);
 		return -ENOMEM;
 	}
-	tn->monitors[bearer_id] = mon;
+	rcu_assign_pointer(tn->monitors[bearer_id], mon);
 	rwlock_init(&mon->lock);
 	mon->net = net;
 	mon->peer_cnt = 1;
@@ -682,16 +685,16 @@ int tipc_mon_create(struct net *net, int bearer_id)
 void tipc_mon_delete(struct net *net, int bearer_id)
 {
 	struct tipc_net *tn = tipc_net(net);
-	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+	struct tipc_monitor *mon = tipc_monitor_rtnl(net, bearer_id);
 	struct tipc_peer *self;
 	struct tipc_peer *peer, *tmp;
 
 	if (!mon)
 		return;
 
-	self = get_self(net, bearer_id);
+	self = mon->self;
+	RCU_INIT_POINTER(tn->monitors[bearer_id], NULL);
 	write_lock_bh(&mon->lock);
-	tn->monitors[bearer_id] = NULL;
 	list_for_each_entry_safe(peer, tmp, &self->list, list) {
 		list_del(&peer->list);
 		hlist_del(&peer->hash);
@@ -700,6 +703,7 @@ void tipc_mon_delete(struct net *net, int bearer_id)
 	}
 	mon->self = NULL;
 	write_unlock_bh(&mon->lock);
+	synchronize_rcu();
 	timer_shutdown_sync(&mon->timer);
 	kfree(self->domain);
 	kfree(self);
@@ -712,7 +716,7 @@ void tipc_mon_reinit_self(struct net *net)
 	int bearer_id;
 
 	for (bearer_id = 0; bearer_id < MAX_BEARERS; bearer_id++) {
-		mon = tipc_monitor(net, bearer_id);
+		mon = tipc_monitor_rtnl(net, bearer_id);
 		if (!mon)
 			continue;
 		write_lock_bh(&mon->lock);
@@ -798,7 +802,7 @@ static int __tipc_nl_add_monitor_peer(struct tipc_peer *peer,
 int tipc_nl_add_monitor_peer(struct net *net, struct tipc_nl_msg *msg,
 			     u32 bearer_id, u32 *prev_node)
 {
-	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+	struct tipc_monitor *mon = tipc_monitor_rtnl(net, bearer_id);
 	struct tipc_peer *peer;
 
 	if (!mon)
@@ -827,7 +831,7 @@ int tipc_nl_add_monitor_peer(struct net *net, struct tipc_nl_msg *msg,
 int __tipc_nl_add_monitor(struct net *net, struct tipc_nl_msg *msg,
 			  u32 bearer_id)
 {
-	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+	struct tipc_monitor *mon = tipc_monitor_rtnl(net, bearer_id);
 	char bearer_name[TIPC_MAX_BEARER_NAME];
 	struct nlattr *attrs;
 	void *hdr;
-- 
2.43.0


