Return-Path: <stable+bounces-242610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPTJGuwT9mnMSAIAu9opvQ
	(envelope-from <stable+bounces-242610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 17:10:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7A64B2957
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 17:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B542B3013D6A
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 15:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071A3366DB6;
	Sat,  2 May 2026 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpnIrw1h"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CCE3806D7
	for <stable@vger.kernel.org>; Sat,  2 May 2026 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777734565; cv=none; b=TbXHSQM2+vSUw7xrZY39mPWL1S73n4v+Jabf4W1yEW0EOK0ClM3OOYVuedhAMiHjHX3dnMbabb1OGRXsnM2XqLoNTo2vgZrjZMuwH4DsAo80OLFNVngEH9kOXyd4pe/9QJZ1Yd8/S+Q+suZVba9W2/4b2LwliHWo2lBhj89j0kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777734565; c=relaxed/simple;
	bh=uazcdPaE5njKmpLYawFPN4mUVC9ypP4hDv4opGgd7Iw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dUKEa7YpLpBYRzKiHKvAW8yln/lPFBv11HWTzwrSE4HfLqy2PO+kLYKItt0YZ/w0kGy2u054BjfuJSCX4JyS2NLgmxttxeAWZy/zn9792fz1edDNm+UbXAKbfnC+YgXFKZQxY3vEgKO+7WTPhSjVDeoh0n4MFDNcP3+GHxG3Vho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpnIrw1h; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82f8b60e485so1279672b3a.0
        for <stable@vger.kernel.org>; Sat, 02 May 2026 08:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777734564; x=1778339364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uZCg2ntfiIQSDRsAzajTIBjeudz9C8jXIZXlecgKHlI=;
        b=MpnIrw1h6hGrASr6P0bNa973sOIWzwfxBIpdAQRI/aHetUnIAYziAcHh0CMjxzd4e8
         otAiR1fqCgIxW2LubpHI60XDQDSb61nVQwAaB9nmjsQxXdWlc7n2K3wswxc3FZyA2PpR
         uKbnolmGxJOyB8WeJHYgtWowgE3tgxylcQYYnqxe24ZKl1nQ3Zc9VcNxdChtWebQ8684
         uODeJhombxEVFnGeODR3kp63i79CfrTLMJC46prAyZL4HRzVfdMhEKSorF7FceWSDs57
         0PJltxHx8kX7dn8xW7KDMWcoERpnYM9ElHAUCB1F58smJdynxv2zxRB1MVc8De0t1Oen
         0iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777734564; x=1778339364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZCg2ntfiIQSDRsAzajTIBjeudz9C8jXIZXlecgKHlI=;
        b=lEWrfWdwR3QNDNxYvu+Sf/qByMm1wtTwpDeSO/orTeQIci7wBztLlgcdjNnSNfKcMR
         527Uq+78pfEdtq4NIFTstTDkuvUsBhNncFcuQ8QO1C8pXLzuFm9nZ96HvAA6LyBIwadD
         WppDHjByoiWwYIHoXYfpgyTSUOR6LYgnuQ63JvoRs1J3WfYwbSxmCpcPjMyT4dVnTiDU
         mpYRzrezmfz3adZ+J3anAR9ksI8ECUeKH75Pz/NpYKIQ8NJE4y35NyF+dMEFZzqtILjv
         yuiuMLQ5R7cGv5oSXWIqjPxB52HxlRrzSZPDPnz/siqq11M3JwJ/fr/efFnHfZQ86dpl
         E4Fg==
X-Forwarded-Encrypted: i=1; AFNElJ/yXgOg6LdzwFYLrcAdvIjx42OCk6yE7C/sw0fvcuiKv0uPTXxgkW90pLll8FKzpfUMapkhWRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Emdpbe3g8qQPVWbL/XHSlLb9ytNL3i3i3NOJdo3Wd7jAaTb4
	UPrVzZhAMTYANDEDfPkw/59r0+uDWWT+MgML4ZoWMqUhc3dhV4Ncs1hndUcg8Q==
X-Gm-Gg: AeBDiesYVwFUcG33ndWGLWFRsYnflEF5wuLAIXwadR6Ya9XnKzql3bt02zAI3o0+6VH
	xP+r1HX/LsJmXE5PSiUH10yvh5t5UqaEQj77sf3aG0zHUb/Il/XA8ybebmTbBAJD8I7FIZewEQx
	AZGQ7G9ZzcGJQPTBZeZ6EhbtD2/h4nPzrPMAByMHRmPrUz7l9PYB6pRnVvR0woK4xfrHapRixWl
	d/WHhHc1Vkrf4MQ2qjyHAJwY5bRDmxXuBrmGKL8nS0dutPdDFgEIwYr74RwBZuOm+E83JAICns3
	uyIsdpIYNq0EASNTsjPVDrawK6tbUgSCN80b/vjLwFAANmJHdL13T64gxz6zmETPgNqQQ8zKn47
	MNuUScEMhYqIx7VIvzyT6xGEcY5pZEV+0tqaA6FeiLQKHeji0ecZG966dUyUzCpmcJ8CMpGS8HR
	ihnMhFZGujaK58y/98s5sbPjUBSxrP98OtN9306wKWUvBPSvnO8gbpv6Ll
X-Received: by 2002:a05:6a21:6d95:b0:3a1:90ef:7e46 with SMTP id adf61e73a8af0-3a7f1bc4197mr3551311637.33.1777734563683;
        Sat, 02 May 2026 08:09:23 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515833ee3sm6080310b3a.11.2026.05.02.08.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 08:09:23 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: dsahern@kernel.org,
	kuznet@ms2.inr.ac.ru,
	willemb@google.com,
	willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v6] ipv6: flowlabel: enforce per-netns limit for unprivileged callers
