Return-Path: <stable+bounces-203223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA4ECD6843
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 16:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2DCA306F049
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 15:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E0B32A3FD;
	Mon, 22 Dec 2025 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SmEE3dN8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04D6324B16
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416880; cv=none; b=KqnFEVhv5o1PqLMHfuw3qM8gXXJYyx6E1j2IztJzMSdxsC3YM7TXr69xi1y7BR98CZ0mom3/jX6UvCEgnvkrnCi7O5WhJyRHG+UZRskcK7NHQLU7cCj6WG8mu6n0Ev0EounF0viDYM3Pio5uaIox1ivrj+DkgMYoGwzqqK2jJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416880; c=relaxed/simple;
	bh=jilGuhvtiRhmxes00FcFwryTusKzzs0Qxj5IRewUsb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/vBCmTqFPUnuzc/4lD4x5ghO6DK1HVe+/tEPFAkPK3+o6WTtcUepRz+nwP6eEbPPFMoTAER/2xtEk9RTK5oOTNsIVVx/LUSlYEl4PoDOeHyfjEq4vADEc4ubGqM3xsHbu0zVkR69G76jCHOFJzXLOKy+/NwPqL9441nULTDBF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SmEE3dN8; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b55ba1e62so277760f8f.2
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 07:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766416875; x=1767021675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=67683Yp4DfWYCEQ61cFljypiXMZpqTDwo/WPQ4r3APU=;
        b=SmEE3dN8wXlIoImf392mjOZ7WjThu7Iv/ZBBcDW5ggRZtMReQBRLC2wtlLm+ofQ1EH
         TbAKt18YNi7iddhhAtkpNiJF37pAjqagF1EHanbtgisuiupzQdLTraT9yKer2Qe9UGsM
         lKHTgDY7a5D208TbSbNOlOXRatfZJ4MdCYVifB/HCeSV9ZE7w77Ijp8Rl8CcE3iSQLe3
         bs1Oe/OBtrNXFiXdYMAihvkmkW0lSX5BgeFX+1WnO0ExcxKrvAkL1TULbPBmTtnS04xY
         YcOZcbjMttKCqlnUtTrPN2tFw3s6wz8CorD8hoio0nCKs/wpX4cjRoXjlNXykPPwvR2p
         yhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416875; x=1767021675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67683Yp4DfWYCEQ61cFljypiXMZpqTDwo/WPQ4r3APU=;
        b=o7fOk3m1aPX/s00ShT2nBO/6fktyzJ/oI6sb0rfMWwmOID6RoWGoXCy/xC2/IICPSg
         7t81fTtBO/ktRHAUHU8C8kfAl1qIShaRbsj0NQBuHc/MKwAC6m0xWJRa5k0CuJPXJgNT
         Za5J9tV3kF20c3ZjWy0q+Ej5N4Tzj+xQBGv0jtcVvrOrk/VZVNeHjtE2DHCVtV3FVXUc
         F0ZrymjF6NZ8vwqnQO2KGRCbjL3JRkWDW7+KfIWZw6kADPcQmg6dP8jdHuM4TjT7Bs4B
         7FN85KJ3OHOAEOIYLD2RieEDd8Unsd1yEqDPVYfke8RdmhNIMrX/SpWBAGFovbh1vdZW
         uX+w==
X-Forwarded-Encrypted: i=1; AJvYcCXTV+M+AXBmsn9r5YK2B5QbT3itN3mReOIC+iveZ3+SzvUffpVbGyGJu77UPDB0czIVbBbfV08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3NEjqD+DKz6ZckGuomB3xjElXYALn8IKImMMUvdaB5/hr2BTE
	qtEqD6mCm126/iqValYv/8GVZVToMJxjdVXAUtzZkpip3tFSpuv15m+ELXalGHCSqmo=
X-Gm-Gg: AY/fxX6sbR1UGFhlLl4ru0W6vjhZRPK9XHsagWpN6opLxgc1cwGzE9zmaQ7TMfdl3n5
	BH+nDmNQII08kkSgqrmE52XFH5CZs5FAVvvZPsOt2SILj4fKDndua0LR5niOhi+8mXJhruQMNFg
	bh+Xso5u11IZUQorQcudqolFQ8g0dZa7rO3TiURfG3PZnaSQYyr44h8CwFa2pKrO90bC1LFFZSX
	nwfFYUNyqTrU/s0/xg6XKT9TGCgudegXYya7dqzULllPChAFhzUAQUN1424/lDDEJ2ExHhBO8Rk
	70vQsuRgqCgulsJHWbEEDtmSVnlJmlzzYTsLxT0y3GlEGhrqdgtlYiTmNYQFHu/ZVjXYoMlft0q
	3haQs4x4HY742gEaaZqT9wHLShXO++rVjI7aoBVZlLq5hTrQEPVassOeCInNh8NLeBFf6Eq4WzQ
	comc9H5MdcSg==
