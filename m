Return-Path: <stable+bounces-93029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E1D9C8EF0
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 17:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0B01F21DE8
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 16:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E257154BEE;
	Thu, 14 Nov 2024 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldA5tK4d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D7953365
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599736; cv=none; b=fqbanu1K6nVab9Zpcx4rMcxB7Hj8Hw0DKPc7KjmRMoAfMdEr/aA9vswG31vhzKUFrKvhUq/NhoxPz9evLGbnGwn4+ClYn2Lq4h5tfgLShthDzoPBi8D77Bwzr15VRPgmDNPuvmVi08mfpk5++dBpYUA5Xky2CkNscoBPhBmwA4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599736; c=relaxed/simple;
	bh=vCyyEd6pkFvue7SusBX2mUE+XRMkJq1uq9wey+3EqXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPlnmwWlRFVXvTk0r3o5CmMaxSkWpekamq1LfyK2yGz2jT4DL99tZUakEtJA33gxmi/rrBqI34SpzGoLPY9yGoZyKGq0/4fH3A1HTGPGX1leuvKDHhwnTeZizC3KNziskFRr0Y6eGUFxQD9DOfD1VM/a1rrrum00NvawOh6b9BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldA5tK4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4DBC4CECD;
	Thu, 14 Nov 2024 15:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731599735;
	bh=vCyyEd6pkFvue7SusBX2mUE+XRMkJq1uq9wey+3EqXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ldA5tK4dGI0oFe8ui5P3TJKRGLRmtiIB7Itx0/mpAA5KiMD/NbgtX//LPNsYuigUf
	 aa/cw2ef7ELzPgOcm8Bqi/j9xNaR4uQpiqMi+g3VFvYOZRNkDAXoI+yrbsX7D6F6ad
	 EhNr+823dbLEX5KnwJsEtMp4/JK2K/E9PIfyjLiAoyzu3VbSHaC5s3KPARuwHmIvug
	 Lf+dmWXFnsLy2UwG3hmweKgZbKetsv0FgEDr7DIx36nLRRqGe1cfDTZYiYC/ud+CrY
	 XzsbElBUUO5Gt8Z8e5UNxuuMPFjQ7K6hmbqCfIxYg2r2v456Aqq+njSTwCiibM1nzV
	 7EORlFLqun0ag==
Date: Thu, 14 Nov 2024 07:55:35 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hans Holmberg <hans.holmberg@wdc.com>, stable@vger.kernel.org,
	Zizhi Wo <wozizhi@huawei.com>
Subject: Re: [PATCH 5/7] xfs: fix off-by-one error in fsmap's end_daddr usage
Message-ID: <20241114155535.GM9462@frogsfrogsfrogs>
References: <20241114153353.318020-1-hch@lst.de>
 <20241114153353.318020-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114153353.318020-6-hch@lst.de>

On Thu, Nov 14, 2024 at 04:33:49PM +0100, Christoph Hellwig wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> In commit ca6448aed4f10a, we created an "end_daddr" variable to fix
> fsmap reporting when the end of the range requested falls in the middle
> of an unknown (aka free on the rmapbt) region.  Unfortunately, I didn't
> notice that the the code sets end_daddr to the last sector of the device
> but then uses that quantity to compute the length of the synthesized
> mapping.

Er... I'm not sure why you're sending this patch to Hans and stable but
not linux-xfs?  Also it's already on the list, though nobody's responded
to it yet:

https://lore.kernel.org/linux-xfs/20241108173907.GB168069@frogsfrogsfrogs/

--D

