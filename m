Return-Path: <stable+bounces-242243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMY9GkRZ9GkvAwIAu9opvQ
	(envelope-from <stable+bounces-242243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 09:41:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEF84AB020
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 09:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 320F23027D98
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 07:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0D736C5BF;
	Fri,  1 May 2026 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee4Wweie"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B1235F5E1
	for <stable@vger.kernel.org>; Fri,  1 May 2026 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777621298; cv=none; b=or8VEDnImVCgjtetgh2zkr00+XRLNULRDqA8vR7zdE/F6gzrtR1sP0a5DMKdHmGtYiGee0ubjZCFAGJlfnjMTeua9niiyJtThO18FH5DUmrPmQeBrQHF8CQ1PQN73Xo5lX0k/z2ZrTz/YOZ+VJBkZw6HvTpn91n3sTQdgf7zLEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777621298; c=relaxed/simple;
	bh=vYAz+GFVJG00m+N0rNeEFR8ISwPXEVv1wwb2oqmGd0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hETUwgGMxdzSHbf+/416nWzq9RILB/itP1L0h/7XmkJUW0NEsOCY3YvWk/14rvaFi3q2X4mu94Thg8yMRXLr+sYAyVzRKq+B4tapRkcKi7GW6jlrKNZeu1qzUEn7JhXexUh7P0KY4OMpx5jsrhbeSBqoeamlsXf3KupKtq+a4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ee4Wweie; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so1202531a91.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 00:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777621296; x=1778226096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B6Y3sVzofFaYqh9OvqIh9FB2/uppgN0RArsWV/LlugY=;
        b=ee4WweieDAwtdiHg6xEhQOrzbzVn7W6kdBZV60PjuecJyDErAjjrqgxFWttFuzPOYh
         JxsmTCfGpGM209sZbRMjVHewUX8F9NTXIy6XWF+gPcwPx9jaM5YD24dz6HTbIPxCOtTx
         gPHJOBRTjnNn9uJhONFsLh2f9B6WB29TPXawKP7LFCenWvRoxlzKRvEZU4L7+JKwlavq
         bRgSKbhCpFR7xy5mlMH/9KVzRpQuEO/ue7r+/QWAiPVxAQNfvo8c2xwg7u3vn1Akd5sH
         I7Vh6kKDJQFJTFZ5+Sjg68qWZ+5EMcjp7P6NvFJOx0Tf/S3rXksq3il9+PG88803Pp8F
         nkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777621296; x=1778226096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6Y3sVzofFaYqh9OvqIh9FB2/uppgN0RArsWV/LlugY=;
        b=lxW7jPgYMlDIojhwNyQj/kTKwlDQGaCLT15oyOhTqXcaQm3sq/qrbR9ybDguLhiFCw
         wTv6MWTUfDAm93gFlLhUMemb9a7WwnMHMQ80rxRL6NpGB1H72tGPfKNfKXCTy/Audrf6
         zg9dj2x+mWGuVPw3W5tPfrbWzVvilgKt0xfIGHJJVTQ2Pnv33tVptOm07PB9c+IL96f2
         r+i5PoxxiDps1p+rURspbLmCfSYZi61Cr1vHMVbWD/qHo3ovr4H1JQFO6Gq6HgISfnU7
         xVrCFhC3TQ+E2nUbYcfhF7/coJn9wCqk8MM0ye+qb5cz2OStk59hozxTjUcbLTiJ+ZUZ
         fOTw==
X-Forwarded-Encrypted: i=1; AFNElJ8PMMcQD1fG8Yqe535+Hdr65zciQDmjShDD6munjW2GCQ45ObkClQdTolExZ/FqegHBo2HEGPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlZLDQ2sCCjUI5NiQbpTrGqJweQvCkDAJeJTHcnEFb0B8HM/0X
	RQ+FsEmZi5SYSxY1+3UWNOA0AFSN6UhIdaUcVY/DCHNEmB3pVnm+9J3wR1003Q==
X-Gm-Gg: AeBDieuO0xBJQnhgkuVHeqckJjnPWwpoqmwlRwiFiCno7mRAVG8YmQRUWl1+PBawibf
	Qh7mDSCZQ0ISuP+gM7WsX3GWAdW2L5Kw7PYOwzBR9IP7V/7ToEKUJjIhGRdPoKTcOH0Y8Rpui9Z
	1AKLvOU+XsiEK/KyAltXAbeldpYmZrrj8wX2Uyv/keA+Ddk8dIZJZdlyCYIznc0ICbx3bZ3L2AF
	n+0jxmasDc5Tif8K3tOzL0shgUdEz6vObDua/iN0qfk4bMzqrA6ILeh8vqNZouw9RMB/UOjQfuK
	Rs4ewyFp9fsAwDu1ONXi+ZWwdnEaB3XhQcGeG3kpoDg8C1BRwByEcWzLJUecZz0GPuvtllukiCZ
	s9l4VUzkWn6uTIYyg6NDcZCq8SyBv/WOzWheIkcliahIMAWoKTvYCVv3D9LwZ9E3UJhMhR0Jwk7
	ei1u8fgLF0mX/FAPSUvnLZZjF08zVmrsKK2Nw9BpaqbBzb474nRuPZ64Lo
X-Received: by 2002:a17:90a:fc4f:b0:35e:58d3:3284 with SMTP id 98e67ed59e1d1-364c2fec747mr6090438a91.9.1777621295742;
        Fri, 01 May 2026 00:41:35 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebf12bcesm1502347a91.7.2026.05.01.00.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 00:41:35 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4] ipv6: flowlabel: enforce per-netns limit for unprivileged callers