Date: Sat,  2 May 2026 23:09:18 +0800
Message-Id: <20260502150918.4171847-1-maoyi.xie@ntu.edu.sg>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CA7A64B2957
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242610-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ms2.inr.ac.ru,google.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.990];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

fl_size, fl_ht and ip6_fl_lock in net/ipv6/ip6_flowlabel.c are file
scope and shared across netns. mem_check() reads fl_size to decide
whether to deny non-CAP_NET_ADMIN callers; capable() runs against
init_user_ns, so an unprivileged user in any non-init userns can
push fl_size past FL_MAX_SIZE - FL_MAX_SIZE/4 and starve every
other unprivileged userns on the host.

Add struct netns_ipv6::flowlabel_count, bumped and decremented next
to fl_size in fl_intern, ip6_fl_gc and ip6_fl_purge. The new field
is placed in the existing 4-byte hole after ipmr_seq, so struct
netns_ipv6 stays the same size on 64-bit builds.

Bump FL_MAX_SIZE from 4096 to 8192. It has been 4096 since the file
was added; machines and connection counts have grown.

mem_check() folds an extra per-netns ceiling into the existing
non-CAP_NET_ADMIN conditional. The ceiling is half of the total
budget that unprivileged callers have ever been able to use, i.e.
(FL_MAX_SIZE - FL_MAX_SIZE/4) / 2 = 3072 entries. With FL_MAX_SIZE
doubled, this preserves the original per-user reach (~3K, what an
unprivileged caller could already obtain before this change) while
forcing an attacker to spread allocations across at least two
netns to exhaust the global non-CAP_NET_ADMIN budget.

CAP_NET_ADMIN against init_user_ns still bypasses both caps.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Willem de Bruijn <willemb@google.com>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
v6 (this submission, addressing v5 review by Willem):
    - Rebased onto current net (resolves the conflict on
      include/net/netns/ipv6.h that v5 hit. ipmr_seq is now
      atomic_t but remains 4 bytes, so flowlabel_count still
      fills the 4-byte hole after it).
    - Restored fl_free() to its original position in both
      ip6_fl_gc() and ip6_fl_purge(). v5 had moved fl_free()
      after the new atomic_dec() to avoid the use-after-free
      on fl->fl_net. v6 instead caches fl->fl_net into a
      local before fl_free() in ip6_fl_gc(), and uses the
      net argument already in scope in ip6_fl_purge().
