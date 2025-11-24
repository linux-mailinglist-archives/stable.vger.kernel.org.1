Return-Path: <stable+bounces-196760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F487C81534
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 16:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1378E3A71B2
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 15:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDC7314B86;
	Mon, 24 Nov 2025 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk5a8vTK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15BB314B82
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763997906; cv=none; b=medb6Cj9/bptbK0GFbNkx+21TKTkNqe2ifSHEgsBto9hivAyoFR3KsLvxniOI+sMdoP3IVgk++sd6G/zrw4fYOpOeFy2y52dS9ySsoaUWb+/08qJvttwazxBUKptnpCO3AHaoZXjFzkCDuBMDjBgr9eX0o30mntuD8HkTDIy0pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763997906; c=relaxed/simple;
	bh=4ccXAY8Re6yRRkjA6hIi944vDEfUHBvLJepo42Qqc8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Br0rRKKoPJZoFxc2Z49tEkI6PS4B/1ebNrAKct3OulGcHVblLh8n73x91HKqvA5gjxz6ayzwFvFoyf+njYhJHgmCRPw01H9SS7iCe7i44xcXZmbX0P0G8xjvZmpxd/VaJ6HOQf+TUPwqJPsh9BD14+7jmNtuyJKtmecWVZu3TRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dk5a8vTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12088C4CEF1;
	Mon, 24 Nov 2025 15:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763997905;
	bh=4ccXAY8Re6yRRkjA6hIi944vDEfUHBvLJepo42Qqc8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dk5a8vTKeZfMHUk2a16zTvpTOjFcffv1FJ1oxhd3ZeT2Euk6DV4s6hw/aJhMXRi1U
	 hfXQLWm34Hwe5qZ0tBmW1MlSn9++adDQJnXW/K3WDX+LV5VWhd1T2lv+mvyB/QmTLo
	 oFRWVKc8i8buYQwszVsi4IjMG849B8B0m1EawaCpeulotOnRUvqcpkYNiEPY2Eek/T
	 Egs/hmAW8+10CGzCxPxi0t1wGO/wHUqimn28ZdrxYPVOBTee7YrxSBAVxT0LyPMZtc
	 57BUgWRWYadzHem0Sdkcsfbx45j0lDJKZhR7nT/xLZxttoOvlYRjaHwKQ3Zh8Q/HiG
	 afoYgNdpShpOw==
Date: Mon, 24 Nov 2025 10:25:03 -0500
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH 6.17.y 2/2] xfs: fix various problems in
 xfs_atomic_write_cow_iomap_begin
Message-ID: <aSR4z9FSdmAyH1Eu@laps>
References: <2025110942-language-suspect-13bc@gregkh>
 <20251109232057.531285-1-sashal@kernel.org>
 <20251109232057.531285-2-sashal@kernel.org>
 <2025112143-wok-recapture-9176@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2025112143-wok-recapture-9176@gregkh>

