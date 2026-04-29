Return-Path: <stable+bounces-241842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL5MOn/B8WkbkQEAu9opvQ
	(envelope-from <stable+bounces-241842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:29:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE4B491309
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A2993013294
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 08:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE6A3B27F3;
	Wed, 29 Apr 2026 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJI/M43M"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE5F3AF642
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451364; cv=pass; b=PQyTFXuVDxvxICJNShm/XGbTH8e22qUK8v4EjXbrpvY0ltOYdyogsVLOctInq3zJbEzx7wciqLs6ZFW0VCqxvcpWahRfCxBnwiFFR6It8lkMQ2ABOW7TeHZs0tQkBj1PRgNBLdKO5hARpIWlSV3D7CAeAdRqgoBddYq5VgQDYKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451364; c=relaxed/simple;
	bh=/Gwm6v/TijAsffL2OxDtjOUdBTDbHCA9DZqpqs3v1rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8Zd+FYHWmcZPSxw1KXnYBjC+2HaOdl87PH46FHvIm4QN1mfC3hPmxJkESDk0Oj7vvzh6cQhEYlYWBo6HBKCyyxhrI553nFO+egxv8Zdt+Wo/MU3tHiUube1cxmxNYfAVJFXD4L1ipVZ0/8x4EcyCt0YUYjAVjxtRn48f02PzFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJI/M43M; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so20305502a12.1
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 01:29:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777451362; cv=none;
        d=google.com; s=arc-20240605;
        b=Yo5OJKiy1q/KN1tuhfQyq/k6c9w3cdvJvC1DM+E8vkBaLdCA1QAeHUNHATGyw4SBim
         5uvoz+9ja57DJlnHGF+9HuhS5MKLVyaCrppKcFTw8cZaReEsKs3zp4nQ7FBUfu783rLG
         EuZJ6jQE1LvrESgBXr6vqgKKpCbCrXftcKqjeZHILEBUGv7bCPe3dx9RwMjC91nTLq3z
         Vvy61kx5x5UWvaARn0nZjMU37xUy4zs7mWqzsLG7uCaOSNjJ1uIvz6zNJTVoo0kRG6GL
         XzOg40N/aa/uO5YYeEXJ5mX5HQcyqDPtMysg/L//MsnrL6qz7PGimLbXo5Tyu7zveGEA
         3HcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zG15aGf0OE+kY43cX7iltj+gfDWHix1TD45tz4xvz3g=;
        fh=4hvCSo6j8bEqNHAyjKOF0O1PW9WSvOYG8Vg/Dy1FF88=;
        b=ikzKj48PpYIsq6zDDz57Ccs0qRDCoTLEPvpXNJWMxe/bEAmkAIgmhD227yfMuGuviI
         tHJhK5PVTjNlsexHx+NE70eKWzgpHGBaWiVgA1KXGwQ2vFTRUrJLqSEm6t0jFvOgaJNi
         HaT+XG6d8WAaSGPIqQieoga6YxO4eXPyvOGu9mWngCTztGxU4dkDiyJByPzi79d57vXV
         4/33NZMNMOvX0ZZbRL1Te/GuQ24FgShdXDynpspE/SZThS/0V11+M0E8I0gzDSqzFn0L
         IMIG84nu3XhdCC+FRR+VQkJkXClCQ+pTcWgGciEBWOW521NLdLjK20H8hSCPWLcbBpDr
         Rk5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777451362; x=1778056162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zG15aGf0OE+kY43cX7iltj+gfDWHix1TD45tz4xvz3g=;
        b=eJI/M43MdSFA42iBw3LhW0gYxnPQYtaplpVyvffn8tOIZK0BGz1ijtv4tjStAM6E0A
         Iq7ceW9MSidfXv8sH/CnzQf4tPVmOcwYRoXtXEbWpamU9ehUk9lMsqtC+bKQymck1lEf
         Ng/Zh1ccvZ7U3hThAi1hKJ3sL3WNk8YdhHT54UTbcsihXcZi1ae7WZsa8k8hiDXe4dyN
         bW9oKv/gflJsi6eD32DUtWwTiuA1E3rDERXWNMqx2k3CsOfLV0jRT+lEbUJg6uTYJVax
         vxnUuyfwPKT3iitOEXXgeJo9e+2sz4d+dySsQnBH/3P5VhqegQHHpF6xItzjOSHaKwS0
         x8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777451362; x=1778056162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zG15aGf0OE+kY43cX7iltj+gfDWHix1TD45tz4xvz3g=;
        b=GZ3IWWGPXeE7mHXleQgfSdjIltjUCCsMMbVCfegS7HJWB6pTZOmkCJVD6Y18eiiDlC
         IQizMUIhF/usR1ROtK8jcb9fqsm121cguP54iW++rPGej7SF0uHNdIZT+T8DEIO81VxK
         MPOOBQcGj6NmbLIEz6mmS7kdSCR74knXPFMUSB50jPnppZPpramn/F9BZXU1rrutXyJb
         GaVoC4hUBL8Rt9n848N9UZPoBD+3WG9/8waDPSmaAMPIxCTLmr7gqZzJOJkAoe7318Do
         rqFs+5zKBhVu3H3S0/gHOprsbSEb43WP6OQCod7BeRGbg8osFwkqqVGYi8hr5ZYShd7S
         2R0Q==
X-Forwarded-Encrypted: i=1; AFNElJ9jpvqCYzXOM6/2P7cUNbMrRLC1GR7BcKB+7CArgprUjwqIMfPZCn4TcfTz322fg50X5baBtw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVp3XNGrqGuWf2qfEL71xj1Mh/5+7Gd7K0XzU1T/F8zHOyHjzU
	YDBtonrBnnQObWORIL3O4eu19M2rpD5e5azqNhzGkeTSq6OQSrQeVaFp8d5vlGTMf80AqQhbfW6
	RMJMWSl9wUkibfqVeBtsKRvt38fZEQME=
X-Gm-Gg: AeBDieujqN2OZOlWMMwTh7bRPqhdlz6YA07qHLAtEddHkRizNO/PDvfK7sTvhq4pGLM
	p5vsQpB4ZoksETdZ6rcdJgrcmFJrfL0ZndN+nw6fduCVPKgG3DIvXBzCPU1JjKbWerZjTLm1qwW
	ksPOK+TdxI/tB+OVcWuClknoXW5gbZNGiPcesOdZOoJjpBDdlQCtTMKlIlpV938Oe9tlGcM8kn/
	iQ8HglYPoXkD8v0O9ZJ1dUcv+Fnl66fHukKCDzdBI35Mg6WUNXLnUHaSgugO3jaTQHjYGdvY7Xp
	MNxKoNnK3tVGcIAOSEFN0X15lbJlyphJO7jV7z1ieWX3jDS8tg==
X-Received: by 2002:a17:906:ef0c:b0:ba7:62f:9fa6 with SMTP id
 a640c23a62f3a-bb8018de3eemr369720766b.2.1777451361410; Wed, 29 Apr 2026
 01:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRy_Hg8O9smcwzWTdBn6j6NLwv+8vBXKtm2KTsOoG1CjxC2Dg@mail.gmail.com>
 <afGug2nzdfjEGHxO@secunet.com>
In-Reply-To: <afGug2nzdfjEGHxO@secunet.com>
From: Michal Kosiorek <mkosiorek121@gmail.com>
Date: Wed, 29 Apr 2026 10:29:10 +0200
X-Gm-Features: AVHnY4LqoTY5DkMiKXlxQ8n9WkREu7CVtiTGqR0WHoa-ov-VwakT5YntKk-n-_w
Message-ID: <CAFRy_HgkpfzxtJEJWRa=wfJ+m_++FbGsaezywRXQWt7uhkKoTQ@mail.gmail.com>
Subject: Re: [PATCH] xfrm: protect __xfrm_state_delete against double-unhash
 of byseq/byspi
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, sd@queasysnail.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9AE4B491309
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241842-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkosiorek121@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,secunet.com:email]

