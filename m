Return-Path: <stable+bounces-180842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F70EB8E91C
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 00:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2966E16614B
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 22:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA2524BBE4;
	Sun, 21 Sep 2025 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eJN3w039"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BBA19CC02
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758494773; cv=none; b=bd7em3uMgV2WbgL0s5Fbl6yXzCmVM2VYZg+Xx2rNTuZlM1cUcCpuY8loCzx/Avkhtl7QQL3Iob3lOGIH3FCqrZBJ5Ahuivx7z50RzZh8MuyCvTrgSHHTD8ovD3z24a2ZZdA1JE80NPblaCqq8g42F0fmRUqw9Ou0fd/8IDXFdT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758494773; c=relaxed/simple;
	bh=myoAn27Kiu7+Z7Ku0EpbMDLTmOtMdUe+0AgAHuAtynk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aATs83cCypwhJZ5ZVbFwTBGmxbfcV7lg12hVwKx33IRNNvuwmqQFgigJK81vIJNa+b9op8DXDujFhX/8mC9RiC1az7hCbqwy0q3txxHS8M91Gi6iyzQgD0qUt4TMhtZr9WXA1Wk6qHGXyb8SxiK0lcts+tJWoryvQKna33Jf8oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eJN3w039; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so2631976f8f.3
        for <stable@vger.kernel.org>; Sun, 21 Sep 2025 15:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758494769; x=1759099569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fbm/f/f8NJbTwBN3NsUAHLQGjR4O4fldJJR4PWdJj2w=;
        b=eJN3w039vYFaFq1XD98tccdH/CmC52dt5rsMzTzrAO9FvzW0B2psXN3JQlUhzvrGJ8
         MDCOQTgZ8k2VUnbVQn/XpYAa950USjO7gt/wfHmeFQkdftvzY5W5kVhHoXjhAKFx4gcY
         gpCmP8ILp4IiRllwRn0QwYn9P7TQatB7bz4MMvUM8LeUSNfyCvkXO4DnBMG5kuwwzShS
         D0GI/tjspmxAqvE/UQ5gLa6jCkw/nzSsCw5NHjfuHLfTV5Bw4fre+m+fSuXeq8EUp/F+
         9PSm8jzUsvoBM7s2Dcj9fxVigSzwLLCB3Swk+hosGjjoEBj8V3dMtMUev2qmBuA9T++s
         E0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758494769; x=1759099569;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbm/f/f8NJbTwBN3NsUAHLQGjR4O4fldJJR4PWdJj2w=;
        b=N9LkN80MbWDX9jxExY9iByhVBZ4Zpygvcuab7gLcWSQyoz4pe1jPOv3JhZqzj+slcU
         QrrAuje1LjOv5efOM8+SzMK+WQ2QF8vugNdjGXvVUlGivOfWIQ5pRg4UCwGcn7KXUuAs
         hBbyP1W2kJsjlemdrWN9A4+zuwvSXrESB5IAh+NxVp9dUd8kvi9adgt9liV33K44yYo8
         T+zeF5vbr75Q5k9nBBGaH9czGwwsYYl3HamRIt7yMszkK+xXmki6RNSRGpA303xyf/mA
         x36N/bsVw5Yooymoyml5oU04y16+U72xGO2cSOFIcqrtvVh/XifXxgzQcdGO1BPwKKcs
         U2ZQ==
X-Gm-Message-State: AOJu0YxeoqjGU7F77jWdQh/61aLqmlmYalQyRseTDLCobSMkBSWy7cYO
	MyThXKU9ZnFWlGcTV1aPaRk9iGEczF+wFm/6CvtoKb9AXYcuu0/TR5zoiJ27lcEEyjw=
X-Gm-Gg: ASbGncsvlXwpIkDTwEcSy9aSdsy+aZFAeT4ruZzpKaF7KI52vgmahrE0nlC3dvO+vID
	yzl4y06V4Oqpf3gHI7XrR5CHGxbjblN2wDfrebJfPuYNbNMLMlvjtYyt6yZ8gZXUjZRJ8UgDSlM
	mpINp8rEPmyz24SRgOzU6hj5w82jeuf15Bi2b+A05fi4/ou0dJW2jC92NvwSaeQNpqonz3NWcje
	/IYZ7xY0RxhngtI2sGFQXEHlAeLzHrtRs6NKbkLG+xuhPyiWCnUGlrr/vhYKteXwI5zEy79LbkG
	7gqKXU/tygRDDVAY0inC5hbRecCw+w1WzpCxk5m1U3Ka7ycZdYcP4tIMc8EsofXfJZDSEuFw2fR
	wGyWM/3Pexf2EejMGIEe1e0d622nPJ5RJIqSO0TmLaqn9H1P8kv59vlDmLIuEcA==
