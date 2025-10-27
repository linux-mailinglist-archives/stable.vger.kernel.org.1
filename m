Return-Path: <stable+bounces-190035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A3CC0F3F8
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 179EA4F4B8A
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB2730E0F4;
	Mon, 27 Oct 2025 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvoagIgX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93A30146F
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581974; cv=none; b=gHUzDr0dQ20K0jAqxfjizyrwoNvxZjexlBT0Tlx9E9QVWH2BFiIgguyS/018iP7qWleTJX8SuZXCQaAkjW3oDZSRQzFIhL82uqrK5ufrcQkCGFTtYSoVjffk/m89m/didCaRfzPBoeLA5hzAcv6IeB0rJcqoPso8ONLvZvstf5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581974; c=relaxed/simple;
	bh=o1NTKQXn9Q+kH+4vgQHmwVwjlSD2z0EgP+DgEB3mX7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixsA2w0GsR3lgxOpR7/Yp5KrVwZYUnXGjkLd3VrduIROGRSKqn9gFNla9H3JbGwlRqZe2DKAroTiq8ykxy68/lTYDtsYkj3kbCmZ2JxM6rHoZgyod39+7/XHrn30w+2RnbQ1zoTp8tCfKu5WDLSfKNRvdGPFLpNPRf2gpPXhRP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvoagIgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF59FC4CEF1;
	Mon, 27 Oct 2025 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761581973;
	bh=o1NTKQXn9Q+kH+4vgQHmwVwjlSD2z0EgP+DgEB3mX7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SvoagIgX5qVR29MEoGVRz6+KWVU+St85o0QWgO6JKhQ3AHG1DJjNGxDzavnMaHteD
	 HAcFU25IVNitBaqf8SJYZZe4qjM+AUK2bIIf7VqZC1k+fnNzyfrHVPkUb7q/6EryHx
	 +1bBxVWus87x+aGx1mCXbx8U+wIuVdXcESJyr/mvhJrjWbBD09YiN9bxtW188e/4gj
	 6XqbEiCk/z4mXgLBczfH703dZzlEAHHXP6z8nfO3gupaD3nQ4mCCBwk1tAQN7yy8O4
	 MlR6eyCQv1H7deZ2LhoXfU+scW7iaRleZy7RRaCVFo5JhicIxR0uKpKQQg0hXViTC/
	 qgVhQ6Sv1db9A==
Date: Mon, 27 Oct 2025 09:19:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH 6.12.y] xfs: always warn about deprecated mount options
Message-ID: <20251027161933.GX6178@frogsfrogsfrogs>
References: <2025102645-oblivion-whoopee-576c@gregkh>
 <20251026180422.171824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026180422.171824-1-sashal@kernel.org>

On Sun, Oct 26, 2025 at 02:04:22PM -0400, Sasha Levin wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> [ Upstream commit 630785bfbe12c3ee3ebccd8b530a98d632b7e39d ]
> 
> The deprecation of the 'attr2' mount option in 6.18 wasn't entirely
> successful because nobody noticed that the kernel never printed a
> warning about attr2 being set in fstab if the only xfs filesystem is the
> root fs; the initramfs mounts the root fs with no mount options; and the
> init scripts only conveyed the fstab options by remounting the root fs.
> 
> Fix this by making it complain all the time.
> 
> Cc: stable@vger.kernel.org # v5.13
> Fixes: 92cf7d36384b99 ("xfs: Skip repetitive warnings about mount options")
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
> Signed-off-by: Carlos Maiolino <cem@kernel.org>
> [ Update existing xfs_fs_warn_deprecated() callers ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Looks good to me, thanks for fixing this up!
Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_super.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 201a86b3574da..77eaff6e16b15 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1232,16 +1232,25 @@ suffix_kstrtoint(
>  static inline void
>  xfs_fs_warn_deprecated(
>  	struct fs_context	*fc,
> -	struct fs_parameter	*param,
> -	uint64_t		flag,
> -	bool			value)
> +	struct fs_parameter	*param)
>  {
> -	/* Don't print the warning if reconfiguring and current mount point
> -	 * already had the flag set
> +	/*
> +	 * Always warn about someone passing in a deprecated mount option.
> +	 * Previously we wouldn't print the warning if we were reconfiguring
> +	 * and current mount point already had the flag set, but that was not
> +	 * the right thing to do.
> +	 *
> +	 * Many distributions mount the root filesystem with no options in the
> +	 * initramfs and rely on mount -a to remount the root fs with the
> +	 * options in fstab.  However, the old behavior meant that there would
> +	 * never be a warning about deprecated mount options for the root fs in
> +	 * /etc/fstab.  On a single-fs system, that means no warning at all.
> +	 *
> +	 * Compounding this problem are distribution scripts that copy
> +	 * /proc/mounts to fstab, which means that we can't remove mount
> +	 * options unless we're 100% sure they have only ever been advertised
> +	 * in /proc/mounts in response to explicitly provided mount options.
>  	 */
> -	if ((fc->purpose & FS_CONTEXT_FOR_RECONFIGURE) &&
> -            !!(XFS_M(fc->root->d_sb)->m_features & flag) == value)
> -		return;
>  	xfs_warn(fc->s_fs_info, "%s mount option is deprecated.", param->key);
>  }
>  
> @@ -1380,19 +1389,19 @@ xfs_fs_parse_param(
>  #endif
>  	/* Following mount options will be removed in September 2025 */
>  	case Opt_ikeep:
> -		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_IKEEP, true);
> +		xfs_fs_warn_deprecated(fc, param);
>  		parsing_mp->m_features |= XFS_FEAT_IKEEP;
>  		return 0;
>  	case Opt_noikeep:
> -		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_IKEEP, false);
> +		xfs_fs_warn_deprecated(fc, param);
>  		parsing_mp->m_features &= ~XFS_FEAT_IKEEP;
>  		return 0;
>  	case Opt_attr2:
> -		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_ATTR2, true);
> +		xfs_fs_warn_deprecated(fc, param);
>  		parsing_mp->m_features |= XFS_FEAT_ATTR2;
>  		return 0;
>  	case Opt_noattr2:
> -		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_NOATTR2, true);
> +		xfs_fs_warn_deprecated(fc, param);
>  		parsing_mp->m_features |= XFS_FEAT_NOATTR2;
>  		return 0;
>  	default:
> -- 
> 2.51.0
> 

