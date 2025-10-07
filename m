Return-Path: <stable+bounces-183540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD52BC1653
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 14:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5483AC753
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 12:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0AA2DF6FF;
	Tue,  7 Oct 2025 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFyBf1MN"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DA02D7DE9
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841099; cv=none; b=pSl/vIzmyqWjDA7psCDQVJlSkEkc0OJS46V6hKc25QeDYMy402R+PLsh8nHjIlp8jtv3ORoPIS5BViBzS/vhsms4Qprjo3RAhIW+gyDi3V12+Bc28DE1W6yYLDmlAjszK9BQmNP0JpyeSd5Frbf8nCZl6sAQY3osZzmqRkWvSZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841099; c=relaxed/simple;
	bh=v8R61G9uFRafpRqgof2hr0YG91bTbaxUiJ4pliJV99c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUMgPkX82wIVlNefq5yrhgWKHzOKpoSUUGoe3+B7g59IjrSBcKkHdwycCR4BB1AEYTSuggBOrfKVgAjOfZFd77iBFQMdOZKFIM4TIpeOrfL8N/OrpwG9xP8LbLQlkB8QwRLUpfAOVi4ALIAKWS2wcU3zsGQwXkdPNZj1vvdyYvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFyBf1MN; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7900f7f4ba9so60908766d6.0
        for <stable@vger.kernel.org>; Tue, 07 Oct 2025 05:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759841096; x=1760445896; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sAHCsIlLwSaJ2tvd0eA1u1tkqHau8sGeAg3aqapTft4=;
        b=kFyBf1MNRU46bYnsRZnUARGBTslOBW5IiGOkXGKqS+Xgk5FL1xh5Md3CM/hVzdyb0I
         1xEumeyQG+k6HR5OL/+WjuOzwqudNcz6H9QM8FZQOp506uYkTQoI+v4LKJDSyHE7uIYA
         y0S0AWTQGKcH0FDgVZ0Agz8m9tTsB8MGwtbY9p19Vkvr4sy4/NLRrGBDphcc2Bj66wwf
         ufySc4lVKzdD/77s1QUV2Ypf1QLkxSftsCQgwAnGRYFdy6S5JMsao+tG203DvhTQxPe5
         17RiAPQXGpUsSSEf6/6DaFix0Reoq2rrLcREDJMSuHKuf+fRvzTR3PeCxXKtVizfQM33
         0NXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759841096; x=1760445896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAHCsIlLwSaJ2tvd0eA1u1tkqHau8sGeAg3aqapTft4=;
        b=BpRU7CdidXfmphI8umDXaSZDbalQ96a6OofHRzg1IHqHfvTmkupPtxH37jB1EWVlPy
         Y69hoAHFNM2ta1GNNlArovj62lBlza5olp61C9CAlr2rAywQgSOhBN9z5X6QzM4dyI26
         ntQYw6Ra01g35zVUuBdgtWmtKEGta/5m9YCXpbK0fLB5LAs1Gg+596alT4k13PSGjMk2
         gW6dGldjcucKpZ+Y0LMVzYVl4/0hN7PXTxTFaYEsB/abnbyo6RAjYtd98YoMir2LFMaP
         eMayXYSFPAMXTtGJn3NDFVfjOZzU6eqRdRuU18BaLpB6hrF4dgoiXFVd/INWSfUxcUXI
         Oqzw==
X-Forwarded-Encrypted: i=1; AJvYcCUa2agZrrjUX0f5mSBarwfWW7yp6XUV9BeFowJxUt2bfyS+0efE8zd9P4duG2aJQX1D94oJQvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YymU6Kf5QH+VZGUb59LGySlmxd0XtahLo7yNvPnbaYSyfaWqe7+
	7sRlDFJj0JLkud6lYRubm1TeLkxVGdCAX7RQs0qBwo5l6Co15yiIp7Au9lAtPjQeWPyF/XvL+Dj
	h0JeuaZXrrQ4t5WDF5G2IooikmuJrGasu8y0T
X-Gm-Gg: ASbGnctFRDoolC+KTtjD6r6uFFeSyHLurO452LKWzlPx1bIlijXzaWIuTGAtsi42weg
	lxW8Eg5yt/+pkLhHpltclmlSeglf4ofLKYMbpkwQXof/gXy+4sWDSjB/baa1RviOlIS9p3a8+lN
	dztsoTyvylhSquBa7BjrGv3xI2Tbql/hKY1zQW00Ef1MOFZohF03SFFNLjzDEFi8Uggya+KkQeF
	W4j4EAagrDHkd8stn+/QM4fWdAKyY8=
X-Google-Smtp-Source: AGHT+IEo0I4fjDzNt4bWp1Mv8jnjbS6WheOlafdsTmodNxclq2dXxLbXwy+MwuvyKzGZZTCsw5noIpHNgDFNoSYhM18=
X-Received: by 2002:a05:6214:27ed:b0:78e:f843:e974 with SMTP id
 6a1803df08f44-879dc8817bcmr213229076d6.63.1759841096159; Tue, 07 Oct 2025
 05:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006085316.470279-1-Ilia.Gavrilov@infotecs.ru>
 <c5a1c806-2c4c-47c5-b83a-cb83f93369b4@intel.com> <06da20bf-79f6-4ad7-92cc-75f19685b530@infotecs.ru>
 <fa7b9dc7-037f-42f7-87e5-19b3d8a3d2c3@intel.com>
