Return-Path: <stable+bounces-114141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E19A2AE49
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82283A82C8
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671AF1F419B;
	Thu,  6 Feb 2025 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="helJakJA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0471EA7ED
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861160; cv=none; b=uNVKb/i6m+74lgEL6YCeUl1RofdXuWykFke+r+qjXpM4RA5UJ+VL6/avLgF7M7dzrduRllDqAcDT27mAfhZrmozO06dGPlJXrVKRgOiTtT6k1oqu08whUIwZ7gA0JdBV18tthN6emvm/MR3BdYH5QxShfbYjhqDE3Su4ozGQCOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861160; c=relaxed/simple;
	bh=5QbMbbQcxvmhyi+0MguvDAyh705KPX1OSdU3Tsd42tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+nGg9tqJLEfvx3FEHOII1X1qvmxBBiiEGVkyeB+nDkLIdSuY0q09NoYzG7/q3KFHOEo2nlyv8Imn7OQlHuyxHJov7snmoA45Q/OcMclnRgGKQfGl6Zb7MMLs9j1xb6Bqmx2WBMtLU6QGHQIMAFETxXuXQbVcOintZfMQ2+jNec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=helJakJA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dcd8d6f130so2321120a12.1
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 08:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738861154; x=1739465954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VM4vonSDY3AnIidNmdkBkYsmfCj58HI1K3CZ7AEmhH4=;
        b=helJakJA1MvE/mVxSvqBkNM8q6LkdCvg3T8PzIeYmnDTd5cjXu2LvrvTmKvKPIYtzg
         LAzucYTKP56nNtx6yw5BjbvDxbVrpQn8x45x6xNoaTrIugmfd0HrtdYfMoDUewq+inJN
         Grw4Drikg420/9KE19mHglwzSdIVy0UHDHM6z5CJ5m+jFO0MuGObHbmB95fB+Ova7g6e
         dnoQVKi2GOnb4+M280d7irr5tgaA+9CUnEPLZQajPB4BKOVmthAcIqVh7n3k3iLtS/p2
         7j85YgIV1Yce18MXnSZyJzAMmEOL6oTMeQm829w+b2HfCrJQPz4gCJupCFit7uu8tOZA
         1Cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738861154; x=1739465954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM4vonSDY3AnIidNmdkBkYsmfCj58HI1K3CZ7AEmhH4=;
        b=rt1EjfTe1GIYoDjmaTwfi1k+1UqkvnSfo+TcarZNyquSpjb2xOdjo97Lj1XYzorQXi
         J6cmTLDSk9H4HURbXxEUQcOaAVe2EU7raZDEK9gPfj7qxdsP3acvl9JhzCQsFN6nTeRB
         BZ1SWSbJynruEYflTwUcczDo1BBpuAt3NP/ERLH8oiWC9bFYmFnWr9Ofs4rij6/Ovzbf
         o63tuS5otjcaTXK0hqWDPK0dP9lpaQjN2QsetujFywX8sOVFNEjHx2Efl/IPJjT8BNru
         1hJjzcCV0KcImhxfmEm0qPUTIMXiUpfAVgpuikfO0m3lc6t+3kEwpbl40I08gzLXm8Zz
         bjyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe9uwa98EER01mT7N4G0qOOtbpFGmTuok3tGG1aCAK7QV7qROyZdwbfMbKC18ys4i8VDnVlEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqvx9cRCJdOo8ComgfPwEstNDT/YFQcvM8Q1XsAKu+jQok4WfX
	X7wP5JuAi+cb3EqCMN+DSLCoEQGG2eRhT0NaJx9LJhOUH8WKmx0DDs/oDkMJFOSvwS9zO+EkylX
	aZf4v+n/5NfXfm0QLsltUSQoGWOwITuMUaMCK
X-Gm-Gg: ASbGncs97HlB35kLSZLSU0O7IWfi7D3Mb1qgZYJ5cTKzHoRUU12YR6uWW2I6eiOF8Z4
	KayFMPzYJKh5nJBbKbH7xUtWHsy+xxH+1MFD6SBRk9eREkcrpy3y0OLoOAYGaHcTr51in1UT1+w
	==
