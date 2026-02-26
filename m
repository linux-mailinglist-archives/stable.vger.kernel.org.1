Return-Path: <stable+bounces-219811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NxtHOBPoGmIiAQAu9opvQ
	(envelope-from <stable+bounces-219811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 14:51:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 911241A6FCC
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 14:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1516730378D6
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 13:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3472D780A;
	Thu, 26 Feb 2026 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TUGBuzDP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27942877C3
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113448; cv=none; b=Yq3ED0ZhwsTzlWnXMjOBicEN8urqtTpQAc267HAk7GjaU3eg2UIIJT6x/uDMbuIGlG7bWlgP5S9U8bIPqm6qyam37/G3t+iCHXeQHYfRVdwiPNKiLKrjfh+m2JK3ULjuBbawA9RilEGMnSR2O8f6M6lsdIGDyhIZQNkZh5KhF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113448; c=relaxed/simple;
	bh=gYACJLn3/0GZSiDl9hZ0qOJ1DMoWtAfWBCr6MWFZTqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECFykKy3hWCTgs/A+1V3dUBnwy4bCG6gYNYU8es1yZd5dQNFGyEPQMNEuiDc2QeSGPha+DlGDrMndnhb0nh8HCYQWK0cOOpspx4hfR8N4ij1vR638pBaBDK4A+2HNlk+RyId2EsIKLcVNOhuHTckkQ+5n2jtTTKEzUioyD0e3zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TUGBuzDP; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4836fc075d2so1082455e9.0
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 05:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772113444; x=1772718244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RiW9GHemN6Ann66iA0XbJEcnWOl2O4mI5KnopxyGsJg=;
        b=TUGBuzDPnS5sqEqtfQ+EAnxTogsw/t+YZtVmDG/HrwWHCq7j+R4zYzBeTSb20KL9hT
         khffNIFWqnKzdHY9UAh13yCHtjA+u4+ymOejC6PFjDn5gLDX8zT2o+wmzgjmoZ/44EVK
         9tWzpHd074Q0wzOqwqe6r8tuWkQWmG37xHb6FfrwptotAyxC7eTVE4kISnP5E6Rb0V0D
         mVrfJ9KMRDHWp0/ghS/fx+SFacIzfFdXrdtF+3MQepvPeqPT/fxO7QvWlXylsZZ61k2G
         3sq5W63DVJYr//3s8n2Vea+nGm0vivOmyJfhCOeSTKdzcV1HSbI9AsO/+EoUaOEWPtb/
         SSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772113444; x=1772718244;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RiW9GHemN6Ann66iA0XbJEcnWOl2O4mI5KnopxyGsJg=;
        b=viVhdmvJcgkFp45ECHekBrmgOd51zH8X0sdvzVR/wjzV+zba4SUru/8Cds4veOL3DM
         om+VLhwOrPKiMsaXCNNj2dzbTnloWnOA8azt0YjQinOUjxpgi0mU9RkZgZ9YvfT89acQ
         01pUZgH3Tz9lQq7SW8PbHuepXbUd21x6z5E4qFbZ1+I/pqAeoSKLLYezL8hIFV2C2LqF
         9rl6a/f49lNIBymrj28fr2iFhfH9uxHs85ZUq2gho93Xe/Ns9eVAYcWGpHjgivw/zKXD
         vKytt8KZab/yZUlLxmNHRcsJC5rjdezkMFjuz+DhA3/w/l2A0b/vXW3rgjMJ0SAQvUmf
         da+g==
X-Forwarded-Encrypted: i=1; AJvYcCW2Dr822sSkKHxFxKtfSvotZrovSmBY00xaAlpPRDFRvLUBLtLNmpeMTixVhUp3qZ5VfyZ5ts8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcYICrLOqxR7xYqQCOo1DsyUi9CNsSfUnKvJjXZKIwsGaH8Y8E
	H3jVPq6EnIN5duo8jLAZDW7pSFjR1DbLIoRZJyateF1/0lWKPg1gVPX6B3mHXR3Z288=
X-Gm-Gg: ATEYQzx1m4kB4rnC1EancPB3iaPU0JVJlB/WwHncmbhPM2rsaMYlqrWyGuCCd8yOcSO
	z/qkbefsNZEphIAzewSvnFMrZJun/SlniGBD7+R8TgoTIKvETIOVxBLa1xGp7aRf02fR/hQP9QI
	HkW/iGqYUpRjkgxtt2B3NEQ8e2K/UGV5tNdYBwuAmepLtkP0xWk8MJCsdg2ueolGqEJiHpIpsyh
	b/UtiQ5woGtjGzkAbokTFuOBHWTaeKyOEXf8n3kb3IGypOxUFX1S3i9JpcFWeNFzKlBrinKC6mT
	GR/+PizyzujLLOsAZpibDJp0nuk4AHMFl39phii6GLsKjR+Uq4CK9XI8DD0JE2NzfkLIvr1OCHI
	Act+f5f8bW5+OkVw/gceMa1sQWlbbl2wVaYeYfFVtxBft4B5+hQc2E5fV7ImWsrOIU/fsnT0btk
	FV4hjxwbsKolFmobh8lY2duf2NfKYoVWkpYLBcVUkhKREoCAIJ1f/E9eigqdn8BA4iZiFo
X-Received: by 2002:a05:600c:34cb:b0:477:a16e:fec5 with SMTP id 5b1f17b1804b1-483a9555ad9mr192713905e9.0.1772113444133;
        Thu, 26 Feb 2026 05:44:04 -0800 (PST)
Received: from ?IPV6:2001:1a48:8:903:1ed6:4f73:ce38:f9d4? ([2001:1a48:8:903:1ed6:4f73:ce38:f9d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f3124sm141938035e9.1.2026.02.26.05.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 05:44:03 -0800 (PST)
Message-ID: <e759dd9b-0857-4155-b570-cd002155f123@suse.com>
Date: Thu, 26 Feb 2026 14:44:02 +0100
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
To: Shakeel Butt <shakeel.butt@linux.dev>, Hao Li <hao.li@linux.dev>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 vbabka@suse.cz, harry.yoo@oracle.com, muchun.song@linux.dev,
 akpm@linux-foundation.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260226115145.62903-1-hao.li@linux.dev>
 <aaBM0fN8fqER7Avf@linux.dev>
From: Vlastimil Babka <vbabka@suse.com>
In-Reply-To: <aaBM0fN8fqER7Avf@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-219811-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 911241A6FCC
X-Rspamd-Action: no action

On 2/26/26 14:39, Shakeel Butt wrote:
> On Thu, Feb 26, 2026 at 07:51:37PM +0800, Hao Li wrote:
>> In the trylock path of refill_obj_stock(), mod_objcg_mlstate() should
>> use the real alloc/free bytes (i.e., nr_acct) for accounting, rather
>> than nr_bytes.
>> 
>> Fixes: 200577f69f29 ("memcg: objcg stock trylock without irq disabling")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hao Li <hao.li@linux.dev>
> 
> Thanks for the fix.
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

What are the user-visible effects of the bug?

