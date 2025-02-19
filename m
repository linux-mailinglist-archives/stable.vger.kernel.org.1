Return-Path: <stable+bounces-118271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C13A3BFB9
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 14:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF261693E1
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 13:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBD91E0086;
	Wed, 19 Feb 2025 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="gWEoe6AY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BBF1DE4F1
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971278; cv=none; b=EO9o/J5Lnm6tkq+Rzaf61lTqzy2yHfLS0CutHjRyMB2yRK11Mz4G5RTwQH4c8Gxr7kh0ejVqJsz50o88ek09H9I2ddCj4AKQZFoV+ES3Q9h7SgztqIWar7hRzDB/hCROlMP6XRHPCH4PPKRXJJ4ByAzJPVLBCaC5ueRTXY4fqFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971278; c=relaxed/simple;
	bh=Ficnt9p1XoQNXuUvqH9vuTMR3Kc5HjcrIAtQm1cqV38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ib2JtcwpQVNEji/HyEw0LKXwHHzBqIaGNVRqdd5YXrku1tvAfbIt9tXWg7g7kdp1VwmdNaJm93us0E3KGhbrV65tRhpayr7HMs8ILL0t8ffCVMgfri6S4wRxjpTtOxj3mzHmMVetvJWQu3zrF3xIRWnbXqR59SABDQYI02/LkKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=gWEoe6AY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43987d046caso4140345e9.0
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 05:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1739971275; x=1740576075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EtzElTgy1YZbJruKey1VM89hhHEr6p8Axm5LWok8UW8=;
        b=gWEoe6AYcyyBFIlQHde9C+QN9zIAsdyLcI2pf79/ppLerLJBecl37uiQeHX3vww2XS
         35iOW+emmC/e89s4Mgl409my2BPTDkJ5er8Qqp6e4OqPheT8yjaJCpnbJ0V0H0O/tVBN
         f8ZPdO7MazBivCW8mfVsjS28MLiLM1sieBGaPFHKw+LdDnlIEWJ4OCHlEPZ9huooYsB3
         pDtA+2e+aeY2VWcIK3ltgDCm4NSRgXs4pHSzdtDAKvtat0B6m0lyDZkwhcrnrYQtowOq
         0+vKeuqEB+8R/xi4fzUaOgXRAG8oGm1srSPxR6onyxqMLCwP68l7G5U+GXLb6uzNDE5w
         LNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739971275; x=1740576075;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtzElTgy1YZbJruKey1VM89hhHEr6p8Axm5LWok8UW8=;
        b=h9D1MJ8eC2wznT2c1g5WuF0iH/w70m2NpTdxhhPvn9I1e7BDamMZWmEq03Ok41XebQ
         d5BcdHATxysJkEgjiNKH1PVUFPs5MIFWWpYmc9LM6q/P6opPGotjFnynycHgPEDn7vqy
         MJ14mBICCkNh7uWXZS31jTr4LubIOggALP6J90uUcqT54M1NHSfL68oeGlDnA0hzu6B1
         BdmIlO6t3VDlYJXt3BLK607UiMzO0LsHR3XhemAsCRJ14J5yB0fbl8RhPtIWY2biPQJG
         qQTdhyDXerBpHKnFewufPTcZD5rrF1OgIXaTCEqTsfyQU6EM7lEFOTaxMfOlRr45WBBr
         EmJw==
X-Forwarded-Encrypted: i=1; AJvYcCUF3yHP9fwpTH3pM5n+lZnT0CAPcbYc5e1JozD9O42cnMbH5MDh7BFHsEur1iXiLVPw1pI5Etg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ/GkxbAQS2aTbQqdqWWfoKHQYRFhHXssmMmU2CMdrjnckbUJt
	o0VwmOKph0L3fHgn5/d6Wo3NASYoANW1efEEM3Jczi47BRu/ipy3RS89MwKMYEg=
X-Gm-Gg: ASbGncuVLw/TmEfBjM0t7L1VNipA++1QfyPwhFQKphNd7vl1quBPL95CpyosmfJjL7M
	/G4dXWSx7E3YoaiO00Yfx/z8GIlM9E0sNZA8PAljwvS8G+aylNBfa+MD9Fh3Y1HzN7Qrs34d6FA
	2DoRAi7bCN2MqsMFQYgAuJLWbLOrocNGlKZ9fxsGVdYVUFIeyYq6Zmia5PZkhQ7zLacQcifnmqB
	duJCRfuXKkp0Hdy5WvyTwG6PE9ITyFTvroDmhjdlLDCU0x6Dttg2YpVKjW1SdN9SAj2TwADQQG+
	FIQHzKi90lBQ023XfKsnO+am7BirXcmbd6Cw2iGfqRt4WuHuK5gxas5f0ZGeBlfm9aho
X-Google-Smtp-Source: AGHT+IH7JbLA3QwIdrnJWRDvE76PDfm27fjBYanEkPfVM7oHClwgTVSyiYbx45MDUjE/Z1yhdqGVUQ==
X-Received: by 2002:a05:600c:3b0e:b0:439:930a:58a6 with SMTP id 5b1f17b1804b1-439930a5ac6mr24348705e9.8.1739971275239;
        Wed, 19 Feb 2025 05:21:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:eba1:dfab:1772:232d? ([2a01:e0a:b41:c160:eba1:dfab:1772:232d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43994f0c10csm46603855e9.26.2025.02.19.05.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 05:21:14 -0800 (PST)
Message-ID: <f476b0c9-06c5-4c24-a77b-a2de548fe745@6wind.com>
Date: Wed, 19 Feb 2025 14:21:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2 1/2] net: advertise 'netns local' property via
 netlink
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20250218171334.3593873-1-nicolas.dichtel@6wind.com>
 <20250218171334.3593873-2-nicolas.dichtel@6wind.com>
 <e542b4f8-176d-4c2a-bb93-6c7380a5a16b@lunn.ch>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <e542b4f8-176d-4c2a-bb93-6c7380a5a16b@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 19/02/2025 à 14:08, Andrew Lunn a écrit :
> On Tue, Feb 18, 2025 at 06:12:35PM +0100, Nicolas Dichtel wrote:
>> Since the below commit, there is no way to see if the netns_local property
>> is set on a device. Let's add a netlink attribute to advertise it.
>>
>> CC: stable@vger.kernel.org
>> Fixes: 05c1280a2bcf ("netdev_features: convert NETIF_F_NETNS_LOCAL to dev->netns_local")
> 
> So you would like this backported. The patch Subject is then wrong and
> indicate it is for net. Please see:
Erf, I forgot to remove this CC. Jakub prefers to have this series in net-next,
I'm ok with that.
I wanted to keep the link to that patch, but I can reword the commit log to
avoid this Fixes tag.

Thanks,
Nicolas

