Return-Path: <stable+bounces-192511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC886C36100
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 15:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F42E4F0052
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 14:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C1A324B1C;
	Wed,  5 Nov 2025 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uLWiJu/C"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D063B314A83
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352796; cv=none; b=bSOqDFTZXDtRjsWBjZRpFVJnz4A54EYZ44Llk6b2w80tyH7OAkv8wgxVu1k9WZ/gQ47wiX1mXnNHJT5NY4bvTEDEHwwf06E4WvnQL391jrTBw0dUVWDrLyuVKW2zfMUj2Ono+U+m7roSZ65bUj+VBzvkfB7gWvDb3r51qHx+QDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352796; c=relaxed/simple;
	bh=UNLeQYL51m+DVasBcWR7PNTrx8XW9tm4YcPbq3YJCTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtbahLkNCcO+WfnME3U/86BmUDKb9LCDnMGfPhTI1hGefeFq06Gs/i3pIB/zlpRQTjBvDqMfNuYALgnOcsM2OMx2qbR1B1vy6mZyYQaVsC2IkiNEiC2v+BUFfOvDCm6FbnhiCrRofl7y1Q63iAv2s8saLX/tLHosuzio/mUuJbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uLWiJu/C; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed25b29595so70127891cf.2
        for <stable@vger.kernel.org>; Wed, 05 Nov 2025 06:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762352794; x=1762957594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yn1Akn56TAK9vxYVpNAmwzoyFjP8WhPaxNLUGZGYjkM=;
        b=uLWiJu/CoXQzzp40yTT9Q02+Yr46Xz5hL6nHYdW8LNVCbBaT1XWa/CmfAcBlhLb1bg
         77lz7tMA5pk12nds7S0eNIJ8PnapTj6d2LYNkYSTWSpfttWWg4UOGRsAKg/kv9XfIDq+
         Zfd42QumaLkTDJD3dQ4PSmehIKfKkPfV2TiWLRenRLUMKS+oEBbsvaPWdfiPm9EDnhG0
         uJzLbhoyha2mQOqitlyEjw8K9UEXFhdGUjWj6DuW7CHIj/2BxX1UQQexRkjfzg/WxI5W
         Yt2IGmhBYbE8LqTJzbmWfFC15/a/xj/RhLDs8w7sBS5yFWu/klp4Ld4ciVlctYE5X6DH
         tlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762352794; x=1762957594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yn1Akn56TAK9vxYVpNAmwzoyFjP8WhPaxNLUGZGYjkM=;
        b=MtjIYIN/OwMFIbzyW4c2FaP3dvqaQdbRcGNpEzkGfrEzvdGjyBZ99tE5w7Fohl72L3
         FhBK/3C1v/3NUHb2GJjd9MeHeW28MWNgOzWkF2VUF8hxpbjTMqNetV8eWokq35bbh+Ef
         vaSujJYiG9ZVq9D/l4l3TlteEftzc9xAb0SEIFmXTl7xnOzXRlgjX1bTIiC/TNqZBC+l
         Wj1KZrig2GUs+aScKyIWDWDQkhWoPiZvqGivMgzKDDv1ioOWXbZzrdyNMgO+YJXhsBtX
         eE1LcMerPJ4vhxbBLIEyNGZuFgq1sPO3vUA0E0yAYHmnIsNFE5rLd2ZYuu+bwyDrpd/H
         Z/sw==
X-Gm-Message-State: AOJu0Yw1PUL4r1Winz5F9lbwtpkkiqGKwgbUDHdEOqrEqszLTKScN7d3
	vFX1gSWgXP6XuP31V5NQRfDCS2Zyq2MJYJ93/ZN0aYy9V3HUUklc7X8HdINWJ70cPniaOSee7sq
	gdnTtmWaej+dcsTbir5cvvt9RnzYIKkYgQw2dNR6glmuDVb9nH5AcbsEE
X-Gm-Gg: ASbGnctUCVUKSyTJKwjzRRObLLfPhvfvgOrIdWp3QiFi1RF4RmglcLtAQo2NFWvP9y3
	iNH8T7kLzy3tTcvHBG1os1gh7MBVlLZki6O+nAyNiYGcmPGFSbSkzHKTzi5EAojisVvxDIspbYA
	yqca56i7Hv755X1LW6ucT1jpH2UL0DZoVFtu0ZpME4jDYdtv5ZmOth2McLy8k3g4RVZXbhFlP4O
	CQvgNba40U8rIKG30/3wgM5fRweEd7/MEIS+D5Plv3iJUWpeLAjkByTslTV6Z0Dh1xNaL0v6IEF
	Idx9ng==
