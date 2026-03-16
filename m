Return-Path: <stable+bounces-225702-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNxdDVRsuGn5dgEAu9opvQ
	(envelope-from <stable+bounces-225702-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:47:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 960312A05AC
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B9BF308CBC9
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828AE356A23;
	Mon, 16 Mar 2026 20:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AMdJt3LS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9612355F48
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 20:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773693976; cv=none; b=jy/UfrzmXVoc9C8Ow2sCX11/5/sqgAXdZKtjNSLsHL59AgmWlwuV34RPVBXJ5nHfOyK2c7FOyJci5XcPswZaE3YOeGQhB3U0t/wZXZes5FimCRYVY5642Il9PF7Q1uebQ/vt9t+sXYjVLNnAi58zlppUtKfdrOI73tsq6dODkFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773693976; c=relaxed/simple;
	bh=cfxy7m5SmaGK44qNGuo7u522WR7ogGxfc0kVM4B1qsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqVwbd2UczlUh+Hs01KsWzO6eRNUGSGddcLoKx9gltWELK53en9rOnv/mj/6ajsdClq/mAF9VFTzDzKWUyKDfjxlpySvc8efOoOO3QDbsoxxi3P6ovmKr5G2nVY6leNpqqVqrZp/gCKJqBjeUzeH1xdaPBLZJOCBjpMKpHCYJ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AMdJt3LS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48541edecf9so54657395e9.1
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773693973; x=1774298773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tchLCfMO3KOBdKYh3AzKmlQaSKhfRam2UpN/PpWJfaw=;
        b=AMdJt3LSpJf52qqp9hOc2PZ4/WkvXeu5NVicOu+eaqTE40xsyTGfb8yzVA4QAc1Q1o
         eWvMDk59xEeHrQSDUSaqGvk3PAWWyJMBqTluSSiVirAzB4MebUTNE5bF70xuuH1P0HDK
         V/NA+J283Ucx2NNRkZTp18BfIWjH7VoC/b4AN3A/4RWqomTEYENgYWgFOZ3ecTDWfkUu
         HEraiCQE8QMUMU7teZPZzU/8HOkinxVY33XtCFKzkPHVVXb2KrRggmecM4LgccTDsxeZ
         L0zjSL33YcSynCIgW/hHJzaKj3No+n705LOB1E5f1UDrdYok+z7iO+p0T0d8Iw/BZRWW
         K8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773693973; x=1774298773;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tchLCfMO3KOBdKYh3AzKmlQaSKhfRam2UpN/PpWJfaw=;
        b=GP8x7obsnesAUUY0cwPjkchmSl+OyB0ixFz4Ges/iPlawceZdHTTbRABbEfySDH2YV
         yVJajF0ldPRQmquO/a2T+agBMfFKj8Z3AU0GoJgpLzZBWjxjPqlni8HSoyTc4kqqifEd
         6KabY4mrS7+64NDFqdv8ITesG1jeNZHzQjw/plTjS6gqrJB5fp8+vSzPyt7cO+lsxlkW
         SMyRSlPSi75iPwmDjAhmCMyMNgqFnC/KJ6g1jiDI6uFP8I1rpdCTNPCGwjhd9Wmhjtc3
         +TA1GMpGgrSb/mDkPzXUUChb6WkrQVfJuNydvnlONICEypzpK23ZFqTX5D5g3ovPwjW/
         ExmA==
X-Forwarded-Encrypted: i=1; AJvYcCUEws80/gaBdbgN2fufn4sWyDgbLtzersBTkr6TQcdazixjOHNK7SL2AE+z04X6R6IglsK3MEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKdKHY53M7N0gQzC1/99YgXwUKpk5WQoh4C2IdtP06zQuC8xuR
	FC2JAhTIyKqG29Ivm6O1YqwVY1/+SXHmqhoACaGDcx2Wy2V2NrdMXy1b6eH1UIoFSZo=
X-Gm-Gg: ATEYQzyD3Hv7flN9XlR3jXxFLRTgQ0dwcTisSZZfUpLI69/SiIExJo/KyKYRU6TNdD6
	55GAOaP8r1GlH/OeJvXZ3P7jPlYUmvfq+Wr7zgZBC8/kYx+vBx/2Wnf3/EyORoAFSgLjzgbAFwA
	eDROUv+gK/iDjz+ou5HpLOZbxzzoyrLuGumPFitCOWmX9koqsaMRr3CRdUn89beqIcQYkYZVcl7
	Waog61tGi091eP/W6gf/upx9JHdCbfm1Sd05Ig/XOB5UGqYdqUGQmIiYKhiNESntT/ScQfazDGG
	j1vGrx46QSlSJASfYzC4dlL4k51aPWeEyuwleTMyNV+eYX5PSpVVQUeu5R7b54Te/IDfYxjtstR
	xGKTe4OixUDBgqji5t3zepZ/A/XiXhxZHgNn3So/H/6voIiFgP2d205QYPFHdoERGYrVz3nC0iv
	JphP9o05RNO8Yji4I5nqrEX5/KnoPk/SHnWLLtvWbeDadgTJ9SADw=
X-Received: by 2002:a05:600c:8489:b0:482:eec4:76d with SMTP id 5b1f17b1804b1-485566f7a2amr259118885e9.17.1773693973244;
        Mon, 16 Mar 2026 13:46:13 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07244071sm14734422b3a.6.2026.03.16.13.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 13:46:12 -0700 (PDT)
Message-ID: <f3497ad9-8ee6-4185-b935-013e596e764d@suse.com>
Date: Tue, 17 Mar 2026 07:16:06 +1030
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: balance: fix null-ptr-deref in
 btrfs_may_alloc_data_chunk
To: ZhengYuan Huang <gality369@gmail.com>, dsterba@suse.com, clm@fb.com,
 bo.li.liu@oracle.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, r33s3n6@gmail.com, zzzccc427@gmail.com,
 stable@vger.kernel.org
References: <20260316134640.2605237-1-gality369@gmail.com>
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
In-Reply-To: <20260316134640.2605237-1-gality369@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-225702-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,suse.com,fb.com,oracle.com];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: 960312A05AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/3/17 00:16, ZhengYuan Huang 写道:
> [BUG]
> Running btrfs balance can trigger a null-ptr-deref before relocating a
> data chunk when metadata corruption leaves a chunk in the chunk tree
> without a corresponding block group in the in-memory cache:
> 
>    KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
>    RIP: 0010:btrfs_may_alloc_data_chunk+0x40/0x1c0 fs/btrfs/volumes.c:3601
>    Call Trace:
>      __btrfs_balance fs/btrfs/volumes.c:4217 [inline]
>      btrfs_balance+0x2516/0x42b0 fs/btrfs/volumes.c:4604
>      btrfs_ioctl_balance fs/btrfs/ioctl.c:3577 [inline]
>      btrfs_ioctl+0x25cf/0x5b90 fs/btrfs/ioctl.c:5313
>      ...
> 
> [CAUSE]
> __btrfs_balance() iterates the on-disk chunk tree and passes the chunk
> logical bytenr to btrfs_may_alloc_data_chunk() before relocating a data
> chunk. That helper then queries the in-memory block group cache:
> 
>    cache = btrfs_lookup_block_group(fs_info, chunk_offset);
>    chunk_type = cache->flags;   /* cache may be NULL */
> 
> On a corrupt image can contain a chunk item whose matching block group
> item is missing, so no block group is ever inserted into the cache. In
> that case btrfs_lookup_block_group() returns NULL.

