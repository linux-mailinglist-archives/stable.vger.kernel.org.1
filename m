Return-Path: <stable+bounces-77769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C79986FD0
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 11:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E64D281833
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 09:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CF21A38E6;
	Thu, 26 Sep 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="rJqhRxg4"
X-Original-To: stable@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7F1537A8;
	Thu, 26 Sep 2024 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342267; cv=none; b=bW48aaqq5rRnH1KERbuu9k9vD/OgRHiqrsZWd+MSdp5BglYIhHCgpb1nXSq92k1IEH6HQwQ9b913dAfA3FnKSVbtD2l03iBrPkX32L4pBT7lqFWL5NpVVrYHltp/1JwdpTM5UBzMAT9y60M87QbhbGvjg95w+tRgnOkLqHJdR4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342267; c=relaxed/simple;
	bh=uWoviCagIDzNcaj6dcBu/83WgK6mT1q3axkyXVUhNqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eM1UYPyGClhACdKhYvtp1bJ48uaytKstneUn14Po/Y3y9vpAUs0R5SACbL7A+bH771uuBvkH88/ecgoNMNEpxw8RHoTeyx2h2R5TAV7Sfm7rl6eCxjleaYTfj4kiTXzoCA1bDh8C93iCVOj3iLFy2Qnn+LiZqoZTjARbDMxxn2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=rJqhRxg4; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jdh5APkkz5QJ+pHXD6WZ3pE5bjKYt07eMwQdL/qBTgs=; b=rJqhRxg47kcLNe2JU2A0i3vdyU
	fZL90CGOTcyC/4WT8MP2WqxCxOjKPKcV6P9TOiqvfGqRiW/qbG93AlUUQ4nfJiO8l7v45xgRYGEP1
	9QwHPXd49xLQUEzHQ+Cirum7vPXq8YGDy4iebwR6hBOSqkYqmCG9JKQ/yeifZjSWT5Zc=;
Received: from p4ff130c8.dip0.t-ipconnect.de ([79.241.48.200] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1stkcy-001K50-1F;
	Thu, 26 Sep 2024 11:17:36 +0200
Message-ID: <daf225a9-8194-40c6-b797-8ab37de773a0@nbd.name>
Date: Thu, 26 Sep 2024 11:17:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] gso: fix gso fraglist segmentation after pull from
 frag_list
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, stable@vger.kernel.org, maze@google.com,
 shiming.cheng@mediatek.com, daniel@iogearbox.net, lena.wang@mediatek.com,
 herbert@gondor.apana.org.au, Willem de Bruijn <willemb@google.com>
References: <20240922150450.3873767-1-willemdebruijn.kernel@gmail.com>
From: Felix Fietkau <nbd@nbd.name>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <20240922150450.3873767-1-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.09.24 17:03, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Detect gso fraglist skbs with corrupted geometry (see below) and
> pass these to skb_segment instead of skb_segment_list, as the first
> can segment them correctly.
> 
> Valid SKB_GSO_FRAGLIST skbs
> - consist of two or more segments
> - the head_skb holds the protocol headers plus first gso_size
> - one or more frag_list skbs hold exactly one segment
> - all but the last must be gso_size
> 
> Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
> modify these skbs, breaking these invariants.
> 
> In extreme cases they pull all data into skb linear. For UDP, this
> causes a NULL ptr deref in __udpv4_gso_segment_list_csum at
> udp_hdr(seg->next)->dest.
> 
> Detect invalid geometry due to pull, by checking head_skb size.
> Don't just drop, as this may blackhole a destination. Convert to be
> able to pass to regular skb_segment.
> 
> Link: https://lore.kernel.org/netdev/20240428142913.18666-1-shiming.cheng@mediatek.com/
> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Felix Fietkau <nbd@nbd.name>