v2 addresses your two points:
  - Added Fixes: tags (fe9f1d8779cb for byseq, 7b4dc3600e48 for byspi).
  - Rebased on ipsec.git master (HEAD fa90a3145c03), `git apply --check`
    clean. Same hunk applies to torvalds/master without changes.

Also added `Cc: stable@vger.kernel.org` per stable-kernel-rules.html
Option 1, since the Fixes: tags otherwise leave AUTOSEL doing the
disambiguation work alone.

Patch follows.

---

KASAN reproduces a slab-use-after-free in __xfrm_state_delete()'s
hlist_del_rcu calls under syzkaller load on linux-6.12.y stable
(reproduced on 6.12.47, also reachable via the same code path on
torvalds/master and on the ipsec tree). Nine unique signatures cluster
in the xfrm_state lifecycle, the load-bearing one being:

  BUG: KASAN: slab-use-after-free in __hlist_del
include/linux/list.h:990 [inline]
  BUG: KASAN: slab-use-after-free in hlist_del_rcu
include/linux/rculist.h:516 [inline]
  BUG: KASAN: slab-use-after-free in __xfrm_state_delete net/xfrm/xfrm_stat=
e.c
  Write of size 8 at addr ffff8881198bcb70 by task kworker/u8:9/435

  Workqueue: netns cleanup_net
  Call Trace:
   __hlist_del / hlist_del_rcu
   __xfrm_state_delete
   xfrm_state_delete
   xfrm_state_flush
   xfrm_state_fini
   ops_exit_list
   cleanup_net

