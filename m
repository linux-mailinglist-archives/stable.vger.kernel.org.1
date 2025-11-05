Return-Path: <stable+bounces-192517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8416CC36487
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 16:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D127E622AD5
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE0732E6B1;
	Wed,  5 Nov 2025 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibr5ouUD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+VhSKs5"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1813A2F3C26
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355288; cv=none; b=hFy7DO5B35X2Q5cjiWJRHNE/ccYWk3z9LCAUd9TmGATGP1RgKbTLS6DCOWBQY4bBqk6kYFjYFGITrG+rhPcZkrLEIOw/gu/r59Kzep94VdHJBxSlLupn2ETzDJAKjAdCVaaliWW9BP2toU+cyEb5oCnte+a7j4w8yaFVvND4FuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355288; c=relaxed/simple;
	bh=zddzhOg8X1nKlNluFiKuPj0/7ElZvDoM9lEwBP40PIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8zyHle/WinF98LCPpSQ1vMZ7UQVnAY3yVQuACRWbPhu1K0eDdEFv2OLDtNEBzHTGtKq0K4b2d8lT7go+ju/9tqDoZ6k2jZv9H8uQcPp6X2WFFYAcdoB06MR5dRR3O5+pIcDLnVlWELpU5hJQNTNtgjxcufSESPkBtUm+rGCaDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ibr5ouUD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+VhSKs5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762355286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zddzhOg8X1nKlNluFiKuPj0/7ElZvDoM9lEwBP40PIo=;
	b=ibr5ouUDPitVjgdtW7Bs7JNSGQ1+r/I0Dr1MZwCja75xmaxjBEdWUYX4xfteYY7WBPh6RF
	NQig0iVCXUctd2fLPNfIE9drCpjwgQS9qEaxxfpvh/otVlQHGmZz0izWwaKUAoJaBsm+Gg
	Pyft/hLogULP1UNzYLeG+7EwfkNs2GQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-67PnBhxYMnmK_xmPPIFo6g-1; Wed, 05 Nov 2025 10:08:04 -0500
X-MC-Unique: 67PnBhxYMnmK_xmPPIFo6g-1
X-Mimecast-MFC-AGG-ID: 67PnBhxYMnmK_xmPPIFo6g_1762355282
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b2ef8e0133fso975477266b.0
        for <stable@vger.kernel.org>; Wed, 05 Nov 2025 07:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762355282; x=1762960082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zddzhOg8X1nKlNluFiKuPj0/7ElZvDoM9lEwBP40PIo=;
        b=E+VhSKs5SJh45HFSv2dfh4byTipz3JBUuXq2cmafniGyY1LOU2Y/5Hfm2O+5q6xElQ
         MpZ8hXEgAx+hKxFiItQqf2EPRWpLqZ/KDhWPjnBl8ShEqGkyqusem0EJx+Ke0SrKROPT
         dZaVWrN/J+oxW+dDGB/UpEvjBQ9I+GeNZIaXON4wEsVEVUbrKCtkQtQPI4jcUhvXhGJw
         eCCOSId/EcvAbpl5TEhLVby2jDhtpub7Xd49lH9pc4D8L7IUoIlmfaGgxU055bot6ltl
         ybDsIFwnRZdgWIzVYuKp0Ve8jQqtAp1PqyFLnvrq7cbuGA7PsmemCOhyckjgsbERpVAK
         TQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355282; x=1762960082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zddzhOg8X1nKlNluFiKuPj0/7ElZvDoM9lEwBP40PIo=;
        b=hyv2vp+IIouwng4aaAGzY24fppmUy+RwdaT4MmAHS/PpxALvuJSs2+rJhgzEAGdAmd
         7LDoHgjgWahNXycMILaKtzGr0FeO2Tq+neo6M89Qv8lZ1LFZxtM2JvysDMcN29l7sWQy
         Q7lJiOmiNR1WBZtrxbHnpajHrrumOysIJ3acnfvR0ed8AaBjfl629bRiBumeb9lSK5ay
         1y/gA/mGCNaPUNyWsHLOyUCBWcBsrbIBiF8AoG84d6Kv662VE8dghls7FgNr3Vh9WmX6
         cOEzrM91gzXkNNn+rKgys9PIYL+3tpgTXr8Gj+1w4suSbE8FLdyJbfvppR3vqc1aQghC
         DrAA==
