Return-Path: <stable+bounces-58255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE7292AB25
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 23:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420691F223CB
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 21:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A704B14EC5D;
	Mon,  8 Jul 2024 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="J21lZiy2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123B512E75
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474030; cv=none; b=cQaIgEYfqMB02rnPlu6yGTtIn0JHjwq1N1sr4FIrHbQsXMV+TVmOA6X4btUvUoIm90y4g6m/PPaAugRDAhKaGdChsj3nj5x6zkB77V1/ouMh1pTw7oycKkdyYTEcSogNQCEvXBaSH1prdW+WbyLp8we22w47CdOL9zjkv04fsG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474030; c=relaxed/simple;
	bh=SniqhF8I1MtrQLUR4CRh6ZHZqPszppuwMNrX5X0ZWno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkYHnvnae4sBxsY60hp+4/LtkBtOGjY4HXMLy/YmhiAw0oq8a8ERV92hp4TdL6HUG5G+uJaYsMomv2Ro5ty8ncEg6rrwsFL77/WEsP/G6j4vDT3yrcR/SbEeYkovQ0nIFyV1ukFj42g2rcxdZds+QLZKq3WV2qQSr/qtwEMfYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=J21lZiy2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266ed6c691so4869955e9.3
        for <stable@vger.kernel.org>; Mon, 08 Jul 2024 14:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720474027; x=1721078827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mUJXtS4XCBqKg2tFK9QNnd2kEKSKQvW0aQSHxBRf1sM=;
        b=J21lZiy2VDowY4EAqrRkq470fI2MzC3mrV4lAARaGSv7000fBUVz9o785drB+OX/Oy
         hyhz774z7mVTqcsVIEyBZ7435HgV7lQFCwd9sLLUpF5Ky4fCCBUhsxOSJ3nbyyBvBO6q
         gyj9fvw6MpX/o7zgOavEL23KfOqFrbcXpINBZSP8E49ClMUeW+oQ2WcMxwG5FScT083r
         GRD5CkndZLvRCbplJl4/jnOlNeNtBal/xPZiFQMc79/rZ7o6OBY9DJgLQUYCSqz14NBj
         7hDoisaiUvQ0q7g4se0T6FF1RlveqD7TMcXYivzRgrf6A9uJ3WNUTGjKTY6QPijIXHp6
         7OsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720474027; x=1721078827;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUJXtS4XCBqKg2tFK9QNnd2kEKSKQvW0aQSHxBRf1sM=;
        b=XJBiv3quP5uqLqYmYHuN97oTK9NxZA5nPqhgFZSihkNFygLEXAaaAXAUTg3Y6231Sa
         9aSh6phmy0QqNCpdzrH806B1WSbZVZFmrYqf3m+GhJPnh4N9+WeoYs08LaR60k0zNijw
         lk5HO0rrUS++OmkCqfZfMobXCHh3q0kXaBikrou+dXNm5dD2JVgeJlzihAWBGE12Nxuz
         zkp6/b6OOat4bl7xV5SvDEeB7TKRcdH17K1lDSzgPYGWQCcpG6FBoywPmRGLErNzusQB
         AM+YxleL16phyz40WnyZ778WHzEfdIZqhwUfKPOJl6o4IHCsYwbqPc3XKcFRBjUF9rBx
         +1RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFrJdVHahUIR5+bzOrl1pSGLlRWtlAwCAhvT1RI+jQkSILgpn80TpmMGUY4T6rLASNRsnrO3+mi+VKYmmxPo1JvW/FMO1s
X-Gm-Message-State: AOJu0Yy8PFNAQOuie5Cf830G6RhYL72YkVz2hfL/XUJWeMh6fj8ftrDi
	UhBzcBSxUe6vaOnBrA7D870lBVcwG/XpH0o6EcTjyM1uzwn2Ap29iwnd/gmtUzM=
X-Google-Smtp-Source: AGHT+IEVB93tN4Egkr+2RhosAVQ5SVQV76/LL6hwcYWL5efR2MQgyf92hklwQZfPfu9HVVMG9C3GLA==
X-Received: by 2002:a05:600c:63d1:b0:426:5ee3:728b with SMTP id 5b1f17b1804b1-426707d8ac4mr4172345e9.13.1720474027560;
        Mon, 08 Jul 2024 14:27:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:f03c:44cd:8f8d:23c? ([2a01:e0a:b41:c160:f03c:44cd:8f8d:23c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e0a07sm12282925e9.10.2024.07.08.14.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 14:27:06 -0700 (PDT)
Message-ID: <8d993975-e637-4594-8dd8-b725111705e8@6wind.com>
Date: Mon, 8 Jul 2024 23:27:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2 1/4] ipv4: fix source address selection with route
 leak
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
 <20240705145302.1717632-2-nicolas.dichtel@6wind.com>
 <339873c4-1c6c-4d9c-873c-75a007d4b162@kernel.org>
 <cc29ed8c-f0b2-4e6d-8347-21bb13d0bbbc@6wind.com>
 <20240708133233.732e2f0c@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20240708133233.732e2f0c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 08/07/2024 à 22:32, Jakub Kicinski a écrit :
> On Mon, 8 Jul 2024 20:13:56 +0200 Nicolas Dichtel wrote:
>>> long line length. separate setting the value:
>>>
>>> 		struct net_device *l3mdev;
>>>
>>> 		l3mdev = dev_get_by_index_rcu(net, fl4->flowi4_l3mdev);  
>> The checkpatch limit is 100-column.
>> If the 80-column limit needs to be enforced in net/, maybe a special case should
>> be added in checkpatch.
> 
> That'd be great. I'm pretty unsuccessful to at getting my patches
> accepted to checkpatch and get_maintainers so I gave up.
Oh, ok :/

> But I never tried with the line length limit.
Why not (:

