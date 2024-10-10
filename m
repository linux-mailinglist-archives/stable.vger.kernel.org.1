Return-Path: <stable+bounces-83356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820A59987C5
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 15:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02680B25163
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 13:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEB01C9DC5;
	Thu, 10 Oct 2024 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhnPDtr1"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D871A1C8FDB;
	Thu, 10 Oct 2024 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567115; cv=none; b=AfhEjq1yIPOVsFWGgfTpg7304aaVdpBuMrjaLz49jTtIj0nZxErmZT2WoSCfYfXAFhH2vEVYGwtyENj/viD94TRDqsAzYImq2Sw60gf5D6AuhaLVGlLKPcwLKAEjUSPSbPFwSal8Bt5kbwnPNiJhnxf+2Rr8tUQzGXp44WxTsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567115; c=relaxed/simple;
	bh=uo78NsS/9hNVQqiGO/gRroRrm8ShtpqYwObsnB//ZK8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dvSDKytfi5zyDW9WauW4kvqR6CFONNcuBiOYCptMQqW+DcoTuSyNXYw8k5wcS8XXlKKD1EE3w7As8ukUegkn4R8MjOsTfsZEISJSoXDFFGRSys7jGVi9V4rNQbtbKn92ojAkGlVbWnONZnn/NZj7zPqsWmudmbeWB9lZr6KWdwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhnPDtr1; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7afc591c69cso52961685a.0;
        Thu, 10 Oct 2024 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728567113; x=1729171913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gjAImBnPB7DxC5flp0bP9ev+AfLl8hjvcLE5d60LxE=;
        b=PhnPDtr1rI5aK/OYQjBYyIFAgxNs9HAPeHgYiGvlxQSo5LZMeTd1QHV0ddiBvebBNt
         RAPMffq5TEdbLdq5NGfBZza5/dDK03ELoSm1cOMWxsj+KoI9csCeH3KPc8KemweQlc8E
         pCr9aDLVJm3uv2O9ioH8G+vOTZMQE4DeAma9pK/XeO9Hpdd+mgc6ubQB4Q6gIq+X8hrB
         GIVg7TY/8vM7PM/lJ8P5A0MKB7wvKIzx7jC/HGdaxZ1rg1iiupN1xcNetBTedaJcWVu9
         oyJVuBN5Le0TE4IdMkemf9yQaBPjojK9KUAolKgp9FkqFipd6JgvEU7UxvXdDkXpADZA
         OBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728567113; x=1729171913;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4gjAImBnPB7DxC5flp0bP9ev+AfLl8hjvcLE5d60LxE=;
        b=UNvpBlUYcsUx8bjO2YP+BgVexIWaNLAnUhrbgkR7DyIuxJK64Rpx4KYV6lV13p0TR2
         MR8889nugb0QlvCsA1pLmUJ1Mn8AfucT7Ga/PizjNouXMsK0a0xM6hxCrEm/3Qu2HEL7
         +zZ1OcJOh7arOtvZri1d4h+kzXhy9D0jnpfi9u6Crrk65MV2HQ1PqnaaRWT0/0wcjmpB
         T4Vf+5Wth6Hr7j5O2LcoipyGUALMTWHQHqIhWQx4XwD1ddTwl9KBLsWb6u9FG5ctqJ/c
         1YjdFySx49xUhgP+b7ViFnD0hw0U7P84OR8ggP06GeplUb2a/f8Qvb3C7BXxBwjSu/gf
         1LGw==
X-Forwarded-Encrypted: i=1; AJvYcCUnZvO0weN3Hlf1QiulnSHZlET5OB/kBORvfMjzwIpzq5aABT4S8dt4wplMfxzFVW2QD+itIPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Eyz/7/K7LwGNhhOIUk4SaC2hsqatC8hzeDcqPtT+NnfChRXS
	wcm2cUvvj1xgLhCn12x/xEgIxXDG4dtsXW7x3HCs9uOw6qxkzPcW
X-Google-Smtp-Source: AGHT+IHNkvHF/8AUxmGltqYBU1GgbYtxjUKErGgvQ/50tcb/RwQWsdFD3VsUwYUXC+qKtFjdin3Wjg==
X-Received: by 2002:a05:620a:394d:b0:79e:fcb8:815c with SMTP id af79cd13be357-7b111d4edd7mr553048385a.54.1728567112596;
        Thu, 10 Oct 2024 06:31:52 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b114958016sm46512085a.81.2024.10.10.06.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:31:51 -0700 (PDT)
Date: Thu, 10 Oct 2024 09:31:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 kernel-team@cloudflare.com, 
 Ivan Babrou <ivan@cloudflare.com>, 
 stable@vger.kernel.org
Message-ID: <6707d74780461_2029212946a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241010-uso-swcsum-fixup-v1-1-a63fbd0a414c@cloudflare.com>
References: <20241010-uso-swcsum-fixup-v1-1-a63fbd0a414c@cloudflare.com>
Subject: Re: [PATCH net] udp: Compute L4 checksum as usual when not segmenting
 the skb
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> If:
> 
>   1) the user requested USO, but
>   2) there is not enough payload for GSO to kick in, and
>   3) the egress device doesn't offer checksum offload, then
> 
> we want to compute the L4 checksum in software early on.
> 
> In the case when we taking the GSO path, but it has been requested, the

What does it refers to here?

> software checksum fallback in skb_segment doesn't get a chance to compute
> the full checksum, if the egress device can't do it. As a result we end up
> sending UDP datagrams with only a partial checksum filled in, which the
> peer will discard.
> 
> Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no checksum offload")
> Reported-by: Ivan Babrou <ivan@cloudflare.com>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: stable@vger.kernel.org
> ---
> This shouldn't have fallen through the cracks. I clearly need to extend the
> net/udpgso selftests further to cover the whole TX path for software
> USO+csum case. I will follow up with that but I wanted to get the fix out
> in the meantime. Apologies for the oversight.
> ---
>  net/ipv4/udp.c | 4 +++-
>  net/ipv6/udp.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 8accbf4cb295..2849b273b131 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -951,8 +951,10 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
>  			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
>  			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
>  								 cork->gso_size);
> +
> +			/* Don't checksum the payload, skb will get segmented */
> +			goto csum_partial;
>  		}
> -		goto csum_partial;

The issue here is that GSO packets with CHECKSUM_NONE will get fixed
software checksummed in skb_segment, but no such fallback path is
entered for regular packets, right?

We could setup CHECKSUM_PARTIAL and rely on validate_xmit_skb. But
might as well do the software checksumming right here, as your
patch does.

If I follow this all, ACK from me. Just want to make sure.
>  	}
>  
>  	if (is_udplite)  				 /*     UDP-Lite      */
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 52dfbb2ff1a8..0cef8ae5d1ea 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1266,8 +1266,10 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
>  			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
>  			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
>  								 cork->gso_size);
> +
> +			/* Don't checksum the payload, skb will get segmented */
> +			goto csum_partial;
>  		}
> -		goto csum_partial;
>  	}
>  
>  	if (is_udplite)
> 



