Return-Path: <stable+bounces-230973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id S8FrKHiKyWlHzAUAu9opvQ
	(envelope-from <stable+bounces-230973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 22:24:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F233E353F37
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 22:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4CB73009000
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3036A2D1907;
	Sun, 29 Mar 2026 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPazgVQp"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2B6279DB6
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774815860; cv=pass; b=ReA8Dhjo6TKvkfsDstX721L6W79xXsvWKwlffWltccL+cm6eYL2ivh4EXPaVwpUqhpfon3Peda6C2gaa7oyHscrly2UbhFdRGqgnXcV3WPUELVoJ1Ti2h1hraUI9dUO0epSN2y76WcrwrXRSTHz7Cg6i1UMlzgJcbtf+T9Cpsa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774815860; c=relaxed/simple;
	bh=Y1pJqKn4emEo8xoIcfl+gnR5mNiHfGq/NqI6f+kyhVM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aOKjUVJbpoigSZb3NbysOtfiOoYCekjewBBt7oeoC/cVuj+yl/uSPI6LW9qt8AU9F++MUuv378GfUsP0wkmpSdCs5zxazwuUqBY4HsI8/ftHlKUJWn7b3ewPfr3J4XoTP9HPFjiwA0Bx/7H/cYfBfYlxQH+zSi0D1rH4RpGspFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPazgVQp; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66bb7e098b1so469156a12.3
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 13:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774815856; cv=none;
        d=google.com; s=arc-20240605;
        b=HfGmjxSwJc0sJCYyo/MvKDXAcZj3rMZ46C8oA15C/t10Ykv/KxTohY9L/VgK8OGZS6
         /GwodSGE+CoM6BMVs/Sx/7lmiJ0fy8bbjO92UUJP0blTNDu970fTLwmJ3FiL9y2TgELM
         4ejGeSxv74esRDAi0QwCzgInwV6BAtcfAk6fWQfo8uye1BYVV0XRdO6wZVFQBQU6mTlp
         oj6GLUqG2wwc6D2BFw4Fi5+Bl7WQobI+wbEKJBFIJZ9DaioYvltsnjUxl+Hhsx2Mgjqg
         h4TAz/BC2BmEzAAn3ROzVPcafokbV0W3CIRkAh1Z+ip7PojQ68KgdtDTQrE2gDPNrQC/
         0lYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QC2mKtnWOQk3ed+8MF9J/tF2/xJLoCDYfn8h8TayBfg=;
        fh=Epl+ZmUGRDaZ+D6XIRtgvIUuNWtiJEPH+fiG3YLoTyE=;
        b=aGezq75+ceNv/xM8KKqc1Kid1eax1xSSXb9y8ClKz/YHiAo5103lTp2VYxbamcNO/j
         njOwoYu14lmZoMG6t6A7T6Al3xdJd//l7YZhd543JAITrZfUcsYukGiE2K0X4USYbvT1
         aDbL+WcCSq8Z0qAf6m1N+RzlCktjSnv2ygMASCzk5iHR8TlECpCGt6c8LBKRjlk8lR7c
         Aor1xCVefJ7RIYboPT9CbhaE2gX+IKyQv79B6TTKBH3m5Q2LmC6sve9OFkQoEqF7v01x
         xU0UcH6fiH3N1zHqMe/LTstyOLWcgp3TiwV50wSf3KIIgOPPNTskrRGOXjCYz00cIsC7
         wp+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774815856; x=1775420656; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QC2mKtnWOQk3ed+8MF9J/tF2/xJLoCDYfn8h8TayBfg=;
        b=iPazgVQpzMJFLuibxfLgrl5cxGsXR2YfmgzlAcCMgKAJwMdTzI+xM2DAPgTser8oHU
         H/WFS/8TpMell9dzqPUmbzManTbrovrobpZIWF0yDvfqcMtEmVImf7iiwfVY392SSdXq
         j2bymkOOO3dYok1L3yQxHfqQf22Fk33n+pnebl8thI3gzJbafyxvGKNBHkgR3/1qN9Eh
         nIVM3Sxp76wWZefME6thiGqBLL37gL07Q/accYOvid0457u5YZP3rEfZj9flvMJdWapn
         6P/OCEGu0IfWLM9vKF2ktC+0lWBJqKbFOhYv0ZNdnwe+sPwmnrv8ADpB0A7Ab52/e1oQ
         j6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774815856; x=1775420656;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QC2mKtnWOQk3ed+8MF9J/tF2/xJLoCDYfn8h8TayBfg=;
        b=mNuWn9t9PlT2V503nOBUOmtElGpApJznofSPeqc6vDczIBSaFGPBmUt76f+mm/UPJM
         miGtbTpn2QEAWOhfHMpXff6f3CeMucA+XOB8MFguxpf81Uhk9z1VoeHoJoF+lF4VecoK
         HYQGtFdlBI4pCyOsJG6qC6zpVqzS0QMDK3+8rcKEcQAnyNMX+N/Mcr5JZQ8PuQAhWQ8V
         CoGZOUodjVz1SOnm7kNEFRRNTKTn7q784EPHH6OIXPgJrjpqzoOT+QivfPJmUXJSlvxd
         2cA1TVNT5DBYYlKkJIrDrnU9DjNN2lSn3xRAcS7L/6IUAZkzpjSk2WKWDFjfitEbomcF
         LYnw==
X-Gm-Message-State: AOJu0Ywa53yl7hDpv1tWUAGZyQak3cbUSttqF2M5Ab25h+9Vvd3GuZi0
	tuXwD5y1HpCnfu2XTCFgJ2eEkC1aPpL58Y1XT9v3uLOzogATeKClSFS6hkXxYIWEl0ve008N5kP
	i6A75vvA/v0GVD4zEyjegp3m7qCXRXmPhj7qeovM=
X-Gm-Gg: ATEYQzzjfsfb+HOGkPvp6xc9k9s07fdYSi0iCiN3Th2UVDhdfcWZD4Y9v530hWeCed5
	ZDJr+SvNzZo/WmjcckPOfWWcaXkCviofpiq6htpNky3qclXS3LJ7jeKNcH0l6CdYk7oT7CRcwgU
	nB/RXzZfp47Wm2JFipvuT1JBxSkGUv7fyx9LB2DXgPTHVchTHBuC5AV9Xcval/5vmqCWveRH8OD
	RP/IXAtmD86ZX7OoQ7ZThIONZ34E8QjUaJBCK9pzEWDPIJHulLBV6qkwWZxk2VwM43VurVjiF4z
	rYJ+JZ+5i3eGiYQb9EkBElv452hzDM3hw58rP7Ezouc7gMPp1tO8OCmfYWtuICSH1YOuyHPaIBV
	jyN+U/HM=
X-Received: by 2002:a05:6402:3483:b0:66b:e45:c7e3 with SMTP id
 4fb4d7f45d1cf-66b2918e530mr5979362a12.27.1774815856000; Sun, 29 Mar 2026
 13:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kai Zen <kai.aizen.dev@gmail.com>
Date: Sun, 29 Mar 2026 23:23:49 +0300
X-Gm-Features: AQROBzCRjp1HyHt9xQAQu1ffpLxfrcr8rSDpoUjTBsq35RNOIxrGidTHcu4CUFo
Message-ID: <CALynFi5UR5NUQLn8-rx66AoD72Qn0Chji_m+hVFrXL4cReNJ1A@mail.gmail.com>
Subject: Subject: [PATCH net] tipc: fix UAF race in tipc_mon_peer_up/down/remove_peer
 vs bearer teardown
To: stable@vger.kernel.org, Kai Aizen <kai@snailsploit.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230973-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F233E353F37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

CVE-2025-40280 fixed tipc_mon_reinit_self() accessing monitors[] from a
workqueue without RTNL.  That patch closed the workqueue path by adding
rtnl_lock() around the call.

However, three additional functions in the same subsystem access
tipc_net->monitors[] from softirq context with no RCU protection at all:

  tipc_mon_peer_up()      - called from tipc_node_write_unlock()
  tipc_mon_peer_down()    - called from tipc_node_write_unlock()
  tipc_mon_remove_peer()  - called from tipc_node_link_down()

These three are invoked from the packet receive path (tipc_rcv ->
tipc_node_write_unlock / tipc_node_link_down) and hold only the per-node
rwlock, not RTNL.

Concurrently, bearer_disable() -- which always holds RTNL per its own
inline documentation -- calls tipc_mon_delete(), which:

  1. acquires mon->lock
  2. sets tn->monitors[bearer_id] = NULL
  3. frees all peer entries
  4. releases mon->lock
  5. calls kfree(mon)                     <-- no synchronize_rcu()

The race is structural: there is no shared lock between the data-path
reader (which reads monitors[id] then acquires mon->lock) and the
teardown path (which acquires mon->lock, NULLs the slot, then frees).
A softirq thread can read a non-NULL mon pointer, get preempted, and
resume after kfree(mon) has run on another CPU, then call
write_lock_bh(&mon->lock) on freed memory:

  CPU 0 (softirq / tipc_rcv)            CPU 1 (RTNL / bearer_disable)
  tipc_mon_peer_up()
    mon = tipc_monitor(net, id)
    [mon is non-NULL]
                                         tipc_mon_delete()
                                           write_lock_bh(&mon->lock)
                                           tn->monitors[id] = NULL
                                           ...
                                           write_unlock_bh(&mon->lock)
                                           kfree(mon)
    write_lock_bh(&mon->lock)   <-- UAF

The fix mirrors the existing bearer_list[] pattern in the same module:
convert monitors[] to __rcu, use rcu_assign_pointer() on creation,
RCU_INIT_POINTER() + synchronize_rcu() on deletion (before the kfree),
and the appropriate rcu_dereference_bh() vs rtnl_dereference() variant
at each read site depending on execution context.

synchronize_rcu() in tipc_mon_delete() is placed after the
write_unlock_bh() and before timer_shutdown_sync() + kfree() to ensure
all softirq-context readers that already observed the old pointer have
completed before the memory is freed.

Fixes: 35c55c9877f8 ("tipc: add neighbor monitoring framework")
Cc: stable@vger.kernel.org
Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
---
 net/tipc/core.h    |  2 +-
 net/tipc/monitor.c | 51 ++++++++++++++++++++++++++++++++--------------
 2 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/net/tipc/core.h b/net/tipc/core.h
--- a/net/tipc/core.h
+++ b/net/tipc/core.h
@@ -109,7 +109,7 @@
        u32 num_links;

        /* Neighbor monitoring list */
-       struct tipc_monitor *monitors[MAX_BEARERS];
+       struct tipc_monitor __rcu *monitors[MAX_BEARERS];
        int mon_threshold;

        /* Bearer list */

diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -97,9 +97,20 @@
        unsigned long timer_intv;
 };

