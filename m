Return-Path: <stable+bounces-223787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BkYB8zTr2kfcgIAu9opvQ
	(envelope-from <stable+bounces-223787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:18:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C69472472D5
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B5D1305CE2A
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D444C3EDACF;
	Tue, 10 Mar 2026 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H2l7YS/j"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C573ED136
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773130398; cv=none; b=mNh/AblvLzoJoMAUqZRVrO0fpKfTIxd8nyjihVEbrHHN/pHdShjZc776n7el+fjOvOTMwqSYO2OA2vMhwpZKgI4kM4IA3YytpSfEgPzu09aE09kgv/VtnUoXbjRjCFLiTDCo5I2Vzk8P5QgeNnOjEsOiDOJ90L2uzqtxVk+hQfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773130398; c=relaxed/simple;
	bh=Ogl1A47+skh40swvXNBfLLd9OGEpxiAPGpg7kD8IlMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MkU8quLz6XjxHolYMHjzuko72w79/DoX28s777DHHlo2IjMPg2Au7QgxgSvnOuj307Q1mHMEnD/ethxTCDkDQaHSOjCV5oNccBDyoAsHLlxOq+7OaGuolejlXi31FGDaXOqjvIlz5uQ8Ii9SlRxGsXM5r4ox/ynfVa1chl5cTsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H2l7YS/j; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso114487325e9.3
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 01:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773130394; x=1773735194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gb/E7qAzjllB7lD/mOoAbiOu6V9IkXKupTTjpaqwPps=;
        b=H2l7YS/j6u2BkQqGGJR+ShRHv8wz3M+24Ec9A/D71ZUA4Jb8qE7oqKIJHt1dLNKo1d
         gxjyU/4o9KMLUYLohwONvcvF2rB6dPWZQLnWlbMNR1Nkb65rB3gUnqf81SGAJ5PwkMrj
         uP/1wSHVoc/2aUP5xyVhNlFkXS2XNs3ySgFGNs7kzPKkN0zKe8AJbPjXVCnbHOKpAmgx
         UilPze9ehHRivVM9pjDLGF38rpDn++GWDG68+laOMhVoJsqpX9+8fopu11eyH6VYkPTI
         07jm8EyNP1liWp4G8IZLGaAKB8gBSu9Fc1WDmttju8o+qnhL+03zsf2h7zyrDHrzVmHp
         QiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773130394; x=1773735194;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb/E7qAzjllB7lD/mOoAbiOu6V9IkXKupTTjpaqwPps=;
        b=WqrNXr6dtmPUOOmNfteqrWH20I038ihGlWgdHL4bV6avFgkwgpxG/gCp2xV7fjg0yP
         vFzgt6N/9OnFG45J+/iXenWQTUI2FIQSuwPEZlzMB8+1kaoHt5Q7pM1goFOvpui68uFM
         IFnOOSRKgcEwNp1pkFpJsXk03SE5u8qsgClq5MeeAzNl7lAN0f9eCyKlay6nQ7CgAHjr
         Zcjovgdvr7/yA/4H9E1g1EOETtfArrFwhMJ7DQYsFVxOyIgdLmukAKmYMTHVnAA1ANh1
         NA7CryY4X7CU3f5zj26vmQlxJTXQshKDUCU7nsWPDu1hcnPbLssWr+zHRgHsc1f9+yqO
         N/8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXa2ETt7fNTG+K2KK8y+fcbuRu5igQDdhERG98CAPRj1vmxbT1QevZf4zoEF7bpCyiOSh6ejwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3eA6LSHVrjwKjo1p99XlNUOqjKokRQfA47DRBC04BWD5GWXqT
	st1jxoM38wG9vcsir48vIxHIH6lNJnFKBgelHN9pp9I5pdFLVE1cg3SNc4t5necyy1TjMfJF6Bq
	dI/HpEM0=
X-Gm-Gg: ATEYQzx+BM1d3hq4ygmDgX3EVyoNhw12m24FPfuQbEtb+P9U2QidPudt69GdWyYZWuo
	qv16SXZvNOpKWb6c4qv6vObEwIbRaHZUIjVVFZqMJOF7vMIKIb2BG74gmEdoznsOhAO0CkllE0n
	nKHWeQq+LVJEN0mvEW/Jie30xse02SUEo9VqCP16banNamlkWXtwfh2U3GsTbBvErBqEz0fBlqH
	mRs0htsXB8QX7+jcvM2Vmh4koN0vSzjN4QvTzOsNBjfx6usbwcpg8mMOZZOZJJOq4pB6zhVWtB7
	knJH+A26fjvAwqZDj9aPX+0u5r2wibkQjSY7CNtfK0eOv2TxqEPc7fNy9cWIIv3UmVJS7ZeLWG4
	kD7NmKHEViWjq/zJm44ayMOmJtovfhl7KTyI8RMZ4vReZPHuf8WbOVp3zrfgnGWux+oKb4fPQmx
	D9CVazb3+hywGaykcW1Ur/joryL5vo9S3nJ4Xszpab7n8wBJvmwJ4=
X-Received: by 2002:a05:600c:4fc2:b0:477:a1a2:d829 with SMTP id 5b1f17b1804b1-4852692bfa5mr230428775e9.13.1773130393898;
        Tue, 10 Mar 2026 01:13:13 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a465b6f7sm15435258b3a.23.2026.03.10.01.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 01:13:12 -0700 (PDT)
Message-ID: <19e81a86-a8ce-42df-8cf7-da74205584ce@suse.com>
Date: Tue, 10 Mar 2026 18:42:54 +1030
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: reloc: unlink orphan reloc roots before dropping
 them
To: ZhengYuan Huang <gality369@gmail.com>, dsterba@suse.com, clm@fb.com,
 wqu@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, r33s3n6@gmail.com, zzzccc427@gmail.com,
 stable@vger.kernel.org
References: <20260310075447.2088205-1-gality369@gmail.com>
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
In-Reply-To: <20260310075447.2088205-1-gality369@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C69472472D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-223787-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,suse.com,fb.com];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action