On Fri, Nov 21, 2025 at 10:47:50AM +0100, Greg KH wrote:
>On Sun, Nov 09, 2025 at 06:20:57PM -0500, Sasha Levin wrote:
>> From: "Darrick J. Wong" <djwong@kernel.org>
>>
>> [ Upstream commit 8d7bba1e8314013ecc817a91624104ceb9352ddc ]
>>
>> I think there are several things wrong with this function:
>>
>> A) xfs_bmapi_write can return a much larger unwritten mapping than what
>>    the caller asked for.  We convert part of that range to written, but
>>    return the entire written mapping to iomap even though that's
>>    inaccurate.
>>
>> B) The arguments to xfs_reflink_convert_cow_locked are wrong -- an
>>    unwritten mapping could be *smaller* than the write range (or even
>>    the hole range).  In this case, we convert too much file range to
>>    written state because we then return a smaller mapping to iomap.
>>
>> C) It doesn't handle delalloc mappings.  This I covered in the patch
>>    that I already sent to the list.
>>
>> D) Reassigning count_fsb to handle the hole means that if the second
>>    cmap lookup attempt succeeds (due to racing with someone else) we
>>    trim the mapping more than is strictly necessary.  The changing
>>    meaning of count_fsb makes this harder to notice.
>>
>> E) The tracepoint is kinda wrong because @length is mutated.  That makes
>>    it harder to chase the data flows through this function because you
>>    can't just grep on the pos/bytecount strings.
>>
>> F) We don't actually check that the br_state = XFS_EXT_NORM assignment
>>    is accurate, i.e that the cow fork actually contains a written
>>    mapping for the range we're interested in
>>
>> G) Somewhat inadequate documentation of why we need to xfs_trim_extent
>>    so aggressively in this function.
>>
>> H) Not sure why xfs_iomap_end_fsb is used here, the vfs already clamped
>>    the write range to s_maxbytes.
>>
>> Fix these issues, and then the atomic writes regressions in generic/760,
>> generic/617, generic/091, generic/263, and generic/521 all go away for
>> me.
>>
>> Cc: stable@vger.kernel.org # v6.16
>> Fixes: bd1d2c21d5d249 ("xfs: add xfs_atomic_write_cow_iomap_begin()")
>> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
>> Reviewed-by: John Garry <john.g.garry@oracle.com>
>> Signed-off-by: Carlos Maiolino <cem@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  fs/xfs/xfs_iomap.c | 61 +++++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 50 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index a4a22975c7cc9..0cf84b25d6567 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -1082,6 +1082,29 @@ const struct iomap_ops xfs_zoned_direct_write_iomap_ops = {
>>  };
>>  #endif /* CONFIG_XFS_RT */
>>
>> +#ifdef DEBUG
>> +static void
>> +xfs_check_atomic_cow_conversion(
>> +	struct xfs_inode		*ip,
>> +	xfs_fileoff_t			offset_fsb,
>> +	xfs_filblks_t			count_fsb,
>> +	const struct xfs_bmbt_irec	*cmap)
>> +{
>> +	struct xfs_iext_cursor		icur;
>> +	struct xfs_bmbt_irec		cmap2 = { };
>> +
>> +	if (xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap2))
>> +		xfs_trim_extent(&cmap2, offset_fsb, count_fsb);
>> +
>> +	ASSERT(cmap2.br_startoff == cmap->br_startoff);
>> +	ASSERT(cmap2.br_blockcount == cmap->br_blockcount);
>> +	ASSERT(cmap2.br_startblock == cmap->br_startblock);
>> +	ASSERT(cmap2.br_state == cmap->br_state);
>> +}
>> +#else
>> +# define xfs_check_atomic_cow_conversion(...)	((void)0)
>> +#endif
>> +
>>  static int
>>  xfs_atomic_write_cow_iomap_begin(
>>  	struct inode		*inode,
>> @@ -1093,9 +1116,10 @@ xfs_atomic_write_cow_iomap_begin(
>>  {
>>  	struct xfs_inode	*ip = XFS_I(inode);
>>  	struct xfs_mount	*mp = ip->i_mount;
>> -	const xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>> -	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
>> -	xfs_filblks_t		count_fsb = end_fsb - offset_fsb;
>> +	const xfs_fileoff_t	offset_fsb = XFS_B_TO_FSBT(mp, offset);
>> +	const xfs_fileoff_t	end_fsb = XFS_B_TO_FSB(mp, offset + length);
>> +	const xfs_filblks_t	count_fsb = end_fsb - offset_fsb;
>> +	xfs_filblks_t		hole_count_fsb;
>>  	int			nmaps = 1;
>>  	xfs_filblks_t		resaligned;
>>  	struct xfs_bmbt_irec	cmap;
>> @@ -1134,14 +1158,20 @@ xfs_atomic_write_cow_iomap_begin(
>>  	if (cmap.br_startoff <= offset_fsb) {
>>  		if (isnullstartblock(cmap.br_startblock))
>>  			goto convert_delay;
>> +
>> +		/*
>> +		 * cmap could extend outside the write range due to previous
>> +		 * speculative preallocations.  We must trim cmap to the write
>> +		 * range because the cow fork treats written mappings to mean
>> +		 * "write in progress".
>> +		 */
>>  		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
>>  		goto found;
>>  	}
>>
>> -	end_fsb = cmap.br_startoff;
>> -	count_fsb = end_fsb - offset_fsb;
>> +	hole_count_fsb = cmap.br_startoff - offset_fsb;
>>
>> -	resaligned = xfs_aligned_fsb_count(offset_fsb, count_fsb,
>> +	resaligned = xfs_aligned_fsb_count(offset_fsb, hole_count_fsb,
>>  			xfs_get_cowextsz_hint(ip));
>>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>>
>> @@ -1177,7 +1207,7 @@ xfs_atomic_write_cow_iomap_begin(
>>  	 * atomic writes to that same range will be aligned (and don't require
>>  	 * this COW-based method).
>>  	 */
>> -	error = xfs_bmapi_write(tp, ip, offset_fsb, count_fsb,
>> +	error = xfs_bmapi_write(tp, ip, offset_fsb, hole_count_fsb,
>>  			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC |
>>  			XFS_BMAPI_EXTSZALIGN, 0, &cmap, &nmaps);
>>  	if (error) {
>> @@ -1190,17 +1220,26 @@ xfs_atomic_write_cow_iomap_begin(
>>  	if (error)
>>  		goto out_unlock;
>>
>> +	/*
>> +	 * cmap could map more blocks than the range we passed into bmapi_write
>> +	 * because of EXTSZALIGN or adjacent pre-existing unwritten mappings
>> +	 * that were merged.  Trim cmap to the original write range so that we
>> +	 * don't convert more than we were asked to do for this write.
>> +	 */
>> +	xfs_trim_extent(&cmap, offset_fsb, count_fsb);
>> +
>>  found:
>>  	if (cmap.br_state != XFS_EXT_NORM) {
>> -		error = xfs_reflink_convert_cow_locked(ip, offset_fsb,
>> -				count_fsb);
>> +		error = xfs_reflink_convert_cow_locked(ip, cmap.br_startoff,
>> +				cmap.br_blockcount);
>>  		if (error)
>>  			goto out_unlock;
>>  		cmap.br_state = XFS_EXT_NORM;
>> +		xfs_check_atomic_cow_conversion(ip, offset_fsb, count_fsb,
>> +				&cmap);
>>  	}
>>
>> -	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
>> -	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
>> +	trace_xfs_iomap_found(ip, offset, length, XFS_COW_FORK, &cmap);
>>  	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
>>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>>  	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
>> --
>> 2.51.0
>>
>>
>
>Also did not apply to 6.17.y :(

You pulled these two for the previous release, so they're already in tree :)

-- 
Thanks,
Sasha

