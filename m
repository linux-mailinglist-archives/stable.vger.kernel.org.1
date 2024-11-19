Return-Path: <stable+bounces-94037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544B19D2934
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 16:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9CC1F23D10
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED5B1CF293;
	Tue, 19 Nov 2024 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miF8vt0b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F49A1CCB35
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028821; cv=none; b=b8WCtVHJydnfjxWHa6tgwT0bmCtOarDgE2SdFqe+jfP66A1qhIVY8Axf0F1HfTJA3acNnVa/wIQntee+Y7SQNjoOgA7ROol1puvy81O/GbdkcPRXfO/86Yutm4QwXcejny43PEhtgnQqWHaDxAs1DDArSu633NO2h5A7XLm3D2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028821; c=relaxed/simple;
	bh=C0BMvvnyM/VsqTDPSeGtuFGg2cYakCjUj1uGBx5G4LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGy7oxtM9ztD/5M224hK//0TECTY8UT5PUDSPIgWcw66Nu9m2BWHc1oHNJXlIVjWE6jgjLgeuCgCp1Z1ZH0HTR+CtQeuAH8OQzSDiM56lupd/Jc8nAQyXZZDUyqCmYmbIVEhoyLLnMTqhQxZfJjZdFvTQdJve8Itm2zxsPjzgoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miF8vt0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40F6C4CEDB;
	Tue, 19 Nov 2024 15:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732028821;
	bh=C0BMvvnyM/VsqTDPSeGtuFGg2cYakCjUj1uGBx5G4LA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=miF8vt0bGmMlLuMd8+Arjq7+BsZRpi0/lAIObqi2/DB6eifbK7O6nUM5S2X6MwfFP
	 WfM3aw95vWQ+BBwyj571NFJSP4xH+akLzxNidkxJkhh/3i2q2o67R15t6g/OKkCLDn
	 H5Z8ZfBK9dhrQBcvb6RwWWkBb/U1EbuCZzy3o63P3VZdggerHEZJc0zzwu4dm281Py
	 WF12bHExTHyc6V7bVr71Oe4SoKLu9AV14wgjpIAAWRGTRUX+x+HqdgdCi6lSF0uCYr
	 WcbNtxJtxTHitusTGhwzcHrKx3fFTKkcEwDB+AzCrqn5/scgrvrDrgPKXP27p3pbJr
	 FUrR7YIn3kkwA==
Date: Tue, 19 Nov 2024 10:06:59 -0500
From: Sasha Levin <sashal@kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm: revert "mm: shmem: fix data-race in
 shmem_getattr()"" failed to apply to 5.15-stable tree
Message-ID: <Zzypk_27dpXEWAp3@sashalap>
References: <c27966fa-007b-97dd-c39c-10412539e9d3@google.com>
 <064fe883-6d13-15f4-1991-3f176c7d5c95@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <064fe883-6d13-15f4-1991-3f176c7d5c95@google.com>

On Mon, Nov 18, 2024 at 10:14:18PM -0800, Hugh Dickins wrote:
>On Mon, 18 Nov 2024, Sasha Levin wrote:
>
>> [ Sasha's backport helper bot ]
>>
>> Hi,
>>
>> The upstream commit SHA1 provided is correct: d1aa0c04294e29883d65eac6c2f72fe95cc7c049
>>
>> WARNING: Author mismatch between patch and upstream commit:
>> Backport author: Hugh Dickins <hughd@google.com>
>> Commit author: Andrew Morton <akpm@linux-foundation.org>
>>
>> Commit in newer trees:
>>
>> |-----------------|----------------------------------------------|
>> | 6.11.y          |  Present (different SHA1: 285505dc512d)      |
>> | 6.6.y           |  Present (different SHA1: 552c02da3b0f)      |
>> | 6.1.y           |  Not found                                   |
>> | 5.15.y          |  Not found                                   |
>> |-----------------|----------------------------------------------|
>>
>> Note: The patch differs from the upstream commit:
>> ---
>> --- -	2024-11-18 22:45:37.221809852 -0500
>> +++ /tmp/tmp.gWYpEchJE1	2024-11-18 22:45:37.214517918 -0500
>> @@ -1,3 +1,12 @@
>> +For 5.15 please use this replacement patch:
>> +
>> +>From 975b740a6d720fdf478e9238b65fa96e9b5d631a Mon Sep 17 00:00:00 2001
>> +From: Andrew Morton <akpm@linux-foundation.org>
>> +Date: Fri, 15 Nov 2024 16:57:24 -0800
>> +Subject: [PATCH] mm: revert "mm: shmem: fix data-race in shmem_getattr()"
>> +
>> +commit d1aa0c04294e29883d65eac6c2f72fe95cc7c049 upstream.
>> +
>>  Revert d949d1d14fa2 ("mm: shmem: fix data-race in shmem_getattr()") as
>>  suggested by Chuck [1].  It is causing deadlocks when accessing tmpfs over
>>  NFS.
>> @@ -13,21 +22,25 @@
>>  Cc: Yu Zhao <yuzhao@google.com>
>>  Cc: <stable@vger.kernel.org>
>>  Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> +Signed-off-by: Hugh Dickins <hughd@google.com>
>>  ---
>>   mm/shmem.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>>  diff --git a/mm/shmem.c b/mm/shmem.c
>> -index e87f5d6799a7b..568bb290bdce3 100644
>> +index cdb169348ba9..663fb117cd87 100644
>>  --- a/mm/shmem.c
>>  +++ b/mm/shmem.c
>> -@@ -1166,9 +1166,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
>> - 	stat->attributes_mask |= (STATX_ATTR_APPEND |
>> - 			STATX_ATTR_IMMUTABLE |
>> - 			STATX_ATTR_NODUMP);
>> +@@ -1077,9 +1077,7 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
>> + 		shmem_recalc_inode(inode);
>> + 		spin_unlock_irq(&info->lock);
>> + 	}
>>  -	inode_lock_shared(inode);
>> - 	generic_fillattr(idmap, request_mask, inode, stat);
>> + 	generic_fillattr(&init_user_ns, inode, stat);
>>  -	inode_unlock_shared(inode);
>>
>> - 	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
>> + 	if (shmem_is_huge(NULL, inode, 0))
>>   		stat->blksize = HPAGE_PMD_SIZE;
>> +--
>> +2.47.0.338.g60cca15819-goog
>> +
>> ---
>>
>> Results of testing on various branches:
>>
>> | Branch                    | Patch Apply | Build Test |
>> |---------------------------|-------------|------------|
>> | stable/linux-5.15.y       |  Success    |  Failed    |
>>
>> Build Errors:
>> Build error for stable/linux-5.15.y:
>
>Sorry, I've not received a mail like this before,
>and don't know what action to take in response to it.
>
>I notice that this 5.15 one says Build Test Failed: that's a surprise,
>it built for me on 5.15.173; but perhaps something has gone into the
>queue since then which causes it not to build?
>
>Or perhaps this is just a bot mail to be ignored?

It's something we're trying out to improve our efficiency around picking
up backports from the mailing list.

Given the bot failed to attach a build log, it seems like an issue with
the bot that I'll go fix. Sorry for the noise.

-- 
Thanks,
Sasha

