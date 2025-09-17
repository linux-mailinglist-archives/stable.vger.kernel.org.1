Return-Path: <stable+bounces-179807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 595EDB7D477
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C217216CEB7
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 08:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDFA30BF52;
	Wed, 17 Sep 2025 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClfNjSro"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0F93093AC
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098493; cv=none; b=AEKcACeDb2GfT+LvCiWcYzcV6gY+6hbRqPkI9RjfFZJIbCUpAqy3lyhDhRVpTpRiNOG0Be8aVtqYiFYJvaax6W+4/AXxCb4xqk2Va9tj5oOa8ek7h8Qg6TqX/aNtMuL2KPRLuGhgi770Pf/8HMZ+c6QJe0RbiB5nqhxvt02NJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098493; c=relaxed/simple;
	bh=+wuBB/CLNq1RtJJc8pKidovhSHWzMbLGpuRbJ63e2mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lu9VG7La3DnjBWaZ7q1+QERvW18ndKpyI6jA8zFASDuGQ28QrjTsnJcA4wpws3WHojPZYTvcajyGcDW/Ch5vROjbpMnHGaL3XvG67v5USkP3q9EX/fNvdz0qhJ6hXdHybQp+VHGyOktVKHz2L4Q7CDqmSZRf9ff6KW5V94txCAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClfNjSro; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758098490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xk1YDZxcM7xZ806Adb7sILX43779sE7ub9kXrnkxlpQ=;
	b=ClfNjSromTf4w4ZCpOEf5T8m3rSHFPHA74A6AVvi+pFbIUaS2Tj5F8QvzvnydHsmneIwyz
	A6+4LKA7Xxhkb7szEj/XtbGg2AuaGgpFsUNmFV25budtMMTl6R/Zo0EI6d5cKXOdR6GMjI
	WH6fxfbzsMY1PZ5nSHO4zKN6rJNGBb8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-DBg2uajqPb6LkuwC5OW4-g-1; Wed, 17 Sep 2025 04:41:28 -0400
X-MC-Unique: DBg2uajqPb6LkuwC5OW4-g-1
X-Mimecast-MFC-AGG-ID: DBg2uajqPb6LkuwC5OW4-g_1758098488
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-732d6d922f6so15247817b3.3
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 01:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098487; x=1758703287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xk1YDZxcM7xZ806Adb7sILX43779sE7ub9kXrnkxlpQ=;
        b=ei8GB/iVlYyzMSzk+MWRgeTEGv7ab8aidmv1wQsWcIpMK+Z4UN2+w5Y6jhnyW9hyMF
         j9It9Q+fWU/ijT/JIm1tCvoEksEGB1kMIJSbVbUOoH+SRTve+MlCLOMt6ynx7BWREzH7
         SsmzMX5LRBAtDtpjGJYOCWt/N8Hp+s8Xwbrr2uH6jH6oeShtcDy1qWK+cZIeF/GlVbZO
         Wes3QY5Qo70PIOTFeF3+Q9PfgLFZK1hT7eP4jAC4fO2EdAY4/3uUMuSIfMcvvPMgfbu4
         y1XXvhh2qyAiFdB7ifOQKpb/qLLET14+9LCxWjve6l71BQltVDomHlMTx/LRtn+oqrDS
         8qoA==
X-Forwarded-Encrypted: i=1; AJvYcCULCQ+6fPayPJGM+b8V5ohQcvSLbO+9y+BqIuSsJQ9SN8sloRjB6ou/xe6AQnJswXPlq85EwTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz14jBAyDWXrm6UeGHl3+YCsSdFhPzPs08on0lyu1yL8yjdRCpP
	vNVoqtRPvwW21bc9nUP7HS+BvEBmthkIlbZsOPG9S2oeRNVqHkA4yhE24HeQHndxidofLqTMum3
	3VyJoHhaYVQYLCbC1d+YhICvBMJoaqclo+2PL6ZLr5krO6nwGrf0yNLs8UxoiJff/GdEXaZc/k9
	UFERl+qpiy7ZKAgYAxbLu5sSAfvLMxrKAQXzIy2yYkSFk=
X-Gm-Gg: ASbGncsxVj+3kQqFvGQjJ/CLjWXgntSKFyH1h/LCTRLI6IvHcfCBFKjUkbvfxOCsdzC
	4acjXNKNKzpwC+V/EMz4Q1V4jlPxI/0M7ARjTUJR/ywyegt3cUnskibTJ5bVWFTNy6IsvK4jWIY
	URrvQcw6RauFCuTjJ572BZvmGOEb4RYSSCF8/pq/G9yQNtPV3Bf4corqmp4Msr78z5zI4VJuaov
	1FX4owx
X-Received: by 2002:a05:690c:3749:b0:729:afb7:2a2b with SMTP id 00721157ae682-7389254ad62mr8759267b3.46.1758098487652;
        Wed, 17 Sep 2025 01:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGla76rh1VJaXE/66DHe3qldHYQTe5nserK4YUTSrEtY8HjxPWvHFg/4R+WaJ3obw1G8XGpBOJzgwrt/fVLoWc=
X-Received: by 2002:a05:690c:3749:b0:729:afb7:2a2b with SMTP id
 00721157ae682-7389254ad62mr8759127b3.46.1758098487353; Wed, 17 Sep 2025
 01:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917063045.2042-1-jasowang@redhat.com> <20250917063045.2042-3-jasowang@redhat.com>
In-Reply-To: <20250917063045.2042-3-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 17 Sep 2025 10:40:50 +0200
X-Gm-Features: AS18NWB1Dm0RAuncLLFYv9X6ibudv7SYOoL2RD1bGzGSS2vWNV11fGBE2RDqleI
Message-ID: <CAJaqyWdsA5kbotTRpHXzHAyaxQY05dcmiPs=Y5Bb_9EVxf0oDQ@mail.gmail.com>
Subject: Re: [PATCH vhost 3/3] vhost-net: flush batched before enabling notifications
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org, jon@nutanix.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:31=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> sendmsg") tries to defer the notification enabling by moving the logic
> out of the loop after the vhost_tx_batch() when nothing new is spotted.
> This caused unexpected side effects as the new logic is reused for
> several other error conditions.
>
> A previous patch reverted 8c2e6b26ffe2. Now, bring the performance
> back up by flushing batched buffers before enabling notifications.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Reported-by: Jon Kohler <jon@nutanix.com>
> Cc: stable@vger.kernel.org
> Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sen=
dmsg")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/net.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 57efd5c55f89..35ded4330431 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -780,6 +780,11 @@ static void handle_tx_copy(struct vhost_net *net, st=
ruct socket *sock)

The same optimization can be done in handle_tx_zerocopy, should it be
marked as TODO?

I guess a lot of logic could be reused from one function to the other
or, ideally, merging both handle_tx_zerocopy and handle_tx_copy.

But it is better to do it on top.

>                         break;
>                 /* Nothing new?  Wait for eventfd to tell us they refille=
d. */
>                 if (head =3D=3D vq->num) {
> +                       /* Flush batched packets to handle pending RX
> +                        * work (if busyloop_intr is set) and to avoid
> +                        * unnecessary virtqueue kicks.
> +                        */
> +                       vhost_tx_batch(net, nvq, sock, &msg);
>                         if (unlikely(busyloop_intr)) {
>                                 vhost_poll_queue(&vq->poll);
>                         } else if (unlikely(vhost_enable_notify(&net->dev=
,
> --
> 2.34.1
>


