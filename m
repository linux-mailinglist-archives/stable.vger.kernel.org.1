Return-Path: <stable+bounces-47633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D348D3453
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 12:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B9E1B228BA
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 10:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFBE17B42A;
	Wed, 29 May 2024 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vqbtRrgQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FFE169398;
	Wed, 29 May 2024 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977841; cv=none; b=IA35yUQLo2gKJbUOOJyich++2EHTnX+9RWM7Lvgcu5CM8JzJm0wNnvyLLYDstdqFv4GGqEG5jX3YJw7ScOZXKjmyh0mCSPsa762uBcnU7bscMePUndfV2wfrDZZm6BSO74LUXtxMSBAFVA4reqOoplT0LMBBQGZUGhZYITEDTBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977841; c=relaxed/simple;
	bh=Czi949DADm29y+/uucQdHueJL3drBx5CNw5SdCX8sF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3gAXTyWjllAKbETSVx/9lDVQWUrXQERixd+JcbCz5eanKHP8SotbR5KPglVVQnQekbSw0ul2F+iNFsK+mano5GNJ4jwFvB60zI+Rsw6L0o4cwp2NgAhJI/ynpN1B5TYhwddCHdqKEKAUSzJ2Kam1uEj0JdWZCQnEcCG8wgS0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vqbtRrgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D510C2BD10;
	Wed, 29 May 2024 10:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716977840;
	bh=Czi949DADm29y+/uucQdHueJL3drBx5CNw5SdCX8sF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vqbtRrgQMOdFub4BijLES/067YvaOGoLwh7IJe/Caeeoaptw3gdKlQwdAD/1kJqCz
	 9Ff9wto4/kpBPdFTmT6j1aVs7HrJp1oyKximLnt8C0ZpxdPctKHSfCtKZV2Ea21ViR
	 jOAOes1gXrnrAlTQ1T9NnCgaZdW/9xV0M9L2jNbg=
Date: Wed, 29 May 2024 12:17:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, rafael@kernel.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] kobject_uevent: Fix OOB access within
 zap_modalias_env()
Message-ID: <2024052933-extended-spender-fc41@gregkh>
References: <1716866347-11229-1-git-send-email-quic_zijuhu@quicinc.com>
 <ZlYo20ztfLWPyy5d@google.com>
 <74e2db16-007a-4b31-b43d-649516000f16@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74e2db16-007a-4b31-b43d-649516000f16@quicinc.com>

On Wed, May 29, 2024 at 06:07:06PM +0800, quic_zijuhu wrote:
> On 5/29/2024 2:56 AM, Dmitry Torokhov wrote:
> > On Tue, May 28, 2024 at 11:19:07AM +0800, Zijun Hu wrote:
> >> zap_modalias_env() wrongly calculates size of memory block to move, so
> >> will cause OOB memory access issue if variable MODALIAS is not the last
> >> one within its @env parameter, fixed by correcting size to memmove.
> >>
> >> Fixes: 9b3fa47d4a76 ("kobject: fix suppressing modalias in uevents delivered over netlink")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >> ---
> >> V1 -> V2: Correct commit messages and add inline comments
> >>
> >> V1 discussion link:
> >> https://lore.kernel.org/lkml/0b916393-eb39-4467-9c99-ac1bc9746512@quicinc.com/T/#m8d80165294640dbac72f5c48d14b7ca4f097b5c7
> >>
> >>  lib/kobject_uevent.c | 17 ++++++++++++++++-
> >>  1 file changed, 16 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> >> index 03b427e2707e..f22366be020c 100644
> >> --- a/lib/kobject_uevent.c
> >> +++ b/lib/kobject_uevent.c
> >> @@ -433,8 +433,23 @@ static void zap_modalias_env(struct kobj_uevent_env *env)
> >>  		len = strlen(env->envp[i]) + 1;
> >>  
> >>  		if (i != env->envp_idx - 1) {
> >> +			/* @env->envp[] contains pointers to @env->buf[]
> >> +			 * with @env->buflen elements, and we want to
> >> +			 * remove variable MODALIAS pointed by
> >> +			 * @env->envp[i] with length @len as shown below:
> >> +			 *
> >> +			 * 0          @env->buf[]      @env->buflen
> >> +			 * ----------------------------------------
> >> +			 *      ^              ^                  ^
> >> +			 *      |->   @len   <-|   target block   |
> >> +			 * @env->envp[i]  @env->envp[i+1]
> >> +			 *
> >> +			 * so the "target block" indicated above is moved
> >> +			 * backward by @len, and its right size is
> >> +			 * (@env->buf + @env->buflen - @env->envp[i + 1]).
> >> +			 */
> >>  			memmove(env->envp[i], env->envp[i + 1],
> >> -				env->buflen - len);
> >> +				env->buf + env->buflen - env->envp[i + 1]);
> > 
> > Thank you for noticing this, it is indeed a bug.
> > 
> > I wonder if this would not be expressed better as:
> > 
> > 			tail_len = env->buflen - (env->envp[i + 1] - env->envp[0]);
> > 			memmove(env->envp[i], env->envp[i + 1], tail_len);
> > 
> > and we would not need the large comment.
> >
> Greg KH suggests add inline comments since my fix is not obvious with
> first glance, let us wait for his comments within 2 days about below
> question:
> is it okay to remove those inline comments if block size to move is
> changed to env->buflen - (env->envp[i + 1] - env->envp[0]) ?

I'm all for making this simpler, please do so as Dmitry's response looks
better and easier to understand, don't you think?

And add comments, they are always good here for stuff like this :)

thanks,

greg k-h

