Return-Path: <stable+bounces-195484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20924C783A5
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 10:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DC014E98DC
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 09:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA93340D91;
	Fri, 21 Nov 2025 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SrgiMlFf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676DB2F7455
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763718465; cv=none; b=K12k6prfX759x04B9Yt2PiV8pUCd+ENGQ1u70GAwIRDWSgTtkhoLLGF+AXlny3TQkNRKe/1QFUjKL1lKNo11YRwcGnFMi4doovWWycGTmzFMH3xxv0vOcqCGOQ1GVKBzTATYZQyMczOd3pqtphYtZFO9LivZ3Utrpg55ej8Jvws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763718465; c=relaxed/simple;
	bh=KJ2P+oOk17WQC0my9Vr6nc4wWHrMd3mkPhw/s9lkEuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHp7fSLGZBXmGhKqnKypd43lBsNtN44FU9molyDNzxnUHqIXu3WwKC/tOwPfzwaWKuvOLt9NoheGgosFU4pYBwc14qrDCSXcsQv1WHlKtwLjxi5QZ+fthfb5A2BVnfp2N9L6rzlLwDn83twVF4dA+Us2ccdOP1IM09KsOsfJ3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SrgiMlFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819B4C4CEF1;
	Fri, 21 Nov 2025 09:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763718463;
	bh=KJ2P+oOk17WQC0my9Vr6nc4wWHrMd3mkPhw/s9lkEuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SrgiMlFf4VboKab9WXdtoOiwrc+wlvc2ZDMbPQy3yKyyHHISSqtWJfGiaIePgil4d
	 GstLnlnuxR8zjMc2iaO9VWIFQ7B2lL/FpxFOhpDVjwEepmm2iOcxzz/8bBhfheqAPI
	 pCIYE2xDdS8B9JcGaZ1IWpiSd0zohYBZTV/fG5AQ=
Date: Fri, 21 Nov 2025 10:47:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH 6.17.y 1/2] xfs: fix delalloc write failures in
 software-provided atomic writes
Message-ID: <2025112133-bleak-stamina-42ba@gregkh>
References: <2025110942-language-suspect-13bc@gregkh>
 <20251109232057.531285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109232057.531285-1-sashal@kernel.org>

On Sun, Nov 09, 2025 at 06:20:56PM -0500, Sasha Levin wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> [ Upstream commit 8d54eacd82a0623a963e0c150ad3b02970638b0d ]
> 
> With the 20 Oct 2025 release of fstests, generic/521 fails for me on
> regular (aka non-block-atomic-writes) storage:
> 
> QA output created by 521
> dowrite: write: Input/output error
> LOG DUMP (8553 total operations):
> 1(  1 mod 256): SKIPPED (no operation)
> 2(  2 mod 256): WRITE    0x7e000 thru 0x8dfff	(0x10000 bytes) HOLE
> 3(  3 mod 256): READ     0x69000 thru 0x79fff	(0x11000 bytes)
> 4(  4 mod 256): FALLOC   0x53c38 thru 0x5e853	(0xac1b bytes) INTERIOR
> 5(  5 mod 256): COPY 0x55000 thru 0x59fff	(0x5000 bytes) to 0x25000 thru 0x29fff
> 6(  6 mod 256): WRITE    0x74000 thru 0x88fff	(0x15000 bytes)
> 7(  7 mod 256): ZERO     0xedb1 thru 0x11693	(0x28e3 bytes)
> 
> with a warning in dmesg from iomap about XFS trying to give it a
> delalloc mapping for a directio write.  Fix the software atomic write
> iomap_begin code to convert the reservation into a written mapping.
> This doesn't fix the data corruption problems reported by generic/760,
> but it's a start.
> 
> Cc: stable@vger.kernel.org # v6.16
> Fixes: bd1d2c21d5d249 ("xfs: add xfs_atomic_write_cow_iomap_begin()")
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Carlos Maiolino <cem@kernel.org>
> Stable-dep-of: 8d7bba1e8314 ("xfs: fix various problems in xfs_atomic_write_cow_iomap_begin")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/xfs/xfs_iomap.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 2a74f29573410..a4a22975c7cc9 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1121,7 +1121,7 @@ xfs_atomic_write_cow_iomap_begin(
>  		return -EAGAIN;
>  
>  	trace_xfs_iomap_atomic_write_cow(ip, offset, length);
> -
> +retry:
>  	xfs_ilock(ip, XFS_ILOCK_EXCL);
>  
>  	if (!ip->i_cowfp) {
> @@ -1132,6 +1132,8 @@ xfs_atomic_write_cow_iomap_begin(
>  	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
>  		cmap.br_startoff = end_fsb;
>  	if (cmap.br_startoff <= offset_fsb) {
> +		if (isnullstartblock(cmap.br_startblock))
> +			goto convert_delay;
>  		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
>  		goto found;
>  	}
> @@ -1160,8 +1162,10 @@ xfs_atomic_write_cow_iomap_begin(
>  	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
>  		cmap.br_startoff = end_fsb;
>  	if (cmap.br_startoff <= offset_fsb) {
> -		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
>  		xfs_trans_cancel(tp);
> +		if (isnullstartblock(cmap.br_startblock))
> +			goto convert_delay;
> +		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
>  		goto found;
>  	}
>  
> @@ -1201,6 +1205,19 @@ xfs_atomic_write_cow_iomap_begin(
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
>  
> +convert_delay:
> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	error = xfs_bmapi_convert_delalloc(ip, XFS_COW_FORK, offset, iomap,
> +			NULL);
> +	if (error)
> +		return error;
> +
> +	/*
> +	 * Try the lookup again, because the delalloc conversion might have
> +	 * turned the COW mapping into unwritten, but we need it to be in
> +	 * written state.
> +	 */
> +	goto retry;
>  out_unlock:
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  	return error;
> -- 
> 2.51.0
> 
> 

Did not apply to 6.17.y at all :(

