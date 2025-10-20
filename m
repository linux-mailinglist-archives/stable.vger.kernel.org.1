Return-Path: <stable+bounces-188228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11435BF3003
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 20:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A2D44F896A
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050FA2BF3F3;
	Mon, 20 Oct 2025 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMzbM0PG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59227257427;
	Mon, 20 Oct 2025 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986040; cv=none; b=JS/YzEeO3evQpj7b7EGfRmNi7aBshTvg1jDx4IOZ9R/f13lWnVau2p2trkFnMadiSsUeMM7lYgzGzvDUEOvXk/w9lsKJCcXu7fkBSjqN2LXzgcp9bYuHXuc+CPw1gYdIqbobNMdgO19jQZSsstIB+vZ3QFhXwmWky2/BsuUId8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986040; c=relaxed/simple;
	bh=gnl1t3TC19SYVzt3uOj7MhJzHUfsGVGM+sv1GmLS2yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQLGA4PkyD6Qqd9rmNfNd/pviNZUviVPkVsRV9Z/eK9/4knpwl/MQPjs+qHfxUJo30yCWZ8dHAdDBPjLnkLQSFrAXAVthjgOk5oNF+ERhE1Rv1tRQoV7pzaceFWLFgdkbJQuQ0Ce+kguqu8S3h2/g4B5VJmZ+wwTv75iU+FGzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMzbM0PG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29BAC116B1;
	Mon, 20 Oct 2025 18:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760986039;
	bh=gnl1t3TC19SYVzt3uOj7MhJzHUfsGVGM+sv1GmLS2yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMzbM0PGZp3HOY9ZNyHO1iC0r4Sq8qOzpgDH9NLeNRkfReZOYRjHnvsk//gyw+70F
	 LOy5Jhv2/HO40mExXv8jFGhswKoAenAmenn8rFLRMIF32Zg+xA7de8XW5M8T4CV2/t
	 SmIoeXc20Ah9VAOYczXy/UIlxrPb0BSteWmotYNGGsKZK3xqTb2/UHELEZPY7IgTGC
	 IFh712UIAXX9ni19x46YapP6BnkAg7pZ0dCayUzW4IT/rqFGHxSq58uYuIwgdeRD9g
	 FOuAo0B0I7KipGJMKu78acP21BmlY3EhhpC6fqaCsw1VYohiAMhRLKzOPhIr+GeXuj
	 xPxCvRdurnP8g==
Date: Mon, 20 Oct 2025 11:47:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	xfs-stable <xfs-stable@lists.linux.dev>
Subject: Re: [PATCH 6.12.y] xfs: use deferred intent items for reaping
 crosslinked blocks
Message-ID: <20251020184719.GQ6178@frogsfrogsfrogs>
References: <2025101603-parasitic-impatient-2d2b@gregkh>
 <20251020154951.1825215-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020154951.1825215-1-sashal@kernel.org>

On Mon, Oct 20, 2025 at 11:49:51AM -0400, Sasha Levin wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> [ Upstream commit cd32a0c0dcdf634f2e0e71f41c272e19dece6264 ]
> 
> When we're removing rmap records for crosslinked blocks, use deferred
> intent items so that we can try to free/unmap as many of the old data
> structure's blocks as we can in the same transaction as the commit.
> 
> Cc: <stable@vger.kernel.org> # v6.6
> Fixes: 1c7ce115e52106 ("xfs: reap large AG metadata extents when possible")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> [ adapted xfs_refcount_free_cow_extent() and xfs_rmap_free_extent() ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Looks good to me,
Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/scrub/reap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/scrub/reap.c b/fs/xfs/scrub/reap.c
> index 53697f3c5e1b0..8688edec58755 100644
> --- a/fs/xfs/scrub/reap.c
> +++ b/fs/xfs/scrub/reap.c
> @@ -409,8 +409,6 @@ xreap_agextent_iter(
>  	if (crosslinked) {
>  		trace_xreap_dispose_unmap_extent(sc->sa.pag, agbno, *aglenp);
>  
> -		rs->force_roll = true;
> -
>  		if (rs->oinfo == &XFS_RMAP_OINFO_COW) {
>  			/*
>  			 * If we're unmapping CoW staging extents, remove the
> @@ -418,11 +416,14 @@ xreap_agextent_iter(
>  			 * rmap record as well.
>  			 */
>  			xfs_refcount_free_cow_extent(sc->tp, fsbno, *aglenp);
> +			rs->force_roll = true;
>  			return 0;
>  		}
>  
> -		return xfs_rmap_free(sc->tp, sc->sa.agf_bp, sc->sa.pag, agbno,
> -				*aglenp, rs->oinfo);
> +		xfs_rmap_free_extent(sc->tp, sc->sa.pag->pag_agno, agbno,
> +				*aglenp, rs->oinfo->oi_owner);
> +		rs->deferred++;
> +		return 0;
>  	}
>  
>  	trace_xreap_dispose_free_extent(sc->sa.pag, agbno, *aglenp);
> -- 
> 2.51.0
> 

