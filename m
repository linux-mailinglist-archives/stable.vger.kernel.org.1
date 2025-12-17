Return-Path: <stable+bounces-202764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2124CC606B
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 06:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A66A3001E01
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 05:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD70C1DFE09;
	Wed, 17 Dec 2025 05:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tlW1b0+s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F11400C;
	Wed, 17 Dec 2025 05:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765948745; cv=none; b=dL0aCkk3VohaeCqinKscFf5OL6sVwy1vQXfCn7p+XbZd/RwcVvG/lEHLE3FVyTIc1XF+jLYFs3cverpL+JfF13p32p7ZIsVQVc2jK+v4Y6ej65XUNlf4nBz+jBrsnAgCaipSqxwtpkyMLb5NhwOT+yC9FPNopamwL9Om0E2kJmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765948745; c=relaxed/simple;
	bh=1fFAyZQv+MGNQs4cmN9uv+MMzLExXIooU6srjtEINYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JW+dF4RGmprxlQ5Z+QQZ4jB9HeBJA3bqywYExSRg6x5s2EWgVQH80GOCRv9N7uotHOEBfShOm4OFOi1KjSLK7XAxed1fcZ3DkoAe7s8wS+cyRh4HoqlvN/aqE+hgegWehnhtVNkhjoZKGs0fjmBHMhDhtRv15GZxJTPQlEXMYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tlW1b0+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A32C4CEF5;
	Wed, 17 Dec 2025 05:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765948745;
	bh=1fFAyZQv+MGNQs4cmN9uv+MMzLExXIooU6srjtEINYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlW1b0+sp6Sny6guNI0QeHzNSkD7b0y0FuBWR30w+S9GPmvd+PDqgXo2M0MBxEgGm
	 Fdy8hN5Iz6iOs+QddLfxaXiHojnr/fJWxjYBvsRu1W8Qlci0hWUmdMzH7831jGcRyn
	 1gA9HzhUgsK1PWI2yiypPuDJE9bxNoIapA0IBrJM=
Date: Wed, 17 Dec 2025 06:19:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Will Rosenberg <whrosenb@asu.edu>
Cc: Paul Moore <paul@paul-moore.com>,
	syzbot+6aaf7f48ae034ab0ea97@syzkaller.appspotmail.com,
	stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Oliver Rosenberg <olrose55@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs/kernfs: null-ptr deref in simple_xattrs_free()
Message-ID: <2025121745-chatty-jogging-ac2d@gregkh>
References: <2025121653-overfeed-giblet-5bde@gregkh>
 <20251216164335.4066425-1-whrosenb@asu.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216164335.4066425-1-whrosenb@asu.edu>

On Tue, Dec 16, 2025 at 09:43:35AM -0700, Will Rosenberg wrote:
> There exists a null pointer dereference in simple_xattrs_free() as
> part of the __kernfs_new_node() routine. Within __kernfs_new_node(),
> err_out4 calls simple_xattr_free(), but kn->iattr may be NULL if
> __kernfs_setattr() was never called. As a result, the first argument to
> simple_xattrs_free() may be NULL + 0x38, and no NULL check is done
> internally, causing an incorrect pointer dereference.
> 
> Add a check to ensure kn->iattr is not NULL, meaning __kernfs_setattr()
> has been called and kn->iattr is allocated. Note that struct kernfs_node
> kn is allocated with kmem_cache_zalloc, so we can assume kn->iattr will
> be NULL if not allocated.
> 
> An alternative fix could be to not call simple_xattr_free() at all. As
> was previously discussed during the initial patch, simple_xattr_free()
> is not strictly needed and is included to be consistent with
> kernfs_free_rcu(), which also helps the function maintain correctness if
> changes are made in __kernfs_new_node().
> 
> Reported-by: syzbot+6aaf7f48ae034ab0ea97@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6aaf7f48ae034ab0ea97
> Fixes: 382b1e8f30f7 ("kernfs: fix memory leak of kernfs_iattrs in __kernfs_new_node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Will Rosenberg <whrosenb@asu.edu>
> ---
>  fs/kernfs/dir.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 5c0efd6b239f..29baeeb97871 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -681,8 +681,10 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
>  	return kn;
>  
>   err_out4:
> -	simple_xattrs_free(&kn->iattr->xattrs, NULL);
> -	kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
> +	if (kn->iattr) {
> +		simple_xattrs_free(&kn->iattr->xattrs, NULL);
> +		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
> +	}
>   err_out3:
>  	spin_lock(&root->kernfs_idr_lock);
>  	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
> 
> base-commit: d358e5254674b70f34c847715ca509e46eb81e6f
> -- 
> 2.34.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

