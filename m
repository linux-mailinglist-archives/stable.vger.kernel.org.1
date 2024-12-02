Return-Path: <stable+bounces-96175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30E49E0E50
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 23:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626942824EC
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 22:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1591DF748;
	Mon,  2 Dec 2024 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I58nF3mV"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433A51DF736
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733177012; cv=none; b=iXder3uIvD/vZB/cCW5yo60sHXdR8AXSTT9Cl9AAAtBG3bhcST65ZLygEahpT1hOq+nCJVXHgkD7SLgS20TW8jSpe7XpTtYXd61GpNqGTG8F/z1EmdujahOdeZoAQ4svX6yq6LiLYh3taSnm7cLK3M3lPj4E4iGHIwswgOWvMKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733177012; c=relaxed/simple;
	bh=t2sbpG90tv+kHFMIuOUjKMR5egnpyGEoJwHV2cw/OG0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UwrxcZqw5E5ipLW6sWbqENB5E7m94LzHIRT0VjubGUOJFlJKujOzh5d44+MOF1oeLVaKVeC32UGAKjAAiZ5Y43yY8IDB1rR5ad3n3INKjTtghtfUIkhAwrC5jlq3yWurXLspoexAMlKTLCvY0t99sPTsMwsRVmaGn0woViLWWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I58nF3mV; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53dd59a2bc1so5257895e87.2
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 14:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733177008; x=1733781808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CCYe/X+N4yxUSPm2U4QFeIlReEJct4YN7qD6OCk0Du0=;
        b=I58nF3mVVa0lBm5mL4Y4htvZ0zQc3+LmOah2UFKKbMQeIC+W233RzWCiaufmS8B+sC
         nEhFIlKwVmhxYFkzihaB6rIm35e+4hVBEBCOLnpDe9A24UTPNv1Z51qTyvPHssnxnf76
         kJNLxFjRceDokZFvZtThoKM2zFda0xrivou14AFh3Ucl5SU7o99V/UF7+ANKbXTOV8rS
         AX3Ae7m90afwNzkb4dV0WPm80XBHQgl1f7dUh4ug7vp0L8k4eRw2onWDJh6oz4SdirVV
         /Cfu63KbOUm0k8UecGHf8mJeDNuQhNSFctCeCoqXnSNG+tBbk0sPJdntpUxWkAmL8Ykf
         m2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733177008; x=1733781808;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CCYe/X+N4yxUSPm2U4QFeIlReEJct4YN7qD6OCk0Du0=;
        b=s8REtKwJPUy06z/xLu7nuEBCxFRlrVwv6dLUCgWAy2mwFDvGnoJ7yn+OZicllXFDoj
         y1n+RR4v91CFyrmrrBcE3utm8Hen9YQb7woyMUG0935p15+dELbZ4LnrSzQMcDbU7/o9
         9kajU3WwDOPfQdifJ+b8vj1E2o7bBkOiBln9+76fI6cp5AFtCyfoqNvCpcknED6WGtjM
         gD/dnHQxXdTbJbcwg/SRpRtbybKozHRzGh3R3hXCwh611CB+BHi2cO3yJLv1KWLJpoeg
         UQCG7B+tSI6Xr7cu4Ci2QwtYR9LTk3cmlCKNHpWat8iuRez1LXgqXIoox909ahWueHpK
         jYNw==
X-Gm-Message-State: AOJu0YypS5M5LQjlGO1dYROFam/XXnLk1D7m6LWBPK126kE+0nYToJeU
	LV5BlpMD7P0AjDygpG8AsuW0AuqMA83C+yn0SKak7zlXiTLxfECqAbPJOMmqp0RgIx+TjEuuWtz
	Q
X-Gm-Gg: ASbGncszbjL4gBMQ6c5S75B3sOFKTYkHDcpLMz4K+AqVoXU6m8Aq+2QmJUxGZSR7nF7
	sR2kbI1mafp9RidHHSpA9cnso/1lZd1c8Zo6e9qcZO5DwONCKi4WLKnVzEUiF4FjuEi/QRr5qoJ
	xnbI599kFQzUlMN6XaDurX4xzml/dcu3adgi66doZBLAi06PL4t/OzEZc+RGzfMY71i4wr2Cwl8
	7YzF4r7XkjKQ9EhNnT2C98D/H8BUUWL4H9aHIP60L96mtr0oIpYM+XCq/xyPw346cxTTBgzlph4
	3g==
X-Google-Smtp-Source: AGHT+IFvJhLkD3P+e9EzZMKGo3iU8fH0bMD1SAeF1HmJ2cw0F4xJV6MZHZb1nAoXizih+Pv9WQumEg==
X-Received: by 2002:a05:6512:696:b0:53d:f173:efee with SMTP id 2adb3069b0e04-53e12a37936mr82586e87.47.1733177007730;
        Mon, 02 Dec 2024 14:03:27 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f511asm82320355ad.1.2024.12.02.14.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 14:03:27 -0800 (PST)
