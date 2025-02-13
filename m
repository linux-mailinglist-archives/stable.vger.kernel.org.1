Return-Path: <stable+bounces-115136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA40A33FF2
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122073AA6F5
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 13:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9642823F40B;
	Thu, 13 Feb 2025 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="is5ehE2j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5254523F400
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452235; cv=none; b=jRgc/ZcuA1l8nbJ/VtryP4T+12yuwbpJZMAgZCnCQ2+h8CRAZpLCOTbzTTdpy3SeFLLwn9zGA7516ffpsvjKEcmJPRyCosjESDoOlAUJ65rY76ZDbgsknKpKHdH7FVRA4zTWBtj5W5wyg32I7aPuP8r9sfmxr6jTji2W/5U8ktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452235; c=relaxed/simple;
	bh=lUm98dMM/f3dS4le63ZSS13DF9O9alx6JlHAx+p6gUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vb3+Y69mNkk2bNNfyrQeTiogFgday8I6aVBy8Ku41WcSC05QhoaWMqIrHPj1V7BeuwGwfYzgdtipyWIKAmu6AS3B3tOEKAPA3svUYUo8riu/pOzUiKOgzscfLO/qgGMtNTw7foq5JJ5GSGPHOAwm71q6WIA/hwE6Np11O39hvCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=is5ehE2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4727CC4CEE6;
	Thu, 13 Feb 2025 13:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739452233;
	bh=lUm98dMM/f3dS4le63ZSS13DF9O9alx6JlHAx+p6gUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=is5ehE2jbPJYfEvyR7kkL61MdKjfL/hxtdnxhl7onYWnBYQozW5q5mW5kKbEeVLFo
	 bjvaxGccyRD+IcfoA8trJOOKg33y2DITXmsDGEMjR2QTNyl/pFhYJwvtaD8SKt24cM
	 76Je8//l95XtZQtQk+I9t66xpHLTiR/u6Fizz0q8=
Date: Thu, 13 Feb 2025 14:10:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, sidhartha.kumar@oracle.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] maple_tree: simplify split calculation"
 failed to apply to 6.1-stable tree
Message-ID: <2025021310-vocalist-mascot-e303@gregkh>
References: <2025021128-repeater-percolate-6131@gregkh>
 <20250211140354.zaqzoa3b5xc77p27@master>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211140354.zaqzoa3b5xc77p27@master>

On Tue, Feb 11, 2025 at 02:03:54PM +0000, Wei Yang wrote:
> On Tue, Feb 11, 2025 at 10:48:28AM +0100, gregkh@linuxfoundation.org wrote:
> >
> >The patch below does not apply to the 6.1-stable tree.
> >If someone wants it applied there, or to any other stable or longterm
> >tree, then please email the backport, including the original git commit
> >id to <stable@vger.kernel.org>.
> >
> >To reproduce the conflict and resubmit, you may use the following commands:
> >
> >git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> >git checkout FETCH_HEAD
> >git cherry-pick -x 4f6a6bed0bfef4b966f076f33eb4f5547226056a
> ># <resolve conflicts, build, test, etc.>
> >git commit -s
> >git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021128-repeater-percolate-6131@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> >
> >Possible dependencies:
> >
> 
> Hi, Greg
> 
> commit 5729e06c819184b7ba40869c1ad53e1a463040b2
> Author: Liam R. Howlett <Liam.Howlett@oracle.com>
> Date:   Thu May 18 10:55:10 2023 -0400
> 
>     maple_tree: fix static analyser cppcheck issue
> 
> This commit reorder the comparison and leads to the conflict.
> 
> If you pick up this one first and then pick up 4f6a6bed0bfef4b966f0, there is
> no complain.
> 
> What do I suppose to do? Re-send these two patches? or merge then into one?

I took the above one first and then this one applied just fine, so
nothing else for you to have to do at all, thanks!

greg k-h