在 2026/3/10 18:24, ZhengYuan Huang 写道:
> clean_dirty_subvols() walks rc->dirty_subvol_roots during relocation
> recovery at mount time. That list can contain both normal subvolume
> roots and orphan relocation roots.
> 
> For normal subvolume roots, clean_dirty_subvols() first removes
> root->reloc_dirty_list from rc->dirty_subvol_roots and then drops the
> associated relocation tree. But for orphan relocation roots it directly
> calls btrfs_drop_snapshot(root, false, true) without unlinking
> root->reloc_dirty_list first.
> 
> This leaves a freed btrfs_root still linked in rc->dirty_subvol_roots.
> Later list_del_init() on a neighboring entry writes through that stale
> list node, triggering a slab-use-after-free in clean_dirty_subvols().

The analyze is correct.

[...]
> Fixes: 30d40577e322 ("btrfs: reloc: Also queue orphan reloc tree for cleanup to avoid BUG_ON()")
> Cc: stable@vger.kernel.org # 5.1+
> Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
> ---
> Root cause
> ==========

Tell your AI/LLM or whatever to listen to the feedback.

> clean_dirty_subvols() walks rc->dirty_subvol_roots, which can contain
> both normal subvolume roots and orphan relocation roots.
> 
> For normal roots, it first removes root->reloc_dirty_list from the list
> before dropping the related relocation tree. But for orphan relocation
> roots it calls btrfs_drop_snapshot(root, false, true) directly, without
> unlinking root->reloc_dirty_list first.
> 
> btrfs_drop_snapshot() can free the last reference to root via
> btrfs_put_root(), leaving a freed btrfs_root still linked in
> rc->dirty_subvol_roots. Later list_del_init() on a neighboring entry
> writes through that stale list node and triggers the slab-use-after-free.
> 
> Reproduction (v6.18, x86_64, KASAN)
> ===================================

This section is useless as commit message, and that's the only part that 
should be kept after the "---" line.

[...]
> 
> Fix
> ===
> Remove orphan relocation roots from rc->dirty_subvol_roots before
> calling btrfs_drop_snapshot() on them.
> 
> That restores the normal list lifetime rule:
>    unlink from external containers first,
>    then allow the final put/free to happen.
> 
> This is a minimal fix. Since both branches now call
> list_del_init(&root->reloc_dirty_list), it may be possible to move the
> unlink before the if/else and simplify the flow. I left that out here to
> avoid changing more than needed, but I can respin the patch that way if
> preferred.
> 
> KASAN reports
> =============

Put this important info into changelog, and this is not the first time I 
or other reviewing asking you to do it.

With all these fixed it looks good to me.

Thanks,
Qu

