Return-Path: <stable+bounces-223379-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJmMLfYaq2lNaAEAu9opvQ
	(envelope-from <stable+bounces-223379-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 19:20:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4675A226A2B
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 19:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B6B030879F3
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 18:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE68421A07;
	Fri,  6 Mar 2026 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CYo8SjHl"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF703ECBE7
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772821223; cv=none; b=MCO3iUq9zSooPndHLQqcIkpRdL93a3v0oqQxeJvg+x3LdNGlQrAzbbEADKxnmujOoF4cmpIWXY+EnxeqOxqT0c6TQzTRhbSJyeoUKSqXPUbW9uap1Zw/i8bOQ0xQmVSjGdESnlQT3chvwPMkxys8Wwv5u9OSh45y7OoAiU53L4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772821223; c=relaxed/simple;
	bh=XoUdcp4sZ9u9yg4lARLdJdb4aYqyVRFrJzsGslmOESs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHI7NtQn79SeJETSYc5qYl8TAE0CS1uGTkSP++UQrmmRa43FsT7w/M2NA+7YvvE+gQlNTcpgJiJcw2LdSpUY+lY+LRa54+5mODAxfgA1zQ5Kh2oY1SXI1THKhigT3PGkf7z+N+uQVSZhRckcvYM0YvmOZ+khBNq6gFLnKTyoeGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CYo8SjHl; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4638a18efc2so6320878b6e.3
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 10:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772821220; x=1773426020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=39xArBXSs4Whdyj6F5WRF6OsnU4hIyo+O+UjLfGtF8w=;
        b=CYo8SjHlAy9kqTHyIOMpjcJ1oXM9PmxnsXgDID+AaEqCZq+M560l3Q2myzbChRboTH
         WCHq/+PHNtX8DLKnOwa2CBaW/12KV3tRMFROU51aE0ll7gaQI34wncEkmf+1TXfePrmC
         Z0ZEj/WlPje4GEt+Ak2Bbz6g3Mo6/CHZinIu8e0DGohppPocUzDf5J5XQXIif7T0tik0
         G60tqQocgETu6Sm10qwc63DMgIotTQwMnnUsB9HjfV4g7V4Vy9XuquY4Be5711RNbJBC
         7sjwXVngIfy0+nPrSm9BVfPwLs+N8++JVLH4Xl9gHD/Kt/OLtwqCgbzuIp50LtAB/pBf
         orxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772821220; x=1773426020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39xArBXSs4Whdyj6F5WRF6OsnU4hIyo+O+UjLfGtF8w=;
        b=Nd6kHsjs3u1206ZdhOz0EHMEdkQpSBXBbdNAK9Qnp2+1CB6wfQt/xnc8EN+xEerAm5
         2QAUMgZsuLEvkicNHtjpINZLZlgBQCiZ2RoPwO+DfrdNMzxfDlV+CxtpRF/QUXZumYYU
         P08QHtD/OVkLRKkk458NCknnmErOFXUZ6A25SknSlzhXXhdxXZ0/K/nCrybjvP9s8fYX
         x+ePSAGoM8Okqqi4pG8YqskD2PlJjctrzTliy9ibiQQnkKcna1+wXjjmBRf0nbjc/Rtc
         24RHY+VaRJgO+u+sUo9GUyBG8DTncQ+KRy1xaoeJymVW18nN6CHnGt4NMwKDB2Q29ELp
         55xg==
X-Forwarded-Encrypted: i=1; AJvYcCVRDHMB0i7DNj5i565CZobN33NSllnQIUFaE+ZoNWVO0Th3XlZOQGYFlHqWlv54Fgtm+D5Lrqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTQgtQb5aq7rLQ4IPdtW8ye3qiFF7qg5UW0UDrgZM9xvbk7Uty
	PACJC82EDcaqDtea+bxFSTYJkGnRbaGzTKCQXLecTqPixAklKZxTMLibuve+cBMaofYFiI7/6+v
	m4iTIbvgCLw==
X-Gm-Gg: ATEYQzw8dFO+qY8jOXG6hu63vqCTWyi3xKqfgJAsOzcCcUU6ybgrQ6T6BItJ9djeNpa
	0X8Qg7F60ToA/D7/bPHv3H9XmpksE6s3tcZrCtzJA/fflVHbCy+rJewSQwc9uwzDTWdFw9mbu1s
	c8Fc0q2scAoZAERJnKNHFqTEA111cmTyWnjB/+zQnzFUuL/Pxj70S1oferH1guonnlAzXeAZ7A3
	17lA0lUi1AiXD8sG7bx12kcDVHcQkyIwd1FnMffRvbjIAvwgxSGZScwqyFlKkuFwK9Aglyhp5zi
	SdFz4assc3oWMU44qPBdWDaEkZiLIGRdkzOn9Ww0EM97g+kfelFe9Thw8Lfpu9geOoX0QHITPPD
	LT0AtzwoDF/qsQfuUpr6tDEd9RXN+qU9GD1FNmON4c/F03ctnlx4xyxp0m/aFmzoNSFR2E88kC5
	PGMSayTg==
X-Received: by 2002:a05:6808:1641:b0:45c:8675:eef1 with SMTP id 5614622812f47-466dca16637mr1603487b6e.3.1772821219577;
        Fri, 06 Mar 2026 10:20:19 -0800 (PST)
Received: from 20HS2G4 ([2a09:bac1:76c0:540::3ce:23])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfac17b3sm1112878b6e.14.2026.03.06.10.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 10:20:18 -0800 (PST)
Date: Fri, 6 Mar 2026 12:20:16 -0600
From: Chris Arges <carges@cloudflare.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lwn@lwn.net,
	jslaby@suse.cz, kernel-team@cloudflare.com,
	netfilter-devel@vger.kernel.org
Subject: Re: [REGRESSION] 6.18.14 netfilter/nftables consumes way more memory
Message-ID: <aasa4AV5p7TFxNmj@20HS2G4>
References: <aahw_h5DdmYZeeqw@20HS2G4>
 <aaijcrM5Ke5-Zabx@chamomile>
 <aaij0XAgYRN40QdD@chamomile>
 <aamvQTTZu4-chpsS@20HS2G4>
 <aarHEfdMXDJ-Wq3V@chamomile>
 <aarHyHIQY0nS9d9K@chamomile>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aarHyHIQY0nS9d9K@chamomile>
X-Rspamd-Queue-Id: 4675A226A2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TAGGED_FROM(0.00)[bounces-223379-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.969];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2026-03-06 13:25:44, Pablo Neira Ayuso wrote:
<snip>
> > I see what is going on, my resize logic is not correct. This is
> > increasing the size for each new transaction, then the array is
> > getting larger and larger on each transaction update.
> > 
> > Could you please give a try to this patch?
> 
> Scratch that.
> 
> Please, give a try to this patch.
> 
> Thanks.

Pablo,

Thanks, I'm getting this set up on a few machines. I will have:
- 6.18.15 (original kernel version that repo'd the issue for us)
- 6.18.15 + this patch
- 6.18.15 + revert rbtree patchseries

I'll compare memory usage with those 3 variants and give a response.

--chris
> diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
> index 853ff30a208c..cffeb6f5c532 100644
> --- a/net/netfilter/nft_set_rbtree.c
> +++ b/net/netfilter/nft_set_rbtree.c
> @@ -646,7 +646,7 @@ static int nft_array_may_resize(const struct nft_set *set)
>  	struct nft_array *array;
>  
>  	if (!priv->array_next) {
> -		array = nft_array_alloc(nelems + NFT_ARRAY_EXTRA_SIZE);
> +		array = nft_array_alloc(priv->array->max_intervals);
>  		if (!array)
>  			return -ENOMEM;
>  


