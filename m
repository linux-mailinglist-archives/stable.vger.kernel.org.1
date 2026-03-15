Return-Path: <stable+bounces-225481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNf2AMTqtmlRKQEAu9opvQ
	(envelope-from <stable+bounces-225481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 18:22:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 573CE291B64
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 18:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A634303C2B1
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 17:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E59374E67;
	Sun, 15 Mar 2026 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="2wJrHZKw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF711D6195
	for <stable@vger.kernel.org>; Sun, 15 Mar 2026 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595111; cv=none; b=TgcntxvFB3DcAR7JszES05oR7d4SU9QeaYlIEs+gTaKzNJE+eKpePMdG8shLamu7MGNdGmUJMwO6C3GYnONOAOiPbwRG247KXagCc9bW02zsEBarthyjT0ul0nSvdHPUpqDVF//U0TpXCBQwJTh9/riqrFUkSQtWR4ysgXkp1TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595111; c=relaxed/simple;
	bh=4I/R+nf+tCduGe/Iz//wKAanfpis4N2VlL2DM4CyWd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6pq8AB83xxx+dI4owto5xB8A+UAwTNl2cFu9lTTICAoiemHWUITo2BBRKoVdQmTawZZPqe6BGEGFFm6cq4nrAR3PhGEtfngscqy4isZDMXu/7nm5W4JROHMlVR9pqNJBQ57rhsnWnHiVw8kH3h1C2T9DamqjdtQoV7tSWm9AfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=2wJrHZKw; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35b90d6fe14so536597a91.2
        for <stable@vger.kernel.org>; Sun, 15 Mar 2026 10:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773595109; x=1774199909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5n+0HPqgzG1OEXMehOgisyL5XK4oZf3WBCHHjquYMU=;
        b=2wJrHZKwminrbl6ucbCRmv8Hi3VYCKyTi8cs9jFfuZRr0hpKXuqcIKFBnOqkhkeyUL
         FUByl5smdN9wbjTO/4tRfgEjs+SLW1JRNKQvi/uQbWnUuYpraQ09pRj1cpFB9mofo3W+
         9CQdylF0nCI77LuXptpzDnzlwek7hv1BsPbopBrsr1UZcpO89GkVVqfGDCgllyxADyzO
         rn8GKJ6+TOz5MbI5lsfGEe/gkUFuHG1y7epZklzLFUpow1lu+XcgpDz3UjzIAdDCFkt2
         KIukF5pDpYZa+YWDPRtEBOAJnZuIKQj+xvf6vgMa+YquFvf/Pkvshtru6WRGzjKDhF3P
         NExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595109; x=1774199909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L5n+0HPqgzG1OEXMehOgisyL5XK4oZf3WBCHHjquYMU=;
        b=O6+CyXdzvQ2KGSvKwlxR8gY8CTM5cz1mopjq6O+tG6iDu43wUjak4IKzxrxDu2rXAo
         mnJR8B4l3egXtTBD4BbbUDFQFoaNVq8Z23Ou0TrufOmtOJN4sNw9TR0tbwvGo7KnaJEF
         FDeEqAXBLSb61wF3AcYsjpu7OO3g+vGVymHKfDbRKHq2KTjE3tVcX+HBQo4KeRhSP+NG
         nHd5WBaBcIiW7VnIxH9RMTa4eO3ub5TJ28JO8YZXmDmgsS7VTJdTgpjqKyaydFOdC8tA
         t+FliZdbcpLeLpTeIUSBS3Y3pa7o919MTGH0/8pS0o02l5+a5fsxsZiZM8a1PViHj/lD
         IfTA==
X-Forwarded-Encrypted: i=1; AJvYcCVGbeYCRNtxQalcbVhnR81TpX+PaSYKLlUpQ8kd3v0EfkJ6OmAm32S5YaIFyuEsMtLlUh/Z3pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWkHALg81zdGm+pv8QfDTWl1uEY63GKcdxKB7XV9z+7bnaRcm1
	pTXYs0eGQLFy6UZydWNej7sSF5/fvWWJsMz8dPIZdKlQsQBcY21B7mySawCzeCo/roI=
X-Gm-Gg: ATEYQzwwQAgIjzVAE2NwYwBfxBWumSYdUGOeHUy8wNxyTujGNjUcAmbrziNvzSNibJh
	wAbVLwfLoJrkV563XJOzJAjDe6jLblrJFksnbON4w8VY4jJeQ2gbYDepwFfXV57/jWVFuPhsW4G
	Fpkro77vvuNCNIO2AGZUAsgfBtXAq54StGaOWoE5nRKsG0TOBUbxQPRmAFXrzsCbOAgzl+WuD9k
	rYahCNPvpeAhWhoYaAaudsoFrI9/LPZLyNq6p+RDcgbkGHUOhQwPsRMBVgZzeavJRGYJqSS9baE
	8C6pJ4A9ywG946ddb3lztLWuOJTmMjwKLibURXpRyph8pfd+2D/LlfeoXu6IuTwtcOXANFA94BN
	RKrLLJcr6QzoGLEuCBWB70dqxQXlDWsQ76iRmkbCiTvXJ5LrrO16Y0fUYXOkn888SuvAdRtMBy5
	xFvkYw1QLD1QDN5ydDrdA5kDQLa5x1emPuJ5U=
X-Received: by 2002:a17:90b:3dc7:b0:35b:9ab6:1d4b with SMTP id 98e67ed59e1d1-35b9ab61eb1mr1341368a91.20.1773595108960;
        Sun, 15 Mar 2026 10:18:28 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02e196fdsm14243693a91.2.2026.03.15.10.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:18:28 -0700 (PDT)
Date: Sun, 15 Mar 2026 10:18:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: William Liu <will@willsroot.io>, netdev@vger.kernel.org,
 stable@vger.kernel.org, Savino Dicanosa <savy@syst3mfailure.io>, Victor
 Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH 03/12] net/sched: netem: add per-CPU recursion guard for
 duplication
