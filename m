Return-Path: <stable+bounces-108380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20639A0B260
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F6D3A594B
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE47233D93;
	Mon, 13 Jan 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RW/FiS7J"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94875234978
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736759266; cv=none; b=tvyGe0y7ptCUuSrOJCIAr/+rkV4afGBiaUvGzCkIpe/uaiuzWT5JzrL+ZlDm6Heb71cqnhnck9ebyhkR/wk3+4QyxeUZyT3pvZq1vL5KX3hGVTXf8koI12OaW25Hzvr1HsDGYlE/47AIABNNSWrv/cNsWT8BwLh849gvytv+cXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736759266; c=relaxed/simple;
	bh=6yDyyW0a6Ly6O8248teCrbgEXbOE+SVqdnWMzK9oNwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjW8RW6kftK0GeAne6qrpF8Wpagu7wsbDVMdAoHLpzgw/4Z1GYWo0odLwlKSqmAgtIOkxz/aPGqPYGfhyxwPO24UoTJkFxdv3dJ+cwL/tUh7NhmMr8g1DlP/9RTqN3CtDCsFk4uzF3m2jJdGCtkdTgsv0nQF+cFwGkMMlCIud+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RW/FiS7J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736759263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DoCA3mgR5luSoFMglhHAYVKxgoy3EGwdMDnuXoKHBSs=;
	b=RW/FiS7JhOnfjz9issLDEwrlrPppiFOHZzCkLS/ndVcNAHn88PbQZa8UhD8TCJOacLSpW4
	0BhTATgGw93u/JZXTcmfybTnJUqkWyTXG4e9PSQUuvglUtax0fk+jNBRr6jSaT8QXBkPIs
	tUbQBEpOCy8mHbAh0LBhroYJmazB3kg=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-3wmk4NxhNmmUTF54MZ5dog-1; Mon, 13 Jan 2025 04:07:42 -0500
X-MC-Unique: 3wmk4NxhNmmUTF54MZ5dog-1
X-Mimecast-MFC-AGG-ID: 3wmk4NxhNmmUTF54MZ5dog
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e572cd106f7so5384977276.3
        for <stable@vger.kernel.org>; Mon, 13 Jan 2025 01:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736759262; x=1737364062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DoCA3mgR5luSoFMglhHAYVKxgoy3EGwdMDnuXoKHBSs=;
        b=UhDXhbLy/zWZPiyi2wyVLC97jHNWQMUpaSxKCH4K47Xi0zi9IzQoeXJXuezF8p+ZHA
         mxhW4eAzpakRCgkqYcPNKvWpV1HIK5g3QRa6HkuUHBdrUge3TPdY9kt9xLnStn7iU0L2
         Jj1DTo5eGt2QrXjxrZcThVqpu8lAcrjj20PR6CKOHlej9eLpzWVVHpQEBRjVXmN6OiYu
         9K2HQxrfo+7meqQ7E67VZ6foAsBCTiHqFMv3TqA+a1xD+df5dLECIYrvEJ0potoIDpDq
         NVyWSXYO8skRRGFXF14fXQDF2KjvggRxI1fLIH+oP29MZN2doeXGh3VDTsnWIumkeBjs
         CREA==
X-Forwarded-Encrypted: i=1; AJvYcCXY3HqC1HSO6ujfYifqjxuaCjTvQrQZ8EtsMeFuM9d+1DuXfqKDPRf2k/bw5iZoCotv1lguyBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE4pRGIbRTY0JhEmr4DSdySgclmX5YoZUTfcBQrochaTJXTQiN
	8EIldXw+haHXIwsAlgd0C29O88Rs6g4iwAoU3YK6z8rGx9DIaYQYA5lzHFq/UfB1JV2xK7y0eIP
	GpLFu+Uj6E1zU88B2OhZHNXJLlHpyJLVq5o9FVPq4U5qIESKKt7dFmr9JoSYA8iI1UQzDI/RSnB
	qJchRpa9QTWuJQtKlpHb8XyIEbKbYo
