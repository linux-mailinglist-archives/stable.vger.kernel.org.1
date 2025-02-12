Return-Path: <stable+bounces-115076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6330A32EFA
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 19:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4289E18891F0
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 18:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87B1260A33;
	Wed, 12 Feb 2025 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mojI/bFq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A2C25EF81
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386548; cv=none; b=kkg8L10vUMRPAGSfzL4vToJgcAgl+T2zYrsWTxqUuqe9vvaMmYfLDm7GKH9luu2QFRgTHAyUAixCM/QAMrljSVNh/sd8E6XjDVRufBgcR74mJkEa+XmeTFr3BgGKd0VADH6gdQKB/nsD4EHfEFdD3+3EgE1JAID6xCUbEL6Jh7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386548; c=relaxed/simple;
	bh=CVMGdoYDL8T1fr+KrjJAoYlnGkxM8XNvTPZrejVoMJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJJ8g9RDveG2yujXvxalkW0v65ZzX0uPBf4fla0ew1D1SoKTsO5aRrVPaq3Zga/WHG9XkoYPeTbT5wsJthmcOu6wKlKCiQ0bqtojhF4WT9dTzCI0S8KD7avAO4Vyz2hb7JajGnlzGENF3GOFp9sr2cX6mojdXk3pw/EOr/++bE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mojI/bFq; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5de51a735acso14882a12.0
        for <stable@vger.kernel.org>; Wed, 12 Feb 2025 10:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739386545; x=1739991345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zx+Z2zXkUwVDnPf100xV5wq4Riv7VP7gTaMh3dudvK8=;
        b=mojI/bFq64VDLGVn4okoRdSh1uOirl93u3OgiJu2w/yPT9Sdo+70AwCom7n519LHPY
         Z0P5if1rCC++SzpOWaKjswutjKgD+ZZ0a98JuyVLC6DWC/3bo5RS18kg1U4eVCnasrh7
         R5faWFOj1U3gIzlVDMfAfOAnTy9piqC3MApX6ZfndQd8PuA71d/8i32ILePJ0R+Wnxzc
         Pe21mE1TPgKnFm9UNehLL94eCpZEAM3shNPdDTrhPvI4wnQ2ig61EsWOTz2kBWo5MCBl
         UtV8BT8DzIozU41MBcOv8hrklTQ2ooLuR3psH+d8oiFzAnsFhHXjU2Pew0GcolBViwEt
         lKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739386545; x=1739991345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zx+Z2zXkUwVDnPf100xV5wq4Riv7VP7gTaMh3dudvK8=;
        b=qwLldTsqzpTOrBOWJ/5pV75hPY8Wz+6/c5DzUWQucyhinJcVRcChErgGAadQlZ318r
         vHC5Mka+lI0ur/b0vkwjsgyQjgrn6PyOwYnnssiE36zd4gqAFGU+lUBTacd6ubqnMVN2
         039AxnRfRuhrlvVqkhAOqghMy1CuIhMOQ4McdDrerA8oeO/PKOU3WeXJRTqzZzXdFz2l
         olGZCnjnWvUn+hxjhpMszq0I+WM/l6FLLMwg5+7A8rg/PPqknugu3K35tU4OpttkqjeC
         giqyWMfzevOTi/jz4PBiuGWO2HREGTlVMRr28PDn/+ndhVW9PJNgYjHycM8E+/gZjYps
         wXig==
X-Forwarded-Encrypted: i=1; AJvYcCWrwHOYN5beqpH+YUti0mgP45jCIHaQ9Eljs6RmVFxIHK0QewOove7DTkel5+/MUxrSc/duecs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfg3KtpMEZIQCmuqSc6yqE+hLhy8eSnraLUE0NREr4wmBbblsI
	yL85uIpfM+q/krY7u5Q7XEBWKOAgTrOzEPG3KkpvmsA4tE5+uSp0u628vaKnmOU+qp60U2ekWNy
	YVklI2C4ia/cXH8+1rhEjQbZLAhXMvA9Drjnu
X-Gm-Gg: ASbGncuVhaisKtNv4DR6EAtVZuXnEgtSYrIDXHJ4oCEFzB8LGC9ZGVm7DZJsnDhW4Y8
	RTUC6+nHuwDHVzX6T+dPdYWa3zsrdOpKF3rMSUslIcALgrVt1JJ2vPGI0RhPEl9v05qomN8Psxw
	==
X-Google-Smtp-Source: AGHT+IG55X34wS789mMJieuUREdopLjA3B44FyJjV3/cSlysBfK2oTbNjkWAOTqEn89wiamATCHt8vdoRDXvCYynFHo=
X-Received: by 2002:a05:6402:913:b0:5db:d9ac:b302 with SMTP id
 4fb4d7f45d1cf-5deca0122e2mr249031a12.32.1739386544998; Wed, 12 Feb 2025
 10:55:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212-netdevsim-v1-1-20ece94daae8@debian.org>
In-Reply-To: <20250212-netdevsim-v1-1-20ece94daae8@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Feb 2025 19:55:32 +0100
X-Gm-Features: AWEUYZleq88KnF_kE4nPNRYzraS7tQ5dHAAtHxK4ii3MnHWveDWf1gwFIVTqsms
Message-ID: <CANn89iKnqeDCrEsa4=vf1XV4N6+FUbfB8S6tXG6n8V+LKGfBEg@mail.gmail.com>
Subject: Re: [PATCH net] netdevsim: disable local BH when scheduling NAPI
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 7:34=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> The netdevsim driver was getting NOHZ tick-stop errors during packet
> transmission due to pending softirq work when calling napi_schedule().
>
> This is showing the following message when running netconsole selftest.
>
>         NOHZ tick-stop error: local softirq work is pending, handler #08!=
!!
>
> Add local_bh_disable()/enable() around the napi_schedule() call to
> prevent softirqs from being handled during this xmit.
>
> Cc: stable@vger.kernel.org
> Fixes: 3762ec05a9fb ("netdevsim: add NAPI support")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netdevsim/netdev.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index 42f247cbdceecbadf27f7090c030aa5bd240c18a..6aeb081b06da226ab91c49f53=
d08f465570877ae 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -87,7 +87,9 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb,=
 struct net_device *dev)
>         if (unlikely(nsim_forward_skb(peer_dev, skb, rq) =3D=3D NET_RX_DR=
OP))
>                 goto out_drop_cnt;
>
> +       local_bh_disable();
>         napi_schedule(&rq->napi);
> +       local_bh_enable();
>

I thought all ndo_start_xmit() were done under local_bh_disable()

Could you give more details ?

