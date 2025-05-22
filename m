Return-Path: <stable+bounces-146128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9EEAC15D8
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 23:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4088E1C01662
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 21:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DAB254B06;
	Thu, 22 May 2025 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q1FYkYuk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2CF7DA73
	for <stable@vger.kernel.org>; Thu, 22 May 2025 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747948889; cv=none; b=V5PSEma5l24/G+D0ykqoA9QzN+I1O5YJI4gjzA19hjXtTP2q7TJrkho/2K8V+YNi/S33DJIL0poN+q0ZQ2dt2vJDt/cbgLpOrfIBtCJ9s314eSK4grmZqaReBZ3s3r7A9Hw8M+P/DKsc9iR9lnjAdFvX/uvD7cdeK5XP+oOmY8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747948889; c=relaxed/simple;
	bh=eQUm987GAOifXtJQfRQfYju0hvoo0t1YRLhADJaixnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uho/lKvLdf6ojqJ2mkgu+Wrge/X1BTObvQdoncDrwplPhEEG2z0xpCvALWR0oU9aZ7ubsBNkKZuqcs5vkrEcSX1FUA0+5ExgZaLIdapBxnxeXl8fxlY8UgbWGULZVVq3G2ijItb5+bTpU1YKV2Z1AA8+qX3uff3fdQK/GPmbsgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q1FYkYuk; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a37d24e607so2698088f8f.1
        for <stable@vger.kernel.org>; Thu, 22 May 2025 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747948885; x=1748553685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2hE3UTfZkn0Pd/k44vtU6byVe7DQxOh/y6oJzEXkOhE=;
        b=Q1FYkYukLO4XsRYIw/FRrvegNzQmLX2mLk4YLwG/Kt1hdZ0/mHIPZSnlj4CkBa+T2s
         OKLC3QhXI5J0+XPW8oJY2U0bS2nwjA2E+BnPYL8fi3RX/6Y9NINoa/jJYEc+K40Csbm8
         4Yzf02H1tvfS++zlqWerRcokCweIyGyC+h4h5zcSbowt5/ISw5B6IzqcAezz/YylXcVZ
         KbVz8Gxj3S+eesfYiGhD6jRqbAoZ+J/QoaSGnhWOsW4Zm++dy+N0B+qFrL4aSm7VHO/H
         j7jCIpiDlBb+vpTftcJ5t3g9w0D93TFFkMn0AlEW2IANAl/WBhYejPXg8lh0Ihc7g6UK
         levw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747948885; x=1748553685;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hE3UTfZkn0Pd/k44vtU6byVe7DQxOh/y6oJzEXkOhE=;
        b=LJZtuomqeZzk8A9k8isWNjpTUhfgDQecfV2pgA9WFUrMXtVeyQV+e+JsM2FJKR2IVK
         HyU8OZcmK5zzgewvjmMf9oFH1JkFjNbu82kJpbIC3xXnOdJ59ZKeGHSME5RVJfXVGhpo
         7vkJNoAVuqIwEUePRnipnguNZKzk6c67D2IeUrFf/yKSdZ+i1HNne5DPufoqrAgiN+rB
         TWsZYUqU6YKd1OGd3LgE1CGfKKC/J+YC9oFiR7rh6M+Vvmfv71sRlCJSPAAsp8wn6wOk
         HPdABbagXPYhgL21ctV2nYJybgYuDrhw9B3uP2M6CISJ4VTZ/FvS2d7JpVFL5a7bta/v
         Topw==
X-Gm-Message-State: AOJu0Yx7NzsoctmwQfIO3JYcmzHPRzpMVEvLgcAdxNDKk01vSMTZfRQa
	Tm5qS+qSSal0Jy+Tlola58z1T9M/Tp6Z+y6Bt8kreK95V83Ek/kRDeYjhMyXaoKLp0QtAz0Md8l
	ok1Cg
X-Gm-Gg: ASbGncu2XFVdlPg6PWijc6zxTrBJOkn7B6cB1AJF65gMW+pCKLfnoD0boG001EVhxn8
	uLlDVFPCNNxrtmsioW6Qyv1Fn9uWD8qJJCXonHohXQ9Bln12w60Lxim8chIO0DztWioR/0rNcC3
	LVlL+rua/NgkIyk7soNWTLmDikjaUB6M3vWKhoJ90ItB0mBSLdVcgtysiP/HVvoHoaw03gX+/33
	PmMzASo0gzrBkv5YiNd1mlVyTXUWqgHi9GjW5QIzpHFN2ZbfMYlbGPt47Lk2iBKym1OuhlsqZf3
	i50ke0M1bHKeVbg5AGOtQ14ELLdo4ha+uBJKu+aO6Dc7NIoWKtBo3X6rO7otHr2ySEiGDT5XAJS
	6sOCDthYgckvzUg==
X-Google-Smtp-Source: AGHT+IFK7+m3RiuyLSTeGlsVXt796+b9KbSzqz1MbOhhnoyik6YS5m2jiZxuMC3jGxiRYIuCzSTjow==
X-Received: by 2002:a05:6000:40c9:b0:3a1:fc5c:dec7 with SMTP id ffacd0b85a97d-3a35fe67788mr22345225f8f.21.1747948885352;
        Thu, 22 May 2025 14:21:25 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb081b06sm11756903a12.52.2025.05.22.14.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 14:21:24 -0700 (PDT)
