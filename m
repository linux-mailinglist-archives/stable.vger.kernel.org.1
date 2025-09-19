Return-Path: <stable+bounces-180607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD83DB88265
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 09:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290191B22BCC
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 07:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EB22D0622;
	Fri, 19 Sep 2025 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BndJCpmo"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EA729ACEE
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758266749; cv=none; b=jizB3A8w1tUmxdRs7/8R44qpVscPnJhMdU7SDTyYU1OjcWIT6SwFe5YCY8iLGW/Vyd9lH3i9TWaz2HBdTiqp6aUnpOHOcZqnEoOKB2bbMgptVDgVEcHsI+NqO1fBgBczR3pEHTrwYm8slh6kbz03bJhjblw4dASVK2zGusTWEr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758266749; c=relaxed/simple;
	bh=zkVkIoUOl03T+4kpYux31FAUF2pWUEphOE/XLbf//wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aus6Fw7MrRfX6NwplkLn0HUsZUhyC20kcyt51C3+cZjXNvk2WJtCRhmFj+H/mqOHR47rDhtD76Y11bsWCkII3Wmdb7wlb22zVbierBhmvVVFmLQxQPqGsPYyJxQIWM3dHEAQNuQ+Ga9MGUix31gyJoqztk4oY4U+3YOI2IRuB/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BndJCpmo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758266746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bM94/nnEI8nwvokemjQlvg6Nu4kwWN6AkIyeAjLPwg=;
	b=BndJCpmoPPgpoR+6GPANMMa7ToA62ceAOjwTVpvYH71/zbm8pwqeITEa0Q7DZBKHDMSWa2
	aYX2rd7+brovy4ZQDbKOm3Rh9mR3/a+0AaeiIZ1OGCYjLTSYFFFX/RB+L4bZXs4dnRyCHr
	fWkqI1IiyCGxMm+1qH37MzzQtjxF90E=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-dC39c_xjMs-NJw5otC5ANA-1; Fri, 19 Sep 2025 03:25:45 -0400
X-MC-Unique: dC39c_xjMs-NJw5otC5ANA-1
X-Mimecast-MFC-AGG-ID: dC39c_xjMs-NJw5otC5ANA_1758266744
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ee4998c4aso1769187a91.1
        for <stable@vger.kernel.org>; Fri, 19 Sep 2025 00:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758266744; x=1758871544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bM94/nnEI8nwvokemjQlvg6Nu4kwWN6AkIyeAjLPwg=;
        b=HLOpcebKMnB8RTrm4FKqDsOUV13+tOsa5KrF5DVs7+M60Mgt6rWP9wItUOnZCnaoKg
         sRZK237JF2zhN9TpXtE+Fq2JLoW+N+sy7DAJkXmT9pjR2rsg+02CKwTbqx5Gk7MHjrgi
         N9rIjV4u906rZmPzWE9L1KJCoe0zVDXBEJOk6P7Fc/pk5JY4oQ8OvmEsn1MDr67YiKN7
         KdUqhoup7ulW2lFigX8Ez0FUvphYvE4REQzXPGjezF9lOLxvDc56fiC0FEBC8Y2pYWAn
         IeAyXnSkSYS2y888YJpdRDT2Ts60K/bLMa+R6Aftf5wyiMSfvZAa8zolbS7bZXmRt0P2
         mEiA==
X-Forwarded-Encrypted: i=1; AJvYcCU3kl7qP2XVNV7OAxpmRb3EFTRsxb1IIkybi4pOGLitTdoqbnZdIUaVgC3fr6YSoQhjfsfPEFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSrZlaLxp5MwRknyK8rhVVtfOECsjY+EsRfjngafCzZpyv+lao
	FYYQR5O2nJXIur9bx3oEB3fwJTgTb5BNUP9vfFL6vnX7BPoMW9qkLs/zz7yeyJ4lRxgKny++vlF
	AYVKxWp5fEb0+ghkSwQCKrXrV7MoplZnLDVfRPTV8SnolCR5rKOo5OiOUHFqHqOQUs0BeIMbZUQ
	5lv0kWdwqjL4RYC+J+MISuLCVEDG9fO1VV
