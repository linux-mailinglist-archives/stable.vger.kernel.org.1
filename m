Return-Path: <stable+bounces-219928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL6tOtRLoWkKsAQAu9opvQ
	(envelope-from <stable+bounces-219928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 08:46:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 560061B411D
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 08:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7455F3036ECA
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 07:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC130322C77;
	Fri, 27 Feb 2026 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fvk6pM9e"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70962C029D
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772178383; cv=none; b=H8JPJnJpjk6x413/L0o0KmCIhkCUNIRZdkGp1GOFHmMWZfHQ1e++wVh97ATb53o5/ao+PxOcnd5HXYbfwkA8dwAVkpIltCv8v8+ybnxCxQHx5DJ5Mcevg7/XXP6+8r13HHl1KHARdvjI7xNFsna7RrLAYpgDC8XWbmmKa8VucXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772178383; c=relaxed/simple;
	bh=Bx+B5gjKJI/vlC7buqYj0K8xUC8oHqthHvN3Xe1DHxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftNUrpEetCGGx9prXD2Q3R7+jXUnP3x6vCiLMbk1Qu3GDr01Io+6nqRFquAjfjBLRbubXgHqZEJVoHSb8WMvaEad6yZeTij/Ta8h91RORdH87/mkoGDdGnkkXjWaXo1R+rxu0tzOMz8tnAZLIhKpWRRzz/J2Qwp/+j6T624GQyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fvk6pM9e; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48371104ffdso2311135e9.1
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 23:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772178380; x=1772783180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPz8QjAwZvhtyd1YXSG1O5BxKJR3PUgfbJT3DkGnKNY=;
        b=fvk6pM9e2MRJDqOB1thCS9SZqnXo2PSsXaLS9IFIGgc7HaIz/8P/F5mG1bK6NGYS9O
         pemHaISBjWPzJEqZVLwdTAs6nVJQODBOlAerix9A6whuYRgSWaKwCG+pGhuIk55nult9
         DomU2y74/p2G4J1AFVsYb56NAQ3sQsn1RZ2h19J+vEHYMuripbOjygs0ixXmG6ZNuDmm
         ouKS4BvrPUD2Q2p67vJz0SdgSpIV94CevUy9wOz/OH31RSkAP3fgh6EDj0J6aNRTHguV
         oTa/5w9fJcPbkjrUMoEi60jgbH+ljovDkNzO2qIgihrE526su9wJ0aR38DB+0ai5DW1r
         xntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772178380; x=1772783180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPz8QjAwZvhtyd1YXSG1O5BxKJR3PUgfbJT3DkGnKNY=;
        b=DmTa4p8+d708axnOzcAl5qE5pPjJih8sIaghac8mTbxXpfSxCnCtwmaqr3abgNXZg6
         p1NVqpbBFMz1P2yeKeotliiEunnc32mkUIeFijWeC2wpmYzBdUV7BiY5lcx7Mozbpe5i
         RWhXsd8RcCPtUDZBGjQGjvuVdaHy/vQm19V2U+yszxsugeUapjZscefGI3hmH4Vl4GGK
         cayO3uL3NsGw3aM7/CL+sYnrDnGAXtTyPH/td/nGUQdK1oHF2OO7uFWnV0tDD82hrhHm
         f0+fQ5SVUMhIDuegr2H4+/NyRzDvmofapB0UjnZCMCCdbZuYXLoZFADeJVXrh98nO+FW
         X9pg==
X-Forwarded-Encrypted: i=1; AJvYcCVJjChu9tcKhxc4zp7On22yCEIlYyB839JAKqD2dvkkowanYHSlvcZCDkkUOXUYjHNPXLXKQt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ1h+iQ3M+pB5evwmGZ71fDn5fL8Rcxr2yk+RkLYbWz3uTtmoh
	Tgo8oAzR9D4Ivq820IHTMKEQlA86hm6ItaMQq7Jv29/+bPSPwYj4vH3iGRRpzMRmMfA=
X-Gm-Gg: ATEYQzxq1QER+9icV0bYHv0xFC66Dz685oUpO+x6kHeBpqlFKDmgMY3Od6gvNVqx3gl
	nNltUTY3KzRJrMV7V+Ckma/nAOI65XlgYgU4677DJ85W7YRK+NV5qSIVu9J4zkqacarIOe5NKjO
	I8fL/kT3A8mxaRnDUxZxRblqSCUfE8cGhFgASGQetCnypcPx7B6YnJwgsPbXbGzsqHFK/6SPkZi
	wPeQLFunhnbtH/8E9OHWzwcJZ/iN8S2bhoz9PSnfpiL88DEG1wlZIwJbC+2sY3Z8Fu5R5ZzxKdR
	h2qcwEGDafW40x0cAZFt/yOy5fpilue/Ykk4WBCzfh5DjKg2aGtqpbC3Gy/W2MzUYpqCs3zLSNi
	srgOj1tgLGXkRdTHxknPOCvmYlRDyB19jiI9K2SnxZdFLlWUl/wKCblp1xr8BcHct1jbDxdJsrK
	cb5nqLZDlTTJwi5egYyCclJv5xTC90L/q4k6uLVzTKjXVn7Fs9EUIGUIGYuw==
X-Received: by 2002:a05:600c:4592:b0:46f:ab96:58e9 with SMTP id 5b1f17b1804b1-483c9b7fadcmr14391835e9.0.1772178380074;
        Thu, 26 Feb 2026 23:46:20 -0800 (PST)
Received: from ?IPV6:2001:1a48:8:903:1ed6:4f73:ce38:f9d4? ([2001:1a48:8:903:1ed6:4f73:ce38:f9d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bffc17dasm97998005e9.2.2026.02.26.23.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 23:46:19 -0800 (PST)
Message-ID: <25f6a18c-0600-4a21-977e-19b8b4b203b2@suse.com>
Date: Fri, 27 Feb 2026 08:46:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: fix slab accounting in refill_obj_stock() trylock
 path
Content-Language: en-US
To: Hao Li <hao.li@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, vbabka@suse.cz,
 harry.yoo@oracle.com, muchun.song@linux.dev, akpm@linux-foundation.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260226115145.62903-1-hao.li@linux.dev>
 <aaBM0fN8fqER7Avf@linux.dev> <e759dd9b-0857-4155-b570-cd002155f123@suse.com>
 <siuyozcbi5x6vusawdy3be5buho5y4qilc5uls7rgiihagk7uv@cfrr75gh4bty>
From: Vlastimil Babka <vbabka@suse.com>
In-Reply-To: <siuyozcbi5x6vusawdy3be5buho5y4qilc5uls7rgiihagk7uv@cfrr75gh4bty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-219928-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.com:mid,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 560061B411D
X-Rspamd-Action: no action

On 2/27/26 02:01, Hao Li wrote:
> On Thu, Feb 26, 2026 at 02:44:02PM +0100, Vlastimil Babka wrote:
>> On 2/26/26 14:39, Shakeel Butt wrote:
>> > On Thu, Feb 26, 2026 at 07:51:37PM +0800, Hao Li wrote:
>> >> In the trylock path of refill_obj_stock(), mod_objcg_mlstate() should
>> >> use the real alloc/free bytes (i.e., nr_acct) for accounting, rather
>> >> than nr_bytes.
>> >> 
>> >> Fixes: 200577f69f29 ("memcg: objcg stock trylock without irq disabling")
>> >> Cc: stable@vger.kernel.org
>> >> Signed-off-by: Hao Li <hao.li@linux.dev>
>> > 
>> > Thanks for the fix.
>> > 
>> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>> 
>> What are the user-visible effects of the bug?
> 
> The user-visible impact is that the NR_SLAB_RECLAIMABLE_B and
> NR_SLAB_UNRECLAIMABLE_B stats can end up being incorrect.
> 
> For example, if a user allocates a 6144-byte object, then before this fix
> refill_obj_stock() calls mod_objcg_mlstate(..., nr_bytes=2048), even though it
> should account for 6144 bytes (i.e., nr_acct).
> 
> When the user later frees the same object with kfree(), refill_obj_stock() calls
> mod_objcg_mlstate(..., nr_bytes=6144). This ends up adding 6144 to the stats,
> but it should be applying -6144 (i.e., nr_acct) since the object is being
> freed.

Thanks, I'm sure Andrew will amend the changelog with those useful details.

Weird that we went since 6.16 with nobody noticing the stats were off - it
sounds they could get really way off?