Message-ID: <20260315101818.1382d6f6@phoenix.local>
In-Reply-To: <CAM0EoMnh7gYjEGVB0eqGfannC=i=R5YQZbBfZK1K+CqKJyOMOQ@mail.gmail.com>
References: <20260313211646.12549-1-stephen@networkplumber.org>
	<20260313211646.12549-4-stephen@networkplumber.org>
	<ydqKfVXU_4_kSsU89EbfSyd66aGeaCaVHFr6kXhrF-qG7G2WCAAOS51LTAM2y_thGnB0pp-pbGLDWqM4XooMX-jelz30W0KbpE3KzCKiWqo=@willsroot.io>
	<20260315090622.5fbdf074@phoenix.local>
	<CAM0EoMnh7gYjEGVB0eqGfannC=i=R5YQZbBfZK1K+CqKJyOMOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225481-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,phoenix.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syst3mfailure.io:email,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 573CE291B64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 15 Mar 2026 12:19:02 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> On Sun, Mar 15, 2026 at 12:06=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Sat, 14 Mar 2026 19:29:10 +0000
> > William Liu <will@willsroot.io> wrote:
> > =20
> > > Looping in Jamal and Victor.
> > >
> > > On Friday, March 13th, 2026 at 9:17 PM, Stephen Hemminger <stephen@ne=
tworkplumber.org> wrote:
> > > =20
> > > > Add a per-CPU recursion depth counter to netem_enqueue(). When netem
> > > > duplicates a packet, the clone is re-enqueued at the root qdisc. If
> > > > the tree contains other netem instances, this can recurse without
> > > > bound, causing soft lockups and OOM.
> > > >
> > > > This approach was previously considered but rejected on the grounds
> > > > that netem_dequeue calling enqueue on a child netem could bypass the
> > > > depth check. That concern does not apply: the child netem's
> > > > netem_enqueue() increments the same per-CPU counter, so the total
> > > > nesting depth across all netem instances in the call chain is track=
ed
> > > > correctly. =20
> > >
> > > I'm assuming you are referring to [1] (and other relevant followup me=
ssages), but has this setup been tested against the original repro? I think=
 there was a similar draft fix originally but it failed during testing beca=
