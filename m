Return-Path: <stable+bounces-46032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A018CE08D
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 07:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2863282B52
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 05:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCAB37147;
	Fri, 24 May 2024 05:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GGKanJM6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5AF1804A;
	Fri, 24 May 2024 05:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716528074; cv=none; b=Cj0KAEdpyvnu6K5V+cu2/xPEwfhkkpkRVAcJ0zxKw+JvOqpXvxTShEu+tUa1e2I2YgxiZtAkuiG2xZMdgE9G9Yq0GF0/wsFjIQrbbXTJXCyhw9ZsuMBOQ/9O9UsECSepZPEpvPpYYYPU3stx6iU/cAt2SH8T75Zk7evsGGsM0kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716528074; c=relaxed/simple;
	bh=S8BFxfNUXwZOr3SFfU2nENOMJ/r7HVoRhywBIG/ZD2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUHk08P2zf7bgCrjxpvmWAKee/2JZAkzC09UWdl7b/kKsFrAgb90OX120HTAljf407xMtr9YUtC8BbaNzPYIbGMls8YVCGspBPRVB1Pg0qZZrUk4Z0rAX/QGVb2S8xJm5Ng/+eXKQQ28+LFpiG8QFTqh53TvCqEicLG90PWplTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GGKanJM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607CEC2BBFC;
	Fri, 24 May 2024 05:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716528073;
	bh=S8BFxfNUXwZOr3SFfU2nENOMJ/r7HVoRhywBIG/ZD2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGKanJM6a1UVwD7yE+ETv6BdcdZYHqpx8Pbha77suqyTJ+H3V1wiDzwBqkO1pGfxN
	 GxUQ/WwBT/sOKPoda8kqwLnfpoDKljSWb8DzlKMZDokp4nmfdeOfEQAzBHV0f/1i29
	 1BdU1NO+kU8MnqHjnF5iMhF41Nl1H5UHTxiH8/Mc=
Date: Fri, 24 May 2024 07:21:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kobject_uevent: Fix OOB access within zap_modalias_env()
Message-ID: <2024052438-hesitate-chevron-dbd7@gregkh>
References: <1716524403-5415-1-git-send-email-quic_zijuhu@quicinc.com>
 <2024052418-casket-partition-c143@gregkh>
 <74465bf5-ca18-45f8-a881-e95561c59a02@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74465bf5-ca18-45f8-a881-e95561c59a02@quicinc.com>

On Fri, May 24, 2024 at 01:15:01PM +0800, quic_zijuhu wrote:
> On 5/24/2024 12:33 PM, Greg KH wrote:
> > On Fri, May 24, 2024 at 12:20:03PM +0800, Zijun Hu wrote:
> >> zap_modalias_env() wrongly calculates size of memory block
> >> to move, so maybe cause OOB memory access issue, fixed by
> >> correcting size to memmove.
> > 
> > "maybe" or "does"?  That's a big difference :)
> > 
> i found this issue by reading code instead of really meeting this issue.
> this issue should be prone to happen if there are more than 1 other
> environment vars.

But does it?  Given that we have loads of memory checkers, and I haven't
ever seen any report of any overrun, it would be nice to be sure.

> do you have suggestion about term to use?

Some confirmation that this really is the case would be nice :)

> >> Fixes: 9b3fa47d4a76 ("kobject: fix suppressing modalias in uevents delivered over netlink")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >> ---
> >>  lib/kobject_uevent.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> >> index 03b427e2707e..f153b4f9d4d9 100644
> >> --- a/lib/kobject_uevent.c
> >> +++ b/lib/kobject_uevent.c
> >> @@ -434,7 +434,7 @@ static void zap_modalias_env(struct kobj_uevent_env *env)
> >>  
> >>  		if (i != env->envp_idx - 1) {
> >>  			memmove(env->envp[i], env->envp[i + 1],
> >> -				env->buflen - len);
> >> +				env->buf + env->buflen - env->envp[i + 1]);
> > 
> > How is this "more correct"?  Please explain it better, this logic is not
> > obvious at all.
> > 
> env->envp[] contains pointers to env->buf[] with length env->buflen,
> we want to delete environment variable pointed by env->envp[i] with
> length @len as shown below.
> 
> env->buf[]            |-> target block <-|
> 0-----------------------------------------env->buflen
>         ^             ^
> 	| ->  @len <- |
>   env->envp[i]   env->envp[i+1]
> 
> so move "target block" forward by @len, so size of target block is
> env->buf + env->buflen - env->envp[i+1] instead of env->buflen
> -len.
> 
> do you suggest add inline comments to explain it ?

Yes please.

thanks,

greg k-h

