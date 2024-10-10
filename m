Return-Path: <stable+bounces-83359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF6F99888E
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 16:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7930A287EFC
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 14:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B881C9B8A;
	Thu, 10 Oct 2024 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BbyEINIG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9515A1BDA90
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568836; cv=none; b=TQDT1sTyt6ElkSIVx2ZcoGLGD9+dPGDGP6YZOpP4MlBZj9BbXv2+vSlMLBFCXYvyTSHLlwU+EhKCsHo3cPVLppvSPkeN2LMQM15THdiOjnyZ+DTZD7tg5uoQr4FIvLNdCMwuvBnzsrQ1+BvWhzoN3AKDPS+AjRITQ88Q63+Iers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568836; c=relaxed/simple;
	bh=gLAM8r7qE6CVz5omgjNonixJXLEHbVuzzGOxsgzhh7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VBtBQQxNTvE2EZGsdPBzDdeI6Z0tRCgvj8TWzG4NLGRAVIVYqxY0cNEZ7VAZlA1O1EJzCOA3GH3hAAnJjny8mvJBpLZkGNWqm5q9Te+3hBJEuk49wqBlWpPt7OqDd1F8rdyqeXvgTR8+fWZgaJ2OLX/GkWqE8EkH1+xVwjKnYn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BbyEINIG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a993f6916daso165696966b.1
        for <stable@vger.kernel.org>; Thu, 10 Oct 2024 07:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728568833; x=1729173633; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vccuKvc83Vv38bDulBNrWqwQbq60HXVP3Eb0biFBOnw=;
        b=BbyEINIGu+fnzmFLEHeLC7f0J4DAFHB85jQTGnAxMdaCdpU9+nFJ2NDGwBl/i7WNeZ
         GP8rMF+Xafe3x0XfRWS0M4230C8j0SZ/3YMA3AP0H6AhRURuqjvUCHxIibFwi8dAAsuC
         m4WrgPK8RAKbFewkzrXmJbkypcN2Fx2qK6miKliTzWKUGg4GmCt3g3IKEWoJ2cW1Xsds
         LJ5dsnl6iXWnYPZLENik/61Nle2aQafr5AzngpNTBz/tjrA6Vh4Ghez5abLhT1a5gi0I
         WyX5gn7gkL+bl3LR/wcOerN4sJkPErqwh/BVHXSCuohulVJum22B68zHKUhMrtganCb+
         C9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568833; x=1729173633;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vccuKvc83Vv38bDulBNrWqwQbq60HXVP3Eb0biFBOnw=;
        b=S9NUzxDLkNsCvx8AEwqjkmKwp6JDX38ZAYSr1kWsQI2jUBM7mqdLSmBrTr6w5xC/QB
         tcRHd49y5rmFCeUH4kMtkqZlsjlxaEsb2PQkrFJRuNsr3nwLYKFz8RMoDsBK/TbOK51h
         zaHsXE70ZE+Kts+XrpxJMNio+u1O6AhmNR8ln/c2dBeUXqgzacvRgS+KVB01qLOMTAcJ
         ixCFGRSjkIf3EtAZPG3/EXARZ3f4YnJoTXoiwyiaTMvUzrUf9iEs/HsfU0FqCCKlWtFE
         As+hT+2yM7UQnQfEKRN9zJYvtsN/yZfTkSaZTiY6TZLwcaCaV5yxZYCoMkG9lUXRxAPG
         4LzA==
X-Forwarded-Encrypted: i=1; AJvYcCWxTFL8giJHposwcwpSz/dykxJsgRuPFLSEdi9oPgqb6f4ZQ2Cy+FdfnlStjEP8vrnnubCN/vk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybz7pxsZhrl96Q7g5DhECxWFmctGe/SokCM9rlLcprRwjMgYW6
	68EokNcmF9RVsa01vdLsBD+pCX8Fm4C7LeEe3XOrr6CBKO9QGyV6m8SsxBxAZ48=
