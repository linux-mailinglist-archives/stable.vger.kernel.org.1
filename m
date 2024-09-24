Return-Path: <stable+bounces-77049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70804984BCC
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 21:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85F01F23BE9
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 19:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D9B12E1C2;
	Tue, 24 Sep 2024 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVg3USFI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0049A40BF2;
	Tue, 24 Sep 2024 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727207456; cv=none; b=N88nEuWu+n+xUQWSfFLebPbhTm2eEAwIRlSZrKnWyy8kx8QHxyPjnrUyoD+Byo1DmyHBG3JgKipJxiOSxyF1Kmt6sI3XSf3YXfHYHXYCnlwdso60Xgr1PO0sQclJZQVvkPmFF9pvrdHfgxhJnrx1K4LEJOX9tJVVI7uAgvTEEcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727207456; c=relaxed/simple;
	bh=YcKqjUQWGYnWxJY+NKRQhkbgtYCI8SyZyH4HHCGKXTE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QW3Ca0vOZdAEc2MI5+oXgAB7MNnHFsfj//l6KGgu6RdkQERRieyTGA2V0fmae23m1ad9PQCSzjXW5Wq3AMTmIKQqRP3mo8GQYDQzH1AkGXOip0XLzOP05GFMDGURvge31HbXUB8dVFRvuNsQVvjuqlO01+MyWuYVQAqj4ngA6U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVg3USFI; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-846c36009d5so1611062241.2;
        Tue, 24 Sep 2024 12:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727207454; x=1727812254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9fLKAgs4Ts7Ftd9D/PvaKgR2A/xj7hugr2Nvm3u+J0=;
        b=PVg3USFIdo+9jRF0zpi3s7Vc0CYYdWU/116hNsoj1GTwtlCFfz/i9gJ2pOjduUYake
         dpQ1XcVqRGujb7eG066qQ/M/DduuqoIU1g7EWdSOrWrXWmLfzaoWeo67Ms+du4Nj7Omk
         Xnhl2SNEWj4p+xJ/WmhJ5nAwKezoZ1dRYFS27YSvaE74P46jaMwiFw+G4EQazB8FR88b
         NB000kP5yT0rLEgOburszG0l1LcI0NLO05Zj2voWN4Dx8a25Q3lERvFKyTF00FptPiDz
         53V8F+QMQwBjyN6Pi8moP56xpzMU4szHNYI0B6QmcZ9BAjfgn6ijLf5M9VmoBZTuZ73g
         i3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727207454; x=1727812254;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A9fLKAgs4Ts7Ftd9D/PvaKgR2A/xj7hugr2Nvm3u+J0=;
        b=eCcs1tTccodqYjjqEYyJ/cLVlc6NIqoo3q0Q+Ju2N4LK5dSCGUUEC53YuhYkmov1aT
         qG68ZTZo5wdC9dNO4+77vkDHMaIKZh5ApwlJPKAbDpBMI9AhvKyNqwedJM48a+IoGfvQ
         Q6X6MDKHRi05IP6bPICJeZVVoF1yGGyiAmni7TBPzttfg3PwAObrviPGddiwIatGCQs6
         sNQAX5Ob5kK8+BL8UegcpA0byd/cOUzjRMEatr1JDc+ZZ9n0pC1GNNAyrUqtPEDKXoRf
         jknHKCbxTxL6CcXN0R9ydLoqBafsYuDHwJNDZLVncmz/IvT7jaNtoAjvGcRTi3lkNwzB
         Km8w==
X-Forwarded-Encrypted: i=1; AJvYcCWD7xpvJZP2U/rDPOqQDR09Z1qtMhumS4B7Y9EWC9nBcZbNgVFFqzlTqRLV+4e3K4qEXVNe+Ts=@vger.kernel.org, AJvYcCXFN8HPJHdpvOjVzvG+bqPoOgE7iJdP7AbPypMhlEqsDFhUi662cfSlUqR9ZeDo0RI2hJOB/84N@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9HsWHUDFM+E7FquETVT/atDcOEz3Ab1udt5pO+UsM2V46o5J3
	8C6mV8PBlybkC2SU99A7b0Fs/OuqFUgvEZE4GS3I9ysZ67Qs0BS/
