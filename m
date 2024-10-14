Return-Path: <stable+bounces-83758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD1999C5D3
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3338DB283E6
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 09:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5512156F27;
	Mon, 14 Oct 2024 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vGsJGxyU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE2156F3F;
	Mon, 14 Oct 2024 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898292; cv=none; b=IvY1gLmluqThIO1Pb1y0MLgm+Wp94ejcGhJgDHy0vihr49u3wI4kkjRddm5avG0r1vLYE2AazMrewF8pWwiMBHEMe2E+47EpFOIFeJs7+pjeKZDiWslGg5XN3K9LnccxK1HSQZYQiDpdGmUdFuCTuT7qBJwZziHcudxBWXjKaf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898292; c=relaxed/simple;
	bh=nFVFUgUkB46dESU/WIJ+M33NfldRFmn0yHk8CLqSR+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWLZj5YlYHwYNaxSYwLTrr4DUlQh7BdU1nUctL2OrbcWJf31RYP1087zx9diC6E7q6c6kkYpNj/EcnrpUuqYD+D3zcemWgtBaX4lxzB25Wz6h4xeP5eds86ceU2ClNPh1JkSizTQ26NkDmkfH8OTS2WRrcDkXrmWz10sMSmlMhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vGsJGxyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736F5C4CEC3;
	Mon, 14 Oct 2024 09:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728898292;
	bh=nFVFUgUkB46dESU/WIJ+M33NfldRFmn0yHk8CLqSR+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vGsJGxyUAT+E4OoLbn5Tf31SY9UlvhS8BSA4pddbCQV1u6QDGgoxaJFIbr+jhfrPL
	 FrD2eUczCOUeKufK54xQmuI8VsImFXKDslZkcpZWTo+nr56bvC71kWNEOePt1IeB7/
	 7y9kg5JjinYGToYBsT/WxPnsJHgQfLGV4LmSrHq0=
Date: Mon, 14 Oct 2024 11:31:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Patch "cpufreq/amd-pstate-ut: Convert nominal_freq to khz during
 comparisons" has been added to the 6.6-stable tree
Message-ID: <2024101443-item-gainfully-9b2b@gregkh>
References: <20241011001826.1646318-1-sashal@kernel.org>
 <effb985a-34c5-4b42-8928-cb2618e1aaea@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <effb985a-34c5-4b42-8928-cb2618e1aaea@amd.com>

On Mon, Oct 14, 2024 at 10:50:23AM +0530, Dhananjay Ugwekar wrote:
> Hello,
>  
> This patch is only needed post the commit cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_nonlinear}_freq. Hence, please do not add it to the 6.6 stable tree.

Then the tag:

> 
> Thanks,
> Dhananjay
> 
> 
> On 10/11/2024 5:48 AM, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     cpufreq/amd-pstate-ut: Convert nominal_freq to khz during comparisons
> > 
> > to the 6.6-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      cpufreq-amd-pstate-ut-convert-nominal_freq-to-khz-du.patch
> > and it can be found in the queue-6.6 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > 
> > commit 09778adee7fa70b5efeaefd17a6e0a0b9d7de62e
> > Author: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> > Date:   Tue Jul 2 08:14:13 2024 +0000
> > 
> >     cpufreq/amd-pstate-ut: Convert nominal_freq to khz during comparisons
> >     
> >     [ Upstream commit f21ab5ed4e8758b06230900f44b9dcbcfdc0c3ae ]
> >     
> >     cpudata->nominal_freq being in MHz whereas other frequencies being in
> >     KHz breaks the amd-pstate-ut frequency sanity check. This fixes it.
> >     
> >     Fixes: e4731baaf294 ("cpufreq: amd-pstate: Fix the inconsistency in max frequency units")

Is wrong?

If so, that's fine, but note that this is why this was added to the
tree.

I'll go drop these from the queue now.

thanks,

greg k-h

