Return-Path: <stable+bounces-200937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B78CB98FE
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 19:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75CD230A3028
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 18:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F9630217B;
	Fri, 12 Dec 2025 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="BvXsH93X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD3230215C
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765563868; cv=none; b=MnAamNZ/hEKTXGodU8Nr0Gwn/DowAgD7RhWXH/Ekj3v/MtMURd51f7hiuDLjk2SsGO2UAvw/QOiuYFBVM+19E5nZQ9I9775FOo3R9Dpo+PDfoNBZhBQANp6oKlMBALy/dYH3Xr6QD6ycakMmSE6VQ8+WY2cFLI0A0FfXmaVNo2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765563868; c=relaxed/simple;
	bh=hDCn04wMFczg2ZKEtyKI65dUdL8Yy8DTr2U9MbionXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STAUFW6hBkyVOiftBJSzOmPxIXdqDcAWZindboApr3g2mXyjDifxkOp1xSAZr4RkTjSeUx6BW5JroTKNhqbdkjw8Ctl0MPVFlPJggaosO1F9zgoC50WwkWESniAeaWHHxevPm32FJbGA77cmi1kamdRXiKTHCWJgL8k9k++Dkic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=BvXsH93X; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-953a8a3ca9; t=1765563864;
 bh=QWy3lytTR7D0TLdcSjtSydcSonNRc5eH+V2CcyhEwkI=;
 b=BvXsH93X547IL2JWLCuLe3vgPPDy4OIP0u7bS3wbyVTEMfmibqC/0lQ3mNCsGpT7O876kqV86
 SHKnoJ3GrIP2c5zJ198JHaf51eGTVApSDBVpZYnzHNqducd9datIATdzOo6RGn+2TbSI0+EVVQf
 Fpid8ruy2aakXMe9Pb5TRaFzY3JCEe6awKidfi+y+BOdXpmkSQR9Ky+j2bcHiZ9fBglfbl4Uqs0
 KaBXhW75ibz2gOh5MIBmFfk/7F0ksJzpURhrtxRdq7a8oSqFbm0e4jDhUFQ2EX/7hADxOl/PMk5
 6y7wNMS9TLJWCieSrl3xle/bSgRAb4hblR5kWyP5r95Q==
X-Forward-Email-ID: 693c5dd3fd4b94c0e94eabae
X-Forward-Email-Sender: rfc822; fnordahl@ubuntu.com, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.6.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <04d484b3-de7a-414a-9389-a19fac0e0daf@ubuntu.com>
Date: Fri, 12 Dec 2025 19:24:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erspan: Initialize options_len before referencing
 options.
To: "Creeley, Brett" <bcreeley@amd.com>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Gal Pressman <gal@nvidia.com>,
 Kees Cook <kees@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org
References: <20251212073202.13153-1-fnordahl@ubuntu.com>
 <uCkgTf4IONTdT-df6jpwHmRGTBaYtp2vrLaQWzL7kfPxpJrvZarTkx6oNdnYWzNVnDmlNUVpd3iYO36CEYx7Dw==@protonmail.internalid>
 <1735c1c0-e731-4fec-83b1-818012194fc8@amd.com>
Content-Language: en-US
From: Frode Nordahl <fnordahl@ubuntu.com>
In-Reply-To: <1735c1c0-e731-4fec-83b1-818012194fc8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/25 18:23, Creeley, Brett wrote:
> 
> On 12/11/2025 11:32 PM, Frode Nordahl wrote:
>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>
>> The struct ip_tunnel_info has a flexible array member named
>> options that is protected by a counted_by(options_len)
>> attribute.
>>
>> The compiler will use this information to enforce runtime bounds
>> checking deployed by FORTIFY_SOURCE string helpers.
>>
>> As laid out in the GCC documentation, the counter must be
>> initialized before the first reference to the flexible array
>> member.
>>
>> In the normal case the ip_tunnel_info_opts_set() helper is used
>> which would initialize options_len properly, however in the GRE
>> ERSPAN code a partial update is done, preventing the use of the
>> helper function.
>>
>> Before this change the handling of ERSPAN traffic in GRE tunnels
>> would cause a kernel panic when the kernel is compiled with
>> GCC 15+ and having FORTIFY_SOURCE configured:
>>
>> memcpy: detected buffer overflow: 4 byte write of buffer size 0
>>
>> Call Trace:
>>    <IRQ>
>>    __fortify_panic+0xd/0xf
>>    erspan_rcv.cold+0x68/0x83
>>    ? ip_route_input_slow+0x816/0x9d0
>>    gre_rcv+0x1b2/0x1c0
>>    gre_rcv+0x8e/0x100
>>    ? raw_v4_input+0x2a0/0x2b0
>>    ip_protocol_deliver_rcu+0x1ea/0x210
>>    ip_local_deliver_finish+0x86/0x110
>>    ip_local_deliver+0x65/0x110
>>    ? ip_rcv_finish_core+0xd6/0x360
>>    ip_rcv+0x186/0x1a0
>>
>> Link: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-counted_005fby-variable-attribute
>> Reported-at: https://launchpad.net/bugs/2129580
>> Fixes: bb5e62f2d547 ("net: Add options as a flexible array to struct ip_tunnel_info")
> 
> Should this be [PATCH net]?
> 
> It seems like this should be intended for the net tree.

