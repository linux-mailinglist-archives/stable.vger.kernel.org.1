Return-Path: <stable+bounces-74134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC580972B3E
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8A31C240B1
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 07:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A91180032;
	Tue, 10 Sep 2024 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhrU5HkZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9321514DA
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 07:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954889; cv=none; b=dVDeN04RMubRSfqJchXA//nSE76zebnKcIx9SvRpP0i7XkmmYruu/sBTtJFyre3KLCI9QpA8mVqVgqcgbhGoSTJIEjIsVvPREEYq/C7Pl+1wrleZbJUvalu0zZQFW8Z1UZiCjurFqBan4dW2vrZ5EmRii9IEcriSIupVFJUhMOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954889; c=relaxed/simple;
	bh=KeqTmh0BQFN/VIEkcymNhVe7df/Fj9BSFD8+DM+IarE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xn3fnvj6FQeEc1RVxqjhWXISsYBy1ZywMB5UARXRV561YP2YwdgjqKEFHINDXTT1T23LgMXpQZlrdNRxGVZhm68Zb10xPd006opReRZ3glrYTGmjXJWc22KGW4cB8cvRz863ykYA+8n5xBds7fSVpOSOkP1fElAnev/LZeq64CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhrU5HkZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d24f98215so391386266b.1
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 00:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725954886; x=1726559686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLxdbbIcHKz8caJW0+X/KLCN31tHPPcKqzcOKw7iaTQ=;
        b=EhrU5HkZuIDvvNpGeKqW3O8Q63x7Urfub872eZ1nEwfHxSCgqkt1tgVP0FwosC4mRC
         hQ2hKiGUK1BYrFIJCxuswYFtNKxXsNucCYW+DPMwbvZeRJwpK2HNZoYqUgAo6EOoYuGC
         v6Is0DejhFQ/HHyTGGnAyu8mYTvcs/HBdzbZcLWugQ6PGEgbH1qhiEjlpAIdwcLl9gAh
         BpI+HfTLEMpfcdbI+1uOZiARQg3yg5AiB24DllO+1KHElwo/+CsGVo3bMSf7bns1QCMK
         yMA4hd86DkPuMLXgedRnZq9EqRkMQ2yvcXSxvICyTgZdKdWfDb1TynBp1sJ2KV89I8MS
         xQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725954886; x=1726559686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLxdbbIcHKz8caJW0+X/KLCN31tHPPcKqzcOKw7iaTQ=;
        b=maK4QuPz997AmkZ/RSDMXtny31uPZ7zkGhh+yBzoWn5RIY7waISsw+zZHjJKFv9zTC
         7/iOLoOWzmYG787GN9MGal0Rdpy0U9aqwbgrZc4DId6PFpJhaD19BRbAlkG5X7Y+NQ0T
         z7zPIb/BpbvrfhmzCSmceSUOpGV0QBk7qMFABLBXaPQAZQ3B75OdSg9sEtoR76mzzb2R
         eQSfxoUDGwI4SEC7pDPukVtegmxjWtZ4vphUO4EUJ2U3xUObfG+0LgkoaxqS2un6Oeft
         KIHej3AiGSGJiIIlKDbL9Xg9fjwp5xHhPYVA5ClNOlO+UKc04aP/OmCpfWtTzhUtIvua
         sBBg==
X-Forwarded-Encrypted: i=1; AJvYcCXLy6i21W10Pgylg0EVu2UKnLgcyBWQDMbaTH3q9vn73zmTqYYLWi75JhFh4iFYRvr5n4H99c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvA6uP5z7GSWA4+apk3sjDlfD2aG8MlBbsXY2VCu34zkBi81OC
	JOpg4zV7ycZwddAOBO6OKOI6HixuEdSecxiln5+uQxdFt2xNkJUSYElQPKjyGWQX7xEHjwfx2Pm
	IXmR0snNP1t1QXyKv4ZklsaASpOLHtdafslzK
X-Google-Smtp-Source: AGHT+IG3sGZv3WdAfHkBHWqny8tIQGffeAIFi8EjCWEZVIxB5gyfhJfccPbUdsWHu1CD++Ri0ByqrE/nlrD/rJSbWcU=
X-Received: by 2002:a17:906:6a14:b0:a86:b042:585a with SMTP id
 a640c23a62f3a-a8d2494c39fmr778949466b.57.1725954884809; Tue, 10 Sep 2024
 00:54:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910004033.530313-1-willemdebruijn.kernel@gmail.com>
 <2024091024-gratitude-challenge-c4c3@gregkh> <20240910034529-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240910034529-mutt-send-email-mst@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Sep 2024 09:54:31 +0200
Message-ID: <CANn89i+3u2hQWoZECOqo6QL4wX01_KAkwgYzELWnZjutzFoW2w@mail.gmail.com>
Subject: Re: [PATCH net] net: tighten bad gso csum offset check in virtio_net_hdr
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, nsz@port70.net, jasowang@redhat.com, 
	yury.khrustalev@arm.com, broonie@kernel.org, sudeep.holla@arm.com, 
	Willem de Bruijn <willemb@google.com>, stable@vger.kernel.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 9:45=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Sep 10, 2024 at 06:34:46AM +0200, Greg KH wrote:
> > On Mon, Sep 09, 2024 at 08:38:52PM -0400, Willem de Bruijn wrote:
> > > Cc: <stable@vger.kernel.net>
> >
> > This is not a correct email address :(
>
> I think netdev does its own stable thing, no need to CC stable at all.

This is no longer the case.

commit dbbe7c962c3a8163bf724dbc3c9fdfc9b16d3117
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Tue Mar 2 18:46:43 2021 -0800

    docs: networking: drop special stable handling

    Leave it to Greg.

    Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

