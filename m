Return-Path: <stable+bounces-150771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA72CACD0B2
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 02:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1492189271E
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 00:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417F4B665;
	Wed,  4 Jun 2025 00:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/o5wGeB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8886FC3
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 00:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997454; cv=none; b=EfmIgI5qmSkDfe5sQJwpIxutbSrFhCnXpo/VCNp4gYRer7lAEb22LwXBr7b2nhtD7oiwPU3JIazNbjB1z99PXUpKCT4JyTen59smmiCS6w2LHyDiGpmQ3qv4c2MHjlX0F0RLsxEcMX7maGMjbVdfFqXldgENelV+HwId4GygN/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997454; c=relaxed/simple;
	bh=FIhhwRMnEvPjuGUpf9qf+tqZDLEP9lZKLjQ3YYZd4as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHAsLGLSSXofxQ+XYWViEAjgoqpD7xaHGHGevWsPUBMksV/7SkGN5nkrUttys9x7hn/AwTG6j5wRvNEKLdTBFeJ+Jbm3SywXt2MI/ctKUG2oSX/Bzuu5gHzbd7uMvaYTjGXgFOtgx4EBvURFIrlWp2i7lXNZE7Hh06DpsgZ6XSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/o5wGeB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748997451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCJQT/kav5ff3pRxvzcaTAEwPIznqrXjhdq5yD+vQEE=;
	b=Z/o5wGeBme9/4XAfl5w58aOWuOBMRVmqHPSpYxc36VkyY5Ud/lu2TMiAd0tzpoYYH0HuPl
	IGO4weXHrhFKWa2LKl2b57lGfZhg091mdFk5Cv23hHRJRBWx1bqA6FMFkYgS/se8YKX8CX
	Ey7ddhiJpmkPQIcLzJJzdlAmFtgtDmI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-iFhPAftiOx2UMIHBLA6VdQ-1; Tue, 03 Jun 2025 20:37:30 -0400
X-MC-Unique: iFhPAftiOx2UMIHBLA6VdQ-1
X-Mimecast-MFC-AGG-ID: iFhPAftiOx2UMIHBLA6VdQ_1748997449
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-30ea0e890ccso5957433a91.2
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 17:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748997449; x=1749602249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCJQT/kav5ff3pRxvzcaTAEwPIznqrXjhdq5yD+vQEE=;
        b=iPSpqpxdfmkEUb5WlfYsMx+V8QPvpQYXw1K87N4UMACIk9Y6SSdoGozqR1f1+ls9zM
         fhe3J45kEsmsY1Ut+gQG4i+c5vA3XfIa81F/9emc6E/f40r+vhIjnn8KDRUKVgKyfZzg
         PBICEcnGm9bu9cupKf0DvMnJJEw3BtNOS/KvuA6Cef9D+8scyp2RlquBkvMNEJtggPMf
         zjfz7mqwGJ6N5zcwJJVbPf1O8dewrfUEdRfIAwM8w0XF3zn1DFzu7Vl4UzqElizMwoF8
         6G5r4Ml4QL/I0PbRKLfLieuhCl2KRhd7NxKb8C/0n15lwzyaxI1AR7lS7+1ygCja2tb9
         poWA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Rv/Rae8ud8jbm4520imnmRcKmwZ6h9phjE2m84oxkiORQ6k/aUUUwGt+iiDbJRBcrLRQSJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKdk6oA7LqIYt92SfTLUey1dD+nCWURum94oleYSRZ1SjWrQG9
	BOs9ttXXE2O0BI+p1iSsBDGkVEFEIEltXPGlBOzo+9CrmKly9XRZdhLz92eGWxbxbc4ME0qK/Gc
	li24OkhGxsa4RbNQo9uFXW7Wa1FgIEhB/8I1OUFHq2ibFw3pfT5s8HRP18KmNOL/lZQa4Nt4Kf+
	30yenfud/RrPs3j5SKuNC2B0dcxq/Gp3FQ
X-Gm-Gg: ASbGncvxPViIWLBXjvL9uEOJ9vxHUjf2NgbxghSckKUK4/JTJBfVJAZMLIwjtnzvKoT
	0wywb19+a6a1uTzN6wy8yVA+V7EtFJsNfiDiFIitxetkWhvoaBIaoqV3ovCGyjJoEFUq7gA==
X-Received: by 2002:a17:90b:51c4:b0:311:c1ec:7d0c with SMTP id 98e67ed59e1d1-3130cd65aaemr1426531a91.27.1748997449155;
        Tue, 03 Jun 2025 17:37:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQeODWbQfUbRlPw0j1gKXQJysD64GEXXnB2RuYnjq0y+PzQoFeIG5PN3PQdqbkgUndiDNUyG9oiwKSrJbbewE=
X-Received: by 2002:a17:90b:51c4:b0:311:c1ec:7d0c with SMTP id
 98e67ed59e1d1-3130cd65aaemr1426509a91.27.1748997448759; Tue, 03 Jun 2025
 17:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
In-Reply-To: <20250603150613.83802-1-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Jun 2025 08:37:16 +0800
X-Gm-Features: AX0GCFt_tMiNdtyDIBlXvuQJILPten36fjn0u2OKQnhU-6uwjA7mU6t1xM2SrDY
Message-ID: <CACGkMEuHDLJiw=VdX38xqkaS-FJPTAU6+XUNwfGkNZGfp+6tKg@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in zerocopy
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 11:07=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> In virtio-net, we have not yet supported multi-buffer XDP packet in
> zerocopy mode when there is a binding XDP program. However, in that
> case, when receiving multi-buffer XDP packet, we skip the XDP program
> and return XDP_PASS. As a result, the packet is passed to normal network
> stack which is an incorrect behavior. This commit instead returns
> XDP_DROP in that case.
>
> Fixes: 99c861b44eb1 ("virtio_net: xsk: rx: support recv merge mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..4c35324d6e5b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1309,9 +1309,14 @@ static struct sk_buff *virtnet_receive_xsk_merge(s=
truct net_device *dev, struct
>         ret =3D XDP_PASS;

It would be simpler to just assign XDP_DROP here?

Or if you wish to stick to the way, we can simply remove this assignment.

>         rcu_read_lock();
>         prog =3D rcu_dereference(rq->xdp_prog);
> -       /* TODO: support multi buffer. */
> -       if (prog && num_buf =3D=3D 1)
> -               ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, sta=
ts);
> +       if (prog) {
> +               /* TODO: support multi buffer. */
> +               if (num_buf =3D=3D 1)
> +                       ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_x=
mit,
> +                                                 stats);
> +               else
> +                       ret =3D XDP_DROP;
> +       }
>         rcu_read_unlock();
>
>         switch (ret) {
> --
> 2.43.0
>

Thanks


