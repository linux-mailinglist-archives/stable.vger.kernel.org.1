Return-Path: <stable+bounces-210265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 037B0D39EB1
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 07:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14E2A3028D5C
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 06:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D89271450;
	Mon, 19 Jan 2026 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FTcwFT9E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351FA1339B1;
	Mon, 19 Jan 2026 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804675; cv=none; b=aTXIqNNHYKjkjGkQm5v2wgOJ50GcVrAGlnDnAV91jNlbdsCEvOzTYWnviyaiRV+dWQvAi6CkI3bBPL/GBC6Cu3WpskB6PazL4Fb7Ot+2WJVe1vczqyj0ilBBm/nqyG0yDYPUwrhGSMZSEpcMBegBSLWKawd081p6S0UVaTxpY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804675; c=relaxed/simple;
	bh=X7s714HQiuwdhF/9jCHIjwDVN/wI2FD6Jsd+KaZding=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAEVsqCQO/cM225fqotGSoIBcCq/bt2C7BRjXlEIDEqF2058+r4SaGwgclmX+opnX3TWFCfYif97we4veX1oxOATEgCzwzgjXme+sLylQ0MhwztUFuwx88tY75uFlXY/1uj2aOc0cn+bdeNqv6cHOD3MtpsBWij0clueUdSQ5IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FTcwFT9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE0AC116C6;
	Mon, 19 Jan 2026 06:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768804674;
	bh=X7s714HQiuwdhF/9jCHIjwDVN/wI2FD6Jsd+KaZding=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FTcwFT9Ez282Gf/g5cgAKr48hF5bA6+CcRVS5USE9IC4gGM4C2sJSB+HNcZ2ijLL9
	 ZN+/l9FTuGx75PUBmVwaZohLARIQu9qDPxm7E+bag2sKa2PG4MQBZwyPlUGt7hbVfy
	 5Wm+wTRzOfzTA+kOs2G7E7mqtsapoxux1x1C6H6Y=
Date: Mon, 19 Jan 2026 07:37:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: markus.elfring@web.de, almaz.alexandrovich@paragon-software.com,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] fs/ntfs3: Fix memory and resource leak in
 indx_find_sort
Message-ID: <2026011945-ammonia-sheet-d784@gregkh>
References: <17914287-640d-4500-b519-5f3d3aed2878@web.de>
 <20260118185736.41529-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118185736.41529-1-jiashengjiangcool@gmail.com>

On Sun, Jan 18, 2026 at 06:57:36PM +0000, Jiasheng Jiang wrote:
> The function indx_find_sort() incorrectly uses kfree(n) to cleanup the
> 'struct indx_node' instance in error paths.
> 
> The 'struct indx_node' is a container that manages internal allocations
> (n->index) and holds a reference to a buffer head (n->nb). Using kfree()
> directly on the node pointer only frees the container itself, resulting
> in a memory leak of the index buffer and a resource leak of the buffer
> head reference.
> 
> This patch replaces the incorrect kfree(n) calls with the specialized
> helper put_indx_node(n), which correctly releases the internal resources
> and the buffer head, consistent with other functions like indx_find_raw().
> 
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Add a Fixes tag.
> ---
>  fs/ntfs3/index.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 7157cfd70fdc..c598b4b2f454 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -1248,7 +1248,7 @@ int indx_find_sort(struct ntfs_index *indx, struct ntfs_inode *ni,
>  		    sizeof(struct NTFS_DE) + sizeof(u64)) {
>  			if (n) {
>  				fnd_pop(fnd);
> -				kfree(n);
> +				put_indx_node(n);
>  			}
>  			return -EINVAL;
>  		}
> @@ -1261,7 +1261,7 @@ int indx_find_sort(struct ntfs_index *indx, struct ntfs_inode *ni,
>  		/* Try next level. */
>  		e = hdr_first_de(&n->index->ihdr);
>  		if (!e) {
> -			kfree(n);
> +			put_indx_node(n);
>  			return -EINVAL;
>  		}
>  
> @@ -1281,7 +1281,7 @@ int indx_find_sort(struct ntfs_index *indx, struct ntfs_inode *ni,
>  		/* Pop one level. */
>  		if (n) {
>  			fnd_pop(fnd);
> -			kfree(n);
> +			put_indx_node(n);
>  		}
>  
>  		level = fnd->level;
> -- 
> 2.25.1
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