Message-ID: <6377b61b-c16e-4d10-becc-53ac4af72725@suse.com>
Date: Fri, 23 May 2025 06:51:18 +0930
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "btrfs: allow buffered write to avoid full page read if
 it's block aligned" has been added to the 6.14-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
References: <20250522210549.3118269-1-sashal@kernel.org>
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
In-Reply-To: <20250522210549.3118269-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/23 06:35, Sasha Levin 写道:
> This is a note to let you know that I've just added the patch titled
> 
>      btrfs: allow buffered write to avoid full page read if it's block aligned
> 
> to the 6.14-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       btrfs-allow-buffered-write-to-avoid-full-page-read-i.patch
> and it can be found in the queue-6.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please drop this patch from all stable branches.

Although this patch mentions a failure in fstests, it acts more like an 
optimization for btrfs.

Furthermore it relies quite some patches that may not be in stable kernels.

Without all the dependency, this can lead to data corruption.

Please drop this one from all stable kernels.

Thanks,
Qu

> 
> 
> 
> commit de0860d610aaaee77a8c5c713c41fea584ac83b3
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Wed Oct 30 17:04:02 2024 +1030
> 
>      btrfs: allow buffered write to avoid full page read if it's block aligned
>      
>      [ Upstream commit 0d31ca6584f21821c708752d379871b9fce2dc48 ]
>      
>      [BUG]
>      Since the support of block size (sector size) < page size for btrfs,
>      test case generic/563 fails with 4K block size and 64K page size:
>      
>        --- tests/generic/563.out     2024-04-25 18:13:45.178550333 +0930
>        +++ /home/adam/xfstests-dev/results//generic/563.out.bad      2024-09-30 09:09:16.155312379 +0930
>        @@ -3,7 +3,8 @@
>         read is in range
>         write is in range
>         write -> read/write
>        -read is in range
>        +read has value of 8388608
>        +read is NOT in range -33792 .. 33792
>         write is in range
>        ...
>      
>      [CAUSE]
>      The test case creates a 8MiB file, then does buffered write into the 8MiB
>      using 4K block size, to overwrite the whole file.
>      
>      On 4K page sized systems, since the write range covers the full block and
>      page, btrfs will not bother reading the page, just like what XFS and EXT4
>      do.
>      
>      But on 64K page sized systems, although the 4K sized write is still block
>      aligned, it's not page aligned anymore, thus btrfs will read the full
>      page, which will be accounted by cgroup and fail the test.
>      
>      As the test case itself expects such 4K block aligned write should not
>      trigger any read.
>      
>      Such expected behavior is an optimization to reduce folio reads when
>      possible, and unfortunately btrfs does not implement such optimization.
>      
>      [FIX]
>      To skip the full page read, we need to do the following modification:
>      
>      - Do not trigger full page read as long as the buffered write is block
>        aligned
>        This is pretty simple by modifying the check inside
>        prepare_uptodate_page().
>      
>      - Skip already uptodate blocks during full page read
>        Or we can lead to the following data corruption:
>      
>        0       32K        64K
>        |///////|          |
>      
>        Where the file range [0, 32K) is dirtied by buffered write, the
>        remaining range [32K, 64K) is not.
>      
>        When reading the full page, since [0,32K) is only dirtied but not
>        written back, there is no data extent map for it, but a hole covering
>        [0, 64k).
>      
>        If we continue reading the full page range [0, 64K), the dirtied range
>        will be filled with 0 (since there is only a hole covering the whole
>        range).
>        This causes the dirtied range to get lost.
>      
>      With this optimization, btrfs can pass generic/563 even if the page size
>      is larger than fs block size.
>      
>      Reviewed-by: Filipe Manana <fdmanana@suse.com>
>      Signed-off-by: Qu Wenruo <wqu@suse.com>
>      Signed-off-by: David Sterba <dsterba@suse.com>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 06922529f19dc..13b5359ea1b77 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -974,6 +974,10 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
>   			end_folio_read(folio, true, cur, iosize);
>   			break;
>   		}
> +		if (btrfs_folio_test_uptodate(fs_info, folio, cur, blocksize)) {
> +			end_folio_read(folio, true, cur, blocksize);
> +			continue;
> +		}
>   		em = get_extent_map(BTRFS_I(inode), folio, cur, end - cur + 1, em_cached);
>   		if (IS_ERR(em)) {
>   			end_folio_read(folio, false, cur, end + 1 - cur);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index cd4e40a719186..61ad1a79e5698 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -804,14 +804,15 @@ static int prepare_uptodate_folio(struct inode *inode, struct folio *folio, u64
>   {
>   	u64 clamp_start = max_t(u64, pos, folio_pos(folio));
>   	u64 clamp_end = min_t(u64, pos + len, folio_pos(folio) + folio_size(folio));
> +	const u32 blocksize = inode_to_fs_info(inode)->sectorsize;
>   	int ret = 0;
>   
>   	if (folio_test_uptodate(folio))
>   		return 0;
>   
>   	if (!force_uptodate &&
> -	    IS_ALIGNED(clamp_start, PAGE_SIZE) &&
> -	    IS_ALIGNED(clamp_end, PAGE_SIZE))
> +	    IS_ALIGNED(clamp_start, blocksize) &&
> +	    IS_ALIGNED(clamp_end, blocksize))
>   		return 0;
>   
>   	ret = btrfs_read_folio(NULL, folio);


