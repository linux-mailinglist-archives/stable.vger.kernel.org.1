Return-Path: <stable+bounces-188873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A808FBF9DC0
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 05:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0D3188A042
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 03:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73672D193B;
	Wed, 22 Oct 2025 03:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNB9+QYw"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989302D130C
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761104530; cv=none; b=DjQtgPqwlDj/fZc/+BU4t9ifg98TnVYRx3MePfIxaVGs/UVB6NPMBtfTDFyLrqgxIUly9Jp/DlSTXfEYPAz6cZPMDPfEw5PUvXzJkRvi4MQIxdgWTJiB/fg+2OBA17p0D2m1rj7Umk1AnETMCimk5PYr3Jo7zKGzbJFqfLELC5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761104530; c=relaxed/simple;
	bh=HMZaRHd3QBC0oWYyy9CqpnKYlqU3jX1Jp7DLd0mUWxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ID4CeSJhWmLOpYTfNnYEiQ4No16P7pAQfMV1eglNv2bFcnDZwkluJC4x9kqwZ9BA+bGkFKsUK3An3mOZir0Mwd6BHplg8mPqCMgZKyoFedDEfQtAGyaU8fbfAOp9tdBs4AVcE7FSt9J8g4qY/3+qySjoefplzLE/+v7tYiT7oes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNB9+QYw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761104527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMZaRHd3QBC0oWYyy9CqpnKYlqU3jX1Jp7DLd0mUWxo=;
	b=HNB9+QYwU/hlwidmnzylFJwkl3Hbs8qwdnHmEbjOoKJ8jm//jgjEmuZ950FdD0S0EGnrIo
	ikwOO6M2180DUg0r/7k01YNIfO3FKCSKXPyDoDZB+wbusqrGSRPSeoO0ef1Z0mvWXxEEjP
	IGLwYzq4DxYHVb5ukQOeBXLut/+3c9I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-YVi1z7xbMh2ybXn0hBaJxw-1; Tue, 21 Oct 2025 23:42:06 -0400
X-MC-Unique: YVi1z7xbMh2ybXn0hBaJxw-1
X-Mimecast-MFC-AGG-ID: YVi1z7xbMh2ybXn0hBaJxw_1761104525
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eaa47c7c8so5019391a91.3
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 20:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761104525; x=1761709325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMZaRHd3QBC0oWYyy9CqpnKYlqU3jX1Jp7DLd0mUWxo=;
        b=geSG1hILUxSdvSA1abREkygtplrHqmrCyj5Sp0u76EvlOOsIuXpNN4w+inkFYw057M
         Vzi2Ue+lgFojghUR+DvjTTCP4YrSHSnqDRx6rbFOa3b9qBd3fwzA8w3XLAz0nrZl9VHi
         5QqbILSyNdJ8AO0jgw8K5A7Ie+1uF2wck7lPtHgAiAf/OBFm8zH+mpKnsk0GdnpFg1JP
         m4UQ7/hI3L56P4oXLMCQZB23N5KG5TDe/JOhWwgUXny/r2pYIEYXouH+f2vHSO0Zxhrq
         JL2Mv5yHEWhbxzynoLAztXbwz3XSvVkxRrMeEzDUQZ5dgaKdJ0iE9XId2i0SPcDW6A9g
         IFmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoKZRRyH2lNL459hUzZP6D/BagPxkLHn7X9W0Onv0ePvP/mg3qTLAv4TpI+yM/j/3wGfjaV8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqhf7UdMFCHVPDFriD2FNMszu4YF+mOubvvPxpyLsNKiueJS7w
	vyWxEtriMXpcHN1cZxQHVj1GHD4C79HQ7jio0pKl8y0vcS1v5dRhtq2brYuN0aL8oXYw4JmIwRt
	nr9vwhyiYD04bOGzU3XyV3JVyvxpEv64zyF0VU1v2960i5QM1KvnmNXFQz9T8oBYzNODmDfhITI
	DetjH5FYoXYfbqGUk3W+hyYFxFONwDVABB
X-Gm-Gg: ASbGnctGbDT/BnjHdzCNzMYbTBaZ7g1mHLVk10AQl6oawso0R0h/Dis0hhx94lJgZ+6
	q0WheXOdAerLJ4sjih7EifyUV74SvtcvxGsC2PnLfM/w/0LySBfxzjD+ZpGt6N4k151CVHIWJDO
	AnRQiKPsZMmH7v2+RSfaVbUVqiq9ZmJGVW+Gfc36oiSIncbYZk2+v2
X-Received: by 2002:a17:90b:4b:b0:334:cb89:bde6 with SMTP id 98e67ed59e1d1-33bcf8628ebmr27742378a91.4.1761104525162;
        Tue, 21 Oct 2025 20:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfFJjBBe9gj2JxeQntVU5I+I/K52WZIsvD7m3axHWRDtjxyFzVKU1vVPQFwjwwB3wSt/W9MIela5+BXvbcA7U=
X-Received: by 2002:a17:90b:4b:b0:334:cb89:bde6 with SMTP id
 98e67ed59e1d1-33bcf8628ebmr27742351a91.4.1761104524805; Tue, 21 Oct 2025
 20:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021040155.47707-1-jasowang@redhat.com> <20251021042820-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251021042820-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Oct 2025 11:41:50 +0800
X-Gm-Features: AS18NWAAJdWZmZZaokLYDDF4FQaIYsA-DM4Fq2y-aLHj75kmJUbkmf7MCRS75P0
Message-ID: <CACGkMEtUjP2UN4s2ZRF8UGV6Bb3-6oPkU50oJ0ek8qfYwxjv1w@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: zero unused hash fields
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pabeni@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:28=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 21, 2025 at 12:01:55PM +0800, Jason Wang wrote:
> > When GSO tunnel is negotiated virtio_net_hdr_tnl_from_skb() tries to
> > initialize the tunnel metadata but forget to zero unused rxhash
> > fields. This may leak information to another side. Fixing this by
> > zeroing the unused hash fields.
> >
> > Fixes: a2fb4bc4e2a6a ("net: implement virtio helpers to handle UDP GSO =
tunneling")x

I just spotted this has an unnecessary trailing 'x'. Will post V2.

> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks


