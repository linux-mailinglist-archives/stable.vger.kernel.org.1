Return-Path: <stable+bounces-77699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 273F2986120
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0B21F26128
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01246188CC6;
	Wed, 25 Sep 2024 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc/ItspS"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F0C18893A;
	Wed, 25 Sep 2024 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727272507; cv=none; b=f3mAOoA0s2gQRDFybaFwJLTQ1wWrqlSKZqbq7MydIZU+dwz0HDXIj3W8LFVaHFtH4xmHIsbufsZlW1lqgfq0r0HR47lOZCqiKc7SrhJ8WD4Apmc9bbfIYjx3pyRlmPw1p7zuVdn/lpd8VHk9iZMSPNB0/rMYXiRJJN9ZFC58Tfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727272507; c=relaxed/simple;
	bh=RGj0qJ5SRgdlrOAjtMa3FcwkkThenRsveChKagVnBrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mU9qMEszOuByI4xmWUBCM8ueSgSy0nguC+dp+t+zbLKKABbngbr+jeb5lO0tj/jCTcCe6FdcInfq8DP/KZBIKkrEiO7jgvQN5iIpSNqWpnZyE22ELQdJ375MkF8c4fTsox1FkfCUneQWZUYkbsAl210PGTgPz6dS5gU6QrCWVA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jc/ItspS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f753375394so50121091fa.0;
        Wed, 25 Sep 2024 06:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727272504; x=1727877304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7LlKWoEC176YkyQGYc14BVZuo0LmqXgUiNzr1xvaMSg=;
        b=jc/ItspS1Ckvg1XbwZPHFkttcnV7CP88E1WLG32glMLuaZXo0rOgrNPn4obcB78pX7
         U54nfWj0VtfMQE3XF0ecAsbvnlbUSQoCi6LPdCQT2cZuFRPJMuP9UZ1FrtI0qXfisSgb
         YBjHf6dmtVYldcToNt3mMAVuaH+kt9vqqEfATFc1Y/kPIdPUWw25DJZW/vqceVAW8n6i
         j7ZqX7bcbh8s3slMa3L4Sn1wWkPynyu311OVMnJSVgrSSwmaPvNONf1bymb+6slq5T/t
         +qFbO7Zlb1y2WmiXA9BzBAIb+6JP1hSrVSjy+a1zIkvP8prtUs6+rKwPcU0v697o6Zkh
         fn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727272504; x=1727877304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LlKWoEC176YkyQGYc14BVZuo0LmqXgUiNzr1xvaMSg=;
        b=SNvGEUaBZniq5NjRqCyyUUTFZDUYO+U6+5/TxKLVT7QcN0bfXJw928ve0muVjoIxI/
         ORMhKi1WxJjNlNv4ejppRaddT/wrpnBQpAgCNjhLJwDC1zVR77BGz5TVnx7a5jIANuuc
         shuDYWL5Up3ne1fpCr8jA+Q4qL4oKHrOHL11H6xcifdYk/ZCJbUsHYCqm4nzQsGHfVL0
         c4t261cpAOJbQ2qv3iyZ+rATp0Q7YM8bENBAj/D6Wc5K7JnykQhB0tuKbvkjNbYozli9
         HL7Nf/yl+2OOfINeI58tnXC7lG1OdLidR/akyVXhFve1AScLfsnH8jBa3H//NImqjiEe
         dDZg==
X-Forwarded-Encrypted: i=1; AJvYcCWfxLYnb9juUyootzTkWtluu/+By3czu4Cp4rWzEOJrW/BaclDnBDiQ/BBQWWcBJ3WAcA6UI7vsJOWpfT2v@vger.kernel.org, AJvYcCWl1qX03NzYu7/FfCs69p+ZF5SR8lHz89Brhm/Q3k93ThC0Ie2lv+qdSZjmkk0gaeRvR18jBI/Z@vger.kernel.org, AJvYcCXumvgOd5AWf/ihuz9cYb/D4fT4WuLF0GbsmKUZe2rd6q87TVrABvp/gq160NHQz3e8hT1FI7xMhmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi4evCmJ7HLHy1VSF34VCNfJwDBtcEhht6Q6eOhp+apwvC1Tnf
	JaqdsSKXRBN4qX/e1TJA6h9pizYV9ZJsZhf3m25mL9bDZDVehIwa
X-Google-Smtp-Source: AGHT+IGWjdvvo6s1HU6FWM2hprzj+s+/otz2iTogc2i2WVp0bBQNB9QpFxjXYVvlE0/ZZcGL6C592w==
X-Received: by 2002:a05:651c:2105:b0:2f7:52c5:b67 with SMTP id 38308e7fff4ca-2f91ca45fe5mr16870841fa.29.1727272503672;
        Wed, 25 Sep 2024 06:55:03 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:48e3:9f19:23c:a642:7730:a44? ([2a00:1fa0:48e3:9f19:23c:a642:7730:a44])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d289ee6dsm5264081fa.121.2024.09.25.06.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 06:55:02 -0700 (PDT)
Message-ID: <0176da3b-e95c-ac75-a945-731dc74cb45d@gmail.com>
Date: Wed, 25 Sep 2024 16:55:00 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH AUTOSEL 6.11 145/244] ata: pata_serverworks: Do not use
 the term blacklist
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Igor Pylypiv <ipylypiv@google.com>, linux-ide@vger.kernel.org
References: <20240925113641.1297102-1-sashal@kernel.org>
 <20240925113641.1297102-145-sashal@kernel.org>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <20240925113641.1297102-145-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/24 14:26, Sasha Levin wrote:

> From: Damien Le Moal <dlemoal@kernel.org>
> 
> [ Upstream commit 858048568c9e3887d8b19e101ee72f129d65cb15 ]
> 
> Let's not use the term blacklist in the function
> serverworks_osb4_filter() documentation comment and rather simply refer
> to what that function looks at: the list of devices with groken UDMA5.
> 
> While at it, also constify the values of the csb_bad_ata100 array.
> 
> Of note is that all of this should probably be handled using libata
> quirk mechanism but it is unclear if these UDMA5 quirks are specific
> to this controller only.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
[...]

   Again, what does this fix? :-/

MBR, Sergey


