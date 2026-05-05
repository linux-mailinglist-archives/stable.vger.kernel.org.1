Return-Path: <stable+bounces-243998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BwiC12b+Wkm+QIAu9opvQ
	(envelope-from <stable+bounces-243998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:25:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C5F4C7DC7
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84F233078A13
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 07:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADFA3DC4DF;
	Tue,  5 May 2026 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnW2r4XU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0713DCDAA
	for <stable@vger.kernel.org>; Tue,  5 May 2026 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965627; cv=none; b=SoXuYXmrMGhDMYhwekfeSSbrPTPzpZGWxzBqenZg0upWY/2WdDF+9qK6Q8HfuFoF9lBUAwoJGwKnBxjb41AbZQDR5rWE8lusPFq0DIddfQUpwMznnJoFQmzNd6lT1UhvhyF35g3ZXT9E8G97fSLmZUB+wuKSDi8S8uwreWqm/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965627; c=relaxed/simple;
	bh=lX3/cikTXdsSWmYhnFJIwfxPeUjb7oER4YyFpC9sMTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iDkhiULOE4WWUDprrZiTfjN7HkQBElZ5Ztsq4ol57azeDZZw6qfBU7WfkOCNQq2HgwrMecaTMEQdBPN982LnmzmvDDOj+pKLUV/ssn0xQXYPhIrt8YiwqrFGZWq2EdosUzAZRd+h8CFCmOjsSdWm3SscXAtwH65REGzEY/WxYoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnW2r4XU; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-837c09d2268so772051b3a.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 00:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777965624; x=1778570424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qwjbtkwr2FWhUlTbYPqxcC7rI+ouC/k6Ix4Q9N1Kqz8=;
        b=DnW2r4XUNE2mVbot61dbvBrf0XdqHa1YG+fsIrqUf5mEdHWwwilDYWzZAUlZLOy5Dp
         PmALLlnRN6lQN/O6v0GTHp6sODdqUGFTqlhbCUqhpaGXLj9mqHGEueOdSvAqi/yyHnCq
         KAEut3+y9gCmKqDBSReCNJl0NlZBkhl+52RrZeCO+vODDktuUutaL/XOfJS9Zscal3W5
         04JLGS0vskTzgmvF6rHK+jQ9blMoPhb5j5Pn/F5k4JNWjT0m08L239/uiEsvc9nxGiz3
         I9qkKlq8BNkhONPCpZUCqfYydcWOrJVljR61glvTzzd8i2GVccibX5aYDH6UZ5rDB4Uu
         T/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965624; x=1778570424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qwjbtkwr2FWhUlTbYPqxcC7rI+ouC/k6Ix4Q9N1Kqz8=;
        b=MKHBLAI3rsh+W9ZgwoazIEtuTeJfjStYI8uC3Ghx5/JYxs2sKbgtcYiNwlRuzQyiCo
         GrAoI0YYaCsXsu8S74wXao/WRNyicOLv00kw+9hYynvqbyZhM2dNN+tZBLW0/pmRKZOT
         J0rVZoXrj4YdCCol3sCRoVj8yIp8GDLwhCFRtD25xcs4cdJ43H78zPsNIAcAW291AKzv
         SzOoC+q2vtgHnXV8zR++8aXxb+XfuR9x0jQDXkDuel+PiP0t40RCjzIt2ZRn+W1379di
         GG6DGlDKx4E37QGteMbBS3tWObjsMaDAEFU5xcT/LJRQqEyMy7dPkjzGRoeopjQvgygS
         OLYA==
X-Forwarded-Encrypted: i=1; AFNElJ9/neBLdLYZA9etcSZDraqLOhlG1DRgPG7Jmxzm5aGdQmHdjQ3EYvF4RuyIjTS+KzCbBj0Dhlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrQ3Xud1Zh9xznXMe8q54LCV9fyayheft7UTy//iPFeDYXCYu0
	q+x40mjA+Ct3DLusOQcC6E4hrz81XYtqRnsWPB1IViB42f/3u4t/Bf37
X-Gm-Gg: AeBDiev1+2kGAk1GOoiHxvNFXw64ucHLDRvJbD3APgk5OCVZdPk2zreaMNy60JyHqfL
	fcOYauuX0ThM8nqMvYVek/qTOJCcoM3Tdq1xdkn5RRRd5oZaX2t1wtTGkNtFA+tA6xxrlZfFOlj
	xwim8YUOUJI38Ml0oxVPn/KcxJSLWfeWYOu6C6GvrsNvmF9RNY4+OM+m4HxUTIgjIWxu0UcdEA3
	CDeBHk7pz01VAF2NEcFM56UPDasm+l7+GjezZomh98jX0OLLmOpQi9AeGhwVBzMevKK3LBizq1w
	/9QtjJIr0ArbskEt9Eprd+l/rJo9ATmusfigOHHqzN0OeI/wJ2JDpzJfXgJygnnN+X84FBqy+j0
	OyPCSswXrAoHWs+gkT0QzP0MrnZivJaxqc33a9IG+IqhRPM+LF1rmeCen74Ck09y6/KdtPN5bxs
	fOnoOdeAHmCxrJi0y83jeKcgtz0JzRnUPLaJlGwusZmoDfYP3MD93hVw5ch+lZ1XtS5/Gxnw==
X-Received: by 2002:a05:6a00:2e17:b0:82f:5d4f:7355 with SMTP id d2e1a72fcca58-839242a6080mr2160599b3a.33.1777965623740;
        Tue, 05 May 2026 00:20:23 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a4bffsm1036227b3a.56.2026.05.05.00.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:20:23 -0700 (PDT)
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
Subject: [PATCH net v7 1/2] ipv6: flowlabel: take ip6_fl_lock across mem_check and fl_intern
Date: Tue,  5 May 2026 15:20:14 +0800
Message-Id: <20260505072015.1672730-2-maoyi.xie@ntu.edu.sg>
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
X-Rspamd-Queue-Id: C4C5F4C7DC7
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
	TAGGED_FROM(0.00)[bounces-243998-lists,stable=lfdr.de];
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

mem_check() in net/ipv6/ip6_flowlabel.c reads fl_size without
holding ip6_fl_lock. fl_intern() takes the lock immediately
afterwards. The two checks therefore race against concurrent
fl_intern, ip6_fl_gc and ip6_fl_purge writers, which makes the
mem_check budget check approximate.

Move spin_lock_bh(&ip6_fl_lock) and the matching unlock from
fl_intern() into its only caller ipv6_flowlabel_get(). The
mem_check() call now runs under the same critical section as the
fl_intern() insert, so the budget check is exact.

With all writers and the read of fl_size under ip6_fl_lock,
convert fl_size from atomic_t to plain int. The four sites that
update or read fl_size are fl_intern (insert path), ip6_fl_gc
(garbage collector, the !sched check and the per-entry decrement),
ip6_fl_purge (per-netns purge), and mem_check (budget check), and
all four now run under ip6_fl_lock.

This is a prerequisite for adding a per-netns budget alongside
fl_size. The follow-up patch adds netns_ipv6::flowlabel_count and
folds it into mem_check().

Suggested-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
 net/ipv6/ip6_flowlabel.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index c92f98c6f..43b5e9ce9 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -40,7 +40,7 @@
 #define FL_HASH_MASK	255
 #define FL_HASH(l)	(ntohl(l)&FL_HASH_MASK)
 
-static atomic_t fl_size = ATOMIC_INIT(0);
+static int fl_size;
 static struct ip6_flowlabel __rcu *fl_ht[FL_HASH_MASK+1];
 
 static void ip6_fl_gc(struct timer_list *unused);
@@ -163,7 +163,7 @@ static void ip6_fl_gc(struct timer_list *unused)
 				if (time_after_eq(now, ttd)) {
 					*flp = fl->next;
 					fl_free(fl);
-					atomic_dec(&fl_size);
+					fl_size--;
 					continue;
 				}
 				if (!sched || time_before(ttd, sched))
@@ -172,7 +172,7 @@ static void ip6_fl_gc(struct timer_list *unused)
 			flp = &fl->next;
 		}
 	}
