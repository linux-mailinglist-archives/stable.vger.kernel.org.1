Return-Path: <stable+bounces-176790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AA8B3DB37
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 09:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34984189BFDA
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 07:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9276E26F297;
	Mon,  1 Sep 2025 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZoIHldoE"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D426B75C
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712285; cv=none; b=eLnyA5Hox1H0ZFc6y5HykyrFmyT6cr+PxrmH8sMdb42tKW+YaojHSirBFVqxxL+MmQ6WniCRibzmWLdza5QrnJzt8B2Pv7S+/CbxPMJbmtWmUxn0TEyVhgCZVTI9uGhTJ+avAsLnRAwfUmhJ7KKEmG56qC+fj/F66QVBP/wco1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712285; c=relaxed/simple;
	bh=WzfW40AZj4gPjN0MUg3o+yqK/+B/OT5Q7UpvUVPe8oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQNnMWvDclHaNyVEoNbgUJcbdv0EsT05KjvvWngBvEdW07IG6y0DJc256YYpFpPvEbWIt39Es/O0Lss1ZS3FkB5Lbdw+ihWT2BHWv/XuG+TmPyZSKmvgZR3VjdXU1GTT7tPWGIPqyPM3nBFyjAvkTMFPTiERaTg5Rgg6nbNNvr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZoIHldoE; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b326b6c189so16654011cf.2
        for <stable@vger.kernel.org>; Mon, 01 Sep 2025 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756712283; x=1757317083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7q7Kl5djn2WgPJ4cdJmkEnqgC+STRWJseSy7eNtKfiA=;
        b=ZoIHldoE4OtEwoVNTtDxzFHfePWLl8GYRBZOmq9MVfG5gMXB+/iN6gOv6cb41P4g98
         FUtpZMQPHZY4tls3HxBDujX6LPerx3SYsA7kN6DUH8AW4BP02Z9nQGJY9DwMq4mgYRTH
         5S48mS/QSxtUlJJBUspoKXcDCpVTP73WWcZ0b87zVIlAElp4UK3PZE59AV8DXGzORcDh
         L/v+7kCjfdYhlldxO/Rxez6ONIEH+WhNyYTjFbUZSTdOH/IT9nRgevi1hJTpzVfdfv9L
         VUx6mf79Ubmb+svzi1lbSbwjWetF0mv11udoChe5tI+y8e1lElYI1VzQ58jmhfMt+vfw
         elsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756712283; x=1757317083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7q7Kl5djn2WgPJ4cdJmkEnqgC+STRWJseSy7eNtKfiA=;
        b=B57NzYwrAeNk0L6+nSKYvx+bsD7T/EqZsDe4K6asGTLQobnvDY+UrPqt+kRiRGBI2h
         0VQ2jCPJs5ro+Q5EWErk4Z2J1eJYspg1aNJR3nuJBubokGBvVr898YA/tYHpa0itHqzw
         wamDxMZxdZCdzLrEjDZFBhGZMyKfcpKK/ImxD8Hph0LWHSFlRCWF8us5DujangA9jQJe
         robDNl/JqpkWZnRagsFA7X7d0ze8MDAToI6Zzii5T/DKs3vIb+oKUDjfLYpvgWdA3EBb
         Xz0nriT0jTPm/vYZiC5YGIbayvQZQKB3nKtZ7NHG1t6r+1+KEfCMu6cMt6CwPnTr99xr
         gxfw==
X-Forwarded-Encrypted: i=1; AJvYcCXaDybx25QG9GWTVwueLc7nu3hzWVbpTgonljWx3YANfK5ey+nazTOQhcCnCUNho8ZTeXxtOWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUUXBq6XbVIyxm549Z3x+YFs017mvDCndZrHm0/qPaeV4tyPyR
	hGl+PvhaYo3VDJ8CmfW/rZxAA2zUqaouXAI48/koqUE7YWVWRDTDuy5zImkFkdL4r3aqAZC36uI
	JpiFGMNWhY6S+Amg9QfrKTCMt4W6k3iMG0TC7ChVV