> Zizhi Wo later observed that when end_daddr isn't set, we still don't
> report the last fsblock on a device because in that case (aka when
> info->last is true), the info->high mapping that we pass to
> xfs_getfsmap_group_helper has a startblock that points to the last
> fsblock.  This is also wrong because the code uses startblock to
> compute the length of the synthesized mapping.
> 
> Fix the second problem by setting end_daddr unconditionally, and fix the
> first problem by setting start_daddr to one past the end of the range to
> query.
> 
> Cc: <stable@vger.kernel.org> # v6.11
> Fixes: ca6448aed4f10a ("xfs: Fix missing interval for missing_owner in xfs fsmap")
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Reported-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>  fs/xfs/xfs_fsmap.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
> index 8d5d4d172d15..59b7a8e50414 100644
> --- a/fs/xfs/xfs_fsmap.c
> +++ b/fs/xfs/xfs_fsmap.c
> @@ -165,7 +165,8 @@ struct xfs_getfsmap_info {
>  	xfs_daddr_t		next_daddr;	/* next daddr we expect */
>  	/* daddr of low fsmap key when we're using the rtbitmap */
>  	xfs_daddr_t		low_daddr;
> -	xfs_daddr_t		end_daddr;	/* daddr of high fsmap key */
> +	/* daddr of high fsmap key, or the last daddr on the device */
> +	xfs_daddr_t		end_daddr;
>  	u64			missing_owner;	/* owner of holes */
>  	u32			dev;		/* device id */
>  	/*
> @@ -388,8 +389,8 @@ xfs_getfsmap_group_helper(
>  	 * we calculated from userspace's high key to synthesize the record.
>  	 * Note that if the btree query found a mapping, there won't be a gap.
>  	 */
> -	if (info->last && info->end_daddr != XFS_BUF_DADDR_NULL)
> -		frec->start_daddr = info->end_daddr;
> +	if (info->last)
> +		frec->start_daddr = info->end_daddr + 1;
>  	else
>  		frec->start_daddr = xfs_gbno_to_daddr(xg, startblock);
>  
> @@ -737,8 +738,8 @@ xfs_getfsmap_rtdev_rtbitmap_helper(
>  	 * we calculated from userspace's high key to synthesize the record.
>  	 * Note that if the btree query found a mapping, there won't be a gap.
>  	 */
> -	if (info->last && info->end_daddr != XFS_BUF_DADDR_NULL) {
> -		frec.start_daddr = info->end_daddr;
> +	if (info->last) {
> +		frec.start_daddr = info->end_daddr + 1;
>  	} else {
>  		frec.start_daddr = xfs_rtb_to_daddr(mp, start_rtb);
>  	}
> @@ -1108,7 +1109,10 @@ xfs_getfsmap(
>  	struct xfs_trans		*tp = NULL;
>  	struct xfs_fsmap		dkeys[2];	/* per-dev keys */
>  	struct xfs_getfsmap_dev		handlers[XFS_GETFSMAP_DEVS];
> -	struct xfs_getfsmap_info	info = { NULL };
> +	struct xfs_getfsmap_info	info = {
> +		.fsmap_recs		= fsmap_recs,
> +		.head			= head,
> +	};
>  	bool				use_rmap;
>  	int				i;
>  	int				error = 0;
> @@ -1185,9 +1189,6 @@ xfs_getfsmap(
>  
>  	info.next_daddr = head->fmh_keys[0].fmr_physical +
>  			  head->fmh_keys[0].fmr_length;
> -	info.end_daddr = XFS_BUF_DADDR_NULL;
> -	info.fsmap_recs = fsmap_recs;
> -	info.head = head;
>  
>  	/* For each device we support... */
>  	for (i = 0; i < XFS_GETFSMAP_DEVS; i++) {
> @@ -1200,17 +1201,23 @@ xfs_getfsmap(
>  			break;
>  
>  		/*
> -		 * If this device number matches the high key, we have
> -		 * to pass the high key to the handler to limit the
> -		 * query results.  If the device number exceeds the
> -		 * low key, zero out the low key so that we get
> -		 * everything from the beginning.
> +		 * If this device number matches the high key, we have to pass
> +		 * the high key to the handler to limit the query results, and
> +		 * set the end_daddr so that we can synthesize records at the
> +		 * end of the query range or device.
>  		 */
>  		if (handlers[i].dev == head->fmh_keys[1].fmr_device) {
>  			dkeys[1] = head->fmh_keys[1];
>  			info.end_daddr = min(handlers[i].nr_sectors - 1,
>  					     dkeys[1].fmr_physical);
> +		} else {
> +			info.end_daddr = handlers[i].nr_sectors - 1;
>  		}
> +
> +		/*
> +		 * If the device number exceeds the low key, zero out the low
> +		 * key so that we get everything from the beginning.
> +		 */
>  		if (handlers[i].dev > head->fmh_keys[0].fmr_device)
>  			memset(&dkeys[0], 0, sizeof(struct xfs_fsmap));
>  
> -- 
> 2.45.2
> 

