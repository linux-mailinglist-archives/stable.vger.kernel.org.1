Return-Path: <stable+bounces-75868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3AA97584D
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 18:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F621F2124D
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8A51AE876;
	Wed, 11 Sep 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsBGly/s"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D3A1AE058
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071901; cv=none; b=UlzmPaGM0Qv4GFRaLHKS5RmAwEuSDozmiFiE89eX1SI9fRYjDAseBrm8ifeEsfMR3uas3RycPA6mKTcmDOojGvRuIV3cZJATIpFQhRBG4hx/x6FgKZ/n7e5rAIDFf824MPwTNK1doERukAsZVtiPG9m7iaFd/qgVmbr+T/aoLtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071901; c=relaxed/simple;
	bh=1bcQW7c1jxdlfBunQ6YWyGYMwuwT68C1Dp4B2rFeirs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tz0Y+p+cUNPgIIkgiPrV/faRV54Bd2EmwnOSl63CpSQn9eWrOzFKebsNt5n0HkLFFzehxlLeZ2yeMzgrElmS27+YVEbQZ6WTW7ehmsuwCFyUeG8EYDABk0B4tBAmSc2/2aAkebwrV5wSMs+p5nnVNICNiCOCQsgWGlpxDicrhdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JsBGly/s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726071898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPuIsJ7LH/NryQa0KHKubTcC5NBQjBwl3HztcdDab5w=;
	b=JsBGly/sa/jNAApO/gyHOID2EsyBEo6MSf/zJbRnJpyjuBUYdRWsyKvF6SVERhzkRHIf4C
	Ai3L9o2p5+3fbQBcAXAkwZU47pgrn6d52oiMVsuoFxgbDKukBj3q/aEI45E9vg7miPUT99
	/c4n1rbq9rFzeYtSNWuAuogCE+KsSpw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-h265suXRN9ayCQeN5LNYyA-1; Wed, 11 Sep 2024 12:24:57 -0400
X-MC-Unique: h265suXRN9ayCQeN5LNYyA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5356aaecdf6so7291463e87.2
        for <stable@vger.kernel.org>; Wed, 11 Sep 2024 09:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726071896; x=1726676696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPuIsJ7LH/NryQa0KHKubTcC5NBQjBwl3HztcdDab5w=;
        b=vSGt9IjL7xKV2KGsDoJOPzwEgdGF2B0/8XCfjkT6CvdRA4LW58PMjoRnV/bfFMW5hK
         fPlE1lnzfjp7b5NEyMP8oMEOKzo/8mLuOWXkqQF4ibvYzyWNvXRyYX3RpyyNhsKp41U4
         9W0dkrhPZ27J4Vbo9JVJmlgMoC8MKEGCPZokuFP3+3tBMoHfV0qi5rmtX+ME6pZu1N8+
         hHpBscZSRtQTL70LCMh4lEu7twgzAzMRssbzgXEwYn62XTUqV1Veh1RbWJozovf1Fs7V
         2Q+qEhKfNEzv8wC96qun82KvDW9U0G5rk4bQ3t7THofr6E7izTg3aY2HK/2p7buhs2KG
         z2zA==
X-Forwarded-Encrypted: i=1; AJvYcCUZPY20yb48v98eaD3qCqkqLO5UQBf5KARcePWCNCQYsWwi7hPiS7eBQ19nZwsukUC1Qxfhpzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3TYIgXwNzrX5iVomhY9QV7vhSc26loGNq1BBmvY/wctfEvuV/
	FnB7fozjQjZWlZfqlLcaTDyMeqJu9/781ATU7q9ke3wOha0f9NbwgmsBLhXkO9QLSr99EfDuCfq
	Auz+IRZQty2YSIJuiqNOA9DzsSPQm7zeQCfnj+Z0dP1ZV3qGiTRvicQ==
X-Received: by 2002:a05:6512:1283:b0:52c:e0fb:92c0 with SMTP id 2adb3069b0e04-536587c8177mr12892264e87.34.1726071895994;
        Wed, 11 Sep 2024 09:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG/2rhUxgQSM96b6JP5Itt5QRcGCTl4PERNI00A/LttGPDuJaR7APim2eBySdgsSLLCiwQCw==
X-Received: by 2002:a05:6512:1283:b0:52c:e0fb:92c0 with SMTP id 2adb3069b0e04-536587c8177mr12892232e87.34.1726071895341;
        Wed, 11 Sep 2024 09:24:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d3597asm629355766b.186.2024.09.11.09.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 09:24:54 -0700 (PDT)
Message-ID: <181dec64-5906-4cdd-bb29-40bc7c02d63e@redhat.com>
Date: Wed, 11 Sep 2024 18:24:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 6.11] minmax: reduce egregious min/max macro
 expansion
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Narron <richard@aaazen.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Arnd Bergmann <arnd@kernel.org>,
 Linus Torvalds <torvalds@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-mm@kvack.org, stable@vger.kernel.org
References: <20240911153457.1005227-1-lorenzo.stoakes@oracle.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240911153457.1005227-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lorenzo,

