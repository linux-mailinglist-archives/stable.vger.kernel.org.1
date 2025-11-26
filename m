Return-Path: <stable+bounces-197056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD320C8C3BD
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 23:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD413B17DA
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 22:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A732FBDFF;
	Wed, 26 Nov 2025 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGccwgtc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6375299924
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764196822; cv=none; b=sqCsqSyyF2ffMG3zyP6ySLddOqMCoef5KN54d83SGBveCheW39OcpfKD3JeEElEqKVkBM+YyBVpCkdElzD8OSTzEdv3TwcgP8JP3Hr00XwGM07a6rb+KpcMORP5+akPl9zNuifAI/XPuurxxo2/p7ByM/APiyAA4KlF2/yJj/0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764196822; c=relaxed/simple;
	bh=Svrqla/4Nthf2e5Fc0KXPyZykX/QWMwlTNobZmEq6b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swn2O2syDjCUmHWluuaytzMpueaQOfbvEBknDOwDOQV953iFaYiqVwA6lJRYrqj0suAX0hjJd/ZPepeCz4MAJAwK29PBdLYolLDusb1B1OhJBE3RSvWFHjNd0Yk53q12mOTVNC6RXZugPGKCN3XpANuX2QPd46WHlxldBiTmJ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGccwgtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C638C4CEF7;
	Wed, 26 Nov 2025 22:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764196822;
	bh=Svrqla/4Nthf2e5Fc0KXPyZykX/QWMwlTNobZmEq6b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGccwgtcKXa+vdwdRAtABQ797PlEF19PH1RHiixK+52OcXhMF7PeJUV+BH510x7VQ
	 iDaZ9hzi2oxmDPZnRimZuV/AkbU/A9OCmFjg+vgO5YizJ1Vae07hNJkzdR0vdbwIza
	 R57d1ijlO+AnWpJ9UAyXo7UgxhLDzC28RqMGTmx1zoRJPQNURt7PV64899HQUF90YI
	 TMQd8AdgSen9fdaeZQwO2vymsPrqFelUHVm+1c1dZTEY+JK7iYcYgiGTjHlyplJe3W
	 4JpEhjfsp7CqezsVX96shWLrPXZxXz9koI1Jo1Hxgunt327iqqbjDH+yugH1qYkjlv
	 ZFaDlOYcjDk0g==
Date: Wed, 26 Nov 2025 14:40:21 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Marcelo Moreira <marcelomoreira1905@gmail.com>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH 6.12.y 1/2] xfs: Replace strncpy with memcpy
Message-ID: <20251126224021.GB23370@frogsfrogsfrogs>
References: <2025112403-evaluate-bogged-d093@gregkh>
 <20251124175606.4173445-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124175606.4173445-1-sashal@kernel.org>

On Mon, Nov 24, 2025 at 12:56:05PM -0500, Sasha Levin wrote:
> From: Marcelo Moreira <marcelomoreira1905@gmail.com>
> 
> [ Upstream commit 33ddc796ecbd50cd6211aa9e9eddbf4567038b49 ]
> 
> The changes modernizes the code by aligning it with current kernel best
> practices. It improves code clarity and consistency, as strncpy is deprecated
> as explained in Documentation/process/deprecated.rst. This change does
> not alter the functionality or introduce any behavioral changes.
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
> Signed-off-by: Marcelo Moreira <marcelomoreira1905@gmail.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Carlos Maiolino <cem@kernel.org>
> Stable-dep-of: 678e1cc2f482 ("xfs: fix out of bounds memory read error in symlink repair")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Both of these backports also look good to me,
Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/scrub/symlink_repair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/scrub/symlink_repair.c b/fs/xfs/scrub/symlink_repair.c
> index 953ce7be78dc2..5902398185a89 100644
> --- a/fs/xfs/scrub/symlink_repair.c
> +++ b/fs/xfs/scrub/symlink_repair.c
> @@ -185,7 +185,7 @@ xrep_symlink_salvage_inline(
>  		return 0;
>  
>  	nr = min(XFS_SYMLINK_MAXLEN, xfs_inode_data_fork_size(ip));
> -	strncpy(target_buf, ifp->if_data, nr);
> +	memcpy(target_buf, ifp->if_data, nr);
>  	return nr;
>  }
>  
> -- 
> 2.51.0
> 

