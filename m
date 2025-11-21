Return-Path: <stable+bounces-195485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A65C78390
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 10:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 101CA349B44
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 09:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A6E34027D;
	Fri, 21 Nov 2025 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kj9a3s5A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B92A33D6F5
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763718474; cv=none; b=hwgKEfykVgPls24IPKbupsNumJLgq5yMRpvTZaipJQU5p8yJQTpy5iu2BrqJDHqdJ4wl0jd3N/mLR9bF9nAJTycRIrFeApIUgS5d7/nNrEXF5mELvg3N6mpZGJiFuY3aHxuyAz6KcnIWYUQFPt6Z6+qDbM0ERl5VOBH6aIq0fhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763718474; c=relaxed/simple;
	bh=cPfD70pHEkrqESn9QjZ9N3HZv1aQmU1R4rGW60GTwkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iix3fmXESWZlFsByJNnUysfqcY7A3kJ8zNXtA0vzUuR199Ax9MCGr9w1ehag1vtBOpbx3JlEjeNd+uFbFUg+PC9qlPtqE9w8FPXDtCzHjqJG1QGKR8JKKLpcgSql92KuHMDiCxfqGLm0tCByW2LqIuwPLBtufPTprzor3uJs1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kj9a3s5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159EBC4CEF1;
	Fri, 21 Nov 2025 09:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763718473;
	bh=cPfD70pHEkrqESn9QjZ9N3HZv1aQmU1R4rGW60GTwkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kj9a3s5AqPsbqrKoziAprxyz+gUqz48vioPxNy1R2zg0nYS9K/Hikmzu3s5AmoSkl
	 v7J8rig5VGZJXeV2Rj9Crir0IjswAbXGQLFHxoYmKNumX38Mh9kR8Kj2JpMUOI2fMX
	 hSSds2NkfGDQJhVoLJqvTirCeDjFIeBkg+Yr4SP8=
Date: Fri, 21 Nov 2025 10:47:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH 6.17.y 2/2] xfs: fix various problems in
 xfs_atomic_write_cow_iomap_begin
Message-ID: <2025112143-wok-recapture-9176@gregkh>
References: <2025110942-language-suspect-13bc@gregkh>
 <20251109232057.531285-1-sashal@kernel.org>
 <20251109232057.531285-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109232057.531285-2-sashal@kernel.org>