X-Forwarded-Encrypted: i=1; AJvYcCWT2Icvb//oVfFCjiXX9rsH00omGuQBz9VA0XgVom5biQsDhT48Hk6gmQqPmPGqSPZqKOPxvEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEovm6DCZvKxCCHIWlZWQyC7IUJJXhurp3kO2eDh/6Mkt29QoQ
	xbkH5LhScQXSqk5lpW2lzzII22XaSpw2WtCnyiJolVylg7VhPi6mf7uh7rda9nRqmIqp78SFUvd
	fVv2YD/snmzSeE7fgTss3AKeRgZmtatD5jG9uKNJ3d6tdSa2GtMB4i2ubWvpCUsOtTwLe+ddQ0l
	Xxz9bX7FETc6jiAq6T/E+myCfHHUfvv7z8
X-Gm-Gg: ASbGncuBny0BwYJItb4HalBYckEkFh6CAakqCfbEWpsqPXEI/IrRNQG7lL/Vq9r+L1K
	G2vJdXUpxpTsnLV+wBTV4LeI8WZDQ5npS8Qzz6c25U65oMUb1LZpdGR7mA18qdokvTC5td05iUp
	Rm0spZXSfLHa5T8Nw38GNLjM9Sm3ufkU9b5WsQ5be4UPaEXfVA099FwIaM
X-Received: by 2002:a17:906:9c83:b0:b70:b3e8:a35e with SMTP id a640c23a62f3a-b7265568be1mr330080866b.50.1762355282366;
        Wed, 05 Nov 2025 07:08:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVOQsjYVyVVrNvkq8akL5ZkGRlDA5wjcsUyQMOyzqYmrxUAS+dfw/oU0IlQDgyfAtyrlbYChyW3M7kMF0tLDI=
X-Received: by 2002:a17:906:9c83:b0:b70:b3e8:a35e with SMTP id
 a640c23a62f3a-b7265568be1mr330075866b.50.1762355281900; Wed, 05 Nov 2025
 07:08:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030144438.7582-1-minhquangbui99@gmail.com>
 <1762149401.6256416-7-xuanzhuo@linux.alibaba.com> <CAPpAL=x-fVOkm=D_OeVLjWwUKThM=1FQFQBZyyBOrH30TEyZdA@mail.gmail.com>
 <CAL+tcoAnhhDn=2qDCKXf3Xnz8VTDG0HOXW8x=GSdtHUe+qipvQ@mail.gmail.com>
In-Reply-To: <CAL+tcoAnhhDn=2qDCKXf3Xnz8VTDG0HOXW8x=GSdtHUe+qipvQ@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 5 Nov 2025 23:07:25 +0800
X-Gm-Features: AWmQ_bn6PCV_WZmKEJ3xHMkBMOhvHDcRetwwHLmBCefOcZy0CYLo96d-gGmw7e8
Message-ID: <CAPpAL=xDpqCT9M6AWHTfNuai=3ih-452sW4g43gduiw7TptToQ@mail.gmail.com>
Subject: Re: [PATCH net v7] virtio-net: fix received length check in big packets
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 8:19=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> Hi Lei,
>
> On Wed, Nov 5, 2025 at 12:56=E2=80=AFAM Lei Yang <leiyang@redhat.com> wro=
te:
> >
> > Tested this patch with virtio-net regression tests, everything works fi=
ne.
>
Hi Jason

> I saw you mentioned various tests on virtio_net multiple times. Could
> you share your tools with me, I wonder? AFAIK, the stability of such
> benchmarks is not usually static, so I'm interested.

My test cases are based on an internal test framework, so I can not
share it with you. Thank you for your understanding :). But I think I
can share with you my usual test scenarios: ping, file transfer
stress, netperf stress, migrate, hotplug/unplug as regression tests.

Thanks
Lei
>
> Thanks,
> Jason
>


