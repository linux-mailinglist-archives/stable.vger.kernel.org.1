Return-Path: <stable+bounces-96182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7689E113B
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 03:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0E8B2330C
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 02:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459F5130A54;
	Tue,  3 Dec 2024 02:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4EAqaIS"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3795B8460
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 02:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733192732; cv=none; b=gOXhtGrOvVr3Ci9Ne20oSmKs57bK1zI+tuy8KAb7D5cWfQzJDu+Dw2600nnjYonN9E+Jkuhm5rr2XfXrW/+Mi+NmZa40UgaKxE83eYt7f1fXG92GbTZ+2y7bhW7g3K5L44h0e9yB0xFSf4STchEO6u0JR33JNzD9f0NvYiuMkqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733192732; c=relaxed/simple;
	bh=d6q8bGpZsfPskVwkj6L7Lml5GYk/xxetw+D0hD9cEJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiNzrjmifk6gK1pFfdcd7jJGK7rC3x4BJ2VrQUXeiq/6yokeKY0W8hPvIRzlJSubPW8g4XGUSQDlcBg7zUNtXRB5OcBJu8UJuD1jA3c/XLWLgcEuXnpNdOfh57WUtB2kjdjS8SXWaCSewqdz1oHcQ3Cm629S1prjZIsSPnanTqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4EAqaIS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733192728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6q8bGpZsfPskVwkj6L7Lml5GYk/xxetw+D0hD9cEJM=;
	b=b4EAqaISwa+mJLCpjirIdOJEDEr99H45OfozaT2BnlqphUszY1aQH9E/8RbSHufGQNaM2i
	FikslVW2l2Jq4psub1JJzeJSHlE8jDI5H47GUqR2JiNSPecWDaVKxyXumrD/mHCP0Auqef
	ES8PlEtOPo9keg81GyodeKLacych1u0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-dUkgC1O7PBSasHqx99Lx-Q-1; Mon, 02 Dec 2024 21:25:27 -0500
X-MC-Unique: dUkgC1O7PBSasHqx99Lx-Q-1
X-Mimecast-MFC-AGG-ID: dUkgC1O7PBSasHqx99Lx-Q
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2eeeb5b7022so1061281a91.0
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 18:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733192726; x=1733797526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6q8bGpZsfPskVwkj6L7Lml5GYk/xxetw+D0hD9cEJM=;
        b=V/DfLJ9rfzdAA/1GSbthqDTlREEGTF5ZzIU6lh3vdkp+/XVi1wIlk5xi4NSGcDabHb
         Kn0tZW4Qr8watm0EQV1TmNg47vLZTd8IFum8bvpWVhmKMRGc8HYFBEDRKogPGvkd93vm
         jjUhuGXvfeJ2wJjbEe6+cMJ6L9MW+LVoqnmD7OczX6uMUZkxK+FwsXASTIEw5jKplyox
         86zH7G8xDb13FI0HTkFxSmTvTj0c0EvDc/JOZ05gqr0nU26qmGgCccXX+xoXsvR4vi+T
         FUsCsgzrqW0dP7oYlrdbm4oGTf+PdNQl0FrdNYf5chXvoPsg7oKtC3WDsTSenu5ise0w
         9Fmw==
X-Forwarded-Encrypted: i=1; AJvYcCWf2M6yUD3RBCZAIEODyPTSU4tbMfPeHRNoFV242wG1HrwcpCfdY8Hf3HwxNWaLTrjjfx1CpPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNKY3DxEV6aH5XzlI7Wcv7v9Xrx3xWDDFiHnRi6vs1sIMaJPQx
	3OXksOlHmaRf0K5kPe6OaNpj+6MzERuQK6a5xlqodOsGVr8V1XMKkDhlqpCPFTl8XWTxflus5ec
	/Iai28E4RFD1FNISis+9+/tvhdEILPOixD3L+OAsaFuTXR+sgBbONfYokBYfRw5/CBe6eLhWnqb
	AvtXYuKiedH8oGt5UnhJgODTf9FruN
X-Gm-Gg: ASbGncuVQJSzaswJ+9MKnPiSg3jgeo1p2yWnDR97Gh8BUSrUSmJjmEgrVDo+Bfz36KD
	5b6tvH8H0u0dGJJzSCKxCl/VBmyJgnHzM
X-Received: by 2002:a17:90b:3ecb:b0:2ee:b8ac:73b4 with SMTP id 98e67ed59e1d1-2ef01276888mr1136819a91.36.1733192726106;
        Mon, 02 Dec 2024 18:25:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH5qQnZ0DiMbRpH7Ik71jXULxUEUKJNASFzFHC0GxhUTgu42/8cZ6SwHvLSqsP/acaKB2ErIzMfAseQ2enXwc=
X-Received: by 2002:a17:90b:3ecb:b0:2ee:b8ac:73b4 with SMTP id
 98e67ed59e1d1-2ef01276888mr1136791a91.36.1733192725616; Mon, 02 Dec 2024
 18:25:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130181744.3772632-1-koichiro.den@canonical.com>
 <CACGkMEtmH9ukthh+DGCP5cJDrR=o9ML_1tF8nfS-rFa+NrijdA@mail.gmail.com> <20241202181445.0da50076@kernel.org>
In-Reply-To: <20241202181445.0da50076@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Dec 2024 10:25:14 +0800
Message-ID: <CACGkMEs=A3tJHf3sFFN++Fb+VL=7P9bWGCynDAVFjtOT-0bYFQ@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: drop netdev_tx_reset_queue() from virtnet_enable_queue_pair()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Koichiro Den <koichiro.den@canonical.com>, virtualization@lists.linux.dev, 
	mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 10:14=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 2 Dec 2024 12:22:53 +0800 Jason Wang wrote:
> > > Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> > > Cc: <stable@vger.kernel.org> # v6.11+
> > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
>
> I see Tx skb flush in:
>
> virtnet_freeze() -> remove_vq_common() -> free_unused_bufs() -> virtnet_s=
q_free_unused_buf()
>
> do we need to reset the BQL state in that case?

Yes, I think so. And I spot another path which is:

virtnet_tx_resize() -> virtqueue_resize() -> virtnet_sq_free_unused_buf().

> Rule of thumb is netdev_tx_reset_queue() should follow any flush
> (IOW skb freeing not followed by netdev_tx_completed_queue()).
>

Right.

Koichiro, I think this fixes the problem of open/stop but may break
freeze/restore(). Let's fix that.

For resizing, it's a path that has been buggy since the introduction of BQL=
.

Thanks