Date: Fri,  1 May 2026 15:41:30 +0800
Message-Id: <20260501074130.3532402-1-maoyi.xie@ntu.edu.sg>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DAEF84AB020
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-242243-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,kernel.org,davemloft.net,ms2.inr.ac.ru,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.992];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ntu.edu.sg:mid,ntu.edu.sg:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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

mem_check() folds an extra FL_MAX_SIZE/8 ceiling into the existing
non-CAP_NET_ADMIN conditional.

Bump FL_MAX_SIZE from 4096 to 8192. It has been 4096 since the file
was added; machines and connection counts have grown. The new
per-netns ceiling is then 1024 flowlabels, half of FL_MAX_SIZE/4.

CAP_NET_ADMIN against init_user_ns still bypasses both caps.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Willem de Bruijn <willemb@google.com>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
v4 (this submission, addressing v3 review by Willem):
    - rephrased the flowlabel_count placement note: dropped the
      flowlabel_has_excl cacheline argument; replaced with the
      simpler "fills the existing 4-byte hole after ipmr_seq" fact.
    - reordered atomic_dec(&...flowlabel_count) to sit immediately
      after atomic_dec(&fl_size) in ip6_fl_gc and ip6_fl_purge so
      the pairing is visually obvious. Both decs now happen before
      fl_free(fl) since fl_free invalidates fl->fl_net. fl_intern
      was already in this order.
v3: addressed Willem's review on the private security@ thread;
    merged FL_MAX_SIZE doubling, dropped test data, moved
    flowlabel_count near ipmr_seq, inlined fl->fl_net in ip6_fl_gc.
v2: per-netns counter + cap, sent to security@ as a 2-patch series.
v1: fix-shape sketch in original disclosure.

 include/net/netns/ipv6.h |  1 +
 net/ipv6/ip6_flowlabel.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 34bdb1308..329482373 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -119,6 +119,7 @@ struct netns_ipv6 {
 	struct fib_notifier_ops	*notifier_ops;
 	struct fib_notifier_ops	*ip6mr_notifier_ops;
 	unsigned int ipmr_seq; /* protected by rtnl_mutex */
+	atomic_t		flowlabel_count;
 	struct {
 		struct hlist_head head;
 		spinlock_t	lock;
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index c92f98c6f..360109cad 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -36,7 +36,7 @@
 /* FL hash table */
 
 #define FL_MAX_PER_SOCK	32
-#define FL_MAX_SIZE	4096
+#define FL_MAX_SIZE	8192
 #define FL_HASH_MASK	255
 #define FL_HASH(l)	(ntohl(l)&FL_HASH_MASK)
 
@@ -162,8 +162,9 @@ static void ip6_fl_gc(struct timer_list *unused)
 				ttd = fl->expires;
 				if (time_after_eq(now, ttd)) {
 					*flp = fl->next;
-					fl_free(fl);
 					atomic_dec(&fl_size);
+					atomic_dec(&fl->fl_net->ipv6.flowlabel_count);
+					fl_free(fl);
 					continue;
 				}
 				if (!sched || time_before(ttd, sched))
@@ -195,8 +196,9 @@ static void __net_exit ip6_fl_purge(struct net *net)
 			if (net_eq(fl->fl_net, net) &&
 			    atomic_read(&fl->users) == 0) {
 				*flp = fl->next;
-				fl_free(fl);
 				atomic_dec(&fl_size);
+				atomic_dec(&net->ipv6.flowlabel_count);
+				fl_free(fl);
 				continue;
 			}
 			flp = &fl->next;
@@ -245,6 +247,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 	fl->next = fl_ht[FL_HASH(fl->label)];
 	rcu_assign_pointer(fl_ht[FL_HASH(fl->label)], fl);
 	atomic_inc(&fl_size);
+	atomic_inc(&net->ipv6.flowlabel_count);
 	spin_unlock_bh(&ip6_fl_lock);
 	rcu_read_unlock();
 	return NULL;
@@ -464,6 +467,7 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
 static int mem_check(struct sock *sk)
 {
+	struct net *net = sock_net(sk);
 	int room = FL_MAX_SIZE - atomic_read(&fl_size);
 	struct ipv6_fl_socklist *sfl;
 	int count = 0;
@@ -478,7 +482,9 @@ static int mem_check(struct sock *sk)
 
 	if (room <= 0 ||
 	    ((count >= FL_MAX_PER_SOCK ||
-	      (count > 0 && room < FL_MAX_SIZE/2) || room < FL_MAX_SIZE/4) &&
+	      (count > 0 && room < FL_MAX_SIZE/2) ||
+	      room < FL_MAX_SIZE/4 ||
+	      atomic_read(&net->ipv6.flowlabel_count) >= FL_MAX_SIZE/8) &&
 	     !capable(CAP_NET_ADMIN)))
 		return -ENOBUFS;
 
-- 
2.34.1