The other observed signatures hit the same slab object from
__xfrm_state_lookup, xfrm_alloc_spi, __xfrm_state_insert and an OOB
write variant of __xfrm_state_delete, all on the byseq/byspi
hash chains.

__xfrm_state_delete() guards its byseq and byspi unhashes with
value-based predicates:

if (x->km.seq)
hlist_del_rcu(&x->byseq);
if (x->id.spi)
hlist_del_rcu(&x->byspi);

while everywhere else in the file (e.g. state_cache, state_cache_input)
the safer hlist_unhashed() check is used. xfrm_alloc_spi() sets
x->id.spi =3D newspi inside xfrm_state_lock and then immediately inserts
into byspi, but a path that observes x->id.spi !=3D 0 outside of
xfrm_state_lock can still skip-or-hit the byspi unhash inconsistently
with whether x is actually on the list. The same holds for x->km.seq
versus byseq, and the bydst/bysrc unhashes have no predicate at all,
so a second __xfrm_state_delete() on the same object writes through
LIST_POISON pprev.

The defensive change here:

  - Use hlist_del_init_rcu() instead of hlist_del_rcu() on bydst,
    bysrc, byseq and byspi so a second deletion is a no-op rather
    than a write through LIST_POISON pprev. The byseq/byspi nodes
    are already initialised in xfrm_state_alloc().
  - Test hlist_unhashed() rather than the value predicate for
    byseq/byspi, so the unhash decision tracks list state rather than
    mutable scalar fields.

Empirical verification: applied this patch on top of v6.12.47, rebuilt,
and re-ran the same syzkaller harness for 1h16m on a previously-crashy
configuration that produced ~100 hits each of slab-use-after-free
Read in xfrm_alloc_spi / Read in __xfrm_state_lookup / Write in
__xfrm_state_delete. After the patch, 7.1M execs across 32 VMs at
~1550 exec/sec produced zero xfrm_state UAF/OOB hits. /proc/slabinfo
confirms the xfrm_state slab is actively allocated and freed during
the run (~143 KiB resident), so the fuzzer is still exercising those
code paths -- they just no longer crash.

