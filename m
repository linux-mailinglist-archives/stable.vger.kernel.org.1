Return-Path: <stable+bounces-146136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7AFAC16FB
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 00:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 328387B193D
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 22:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6D9298272;
	Thu, 22 May 2025 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NptlPZCm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4A3299939
	for <stable@vger.kernel.org>; Thu, 22 May 2025 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747954093; cv=none; b=LynaDka9FhD8NV5Irq/IJhKfPayCcFo9eaR0Bhh2Rl3MdRt4He3B0buUaK9LHdyv81qZ1ASboZAFQwh2WY2jhtNmeKokyabZ4RZLUO/lRyvmACegNPDMF56npj+gBj7xNByT5wJT2ZYZ6oJwOqydzu/CDyxiulZYjQHZhBketXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747954093; c=relaxed/simple;
	bh=sLsghXGY4utUh9MNz/Ol4CvdEyqgpiuN0ca73MFdwiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stV+bTZUdcRoV01qKDEDrEO8ZpFR1q6XhnGG2XCnlCK4qJ3gPwTDbgeZJ9Ej5t+Q61U6qDwnAIHffv/cu3sgb8cSKkXVytBnDIyq8Pm8VeFG5WrU7WQHpriZ9VXh3bpmROHdiWaNvUp/Q9ahVqgDxWtb/vYpuatL5Uo5omWPfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NptlPZCm; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a35b7e60cbso245529f8f.1
        for <stable@vger.kernel.org>; Thu, 22 May 2025 15:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747954087; x=1748558887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zdibr74SfdkcUH0NWKuFoAjzbtjJnfSY2Zvq2R4YhAg=;
        b=NptlPZCmvUHFCYC7DN0FYPzt34ERxVtXH9T0/3kZ55siqLGZWQ8gJCht6dc2U1GATy
         xqcoIfCc/9M70dDDhtIyM8DUaXAH6YMOLYfoVMAf1cExrvACV0UJ9B4khwOYEvJn7b5U
         Qg0whC2ponI2ADQ66iUTzFikDCfi//iY2xaH4GFDnwWKxXzRSf/hwLxU9+6gToGbXjk8
         hINzt2RtUdJlyvgYyrV6tUTPFzc7HbKvSM8Gy5RCaYU6DyMbfxpFHFgW7OrytMG2DiTM
         nZk3af9cDhVzLaWFOwJZI6+AQqJ1DaTCoArzDkiAfp7zOtDlqYi4ZonAjGVhubHydaws
         pY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747954087; x=1748558887;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdibr74SfdkcUH0NWKuFoAjzbtjJnfSY2Zvq2R4YhAg=;
        b=F2OYNQsj0htoSZGXORsLagxbyVY6hIPw9MkcF6WAIWX76x6OuygFXvwnrN+hK2hDVZ
         MBwIDoLHMqqv0M5Npwi4x21qRX8KVFkO+PAbJCBlB3NWqRijzmOUxdzAaowzmVUXP0RU
         n2O5WVBSQXjKtiYRz1Lx0ZvAWB5tQzus9dt1zocNeWwA5TqT8qPSLkiSa1JdBn3aCR63
         BIbrY5cRXTTiVRC3D35Cs7fGDFb/iVrfpwGJauteuylMNFXNCDvSbJC8Jhopop3wU5g6
         NY+lUnPObLZfyINNIyEWewDZOpfpPFJXmhA5o5JFAxNMBoCEHILqdOAnBRgrcxQFgirc
         fvSA==
X-Gm-Message-State: AOJu0YzIiu5KJJt/mc+aQICSFUohy0FPo21ci6STt/2llJGxO0z+COpx
	aiqQpUXMTroPZK+XaZm5EsdfLpXT6A1Je0TUYId6GNScm4n5/eem2WUm+d1C3zthJiXI/pvtTV7
	VDsXG
X-Gm-Gg: ASbGncsbM4b92fbqFqSBUm3G04N17FnsnijRhTlvepMHoFp6flX4saA+bgTDiy3vf+e
	hfni4WrLRZlWhwcQbN1ijxo8UgLc7ZrYU9TY7xAwr9FdyVoA+zYpqRP6EqHGcTactZW/1n4Lg2u
	JqagNn/rluoabMWDoL+siPX1THDT2wpW7O/AGEiOkYioB7lnqHwXyAXNDw3fF699nX5O+3ru885
	1o07wY5/Wc+cb1XyIa6QYAUMmcYEDCaAyB0kDButJrVAFA0oMlFLDxgku3mBbkkTq00mefhUlIv
	8hCWecJN18t+kSU70EV5923iLL3i7Vj4r4EY8Vcoav9ztq82Q5HNBsNLu809E/RB4+POW8q638O
	Y0PA=
X-Google-Smtp-Source: AGHT+IHqRhzTJXdBu5wYJVtT07Y3T8g+IGGO1RUPiEC0uyvGBdz0weX9ApthegM9IoI1EnQlH0sEFQ==
X-Received: by 2002:a05:6000:184c:b0:3a3:699a:3108 with SMTP id ffacd0b85a97d-3a4c1508ad3mr1018008f8f.14.1747954087409;
        Thu, 22 May 2025 15:48:07 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e975f3sm113221645ad.117.2025.05.22.15.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 15:48:06 -0700 (PDT)
Message-ID: <872d4847-9092-4b9e-a7d6-5c2bae8e1cbf@suse.com>
Date: Fri, 23 May 2025 08:17:45 +0930
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "btrfs: properly limit inline data extent according to
 block size" has been added to the 6.12-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
References: <20250522220136.3171868-1-sashal@kernel.org>
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
In-Reply-To: <20250522220136.3171868-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/23 07:31, Sasha Levin 写道:
> This is a note to let you know that I've just added the patch titled
> 
>      btrfs: properly limit inline data extent according to block size
> 
> to the 6.12-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       btrfs-properly-limit-inline-data-extent-according-to.patch
> and it can be found in the queue-6.12 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please drop this patch from all stable trees.

This is only for a debug feature, 2K block size, and it will never be 
exposed to end users (only to allow people without a 64K page sized 
system to test subpage routine on x86_64).

Thanks,
Qu

> 
> 
> 
> commit a5afc96d757771c992eb3af4629a562ec52ba1dc
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
> index 9ce1270addb04..0da2611fb9c85 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -623,6 +623,10 @@ static bool can_cow_file_range_inline(struct btrfs_inode *inode,
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
> @@ -8691,7 +8695,12 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
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