use DOS still happened [2].
> > >
> > > If I remember correctly,  the issue is less so the recursive depth bu=
t more so being able to differentiate between packets that are previously i=
nvolved in duplication or not.
> > > =20
> > > >
> > > > A depth limit of 4 is generous for any legitimate configuration.
> > > >
> > > > Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220774
> > > > Cc: stable@vger.kernel.org
> > > > Reported-by: William Liu <will@willsroot.io>
> > > > Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
> > > >
> > > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > > > ---
> > > >  net/sched/sch_netem.c | 22 ++++++++++++++++++++++
> > > >  1 file changed, 22 insertions(+)
> > > >
> > > > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > > > index 0ccf74a9cb82..085fa3ad6f83 100644
> > > > --- a/net/sched/sch_netem.c
> > > > +++ b/net/sched/sch_netem.c
> > > > @@ -21,6 +21,7 @@
> > > >  #include <linux/rtnetlink.h>
> > > >  #include <linux/reciprocal_div.h>
> > > >  #include <linux/rbtree.h>
> > > > +#include <linux/percpu.h>
> > > >
> > > >  #include <net/gso.h>
> > > >  #include <net/netlink.h>
> > > > @@ -29,6 +30,15 @@
> > > >
> > > >  #define VERSION "1.3"
> > > >
> > > > +/*
> > > > + * Limit for recursion from duplication.
> > > > + * Duplicated packets are re-enqueued at the root qdisc, which may
> > > > + * reach this or another netem instance, causing nested calls to
> > > > + * netem_enqueue(). This per-CPU counter limits the total depth.
> > > > + */
> > > > +static DEFINE_PER_CPU(unsigned int, netem_enqueue_depth);
> > > > +#define NETEM_RECURSION_LIMIT      4
> > > > +
> > > >  /* Network Emulation Queuing algorithm.
> > > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > @@ -460,6 +470,14 @@ static int netem_enqueue(struct sk_buff *skb, =
struct Qdisc *sch,
> > > >     /* Do not fool qdisc_drop_all() */
> > > >     skb->prev =3D NULL;
> > > >
> > > > +   /* Guard against recursion from duplication re-injection. */
> > > > +   if (unlikely(this_cpu_inc_return(netem_enqueue_depth) >
> > > > +                NETEM_RECURSION_LIMIT)) {
> > > > +           this_cpu_dec(netem_enqueue_depth);
> > > > +           qdisc_drop(skb, sch, to_free);
> > > > +           return NET_XMIT_DROP;
> > > > +   }
> > > > +
> > > >     /* Random duplication */
> > > >     if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, =
&q->prng))
> > > >             ++count;
> > > > @@ -474,6 +492,7 @@ static int netem_enqueue(struct sk_buff *skb, s=
truct Qdisc *sch,
> > > >     if (count =3D=3D 0) {
> > > >             qdisc_qstats_drop(sch);
> > > >             __qdisc_drop(skb, to_free);
> > > > +           this_cpu_dec(netem_enqueue_depth);
> > > >             return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> > > >     }
> > > >
> > > > @@ -529,6 +548,7 @@ static int netem_enqueue(struct sk_buff *skb, s=
truct Qdisc *sch,
> > > >             qdisc_drop_all(skb, sch, to_free);
> > > >             if (skb2)
> > > >                     __qdisc_drop(skb2, to_free);
> > > > +           this_cpu_dec(netem_enqueue_depth);
> > > >             return NET_XMIT_DROP;
> > > >     }
> > > >
> > > > @@ -643,8 +663,10 @@ static int netem_enqueue(struct sk_buff *skb, =
struct Qdisc *sch,
> > > >             /* Parent qdiscs accounted for 1 skb of size @prev_len =
*/
> > > >             qdisc_tree_reduce_backlog(sch, -(nb - 1), -(len - prev_=
len));
> > > >     } else if (!skb) {
> > > > +           this_cpu_dec(netem_enqueue_depth);
> > > >             return NET_XMIT_DROP;
> > > >     }
> > > > +   this_cpu_dec(netem_enqueue_depth);
> > > >     return NET_XMIT_SUCCESS;
> > > >  }
> > > >
> > > > --
> > > > 2.51.0
> > > >
> > > > =20
> > >
> > > What about the last suggestion for a robust fix from [3]?
> > >
> > > Best,
> > > Will
> > >
> > > [1] https://lore.kernel.org/netdev/DISZZlS5CdbUKITzkIyT3jki3inTWSMecT=
6FplNmkpYs9bJizbs0iwRbTGMrnqEXrL3-__IjOQxdULPdZwGdKFSXJ1DZYIj6xmWPBZxerdk=
=3D@willsroot.io/
> > > [2] https://lore.kernel.org/netdev/q7G0Z7oMR2x9TWwNHOiPNsZ8lHzAuXuVgr=
ZgGmAgkH8lkIYyTgeqXwcDrelE_fdS9OdJ4TlfS96px6O9SvnmKigNKFkiaFlStvAGPIJ3b84=
=3D@willsroot.io/
> > > [3] https://lore.kernel.org/netdev/20260111163947.811248-6-jhs@mojata=
tu.com/ =20
> >
> > Thanks, this is a tight corner here, and not all solutions work out.
> >
> > You're right that the per-CPU guard alone doesn't cover the
> > dequeue-to-child-enqueue path you described. That's exactly why
> > the series has two patches working together:
> >
> > Patch 02 adds the per-CPU recursion guard, which handles the
> > direct enqueue recursion (rootq->enqueue duplicated packet hits
> > another netem_enqueue in the same call chain).
> >
> > Patch 04 restructures netem_dequeue to eliminate the pump. The
> > old code had "goto tfifo_dequeue" which looped back after each
> > child enqueue, so packets the child duplicated back to root would
> > immediately get picked up by the same dequeue iteration. The new
> > code transfers all currently-ready packets from the tfifo to the
> > child in one batch, then does a single dequeue from the child and
> > returns. Packets that the child duplicates back to root land in
> > the tfifo but won't be processed until the next dequeue call from
> > the parent =E2=80=94 breaking the loop you diagrammed.
> >
> > The original repro is:
> >
> >   tc qdisc add dev lo root handle 1: netem delay 1ms duplicate 100%
> >   tc qdisc add dev lo parent 1:1 handle 2: netem delay 1ms duplicate 10=
0%
> >   ping -f localhost
> >
> > This is covered by tdc test f2a3 (nested netem config acceptance)
> > and test 7a07 (nested netem with duplication, traffic via scapy).
> > More tests are added in the new version.
> >
> > Jamal's proposed change with skb ttl would also work but
> > it was rejected because it required adding ttl field to skb
> > and skb size is a performance critical. As Cong pointed out
> > adding a couple of bits for ttl makes it increase.
> > So considered the idea and decided against it. =20
>=20
> It was not "rejected" - other than Cong making those claims (which i
> responded to).
> Last posting i had some feedback from Willem but i dropped the ball.
> And that variant i posted had issues which were not caught by the AI
> review - required human knowledge (it didnt consider the GRO code
> path).
> If you want to go this path - i am fine with it, I will just focus on
> the mirred loop.
> Also tell your AI to Cc the stakeholders next time it posts via
> get_maintainers (and not cc stable) - then i will be fine reviewing.
> Commit log (or cover letter) would help if you cite the "documented
> examples" you said were broken.
>=20
> cheers,
> jamal

The AI never does any posting, I do. It is used for review only.

You are correct that the original skb ttl size objection was a
"red herring"; the size only changed in a minimal config corner
case and alignment padding absorbs it anyway.

Looking deeper at the ttl approach, I noticed that sharing the
skb ttl across multiple subsystems could lead to new problems.
For example: netem with duplication + mirred redirect is a
legitimate combination. Netem increments ttl on the duplicate,
mirred increments it again on redirect =E2=80=94 with only 2 bits (0-3),
a valid packet gets dropped after just two hops. Each subsystem
needs its own budget, which is what separate per-CPU counters
give you.

The per-CPU counter approach is simple and proven. Earlier versions
of mirred used the same pattern (tcf_mirred_nest_level). Why did
it get changed?

Regarding the broken documented examples: the netem wiki shows
HTB with netem leaves on different classes, and HFSC with netem
children. check_netem_in_tree() rejects both if any branch has
duplication enabled. I'll add specific citations in the next
version.

Lastly, my understanding of Linus's rules on regressions is
that a regression must not be introduced even if it fixes a bug.=20
The "No regressions" rule is highest priority here.
=20


