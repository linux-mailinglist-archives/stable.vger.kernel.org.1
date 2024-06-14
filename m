Return-Path: <stable+bounces-52138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6225890837C
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 08:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC34E1F254B0
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 06:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F891474B2;
	Fri, 14 Jun 2024 06:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vc1vAPZ4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18B519D895
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 06:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718344899; cv=none; b=QSu2Sg1w7zegOaDRsUb7MV7jauUBfZ6ETKow8QzWB34c+6NbuU0ZeWFEIEM1OGspRXCyr6y2R68LUX7Y4Cw3a+bLhhZjrsmGgpB9GQ/DiNnjOo7jECjKkwJB7t4KPhajbnd20gzr6aMAEH/5hZanO3GSb1LJo0aL0vn0z2fX5bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718344899; c=relaxed/simple;
	bh=x1zaNb8/OfqAZqW6xIF++L66xGyrPW35J+McVRQhcDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWn8A7B0VbUD57Oqc3NSYsGcsFI0U3dLkUBYRzdgPmjgohh3Xrt3DiB/ECX3F5rryjUYqpFBHeFOaJmEoLh00GuJu+CUir6QK2n1PSUXflRfQv9VcxsUTnR+DZdHmYQ6dXJI/DCgIMT24ZASTICeS5fA8mPmkKSOyVRa6BRCQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vc1vAPZ4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so233068166b.2
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 23:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718344895; x=1718949695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BR/byF0T5iDKCNBOsyArBXpm3tWlbtbt45AHnweARas=;
        b=Vc1vAPZ4Zy4/4IKYsqzN+ou18J1TS7BNsKNvVPqRMqRY5LzXz9GDC5wtCo9KawRMLg
         Ef04up4j2PAmP8B+wmlRJ3RJ/9uA+GIHurg9uy1UF2UpAohF3hiL5nHWVcTkipJbHQ9e
         yFN0CjG7zeVkt7zQZjgBrPn3YDjsv78Mek9ocbGyf9Z1LI4044r+zDCZnL9WUEG6DuVr
         rerkEc1yRng8nbcMPLyIGPpbL1YT9WYQN24u3rNZfp78inamXX1w2FVvgKfRfYX11qHy
         bqDpVpmfvCVQMhXBjUl12DAxpXFQYexW5+EAyVWOg557Z1E1yivc637/GwLBm1bfPFtz
         ykXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718344895; x=1718949695;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BR/byF0T5iDKCNBOsyArBXpm3tWlbtbt45AHnweARas=;
        b=EIWVz4nr3gmJ14QrrMSRYe84l40jE3w+gXnwc1V9qJf+tIKY2F7EteW4Z/TBQhWFHg
         cYXyQkATiPvH4XMG3VwZUVJFr6kiiq3i+As+kD6zYo0Wou0uglVMYx2BIknvxdhqfdfa
         Wgaiy2ZxYCWK/mo0fOTZtYAVAHPjmbokv5a59+/bBd8uddMESdPHQt6Jk8Ylj52R4Djw
         QDIrl7yQdOMc/TlGs0VDPMiIwARgirfFh9pppvTeTR/Y2B6aX57dXA4q8zX7A4f9lQqW
         bP36EJrffZQAzC9e9JKHQkZNY7j8LOnTJIMa+Ic73L6Ue2CwBp/s4RZEFhkS7/ariod+
         PVjg==
X-Forwarded-Encrypted: i=1; AJvYcCXYt6L4J4CCFCoXB+KoKCK7p5seIHTPoxX79aVWBRt1EnLRQjqt81aeOZowAAngDYuDO1WdblpD7DMn2ps1/vQRIIrYUO/8
X-Gm-Message-State: AOJu0YxE1dX5tO3DyxvpYoYd4qbV17gd/1cg9HFJpfr3+AuTEQ3hSn2B
	6gzrMR+VaUFOHPpnGqSV0ifKoyefTlWEDaO1H1mZXKehMqZ5HHi+9e82e6QOzw==
X-Google-Smtp-Source: AGHT+IGi1nuaXOBHTFNEfd8j9olcUmrdZrQ3Kk5EJcl4kPMb4Lp5qx36F3lQSqP0EhlgHeqULoYJCA==
X-Received: by 2002:a17:906:17d5:b0:a68:c6c1:cd63 with SMTP id a640c23a62f3a-a6f60cee916mr94169466b.13.1718344894795;
        Thu, 13 Jun 2024 23:01:34 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ed0f2asm147572866b.131.2024.06.13.23.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 23:01:34 -0700 (PDT)
Message-ID: <663e80fc-6785-4ac5-ae74-e5f26d938f49@suse.com>
Date: Fri, 14 Jun 2024 08:01:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] memblock:fix validation of NUMA coverage
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Narasimhan V <Narasimhan.V@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, stable@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@kernel.org>
References: <Zmr9oBecxdufMTeP@kernel.org>
 <CAHk-=wickw1bAqWiMASA2zRiEA_nC3etrndnUqn_6C1tbUjAcQ@mail.gmail.com>
 <CAHk-=wgOMcScTviziAbL9Z2RDduaEFdZbHsESxqUS2eFfUmUVg@mail.gmail.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <CAHk-=wgOMcScTviziAbL9Z2RDduaEFdZbHsESxqUS2eFfUmUVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.06.2024 19:38, Linus Torvalds wrote:
> On Thu, 13 Jun 2024 at 10:09, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Is there some broken scripting that people have started using (or have
>> been using for a while and was recently broken)?
> 
> ... and then when I actually pull the code, I note that the problem
> where it checked _one_ bogus value has just been replaced with
> checking _another_ bogus value.
> 
> Christ.
> 
> What if people use a node ID that is simply outside the range
> entirely, instead of one of those special node IDs?
> 
> And now for memblock_set_node() you should apparently use NUMA_NO_NODE
> to not get a warning, but for memblock_set_region_node() apparently
> the right random constant to use is MAX_NUMNODES.
> 
> Does *any* of this make sense? No.
> 
> How about instead of having two random constants - and not having any
> range checking that I see - just have *one* random constant for "I
> have no range", call that NUMA_NO_NODE,

Just to mention it - my understanding is that this is an ongoing process
heading in this very direction. I'm not an mm person at all, so I can't
tell why the conversion wasn't done / can't be done all in one go.

Jan

> and then have a simple helper
> for "do I have a valid range", and make that be
> 
>    static inline bool numa_valid_node(int nid)
>    { return (unsigned int)nid < MAX_NUMNODES; }
> 
> or something like that? Notice that now *all* of
> 
>  - NUMA_NO_NODE (explicitly no node)
> 
>  - MAX_NUMNODES (randomly used no node)
> 
>  - out of range node (who knows wth firmware tables do?)
> 
> will get the same result from that "numa_valid_node()" function.
> 
> And at that point you don't need to care, you don't need to warn, and
> you don't need to have these insane rules where "sometimes you *HAVE*
> to use NUMA_NO_NODE, or we warn, in other cases MAX_NUMNODES is the
> thing".
> 
> Please? IOW, instead of adding a warning for fragile code, then change
> some caller to follow the new rules, JUST FIX THE STUPID FRAGILITY!
> 
> Or hey, just do
> 
>     #define NUMA_NO_NODE MAX_NUMNODES
> 
> and have two names for the *same* constant, instead fo having two
> different constants with strange semantic differences that seem to
> make no sense and where the memblock code itself seems to go
> back-and-forth on it in different contexts.
> 
>               Linus


