Return-Path: <stable+bounces-232871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLLqEjCYzWkrfQYAu9opvQ
	(envelope-from <stable+bounces-232871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 00:12:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A13380DA9
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 00:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81375302A19D
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 22:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1AC342CA9;
	Wed,  1 Apr 2026 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IFNjY6/e"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2824132C316
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775081517; cv=none; b=TsvXFIATnrRavLDrNPFXSv3BvOxx3zHAoooTo+IN3EXThma/aFrzpQlT+kiLIuilNxuzwgKv1FbYRJbsLwKpXqOwCwAXpox1KUa/jVvaTRcOa7gwcc6hNqPjq/xln4eN5nqVy4Vr+7StYyFCASHXutLR+zCxaxaM4wZ/qZyoTW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775081517; c=relaxed/simple;
	bh=mXm/RVkydjltxBYXI3wsGZqHDOjU3KCa3eQf0otGLHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFBXgFpmy2RcfQ8toYriIjJJotyJSD+juSy7ppzXRWAhCrC6aDdFCBAwzqwF5X7/t27NgYWBacUzOVicmqDIdi0kdQ01IKjfustmT6+L07oqF/4FmOBoKXhoIKUaVdSGX0dUaY5ZuV/7jn9oOhwYWHnIvQFwWvwMH976deZDLhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IFNjY6/e; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fe655187so2238415e9.2
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 15:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775081514; x=1775686314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fuaXeXdxXua3ooI0sFkXIl7FkYLoUgWL2eTcBzrMgAk=;
        b=IFNjY6/e81MPsvow3rvkbotTMBvg92VTrH0Hidf9DZIT/jIHJYVJ9RTuoyyvNTEDZa
         ELgi+rFwwjK5TFj0o8GImHPAf/xNoMOSdmEAweS4HlLOAPpbY8DM6oGsHg9U+BswDawz
         BfnEma9AY2aKYj1nG/atn6qiUIlphikzYrXIjQzBnyyEKZ9SCleBO022RLeXTwIzeHKr
         +fpRzuYO5G9wkBIzjLT5G5oGlzjtOufhd0pUWUCd2R6q2tJg/84bSDaQIG/qxdZG99xU
         E9jzrL7lIMIX1LeTeADxXFkBEf/Z7d+nKoqgwT4jS4cTflkuwwM+apY5NROByiECBFf2
         5kdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775081514; x=1775686314;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuaXeXdxXua3ooI0sFkXIl7FkYLoUgWL2eTcBzrMgAk=;
        b=NKWgLnvLRyLgP5clf66MaakPqf/1bpl30Qw3dyK6U1OIb6YZ9lKMvTtEc6hGwMAvnd
         M7wRlbXTWY8Byix6Kaq/5vPN8loJApq0ayBhQ1UXfE8lN+VE4bg4jWq+CVSx7FcuA1G4
         6iTZ7VZLykCwmpfM2MEd4CtId88M/Of/5QjiE7G0q37WR4xcDZGWlql52Gfis3vk+x7g
         X4Hgmd9Qkwj7+e967zAJEJRXfOZb/bF9SBVvq3tyBtph23eKB9bvTM6JHjJ97Uo+PS4l
         P1KLlQGKKYvXJtWMIwgN0fdXDdiMH6yG9XCOlf1+iCxVVhay8/2NHsmRvuiEg5yQnuqo
         3M7g==
X-Gm-Message-State: AOJu0YxTpTacgqZOSGjCNW3owSWeGpIJhcdBLMKjigQ/WJPSnteKTWHg
	y1lJQBtDXrj8J3R0egmiifY8rRwryvMtIlHLhL2DfEfJ82QZ6A+uoavqQIc94evie7s=
X-Gm-Gg: ATEYQzzv+Z+xYdQOPTPzrGIdfs3b1lqWR5lgZTcTUNk5Z5u1SsZ6LWEdJdYLSUJTZWs
	SLbS6ylZKuJYC6kUMgGGmwJE11Kj4YC/CCmaSX/XsWgwlVEZZeQNqJqQ+kw+95J++j0U+MMXope
	dr2iAd7uxtiqz526VHdu3h8fj5sPdxyF0x9ZGwPypLvQpTCL/uz1jQX6pLjIckYRJVl/0aUSFzK
	jeoQ9Gu6X/osmj6qZnibVQ9trW74OtJcUPVn0Z4/DSry749ys3q89GYBqWiybS1fecctt1JEW3A
	tFNImP0v6cvx/6SrTK52HshV0Q8uxtSd4lMyuNHesSXqjrc9vmw9epgCLWezziwziJ0eZ/IiSYt
	VgxaWJHGFs9BF5IXDSc6DMICdBO4/TP2/aO/0RdUV7wQN+oiAca+gc4vbt80a7zvg0GtAqghxGh
	wdhQ/GCZj0MI6x8M6APZPZvpBUSySVk+gqfuj7HWrEOJznoNfHS3Y=
X-Received: by 2002:a05:600c:2d52:b0:488:8d44:bf98 with SMTP id 5b1f17b1804b1-4888d44c16emr3631025e9.7.1775081514540;
        Wed, 01 Apr 2026 15:11:54 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6491157sm716394a12.9.2026.04.01.15.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 15:11:53 -0700 (PDT)
Message-ID: <4e0a7845-a9c0-48f6-9bb8-102411ff0a11@suse.com>
Date: Thu, 2 Apr 2026 08:41:47 +1030
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix double free in create_space_info_sub_group()
 error path
To: Guangshuo Li <lgs201920130244@gmail.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260401110219.1517804-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20260401110219.1517804-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-232871-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,fb.com,suse.com,wdc.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: B7A13380DA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/4/1 21:32, Guangshuo Li 写道:
> When kobject_init_and_add() fails, the call chain is:
> 
> create_space_info_sub_group()
> -> btrfs_sysfs_add_space_info_type()
> -> kobject_init_and_add()
> -> failure
> -> kobject_put(&sub_group->kobj)
> -> space_info_release()
> -> kfree(sub_group)
> 
> Then control returns to create_space_info_sub_group(), where:
> 
> btrfs_sysfs_add_space_info_type() returns error
> -> kfree(sub_group)
> 
> Thus, sub_group is freed twice.
> 
> Keep parent->sub_group[index] = NULL for the failure path, but after
> btrfs_sysfs_add_space_info_type() has called kobject_put(), let the
> kobject release callback handle the cleanup.
> 
> Fixes: f92ee31e031c ("btrfs: introduce btrfs_space_info sub-group")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

> ---
>   fs/btrfs/space-info.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index d7176eb2fcbf..f5d0f587b755 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -277,7 +277,6 @@ static int create_space_info_sub_group(struct btrfs_space_info *parent, u64 flag
>   
>   	ret = btrfs_sysfs_add_space_info_type(sub_group);
>   	if (ret) {
> -		kfree(sub_group);
>   		parent->sub_group[index] = NULL;
>   	}

For single line operation inside a if branch, we do not need the 
brackets anymore.

I'll remove them during merge so you don't need to resend the patch.

Thanks,
Qu
>   	return ret;