X-Google-Smtp-Source: AGHT+IErIHGCQKyXmGsglEEDpU2V4PsZYFHbVJ7pqsVEv4bAocIXpUCCwvHo7+STQGVGeYBDGj0uBA==
X-Received: by 2002:a05:6000:2d12:b0:3fd:2dee:4e3d with SMTP id ffacd0b85a97d-3fd2dee5bb0mr1237569f8f.46.1758494769004;
        Sun, 21 Sep 2025 15:46:09 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff3fdb22sm10359741a12.25.2025.09.21.15.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 15:46:08 -0700 (PDT)
Message-ID: <f4350295-ae02-4284-bafd-4e3cf0579021@suse.com>
Date: Mon, 22 Sep 2025 08:16:05 +0930
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] btrfs: fix the incorrect @max_bytes value for
 find_lock_delalloc_range()
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
References: <cover.1758494326.git.wqu@suse.com>
 <8e713e74d2a2515727f5438e9f86f68ad2f4cceb.1758494327.git.wqu@suse.com>
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
In-Reply-To: <8e713e74d2a2515727f5438e9f86f68ad2f4cceb.1758494327.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

By somehow, the cover letter is not sent correctly, so here comes the 
cover letter:

[CHANGELOG]
v2:
- Add a new patch to fix the incorrect @max_bytes of
   find_lock_delalloc_range()
   This in fact also fixes a very rare corner case where bs < ps support
   is also affected.

   This allows us to re-enable extra large folios (folio > bs) for
   bs > ps cases.

RFC->v1
- Disable extra large folios for bs > ps mounts
   Such extra large folios are larger than a block.

   Still debugging, but disabling it makes 8K block size runs survive the
   full fs tests, with some minor failures due to the limitations.

   This may be something affecting regular large folios (folio > bs,
   but bs <= ps).

This series enables the initial bs > ps support, with several
limitations:

- No direct IO support
   All direct IOs fall back to buffered ones.

- No RAID56 support
   Any fs with RAID56 feature will be rejected at mount time.

- No encoded read/write/send
   Encoded send will fallback to the regular send (reading from page
   cache).
   Encoded read/write utilized by send/receive will fallback to regular
   ones.

Above limits are introduced by the fact that, we require large folios to
cover at least one fs block, so that no block can cross large folio
boundaries.

This simplifies our checksum and RAID56 handling.

The problem is, user space programs can only ensure their memory is
properly aligned in virtual addresses, but have no control on the
backing folios. Thus they can got a contiguous memory but is backed
by incontiguous pages.

In that case, it will break the "no block can cross large folio
boundaries" assumption, and will need a very complex mechanism to handle
checksum, especially for RAID56.

The same applies to encoded send, which uses vmallocated memory.

In the long run, we will need to support all those complex mechanism.

[FUTURE ROADMAP]
Currently bs > ps support is only to allow extra compatibility, e.g.
allowing x86_64 to mount a btrfs which is originally created on ppc64
(64K page size, 64K block size).

But this should also open a new door for btrfs RAID56 write hole
problems in the future, by enforcing a larger block size and fixed
power-of-2 data stripes, so that every write can fill a full stripe,
just like RAIDZ.

E.g. with 8K block size, all data writes are now in 8K sizes, and will
always be a full stripe write for a 3 disks RAID5 with a stripe length
of 4K.

This RAIDZ like solution will allow a much simpler RAID56 (no more RMW
any more), at the cost of a larger block size (more write-amplification,
higher memory usage etc).