-static struct tipc_monitor *tipc_monitor(struct net *net, int bearer_id)
+/*
+ * tipc_monitor_rcu_bh - dereference monitors[] from softirq / data path.
+ * Softirq context implicitly provides RCU-bh read-side protection on
+ * non-PREEMPT_RT kernels; callers on RT should hold rcu_read_lock_bh().
+ */
+static struct tipc_monitor *tipc_monitor_rcu_bh(struct net *net, int bearer_id)
+{
+       return rcu_dereference_bh(tipc_net(net)->monitors[bearer_id]);
+}
+
+/* tipc_monitor_rtnl - dereference monitors[] from RTNL-held control path. */
+static struct tipc_monitor *tipc_monitor_rtnl(struct net *net, int bearer_id)
 {
-       return tipc_net(net)->monitors[bearer_id];
+       return rtnl_dereference(tipc_net(net)->monitors[bearer_id]);
 }

 const int tipc_max_domain_size = sizeof(struct tipc_mon_domain);
@@ -194,7 +205,7 @@

 static struct tipc_peer *get_self(struct net *net, int bearer_id)
 {
-       struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+       struct tipc_monitor *mon = tipc_monitor_rcu_bh(net, bearer_id);

        return mon->self;
 }
@@ -351,7 +362,7 @@

 void tipc_mon_remove_peer(struct net *net, u32 addr, int bearer_id)
 {
-       struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+       struct tipc_monitor *mon = tipc_monitor_rcu_bh(net, bearer_id);
        struct tipc_peer *self;
        struct tipc_peer *peer, *prev, *head;

@@ -421,7 +432,7 @@

 void tipc_mon_peer_up(struct net *net, u32 addr, int bearer_id)
 {
-       struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+       struct tipc_monitor *mon = tipc_monitor_rcu_bh(net, bearer_id);
        struct tipc_peer *self = get_self(net, bearer_id);
        struct tipc_peer *peer, *head;

@@ -440,7 +451,7 @@

 void tipc_mon_peer_down(struct net *net, u32 addr, int bearer_id)
 {
-       struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+       struct tipc_monitor *mon = tipc_monitor_rcu_bh(net, bearer_id);
        struct tipc_peer *self;
        struct tipc_peer *peer, *head;
        struct tipc_mon_domain *dom;
@@ -480,7 +491,7 @@
 void tipc_mon_rcv(struct net *net, void *data, u16 dlen, u32 addr,
                  struct tipc_mon_state *state, int bearer_id)
 {
-       struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+       struct tipc_monitor *mon = tipc_monitor_rcu_bh(net, bearer_id);
        struct tipc_mon_domain *arrv_dom = data;
        struct tipc_mon_domain dom_bef;
        struct tipc_mon_domain *dom;
@@ -566,7 +577,7 @@
 void tipc_mon_prep(struct net *net, void *data, int *dlen,
                   struct tipc_mon_state *state, int bearer_id)
 {
-       struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+       struct tipc_monitor *mon = tipc_monitor_rcu_bh(net, bearer_id);
        struct tipc_mon_domain *dom = data;
        u16 gen = mon->dom_gen;
        u16 len;
@@ -600,7 +611,7 @@
                struct tipc_mon_state *state,
                int bearer_id)
 {
-       struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+       struct tipc_monitor *mon = tipc_monitor_rcu_bh(net, bearer_id);
        struct tipc_peer *peer;

        if (!tipc_mon_is_active(net, mon)) {
@@ -651,7 +662,7 @@
        struct tipc_peer *self;
        struct tipc_mon_domain *dom;

-       if (tn->monitors[bearer_id])
+       if (rtnl_dereference(tn->monitors[bearer_id]))
                return 0;

        mon = kzalloc_obj(*mon, GFP_ATOMIC);
@@ -663,7 +674,7 @@
                kfree(dom);
                return -ENOMEM;
        }
-       tn->monitors[bearer_id] = mon;
+       rcu_assign_pointer(tn->monitors[bearer_id], mon);
        rwlock_init(&mon->lock);
        mon->net = net;
        mon->peer_cnt = 1;
@@ -682,7 +693,7 @@
 void tipc_mon_delete(struct net *net, int bearer_id)
 {
        struct tipc_net *tn = tipc_net(net);
-       struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+       struct tipc_monitor *mon = rtnl_dereference(tn->monitors[bearer_id]);
        struct tipc_peer *self;
        struct tipc_peer *peer, *tmp;

@@ -690,8 +701,13 @@
                return;

        self = get_self(net, bearer_id);
+       /*
+        * Null the pointer under write lock so data-path lookups immediately
+        * return NULL, then wait for readers that already loaded the old
+        * pointer to finish before freeing.
+        */
        write_lock_bh(&mon->lock);
-       tn->monitors[bearer_id] = NULL;
+       RCU_INIT_POINTER(tn->monitors[bearer_id], NULL);
        list_for_each_entry_safe(peer, tmp, &self->list, list) {
                list_del(&peer->list);
                hlist_del(&peer->hash);
@@ -700,6 +716,7 @@
        }
        mon->self = NULL;
        write_unlock_bh(&mon->lock);
+       synchronize_rcu();
        timer_shutdown_sync(&mon->timer);
        kfree(self->domain);
        kfree(self);
@@ -712,7 +729,7 @@
        int bearer_id;

        for (bearer_id = 0; bearer_id < MAX_BEARERS; bearer_id++) {
-               mon = tipc_monitor(net, bearer_id);
+               mon = rtnl_dereference(tipc_net(net)->monitors[bearer_id]);
                if (!mon)
                        continue;
                write_lock_bh(&mon->lock);
@@ -798,7 +815,7 @@
 int tipc_nl_add_monitor_peer(struct net *net, struct tipc_nl_msg *msg,
                             u32 bearer_id, u32 *prev_node)
 {
-       struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+       struct tipc_monitor *mon =
rtnl_dereference(tipc_net(net)->monitors[bearer_id]);
        struct tipc_peer *peer;

        if (!mon)
@@ -827,7 +844,7 @@
 int __tipc_nl_add_monitor(struct net *net, struct tipc_nl_msg *msg,
                          u32 bearer_id)
 {
-       struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+       struct tipc_monitor *mon =
rtnl_dereference(tipc_net(net)->monitors[bearer_id]);
        char bearer_name[TIPC_MAX_BEARER_NAME];
        struct nlattr *attrs;
        void *hdr;



CHEERS,
Kai Aizen @Snailsploit