v5: replaced the per-netns ceiling FL_MAX_SIZE/8 with the
    computed unpriv_user_limit = (FL_MAX_SIZE - FL_MAX_SIZE/4)/2,
    which evaluates to 3072. v4's FL_MAX_SIZE/8 = 1024 would
    have reduced the per-user budget below the ~3K an
    unprivileged caller could already obtain before any of
    this work, defeating the reason FL_MAX_SIZE was doubled
    in the first place.
v4: addressed Willem's v3 review on netdev. Dropped the
    flowlabel_has_excl cacheline argument in favour of "fills
    the existing 4-byte hole after ipmr_seq", and reordered
    atomic_dec(&...flowlabel_count) to sit immediately after
    atomic_dec(&fl_size) in ip6_fl_gc and ip6_fl_purge.
v3: addressed Willem's review on the private security@ thread.
    Merged FL_MAX_SIZE doubling, dropped test data, moved
    flowlabel_count near ipmr_seq, inlined fl->fl_net in
    ip6_fl_gc.
v2: per-netns counter + cap, sent to security@ as a 2-patch
    series.
v1: fix-shape sketch in original disclosure.

 include/net/netns/ipv6.h |  1 +
 net/ipv6/ip6_flowlabel.c | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 499e42881..ef698f5fa 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -119,6 +119,7 @@ struct netns_ipv6 {
 	struct fib_notifier_ops	*notifier_ops;
 	struct fib_notifier_ops	*ip6mr_notifier_ops;
 	atomic_t		ipmr_seq;
+	atomic_t		flowlabel_count;
 	struct {
 		struct hlist_head head;
 		spinlock_t	lock;
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index c92f98c6f..28e43718d 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -36,7 +36,7 @@
 /* FL hash table */
 
 #define FL_MAX_PER_SOCK	32
-#define FL_MAX_SIZE	4096
+#define FL_MAX_SIZE	8192
 #define FL_HASH_MASK	255
 #define FL_HASH(l)	(ntohl(l)&FL_HASH_MASK)
 
@@ -161,9 +161,12 @@ static void ip6_fl_gc(struct timer_list *unused)
 					fl->expires = ttd;
 				ttd = fl->expires;
 				if (time_after_eq(now, ttd)) {
+					struct net *net = fl->fl_net;
+
 					*flp = fl->next;
 					fl_free(fl);
 					atomic_dec(&fl_size);
+					atomic_dec(&net->ipv6.flowlabel_count);
 					continue;
 				}
 				if (!sched || time_before(ttd, sched))
@@ -197,6 +200,7 @@ static void __net_exit ip6_fl_purge(struct net *net)
 				*flp = fl->next;
 				fl_free(fl);
 				atomic_dec(&fl_size);
+				atomic_dec(&net->ipv6.flowlabel_count);
 				continue;
 			}
 			flp = &fl->next;
@@ -245,6 +249,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 	fl->next = fl_ht[FL_HASH(fl->label)];
 	rcu_assign_pointer(fl_ht[FL_HASH(fl->label)], fl);
 	atomic_inc(&fl_size);
+	atomic_inc(&net->ipv6.flowlabel_count);
 	spin_unlock_bh(&ip6_fl_lock);
 	rcu_read_unlock();
 	return NULL;
@@ -464,6 +469,9 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
 static int mem_check(struct sock *sk)
 {
+	const int unpriv_total_limit = FL_MAX_SIZE - (FL_MAX_SIZE / 4);
+	const int unpriv_user_limit = unpriv_total_limit / 2;
+	struct net *net = sock_net(sk);
 	int room = FL_MAX_SIZE - atomic_read(&fl_size);
 	struct ipv6_fl_socklist *sfl;
 	int count = 0;
@@ -478,7 +486,9 @@ static int mem_check(struct sock *sk)
 
 	if (room <= 0 ||
 	    ((count >= FL_MAX_PER_SOCK ||
-	      (count > 0 && room < FL_MAX_SIZE/2) || room < FL_MAX_SIZE/4) &&
+	      (count > 0 && room < FL_MAX_SIZE/2) ||
+	      room < FL_MAX_SIZE/4 ||
+	      atomic_read(&net->ipv6.flowlabel_count) >= unpriv_user_limit) &&
 	     !capable(CAP_NET_ADMIN)))
 		return -ENOBUFS;
 
-- 
2.34.1


