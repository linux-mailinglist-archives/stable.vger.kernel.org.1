Return-Path: <stable+bounces-146126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F7EAC15D6
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 23:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947B39E62D1
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 21:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F24B253B70;
	Thu, 22 May 2025 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Uf+3xo26"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFDA7DA73
	for <stable@vger.kernel.org>; Thu, 22 May 2025 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747948631; cv=none; b=CzpbV+Nj90HKg2SkHt0NdOzPttmkrl8MPw5XMVCxrT0Me1TGFRugbu2REPjK53/DHBH/ydum+VhNvxEHxXj8B1gFAkjM8vH1uFGn2GBc0n0VSUwnRj9nrVEnrlxF5tuNX5zmhZfEmEArg5zik0FYv1+nmSSNoxEQ21yMf6HgrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747948631; c=relaxed/simple;
	bh=YihQFKRF74Bjoh1EUPzOaaXw9HSnytSqsDbdz34pJgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ofr1HrkHoAAKHN4xaEXg9uWQphSmbqzOEkBa1/3xFc3KETa7QOpd4ceB+cAaU487X46Taws2Uf/WiGjJp2lB7SQeFH83kexGEFHv9UggHozttUIjizawocNzCLNFCJbazmorXw+pfb+MajjPumdNW/bVcnO00dk/x0K8we0d1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Uf+3xo26; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a36ab95a13so3469015f8f.3
        for <stable@vger.kernel.org>; Thu, 22 May 2025 14:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747948628; x=1748553428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hgpHTTT5wc4kb5CIm81irDTyG0eIY0KsQ3MaiwBFCeo=;
        b=Uf+3xo26VYmGi+ZJUDBmY23bXqcegq2tgjq655nj5NvWwlqWLo4+eQ6GFiUfK6h/iY
         /uh+CWv61cbcbND29KvGXgzr9xn4+5oAFVCtmyC0k3HQuUlyHpNESc8nSHfzZFRD3fgo
         XTXlhZ3fccBSsLSsGGn2A0A6FV6gO1zHlsAgG3q32/le67M4BnGRdX23t5FhNX3idPLn
         Z2LxzYOJgCqht61qHedHl68pfmKM6MOefKfJBJ99RcLhW6JM8ImtCgU9BeGBgbU8z7aH
         6q9L0WAYa42OX1K3jEf5uv/m8V0xy5iFJuhKuzmXaxi2i7djXjH8LHv6YyA2HVWeuNTt
         m+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747948628; x=1748553428;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgpHTTT5wc4kb5CIm81irDTyG0eIY0KsQ3MaiwBFCeo=;
        b=QQsDHj0az1rrpwCwCz7mxcijn393muVMcljwrmLUFxt7NtGbu/hO4OuhZmmY/3EjEn
         0H8HkaAMMng+tnJ8+xwZN2U7fgrUM2/BYYs/l5ppC/kCClEW3bM0EsqXhQZbiPZCGWSV
         HHTut4hhiVCAvH8wn35u9oS3JibZ4rZBT0M1O8HxUrzE1o6jkoyr26zUfgTsVqsvWPwo
         2kIcf3KKY7SWvhWKWvezw1T6Txi9zcPRnQjsbE5szgnDmQvHStBlS9t/QUY7+9oy6pG7
         8uggN9Ui1z3U9RWq3luvXFuZH+cmSfMhTsoyixHD/VC7FVPaPO+0fci247TEDe7kSOMz
         VE7w==
X-Gm-Message-State: AOJu0YxBoS4LlZAaH4HGFJfhguiOTR9/Gap/a/VvMHpnUX0vAOO4nlL3
	p4SAg0NFhdS0gxgyGpRdTTz9zyRk3H3HOXM0XB6yzCRcFo0kHk5lPzup6lABnD0AAE1xTnTE5fa
	vljvO
