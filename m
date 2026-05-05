Return-Path: <stable+bounces-243999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HJlEHGb+Wkn+QIAu9opvQ
	(envelope-from <stable+bounces-243999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:25:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE204C7DF3
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B57993081306
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 07:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A32363099;
	Tue,  5 May 2026 07:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvzcBau9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BA03D6465
	for <stable@vger.kernel.org>; Tue,  5 May 2026 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965629; cv=none; b=ORxuXxkHms0GHeCnYMOdQ9E2pFNJDvloyHxXAMqA0WCOnmoApRFg/Q0P9PGahrckAkDqzmD8KUKLF6LijyVfLqi+bC7QFBGMBBMtqkFjtZt3LNjC4SJgDMpG65y303YwnrDv3uuz04mkUQCZUvl4RTS1i8lJv/hSFc098O+CjCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965629; c=relaxed/simple;
	bh=CWPXKjsjnzf2MJSXTZixtgVN37D9acgZ3iGAC6v+QiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bzm/3/2OsSrUa0QptGeEX7tfRY9JemhCUz9nf3ksnqSXrdUMGaDhCsdGJ/zVuMaB+N9AA3kjItw4nmAs3fgxcddbCQM9vYCNeVv06NllfkfFUc7xxg7pkzObNiZ/CchFpE2Q134u3JIeELRC8FsPGl6UYJ7Wp3FoHWm0Px0+LqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvzcBau9; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so1518478b3a.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 00:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777965627; x=1778570427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yqj3j5E+sxGL3D0rj/RO5rzFrYw+YF42d/8r6R+oyY=;
        b=pvzcBau9NYr51G6D0Z7v2/CUW2wh53Fja+bcvZWWUOM+P+xpJWjSBcRL3lNb5MwC3l
         PgzwI3Vudijfme3xbecJVeixa2cW+JJpjKyaZEX4mJ3R24s9QSyieLJ2hOfN34MRgqnU
         xyre9GcspC0FG9Ml4wozmaWfM9exFykOZPcFUA6l93dpE2Eu4mGyc2eYF1sYvXDjg81B
         v0+c+EgcMvFZ4/89slGacydSWhZ/GuERtd59M8PxhWW5NhYrzUdVv/J76i4brHi+1yvZ
         0B2TOrQ7Beo+95o7EVxVSCiPH7njv2LZ2r25vblJ4Rb+pZCAz8zOkSmozJq4fWZ+DVUW
         bXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965627; x=1778570427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7yqj3j5E+sxGL3D0rj/RO5rzFrYw+YF42d/8r6R+oyY=;
        b=EuLQgjwOrKqglW5TXhEAO5Mia9Pet+Rcqaykxo1gjjxdjNR/AI+zMRm3+AjZDIVxsY
         99dSaQ9YDancoRYBWVNI811dmzfIHLksmDT5Z0dwMlYwY3b0MJOCBzDnmPKqb74iy0Bf
         khzgkhOpILoeZBr/T95Xm1B8F15uYuhT/pxQhMDmeqE+05F3QyUf6A88VBteAbbPovCE
         m82ToU80EqPRKihEOPz8JXzMcKsKLuoPnFX4gijmL4P9QK+mmg8GbJTQuO5BhZw3UDvI
         Vddb6ir80U/740sopnVB1OoiQr6UCQ4KnfvkqYYpkuD320V4ToC1yPMTm3D/j1bFJ37+
         8DFw==
X-Forwarded-Encrypted: i=1; AFNElJ/TXnBgzz0Sb537K2XskH5NzGrvDTC/o+Odc3I2isshHRHI9aSphIyxD1ZCptpAtDJVK1YCnh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxav8CBWVzJP0fjZJzFfl8NMytMfQIqT6eew0tCjbekHI5IwX+N
	//bbSd+XearOTtksfvtkoq8Et3UAYUj2Ks42pme3UPa+8D4ws1x6z841
X-Gm-Gg: AeBDievaqrGPGJoIv6JlweVu/UcImbbN+FKuqJidPyvZkT+twU2RabPK4aWetlSOMiY
	0XMa9unqcxeHxYrXo54Wk5UF845sgvqpCWLER/VIjYUtyfySjJ6WOqwemv4HCQnTvmtuWAtwnCi
	ouRRZgju75SvZ5zcg20T1SA2ndx/d65hJfnRUbQljDaBtZPvtUB68K0D1ekeH22R/eRx/ivKDwO
	Oi4J6rlxR57sC9l+d2//nbivvzovR0FKMMLcEaCyhERfdTd9DFuOhJSMzBtVmpfggiwsv7uhRSS
	U6LiX+Ng4yCzips47Z//o3uxxhuFBQqttpZ2yOZ1sgWF0jGYidxob7SRw9MvGkRcoAgiGD/XsDM
	Fyco/VT85AgbXsRzm9/08BRPFdNmp6qHBz0vDk2mWVYlLqZeUk54hCbltmv6rL86+e1hyoJRRc2
	xyvOeQdlKw0ytzo+r2hiCOmyqTmcVOVv4vvyZLwIt4GJScZTbEyC9w3KzXzQM=
X-Received: by 2002:aa7:88d2:0:b0:838:127d:a16e with SMTP id d2e1a72fcca58-839228cb3afmr1943221b3a.17.1777965626775;
        Tue, 05 May 2026 00:20:26 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a4bffsm1036227b3a.56.2026.05.05.00.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:20:26 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: "David S . Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Willem de Bruijn <willemb@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v7 2/2] ipv6: flowlabel: enforce per-netns limit for unprivileged callers
Date: Tue,  5 May 2026 15:20:15 +0800
Message-Id: <20260505072015.1672730-3-maoyi.xie@ntu.edu.sg>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505072015.1672730-1-maoyi.xie@ntu.edu.sg>
References: <20260505072015.1672730-1-maoyi.xie@ntu.edu.sg>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9CE204C7DF3
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-243999-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,ms2.inr.ac.ru,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ntu.edu.sg:mid,ntu.edu.sg:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

fl_size, fl_ht and ip6_fl_lock in net/ipv6/ip6_flowlabel.c are
file scope and shared across netns. mem_check() reads fl_size to
decide whether to deny non-CAP_NET_ADMIN callers. capable() runs
against init_user_ns, so an unprivileged user in any non-init
userns can push fl_size past FL_MAX_SIZE - FL_MAX_SIZE / 4 and
starve every other unprivileged userns on the host.

Add struct netns_ipv6::flowlabel_count, bumped and decremented
next to fl_size in fl_intern, ip6_fl_gc and ip6_fl_purge. The new
field fills the existing 4-byte hole after ipmr_seq, so struct
netns_ipv6 stays the same size on 64-bit builds.

Bump FL_MAX_SIZE from 4096 to 8192. It has been 4096 since the
file was added. Machines and connection counts have grown.

mem_check() folds an extra per-netns ceiling into the existing
non-CAP_NET_ADMIN conditional. The ceiling is half of the total
budget that unprivileged callers have ever been able to use, i.e.
(FL_MAX_SIZE - FL_MAX_SIZE / 4) / 2 = 3072 entries. With
FL_MAX_SIZE doubled, this preserves the original per-user reach
of 3K (what an unprivileged caller could already obtain before
this change), while forcing an attacker to spread allocations
across at least two netns to exhaust the global non-CAP_NET_ADMIN
budget.

CAP_NET_ADMIN against init_user_ns still bypasses both caps.

The previous patch took ip6_fl_lock across mem_check and
fl_intern, so the new flowlabel_count read in mem_check and the
new flowlabel_count++ in fl_intern run under the same critical
section. flowlabel_count is therefore plain int, like fl_size.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Willem de Bruijn <willemb@google.com>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
 include/net/netns/ipv6.h |  1 +
 net/ipv6/ip6_flowlabel.c | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 499e42881..875916d60 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -119,6 +119,7 @@ struct netns_ipv6 {
 	struct fib_notifier_ops	*notifier_ops;
 	struct fib_notifier_ops	*ip6mr_notifier_ops;
 	atomic_t		ipmr_seq;
+	int			flowlabel_count;
 	struct {
 		struct hlist_head head;
 		spinlock_t	lock;
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index 43b5e9ce9..e1b2460f9 100644
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
 					fl_size--;
+					fl->fl_net->ipv6.flowlabel_count--;
+					fl_free(fl);
 					continue;
 				}
 				if (!sched || time_before(ttd, sched))
@@ -197,6 +198,7 @@ static void __net_exit ip6_fl_purge(struct net *net)
 				*flp = fl->next;
 				fl_free(fl);
 				fl_size--;
+				net->ipv6.flowlabel_count--;
 				continue;
 			}
 			flp = &fl->next;
@@ -242,6 +244,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 	fl->next = fl_ht[FL_HASH(fl->label)];
 	rcu_assign_pointer(fl_ht[FL_HASH(fl->label)], fl);
 	fl_size++;
+	net->ipv6.flowlabel_count++;
 	return NULL;
 }
 
@@ -459,6 +462,9 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
 static int mem_check(struct sock *sk)
 {
+	const int unpriv_total_limit = FL_MAX_SIZE - (FL_MAX_SIZE / 4);
+	const int unpriv_user_limit = unpriv_total_limit / 2;
+	struct net *net = sock_net(sk);
 	int room;
 	struct ipv6_fl_socklist *sfl;
 	int count = 0;
@@ -477,7 +483,9 @@ static int mem_check(struct sock *sk)
 
 	if (room <= 0 ||
 	    ((count >= FL_MAX_PER_SOCK ||
-	      (count > 0 && room < FL_MAX_SIZE/2) || room < FL_MAX_SIZE/4) &&
+	      (count > 0 && room < FL_MAX_SIZE / 2) ||
+	      room < FL_MAX_SIZE / 4 ||
+	      net->ipv6.flowlabel_count >= unpriv_user_limit) &&
 	     !capable(CAP_NET_ADMIN)))
 		return -ENOBUFS;
 
-- 
2.34.1