In-Reply-To: <fa7b9dc7-037f-42f7-87e5-19b3d8a3d2c3@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 7 Oct 2025 14:44:45 +0200
X-Gm-Features: AS18NWAnR4YpziIfj3IV8amXvZKL_RMPNGBrMgzSOHgm0l_GJQ5WzXolRyspwjw
Message-ID: <CAJ8uoz1wf6cfRN16pdMZuoWMxVLWfywVymB7NffDpp82vp5dLA@mail.gmail.com>
Subject: Re: [lvc-project] [PATCH net] xsk: Fix overflow in descriptor validation@@
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>, 
	Song Yoong Siang <yoong.siang.song@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 14:11, Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
> Date: Tue, 7 Oct 2025 11:19:19 +0000
>
> > On 10/6/25 18:19, Alexander Lobakin wrote:
> >> From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
> >> Date: Mon, 6 Oct 2025 08:53:17 +0000
> >>
> >>> The desc->len value can be set up to U32_MAX. If umem tx_metadata_len
> >>
> >> In theory. Never in practice.
> >>
> >
> > Hi Alexander,
> > Thank you for the review.
> >
> > It seems to me that this problem should be considered not from the point of view of practical use,
> > but from the point of view of security. An attacker can set any length of the packet in the descriptor
> > from the user space and descriptor validation will pass.
> >
> >
> >>> option is also set, then the value of the expression
> >>> 'desc->len + pool->tx_metadata_len' can overflow and validation
> >>> of the incorrect descriptor will be successfully passed.
> >>> This can lead to a subsequent chain of arithmetic overflows
> >>> in the xsk_build_skb() function and incorrect sk_buff allocation.
> >>>
> >>> Found by InfoTeCS on behalf of Linux Verification Center
> >>> (linuxtesting.org) with SVACE.
> >>
> >> I think the general rule for sending fixes is that a fix must fix a real
> >> bug which can be reproduced in real life scenarios.
> >
> > I agree with that, so I make a test program (PoC). Something like that:
> >
> >       struct xdp_umem_reg umem_reg;
> >       umem_reg.addr = (__u64)(void *)umem;
> >       ...
> >       umem_reg.chunk_size = 4096;
> >       umem_reg.tx_metadata_len = 16;
> >       umem_reg.flags = XDP_UMEM_TX_METADATA_LEN;
> >       setsockopt(sfd, SOL_XDP, XDP_UMEM_REG, &umem_reg, sizeof(umem_reg));
> >       ...
> >
> >       xsk_ring_prod__reserve(tq, batch_size, &idx);
> >
> >       for (i = 0; i < nr_packets; ++i) {
> >               struct xdp_desc *tx_desc = xsk_ring_prod__tx_desc(tq, idx + i);
> >               tx_desc->addr = packets[i].addr;
> >               tx_desc->addr += umem->tx_metadata_len;
> >               tx_desc->options = XDP_TX_METADATA;
> >               tx_desc->len = UINT32_MAX;
> >       }
> >
> >       xsk_ring_prod__submit(tq, nr_packets);
> >       ...
> >       sendto(sfd, NULL, 0, MSG_DONTWAIT, NULL, 0);
> >
> > Since the check of an invalid descriptor has passed, kernel try to allocate
> > a skb with size of 'hr + len + tr' in the sock_alloc_send_pskb() function
> > and this is where the next overflow occurs.
> > skb allocates with a size of 63. Next the skb_put() is called, which adds U32_MAX to skb->tail and skb->end.
> > Next the skb_store_bits() tries to copy -1 bytes, but fails.
> >
> >  __xsk_generic_xmit
> >       xsk_build_skb
> >               len = desc->len; // from descriptor
> >               sock_alloc_send_skb(..., hr + len + tr, ...) // the next overflow
> >                       sock_alloc_send_pskb
> >                               alloc_skb_with_frags
> >               skb_put(skb, len)  // len casts to int
> >               skb_store_bits(skb, 0, buffer, len)
>
> Oh, so you actually have a repro for this. This is good. I suggest you
> resubmitting the patch and include this repro in the commit message, so
> that it will be clear that it's actually possible to trigger the problem
> in the kernel using a malicious/broken userspace application.
>
> (also pls remove those double `@@` from the subject next time)
>
> I'd also like to hear from Maciej and/or others what they think about
> this problem (that the userspace can set packet len to U32_MAX). Should
> we just go with this proposed u64 propagation or maybe we need to limit
> the maximum length which could be sent from the userspace?

I prefer that we do not set a limit on it and go with the proposed
solution since I do not know what a future proof size limit would be.
Somebody could come up with a new virtual device that can send really
large packets, who knows.

> In any case, you raised a good topic.
>
> >
> >> Static Analysis Tools have no idea that nobody sends 4 Gb sized network
> >> packets.
> >>
> >
> > That's right. Static analyzer is only a tool, but in this case, the overflow
> > highlighted by the static analyzer can be used for malicious purposes.
>
> +1
>
> Also I really do hope Infotecs stayed independent from the govs and
> doesn't take part in any dual-purpose/gov-related projects.
>
> Thanks,
> Olek
>

