Return-Path: <stable+bounces-61880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB8193D493
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 15:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038EF283A7A
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 13:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A3717C21C;
	Fri, 26 Jul 2024 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEsWt/sy"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3788E1E51E;
	Fri, 26 Jul 2024 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001808; cv=none; b=iL3gD71sKEEAaeFJRnyR5JsVC16HA1LQ4WZWjdjE9aoQrXiB1ribkINAj9oJwvzV37SVPVi5sYwqAfajd5dLI2TWt4qAmgS2QeuNCNQTqcWU7AZh9Iknnb3j5YEo9oRRnF1W8Xq65ZuqKHtNs0FzMFPawytSGxxP28vVKo2l8Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001808; c=relaxed/simple;
	bh=faQ1wVJrMePxsi1+TgfM4u0l9baALGk62s9cTVgtCkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDyySZyYwuQLpUHJc83OTMMAEXZ71yUiNvslAOKm/ADqc2nD+SgIzX49JzQq86cRf99wJHpIdInMD1yhtKMS1qddjw89vu0OgEZGh1+mIAs+9PlYY/D3MRKYihliR8vyijy4BETuKo1A55rXQXAL6gDcDecx/tqEUUExXyDtYz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEsWt/sy; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f5153a3a73so271461e0c.2;
        Fri, 26 Jul 2024 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722001806; x=1722606606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQTSbwp7fWVIR1Lsu119df0C4W+fLPaUihsyQxt958k=;
        b=mEsWt/syHT24PznZDXKlKVUmHMyqj0hb1oF1YzrU4N7ic+5HJN1Z06fqafKr/7dmvO
         Q9WdtsRGQGQCH/UkEP5nQdO0n+i2rya2w8Ys5ytGh++LXuAvNP2hc22JuNhEkqozD2i2
         LXlBYANTzwQonSntiNP34Oj8n277eUhwyvQy5oH8KnZgpYn4sPd+yehIK4Exg3Xim204
         Z0BbXdi5mzLcz/H8BG4AohzML+7VmTPbXaB2l5sMgp+IidOKZIbsna3ZnnEIsmSn1ooX
         wnovo3vevuEb7IHHnKAwwTpiNsj4pnfosVkPR8zmRxG3Sqj7aNaQ8tRY+xuxHh03GvKP
         dUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722001806; x=1722606606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQTSbwp7fWVIR1Lsu119df0C4W+fLPaUihsyQxt958k=;
        b=Y4CjUR/9V5h5jkeUpA8Nq5FAOcoBnndPsJ0GTY+NozEVeh0cifihg26Ob6la+vCJ5d
         gTWFzU7VxFhtA0+mlu7PMvlBOt2yrrkFrot7KlMFMwxLW5srY82SNOvyDhNgbWlx0ndE
         6VhXaNjipJBwIQNXvDRSRHxqihsYFTdN/GgbUSJrfIrLag3VmTH5Oa9GfrZ6xTAGAEK/
         i4DzPpqMkZ8+YCWMsJcBhAsOnaWdVgyWt3Y0FhOzvgPpeiV+bkXpH29Z2Oqpf5/EP5Hv
         IWuuFc6Wtmuuwx6F1UV8BrjJZLeL26XwhqV9RBufyLEnbdStsa8GgDqVXP3ZD6gjvyLP
         TVmw==
X-Forwarded-Encrypted: i=1; AJvYcCUGUo5WBHxZxpqgNIv+PEierjRLxzJB33Cp8aKeCd0z/NUBHLMlGbyvWFOWDZeyT1QZxNje682Ud0MfsRH9Ny8ZxlW4NkHa
X-Gm-Message-State: AOJu0YxkOaM/Cpo+YU91sBxg1S/3S/T3daXZvq19Anb6w9AEJla8+PwP
	ZEHfChVsRvEbCXeWzkMoMoZFcrRM8DSnjHli69ZXhdMwrJJTS5yIdlitbhHhCAnjHM3vUn/jIiu
	+/TLEzhcWmygsP55comOsb17kcaY=
X-Google-Smtp-Source: AGHT+IEh/jWeobdSWAM3EFxoF+xIBVygBmISNM05wgXcXEji7lnsYOptB7K/nBWaiwR7ERxBxljN0DLDv1oeO6SjJ8A=
X-Received: by 2002:a05:6122:3bd1:b0:4f5:199b:2a61 with SMTP id
 71dfb90a1353d-4f6ca37d8f2mr6433687e0c.9.1722001805832; Fri, 26 Jul 2024
 06:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com> <CANn89i+gMUzYfX2UTzCZx_S=96UHEf9_KzkG-cCq9aQkUiX3Bg@mail.gmail.com>
In-Reply-To: <CANn89i+gMUzYfX2UTzCZx_S=96UHEf9_KzkG-cCq9aQkUiX3Bg@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 26 Jul 2024 09:49:27 -0400
Message-ID: <CAF=yD-KZSrh=5gH-yrtw4kcAjXn4T8Fm7xoik-OcmAWBTQ9BdA@mail.gmail.com>
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in virtio_net_hdr
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com, arefev@swemel.ru, 
	alexander.duyck@gmail.com, Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 3:00=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Jul 26, 2024 at 4:34=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > From: Willem de Bruijn <willemb@google.com>
>
> ...
>
> >                 /* Kernel has a special handling for GSO_BY_FRAGS. */
> > diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> > index 4b791e74529e1..9e49ffcc77071 100644
> > --- a/net/ipv4/tcp_offload.c
> > +++ b/net/ipv4/tcp_offload.c
> > @@ -140,6 +140,9 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb=
,
> >         if (thlen < sizeof(*th))
> >                 goto out;
> >
> > +       if (unlikely(skb->csum_start !=3D skb->transport_header))
> > +               goto out;
> > +
>
> Using skb_transport_header() will make sure DEBUG_NET_WARN_ON_ONCE()
> will fire for debug kernels,
> with no additional costs for non debug kernels (compiler will generate
> not use skb->head at all)
>
> if (unlikely(skb->csum_start !=3D skb_transport_header(skb) - skb->head))
>                   goto out;
>
> (This will match the corresponding initialization in __tcp_v4_send_check(=
))

Will do, thanks.