X-Google-Smtp-Source: AGHT+IHs66jsGVsDIa6nU/GDZDjyrTOMBCVIgq4sUT8APnQVeWzsXntFRqDIlxWQ12IMQaG/q8PPxw==
X-Received: by 2002:a17:907:9483:b0:a99:5601:7dc1 with SMTP id a640c23a62f3a-a998d327bb2mr546038066b.49.1728568831155;
        Thu, 10 Oct 2024 07:00:31 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506b:2dc::49:1d6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dca54sm91345866b.159.2024.10.10.07.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 07:00:30 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,  David Ahern
 <dsahern@kernel.org>,  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  kernel-team@cloudflare.com,  Ivan Babrou
 <ivan@cloudflare.com>,  stable@vger.kernel.org
Subject: Re: [PATCH net] udp: Compute L4 checksum as usual when not
 segmenting the skb
In-Reply-To: <6707d74780461_2029212946a@willemb.c.googlers.com.notmuch>
	(Willem de Bruijn's message of "Thu, 10 Oct 2024 09:31:51 -0400")
References: <20241010-uso-swcsum-fixup-v1-1-a63fbd0a414c@cloudflare.com>
	<6707d74780461_2029212946a@willemb.c.googlers.com.notmuch>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Thu, 10 Oct 2024 16:00:28 +0200
Message-ID: <87ttdkxdkz.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 10, 2024 at 09:31 AM -04, Willem de Bruijn wrote:
> Jakub Sitnicki wrote:
>> If:
>> 
>>   1) the user requested USO, but
>>   2) there is not enough payload for GSO to kick in, and
>>   3) the egress device doesn't offer checksum offload, then
>> 
>> we want to compute the L4 checksum in software early on.
>> 
>> In the case when we taking the GSO path, but it has been requested, the
>
> What does it refers to here?

That's a typo there. Will fix. It should have said:

  In the case when we *not* taking the GSO path, but it has been
  requested, ...

Pseudo code-wise something like:

  s.setsockopt(SOL_UDP, UDP_SEGMENT, 1200)
  s.sendto(b"x", ("192.0.2.1", 9))


>> software checksum fallback in skb_segment doesn't get a chance to compute
>> the full checksum, if the egress device can't do it. As a result we end up
>> sending UDP datagrams with only a partial checksum filled in, which the
>> peer will discard.
>> 
>> Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no checksum offload")
>> Reported-by: Ivan Babrou <ivan@cloudflare.com>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> Cc: stable@vger.kernel.org
>> ---
>> This shouldn't have fallen through the cracks. I clearly need to extend the
>> net/udpgso selftests further to cover the whole TX path for software
>> USO+csum case. I will follow up with that but I wanted to get the fix out
>> in the meantime. Apologies for the oversight.
>> ---
>>  net/ipv4/udp.c | 4 +++-
>>  net/ipv6/udp.c | 4 +++-
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>> 
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index 8accbf4cb295..2849b273b131 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -951,8 +951,10 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
>>  			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
>>  			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
>>  								 cork->gso_size);
>> +
>> +			/* Don't checksum the payload, skb will get segmented */
>> +			goto csum_partial;
>>  		}
>> -		goto csum_partial;
>
> The issue here is that GSO packets with CHECKSUM_NONE will get fixed
> software checksummed in skb_segment, but no such fallback path is
> entered for regular packets, right?
>
> We could setup CHECKSUM_PARTIAL and rely on validate_xmit_skb. But
> might as well do the software checksumming right here, as your
> patch does.

Yes, all correct.

To add to it - I figured that marking the skb with CHECKSUM_PARTIAL,
when device doesn't offer csum offload, would be more confusing.

>
> If I follow this all, ACK from me. Just want to make sure.

Thanks. I will carry it in v2.

Will wait a bit before respinning it.
Maybe Ivan can get a chance to this patch.

>>  	}
>>  
>>  	if (is_udplite)  				 /*     UDP-Lite      */
>> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
>> index 52dfbb2ff1a8..0cef8ae5d1ea 100644
>> --- a/net/ipv6/udp.c
>> +++ b/net/ipv6/udp.c
>> @@ -1266,8 +1266,10 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
>>  			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
>>  			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
>>  								 cork->gso_size);
>> +
>> +			/* Don't checksum the payload, skb will get segmented */
>> +			goto csum_partial;
>>  		}
>> -		goto csum_partial;
>>  	}
>>  
>>  	if (is_udplite)
>> 