Indeed, thank you for pointing it out!

>> Signed-off-by: Frode Nordahl <fnordahl@ubuntu.com>
>> ---
>>    net/ipv4/ip_gre.c  | 18 ++++++++++++++++--
>>    net/ipv6/ip6_gre.c | 18 ++++++++++++++++--
>>    2 files changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
>> index 761a53c6a89a..285a656c9e41 100644
>> --- a/net/ipv4/ip_gre.c
>> +++ b/net/ipv4/ip_gre.c
>> @@ -330,6 +330,22 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
>>                           if (!tun_dst)
>>                                   return PACKET_REJECT;
>>
>> +                       /* The struct ip_tunnel_info has a flexible array member named
>> +                        * options that is protected by a counted_by(options_len)
>> +                        * attribute.
>> +                        *
>> +                        * The compiler will use this information to enforce runtime bounds
>> +                        * checking deployed by FORTIFY_SOURCE string helpers.
>> +                        *
>> +                        * As laid out in the GCC documentation, the counter must be
>> +                        * initialized before the first reference to the flexible array
>> +                        * member.
>> +                        *
>> +                        * Link: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-counted_005fby-variable-attribute
> 
> Nit, but I wonder if the Link in the commit message is good enough? Same
> comment below.

Yes, in retrospect the comments and links in-line became a bit too 
verbose, I'll trim them down in the next iteration.

> Thanks,

Thank you for taking the time to review, much appreciated!

-- 
Frode Nordahl

> Brett
> 
>> +                        */
>> +                       info = &tun_dst->u.tun_info;
>> +                       info->options_len = sizeof(*md);
>> +
>>                           /* skb can be uncloned in __iptunnel_pull_header, so
>>                            * old pkt_md is no longer valid and we need to reset
>>                            * it
>> @@ -344,10 +360,8 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
>>                           memcpy(md2, pkt_md, ver == 1 ? ERSPAN_V1_MDSIZE :
>>                                                          ERSPAN_V2_MDSIZE);
>>
>> -                       info = &tun_dst->u.tun_info;
>>                           __set_bit(IP_TUNNEL_ERSPAN_OPT_BIT,
>>                                     info->key.tun_flags);
>> -                       info->options_len = sizeof(*md);
>>                   }
>>
>>                   skb_reset_mac_header(skb);
>> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
>> index c82a75510c0e..eb840a11b93b 100644
>> --- a/net/ipv6/ip6_gre.c
>> +++ b/net/ipv6/ip6_gre.c
>> @@ -535,6 +535,22 @@ static int ip6erspan_rcv(struct sk_buff *skb,
>>                           if (!tun_dst)
>>                                   return PACKET_REJECT;
>>
>> +                       /* The struct ip_tunnel_info has a flexible array member named
>> +                        * options that is protected by a counted_by(options_len)
>> +                        * attribute.
>> +                        *
>> +                        * The compiler will use this information to enforce runtime bounds
>> +                        * checking deployed by FORTIFY_SOURCE string helpers.
>> +                        *
>> +                        * As laid out in the GCC documentation, the counter must be
>> +                        * initialized before the first reference to the flexible array
>> +                        * member.
>> +                        *
>> +                        * Link: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-counted_005fby-variable-attribute
>> +                        */
>> +                       info = &tun_dst->u.tun_info;
>> +                       info->options_len = sizeof(*md);
>> +
>>                           /* skb can be uncloned in __iptunnel_pull_header, so
>>                            * old pkt_md is no longer valid and we need to reset
>>                            * it
>> @@ -543,7 +559,6 @@ static int ip6erspan_rcv(struct sk_buff *skb,
>>                                skb_network_header_len(skb);
>>                           pkt_md = (struct erspan_metadata *)(gh + gre_hdr_len +
>>                                                               sizeof(*ershdr));
>> -                       info = &tun_dst->u.tun_info;
>>                           md = ip_tunnel_info_opts(info);
>>                           md->version = ver;
>>                           md2 = &md->u.md2;
>> @@ -551,7 +566,6 @@ static int ip6erspan_rcv(struct sk_buff *skb,
>>                                                          ERSPAN_V2_MDSIZE);
>>                           __set_bit(IP_TUNNEL_ERSPAN_OPT_BIT,
>>                                     info->key.tun_flags);
>> -                       info->options_len = sizeof(*md);
>>
>>                           ip6_tnl_rcv(tunnel, skb, tpi, tun_dst, log_ecn_error);
>>
>> --
>> 2.43.0
>>
>>