在 2025/9/22 08:10, Qu Wenruo 写道:
> [BUG]
> With my local branch to enable bs > ps support for btrfs, sometimes I
> hit the following ASSERT() inside submit_one_sector():
> 
> 	ASSERT(block_start != EXTENT_MAP_HOLE);
> 
> Please note that it's not yet possible to hit this ASSERT() in the wild
> yet, as it requires btrfs bs > ps support, which is not even in the
> development branch.
> 
> But on the other hand, there is also a very low chance to hit above
> ASSERT() with bs < ps cases, so this is an existing bug affect not only
> the incoming bs > ps support but also the existing bs < ps support.
> 
> [CAUSE]
> Firstly that ASSERT() means we're trying to submit a dirty block but
> without a real extent map nor ordered extent map backing it.
> 
> Furthermore with extra debugging, the folio triggering such ASSERT() is
> always larger than the fs block size in my bs > ps case.
> (8K block size, 4K page size)
> 
> After some more debugging, the ASSERT() is trigger by the following
> sequence:
> 
>   extent_writepage()
>   |  We got a 32K folio (4 fs blocks) at file offset 0, and the fs block
>   |  size is 8K, page size is 4K.
>   |  And there is another 8K folio at file offset 32K, which is also
>   |  dirty.
>   |  So the filemap layout looks like the following:
>   |
>   |  "||" is the filio boundary in the filemap.
>   |  "//| is the dirty range.
>   |
>   |  0        8K       16K        24K         32K       40K
>   |  |////////|        |//////////////////////||////////|
>   |
>   |- writepage_delalloc()
>   |  |- find_lock_delalloc_range() for [0, 8K)
>   |  |  Now range [0, 8K) is properly locked.
>   |  |
>   |  |- find_lock_delalloc_range() for [16K, 40K)
>   |  |  |- btrfs_find_delalloc_range() returned range [0, 8K)
>   |  |  |- lock_delalloc_folios() succeeded.
>   |  |  |
>   |  |  |  The filemap range [32K, 40K) got dropped from filemap.
>   |  |  |
>   |  |  |- lock_delalloc_folios() failed with -EAGAIN.
>   |  |  |  As it failed to lock the folio at [32K, 40K).
>   |  |  |
>   |  |  |- loops = 1;
>   |  |  |- max_bytes = PAGE_SIZE;
>   |  |  |- goto again;
>   |  |  |  This will re-do the lookup for dirty delalloc ranges.
>   |  |  |
>   |  |  |- btrfs_find_delalloc_range() called with @max_bytes == 4K
>   |  |  |  This is smaller than block size, so
>   |  |  |  btrfs_find_delalloc_range() is unable to return any range.
>   |  |  \- return false;
>   |  |
>   |  \- Now only range [0, 8K) has an OE for it, but for dirty range
>   |     [16K, 32K) it's dirty without an OE.
>   |     This breaks the assumption that writepage_delalloc() will find
>   |     and lock all dirty ranges inside the folio.
>   |
>   |- extent_writepage_io()
>      |- submit_one_sector() for [0, 8K)
>      |  Succeeded
>      |
>      |- submit_one_sector() for [16K, 24K)
>         Triggering the ASSERT(), as there is no OE, and the original
>         extent map is a hole.
> 
> Please note that, this also exposed the same problem for bs < ps
> support. E.g. with 64K page size and 4K block size.
> 
> If we failed to lock a folio, and falls back into the "loops = 1;"
> branch, we will re-do the search using 64K as max_bytes.
> Which may fail again to lock the next folio, and exit early without
> handling all dirty blocks inside the folio.
> 
> [FIX]
> Instead of using the fixed size PAGE_SIZE as @max_bytes, use
> @sectorsize, so that we are ensured to find and lock any remaining
> blocks inside the folio.
> 
> And since we're here, add an extra ASSERT() to
> before calling btrfs_find_delalloc_range() to make sure the @max_bytes is
> at least no smaller than a block to avoid false negative.
> 
> Cc: stable@vger.kernel.org #5.15+
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index ca7174fa0240..2fd82055a779 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -393,6 +393,13 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
>   	/* step one, find a bunch of delalloc bytes starting at start */
>   	delalloc_start = *start;
>   	delalloc_end = 0;
> +
> +	/*
> +	 * If @max_bytes is smaller than a block, btrfs_find_delalloc_range() can
> +	 * return early without handling any dirty ranges.
> +	 */
> +	ASSERT(max_bytes >= fs_info->sectorsize);
> +
>   	found = btrfs_find_delalloc_range(tree, &delalloc_start, &delalloc_end,
>   					  max_bytes, &cached_state);
>   	if (!found || delalloc_end <= *start || delalloc_start > orig_end) {
> @@ -423,13 +430,14 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
>   				   delalloc_end);
>   	ASSERT(!ret || ret == -EAGAIN);
>   	if (ret == -EAGAIN) {
> -		/* some of the folios are gone, lets avoid looping by
> -		 * shortening the size of the delalloc range we're searching
> +		/*
> +		 * Some of the folios are gone, lets avoid looping by
> +		 * shortening the size of the delalloc range we're searching.
>   		 */
>   		btrfs_free_extent_state(cached_state);
>   		cached_state = NULL;
>   		if (!loops) {
> -			max_bytes = PAGE_SIZE;
> +			max_bytes = fs_info->sectorsize;
>   			loops = 1;
>   			goto again;
>   		} else {


