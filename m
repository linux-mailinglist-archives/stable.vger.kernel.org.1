Return-Path: <stable+bounces-98782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 047F39E5365
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 12:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA2318813B4
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 11:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753CC1DDA31;
	Thu,  5 Dec 2024 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KEDSO+2X"
X-Original-To: stable@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509081DF75B;
	Thu,  5 Dec 2024 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396954; cv=none; b=A6ay2fEjPRbVtytru/eYRaqGj5JgZZrYvXi5YDW006ZDszScaS1KR5DY7s0alzauP1EKoj+R2pQbw6DDtVY8l3OuEHcaHGpC4Zwbhxyke4TnPQSAOToqLuUu5Ol4FjEIHahX8/Hpsp2d1hXl9iMXuK9WWFOzBPqS9/6o92/peS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396954; c=relaxed/simple;
	bh=2lwv7PTuYJ1KSoCkZDbSJ2Fkk3xStOJzhn/LI+XU2d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtAhUSdShTThCgZATBJji9Gl+jgXYFyOnv+bRiO9w7MwYztZw9whemt9Bv2FABKqVsxiUG0nbNS6wDua4TxVvQbF1MTOnjw4YhNZydMHExcoB9xZdycCGTkkVRx0JwFwtx7u++ZltojWumebi6Eih+nAMuZO22Zc/M/tLnv5J6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KEDSO+2X; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733396947; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=F1uWlXiJdRS4YGgh84leHN/3o0Drua4QYRdsX3mwS+0=;
	b=KEDSO+2XvEvZvehACXFaeK3fvN+jFJk0SOxOPrEHz3tLkrqBpDSuu05nPGnlxjFnYcUh5e4L7k4B0d9el8nokwxQqRvuYQWRU8398jCO9y7z6+o3wFJ6vqYsN7XCDHcl3ZSg5DDsVW8FwY975RUyp8J74ooNOtzYqIqfCQaQ4dU=
Received: from 30.221.131.123(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WKt16k9_1733396946 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Dec 2024 19:09:07 +0800
Message-ID: <c994ac21-7412-4df2-b6d9-e810d8c6864b@linux.alibaba.com>
Date: Thu, 5 Dec 2024 19:09:06 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ocfs2: Revert "ocfs2: fix the la space leak when
 unmounting an ocfs2 volume"
To: Heming Zhao <heming.zhao@suse.com>, ocfs2-devel@lists.linux.dev,
 akpm <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241205104835.18223-1-heming.zhao@suse.com>
 <20241205104835.18223-2-heming.zhao@suse.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20241205104835.18223-2-heming.zhao@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/5/24 6:48 PM, Heming Zhao wrote:
> This reverts commit dfe6c5692fb5 ("ocfs2: fix the la space leak when
> unmounting an ocfs2 volume").
> 
> In commit dfe6c5692fb5, the commit log "This bug has existed since the
> initial OCFS2 code." is wrong. The correct introduction commit is
> 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()").
> 
> The influence of commit dfe6c5692fb5 is that it provides a correct
> fix for the latest kernel. however, it shouldn't be pushed to stable
> branches. Let's use this commit to revert all branches that include
> dfe6c5692fb5 and use a new fix method to fix commit 30dd3478c3cd.
> 
> Fixes: dfe6c5692fb5 ("ocfs2: fix the la space leak when unmounting an ocfs2 volume")
> Signed-off-by: Heming Zhao <heming.zhao@suse.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> Cc: <stable@vger.kernel.org>
> ---
>  fs/ocfs2/localalloc.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
> index 8ac42ea81a17..5df34561c551 100644
> --- a/fs/ocfs2/localalloc.c
> +++ b/fs/ocfs2/localalloc.c
> @@ -1002,25 +1002,6 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
>  		start = bit_off + 1;
>  	}
>  
> -	/* clear the contiguous bits until the end boundary */
> -	if (count) {
> -		blkno = la_start_blk +
> -			ocfs2_clusters_to_blocks(osb->sb,
> -					start - count);
> -
> -		trace_ocfs2_sync_local_to_main_free(
> -				count, start - count,
> -				(unsigned long long)la_start_blk,
> -				(unsigned long long)blkno);
> -
> -		status = ocfs2_release_clusters(handle,
> -				main_bm_inode,
> -				main_bm_bh, blkno,
> -				count);
> -		if (status < 0)
> -			mlog_errno(status);
> -	}
> -
>  bail:
>  	if (status)
>  		mlog_errno(status);


