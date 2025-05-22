Return-Path: <stable+bounces-146137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E47AC1700
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 00:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3981C036F1
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 22:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2129929A337;
	Thu, 22 May 2025 22:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gOoMY/Du"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6706A29A329
	for <stable@vger.kernel.org>; Thu, 22 May 2025 22:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747954194; cv=none; b=Y37CLBd0IHGAvhyhAdvwTLfVuc/kcORbuCyZVIuVa8pbf5iM7azXA6DPDHTa0K3X9Cxuwg1OJc79LUkvzlpcEQiwpOS6FdfZEISFgCtngLC70+3wnlwngFPxIYaLInPWloXsJVZYluUZ6FE9EGUJoKDqAAI8CNUAS0tsLagyyOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747954194; c=relaxed/simple;
	bh=jxrNXEL9DUf1PCh2VmghehPgikW2AdmduPq8mBSTIvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mu3XZ2TY31TOWwvlgbwptiQcHCFS+fuht3fKqbEgb1tw8HLGNvPdESzWYMbd+p//ttAxPSx8FlrHfBZYzsUFtspld0M0uCUiJkUsZrcHw9NrizQeBhjAMsR7Ow8NQtN9djQY63Bir4w8IrUqxu0/oe+244nH8PyPXNkqY00T52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gOoMY/Du; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a37a243388so3474890f8f.1
        for <stable@vger.kernel.org>; Thu, 22 May 2025 15:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747954190; x=1748558990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3PuNWEe5fjuzj06kJSzMBCEJyE+xvQWPrnwaxZGyNLA=;
        b=gOoMY/Du6lHRhgCWfUeA/4QW274apJqYv0V/UA66L3Jgxaj58OdwJzMGX+AXZLe2X7
         +Al6K+SYbOBFBi/oufqUw+vSPqTN/IwozqMg5DfXfE/sF+GbOkS8z1/J0H/tEEmG5mMC
         brY3gB/Xd9n7ujejvSo6IJqmb0aRNJkboSJAHcgDz1L8le+cLiaTF6bYZch+ipCWjuhc
         uhieFt6emL9WSH0ULrQUJewffmJzsfmCHGznAIY+uT+Uk2DpNuipAtuqs3nl+IN8Jmeg
         bhU/TJyXcfhx00UCL1At1Rvp0oXJw89LbO2OytEr2kcLHu2yNVNgO9Bsj0O1srkMgtDe
         +Mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747954190; x=1748558990;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PuNWEe5fjuzj06kJSzMBCEJyE+xvQWPrnwaxZGyNLA=;
        b=O8bByNynSk/EzHmsFiCJiFh7WPiWVE6yAM0Si5qNV3locKwL63XN30Y+gDlGqaZ6Yu
         3NeTl0NHUyzA7AwP5V9+7FWDDaT12PeD4ZM8yO5XR6TuUk2XbdbOBABuO38JpI/YhXVn
         XIqa+9ldCjDqV7ccdn9lTryttWu+OXQgC31TGEQOEADTKPMa92CrVRM8058HylSEvM2m
         WzfiEpHRPmnzFtx7rWodWfe4ZhwwPCe+0rp0zFfiSGDQtChemBtZhNFdlfunnm3zDtje
         FeX/tWDVyq1XNImB1z8k5dfw3a8Rm0lTB0X24X8Zu/GprBFmMmyEDJadtCXOa/XqMhyZ
         wwKQ==
X-Gm-Message-State: AOJu0YwUMb8ei9n2CYw+QvcSRnIAyhdvfmj3QtSIsopY5y7U2pbgcTx+
	zh1TCN3rHnYC/9IZ4tPxK9v1nyIEd7g93iJ0p22ixWHe3jfxwEV++Aa0OMxlZW0gusegUscLqj9
	yMtjA
X-Gm-Gg: ASbGnculIeOR/KfdrF/BKZYO6E94kX3s2fdIA2h7xp0vicse1+4NzBlMXBVXPmJAemo
	fwgU9BTjmlLEwlXm/VA6xVEp/0bjCRz7zsP1IzJvRvsuNeEzR147d5F/Q6SNynyQkkiql3tOFav
	cTjzfXNrolV0M/19+KaN7IcCodFrzPDPynq7AAUFsJtbTJNZ392/ImZzt7fnpOUTqUzcErX0NuJ
	TlYYLgYmQAM7RczFF9pzEKPnNU1uQZxfbiFcAqo4CobMtJ7+eKN0QANozc7eVlIXD8W1mEaG4VV
	fzDO0/QjzkgpSs+PkFq36pPFETZv/XjR3egyJQkdxm/OOcJLBn4E8Oox2nPzMTDRY2yaU+cLewn
	2rCc=
X-Google-Smtp-Source: AGHT+IFPkRjp+KE0vV0pKqj8eE74QVIw/t1d80TqvPrQSrYJU/DUvC/QdmlkBPbqvE3glm0vkCnl6A==
X-Received: by 2002:adf:f50b:0:b0:3a3:5c97:d756 with SMTP id ffacd0b85a97d-3a35c97d8aamr20406280f8f.17.1747954189661;
        Thu, 22 May 2025 15:49:49 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac91c2sm113517225ad.36.2025.05.22.15.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 15:49:49 -0700 (PDT)
Message-ID: <2b5e840b-f187-4911-b26e-39471900aa35@suse.com>
Date: Fri, 23 May 2025 08:19:43 +0930
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "btrfs: prevent inline data extents read from touching
 blocks beyond its range" has been added to the 6.12-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
References: <20250522220141.3171905-1-sashal@kernel.org>
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
In-Reply-To: <20250522220141.3171905-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/23 07:31, Sasha Levin 写道:
> This is a note to let you know that I've just added the patch titled
> 
>      btrfs: prevent inline data extents read from touching blocks beyond its range
> 
> to the 6.12-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       btrfs-prevent-inline-data-extents-read-from-touching.patch
> and it can be found in the queue-6.12 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please drop this one from all stable trees.

Although the patch won't cause any behavior change, the main reason for 
this patch is to prepare for the subpage optimization (and future large 
folios support).

Thanks,
Qu

> 
> 
> 
> commit 98504dd74a2688ff63dba6bf1d9f8abc7f0b322e
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
> index 0da2611fb9c85..ee8c18d298758 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6825,6 +6825,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
>   {
>   	int ret;
>   	struct extent_buffer *leaf = path->nodes[0];
> +	const u32 blocksize = leaf->fs_info->sectorsize;
>   	char *tmp;
>   	size_t max_size;
>   	unsigned long inline_size;
> @@ -6841,7 +6842,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
>   
>   	read_extent_buffer(leaf, tmp, ptr, inline_size);
>   
> -	max_size = min_t(unsigned long, PAGE_SIZE, max_size);
> +	max_size = min_t(unsigned long, blocksize, max_size);
>   	ret = btrfs_decompress(compress_type, tmp, folio, 0, inline_size,
>   			       max_size);
>   
> @@ -6853,8 +6854,8 @@ static noinline int uncompress_inline(struct btrfs_path *path,
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
> @@ -6862,6 +6863,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
>   static int read_inline_extent(struct btrfs_inode *inode, struct btrfs_path *path,
>   			      struct folio *folio)
>   {
> +	const u32 blocksize = path->nodes[0]->fs_info->sectorsize;
>   	struct btrfs_file_extent_item *fi;
>   	void *kaddr;
>   	size_t copy_size;
> @@ -6876,14 +6878,14 @@ static int read_inline_extent(struct btrfs_inode *inode, struct btrfs_path *path
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