X-Google-Smtp-Source: AGHT+IFzaE4T7sbdiBB76z0y8f6nzQp7lQUWhO5ZeJW7y/EGro+YVQnvkVfXl4AsyESLLSuFUnJprUrXBsfzJGYIHXE=
X-Received: by 2002:a05:6402:440f:b0:5dc:90d8:f4c1 with SMTP id
 4fb4d7f45d1cf-5de45047a12mr167322a12.10.1738861154365; Thu, 06 Feb 2025
 08:59:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206165132.2898347-1-nicolas.dichtel@6wind.com> <20250206165132.2898347-2-nicolas.dichtel@6wind.com>
In-Reply-To: <20250206165132.2898347-2-nicolas.dichtel@6wind.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Feb 2025 17:59:03 +0100
X-Gm-Features: AWEUYZkvTzz4EonJZDW96lwJ75T5ESDy-CmwF5hQKXHSC6tevviuI1sH2y7Q-ao
Message-ID: <CANn89iJO66n0OtC1axnkfukm=vD5AacHcuxXh3sUvyTXdSy-TQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: advertise 'netns local' property via netlink
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 5:51=E2=80=AFPM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> Since the below commit, there is no way to see if the netns_local propert=
y
> is set on a device. Let's add a netlink attribute to advertise it.
>


> CC: stable@vger.kernel.org
> Fixes: 05c1280a2bcf ("netdev_features: convert NETIF_F_NETNS_LOCAL to dev=
->netns_local")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  include/uapi/linux/if_link.h | 1 +
>  net/core/rtnetlink.c         | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index bfe880fbbb24..ed4a64e1c8f1 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -378,6 +378,7 @@ enum {
>         IFLA_GRO_IPV4_MAX_SIZE,
>         IFLA_DPLL_PIN,
>         IFLA_MAX_PACING_OFFLOAD_HORIZON,
> +       IFLA_NETNS_LOCAL,
>         __IFLA_MAX
>  };
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index d1e559fce918..5032e65b8faa 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -1287,6 +1287,7 @@ static noinline size_t if_nlmsg_size(const struct n=
et_device *dev,
>                + nla_total_size(4) /* IFLA_TSO_MAX_SEGS */
>                + nla_total_size(1) /* IFLA_OPERSTATE */
>                + nla_total_size(1) /* IFLA_LINKMODE */
> +              + nla_total_size(1) /* IFLA_NETNS_LOCAL */
>                + nla_total_size(4) /* IFLA_CARRIER_CHANGES */
>                + nla_total_size(4) /* IFLA_LINK_NETNSID */
>                + nla_total_size(4) /* IFLA_GROUP */
> @@ -2041,6 +2042,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
>                        netif_running(dev) ? READ_ONCE(dev->operstate) :
>                                             IF_OPER_DOWN) ||
>             nla_put_u8(skb, IFLA_LINKMODE, READ_ONCE(dev->link_mode)) ||
> +           nla_put_u8(skb, IFLA_NETNS_LOCAL, dev->netns_local) ||
>             nla_put_u32(skb, IFLA_MTU, READ_ONCE(dev->mtu)) ||
>             nla_put_u32(skb, IFLA_MIN_MTU, READ_ONCE(dev->min_mtu)) ||
>             nla_put_u32(skb, IFLA_MAX_MTU, READ_ONCE(dev->max_mtu)) ||
> @@ -2229,6 +2231,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX=
+1] =3D {
>         [IFLA_ALLMULTI]         =3D { .type =3D NLA_REJECT },
>         [IFLA_GSO_IPV4_MAX_SIZE]        =3D NLA_POLICY_MIN(NLA_U32, MAX_T=
CP_HEADER + 1),
>         [IFLA_GRO_IPV4_MAX_SIZE]        =3D { .type =3D NLA_U32 },
> +       [IFLA_NETNS_LOCAL]      =3D { .type =3D NLA_U8 },

As this is a read-only attribute, I would suggest NLA_REJECT

