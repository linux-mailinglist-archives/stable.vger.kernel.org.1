Return-Path: <stable+bounces-146127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C49AC15D7
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 23:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89511C0127E
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 21:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B7F25485E;
	Thu, 22 May 2025 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GFLOi7dm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8CB25485C
	for <stable@vger.kernel.org>; Thu, 22 May 2025 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747948774; cv=none; b=S7yee032pEg+1906spiAJSrWIfaRMP20UOf5mbT8Yi42YVo+Bh/hwsJ7t54dc1SbHD+VX9TUUyx7VfWCuj+Y6QtkwgSqSEc/esuaosZnTzMrS1iKPK96y1F4jRU3h/EKuBu28x6eUfnjjbD12VI9IBNrfJH9WXTCUmIl5+K2piw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747948774; c=relaxed/simple;
	bh=BBKnRAPi0e7QaTOeCgBTonUanVg649xIKwDJZfoFIBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcaAiyOWd4aV4aE1n4gEEFvNzHMALK/FJkEWQQCiq36ZUZoxqHzO2CUruBShrVK38e0wKqxIRZ6JVM3ukBWrMaCR+EencLLysEaOmFexVyqPhYrFO0S+wtBOaYuYArT7nphLXkI3JqGx3RO2H2qrsegyavgYFjuzUt1OZWHbIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GFLOi7dm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a36e090102so2998478f8f.2
        for <stable@vger.kernel.org>; Thu, 22 May 2025 14:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747948769; x=1748553569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PH2YmKea+8HaOzYmFyz3BV5iotiuHGfzl2DuRWMm2O8=;
        b=GFLOi7dmjxhKJzcgnnnLBNUyk4QTCawM4T63bNnCAN0pm0VJo+j6SyaqIYnZ+3fdFp
         j6N1CoZcHtZiGG6wUEY8VQvTqRs/nJka2m/Kqbs2rJzDlXFEoXl16y9Ia5muy/3qaVmC
         dNrdCxZi0ydsvO3csyOaOcWd/qisLBaPkGqLNp4Jon/B1alR0o9DeaHAd2J9KzWUJ8Pp
         DugVsdByDnie6D1IXkEA/rO1Ro2lVO0XFgn3WoA543fBCh7eviNz0MSJc+TpbesgAr9L
         9CqYOankH+9iwR0ZZ2IgilwJCmUUKGxLZG0Aufmao9P5eh30biT8oJ7PQ/0r5U6SZMdX
         g+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747948769; x=1748553569;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PH2YmKea+8HaOzYmFyz3BV5iotiuHGfzl2DuRWMm2O8=;
        b=SO4icsKYSgasNJLG0t7p4A/IEJIRjPrpMK5DociUnXTjvPbHtIj6ODq1zAb8Coil7k
         oOC9jPMNi9kRU95M1FWqQ62p5b754YAZruGyHnfpIPnTGLVjF/p0ZeStVqiGobAmYPef
         zBDttsuqL98OhMbF0DyAgpd/Hyz23RjpReisNIZcGZg0YzfMUG5DBR0y591Jz52BnrEk
         lKw7kyvVm/ZpnkLjrJCZnH21e3CVKQZlkyCld+JWUOLMMeKLROQ8nUQHl3VnFCs++tMP
         AeLlDm13U1ExQVMUqSeY0fmYmwQpqM4obemlUJ5lHTjoZ8OC2RjhFO6AWT+F2qa/q9/D
         aaiw==
X-Gm-Message-State: AOJu0YzPdntQCzK89I9+Ra1LK2lcA8QBID6OWFoTLL6rL5RCJhci+tCU
	AN1e0PuHAUsURCqHWamyfQox7lYe2jh9RHuSoWl6DkCd8Iuj4gYEfnuN/9uM78nYXjVvkI4QsGt
	l84He
X-Gm-Gg: ASbGncstgasoP+zc87hZWZkTdbJt0VyCr5Ohknss5S5qbc0NcM2WMZWDAyuj258Tq9Y
	sJ5TXTb5Ux40jWv6gXPoPFwLPVi6GJX/ggkIAG4zC4z3wBVl4tJc5zI8v+dLcISKuTlyatP/krF
	iHvaseYNDM1s2seSGDhY+6PK2a1Ho8gQ61mxRkVXNYmgLuOSr3mXHDp8yF9eeCVPs/lPUxQ1nJY
	qcZpaSUf4kwuL3+o3t7TBdlzeLedbmEq9gpc6g58Zcch0YTFZ9BRFza1sgaYtkqCP4dQX8NMqp1
	ieaoXH4+TQGYxWgregGDuaiTWbKnVI1YSaEYrGk5F/owAhV2vHFtBPlwAgeSrkBKKvcjwdC9RET
	zTik=
X-Google-Smtp-Source: AGHT+IFiJRqKBWXRCCJxY4D1AJIRiJbmZ8E7qgzAhmex0nlgl/IP/1IrQwbTN1IoUl56SOi3jdqQbA==
X-Received: by 2002:a05:6000:2011:b0:3a3:6f1a:b8f9 with SMTP id ffacd0b85a97d-3a36f1aba52mr15953429f8f.15.1747948769365;
        Thu, 22 May 2025 14:19:29 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f364907d4sm5997273a91.24.2025.05.22.14.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 14:19:28 -0700 (PDT)
Message-ID: <3f1db027-b4df-4035-9d10-af6999d27f7f@suse.com>
Date: Fri, 23 May 2025 06:49:11 +0930
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "btrfs: prevent inline data extents read from touching
 blocks beyond its range" has been added to the 6.14-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