On Sun, Nov 09, 2025 at 06:20:57PM -0500, Sasha Levin wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> [ Upstream commit 8d7bba1e8314013ecc817a91624104ceb9352ddc ]
> 
> I think there are several things wrong with this function:
> 
> A) xfs_bmapi_write can return a much larger unwritten mapping than what
>    the caller asked for.  We convert part of that range to written, but
>    return the entire written mapping to iomap even though that's
>    inaccurate.
> 
> B) The arguments to xfs_reflink_convert_cow_locked are wrong -- an
>    unwritten mapping could be *smaller* than the write range (or even
>    the hole range).  In this case, we convert too much file range to
>    written state because we then return a smaller mapping to iomap.
> 
> C) It doesn't handle delalloc mappings.  This I covered in the patch
>    that I already sent to the list.
> 
> D) Reassigning count_fsb to handle the hole means that if the second
>    cmap lookup attempt succeeds (due to racing with someone else) we
>    trim the mapping more than is strictly necessary.  The changing
>    meaning of count_fsb makes this harder to notice.
> 
> E) The tracepoint is kinda wrong because @length is mutated.  That makes
>    it harder to chase the data flows through this function because you
>    can't just grep on the pos/bytecount strings.
> 
> F) We don't actually check that the br_state = XFS_EXT_NORM assignment
>    is accurate, i.e that the cow fork actually contains a written
>    mapping for the range we're interested in
> 
> G) Somewhat inadequate documentation of why we need to xfs_trim_extent
>    so aggressively in this function.
> 
> H) Not sure why xfs_iomap_end_fsb is used here, the vfs already clamped
>    the write range to s_maxbytes.
> 
> Fix these issues, and then the atomic writes regressions in generic/760,
> generic/617, generic/091, generic/263, and generic/521 all go away for
> me.
> 
> Cc: stable@vger.kernel.org # v6.16
> Fixes: bd1d2c21d5d249 ("xfs: add xfs_atomic_write_cow_iomap_begin()")
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Carlos Maiolino <cem@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/xfs/xfs_iomap.c | 61 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 50 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index a4a22975c7cc9..0cf84b25d6567 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1082,6 +1082,29 @@ const struct iomap_ops xfs_zoned_direct_write_iomap_ops = {
>  };
>  #endif /* CONFIG_XFS_RT */
>  
> +#ifdef DEBUG
> +static void
> +xfs_check_atomic_cow_conversion(
> +	struct xfs_inode		*ip,
> +	xfs_fileoff_t			offset_fsb,
> +	xfs_filblks_t			count_fsb,
> +	const struct xfs_bmbt_irec	*cmap)
> +{
> +	struct xfs_iext_cursor		icur;
> +	struct xfs_bmbt_irec		cmap2 = { };
> +
> +	if (xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap2))
> +		xfs_trim_extent(&cmap2, offset_fsb, count_fsb);
> +
> +	ASSERT(cmap2.br_startoff == cmap->br_startoff);
> +	ASSERT(cmap2.br_blockcount == cmap->br_blockcount);
> +	ASSERT(cmap2.br_startblock == cmap->br_startblock);
> +	ASSERT(cmap2.br_state == cmap->br_state);
> +}
> +#else
> +# define xfs_check_atomic_cow_conversion(...)	((void)0)
> +#endif
> +
>  static int
>  xfs_atomic_write_cow_iomap_begin(
>  	struct inode		*inode,
> @@ -1093,9 +1116,10 @@ xfs_atomic_write_cow_iomap_begin(
>  {
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> -	const xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> -	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
> -	xfs_filblks_t		count_fsb = end_fsb - offset_fsb;
> +	const xfs_fileoff_t	offset_fsb = XFS_B_TO_FSBT(mp, offset);
> +	const xfs_fileoff_t	end_fsb = XFS_B_TO_FSB(mp, offset + length);
> +	const xfs_filblks_t	count_fsb = end_fsb - offset_fsb;
> +	xfs_filblks_t		hole_count_fsb;
>  	int			nmaps = 1;
>  	xfs_filblks_t		resaligned;
>  	struct xfs_bmbt_irec	cmap;
> @@ -1134,14 +1158,20 @@ xfs_atomic_write_cow_iomap_begin(
>  	if (cmap.br_startoff <= offset_fsb) {
>  		if (isnullstartblock(cmap.br_startblock))
>  			goto convert_delay;
> +
> +		/*
> +		 * cmap could extend outside the write range due to previous
> +		 * speculative preallocations.  We must trim cmap to the write
> +		 * range because the cow fork treats written mappings to mean
> +		 * "write in progress".
> +		 */
>  		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
>  		goto found;
>  	}
>  
> -	end_fsb = cmap.br_startoff;
> -	count_fsb = end_fsb - offset_fsb;
> +	hole_count_fsb = cmap.br_startoff - offset_fsb;
>  
> -	resaligned = xfs_aligned_fsb_count(offset_fsb, count_fsb,
> +	resaligned = xfs_aligned_fsb_count(offset_fsb, hole_count_fsb,
>  			xfs_get_cowextsz_hint(ip));
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  
> @@ -1177,7 +1207,7 @@ xfs_atomic_write_cow_iomap_begin(
>  	 * atomic writes to that same range will be aligned (and don't require
>  	 * this COW-based method).
>  	 */
> -	error = xfs_bmapi_write(tp, ip, offset_fsb, count_fsb,
> +	error = xfs_bmapi_write(tp, ip, offset_fsb, hole_count_fsb,
>  			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC |
>  			XFS_BMAPI_EXTSZALIGN, 0, &cmap, &nmaps);
>  	if (error) {
> @@ -1190,17 +1220,26 @@ xfs_atomic_write_cow_iomap_begin(
>  	if (error)
>  		goto out_unlock;
>  
> +	/*
> +	 * cmap could map more blocks than the range we passed into bmapi_write
> +	 * because of EXTSZALIGN or adjacent pre-existing unwritten mappings
> +	 * that were merged.  Trim cmap to the original write range so that we
> +	 * don't convert more than we were asked to do for this write.
> +	 */
> +	xfs_trim_extent(&cmap, offset_fsb, count_fsb);
> +
>  found:
>  	if (cmap.br_state != XFS_EXT_NORM) {
> -		error = xfs_reflink_convert_cow_locked(ip, offset_fsb,
> -				count_fsb);
> +		error = xfs_reflink_convert_cow_locked(ip, cmap.br_startoff,
> +				cmap.br_blockcount);
>  		if (error)
>  			goto out_unlock;
>  		cmap.br_state = XFS_EXT_NORM;
> +		xfs_check_atomic_cow_conversion(ip, offset_fsb, count_fsb,
> +				&cmap);
>  	}
>  
> -	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
> -	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
> +	trace_xfs_iomap_found(ip, offset, length, XFS_COW_FORK, &cmap);
>  	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
> -- 
> 2.51.0
> 
> 

Also did not apply to 6.17.y :(