X-Google-Smtp-Source: AGHT+IEyRyguqmLTVuV/+p4rWmG9dIhs2YGO8hfZ3uT7d0TjJn2hFD71728jqAvX+zyf0Qlwg6ZcF52UU2ueLDMEGK4=
X-Received: by 2002:a05:622a:1cc3:b0:4ed:42ba:9bd5 with SMTP id
 d75a77b69052e-4ed7262edbcmr35915681cf.72.1762352793343; Wed, 05 Nov 2025
 06:26:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACueBy7yNo4jq4HbiLXn0ez14w8CUTtTpPHmpSB-Ou6jhhNypA@mail.gmail.com>
In-Reply-To: <CACueBy7yNo4jq4HbiLXn0ez14w8CUTtTpPHmpSB-Ou6jhhNypA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Nov 2025 06:26:22 -0800
X-Gm-Features: AWmQ_bkdl5RhKS829nQ2M5b3RoWq2JzXUH6E0i1Wig8_xYGoL3cCA0DzQqGNDNg
Message-ID: <CANn89iL9e9TZoOZ8KG66ea37bo=WztPqRPk8A9i0Ntx2KidYBw@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: route: Prevent rt_bind_exception() from
 rebinding stale fnhe
To: chuang <nashuiliang@gmail.com>
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Networking <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 7:09=E2=80=AFPM chuang <nashuiliang@gmail.com> wrote=
:
>
> From 35dbc9abd8da820007391b707bd2c1a9c99ee67d Mon Sep 17 00:00:00 2001
> From: Chuang Wang <nashuiliang@gmail.com>
> Date: Tue, 4 Nov 2025 02:52:11 +0000
> Subject: [PATCH net] ipv4: route: Prevent rt_bind_exception() from rebind=
ing
>  stale fnhe
>
> A race condition exists between fnhe_remove_oldest() and
> rt_bind_exception() where a fnhe that is scheduled for removal can be
> rebound to a new dst.
>
> The issue occurs when fnhe_remove_oldest() selects an fnhe (fnheX)
> for deletion, but before it can be flushed and freed via RCU,
> CPU 0 enters rt_bind_exception() and attempts to reuse the entry.
>
> CPU 0                             CPU 1
> __mkroute_output()
>   find_exception() [fnheX]
>                                   update_or_create_fnhe()
>                                     fnhe_remove_oldest() [fnheX]
>   rt_bind_exception() [bind dst]
>                                   RCU callback [fnheX freed, dst leak]
>
> If rt_bind_exception() successfully binds fnheX to a new dst, the
> newly bound dst will never be properly freed because fnheX will
> soon be released by the RCU callback, leading to a permanent
> reference count leak on the old dst and the device.
>
> This issue manifests as a device reference count leak and a
> warning in dmesg when unregistering the net device:
>
>   unregister_netdevice: waiting for ethX to become free. Usage count =3D =
N
>
> Fix this race by clearing 'oldest->fnhe_daddr' before calling
> fnhe_flush_routes(). Since rt_bind_exception() checks this field,
> setting it to zero prevents the stale fnhe from being reused and
> bound to a new dst just before it is freed.
>
> Cc: stable@vger.kernel.org
> Fixes: 67d6d681e15b ("ipv4: make exception cache less predictible")

I do not see how this commit added the bug you are looking at ?

> Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> ---
>  net/ipv4/route.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 6d27d3610c1c..b549d6a57307 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -607,6 +607,11 @@ static void fnhe_remove_oldest(struct
> fnhe_hash_bucket *hash)
>                         oldest_p =3D fnhe_p;
>                 }
>         }
> +
> +       /* Clear oldest->fnhe_daddr to prevent this fnhe from being
> +        * rebound with new dsts in rt_bind_exception().
> +        */
> +       oldest->fnhe_daddr =3D 0;
>         fnhe_flush_routes(oldest);
>         *oldest_p =3D oldest->fnhe_next;
>         kfree_rcu(oldest, rcu);
> --