Reproduction:

  - Linux 6.12.47 x86_64 + KASAN_GENERIC + KASAN_INLINE + KCOV
  - syzkaller @ 746545b8b1e4c3a128db8652b340d3df90ce61db
  - 32 QEMU/KVM VMs x 2 vCPU on AWS c5.metal bare metal
  - 9 unique signatures collected in ~9h, all within xfrm_state
    lifecycle

Fixes: fe9f1d8779cb ("xfrm: add state hashtable keyed by seq")
Fixes: 7b4dc3600e48 ("[XFRM]: Do not add a state whose SPI is zero to
the SPI hash.")
Reported-by: Michal Kosiorek <mkosiorek121@gmail.com>
Tested-by: Michal Kosiorek <mkosiorek121@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Michal Kosiorek <mkosiorek121@gmail.com>
---
 net/xfrm/xfrm_state.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1748d374abca..686014d39429 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -818,17 +818,17 @@ int __xfrm_state_delete(struct xfrm_state *x)

  spin_lock(&net->xfrm.xfrm_state_lock);
  list_del(&x->km.all);
- hlist_del_rcu(&x->bydst);
- hlist_del_rcu(&x->bysrc);
- if (x->km.seq)
- hlist_del_rcu(&x->byseq);
+ hlist_del_init_rcu(&x->bydst);
+ hlist_del_init_rcu(&x->bysrc);
+ if (!hlist_unhashed(&x->byseq))
+ hlist_del_init_rcu(&x->byseq);
  if (!hlist_unhashed(&x->state_cache))
  hlist_del_rcu(&x->state_cache);
  if (!hlist_unhashed(&x->state_cache_input))
  hlist_del_rcu(&x->state_cache_input);

- if (x->id.spi)
- hlist_del_rcu(&x->byspi);
+ if (!hlist_unhashed(&x->byspi))
+ hlist_del_init_rcu(&x->byspi);
  net->xfrm.state_num--;
  xfrm_nat_keepalive_state_updated(x);
  spin_unlock(&net->xfrm.xfrm_state_lock);
--=20
2.54.0


=C5=9Br., 29 kwi 2026 o 09:08 Steffen Klassert
<steffen.klassert@secunet.com> napisa=C5=82(a):
>
> On Tue, Apr 28, 2026 at 09:53:45AM +0200, Michal Kosiorek wrote:
> ...
> >
> > Reported-by: Michal Kosiorek <mkosiorek121@gmail.com>
> > Tested-by: Michal Kosiorek <mkosiorek121@gmail.com>
> > Signed-off-by: Michal Kosiorek <mkosiorek121@gmail.com>
>
> Please add a 'Fixes:' tag so the patch can be backported
> to the stable trees.
>
> > ---
> >  net/xfrm/xfrm_state.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -758,16 +758,16 @@ int __xfrm_state_delete(struct xfrm_state *x)
> >
> >   spin_lock(&net->xfrm.xfrm_state_lock);
> >   list_del(&x->km.all);
> > - hlist_del_rcu(&x->bydst);
> > - hlist_del_rcu(&x->bysrc);
> > - if (x->km.seq)
> > - hlist_del_rcu(&x->byseq);
> > + hlist_del_init_rcu(&x->bydst);
> > + hlist_del_init_rcu(&x->bysrc);
> > + if (!hlist_unhashed(&x->byseq))
> > + hlist_del_init_rcu(&x->byseq);
> >   if (!hlist_unhashed(&x->state_cache))
> >   hlist_del_rcu(&x->state_cache);
> >   if (!hlist_unhashed(&x->state_cache_input))
> >   hlist_del_rcu(&x->state_cache_input);
> >
> > - if (x->id.spi)
> > - hlist_del_rcu(&x->byspi);
> > + if (!hlist_unhashed(&x->byspi))
> > + hlist_del_init_rcu(&x->byspi);
> >   net->xfrm.state_num--;
> >   xfrm_nat_keepalive_state_updated(x);
> >   spin_unlock(&net->xfrm.xfrm_state_lock);
>
> This does not allpy to the ipsec tree. Please
> rebase on the ipsec tree and resend.
>
> Thanks!

