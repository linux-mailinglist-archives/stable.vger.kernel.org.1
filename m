Return-Path: <stable+bounces-77689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AEB985FF4
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC891C25F00
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E4E1BA27F;
	Wed, 25 Sep 2024 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LpD8m3XP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C4822D743;
	Wed, 25 Sep 2024 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266700; cv=none; b=Rj0oKHQyn9Um3OFx1hGfCMMaQE5rDKrxKWE3pPh90eYQXFAPX3QybCjwapiTX3/T1IyWKyIMcPbmj2n+8GCg3wI/T2Dmj69ghD47i0IkhUVLErCwag35n+qucTeplIX+Y97emigQdtXPLyjaYG/U3gRJwMgs4A9XFJRwoiON1zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266700; c=relaxed/simple;
	bh=tn5cJCOR98Jl9znHj3pY3J/jHPEF0ooY+piwssC5/QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1MMrAV1UTWrM98h9UGBm7gHH1C660EoctgQVGKSMOnkG/JL4gk5ddBE4wKSGHkUZUL7FClwEUEMGKzlPECosVnog4zl7eaJLn00B8UJArQNMhyYzCmRKkS8ryx9ZazuwbQBOy0ZEc1yeDP4hdRXKxJnUW7LuKpIAicuWpY285o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LpD8m3XP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB86AC4CEC3;
	Wed, 25 Sep 2024 12:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727266699;
	bh=tn5cJCOR98Jl9znHj3pY3J/jHPEF0ooY+piwssC5/QE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpD8m3XPG6uz3CB1wARhNtQtX65h8cQL3BK79qliyctN2lKoGnAwSRjVx+cCN5i9z
	 NEMUN7Q4ipfOV6kLtbOLKwz8dAWVRx3/5Ge7H5q94IA8ikdAOQsa7kFIPy7G6GlyEk
	 Ae4r0nep4PACD4kN8atw8S2rcLi3qYyHbHyL3XWU=
Date: Wed, 25 Sep 2024 14:18:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org,
	thunder.leizhen@huawei.com, wangweiyang2@huawei.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH -next 2/2] kobject: fix memory leak when
 kobject_add_varg() returns error
Message-ID: <2024092506-buddy-justifier-9050@gregkh>
References: <20240925120747.1930709-1-cuigaosheng1@huawei.com>
 <20240925120747.1930709-3-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925120747.1930709-3-cuigaosheng1@huawei.com>

On Wed, Sep 25, 2024 at 08:07:47PM +0800, Gaosheng Cui wrote:
> Inject fault while loading module, kobject_add_varg() may fail.
> If it fails, the kset.kobj.name allocated by kobject_set_name_vargs()
> may be leaked, the call trace as follow:
> 
> unreferenced object 0xffff8884ef4fccc0 (size 32):
>   comm "modprobe", pid 56721, jiffies 4304802933
>   backtrace (crc 4b069391):
>     [<ffffffff85e9fb2b>] kmemleak_alloc+0x4b/0x80
>     [<ffffffff83664674>] __kmalloc_node_track_caller_noprof+0x3d4/0x510
>     [<ffffffff83510656>] kstrdup+0x46/0x80
>     [<ffffffff8351070f>] kstrdup_const+0x6f/0x90
>     [<ffffffff84213842>] kvasprintf_const+0x112/0x190
>     [<ffffffff85d8446b>] kobject_set_name_vargs+0x5b/0x160
>     [<ffffffff85d85969>] kobject_init_and_add+0xc9/0x170
>     [<ffffffff83661788>] sysfs_slab_add+0x188/0x230
>     [<ffffffff83665e24>] do_kmem_cache_create+0x4d4/0x5a0
>     [<ffffffff835343cd>] __kmem_cache_create_args+0x18d/0x310
>     [<ffffffffc64a08b4>] 0xffffffffc64a08b4
>     [<ffffffffc64a005f>] 0xffffffffc64a005f
>     [<ffffffff82a04198>] do_one_initcall+0xb8/0x590
>     [<ffffffff82f0c626>] do_init_module+0x256/0x7d0
>     [<ffffffff82f12f73>] load_module+0x5953/0x7010
>     [<ffffffff82f14b0a>] init_module_from_file+0xea/0x140
> 
> To mitigate this, we need to check return value of kobject_add_internal,
> and free the name when an error is encountered.
> 
> Fixes: 244f6cee9a92 ("kobject: add kobject_add_ng function")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  lib/kobject.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index ecca72622933..365e2ad12cba 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -371,7 +371,13 @@ static __printf(3, 0) int kobject_add_varg(struct kobject *kobj,
>  		return retval;
>  	}
>  	kobj->parent = parent;
> -	return kobject_add_internal(kobj);
> +	retval = kobject_add_internal(kobj);
> +	if (retval) {
> +		kfree_const(kobj->name);
> +		kobj->name = NULL;
> +	}
> +
> +	return retval;
>  }
>  
>  /**
> -- 
> 2.25.1
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

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