I'd say adding a proper chunk/bg mapping check is the root fix.

Or you'll need to adhoc a lot of null pointer checks.

> 
> The code only guards this with ASSERT(cache), which becomes a no-op when
> CONFIG_BTRFS_ASSERT is disabled. The subsequent dereference of
> cache->flags therefore crashes the kernel.
> 
> [FIX]
> Add a NULL check after btrfs_lookup_block_group() in
> btrfs_may_alloc_data_chunk(). If the lookup fails, emit a btrfs_err()
> message identifying the affected bytenr and return -EUCLEAN to report
> filesystem corruption instead of dereferencing NULL.
> 
> The caller already treats negative returns from
> btrfs_may_alloc_data_chunk() as fatal errors, so balance aborts cleanly
> and reports the corruption to userspace.
> 
> Fixes: a6f93c71d412 ("Btrfs: avoid losing data raid profile when deleting a device")
> Cc: stable@vger.kernel.org
> Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
> ---
>   fs/btrfs/volumes.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 4958e074d420..4657b826b48b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3597,7 +3597,12 @@ static int btrfs_may_alloc_data_chunk(struct btrfs_fs_info *fs_info,
>   	u64 bytes_used;
>   	u64 chunk_type;
>   
>   	cache = btrfs_lookup_block_group(fs_info, chunk_offset);
> -	ASSERT(cache);
> +	if (!cache) {
> +		btrfs_err(fs_info,
> +			  "balance: chunk at bytenr %llu has no corresponding block group",
> +			  chunk_offset);
> +		return -EUCLEAN;
> +	}
>   	chunk_type = cache->flags;
>   	btrfs_put_block_group(cache);
>   