-	if (!sched && atomic_read(&fl_size))
+	if (!sched && fl_size)
 		sched = now + FL_MAX_LINGER;
 	if (sched) {
 		mod_timer(&ip6_fl_gc_timer, sched);
@@ -196,7 +196,7 @@ static void __net_exit ip6_fl_purge(struct net *net)
 			    atomic_read(&fl->users) == 0) {
 				*flp = fl->next;
 				fl_free(fl);
-				atomic_dec(&fl_size);
+				fl_size--;
 				continue;
 			}
 			flp = &fl->next;
@@ -205,6 +205,7 @@ static void __net_exit ip6_fl_purge(struct net *net)
 	spin_unlock_bh(&ip6_fl_lock);
 }
 
+/* Caller must hold ip6_fl_lock. */
 static struct ip6_flowlabel *fl_intern(struct net *net,
 				       struct ip6_flowlabel *fl, __be32 label)
 {
@@ -212,8 +213,6 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 
 	fl->label = label & IPV6_FLOWLABEL_MASK;
 
-	rcu_read_lock();
-	spin_lock_bh(&ip6_fl_lock);
 	if (label == 0) {
 		for (;;) {
 			fl->label = htonl(get_random_u32())&IPV6_FLOWLABEL_MASK;
@@ -235,8 +234,6 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 		lfl = __fl_lookup(net, fl->label);
 		if (lfl) {
 			atomic_inc(&lfl->users);
-			spin_unlock_bh(&ip6_fl_lock);
-			rcu_read_unlock();
 			return lfl;
 		}
 	}
@@ -244,9 +241,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 	fl->lastuse = jiffies;
 	fl->next = fl_ht[FL_HASH(fl->label)];
 	rcu_assign_pointer(fl_ht[FL_HASH(fl->label)], fl);
-	atomic_inc(&fl_size);
-	spin_unlock_bh(&ip6_fl_lock);
-	rcu_read_unlock();
+	fl_size++;
 	return NULL;
 }
 
@@ -464,10 +459,14 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
 static int mem_check(struct sock *sk)
 {
-	int room = FL_MAX_SIZE - atomic_read(&fl_size);
+	int room;
 	struct ipv6_fl_socklist *sfl;
 	int count = 0;
 
+	lockdep_assert_held(&ip6_fl_lock);
+
+	room = FL_MAX_SIZE - fl_size;
+
 	if (room > FL_MAX_SIZE - FL_MAX_PER_SOCK)
 		return 0;
 
@@ -692,11 +691,19 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 	if (!sfl1)
 		goto done;
 
+	rcu_read_lock();
+	spin_lock_bh(&ip6_fl_lock);
 	err = mem_check(sk);
+	if (err == 0)
+		fl1 = fl_intern(net, fl, freq->flr_label);
+	else
+		fl1 = NULL;
+	spin_unlock_bh(&ip6_fl_lock);
+	rcu_read_unlock();
+
 	if (err != 0)
 		goto done;
 
-	fl1 = fl_intern(net, fl, freq->flr_label);
 	if (fl1)
 		goto recheck;
 

base-commit: ebb639024ebd47a13a511cce6ae630c15e4b3126
-- 
2.34.1