X-Google-Smtp-Source: AGHT+IEDvwydDPMyvQlQ1uj4ntKAx3iktmnPdXlRSl6L6idBnNQqiPHXls5Lb+3ECM7z+lJAxOZN+w==
X-Received: by 2002:a05:6102:5121:b0:49b:dd03:2476 with SMTP id ada2fe7eead31-4a15dd1d5eemr839306137.21.1727207453655;
        Tue, 24 Sep 2024 12:50:53 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4c2f51sm9446786d6.31.2024.09.24.12.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 12:50:53 -0700 (PDT)
Date: Tue, 24 Sep 2024 15:50:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 stable@vger.kernel.org, 
 maze@google.com, 
 shiming.cheng@mediatek.com, 
 daniel@iogearbox.net, 
 lena.wang@mediatek.com, 
 herbert@gondor.apana.org.au, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66f3181c4fd22_3382d294b6@willemb.c.googlers.com.notmuch>
In-Reply-To: <da09e77a-a293-41b0-a46f-861dd5775ba2@nbd.name>
References: <20240922150450.3873767-1-willemdebruijn.kernel@gmail.com>
 <da09e77a-a293-41b0-a46f-861dd5775ba2@nbd.name>
Subject: Re: [PATCH net] gso: fix gso fraglist segmentation after pull from
 frag_list
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Felix Fietkau wrote:
> On 22.09.24 17:03, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > Detect gso fraglist skbs with corrupted geometry (see below) and
> > pass these to skb_segment instead of skb_segment_list, as the first
> > can segment them correctly.
> > 
> > Valid SKB_GSO_FRAGLIST skbs
> > - consist of two or more segments
> > - the head_skb holds the protocol headers plus first gso_size
> > - one or more frag_list skbs hold exactly one segment
> > - all but the last must be gso_size
> > 
> > Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
> > modify these skbs, breaking these invariants.
> > 
> > In extreme cases they pull all data into skb linear. For UDP, this
> > causes a NULL ptr deref in __udpv4_gso_segment_list_csum at
> > udp_hdr(seg->next)->dest.
> > 
> > Detect invalid geometry due to pull, by checking head_skb size.
> > Don't just drop, as this may blackhole a destination. Convert to be
> > able to pass to regular skb_segment.
> > 
> > Link: https://lore.kernel.org/netdev/20240428142913.18666-1-shiming.cheng@mediatek.com/
> > Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > Cc: stable@vger.kernel.org
> > 
> > ---
> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > index d842303587af..e457fa9143a6 100644
> > --- a/net/ipv4/udp_offload.c
> > +++ b/net/ipv4/udp_offload.c
> > @@ -296,8 +296,16 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
> >   		return NULL;
> >   	}
> >   
> > -	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
> > -		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
> > +	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
> > +		 /* Detect modified geometry and pass these to skb_segment. */
> > +		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
> > +			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
> > +
> > +		 /* Setup csum, as fraglist skips this in udp4_gro_receive. */
> > +		gso_skb->csum_start = skb_transport_header(gso_skb) - gso_skb->head;
> > +		gso_skb->csum_offset = offsetof(struct udphdr, check);
> > +		gso_skb->ip_summed = CHECKSUM_PARTIAL;
> > +	}
> 
> It seems to me that the TCP code would need something similar.

I think you're right, thanks.

Separate patch, as different Fixes, of course.

> Do you think the same approach would work there as well?

tcp4_gro_complete seems to mirror udp4_gro_receive in returning early
before setting up checksum offload. So likely yes.

The script I shared to reproduce for UDP can hopefully be reused
easily to also generate these packets with TCP.
 
> Thanks,
> 
> - Felix



