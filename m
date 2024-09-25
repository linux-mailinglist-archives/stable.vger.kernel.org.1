Return-Path: <stable+bounces-77686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159F3986079
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 633E1B30363
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E191D55A0;
	Wed, 25 Sep 2024 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="croZ6UPG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0C22C3C5;
	Wed, 25 Sep 2024 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266686; cv=none; b=ZO/rgOB14LlneXMsx7/88LVuTj2wJ49ERuI351oEsh5yrQTyYRDqacropRFc+jBKg3aIJDaCflCPc6WUQT2gEgQoqSQGMIZr4oaIfau+6FdzPF5kpXJm51PVHi8MuhVTJtkjvvyjZlCJIC3G2/wkP3pRXdtP21nKjGF2TW63UAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266686; c=relaxed/simple;
	bh=WYbX/CYBzzvA0ZfKnz90ChZuthLl9se19UtmvW4qUEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXQqK6wJslFnJEeOZv+fVAEjxk7yuoqAZu9Tm8olcYmgxqWNXjgM0IDxvyo/NphwwKYkzAMlJRsyntuRo6/Zuc+MUj2Iw5t1J1lqPP3TGTDwkm3VoPXdVJKiPsI2ymQbOKbFyELaqx4GrzudwiwAQgWy3sx/MYxZtaoIBZdqGN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=croZ6UPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C49CC4CEC3;
	Wed, 25 Sep 2024 12:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727266686;
	bh=WYbX/CYBzzvA0ZfKnz90ChZuthLl9se19UtmvW4qUEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=croZ6UPGprZAJSjf0wJwbyfqPwCA2datii0S8U5MolJ8XkVLBH5Llns4Oy+e8POS5
	 3KbzEc1zLmslvG4H65+v5H3XZ8/u2ek5/AiiFDyg3JCAcJ6i3iRUBAY2zQdRlHRtpT
	 xXypFo6xn1PqUO1kAhZempBHDQFj0TCpak4yuBdg=
Date: Wed, 25 Sep 2024 14:18:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org,
	thunder.leizhen@huawei.com, wangweiyang2@huawei.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH -next 1/2] kobject: fix memory leak in kset_register()
 due to uninitialized kset->kobj.ktype
Message-ID: <2024092552-buckskin-frivolous-3728@gregkh>
References: <20240925120747.1930709-1-cuigaosheng1@huawei.com>
 <20240925120747.1930709-2-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925120747.1930709-2-cuigaosheng1@huawei.com>

On Wed, Sep 25, 2024 at 08:07:46PM +0800, Gaosheng Cui wrote:
> If a kset with uninitialized kset->kobj.ktype be registered,
> kset_register() will return error, and the kset.kobj.name allocated
> by kobject_set_name() will be leaked.
> 
> To mitigate this, we free the name in kset_register() when an error
> is encountered due to uninitialized kset->kobj.ktype.
> 
> Fixes: 4d0fe8c52bb3 ("kobject: Add sanity check for kset->kobj.ktype in kset_register()")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  lib/kobject.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index 72fa20f405f1..ecca72622933 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -862,6 +862,8 @@ int kset_register(struct kset *k)
>  		return -EINVAL;
>  
>  	if (!k->kobj.ktype) {
> +		kfree_const(k->kobj.name);
> +		k->kobj.name = NULL;
>  		pr_err("must have a ktype to be initialized properly!\n");
>  		return -EINVAL;
>  	}
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

