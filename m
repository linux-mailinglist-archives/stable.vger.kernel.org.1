Return-Path: <stable+bounces-300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF807F786A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 16:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0435B20AD5
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6F92E831;
	Fri, 24 Nov 2023 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iv7VQiWV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE1333062
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 15:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65641C433C7;
	Fri, 24 Nov 2023 15:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700841473;
	bh=lv5ykoEIK5HYy9p2cWVHgs3wx+bPRg5Xd31TWsh6Goc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iv7VQiWVohBjF3/OmLlHoZ9EMwR5qHsJ0VnQmc3GtegGeKcQu+q1SAywooKcrQxH3
	 CaQzcSzxtRV3jxggCNaaihQcbOW66U1XKvHsOFKq/fTogIySmx/x8zq6nLEE+K5giD
	 pLfKFGFmS5uinIeDBpSVRWZ05+7cRiX32CLmMGos=
Date: Fri, 24 Nov 2023 15:57:51 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Helge Deller <deller@gmx.de>
Cc: sam@gentoo.org, stable@vger.kernel.org, torvalds@linux-foundation.org,
	Florent Revest <revest@chromium.org>,
	Kees Cook <keescook@chromium.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: FAILED: patch "[PATCH] prctl: Disable prctl(PR_SET_MDWE) on
 parisc" failed to apply to 6.5-stable tree
Message-ID: <2023112420-reward-relative-f84d@gregkh>
References: <2023112456-linked-nape-bf19@gregkh>
 <1aadb9ed-5118-4a6f-a273-495466f4737b@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aadb9ed-5118-4a6f-a273-495466f4737b@gmx.de>

On Fri, Nov 24, 2023 at 04:10:25PM +0100, Helge Deller wrote:
> On 11/24/23 12:35, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 6.5-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 793838138c157d4c49f4fb744b170747e3dabf58
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112456-linked-nape-bf19@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 793838138c15 ("prctl: Disable prctl(PR_SET_MDWE) on parisc")
> > 24e41bf8a6b4 ("mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl")
> > 0da668333fb0 ("mm: make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long")
> 
> Greg, I think the most clean solution is that you pull in this patch:
> 
> commit 24e41bf8a6b424c76c5902fb999e9eca61bdf83d
> Author: Florent Revest <revest@chromium.org>
> Date:   Mon Aug 28 17:08:57 2023 +0200
>     mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl
> 
> as well into 6.5-stable and 6.6-stable prior to applying my patch.
> 
> Florent, Kees and Catalin, do you see any issues if this patch
> ("mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl") is backported
> to 6.5 and 6.6 too?
> If yes, I'm happy to just send the trivial backport of my patch below...

Given that we need an explicit ack for adding mm: patches to the stable
trees, I'll wait for that to happen here before adding it.

thanks,

greg k-h

