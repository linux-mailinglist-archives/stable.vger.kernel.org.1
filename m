Return-Path: <stable+bounces-253383-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HYyFuccDmro6AUAu9opvQ
	(envelope-from <stable+bounces-253383-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:43:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF95459A003
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 421FF3074026
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB73372EF1;
	Wed, 20 May 2026 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hyRC9W/x"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DE43630BE
	for <stable@vger.kernel.org>; Wed, 20 May 2026 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779309769; cv=pass; b=cEF++koAS+sYa8OIE0YYPmOl2r7WJNBCCTzkdw7P5iIR5uzBXGaqvOsWRTCYIcc4kfxvBM1QbtRNMhRaycx3ME37q9DdA0E/YDxcCZJ1QAEtSjaqsXR7PUuIC4pQMWBGIZyLPmwCQNEZM2Gx06htdlq0upcC3Df6HuAPs5F1CvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779309769; c=relaxed/simple;
	bh=swoniN8dKbxjmhX+Uk6nTtqqeMOaDJuOsCzcMmvbw1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hF/or02dNNNTgRNH7iaXlfmjK47mTLR7AqfEVv7huaFO8XH+VxYEYvtPKo8a7PkO+jahHAVg4piwbh4R4Tbdl/O5SXe/FtJDoLanw7JHQRoUKkhUi1JUcSRbgybi28wuZesJp6mPrCIIb0octt3xH6k4umvWUWVnJZ+Xgy696Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hyRC9W/x; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-133362c30cfso28c88.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 13:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779309766; cv=none;
        d=google.com; s=arc-20240605;
        b=bjJNNkVIKJCIGxdwAn/5OG3yeD/GAxqC7qTPiFOi9MhCI5RtTqKgHs6K9d7n2tS+Oh
         phtVGxuYGNC3W27uyLXKrmKeedU3LwxJ9EfR2FB4wWtB61aZnHu2Bt5zdOwNb1jcpsCi
         tmO3DS8IQ3k1ANEjediuFBdnhk5unWA5MxWllGvuD1wpNeSrw/RcILd21x2DRFDD0KiP
         TxCw6QOo3vuDUqXU3KnLNqwrunZOYHndUNJlLwmrENWg/Tik2z4qu3XomFHgePitdHsc
         MXV39p9nB0aHkz2nFr8L4yIFzyURsacDrlNZGYfngivwLl0a3XVgtUtXDKZYyD1nJp2m
         cwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vcExwVYkUpCIudziU/6/ngXHhFQ/KYbIMq9N2HBF1YI=;
        fh=4+UiCreEPTgY0mNB4YB6M1jHmOMX+vxPvL60DOTooBQ=;
        b=WzNZZ2BE7PlkCZK6tZSJqHxX+emNx7aFdndy9Qk4E7VIPT3+83FmPT2KasAuUjHUWt
         k12QSgpAGuRJPCkf+hoMYdEI9f44rzVKDFAY6zbIgIbFqpwGCIbuXUHLM/Vl58vHFaXD
         sG46bN4UczBJGFeheZ78VW5q2p8sJWgwM9meIHSAYgw1LX8/OcNhXXbdWqjzmNDHhhLW
         Ndj6DyxsMdW7ytV4yuyL3++Lc+IhbeWo8l/P+KWJ61oX8QGX+JX9reBY0YLtvPpTbJzP
         gL5wO5jAccHr+zdDvLidBB8sl6yekn8OpXRsswAtuPReCbx25zf+hWDGNfFE9FpmIc2Q
         +Nbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779309766; x=1779914566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcExwVYkUpCIudziU/6/ngXHhFQ/KYbIMq9N2HBF1YI=;
        b=hyRC9W/x/40Epk8d6ZrXyLem/qA+ZN9MJCA8UCBodEADRwAwaG06o/sWyYJ8w+S1J7
         o10WCZAMsFlBLXyTdgnVRq3s/Ke6tPYA4kvR6bPzGC3sIQRydCKmLIkIBj3IU3rWRTj+
         2CNsNauJDn/+CDAuE7UCVfxJnOFNxpY5p+EKl8S8omlSOrIQ6bzLfxd/YwjO9VBgTIFy
         ZHN5/NZ8W9nkocXKEd1gIZSiFmd/Nfs6jFHdT4N4YFpp2c+sbaommHE0R0jWXxIueIwQ
         +gDi8pZgqQNwPgA1IgN8ZG2DbLNNIdzY0UuZJGWBIk7/B54MV4hZRow6F8kVtATPcOj4
         KZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779309766; x=1779914566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vcExwVYkUpCIudziU/6/ngXHhFQ/KYbIMq9N2HBF1YI=;
        b=qWWnznXO8stONuEwXVZqw/pfuffHlb2h1zcBu8cSYfdK+n/BoXcgZbyJzXzn3Y6rJX
         2DcDIp3yHLjC4I53tUpK8fgtq55/m2KaFmPSZqUoBaRFTVcmjTuQjXw9my+cIIYeblDQ
         jyWrNA1BNbFyqLSyqAA3dCKUvZNBi/hJuSqADbiYhqldu6HW2IFff22BiGxhRYBU03tr
         p0pJxr4KWT3AfsBNiig5r4Wqzl/DVFLvBcU/l3G/ql4J1aHnICWjoKtyaQdjq45B9+al
         6+64nnK6ccjoXPT7etU1GQ+wNooN/MedJX/Q+7GQ3xP3/umBARj8D63O7Pl8u7GjYhWc
         ReIA==
X-Forwarded-Encrypted: i=1; AFNElJ/TaSy1lF1oQHuwMwGJBQS8vX7PTu1Jst7wuIp5z9DnkMP2Y9YZbYnL/ZHq6d2phlbyTQaqJk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYmvVq8pgF37azaSAADTEw+BDz5GVt4ssC4nn/L/UC/0xXcKDW
	4FUiiYK3b0YPbkmkleS0cms1EcrLfLwIYUWONtiQVPFMKn85ex19TLdFZJo2I4vttKbW3TS9j9t
	NTPDx4AqR4rLFcLYR9dgcNGFTf7lMX4l/QnjkI8TR
X-Gm-Gg: Acq92OEv3Yz0lotxrDVLOGviNYJV0pynCJTtcTBkwrCznFJOXUdXUlMMG7xTs6lraBG
	azTflIVRm/khig/zb3Smi6QeYyGdfP+p6pMs7Cw999IvShBFalTOfzQe7/S/56mGVTsamDaTpCN
	iL5I0K36LsOhGdiCtmuMt9UKC4z7Y8cpYFEnS0sD30aLhzHN3KK8nu1P2OQ0AKCfIrUDaMajGvQ
	3UD1ad+Acxl0wV4nWPXAMPv8vVDDOMPzbehfP8yMGZhOxz9vsK4g0Lf9cIdvbANiVdcHNWMT5/+
	bfFDWk59Y2Zghgtm4xRXq4UU8SuAk9A0ejcvn7KqZXUOpFK/VGEf
X-Received: by 2002:a05:7022:108:b0:11a:b4dc:7773 with SMTP id
 a92af1059eb24-1363394eabfmr4014c88.12.1779309765824; Wed, 20 May 2026
 13:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519203530.66310-1-devnexen@gmail.com> <CAHS8izOL4yyPH4+ZUXxKB6JAj0EgbFK5UkG+SSb4rk_vG6EfhQ@mail.gmail.com>
 <CA+XhMqxPNEBVey8xw_yisymwL2H_04hL48GOyPk08U8p0tYM2g@mail.gmail.com>
In-Reply-To: <CA+XhMqxPNEBVey8xw_yisymwL2H_04hL48GOyPk08U8p0tYM2g@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 20 May 2026 13:42:32 -0700
X-Gm-Features: AVHnY4ICiwqE7hbYCr0VxH30HD8L8io-G094d2MA_FbIMSMclBaeXhhNRblCHYc
Message-ID: <CAHS8izMTxrywNPEeYsuyeJ9ETfdwt0qYdHFh5=v8pohboT86AQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: devmem: reject dma-buf bind with
 non-page-aligned size or SG length
To: David CARLIER <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	sdf@fomichev.me, sdf.kernel@gmail.com, kaiyuanz@google.com, 
	bobbyeshleman@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-253383-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almasrymina@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,gmail.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DF95459A003
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 12:28=E2=80=AFPM David CARLIER <devnexen@gmail.com>=
 wrote:
>
> On Wed, 20 May 2026 at 19:55, Mina Almasry <almasrymina@google.com> wrote=
:
> >
> > On Tue, May 19, 2026 at 1:35=E2=80=AFPM David Carlier <devnexen@gmail.c=
om> wrote:
> > >
> > > net_devmem_bind_dmabuf() trusts dmabuf->size and sg_dma_len() to be
> > > PAGE_SIZE multiples without checking:
> > >
> > >   - tx_vec is sized dmabuf->size / PAGE_SIZE, and
> > >     net_devmem_get_niov_at() only bounds-checks virt_addr < dmabuf->s=
ize
> > >     before indexing tx_vec[virt_addr / PAGE_SIZE]. With size =3D
> > >     N*PAGE_SIZE + r (1 <=3D r < PAGE_SIZE), sendmsg() at iov_base =3D
> > >     N*PAGE_SIZE passes the bound check and reads tx_vec[N] -- one pas=
t.
> > >
> > >   - owner->area.num_niovs =3D len / PAGE_SIZE while gen_pool_add_owne=
r()
> > >     covers the full byte len, so a non-page-multiple non-final sg
> > >     desyncs num_niovs from the gen_pool region for every later sg, on
> > >     both RX and TX.
> > >
> > > dma-buf does not require page-aligned sizes, so the bind path has to
> > > enforce what its own indexing assumes. Reject both with -EINVAL.
> > >
> > > The size check is TX-only (only tx_vec is sized off dmabuf->size); th=
e
> > > SG-length check covers both directions.
> > >
> > > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: David Carlier <devnexen@gmail.com>
> > > ---
> > > Changes in v2:
> > >   - Reframe commit message around the kernel-side OOB instead of
> > >     "real exporters already page-align", which read as the OOB being
> > >     unreachable and undercut Cc: stable (Stanislav Fomichev).
> > >   - Hoist the SG-length check out of the if (TX) branch so it covers
> > >     RX too; RX has the same num_niovs / gen_pool desync on a
> > >     contract-violating exporter, just without an OOB. Keep the
> > >     size-multiple check TX-only (Stanislav Fomichev).
> > >   - Drop bool todevice; compare direction =3D=3D DMA_TO_DEVICE inline=
 to
> > >     match the existing call site at the tx_vec[] assignment
> > >     (Bobby Eshleman).
> > >
> > >  net/core/devmem.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > index 468344739db2..4f71de44c0fb 100644
> > > --- a/net/core/devmem.c
> > > +++ b/net/core/devmem.c
> > > @@ -241,6 +241,11 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> > >         }
> > >
> > >         if (direction =3D=3D DMA_TO_DEVICE) {
> > > +               if (!IS_ALIGNED(dmabuf->size, PAGE_SIZE)) {
> > > +                       err =3D -EINVAL;
> > > +                       NL_SET_ERR_MSG(extack, "TX dma-buf size must =
be a multiple of PAGE_SIZE");
> > > +                       goto err_unmap;
> > > +               }
> > >                 binding->tx_vec =3D kvmalloc_objs(struct net_iov *,
> > >                                                 dmabuf->size / PAGE_S=
IZE);
> > >                 if (!binding->tx_vec) {
> > > @@ -267,6 +272,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> > >                 size_t len =3D sg_dma_len(sg);
> > >                 struct net_iov *niov;
> > >
> > > +               if (!IS_ALIGNED(len, PAGE_SIZE)) {
> > > +                       err =3D -EINVAL;
> > > +                       NL_SET_ERR_MSG(extack, "dma-buf SG length mus=
t be PAGE_SIZE aligned");
> > > +                       goto err_free_chunks;
> > > +               }
> > > +
> > >                 owner =3D kzalloc_node(sizeof(*owner), GFP_KERNEL,
> > >                                      dev_to_node(&dev->dev));
> > >                 if (!owner) {
> > > --
> > > 2.53.0
> > >
> >
> > No hold on, I don't think we actually have a bug here. AFAIR all
> > you're describing is intionional . Yes the TX vectors and their niov
> > arrays do implicitly 'pad' the dmabuf size to PAGE_SIZE.
> >
> > But net_devmem_get_niov_at has this check that prevents us from trying
> > to send past the dma-buf size, even if it's not page_aligned:
> >
> > ```
> > if (virt_addr >=3D binding->dmabuf->size)
> > return NULL;
> > ```
> >
> > IIRC the NULL should be bubbled up to the user as some error.
> >
> > Please double check that we actually have a bug here. If not, please
> > don't merge this. This change could break existing users using devmem
> > TX correctly with non-PAGE_SIZE aligned dmabufs, which is a valid use
> > case.
> >
> > And if we have a bug, lets fix it in some way that doesn't deprecate
> > support for non page-aligned TX dmabufs. You may be breaking users
> > here.
> >
> > --
> > Thanks,
> > Mina
>
> Hi, Mina, note that the guard you're quoting doesn't cover the case
> I'm describing. It's in bytes against dmabuf->size, while tx_vec is
> sized dmabuf->size / PAGE_SIZE
>   (truncating) -- there's a sub-page window where the check passes and
> the index doesn't.
>
>   Concretely, PAGE_SIZE =3D 4096 and dmabuf->size =3D 4097:
>
>   tx_vec allocated for 4097 / 4096 =3D 1 entry (valid index 0).
>   sendmsg with iov_base =3D 4096:
>     virt_addr >=3D dmabuf->size   ->  4096 >=3D 4097, passes.
>     tx_vec[virt_addr / PAGE_SIZE] -> tx_vec[1], OOB by one.
>
>   And the OOB pointer isn't just returned to the caller -- it flows
> through get_netmem() -> __get_netmem(), which dereferences it
> (net_is_devmem_iov() reads ->type) and
>    on a matching byte refcounts the binding off of it. So this is a
> controlled OOB deref, not just a stray read.
>

Ah, I see. I think that is indeed the bug. In the case PAGE_SIZE=3D4096
and dmabuf->size is 4097, the intention in the code was to have tx_vec
be an array of 2, where tx_vec[0] is [1->4096] and tx_vec[1] is
[4097]. I have an off-by-one error in the tx_vec allocation :(

tx_vec[1] would contain an niov and as is stands we assume nvios are
PAGE_SIZE, but IIRC net_devmem_get_niov_at() would make sure that the
callers trying to use tx_vec[1] would only use it for a range that's
valid, so using [4097] and not a range like [4097->8192].

However when I dug deeper on proper pruning of page alignment
assumptions in net_devmem_bind_dmabuf, the problems are deeper than
this patch suggests. We don't properly handle the (probably
non-existent?) edge case where the dma-buf itself is page aligned but
for_each_sgtable_dma_sg itself gives us un-page_aligned sg entries :(

I think probably all of this is very theoretical. In practice probably
the dmabuf implementations in the wild seem to be page-aligned.
udmabuf doesn't support non-page-aligned dmabufs even so we can't add
tests for these things. So I guess fine, lets merge this.

>   On breaking users: the partial-page tail was never TX-usable to
> begin with. The fill loop only populates num_niovs =3D len / PAGE_SIZE
> entries while
>   gen_pool_add_owner() covers the full byte len, so any sendmsg into
> [num_niovs*PAGE_SIZE, dmabuf->size) was already heading for either
> NULL or this OOB. It's not
>   deprecating a working configuration -- it's rejecting one that wasn't w=
orking.
>

Yes, but still, today binding a non-PAGE_SIZE TX dmabuf but only using
actually sendmsging up to the last PAGE_SIZE boundary is working,
andthat would break entirely. I guess lets merge this and on the
offchance someone is hitting this edge case we can revisit.

Reviewed-by: Mina Almasry <almasrymina@google.com>

I don't know if you're interested in also fixing the edge case where
the sg table entries themselves are not not page-aligned. I think that
also doesn't work properly?

--
Thanks,
Mina

