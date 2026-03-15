Return-Path: <stable+bounces-225479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKcYNA3ctmkQJwEAu9opvQ
	(envelope-from <stable+bounces-225479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 17:19:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CD32915D7
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 17:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0FB13006B61
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 16:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CA0371CE0;
	Sun, 15 Mar 2026 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="jff+/rka"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB96371D11
	for <stable@vger.kernel.org>; Sun, 15 Mar 2026 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773591558; cv=pass; b=Xjr3j1dGNNh72SDJ2N0P3Fb2spkKTqukRCUuWzJflRZerwsXXx8fseQfKEwEu++jrdsu3lfQm0K4dG58pe+YJzlNv7RF4/3J74Tc2U20vn2ey+RCH7KPMy7mk/4leCxjGlamRVY+wWY1P2+fWaQuh2pMHamcGiAMhAQcdTeHrI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773591558; c=relaxed/simple;
	bh=g4CAao8ZqmqtdUy+SgdyMkVPd3ywREDYdYWdkUz51Ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8i5XPnkLqEPjaR5rLqFziGYrrGimuQ7yPQaaz5Kl8On883jpZgTLSrfO7EI3gKis3w06pqJ4Vo+ApieO/Ln9ClCbpzSIiARmpRBl8xUcABPHOqtoR9Cix2sKCf3tY2Y3lKZIyN6xwtN2jXgEzHtAamfJ3Anemcg/YDsfpM/XLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=jff+/rka; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82976220e97so2229727b3a.3
        for <stable@vger.kernel.org>; Sun, 15 Mar 2026 09:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773591553; cv=none;
        d=google.com; s=arc-20240605;
        b=J0EYeEkETyB8PL1rnXAf8xkb3iNwACZXJFKi9G3+iDCIFqNmPfxYruq5rJdkzIh0Kq
         zoQAbK1cBadXzGfz5O3GT9SGSckIVpXfBPwyjofDA+R9O9t1WwpjEMUDTrVidCy1Jgwb
         946ieaiDgFv55Jh5p30cOaG23C3lvrA6qS4IbIQSOwm4o8jOoGNu3q4L6fKJmc+UF7zM
         RpN/y09P72jdPNva/KBuDoHHczlm9d7lc5e0YE9ehAm9i5+beR5gKhjlFVbwf+vGzzFC
         4Uzfsndf/vRR4n/qYDxHBn871aqmK4ovQqLVC57v0QHUDF280K06SXA5o9YzILP9kiAs
         rMrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7EulIjs457FDWkH8ubZ5UiSY4G2+TWHJgcekVUzvkrM=;
        fh=/xk6uxSnXtT9qQ4Bftik020zk71o3M02gh78oSj2hbs=;
        b=UTZWdijpyF+JRJpbt6tOpzuakghV1bD2ZiwTK86v5vqgVpkDjteYE36/KxvTFprL0q
         nag4/wzPXRFW5tJdqWawJxCPGmDaPFPEAhF7EpKlu54E9bN4adJnAUDDTq930idE8ERn
         JzBLH8KusLN1p2mqOL3Yl3z5ICYg2HyvkclTBl/r2cI9Bsyo9Tcb/AEEqc43tktqpwiZ
         U9Y7BdsiLulBAowfCyC6vU1dO1b1eiHzNrCQYRxVizcW8XAFDhbLiVQ7iK+5F/jtdkna
         Hu0Mj4iK/4eeLcsNcACDgC/DvvB4OOT7sVICCrbioXRnu6+Zn/Z5B1srhwZsAn96ZszA
         gQ3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773591553; x=1774196353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EulIjs457FDWkH8ubZ5UiSY4G2+TWHJgcekVUzvkrM=;
        b=jff+/rkaOcGtqnXwBzjKgIbY+vfsrKH0CTIhjNj6SDNzZCTmdXifqO49WPQO5jn/db
         QpUN5hQJReCNEu8UrNylPagVMzztgHEUkD67y4Ba9mvv+/mqZkbdP6Ml7P6rbDU2SRi0
         Lbyb3VbsgfbO7wrtAFCaBeovyAn34I6Vw9FEAySTedqBC2oDw15QF3lYl4pH4IL/WqBv
         itqsNTYXOUUdP0hsifv+dhOReNRAOlZFnKY3qUbXr3GbbTP9SDEw/dPogRwTc4W9KSBI
         rzfi1WST3ulqofHC65fqE5uJqG6YG9kVnYK9dRP3WO+S/OzHRXhpKczadFQOMM7Eu3Iq
         1xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773591553; x=1774196353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7EulIjs457FDWkH8ubZ5UiSY4G2+TWHJgcekVUzvkrM=;
        b=s9CVHlGFc33D2EUu4oaIpRuFO7GO8Rm3ssSmflHGb87elTLvm2Kq8lU+fx7MN3nnk9
         kLpL3CgYIDskpyn8dH7aBU1hSJ7BPlVrjYKt15QDHDDBrC0y4aAO8+C67cbl/Kt7yVov
         XRznwomk4Sw/aIHntcIefSR08QR2JJFI7Ct95TAHPWB4y//YOh+ntUOUi3rkO62Ze8DW
         SDXdTFviwwUaIEVbXwWddRmCA3HiyUtFPi3WTMn2pdAGbAqaYgLQXo2dxF9oAIq/KNpu
         hQGD2lb0fcwnak+fAUJVszFbRGlpg85n+BBE0Jp86leSm0oeO7AKBrTKxYlxDqy4U5Sg
         Pvgg==
X-Forwarded-Encrypted: i=1; AJvYcCUuBAY1VkVV1XPAMmqXG1PX+KslMiHmQDvHFKKAroJ0zveweq7VzyQKRpajR6HP3ycletQxFyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfOnbmPbU0rce2uKCx8JsctO5B58N7efsu+lY7U3F1wcmqUJbj
	H3gowD4uGKS+rJI2ryDJFHZVyIfwLjasPGP8X6zOzYOjwIlzluAh6bIMJ/una9Ut+CyZBu+iPUI
	TDjHtMjjbiKOIAGdEh1d9imi0NWDeZmj8OWRF3OH4
X-Gm-Gg: ATEYQzxM7XPalS4ioeyPNUDlwXXHM3UIY3mBX5WQ/iVTMJ/e/5kExwRIYPNugMo7ds3
	fFX//92UhHLMFO8X0e8Bv1N6eay4Lxhp4f2rlCLe5LHMxDw0Kb5I1LWyZ4RxPNriRJR7Q+ktjfV
	9f0PhejrWndBYEpBIJcCU0d0cMBSLt9UkhNo7OxHgPr1mvH/hQYj3ryIQDz1uKUrPcStIBRZhYh
	Ijei2r24fGQ1cIuwNRVEHXpHJc6k9cBvq/+Zw1efa/rRoCCwltBvNSSzh0MVbG+hne+TwvzwbqF
	lw+2TVhParMORss=
X-Received: by 2002:a05:6a00:a0b:b0:81f:3c92:1699 with SMTP id
 d2e1a72fcca58-82a19906fb3mr9218500b3a.59.1773591553433; Sun, 15 Mar 2026
 09:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313211646.12549-1-stephen@networkplumber.org>
 <20260313211646.12549-4-stephen@networkplumber.org> <ydqKfVXU_4_kSsU89EbfSyd66aGeaCaVHFr6kXhrF-qG7G2WCAAOS51LTAM2y_thGnB0pp-pbGLDWqM4XooMX-jelz30W0KbpE3KzCKiWqo=@willsroot.io>
 <20260315090622.5fbdf074@phoenix.local>
In-Reply-To: <20260315090622.5fbdf074@phoenix.local>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 15 Mar 2026 12:19:02 -0400
X-Gm-Features: AaiRm513oKjUthr-xSwhQVj8uBsPnNyc0vXXYZ0a13It-xuC4iLxEunSj8BSBKo
Message-ID: <CAM0EoMnh7gYjEGVB0eqGfannC=i=R5YQZbBfZK1K+CqKJyOMOQ@mail.gmail.com>
Subject: Re: [PATCH 03/12] net/sched: netem: add per-CPU recursion guard for duplication
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: William Liu <will@willsroot.io>, netdev@vger.kernel.org, stable@vger.kernel.org, 
	Savino Dicanosa <savy@syst3mfailure.io>, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225479-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[willsroot.io:email,mail.gmail.com:mid,networkplumber.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim,syst3mfailure.io:email]
X-Rspamd-Queue-Id: 61CD32915D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 12:06=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Sat, 14 Mar 2026 19:29:10 +0000
> William Liu <will@willsroot.io> wrote:
>
> > Looping in Jamal and Victor.
> >
> > On Friday, March 13th, 2026 at 9:17 PM, Stephen Hemminger <stephen@netw=
orkplumber.org> wrote:
> >
> > > Add a per-CPU recursion depth counter to netem_enqueue(). When netem
> > > duplicates a packet, the clone is re-enqueued at the root qdisc. If
> > > the tree contains other netem instances, this can recurse without
> > > bound, causing soft lockups and OOM.
> > >
> > > This approach was previously considered but rejected on the grounds
> > > that netem_dequeue calling enqueue on a child netem could bypass the
> > > depth check. That concern does not apply: the child netem's
> > > netem_enqueue() increments the same per-CPU counter, so the total
> > > nesting depth across all netem instances in the call chain is tracked
> > > correctly.
> >
> > I'm assuming you are referring to [1] (and other relevant followup mess=
ages), but has this setup been tested against the original repro? I think t=
here was a similar draft fix originally but it failed during testing becaus=
e DOS still happened [2].
> >
> > If I remember correctly,  the issue is less so the recursive depth but =
more so being able to differentiate between packets that are previously inv=
olved in duplication or not.
> >
> > >
> > > A depth limit of 4 is generous for any legitimate configuration.
> > >
> > > Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220774
> > > Cc: stable@vger.kernel.org
> > > Reported-by: William Liu <will@willsroot.io>
> > > Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
> > >
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > > ---
> > >  net/sched/sch_netem.c | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > >
> > > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > > index 0ccf74a9cb82..085fa3ad6f83 100644
> > > --- a/net/sched/sch_netem.c
> > > +++ b/net/sched/sch_netem.c
> > > @@ -21,6 +21,7 @@
> > >  #include <linux/rtnetlink.h>
> > >  #include <linux/reciprocal_div.h>
> > >  #include <linux/rbtree.h>
> > > +#include <linux/percpu.h>
> > >
> > >  #include <net/gso.h>
> > >  #include <net/netlink.h>
> > > @@ -29,6 +30,15 @@
> > >
> > >  #define VERSION "1.3"
> > >
> > > +/*
> > > + * Limit for recursion from duplication.
> > > + * Duplicated packets are re-enqueued at the root qdisc, which may
> > > + * reach this or another netem instance, causing nested calls to
> > > + * netem_enqueue(). This per-CPU counter limits the total depth.
> > > + */
> > > +static DEFINE_PER_CPU(unsigned int, netem_enqueue_depth);
> > > +#define NETEM_RECURSION_LIMIT      4
> > > +
> > >  /* Network Emulation Queuing algorithm.
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > @@ -460,6 +470,14 @@ static int netem_enqueue(struct sk_buff *skb, st=
ruct Qdisc *sch,
> > >     /* Do not fool qdisc_drop_all() */
> > >     skb->prev =3D NULL;
> > >
> > > +   /* Guard against recursion from duplication re-injection. */
> > > +   if (unlikely(this_cpu_inc_return(netem_enqueue_depth) >
> > > +                NETEM_RECURSION_LIMIT)) {
> > > +           this_cpu_dec(netem_enqueue_depth);
> > > +           qdisc_drop(skb, sch, to_free);
> > > +           return NET_XMIT_DROP;
> > > +   }
> > > +
> > >     /* Random duplication */
> > >     if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, &q=
->prng))
> > >             ++count;
> > > @@ -474,6 +492,7 @@ static int netem_enqueue(struct sk_buff *skb, str=
uct Qdisc *sch,
> > >     if (count =3D=3D 0) {
> > >             qdisc_qstats_drop(sch);
> > >             __qdisc_drop(skb, to_free);
> > > +           this_cpu_dec(netem_enqueue_depth);
> > >             return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> > >     }
> > >
> > > @@ -529,6 +548,7 @@ static int netem_enqueue(struct sk_buff *skb, str=
uct Qdisc *sch,
> > >             qdisc_drop_all(skb, sch, to_free);
> > >             if (skb2)
> > >                     __qdisc_drop(skb2, to_free);
> > > +           this_cpu_dec(netem_enqueue_depth);
> > >             return NET_XMIT_DROP;
> > >     }
> > >
> > > @@ -643,8 +663,10 @@ static int netem_enqueue(struct sk_buff *skb, st=
ruct Qdisc *sch,
> > >             /* Parent qdiscs accounted for 1 skb of size @prev_len */
> > >             qdisc_tree_reduce_backlog(sch, -(nb - 1), -(len - prev_le=
n));
> > >     } else if (!skb) {
> > > +           this_cpu_dec(netem_enqueue_depth);
> > >             return NET_XMIT_DROP;
> > >     }
> > > +   this_cpu_dec(netem_enqueue_depth);
> > >     return NET_XMIT_SUCCESS;
> > >  }
> > >
> > > --
> > > 2.51.0
> > >
> > >
> >
> > What about the last suggestion for a robust fix from [3]?
> >
> > Best,
> > Will
> >
> > [1] https://lore.kernel.org/netdev/DISZZlS5CdbUKITzkIyT3jki3inTWSMecT6F=
plNmkpYs9bJizbs0iwRbTGMrnqEXrL3-__IjOQxdULPdZwGdKFSXJ1DZYIj6xmWPBZxerdk=3D@=
willsroot.io/
> > [2] https://lore.kernel.org/netdev/q7G0Z7oMR2x9TWwNHOiPNsZ8lHzAuXuVgrZg=
GmAgkH8lkIYyTgeqXwcDrelE_fdS9OdJ4TlfS96px6O9SvnmKigNKFkiaFlStvAGPIJ3b84=3D@=
willsroot.io/
> > [3] https://lore.kernel.org/netdev/20260111163947.811248-6-jhs@mojatatu=
.com/
>
> Thanks, this is a tight corner here, and not all solutions work out.
>
> You're right that the per-CPU guard alone doesn't cover the
> dequeue-to-child-enqueue path you described. That's exactly why
> the series has two patches working together:
>
> Patch 02 adds the per-CPU recursion guard, which handles the
> direct enqueue recursion (rootq->enqueue duplicated packet hits
> another netem_enqueue in the same call chain).
>
> Patch 04 restructures netem_dequeue to eliminate the pump. The
> old code had "goto tfifo_dequeue" which looped back after each
> child enqueue, so packets the child duplicated back to root would
> immediately get picked up by the same dequeue iteration. The new
> code transfers all currently-ready packets from the tfifo to the
> child in one batch, then does a single dequeue from the child and
> returns. Packets that the child duplicates back to root land in
> the tfifo but won't be processed until the next dequeue call from
> the parent =E2=80=94 breaking the loop you diagrammed.
>
> The original repro is:
>
>   tc qdisc add dev lo root handle 1: netem delay 1ms duplicate 100%
>   tc qdisc add dev lo parent 1:1 handle 2: netem delay 1ms duplicate 100%
>   ping -f localhost
>
> This is covered by tdc test f2a3 (nested netem config acceptance)
> and test 7a07 (nested netem with duplication, traffic via scapy).
> More tests are added in the new version.
>
> Jamal's proposed change with skb ttl would also work but
> it was rejected because it required adding ttl field to skb
> and skb size is a performance critical. As Cong pointed out
> adding a couple of bits for ttl makes it increase.
> So considered the idea and decided against it.

It was not "rejected" - other than Cong making those claims (which i
responded to).
Last posting i had some feedback from Willem but i dropped the ball.
And that variant i posted had issues which were not caught by the AI
review - required human knowledge (it didnt consider the GRO code
path).
If you want to go this path - i am fine with it, I will just focus on
the mirred loop.
Also tell your AI to Cc the stakeholders next time it posts via
get_maintainers (and not cc stable) - then i will be fine reviewing.
Commit log (or cover letter) would help if you cite the "documented
examples" you said were broken.

cheers,
jamal


> Thanks.

