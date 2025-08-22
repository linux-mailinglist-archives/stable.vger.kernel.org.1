Return-Path: <stable+bounces-172309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B73B30EE9
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 08:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEC468591A
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 06:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB65142048;
	Fri, 22 Aug 2025 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y0C/FaOM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B48B1E4AB
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844071; cv=none; b=el1yL2BhHIH9smBdLcdo6uiI+pAfXjtnzGARoY8oYg2HIFHFrWwKR/1+Olti/Q/gU1Whknz9yb45DWJZjWFcLmbsLSd8hxID8aYhD78gxkM4nPM9vP71mpQWwIOu0Ns5PW4uCUBObwSf4Vm8dKciZ2GMO0+BcldV+0KZdELtcyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844071; c=relaxed/simple;
	bh=GB9m7R0rt5v9R+DoriTqgBJdAhQBqFfyNoTQcye8PlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvV2OvYUt3mkO7NfsHkDdNzt11gkfukdtdCDphl0c4RhQwT0oTLotEAPewGPiqRtIFBBhWuALKDBJ7VvGkNFlH+/s9i8vsN0rukjPVo0iMV1+fmfQHs8sMSEhWF/dSGq/4JgFrKXPIAjbnO6NHeP1vuNH64LAkN8HZbVX/T47Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y0C/FaOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A392AC4CEF1;
	Fri, 22 Aug 2025 06:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755844071;
	bh=GB9m7R0rt5v9R+DoriTqgBJdAhQBqFfyNoTQcye8PlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y0C/FaOMVY/kP3zI8tyNC4JwhOW1oYFnfCQwdGDm38zSWNQg5lP41f2sGfz8noSjz
	 Gz4sBi4LjfBXPwPNHoOSQ2wo1N0G3xCB/Rr52ipDAiozu4QpXAUqM6edrZfTnDl7+G
	 hMbF4nTNE9auHtOMAuNL4SP+veQpk0hUf4BBkhgw=
Date: Fri, 22 Aug 2025 08:27:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: superman.xpt@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/net: commit partial buffers on
 retry" failed to apply to 6.12-stable tree
Message-ID: <2025082232-scorecard-fame-d24c@gregkh>
References: <2025081548-whoops-aneurism-c7b1@gregkh>
 <75f257ff-21d3-4eae-afa1-a25cff16abe0@kernel.dk>
 <7a97e700-9ecb-4c17-b393-0f8a31c398e9@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a97e700-9ecb-4c17-b393-0f8a31c398e9@kernel.dk>

On Thu, Aug 21, 2025 at 03:46:33PM -0600, Jens Axboe wrote:
> On Fri, Aug 15, 2025 at 9:35?AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 8/15/25 9:26 AM, gregkh@linuxfoundation.org wrote:
> > >
> > > The patch below does not apply to the 6.12-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > >
> > > To reproduce the conflict and resubmit, you may use the following commands:
> > >
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 41b70df5b38bc80967d2e0ed55cc3c3896bba781
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081548-whoops-aneurism-c7b1@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> >
> > Trivial reject, here's one for 6.12-stable.
> 
> This didn't get included in the release yesterday?

Ick, this got dropped somehow, sorry about that.  I'll go queue it up
now, thanks for noticing.

greg k-h