X-Gm-Gg: ASbGncsyQf92XBIWa1oaWgnc53CTRR22DVWOpiHBZC63xxUEVUI6MHC/iBN7mMH2FWO
	7SsKD6ptlZmseJ9RoG3rh84t8tlNtlHDMMSkEKQ==
X-Received: by 2002:a25:2104:0:b0:e47:f4e3:87e3 with SMTP id 3f1490d57ef6-e54edf25ca4mr10705873276.11.1736759261777;
        Mon, 13 Jan 2025 01:07:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+CmZ1v9e/WbMUz4yhx1sfIQirqoiE0T/w4GOD49eFf+cvd2Qrlw+zoWAPzA/qokVRzziYFs0iIh6kdpyEqho=
X-Received: by 2002:a25:2104:0:b0:e47:f4e3:87e3 with SMTP id
 3f1490d57ef6-e54edf25ca4mr10705852276.11.1736759261303; Mon, 13 Jan 2025
 01:07:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110083511.30419-1-sgarzare@redhat.com> <20250110083511.30419-2-sgarzare@redhat.com>
 <1aa83abf-6baa-4cf1-a108-66b677bcfd93@rbox.co> <nedvcylhjxrkmkvgugsku2lpdjgjpo5exoke4o6clxcxh64s3i@jkjnvngazr5v>
In-Reply-To: <nedvcylhjxrkmkvgugsku2lpdjgjpo5exoke4o6clxcxh64s3i@jkjnvngazr5v>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 13 Jan 2025 10:07:30 +0100
X-Gm-Features: AbW1kvaVe4-Ehu2H7XpdFvk6JHj69SbGoUvKX4WzH9KRTtiYmUqWFms2gAxG3cY
Message-ID: <CAGxU2F7BoMNi-z=SHsmCV5+99=CxHo4dxFeJnJ5=q9X=CM3QMA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/5] vsock/virtio: discard packets if the transport changes
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luigi Leonardi <leonardi@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Wongi Lee <qwerty@theori.io>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>, Hyunwoo Kim <v4bel@theori.io>, 
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Jan 2025 at 09:57, Stefano Garzarella <sgarzare@redhat.com> wrote:
> On Sun, Jan 12, 2025 at 11:42:30PM +0100, Michal Luczaj wrote:

[...]

> >
> >So, if I get this right:
> >1. vsock_create() (refcnt=1) calls vsock_insert_unbound() (refcnt=2)
> >2. transport->release() calls vsock_remove_bound() without checking if sk
> >   was bound and moved to bound list (refcnt=1)
> >3. vsock_bind() assumes sk is in unbound list and before
> >   __vsock_insert_bound(vsock_bound_sockets()) calls
> >   __vsock_remove_bound() which does:
> >      list_del_init(&vsk->bound_table); // nop
> >      sock_put(&vsk->sk);               // refcnt=0
> >
> >The following fixes things for me. I'm just not certain that's the only
> >place where transport destruction may lead to an unbound socket being
> >removed from the unbound list.
> >
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >index 7f7de6d88096..0fe807c8c052 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -1303,7 +1303,8 @@ void virtio_transport_release(struct vsock_sock *vsk)
> >
> >       if (remove_sock) {
> >               sock_set_flag(sk, SOCK_DONE);
> >-              virtio_transport_remove_sock(vsk);
> >+              if (vsock_addr_bound(&vsk->local_addr))
> >+                      virtio_transport_remove_sock(vsk);
>
> I don't get this fix, virtio_transport_remove_sock() calls
>    vsock_remove_sock()
>      vsock_remove_bound()
>        if (__vsock_in_bound_table(vsk))
>            __vsock_remove_bound(vsk);
>
>
> So, should already avoid this issue, no?

I got it wrong, I see now what are you trying to do, but I don't think
we should skip virtio_transport_remove_sock() entirely, it also purge
the rx_queue.

>
> Can the problem be in vsock_bind() ?
>
> Is this issue pre-existing or introduced by this series?

I think this is pre-existing, can you confirm?

In that case, I'd not stop this series, and fix it in another patch/series.

Thanks,
Stefano