References: <20250522210553.3118311-1-sashal@kernel.org>
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
In-Reply-To: <20250522210553.3118311-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/23 06:35, Sasha Levin 写道:
> This is a note to let you know that I've just added the patch titled
> 
>      btrfs: prevent inline data extents read from touching blocks beyond its range
> 
> to the 6.14-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       btrfs-prevent-inline-data-extents-read-from-touching.patch
> and it can be found in the queue-6.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please drop this patch.

This is again a preparation patch for larger folios support of btrfs, 
and the optimization to dirty a block without reading the full page.

This patch alone doesn't cause any difference for older kernels and 
should not be backported.

Thanks,
Qu


> 
> 
> 
> commit 6a2d904623a8d1711b6b5065845d52cb3f2be60a
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Fri Nov 15 19:15:34 2024 +1030
> 
>      btrfs: prevent inline data extents read from touching blocks beyond its range
>      
>      [ Upstream commit 1a5b5668d711d3d1ef447446beab920826decec3 ]
>      
>      Currently reading an inline data extent will zero out the remaining
>      range in the page.
>      
>      This is not yet causing problems even for block size < page size
>      (subpage) cases because:
>      
>      1) An inline data extent always starts at file offset 0
>         Meaning at page read, we always read the inline extent first, before
>         any other blocks in the page. Then later blocks are properly read out
>         and re-fill the zeroed out ranges.
>      
>      2) Currently btrfs will read out the whole page if a buffered write is
>         not page aligned
>         So a page is either fully uptodate at buffered write time (covers the
>         whole page), or we will read out the whole page first.
>         Meaning there is nothing to lose for such an inline extent read.
>      
>      But it's still not ideal:
>      
>      - We're zeroing out the page twice
>        Once done by read_inline_extent()/uncompress_inline(), once done by
>        btrfs_do_readpage() for ranges beyond i_size.
>      
>      - We're touching blocks that don't belong to the inline extent
>        In the incoming patches, we can have a partial uptodate folio, of
>        which some dirty blocks can exist while the page is not fully uptodate:
>      
>        The page size is 16K and block size is 4K:
>      
>        0         4K        8K        12K        16K
>        |         |         |/////////|          |
>      
>        And range [8K, 12K) is dirtied by a buffered write, the remaining
>        blocks are not uptodate.
>      
>        If range [0, 4K) contains an inline data extent, and we try to read
>        the whole page, the current behavior will overwrite range [8K, 12K)
>        with zero and cause data loss.
>      
>      So to make the behavior more consistent and in preparation for future
>      changes, limit the inline data extents read to only zero out the range
>      inside the first block, not the whole page.
>      
>      Reviewed-by: Filipe Manana <fdmanana@suse.com>
>      Signed-off-by: Qu Wenruo <wqu@suse.com>
>      Signed-off-by: David Sterba <dsterba@suse.com>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 9a648fb130230..a7136311a13c6 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6779,6 +6779,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
>   {
>   	int ret;
>   	struct extent_buffer *leaf = path->nodes[0];
> +	const u32 blocksize = leaf->fs_info->sectorsize;
>   	char *tmp;
>   	size_t max_size;
>   	unsigned long inline_size;
> @@ -6795,7 +6796,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
>   
>   	read_extent_buffer(leaf, tmp, ptr, inline_size);
>   
> -	max_size = min_t(unsigned long, PAGE_SIZE, max_size);
> +	max_size = min_t(unsigned long, blocksize, max_size);
>   	ret = btrfs_decompress(compress_type, tmp, folio, 0, inline_size,
>   			       max_size);
>   
> @@ -6807,14 +6808,15 @@ static noinline int uncompress_inline(struct btrfs_path *path,
>   	 * cover that region here.
>   	 */
>   
> -	if (max_size < PAGE_SIZE)
> -		folio_zero_range(folio, max_size, PAGE_SIZE - max_size);
> +	if (max_size < blocksize)
> +		folio_zero_range(folio, max_size, blocksize - max_size);
>   	kfree(tmp);
>   	return ret;
>   }
>   
>   static int read_inline_extent(struct btrfs_path *path, struct folio *folio)
>   {
> +	const u32 blocksize = path->nodes[0]->fs_info->sectorsize;
>   	struct btrfs_file_extent_item *fi;
>   	void *kaddr;
>   	size_t copy_size;
> @@ -6829,14 +6831,14 @@ static int read_inline_extent(struct btrfs_path *path, struct folio *folio)
>   	if (btrfs_file_extent_compression(path->nodes[0], fi) != BTRFS_COMPRESS_NONE)
>   		return uncompress_inline(path, folio, fi);
>   
> -	copy_size = min_t(u64, PAGE_SIZE,
> +	copy_size = min_t(u64, blocksize,
>   			  btrfs_file_extent_ram_bytes(path->nodes[0], fi));
>   	kaddr = kmap_local_folio(folio, 0);
>   	read_extent_buffer(path->nodes[0], kaddr,
>   			   btrfs_file_extent_inline_start(fi), copy_size);
>   	kunmap_local(kaddr);
> -	if (copy_size < PAGE_SIZE)
> -		folio_zero_range(folio, copy_size, PAGE_SIZE - copy_size);
> +	if (copy_size < blocksize)
> +		folio_zero_range(folio, copy_size, blocksize - copy_size);
>   	return 0;
>   }
>   