X-Google-Smtp-Source: AGHT+IF1MMLXn8cF9gQ8Kub0saoElqwqDv43cL2DbrA9klBBpsVnAtBkl/8MYrLlslInXIb7mvfraA==
X-Received: by 2002:a05:600c:848c:b0:471:1387:377e with SMTP id 5b1f17b1804b1-47d195a0ccemr60957825e9.6.1766416875083;
        Mon, 22 Dec 2025 07:21:15 -0800 (PST)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d428sm100198035ad.73.2025.12.22.07.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:21:14 -0800 (PST)
Date: Mon, 22 Dec 2025 23:21:11 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: Prithvi Tambewagh <activprithvi@gmail.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	khalid@kernel.org, syzbot+af14efe17dfa46173239@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] ocfs2: Add check for total number of chains in chain list
Message-ID: <dcbfbwivj2pgid24lp7xynsli5v44fw5lskyg6r6yodr223irp@alqswzjnxmmu>
References: <20251220094928.134849-1-activprithvi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220094928.134849-1-activprithvi@gmail.com>

On Sat, Dec 20, 2025 at 03:19:28PM +0530, Prithvi Tambewagh wrote:
> The functions ocfs2_reserve_suballoc_bits(), ocfs2_block_group_alloc(),
> ocfs2_block_group_alloc_contig() and ocfs2_find_smallest_chain() trust
> the on-disk values related to the allocation chain. However, KASAN bug
> was triggered in these functions, and the kernel panicked when accessing
> redzoned memory. This occurred due to the corrupted value of `cl_count`
> field of `struct ocfs2_chain_list`. Upon analysis, the value of `cl_count`
> was observed to be overwhemingly large, due to which the code accessed
> redzoned memory.
> 
> The fix introduces an if statement which validates value of `cl_count`
> (both lower and upper bounds). Lower bound check ensures the value of
> `cl_count` is not zero and upper bound check ensures that the value of
> `cl_count` is in the range such that it has a value less than the total
> size of struct ocfs2_chain_list and maximum number of chains that can be
> present, so as to fill one block.
> 
> Reported-by: syzbot+af14efe17dfa46173239@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=af14efe17dfa46173239
> Tested-by: syzbot+af14efe17dfa46173239@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
> ---
>  fs/ocfs2/suballoc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
> index f7b483f0de2a..7ea63e9cc4f8 100644
> --- a/fs/ocfs2/suballoc.c
> +++ b/fs/ocfs2/suballoc.c
> @@ -671,6 +671,21 @@ static int ocfs2_block_group_alloc(struct ocfs2_super *osb,
>  	BUG_ON(ocfs2_is_cluster_bitmap(alloc_inode));
>  
>  	cl = &fe->id2.i_chain;
> +	unsigned int block_size = osb->sb->s_blocksize;
> +	unsigned int max_cl_count =
> +	(block_size - offsetof(struct ocfs2_chain_list, cl_recs)) /
> +	sizeof(struct ocfs2_chain_rec);
> +
> +	if (!le16_to_cpu(cl->cl_count) ||
> +	    le16_to_cpu(cl->cl_count) > max_cl_count) {
> +		ocfs2_error(osb->sb,
> +			    "Invalid chain list: cl_count %u "
> +			    "exceeds max %u",
> +			    le16_to_cpu(cl->cl_count), max_cl_count);
> +		status = -EIO;
> +		goto bail;
> +	}
> +
>  	status = ocfs2_reserve_clusters_with_limit(osb,
>  						   le16_to_cpu(cl->cl_cpg),
>  						   max_block, flags, &ac);
> 
> base-commit: 36c254515dc6592c44db77b84908358979dd6b50
> -- 
> 2.34.1
> 

Since 'fe' is read by ocfs2_read_inode_block(), the validation function
ocfs2_validate_inode_block() is the appropriate place to perform this sanity
check.

Please follow the pattern in commit e1c70505ee81 ("ocfs2: add extra consistency
checks for chain allocator dinodes") when adding your code.

btw, I am a little bit confused, it seems commit e1c70505ee81 is enough to fix
this syzbot issue.

Thanks,
Heming

