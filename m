Return-Path: <stable+bounces-48296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 076DA8FE722
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 15:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0843C1C23E40
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 13:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6C5195F3F;
	Thu,  6 Jun 2024 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="HVEdj6k8"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3B2195F2E
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679232; cv=none; b=iQf3Bm/djK7WI0bXJ8WlmFzBj+ziEvkk9VRP5P748scfbZBFPTFkhp1/k4ZyYU8mDXFuGf38FZTu5mqlAUYbyIGkrwDRFDfXB1uRHHhrnXXT5ku8mDRUNQLH461rMTznLbtJeGmZdAfbP7X0/KOEkBnbp7f8usp5M2CLuyC76IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679232; c=relaxed/simple;
	bh=Etq3BFH0SUDQc3u7gbIgGA42LQ02usvZh0xzy0dG8VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNS5fPnkLEFS9l5sCHUzJF79+P+/+PgmK1us7rm8ibnmngW9yfBRXVM4isx77sInJAmFc5WAHz0u2WCEQnLt9AMV61yJHsMq0HdGGBSwts9o5iXCEJ/yaczr48BE9Q9D/2wdPBN0GIbTwLM/TgwEXDcvSxvuPIXJodk70lee7RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=HVEdj6k8; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b90038cf7so1472765e87.0
        for <stable@vger.kernel.org>; Thu, 06 Jun 2024 06:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1717679229; x=1718284029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X7/YjkjE87q9fVWLbAbF50WpMhrk7+YRouKRmXLf4ss=;
        b=HVEdj6k8ZweIWXWv63y8axEwQ/cJAkUQd/SjI2vIdYXS41l3wDskJETC+ZbU44KxqX
         oEa6c3TaH/dKrbYTyGAh82e4vKJeWlMGDsRd3UrTqQDpukWtAYkSpPJieuO3iR4JIyC9
         pAAidD/WILy4VhCzKFIDEPtcGnjY05m0F+iw7Xyp/C6awK0mjOyZLimiMP7DxvOiGM4v
         b8HbiKD2b62AwDcJsvkRa8gLg6yIwnAkD8lNihGQGvd2GGOezqloibY8R6FW8ZKO4X1T
         xh/r4zUWeXK8qUFUz/ej63kmrX8RYsExZpmEtcbrsnJEekRPfJkIMt6XpHN3pGsVDkO/
         L8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679229; x=1718284029;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7/YjkjE87q9fVWLbAbF50WpMhrk7+YRouKRmXLf4ss=;
        b=wzEgZzTHAS1KM8/Lkjo1awbH5wmbdW0EDfQQ8V1YtpbdgAW1FfdE8+GE+XlV2nNo9+
         tlmQZuiReBpWMUpn+NwIDQJ9HJN+VkKO/K6iOrGu2A1CD7ONA0POWtw8zRx+N+qlXOtp
         Ijilu6+SaMvaoNJqYxQcW+3z9PlGmb39lhTBvDiyEmZiemh2tFas+aBtFjN5I8NvM4vO
         SGXignlnSvsWvp6dENdB6E6r70r2NpkItYceiWI5v+XuSqESdGlPP1q7sM1dVEHwooP9
         459coAQ/mzwrjdPbNa4V0VEYT1hTvFVT4HCP9mvHaLIdhdq2u18kHjj36fcugFOrpDuS
         2Q5A==
X-Forwarded-Encrypted: i=1; AJvYcCUb3kikORieHho8mWfr/wZ+bSrtr3FuGOm8xHU5TTjc5ZxAJhJoBHB1wnFQMWdq/NVFxDJh9dNKr3srSiLNqcaOGxUgLNqU
X-Gm-Message-State: AOJu0YwX6UZAJUqdvFshKgTWK8qKYEzonxknElsLbJbRZNXsDNF8IC1q
	aahBU0s0ajBGo2iBUC8Ygh5QXMWfuywfKG7QpALzirWyUY8BwemJIfinOhFdwHk=
X-Google-Smtp-Source: AGHT+IGLIp8RENe2geB0EOGlL/St+z0m6WGvSCPoo9gsCnSNdlZPwexPjET61pIuui0zOW6sPdb95A==
X-Received: by 2002:a05:6512:b92:b0:529:593f:3f3c with SMTP id 2adb3069b0e04-52bab4f4c6bmr4590296e87.53.1717679228688;
        Thu, 06 Jun 2024 06:07:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:ff33:6de4:d126:4280? ([2a01:e0a:b41:c160:ff33:6de4:d126:4280])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c1aad97sm21117195e9.20.2024.06.06.06.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 06:07:08 -0700 (PDT)
Message-ID: <9def8383-55ba-407a-af58-838dff2f3e49@6wind.com>
Date: Thu, 6 Jun 2024 15:07:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH nf] netfilter: restore default behavior for
 nf_conntrack_events
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, stable@vger.kernel.org
References: <20240604135438.2613064-1-nicolas.dichtel@6wind.com>
 <ZmAn7VcLHsdAI8Xg@strlen.de> <c527582b-05dd-45bf-a9b1-2499b01280ee@6wind.com>
 <ZmCxb2MqzeQPDFZt@calendula> <1eafd4a6-8a7e-48d7-b0a5-6f0f328cf7db@6wind.com>
 <20240606085352.GB4688@breakpoint.cc>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20240606085352.GB4688@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 06/06/2024 à 10:53, Florian Westphal a écrit :
> Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
>> I understand it's "sad" to keep nf_conntrack_events=1, but this change breaks
>> the backward compatibility. A container migrated to a host with a recent kernel
>> is broken.
>> Usually, in the networking stack, sysctl are added to keep the legacy behavior
>> and enable new systems to use "modern" features. There are a lot of examples :)
> 
> Weeks of work down the drain.  I wonder if we can make any changes aside
> from bug fixes in the future.
The commit doesn't remove the optimization, it only keeps the existing behavior.
Systems that require this optimization, could still turn nf_conntrack_event to 2.

