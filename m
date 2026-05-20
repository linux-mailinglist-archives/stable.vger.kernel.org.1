Return-Path: <stable+bounces-253372-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFqaGT0mDmr26QUAu9opvQ
	(envelope-from <stable+bounces-253372-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:23:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B046D59AC6E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F23B305B5AA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7F3345CBF;
	Wed, 20 May 2026 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDOQO2mY"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D95733F594
	for <stable@vger.kernel.org>; Wed, 20 May 2026 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305339; cv=pass; b=g6MOTy2QOpPKKfsGvT80muZJoSHLC0ZUB/ekQAtx6/gLha+ytF/78qGEM/pc59lhBtPvUEtbs8NixWFnvrr3fsHC3C3BDjuArtLdRBt8SX6dW3TV1pq5wR6ZOmnF+L7ANYOfv53PeJwELYu9uI0qkYIe2S590X9seqUDUDLNSWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305339; c=relaxed/simple;
	bh=yG/p/yuvMmqBSrI24CIpddBCL6WpWYyfLyN4AvPjGIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHsEpazXUHd/NDPjphGYyJHQABn0HpfpVYZC4Bykkimr8aCuMU9qSburcqtC5Q9KbzD07qTDxlXzFltePC+/BpOnZ4d110cnZwcEu8+ECoCco3fOEjGOxtBnWal2Q9MVJwSo2GgD0KqLLRCvMhCsrwK4W/BWK2MkBWXTsQbMfEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDOQO2mY; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-464bba3a9easo3303899b6e.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 12:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779305337; cv=none;
        d=google.com; s=arc-20240605;
        b=EFMt5WkDZUGvjG90Hhvov1mPxJXO2Lh0sbQOEBzKm+Z1JjNPJE7XaHRv9keYt1TNWi
         4bGYeaMeLvy1oPFy20nmYXQJKtoEX/yyJqapfFLDN9p22eULRyWPys6JPWGpuDnz49nJ
         tSARpa+8pbnnyQKy4AVCk02CFTkMqQz92wIME0TAT0mTUkEJHgnQfGJT7hTzcxzmLreJ
         F0VN3gTJfwgd2GYOZP3KvkjSGVeZmZIT0QD8D+Qx5xh5lNdSQVQ9N77UTD4kL0S4BEPl
         hocr/80yfR3eTGf1f0ChW8Br1HoIn/3WUn80Tgia1KWZ10xEquw2C564f7zO5IGLNjyJ
         R7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A3UCWntrndamBVtc/z+S3mQBh/bx6v1SPMImgyyDyCA=;
        fh=8tzevW3Tfofph0fqeDg8TyWoWPgZ6cuT7EH8BNNat3U=;
        b=cJW+pUWO7TjttRHMN4bHpGAeUj2kAJ7BMxGX9IaPbpb9fkV9byAsl+ykNkraRSB7na
         B8Sf3znMaEWMkwkuD5tA1G50oYInb5VzyxI2vIL0uO9noxE3XCZx/Kar/i4DbvEqGZKd
         VJsapOG1oIEmU94RwRr7+EjcpQ0dbiixfIgqI54lKNXBUsoLaZXHo7+cNJsDkeqF0rRw
         o3fQHoSL6wey1E10V7deQhxg3axeRK8Zs732UwAXwSG5jJeX05rEQJ8Rqllzsz0+wfSr
         /8Pa76bgvsHO8G1Sk9NyVR7PxnDNa+2z/dK7TlHca7+vY9FbTHHX8Y7Foia3CCoH+WD9
         zTlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779305337; x=1779910137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3UCWntrndamBVtc/z+S3mQBh/bx6v1SPMImgyyDyCA=;
        b=XDOQO2mY2JxKrCvsz8pwXTrrYe0wLP1IvH3Zhz2heeJWT12MfrPNfl+TSIPeBvjefC
         08iw8IiZgA9dvRNqpg5Y6hQ7DeG6krpDWxo2IqUuDsG2NYhy4EmTVz/mR38n7UwCB69X
         iY4rY3YEr8luHm5JbAURtLqd9aZCoNKO+rN+9DLvVkQeZgxM2yopcs3emLl5kC/ZMhj5
         OBsw2l8h7z4wl4o10VweawaUGv4xhj75gyDhufSEk12IS5/fLhRjjL8NWl0/XQoKBjEH
         0dFnVzd695pGt8H7HJRXN1uj+nCcdplN/z4BLQLpLgSQSa2XmAPOOGvSeOqS3CTBGkIQ
         ivxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779305337; x=1779910137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A3UCWntrndamBVtc/z+S3mQBh/bx6v1SPMImgyyDyCA=;
        b=Bd9VLrbSCu6cd5CdhmdNAlqCPylbqgzZl+z537bxym+aOzYLNgCA40IPxLndASNPIV
         rM9XDz+Mz64itAvq/0AEglmOK22Z86Mruta4ZvZQsoZYGPJA+XG2Mp6rfjLujWGzFu2D
         /BTVJgtMOsd7IOWtNyz2mqOC5j3mPqZJAPJWtKCLpTgNBX9oLP5qiXAYHrbZF7ZBkrhe
         Xkbj4mJW9c5tR0CfWR+ZN8VtB7wEZ6yPC7/X3odDacqWFrRkgnFhGMaKMbBlExM0b9vr
         ZNlRZSI4s6ki2ulYOA1wwDFuxEYwiFeyaasKJVASZdNFWRLLrPWQ51+e7T5Xfurub2Fs
         LjKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+FIYGtYW3P4uIH9QaOsf4tBCU0zqyZABnLvlq0Kx9UmM6/j4lsCAdAJIjOopoopJN63Qjdvkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxab3Yk7dlrq0/qHVLgH5CijbGJ2AZ+iBEbc8RRJ5c9CZkW2DVi
	dqhbGPZFyq14a25IYlqUKf8hVUuecRZwlAud2KUL+j8+4XhpRpghxIMO5fhAYAH4/XbKhkBJrQ4
	KJWGY+u6C1MkuzSCXXzUUtHcZOdq2UmQ=
X-Gm-Gg: Acq92OE3tHU+oV0H3hBmdBEgFwScqE3i4J8VmgMJhxphyjTjt27kHvySiR47Gw193ot
	YX93GRGHyGp2NxuziNuWFCVhf1TGOHbYOXXWYfVNDlZZjuuXreKlTuoPctObVlYI3HtCW9TkuUf
	rOcvjw5mLw6k5MF0qojDWoNnSF5zoE4vVZLcz48nUiZ/XNBMUbyYpNxbvcclARzUzko4nyUQ21U
	xvI1A3ZHVvBjk/kSDAm90q5gY5UyeUbqBt/7uQn5jirFPAXNhEVAs4a5yhPf0TCTlIY0NykJMsK
	8nUO+Ma362VcPOICdkswH8aY9OWMQ4aoOW8EUw==
X-Received: by 2002:a05:6808:6714:b0:479:fb8d:dfb7 with SMTP id
 5614622812f47-482e596ca6fmr17496612b6e.33.1779305337045; Wed, 20 May 2026
 12:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519203530.66310-1-devnexen@gmail.com> <CAHS8izOL4yyPH4+ZUXxKB6JAj0EgbFK5UkG+SSb4rk_vG6EfhQ@mail.gmail.com>
In-Reply-To: <CAHS8izOL4yyPH4+ZUXxKB6JAj0EgbFK5UkG+SSb4rk_vG6EfhQ@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 20 May 2026 20:28:43 +0100
X-Gm-Features: AVHnY4KuWqXR53z8xCkPj3OfkuOQUnc1neGMFTH-z7PxOL90NyF34xVuL-9wu-0
Message-ID: <CA+XhMqxPNEBVey8xw_yisymwL2H_04hL48GOyPk08U8p0tYM2g@mail.gmail.com>
Subject: Re: [PATCH net v2] net: devmem: reject dma-buf bind with
 non-page-aligned size or SG length
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	sdf@fomichev.me, sdf.kernel@gmail.com, kaiyuanz@google.com, 
	bobbyeshleman@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253372-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B046D59AC6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 at 19:55, Mina Almasry <almasrymina@google.com> wrote:
>
> On Tue, May 19, 2026 at 1:35=E2=80=AFPM David Carlier <devnexen@gmail.com=
> wrote:
> >
> > net_devmem_bind_dmabuf() trusts dmabuf->size and sg_dma_len() to be
> > PAGE_SIZE multiples without checking:
> >
> >   - tx_vec is sized dmabuf->size / PAGE_SIZE, and
> >     net_devmem_get_niov_at() only bounds-checks virt_addr < dmabuf->siz=
e
> >     before indexing tx_vec[virt_addr / PAGE_SIZE]. With size =3D
> >     N*PAGE_SIZE + r (1 <=3D r < PAGE_SIZE), sendmsg() at iov_base =3D
> >     N*PAGE_SIZE passes the bound check and reads tx_vec[N] -- one past.
> >
> >   - owner->area.num_niovs =3D len / PAGE_SIZE while gen_pool_add_owner(=
)
> >     covers the full byte len, so a non-page-multiple non-final sg
> >     desyncs num_niovs from the gen_pool region for every later sg, on
> >     both RX and TX.
> >
> > dma-buf does not require page-aligned sizes, so the bind path has to
> > enforce what its own indexing assumes. Reject both with -EINVAL.
> >
> > The size check is TX-only (only tx_vec is sized off dmabuf->size); the
> > SG-length check covers both directions.
> >
> > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> > Changes in v2:
> >   - Reframe commit message around the kernel-side OOB instead of
> >     "real exporters already page-align", which read as the OOB being
> >     unreachable and undercut Cc: stable (Stanislav Fomichev).
> >   - Hoist the SG-length check out of the if (TX) branch so it covers
> >     RX too; RX has the same num_niovs / gen_pool desync on a
> >     contract-violating exporter, just without an OOB. Keep the
> >     size-multiple check TX-only (Stanislav Fomichev).
> >   - Drop bool todevice; compare direction =3D=3D DMA_TO_DEVICE inline t=
o
> >     match the existing call site at the tx_vec[] assignment
> >     (Bobby Eshleman).
> >
> >  net/core/devmem.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index 468344739db2..4f71de44c0fb 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -241,6 +241,11 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> >         }
> >
> >         if (direction =3D=3D DMA_TO_DEVICE) {
> > +               if (!IS_ALIGNED(dmabuf->size, PAGE_SIZE)) {
> > +                       err =3D -EINVAL;
> > +                       NL_SET_ERR_MSG(extack, "TX dma-buf size must be=
 a multiple of PAGE_SIZE");
> > +                       goto err_unmap;
> > +               }
> >                 binding->tx_vec =3D kvmalloc_objs(struct net_iov *,
> >                                                 dmabuf->size / PAGE_SIZ=
E);
> >                 if (!binding->tx_vec) {
> > @@ -267,6 +272,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> >                 size_t len =3D sg_dma_len(sg);
> >                 struct net_iov *niov;
> >
> > +               if (!IS_ALIGNED(len, PAGE_SIZE)) {
> > +                       err =3D -EINVAL;
> > +                       NL_SET_ERR_MSG(extack, "dma-buf SG length must =
be PAGE_SIZE aligned");
> > +                       goto err_free_chunks;
> > +               }
> > +
> >                 owner =3D kzalloc_node(sizeof(*owner), GFP_KERNEL,
> >                                      dev_to_node(&dev->dev));
> >                 if (!owner) {
> > --
> > 2.53.0
> >
>
> No hold on, I don't think we actually have a bug here. AFAIR all
> you're describing is intionional . Yes the TX vectors and their niov
> arrays do implicitly 'pad' the dmabuf size to PAGE_SIZE.
>
> But net_devmem_get_niov_at has this check that prevents us from trying
> to send past the dma-buf size, even if it's not page_aligned:
>
> ```
> if (virt_addr >=3D binding->dmabuf->size)
> return NULL;
> ```
>
> IIRC the NULL should be bubbled up to the user as some error.
>
> Please double check that we actually have a bug here. If not, please
> don't merge this. This change could break existing users using devmem
> TX correctly with non-PAGE_SIZE aligned dmabufs, which is a valid use
> case.
>
> And if we have a bug, lets fix it in some way that doesn't deprecate
> support for non page-aligned TX dmabufs. You may be breaking users
> here.
>
> --
> Thanks,
> Mina

Hi, Mina, note that the guard you're quoting doesn't cover the case
I'm describing. It's in bytes against dmabuf->size, while tx_vec is
sized dmabuf->size / PAGE_SIZE
  (truncating) -- there's a sub-page window where the check passes and
the index doesn't.

  Concretely, PAGE_SIZE =3D 4096 and dmabuf->size =3D 4097:

  tx_vec allocated for 4097 / 4096 =3D 1 entry (valid index 0).
  sendmsg with iov_base =3D 4096:
    virt_addr >=3D dmabuf->size   ->  4096 >=3D 4097, passes.
    tx_vec[virt_addr / PAGE_SIZE] -> tx_vec[1], OOB by one.

  And the OOB pointer isn't just returned to the caller -- it flows
through get_netmem() -> __get_netmem(), which dereferences it
(net_is_devmem_iov() reads ->type) and
   on a matching byte refcounts the binding off of it. So this is a
controlled OOB deref, not just a stray read.

  On breaking users: the partial-page tail was never TX-usable to
begin with. The fill loop only populates num_niovs =3D len / PAGE_SIZE
entries while
  gen_pool_add_owner() covers the full byte len, so any sendmsg into
[num_niovs*PAGE_SIZE, dmabuf->size) was already heading for either
NULL or this OOB. It's not
  deprecating a working configuration -- it's rejecting one that wasn't wor=
king.

  Also worth flagging: the second hunk (sg_dma_len alignment) is the
RX path too. net_devmem_get_niov_at() is TX-only, so the guard you
quoted doesn't apply there, and
  the num_niovs vs gen_pool_add_owner(len) desync hits every non-final
SG with a sub-page length, both directions.

  If you'd prefer to keep non-aligned binds legal, an alternative
would be tightening the guard in net_devmem_get_niov_at() to virt_addr
>=3D num_niovs * PAGE_SIZE
  instead of >=3D dmabuf->size. Happy to spin that as v3 -- but it
doesn't help the SG-length leg, which still needs rejecting at bind
time.

Cheers.

