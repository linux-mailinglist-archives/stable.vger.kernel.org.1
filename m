Return-Path: <stable+bounces-100440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C329EB4B0
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 16:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF52D16A5E0
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B6A1B85F0;
	Tue, 10 Dec 2024 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lU/K0eEU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B0478F23
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733844168; cv=none; b=Rl/aikHRDx2go4ZMxkVGTg9BIBSywT2brY8LDB5kFBn2GplfaethH/MCB5NDL4iVPeQ5tUoVU8VmNg0+uTbOghrOeM3kgbBvFdWhXEx3tEcxMaXyuhnmSBd/tEyxEd6hxjueaoi/aylQ+eUCI9YrxFw+VAqYOVvgS3oz91hRs5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733844168; c=relaxed/simple;
	bh=jSn45KUbIA2sv7poovBjS7a53unt1QOAnKZwOKxaNCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/GczJety1qKAO5M/MIV+RAaYH4BenSJL+/0DvrxNQFMGev7B+0hskjNzByKvomj1m4FyncLdQuPiHmX1kC15qgCPdc3lPUfy6IKesPEPU/BNs2Fmin0DJvdMBxMt5obRq58s0PLWwnuxKvuxKj9B0ZAHqR2GkeKtDP0fE+rsN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lU/K0eEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F83C4CED6;
	Tue, 10 Dec 2024 15:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733844168;
	bh=jSn45KUbIA2sv7poovBjS7a53unt1QOAnKZwOKxaNCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lU/K0eEUcNEnKYmfG4lUG1BmQ1DVZjRdiiOoQ22Ccqnv0S+lI4yF4p1Wu2emmhvsK
	 CF5a0lMcSwY7tPbFsqVr6igvHsgZQ63ZeefTCDqcYUVP+PCqDmKZabvXar+UvMC/Mr
	 Roq1RarceZ/mRRZy7JWIVTTdixeOrLU2XFRZ+pMA=
Date: Tue, 10 Dec 2024 16:22:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: marcelo.dalmas@ge.com, stable@vger.kernel.org
Subject: Re: [PATCH backport] ntp: Remove invalid cast in time offset math
Message-ID: <2024121004-riveter-heading-d7c3@gregkh>
References: <2024120622-enamel-avenge-5621@gregkh>
 <878qssr16f.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qssr16f.ffs@tglx>

On Fri, Dec 06, 2024 at 09:44:56PM +0100, Thomas Gleixner wrote:
> 
> From: Marcelo Dalmas <marcelo.dalmas@ge.com>
> 
> commit f5807b0606da7ac7c1b74a386b22134ec7702d05 upstream.
> 
> Due to an unsigned cast, adjtimex() returns the wrong offest when using
> ADJ_MICRO and the offset is negative. In this case a small negative offset
> returns approximately 4.29 seconds (~ 2^32/1000 milliseconds) due to the
> unsigned cast of the negative offset.
> 
> This cast was added when the kernel internal struct timex was changed to
> use type long long for the time offset value to address the problem of a
> 64bit/32bit division on 32bit systems.
> 
> The correct cast would have been (s32), which is correct as time_offset can
> only be in the range of [INT_MIN..INT_MAX] because the shift constant used
> for calculating it is 32. But that's non-obvious.
> 
> Remove the cast and use div_s64() to cure the issue.
> 
> [ tglx: Fix white space damage, use div_s64() and amend the change log ]
> [ tglx: Backport for 6.12.y and older ]
> 
> Fixes: ead25417f82e ("timex: use __kernel_timex internally")
> Signed-off-by: Marcelo Dalmas <marcelo.dalmas@ge.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/SJ0P101MB03687BF7D5A10FD3C49C51E5F42E2@SJ0P101MB0368.NAMP101.PROD.OUTLOOK.COM
> ---
>  kernel/time/ntp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Now applied, thanks.

greg k-h

