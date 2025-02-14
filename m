Return-Path: <stable+bounces-116412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B07A35E64
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 14:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE63616D416
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 13:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9718A264A9E;
	Fri, 14 Feb 2025 13:01:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958BF264A9A;
	Fri, 14 Feb 2025 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538092; cv=none; b=nRsduaedp4bNcOXTwCerUm5ejh9yheq2jWXxOKTE6RLyV6fcnPU9RwADrcLbw/6UB9MW+KQyhjiclv7ig1gcfUZbm7NSk5bEf3U6X3CUj9osKhd7nfckSGuu4YUloixoeBPaQyargpkUZ/HgMNruJr4Wy39cnO0MpX57pQDtnvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538092; c=relaxed/simple;
	bh=FIBo4Pn5/bM8NNMW2uzH89Pu3UzY3UHIvwIrPFjcIYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKDKSlGY/irHND4uCJofoEF+g6InVFdGPC/6LxfsZdL47MFD1bZESUoA14MLR6yOXhfwl33AZXAyy2Ze5DI6TRA843BidtVJ+LLbLwVREUc3+Xf9wP9ifOp/lHsvz+nn6cnw7KIoEjSjS/1o7WJvWLM41NARuzOzxRQSUlXZvPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so1106614a12.1;
        Fri, 14 Feb 2025 05:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739538089; x=1740142889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmJSbPjau7GZkUvt4YAQLEQLZ+4k7GSl+yHabGYZeqg=;
        b=r5b4CCrBRukca8dW6trOReaOCLrjy95fAenMeFpNH/cuEF05cgTBy9FrOVFnJm7xyL
         sa/qBqRuzu8MD9P+zxdCvsx/RKSggt/hEQS0IrS+D9e7ffLQGciKqhKtsWZLIzaLNf2Z
         EDHI9M7IysptptsPz2Jtz3geLX/L3s4pZW2KoCFn03e/rydGoPBUF/9Cbaimx0AgPQcg
         zpghuKwqrYo0HL7p5/mWA43JCaB7Aetehl3XQINF+TLTqN3AuR0klT/uTWS8ly1JxHFe
         FZm5wVB2VlQ6aCL5aWtAG+a7Ieu17DVdPisb4cwzwV9ieO2vmDxL/VTJ7nZ62oDI7fi7
         H8tA==
X-Forwarded-Encrypted: i=1; AJvYcCUgS60VUGlJvtIHcTqU+WP7o4wu/V3jBIoA4agB+lc/o4r74v7djxQwyyphJt2EhT4aQ31ImxEq@vger.kernel.org, AJvYcCWI2b66Rmp1kUmA1j0iCg6HP6hESocDP0jsUsJbj/4Z0vrPzzX1HhZsxxeRpvN6zZo5LdcBG0rJ@vger.kernel.org, AJvYcCWsAj8WAolw6F1YTrxGCpMMM9koqtoIkHhDdkgVWVNUuVtNaIReYtgCHtRHI88DfIGZpoGBwsPu7+BQADo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/bugQ4iL1NM7wCDcP54tAB4oZI/SIpxJ4nPe0SZAfnjs56sG4
	dZ8C60JB9XFo1kIJjdz+WXZpY4FIjuidsFvIS8y493p0HWl6tbga
X-Gm-Gg: ASbGnctXpAhgHH8AGQh3GsALmw0qS4hRilyu2VHv4lVND/gZ3RKmkZXrVxfcF5zHzv8
	eZ9qhPm3I0AlwKs/veW2PgyW7oVlJtZheOQy9KlS5Ug0FYN+mOGQ71FB5fFHR0ouVQlGWLyzg9t
	0Tz01+hf3hmDC6EvvQA54b8oQ6maUT3rpGz6m5Ujd1kywd/MIAtwlnIo9nBMdCHn+/ZTFu4xzfo
	+B+4n3/b6pvx4GkCUU4vNQeXyD3UOympEcPO7JgEi6VqLsVO7yJxA2mN5ZOAdlQTgb9ESRSp/84
	B6sflQ==
X-Google-Smtp-Source: AGHT+IEirsmfMl6q8OzxN8fXiy6/+vOALKyTI2Z/D3DognQreEPKQsCrns0gsFkYbx+oq0ZFm8aeEA==
X-Received: by 2002:a17:907:1c1e:b0:ab7:ef47:ed27 with SMTP id a640c23a62f3a-aba50febe2cmr709899666b.13.1739538088320;
        Fri, 14 Feb 2025 05:01:28 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532581cesm334181466b.45.2025.02.14.05.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:01:27 -0800 (PST)
Date: Fri, 14 Feb 2025 05:01:25 -0800
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH net] netdevsim: disable local BH when scheduling NAPI
Message-ID: <20250214-daffy-athletic-kakapo-ba9b1b@leitao>
References: <20250212-netdevsim-v1-1-20ece94daae8@debian.org>
 <CANn89iKnqeDCrEsa4=vf1XV4N6+FUbfB8S6tXG6n8V+LKGfBEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKnqeDCrEsa4=vf1XV4N6+FUbfB8S6tXG6n8V+LKGfBEg@mail.gmail.com>

Hello Eric,

On Wed, Feb 12, 2025 at 07:55:32PM +0100, Eric Dumazet wrote:
> On Wed, Feb 12, 2025 at 7:34 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > --- a/drivers/net/netdevsim/netdev.c
> > +++ b/drivers/net/netdevsim/netdev.c
> > @@ -87,7 +87,9 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
> >         if (unlikely(nsim_forward_skb(peer_dev, skb, rq) == NET_RX_DROP))
> >                 goto out_drop_cnt;
> >
> > +       local_bh_disable();
> >         napi_schedule(&rq->napi);
> > +       local_bh_enable();
> >
> 
> I thought all ndo_start_xmit() were done under local_bh_disable()

I think it depends on the path?

> Could you give more details ?

There are several paths to ndo_start_xmit(), and please correct me if
I am reading the code wrongly here.

Common path:

	__dev_direct_xmit()
		local_bh_disable();
			netdev_start_xmit()
				__netdev_start_xmit()
					ops->ndo_start_xmit(skb, dev);


But, in some other cases, I see:

	netpoll_start_xmit()
		netdev_start_xmit()
			....

My reading is that not all cases have local_bh_disable() disabled before
calling ndo_start_xmit().

Question: Must BH be disabled before calling ndo_start_xmit()? If so,
the problem might be in the netpoll code!? Also, is it worth adding
a DEBUG_NET_WARN_ON_ONCE()?

Note: Jakub gave another suggestion on how to fix this, so, I send a v2
with a different approach:

	https://lore.kernel.org/all/20250213071426.01490615@kernel.org/

Thanks for the review!
--breno


