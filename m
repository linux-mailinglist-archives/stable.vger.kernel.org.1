Return-Path: <stable+bounces-244340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHseMJ37+mnjUwMAu9opvQ
	(envelope-from <stable+bounces-244340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 10:28:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 244034D7D9A
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 10:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA059305092C
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 08:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AD43E317B;
	Wed,  6 May 2026 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbkuiFuT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47373E315C
	for <stable@vger.kernel.org>; Wed,  6 May 2026 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778055867; cv=none; b=I2cYUqDRTp8kRmN38RrmTWgegFwnXdU+xgF/2kGeD4gcTW1qOrj+d6TTcMaguEKNbwBJgaRcN5+BiYd516GkQj0JlMF89p+pR3ox8KY7z0Yw6POka6OOSPhyTbuCX/m5BDDJhBe45ZYLeVEpw4h4Y92q8dbnyGWTeZTg0k3Q4Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778055867; c=relaxed/simple;
	bh=/Fl6Eup1KJku7VmBbKrDm8Q65djqAuVDuYeegE3umw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V1fL6Z7+oPAIBJUhoIlfsikuSc7zbR8YQnKoS1DNYdXNP+M84vbP71D5zTCKoJzXJsH51Jl51gPQFRRa26CIr1pOk9n9k+MiG54yQtEJobl/X6goSdojZuC83zXeMBO0u+124xgb2VnEhshL/925kdgHv3TKr/2bT6uNHN0D4rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbkuiFuT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36525730172so3728316a91.1
        for <stable@vger.kernel.org>; Wed, 06 May 2026 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778055865; x=1778660665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaLjuq9Nze0HU4z8sneE7fCkabZfqnOhZ8tEew7UUs4=;
        b=GbkuiFuT7rd/q+q/a9Ckw4xtBrwtxlry9JRwTCPCtTK14g4pVYAPqbZUVy5MreOrbr
         w1f8Rw2+N+t/xK0NiikQ5dmO6VsUtrkgORxNv0HLSl9582BD4idkA50bHF/dCAEic3nd
         7BDjCppxJEqLujHos6wAI4+4UeSmdVMopV3P/hmYXn2u7WvcdXTINa8eizVMqq28VoPQ
         vC/PpNdF2pf6pN8RWiEdV72UWTRj6VRTUzK7Mx4pYRclLjevLJKo6BjyuvMCCK0UaW1R
         vUM22iCtUvcozP6Oaymg9oW0EfiZUvFvIxX5YLqyPLcFtDjvddcc8AEdR+xdnA8Tbj3U
         7qkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778055865; x=1778660665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kaLjuq9Nze0HU4z8sneE7fCkabZfqnOhZ8tEew7UUs4=;
        b=GiC/+6GKJeBUiHfR8cG1d8ysLqB0XcUFdgkZEEyzAig8JoH7iYFfOtgxze5IqRfVWQ
         omcrle9rs84G9InpvXmq4kEXtuYheldRMKhtb5RjtroNrhziDKTQHQEpK0YqDD2Vc1BE
         symtxAsX2lepfV4xHX5BrfRvCv+VX/zQ7nvk7UdPFaet7zrCd1cQ3XSITqSlZOqHNkFs
         0f7JrTTfyZPr4Tw5BmUjAyQQ9HCWVHYw9GW0clCygDvdZX6e3Zt0hpORoxTulxq+/cB5
         rM1Lni7s8qPPE7401Vg6BK7M/Buz6DjBkrGzhLFV8JrDeviFn8z2a31L9eLTLj2W269c
         6Thw==
X-Forwarded-Encrypted: i=1; AFNElJ8VzMlLZ0d728CKEANdAivZcX638QJPn8HHjAmQNBISUhElE6DJdg1XyfBRQMvjqLfPJmPvP+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx92uz7UOJxAbkt4YAkS94M+F1ONPOAAshLZ2UC16fD4NOaS1CE
	of0WvLqShD4tfyiLhb6R2crB6TL06/n2IZKKMY/nhrnUTjbjwKd0vomh
X-Gm-Gg: AeBDietHqOEnuU8CpwVWieUypt/aYPWABUG6puLFtlBmnGq3IjWsBBCpBlR8A57BCzF
	Ytf6tfswx+dv7mGGwPtX6cUjvOMpIvVhJ6//9LUdyVh3Fop4OoopE0waSqQ8sbmzAsXWEm65S+c
	SJJiDBUsZALn7UwKsCssYkGKdlrSNIoBROTKfnPy+dpFI3U1EGue+ViM2BurjkIdkHawhsLiFv/
	ZqrageCCNV5AHV6YhlOM6G3e5yL2NR1/5K1vW50IlZRBYIHxYS94/z1+/lXBETb7WAERXH6Wq7g
	NYJSgSfEgTUrv0WgzFXb7HjE919xgcoITJwQdzQidDdZeC20E48nCmKYXzZ1wIV/NIzL7yW1EG2
	TUm57qnLpBX2ynz4GW7yGcZ+hN3GKSGcGf9mvkRMo/7hq2O96cUGyOH5JwnvJEF74S81425SFi8
	qDDKUC2h6fDlHnockBEDKPSNQIfegfCkY3xwRwSsDr9TkRExyAxzWhtoDDO5E=
X-Received: by 2002:a17:90b:5343:b0:35e:57cf:c0a3 with SMTP id 98e67ed59e1d1-365ac7808f4mr2213995a91.26.1778055864948;
        Wed, 06 May 2026 01:24:24 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b12a1eddsm1000293a91.6.2026.05.06.01.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 01:24:24 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
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
	stable@vger.kernel.org,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>
Subject: [PATCH net v8 1/2] ipv6: flowlabel: take ip6_fl_lock across mem_check and fl_intern
Date: Wed,  6 May 2026 16:24:15 +0800
Message-Id: <20260506082416.2259567-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506082416.2259567-1-maoyixie.tju@gmail.com>
References: <20260506082416.2259567-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 244034D7D9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,ms2.inr.ac.ru,gmail.com,vger.kernel.org,ntu.edu.sg];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244340-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ntu.edu.sg:email]

From: Maoyi Xie <maoyi.xie@ntu.edu.sg>

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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
 net/ipv6/ip6_flowlabel.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index c92f98c6f..a89746431 100644
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
@@ -210,10 +210,10 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 {
 	struct ip6_flowlabel *lfl;
 
+	lockdep_assert_held(&ip6_fl_lock);
+
 	fl->label = label & IPV6_FLOWLABEL_MASK;
 
-	rcu_read_lock();
-	spin_lock_bh(&ip6_fl_lock);
 	if (label == 0) {
 		for (;;) {
 			fl->label = htonl(get_random_u32())&IPV6_FLOWLABEL_MASK;
@@ -235,8 +235,6 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 		lfl = __fl_lookup(net, fl->label);
 		if (lfl) {
 			atomic_inc(&lfl->users);
-			spin_unlock_bh(&ip6_fl_lock);
-			rcu_read_unlock();
 			return lfl;
 		}
 	}
@@ -244,9 +242,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 	fl->lastuse = jiffies;
 	fl->next = fl_ht[FL_HASH(fl->label)];
 	rcu_assign_pointer(fl_ht[FL_HASH(fl->label)], fl);
-	atomic_inc(&fl_size);
-	spin_unlock_bh(&ip6_fl_lock);
-	rcu_read_unlock();
+	fl_size++;
 	return NULL;
 }
 
@@ -464,10 +460,14 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
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
 
@@ -692,11 +692,19 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
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
 
-- 
2.34.1


