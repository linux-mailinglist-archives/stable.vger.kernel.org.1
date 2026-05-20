Return-Path: <stable+bounces-253386-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPHDCBw/Dmqr9AUAu9opvQ
	(envelope-from <stable+bounces-253386-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:09:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B6E59C94E
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED43C32FF5E6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED883379EC6;
	Wed, 20 May 2026 21:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/o9VH2T"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D4737998B
	for <stable@vger.kernel.org>; Wed, 20 May 2026 21:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310986; cv=pass; b=bB1HYjk15vYe/xu9Z55lfJK+svPDW3u+gGMAKaoDmxgvkbeoLfi00WEvhREDDMxlJ98Kck9u/JKbeB+l2xaXjT7p1LnXSzkkT9pHqEkHe7I9nR6dsVGKWPVXBLS333IYf6dQ8S61WYCR/YMwjaVqitQeV0oFQblUuB89NAIcKHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310986; c=relaxed/simple;
	bh=stpRi+PiiMy0l41q+2r76uTwBzr3MWreHkAxryAQ1EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzKiPiw8li/qELJXn9NUqiMsbF3GR7SBM/Soz+qqmND5Nq8FwTFYHtGOtQBSvIXnWwzRn0AadsckOxWaIvTOGsOM9s9uFtzdx6h5ZlBiuT0P6GOHpsQJh5OYDidKflh6PJkH4kxeLCF9rSDbs3gphcM2DFxN2u8CsTEKycVUU3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/o9VH2T; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-479eb8bcacbso3653097b6e.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 14:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779310984; cv=none;
        d=google.com; s=arc-20240605;
        b=URI4H9AEjn9IjOSnmswipUT0ltRUR8bbPv3VAo9n3Q1bn+gdclBMQRxUooTuzMBHoT
         eb+EUzHzt8DJHm28TjAxoQhUfMhJ8zxMwIL/AQkDz3mtwwAxuGkxCuFP0Qtqq6KoTZI8
         722b9jiixXOdowd4nIb0fOA0baz1BzMMLSNY/1q5uvBxo7qV6ZdDQxmQBW+61Kj4p9tG
         5CYfQcBGslpr4rIXXeI7bav2ayIv+6TfJ24Cy+np/ItCX0+p20yV3Hg0ntPExQlhUTbE
         lt+Xe9EhS4qN4tq0T7spf/7nkhv1mEhMXCHxwcftyxv8JOwWdNsPZMcZQXgTvxCCO9a8
         YM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IQTvCYBr9Cz3MOTTexPKRQiIGmQvkY0YRAS3I+gG8tY=;
        fh=J7zzloLGdxvuBbfD/TokwO157t5KLvJl9fSpM2U1BOg=;
        b=jy/sb+S/Z8fBWJFHXZB5bYWuJ1co4kJqT9YKQtFU1U/NcN/lxCOoAANRRw10OfrhAb
         S/6+4Z/kr8X0r56JJ4f812x10QX/XzsgYgiA81/qaOiyIrkm54Gc2tzlzQdv9fulw7Ae
         P8uLXLIkbkOElJTyLF8Iz6e7HXBOcA/BtrHIGTU9nzJ3ysTiOCYrJqWQedpH44hhWyhD
         S7rASkdnrLRILhbTXrGvb1k0U/jDvwWB0ynwdCpfbf4TfG9MgnSvQfSK9vGyfYnoGZkC
         dOGjDl+PHgoZHDLTZq0PoQR2zRKlokwy/eVT8Sej/nHLBZ2bZiB6JIKTV7ZnqHDRvHBZ
         1y1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779310984; x=1779915784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQTvCYBr9Cz3MOTTexPKRQiIGmQvkY0YRAS3I+gG8tY=;
        b=K/o9VH2TA0MvmoLnPyUM3aHNcLeqAPIIdTw2EVF7pSxtOFMg2UmyKi1rY4pEtDSL1Z
         oGzuosXbdery23p6PqLO8eFAwVGZyjO+ajnTvcvC3dTfHfMnb+bV7STJRBzB7muJpPLy
         8vKD/V1IXPjBCmTIqP1C5PmfaR8G8zDKeIxECdjrARA2TSpK+nXu9HmFDpliK+ms8uPG
         p1Vd6hKEn/RXTpYJPHED1Xegk6IN1Kemv8QL5VoJ+yLxdDEV9q4BH41ffQf5ntK1+RwJ
         bqfQJr4d0IBGc5nC1AJIK6M5lwI7a8apl/ndiNiqjwWS4JmecEEF9TvsQomqd1ck646R
         QD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310984; x=1779915784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQTvCYBr9Cz3MOTTexPKRQiIGmQvkY0YRAS3I+gG8tY=;
        b=DapKGinDqYGMkIMeVlZtwbApxv7B/e1u3Al1dFaRdjD3YCb94vZQWTekWBiTXhh7xG
         7orh0rWrAvcvhHHqQl19sDYmfwM2NIrHBWuJL9h198y/S0Tf8vJvuSQ0UehhE90zZFJK
         J0BzmuFbnl4BiFjf/4aPYdqd9vRmzPEXk5EYEwvJSWncKabhP5kQ7ozyLayoTZsAb10B
         STZzZfvgvXcSwHvGpwbPQ8QFXhFAPTXMKxWoxG2VpwRqujexR4k58P10fT1TJzaAkIOp
         stX5cgXCsgjxQVh5bHrU5kZ4RMWGFnoGoRtOjQGIzf1ybPRd+ooiGhV3ZPRZYWtNjyQZ
         EcuQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Nd/NeU+XTUSH/w2+vZvNarKUggW78jrIBQ07rgnjGdHQ2qYrTecuMfJIsOVWJw0zvxWSBx6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGskh+9Dd5xgblCwSCbsXySf3+S5JPEWtVu7PU5ZOtCGX1WI3O
	v+KF4KNosVGJlOZof5FKUd9ERf3IpYgl5vB1it62DfCHI60vxeeQVyItdlJ1TIPF6EcN1tDNb6E
	VGZcFHhDYWqhxEctcFfdqHlIg/cwZ55Q=
X-Gm-Gg: Acq92OFQa81MxPeGy11ru1Ry8MWzx7zUIt9VGIAxLPMDr6Ae8K+6MzsirszI4lO63SD
	h05vTUyJxuWpHviQszkSc4jS79HJ8QXV7+URioQS3FP3Hx6i4JL/oEslkYGeFE1VQccMYRDH0r1
	N6g4/kWay02MbI3u2yA1WMc3XTa/E3/YTX8J359D2/i6O5e/xFzo0bB/A2VN5XDoWfXOJrqRsM2
	2YLUgNuPjVLSC11sKMFXNa+jJGczSMN8M3ao3ehEOSDJVVzPC/aqfZBO6oG1ISHePvPe+CjqEA1
	CNfZ4Q5aECsSNOrMbnv94Llr/oABoITT0ImbVw==
X-Received: by 2002:a05:6808:2382:b0:467:1458:2a8f with SMTP id
 5614622812f47-482e592d399mr16600671b6e.37.1779310984145; Wed, 20 May 2026
 14:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519203530.66310-1-devnexen@gmail.com> <CAHS8izOL4yyPH4+ZUXxKB6JAj0EgbFK5UkG+SSb4rk_vG6EfhQ@mail.gmail.com>
 <CA+XhMqxPNEBVey8xw_yisymwL2H_04hL48GOyPk08U8p0tYM2g@mail.gmail.com> <CAHS8izMTxrywNPEeYsuyeJ9ETfdwt0qYdHFh5=v8pohboT86AQ@mail.gmail.com>
In-Reply-To: <CAHS8izMTxrywNPEeYsuyeJ9ETfdwt0qYdHFh5=v8pohboT86AQ@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 20 May 2026 22:02:53 +0100
X-Gm-Features: AVHnY4Jpi7LniJLzlTb__HITTRBbXOaJ145PrJMHGg4oFhdjOskSHMzBvOrZi18
Message-ID: <CA+XhMqx0F5Ujfo2BrgmjzYG030rsu271nppL4DPLEetfMcr-0g@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253386-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 83B6E59C94E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 at 21:42, Mina Almasry <almasrymina@google.com> wrote:
>
> On Wed, May 20, 2026 at 12:28=E2=80=AFPM David CARLIER <devnexen@gmail.co=
m> wrote:
> >
> > On Wed, 20 May 2026 at 19:55, Mina Almasry <almasrymina@google.com> wro=
te:
> > >
> > > On Tue, May 19, 2026 at 1:35=E2=80=AFPM David Carlier <devnexen@gmail=
.com> wrote:
> > > >
> > > > net_devmem_bind_dmabuf() trusts dmabuf->size and sg_dma_len() to be
> > > > PAGE_SIZE multiples without checking:
> > > >
> > > >   - tx_vec is sized dmabuf->size / PAGE_SIZE, and
> > > >     net_devmem_get_niov_at() only bounds-checks virt_addr < dmabuf-=
>size
> > > >     before indexing tx_vec[virt_addr / PAGE_SIZE]. With size =3D
> > > >     N*PAGE_SIZE + r (1 <=3D r < PAGE_SIZE), sendmsg() at iov_base =
=3D
> > > >     N*PAGE_SIZE passes the bound check and reads tx_vec[N] -- one p=
ast.
> > > >
> > > >   - owner->area.num_niovs =3D len / PAGE_SIZE while gen_pool_add_ow=
ner()
> > > >     covers the full byte len, so a non-page-multiple non-final sg
> > > >     desyncs num_niovs from the gen_pool region for every later sg, =
on
> > > >     both RX and TX.
> > > >
> > > > dma-buf does not require page-aligned sizes, so the bind path has t=
o
> > > > enforce what its own indexing assumes. Reject both with -EINVAL.
> > > >
> > > > The size check is TX-only (only tx_vec is sized off dmabuf->size); =
the
> > > > SG-length check covers both directions.
> > > >
> > > > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: David Carlier <devnexen@gmail.com>
> > > > ---
> > > > Changes in v2:
> > > >   - Reframe commit message around the kernel-side OOB instead of
> > > >     "real exporters already page-align", which read as the OOB bein=
g
> > > >     unreachable and undercut Cc: stable (Stanislav Fomichev).
> > > >   - Hoist the SG-length check out of the if (TX) branch so it cover=
s
> > > >     RX too; RX has the same num_niovs / gen_pool desync on a
> > > >     contract-violating exporter, just without an OOB. Keep the
> > > >     size-multiple check TX-only (Stanislav Fomichev).
> > > >   - Drop bool todevice; compare direction =3D=3D DMA_TO_DEVICE inli=
ne to
> > > >     match the existing call site at the tx_vec[] assignment
> > > >     (Bobby Eshleman).
> > > >
> > > >  net/core/devmem.c | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >
> > > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > > index 468344739db2..4f71de44c0fb 100644
> > > > --- a/net/core/devmem.c
> > > > +++ b/net/core/devmem.c
> > > > @@ -241,6 +241,11 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> > > >         }
> > > >
> > > >         if (direction =3D=3D DMA_TO_DEVICE) {
> > > > +               if (!IS_ALIGNED(dmabuf->size, PAGE_SIZE)) {
> > > > +                       err =3D -EINVAL;
> > > > +                       NL_SET_ERR_MSG(extack, "TX dma-buf size mus=
t be a multiple of PAGE_SIZE");
> > > > +                       goto err_unmap;
> > > > +               }
> > > >                 binding->tx_vec =3D kvmalloc_objs(struct net_iov *,
> > > >                                                 dmabuf->size / PAGE=
_SIZE);
> > > >                 if (!binding->tx_vec) {
> > > > @@ -267,6 +272,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> > > >                 size_t len =3D sg_dma_len(sg);
> > > >                 struct net_iov *niov;
> > > >
> > > > +               if (!IS_ALIGNED(len, PAGE_SIZE)) {
> > > > +                       err =3D -EINVAL;
> > > > +                       NL_SET_ERR_MSG(extack, "dma-buf SG length m=
ust be PAGE_SIZE aligned");
> > > > +                       goto err_free_chunks;
> > > > +               }
> > > > +
> > > >                 owner =3D kzalloc_node(sizeof(*owner), GFP_KERNEL,
> > > >                                      dev_to_node(&dev->dev));
> > > >                 if (!owner) {
> > > > --
> > > > 2.53.0
> > > >
> > >
> > > No hold on, I don't think we actually have a bug here. AFAIR all
> > > you're describing is intionional . Yes the TX vectors and their niov
> > > arrays do implicitly 'pad' the dmabuf size to PAGE_SIZE.
> > >
> > > But net_devmem_get_niov_at has this check that prevents us from tryin=
g
> > > to send past the dma-buf size, even if it's not page_aligned:
> > >
> > > ```
> > > if (virt_addr >=3D binding->dmabuf->size)
> > > return NULL;
> > > ```
> > >
> > > IIRC the NULL should be bubbled up to the user as some error.
> > >
> > > Please double check that we actually have a bug here. If not, please
> > > don't merge this. This change could break existing users using devmem
> > > TX correctly with non-PAGE_SIZE aligned dmabufs, which is a valid use
> > > case.
> > >
> > > And if we have a bug, lets fix it in some way that doesn't deprecate
> > > support for non page-aligned TX dmabufs. You may be breaking users
> > > here.
> > >
> > > --
> > > Thanks,
> > > Mina
> >
> > Hi, Mina, note that the guard you're quoting doesn't cover the case
> > I'm describing. It's in bytes against dmabuf->size, while tx_vec is
> > sized dmabuf->size / PAGE_SIZE
> >   (truncating) -- there's a sub-page window where the check passes and
> > the index doesn't.
> >
> >   Concretely, PAGE_SIZE =3D 4096 and dmabuf->size =3D 4097:
> >
> >   tx_vec allocated for 4097 / 4096 =3D 1 entry (valid index 0).
> >   sendmsg with iov_base =3D 4096:
> >     virt_addr >=3D dmabuf->size   ->  4096 >=3D 4097, passes.
> >     tx_vec[virt_addr / PAGE_SIZE] -> tx_vec[1], OOB by one.
> >
> >   And the OOB pointer isn't just returned to the caller -- it flows
> > through get_netmem() -> __get_netmem(), which dereferences it
> > (net_is_devmem_iov() reads ->type) and
> >    on a matching byte refcounts the binding off of it. So this is a
> > controlled OOB deref, not just a stray read.
> >
>
> Ah, I see. I think that is indeed the bug. In the case PAGE_SIZE=3D4096
> and dmabuf->size is 4097, the intention in the code was to have tx_vec
> be an array of 2, where tx_vec[0] is [1->4096] and tx_vec[1] is
> [4097]. I have an off-by-one error in the tx_vec allocation :(
>
> tx_vec[1] would contain an niov and as is stands we assume nvios are
> PAGE_SIZE, but IIRC net_devmem_get_niov_at() would make sure that the
> callers trying to use tx_vec[1] would only use it for a range that's
> valid, so using [4097] and not a range like [4097->8192].
>
> However when I dug deeper on proper pruning of page alignment
> assumptions in net_devmem_bind_dmabuf, the problems are deeper than
> this patch suggests. We don't properly handle the (probably
> non-existent?) edge case where the dma-buf itself is page aligned but
> for_each_sgtable_dma_sg itself gives us un-page_aligned sg entries :(
>
> I think probably all of this is very theoretical. In practice probably
> the dmabuf implementations in the wild seem to be page-aligned.
> udmabuf doesn't support non-page-aligned dmabufs even so we can't add
> tests for these things. So I guess fine, lets merge this.
>
> >   On breaking users: the partial-page tail was never TX-usable to
> > begin with. The fill loop only populates num_niovs =3D len / PAGE_SIZE
> > entries while
> >   gen_pool_add_owner() covers the full byte len, so any sendmsg into
> > [num_niovs*PAGE_SIZE, dmabuf->size) was already heading for either
> > NULL or this OOB. It's not
> >   deprecating a working configuration -- it's rejecting one that wasn't=
 working.
> >
>
> Yes, but still, today binding a non-PAGE_SIZE TX dmabuf but only using
> actually sendmsging up to the last PAGE_SIZE boundary is working,
> andthat would break entirely. I guess lets merge this and on the
> offchance someone is hitting this edge case we can revisit.
>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
>
> I don't know if you're interested in also fixing the edge case where
> the sg table entries themselves are not not page-aligned. I think that
> also doesn't work properly?
>
> --
> Thanks,
> Mina

Thanks Mina, appreciate the review.

  On the SG side -- the second hunk in this patch already rejects any
SG with !IS_ALIGNED(sg_dma_len(sg), PAGE_SIZE) at bind time, so the
num_niovs vs
  gen_pool_add_owner(len) desync I described in the changelog is
covered for both RX and TX.

  What's not checked is the sg_dma_address() alignment itself -- an SG
with a page-multiple length but a sub-page start offset would still
slip through and produce
  niovs whose dma addresses straddle pages. Like you said, it's
theoretical (in-tree exporters and udmabuf all hand back page-aligned
addresses), but happy to send a
  follow-up as a separate fix if you'd like.

Cheers.