On 9/11/24 5:34 PM, Lorenzo Stoakes wrote:
> Avoid nested min()/max() which results in egregious macro expansion.
> 
> This issue was introduced by commit 867046cc7027 ("minmax: relax check to
> allow comparison between unsigned arguments and signed constants") [2].
> 
> Work has been done to address the issue of egregious min()/max() macro
> expansion in commit 22f546873149 ("minmax: improve macro expansion and type
> checking") and related, however it appears that some issues remain on more
> tightly constrained systems.
> 
> Adjust a few known-bad cases of deeply nested macros to avoid doing so to
> mitigate this. Porting the patch first proposed in [1] to Linus's tree.
> 
> Running an allmodconfig build using the methodology described in [2] we
> observe a 35 MiB reduction in generated code.
> 
> The difference is much more significant prior to recent minmax fixes which
> were not backported. As per [1] prior these the reduction is more like 200
> MiB.
> 
> This resolves an issue with slackware 15.0 32-bit compilation as reported
> by Richard Narron.
> 
> Presumably the min/max fixups would be difficult to backport, this patch
> should be easier and fix's Richard's problem in 5.15.
> 
> [0]:https://lore.kernel.org/all/b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com/
> [1]:https://lore.kernel.org/lkml/5882b96e-1287-4390-8174-3316d39038ef@lucifer.local/
> [2]:https://lore.kernel.org/linux-mm/36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local/
> 
> Reported-by: Richard Narron <richard@aaazen.com>
> Closes: https://lore.kernel.org/all/4a5321bd-b1f-1832-f0c-cea8694dc5aa@aaazen.com/
> Fixes: 867046cc7027 ("minmax: relax check to allow comparison between unsigned arguments and signed constants")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thank you for your patch.

I must say that I'm not a fan of that this is patching 3 totally
unrelated files here in a single patch.

This is e.g. going to be a problem if we need to revert one of
the changes because of regressions...

So I would prefer this to be split into 3 patches.

One review comment for the atomisp bits inline / below.

> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  2 +-
>  .../staging/media/atomisp/pci/sh_css_frac.h   | 26 ++++++++++++++-----
>  include/linux/skbuff.h                        |  6 ++++-
>  3 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> index e809f91c08fb..8b431f90efc3 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> @@ -23,7 +23,7 @@
>  /* The PacketOffset field is measured in units of 32 bytes and is 3 bits wide,
>   * so the maximum offset is 7 * 32 = 224
>   */
> -#define MVPP2_SKB_HEADROOM	min(max(XDP_PACKET_HEADROOM, NET_SKB_PAD), 224)
> +#define MVPP2_SKB_HEADROOM	clamp_t(int, XDP_PACKET_HEADROOM, NET_SKB_PAD, 224)
> 
>  #define MVPP2_XDP_PASS		0
>  #define MVPP2_XDP_DROPPED	BIT(0)
> diff --git a/drivers/staging/media/atomisp/pci/sh_css_frac.h b/drivers/staging/media/atomisp/pci/sh_css_frac.h
> index b90b5b330dfa..a973394c5bc0 100644
> --- a/drivers/staging/media/atomisp/pci/sh_css_frac.h
> +++ b/drivers/staging/media/atomisp/pci/sh_css_frac.h
> @@ -32,12 +32,24 @@
>  #define uISP_VAL_MAX		      ((unsigned int)((1 << uISP_REG_BIT) - 1))
> 
>  /* a:fraction bits for 16bit precision, b:fraction bits for ISP precision */
> -#define sDIGIT_FITTING(v, a, b) \
> -	min_t(int, max_t(int, (((v) >> sSHIFT) >> max(sFRACTION_BITS_FITTING(a) - (b), 0)), \
> -	  sISP_VAL_MIN), sISP_VAL_MAX)
> -#define uDIGIT_FITTING(v, a, b) \
> -	min((unsigned int)max((unsigned)(((v) >> uSHIFT) \
> -	>> max((int)(uFRACTION_BITS_FITTING(a) - (b)), 0)), \
> -	  uISP_VAL_MIN), uISP_VAL_MAX)
> +static inline int sDIGIT_FITTING(short v, int a, int b)
> +{

drivers/staging/media/atomisp/pci/isp/kernels/s3a/s3a_1.0/ia_css_s3a.host.c

calls this with ia_css_3a_config.af_fir1_coef / .af_fir2_coef
as first argument those are of the ia_css_s0_15 type which is:

/* Signed fixed point value, 0 integer bits, 15 fractional bits */
typedef s32 ia_css_s0_15;

please replace the "short v" with "int v" 

I think that you can then also replace clamp_t() with clamp()


> +	int fit_shift = sFRACTION_BITS_FITTING(a) - b;
> +
> +	v >>= sSHIFT;
> +	v >>= fit_shift > 0 ? fit_shift : 0;
> +
> +	return clamp_t(int, v, sISP_VAL_MIN, sISP_VAL_MAX);
> +}
> +
> +static inline unsigned int uDIGIT_FITTING(unsigned int v, int a, int b)
> +{
> +	int fit_shift = uFRACTION_BITS_FITTING(a) - b;
> +
> +	v >>= uSHIFT;
> +	v >>= fit_shift > 0 ? fit_shift : 0;
> +
> +	return clamp_t(unsigned int, v, uISP_VAL_MIN, uISP_VAL_MAX);
> +}

Regular clamp() should work here ? all parameters are already
unsigned ints.

Regards,

Hans




> 
>  #endif /* __SH_CSS_FRAC_H */
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 29c3ea5b6e93..d53b296df504 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3164,7 +3164,11 @@ static inline int pskb_network_may_pull(struct sk_buff *skb, unsigned int len)
>   * NET_IP_ALIGN(2) + ethernet_header(14) + IP_header(20/40) + ports(8)
>   */
>  #ifndef NET_SKB_PAD
> -#define NET_SKB_PAD	max(32, L1_CACHE_BYTES)
> +#if L1_CACHE_BYTES < 32
> +#define NET_SKB_PAD	32
> +#else
> +#define NET_SKB_PAD	L1_CACHE_BYTES
> +#endif
>  #endif
> 
>  int ___pskb_trim(struct sk_buff *skb, unsigned int len);
> --
> 2.46.0
> 