X-Gm-Gg: ASbGncu0amFjjQEH7NJ2Npj87eVbF+KWfoGeNjGsJNBvAT5e3FJpIUrpQ3XOGY+7WvU
	tpIxlUyuUvw8DdajIr1Eu9G9ZTmkWvOj3bc8hL1ZweZy9ZDwRHww19luSLaiqqAeTX9qVmVvsk/
	FinYCkTf90YDPCUxmchrlJGYZzKBHeMPaEaLn0k6du8JM3CgiUa1aPw6DnJLLRWPD0ISWyj1zSI
	ZZznQW6zWvYPw==
X-Google-Smtp-Source: AGHT+IGzV6ATmp61ewbLzWto0qipug1G5shAQMh1uxcEylMfvmjc0KzUnlWIJKtFhfSJ0DazP+bJFRjB/3sgo7tLmGo=
X-Received: by 2002:a05:622a:4c0e:b0:4b3:19b1:99d4 with SMTP id
 d75a77b69052e-4b31dd773bdmr95750161cf.80.1756712282420; Mon, 01 Sep 2025
 00:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827143715.23538-1-disclosure@aisle.com>
In-Reply-To: <20250827143715.23538-1-disclosure@aisle.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Sep 2025 00:37:48 -0700
X-Gm-Features: Ac12FXwEBF4lffbGsQAW59JN0B7gOKoWwGphyL_Y5FDSSgXmBtkMqJYMWifcp7Q
Message-ID: <CANn89iJM3CV-_2jWMMspH52RvfWtep-3srctf47NkYUkTTboSg@mail.gmail.com>
Subject: Re: [PATCH net] netrom: validate header lengths in nr_rx_frame()
 using pskb_may_pull()
To: Stanislav Fort <disclosure@aisle.com>
Cc: netdev@vger.kernel.org, security@kernel.org, kuba@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 7:38=E2=80=AFAM Stanislav Fort <disclosure@aisle.co=
m> wrote:
>
> NET/ROM nr_rx_frame() dereferences the 5-byte transport header
> unconditionally. nr_route_frame() currently accepts frames as short as
> NR_NETWORK_LEN (15 bytes), which can lead to small out-of-bounds reads
> on short frames.
>
> Fix by using pskb_may_pull() in nr_rx_frame() to ensure the full
> NET/ROM network + transport header is present before accessing it, and
> guard the extra fields used by NR_CONNREQ (window, user address, and the
> optional BPQ timeout extension) with additional pskb_may_pull() checks.
>
> This aligns with recent fixes using pskb_may_pull() to validate header
> availability.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Stanislav Fort <disclosure@aisle.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Stanislav Fort <disclosure@aisle.com>
> ---
>  net/netrom/af_netrom.c | 12 +++++++++++-
>  net/netrom/nr_route.c  |  2 +-
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
> index 3331669d8e33..1fbaa161288a 100644
> --- a/net/netrom/af_netrom.c
> +++ b/net/netrom/af_netrom.c
> @@ -885,6 +885,10 @@ int nr_rx_frame(struct sk_buff *skb, struct net_devi=
ce *dev)
>          *      skb->data points to the netrom frame start
>          */
>
> +       /* Ensure NET/ROM network + transport header are present */
> +       if (!pskb_may_pull(skb, NR_NETWORK_LEN + NR_TRANSPORT_LEN))
> +               return 0;
> +
>         src  =3D (ax25_address *)(skb->data + 0);
>         dest =3D (ax25_address *)(skb->data + 7);
>
> @@ -961,6 +965,12 @@ int nr_rx_frame(struct sk_buff *skb, struct net_devi=
ce *dev)
>                 return 0;
>         }
>
> +       /* Ensure NR_CONNREQ fields (window + user address) are present *=
/
> +       if (!pskb_may_pull(skb, 21 + AX25_ADDR_LEN)) {

If skb->head is reallocated by this pskb_may_pull(), dest variable
might point to a freed piece of memory

(old skb->head)

As far as netrom is concerned, I would force a full linearization of
the packet very early

It is also unclear if the bug even exists in the first place.

Can you show the stack trace leading to this function being called
from an arbitrary
provider (like a packet being fed by malicious user space)

For instance nr_rx_frame() can be called from net/netrom/nr_loopback.c
with non malicious packet.

For the remaining caller (nr_route_frame()), it is unclear to me.