Message-ID: <48b8bbef-c62c-4d8a-859d-6a263e90c578@suse.com>
Date: Tue, 3 Dec 2024 08:33:23 +1030
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do proper folio cleanup when cow_file_range()
 failed
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
References: <42ee9dff1e240427f4a4d827c83e81b5598fe765.1733109950.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <42ee9dff1e240427f4a4d827c83e81b5598fe765.1733109950.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

My bad, the subject line is completely the same from the 
cow_file_range() fix, meanwhile it's for run_delalloc_nocow().

Forgot to modify the function name.

The newer version is submitted here, with subject line changed:
https://lore.kernel.org/linux-btrfs/4727cdf5b669acf42d93504f2c73434f330e4d59.1733176210.git.wqu@suse.com/

Thanks,
Qu

在 2024/12/2 13:58, Qu Wenruo 写道:
> Just like cow_file_range(), from day 1 btrfs doesn't really clean the
> dirty flags, if it has an ordered extent created successfully.
> 
> Per error handling protocol (according to the iomap, and the btrfs
> handling if it failed at the beginning of the range), we should clear
> all dirty flags for the involved folios.
> 
> Or the range of that folio will still be marked dirty, but has no
> EXTENT_DEALLLOC set inside the io tree.
> 
> Since the folio range is still dirty, it will still be the target for
> the next writeback, but since there is no EXTENT_DEALLLOC, no new
> ordered extent will be created for it.
> 
> This means the writeback of that folio range will fall back to COW
> fixup, which is being marked deprecated and will trigger a crash.
> 
> Unlike the fix in cow_file_range(), which holds the folio and extent
> lock until error or a fully successfully run, here we have no such luxury
> as we can fallback to COW, and in that case the extent/folio range will
> be unlocked by cow_file_range().
> 
> So here we introduce a new helper, cleanup_dirty_folios(), to clear the
> dirty flags for the involved folios.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/inode.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index e8232ac7917f..19e1b78508bd 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1969,6 +1969,46 @@ static int can_nocow_file_extent(struct btrfs_path *path,
>   	return ret < 0 ? ret : can_nocow;
>   }
>   
> +static void cleanup_dirty_folios(struct btrfs_inode *inode,
> +				 struct folio *locked_folio,
> +				 u64 start, u64 end, int error)
> +{
> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> +	struct address_space *mapping = inode->vfs_inode.i_mapping;
> +	pgoff_t start_index = start >> PAGE_SHIFT;
> +	pgoff_t end_index = end >> PAGE_SHIFT;
> +	u32 len;
> +
> +	ASSERT(end + 1 - start < U32_MAX);
> +	len = end + 1 - start;
> +
> +	/*
> +	 * Handle the locked folio first.
> +	 * btrfs_folio_clamp_*() helpers can handle range out of the folio case.
> +	 */
> +	btrfs_folio_clamp_clear_dirty(fs_info, locked_folio, start, len);
> +	btrfs_folio_clamp_set_writeback(fs_info, locked_folio, start, len);
> +	btrfs_folio_clamp_clear_writeback(fs_info, locked_folio, start, len);
> +
> +	for (pgoff_t index = start_index; index <= end_index; index++) {
> +		struct folio *folio;
> +
> +		/* Already handled at the beginning. */
> +		if (index == locked_folio->index)
> +			continue;
> +		folio = __filemap_get_folio(mapping, index, FGP_LOCK, GFP_NOFS);
> +		/* Cache already dropped, no need to do any cleanup. */
> +		if (IS_ERR(folio))
> +			continue;
> +		btrfs_folio_clamp_clear_dirty(fs_info, folio, start, len);
> +		btrfs_folio_clamp_set_writeback(fs_info, folio, start, len);
> +		btrfs_folio_clamp_clear_writeback(fs_info, folio, start, len);
> +		folio_unlock(folio);
> +		folio_put(folio);
> +	}
> +	mapping_set_error(mapping, error);
> +}
> +
>   /*
>    * when nowcow writeback call back.  This checks for snapshots or COW copies
>    * of the extents that exist in the file, and COWs the file as required.
> @@ -2228,6 +2268,22 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>   	return 0;
>   
>   error:
> +	/*
> +	 * We have some range with ordered extent created.
> +	 *
> +	 * Ordered extents and extent maps will be cleaned up by
> +	 * btrfs_mark_ordered_io_finished() later, but we also need to cleanup
> +	 * the dirty flags of folios.
> +	 *
> +	 * Or they can be written back again, but without any EXTENT_DELALLOC flag
> +	 * in io tree.
> +	 * This will force the writeback to go COW fixup, which is being deprecated.
> +	 *
> +	 * Also such left-over dirty flags do no follow the error handling protocol.
> +	 */
> +	if (cur_offset > start)
> +		cleanup_dirty_folios(inode, locked_folio, start, cur_offset - 1, ret);
> +
>   	/*
>   	 * If an error happened while a COW region is outstanding, cur_offset
>   	 * needs to be reset to cow_start to ensure the COW region is unlocked