X-Gm-Gg: ASbGncsuDagjaf3poaVUToshhq3wTGSXcN2P2zhwcA6AaQcgh+gcK58CyGWBw13jDMM
	204td16fNT9PU3E1LQGVzehfnLJBBteHKCDdVxM8JGhd7OZ+oQcU3CeTvhDp8CXwTQv3q6Ym7ad
	6GpVs0Lwr/3ShWfcfWeM7Hjw==
X-Received: by 2002:a17:90b:4d:b0:321:9366:5865 with SMTP id 98e67ed59e1d1-3309838e07dmr3146558a91.33.1758266744228;
        Fri, 19 Sep 2025 00:25:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHioX/aUb/kf3X7YbtUfx1ZTiAhYMo4GyJt6XgUNBRLxjMQjBMLN0ziU1pYTAvo5cwkJNciXxXsSL6B3HEhWEE=
X-Received: by 2002:a17:90b:4d:b0:321:9366:5865 with SMTP id
 98e67ed59e1d1-3309838e07dmr3146523a91.33.1758266743790; Fri, 19 Sep 2025
 00:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917063045.2042-1-jasowang@redhat.com> <20250918105037-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250918105037-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Sep 2025 15:25:32 +0800
X-Gm-Features: AS18NWCuouHf_lzYXemPvsvzosa6Qbb26dhl00LIb1AvW_Yc0kDUxptSh5xarsQ
Message-ID: <CACGkMEsUb0sXqt8yRwnNfhgmqWKm1nkMNYfgxSgz-5CtE3CSUA@mail.gmail.com>
Subject: Re: [PATCH vhost 1/3] vhost-net: unbreak busy polling
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org, 
	jon@nutanix.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 10:52=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Sep 17, 2025 at 02:30:43PM +0800, Jason Wang wrote:
> > Commit 67a873df0c41 ("vhost: basic in order support") pass the number
> > of used elem to vhost_net_rx_peek_head_len() to make sure it can
> > signal the used correctly before trying to do busy polling. But it
> > forgets to clear the count, this would cause the count run out of sync
> > with handle_rx() and break the busy polling.
> >
> > Fixing this by passing the pointer of the count and clearing it after
> > the signaling the used.
> >
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 67a873df0c41 ("vhost: basic in order support")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> I queued this but no promises this gets into this release - depending
> on whether there is another rc or no. I had the console revert which
> I wanted in this release and don't want it to be held up.
>

I see.

> for the future, I expect either a cover letter explaining
> what unites the patchset, or just separate patches.

Ok.

Thanks

>
> > ---
> >  drivers/vhost/net.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index c6508fe0d5c8..16e39f3ab956 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -1014,7 +1014,7 @@ static int peek_head_len(struct vhost_net_virtque=
ue *rvq, struct sock *sk)
> >  }
> >
> >  static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct so=
ck *sk,
> > -                                   bool *busyloop_intr, unsigned int c=
ount)
> > +                                   bool *busyloop_intr, unsigned int *=
count)
> >  {
> >       struct vhost_net_virtqueue *rnvq =3D &net->vqs[VHOST_NET_VQ_RX];
> >       struct vhost_net_virtqueue *tnvq =3D &net->vqs[VHOST_NET_VQ_TX];
> > @@ -1024,7 +1024,8 @@ static int vhost_net_rx_peek_head_len(struct vhos=
t_net *net, struct sock *sk,
> >
> >       if (!len && rvq->busyloop_timeout) {
> >               /* Flush batched heads first */
> > -             vhost_net_signal_used(rnvq, count);
> > +             vhost_net_signal_used(rnvq, *count);
> > +             *count =3D 0;
> >               /* Both tx vq and rx socket were polled here */
> >               vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
> >
> > @@ -1180,7 +1181,7 @@ static void handle_rx(struct vhost_net *net)
> >
> >       do {
> >               sock_len =3D vhost_net_rx_peek_head_len(net, sock->sk,
> > -                                                   &busyloop_intr, cou=
nt);
> > +                                                   &busyloop_intr, &co=
unt);
> >               if (!sock_len)
> >                       break;
> >               sock_len +=3D sock_hlen;
> > --
> > 2.34.1
>


