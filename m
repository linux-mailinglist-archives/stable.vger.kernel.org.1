Return-Path: <stable+bounces-197055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 115A3C8C3BA
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 23:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C0E3B179D
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 22:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E2E2FBDFF;
	Wed, 26 Nov 2025 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSMDW1MV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16AB299924
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764196797; cv=none; b=q7kHMgg5NU5z3EDoZFidIA7i6X8OWhkCLMRY8Pk4XC7XuI6hM9B5fzi6vTK0kSL1bzKG54sy5lS0JERNfHJ30+QevF5kgaqRcsQz3lHDU5wkOyHXhUJ07DG+YRs9VncnRGQn6ZyzWZRn7tV7CjyAKMyH5L4Ko5AYXbqAUXQHnB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764196797; c=relaxed/simple;
	bh=nEWvWZKmCR+cQJ+jGIKOZ2Tav50fUfUWvq6lkh0/IoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/n8T+W3Xja7cjIwWD9svq93Z4Pnt4eKwgyT+CuXQ32OdCSTv3yfGZ+rL/42bNLmhKlgT7fyT8f640dr+x4/7nAQCHbAGoOWzlCCs4inb9BdXWMtXLT0v7seB/SYP0Kd8T5skf0xdk7qKK07n+VS0Z073OzKJCnvW3VzQihOMUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSMDW1MV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BABC4CEF7;
	Wed, 26 Nov 2025 22:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764196796;
	bh=nEWvWZKmCR+cQJ+jGIKOZ2Tav50fUfUWvq6lkh0/IoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gSMDW1MVrqel74r2pkOfXL2ovmxPU9rWJTziwRxXsu4dZ1VHGe7PVteHixJ11QThZ
	 dBlprxU3R7Ry9gcBXMOr7rJ+1/zqCT4YnglUpoFsnFapUGrAs8mJzTyIZRJs3ni0ru
	 B5pIkxwnIFhiAIn58bEhbCmaYv4g2BAZtt2y+ZmFuwQVLLgrlHNNaa5EkjZT5TmC3G
	 KMbmGCOiR+LYfrqi7GhJdFqVRRbNd2Pf9rKV6YUF/iB8JPFu9Ytrx8F1Kn1DAxdxZi
	 UU39Y0NSqMLmOrvwtUL9pNytWWrkompgEV2UrvGn7QTx6wkX+hsEuyHEH/Hu7uK3nm
	 5tRtm1ZAFMjYg==
Date: Wed, 26 Nov 2025 14:39:55 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Marcelo Moreira <marcelomoreira1905@gmail.com>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH 6.17.y 1/2] xfs: Replace strncpy with memcpy
Message-ID: <20251126223955.GA23370@frogsfrogsfrogs>
References: <2025112457-shining-trough-db05@gregkh>
 <20251124174503.4167383-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124174503.4167383-1-sashal@kernel.org>

On Mon, Nov 24, 2025 at 12:45:02PM -0500, Sasha Levin wrote:
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

The backports of patches 1-2 look good to me,
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