X-Gm-Gg: ASbGncsioMapejVnUpCv9OXYBmcDEC9RIvIy31L6RHQdDI5H7bOAqN4kcJSi1gaVE4+
	+DxKyjs4+woxQ7wB1Rmpl5FbkHc+ESDpoyzOXNxlpwJQMFQsMWPjF2NeJG7tWFbOLbeSwSHu++L
	UwwM2VpCxojKvJ9trqLXtVjvn4KEgBXh5KfDnRFdmpCHCyXIS1GqllZ2SinR/ysgkVq46AZpMlA
	IvWnhDBCKjVrhCR+ft1YrQo+8AjMNQJEyecakU7+XIgrwt3XOgZG+/0ekSfUA8YjAizEfMxrXds
	SXrR7DdDbtWNWl24QxwzT04tHOL8GBDFP1ZJWLJainJ4G7UKMLo0PiiIDm8sy+eueOHSNkEY7rd
	K8eU=
X-Google-Smtp-Source: AGHT+IGBaFuj3tvHNXnk++ys61vhi8FoST3ZYaex/kaNeTk28pq+4dEF+xam9qrBR/iCuMo9fwmiZw==
X-Received: by 2002:a05:6000:1848:b0:3a3:64d5:5b5b with SMTP id ffacd0b85a97d-3a364d55c21mr21108052f8f.5.1747948627662;
        Thu, 22 May 2025 14:17:07 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eba368sm113120955ad.200.2025.05.22.14.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 14:17:07 -0700 (PDT)
Message-ID: <532514ac-dbed-4805-8baf-c4bd869df333@suse.com>
Date: Fri, 23 May 2025 06:46:30 +0930
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "btrfs: properly limit inline data extent according to
 block size" has been added to the 6.14-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
References: <20250522210544.3118226-1-sashal@kernel.org>
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
In-Reply-To: <20250522210544.3118226-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/23 06:35, Sasha Levin 写道:
> This is a note to let you know that I've just added the patch titled
> 
>      btrfs: properly limit inline data extent according to block size
> 
> to the 6.14-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       btrfs-properly-limit-inline-data-extent-according-to.patch
> and it can be found in the queue-6.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please drop this patch.

This is mostly for the incoming large folios support for btrfs.

For older kernels this patch will not cause any behavior change.

Thanks,
Qu>
> 
> 
> commit ec02842137bdccb74ed331a1b0a335ee22eb179c
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Tue Feb 25 14:30:44 2025 +1030
> 
>      btrfs: properly limit inline data extent according to block size
>      
>      [ Upstream commit 23019d3e6617a8ec99a8d2f5947aa3dd8a74a1b8 ]
>      
>      Btrfs utilizes inline data extent for the following cases:
>      
>      - Regular small files
>      - Symlinks
>      
>      And "btrfs check" detects any file extents that are too large as an
>      error.
>      
>      It's not a problem for 4K block size, but for the incoming smaller
>      block sizes (2K), it can cause problems due to bad limits:
>      
>      - Non-compressed inline data extents
>        We do not allow a non-compressed inline data extent to be as large as
>        block size.
>      
>      - Symlinks
>        Currently the only real limit on symlinks are 4K, which can be larger
>        than 2K block size.
>      
>      These will result btrfs-check to report too large file extents.
>      
>      Fix it by adding proper size checks for the above cases.
>      
>      Signed-off-by: Qu Wenruo <wqu@suse.com>
>      Reviewed-by: David Sterba <dsterba@suse.com>
>      Signed-off-by: David Sterba <dsterba@suse.com>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a06fca7934d55..9a648fb130230 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -583,6 +583,10 @@ static bool can_cow_file_range_inline(struct btrfs_inode *inode,
>   	if (size > fs_info->sectorsize)
>   		return false;
>   
> +	/* We do not allow a non-compressed extent to be as large as block size. */
> +	if (data_len >= fs_info->sectorsize)
> +		return false;
> +
>   	/* We cannot exceed the maximum inline data size. */
>   	if (data_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info))
>   		return false;
> @@ -8671,7 +8675,12 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>   	struct extent_buffer *leaf;
>   
>   	name_len = strlen(symname);
> -	if (name_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info))
> +	/*
> +	 * Symlinks utilize uncompressed inline extent data, which should not
> +	 * reach block size.
> +	 */
> +	if (name_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info) ||
> +	    name_len >= fs_info->sectorsize)
>   		return -ENAMETOOLONG;
>   
>   	inode = new_inode(dir->i_sb);


