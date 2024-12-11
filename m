Return-Path: <stable+bounces-100602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174B29ECA30
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 11:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D512160EE8
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 10:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225F11EC4C5;
	Wed, 11 Dec 2024 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wCRyFgn6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBE2236FA9;
	Wed, 11 Dec 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912437; cv=none; b=SJsfbc6ZvKjwc8tVAMXON6/1oC9ZvCEdfNCsmsTbxBwityYWGAsUkJ7TKJAp0PoXnW3f+zeAPz/T+mC7KiA0ukATJ2KMGH9GfPb2XqqRnRKTI0/qHjJdoJW9i2J47Of3VKtF333K/GirEyHVoCgeHw6YtVlLIYldxan/BolcbZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912437; c=relaxed/simple;
	bh=AxDltFLRVVzlvIw1IOEck6n/X0HRP7ggK3B9Rl+OlL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZ7rvQjoExwGaqi9+X+0AtPm7iOLRjfjYjvEvEjjDZyklbDJhLuGngOB7GkDyA7NMbiEakxsWBAZ0tMA9hJ3GxPaIY+KeIjre59S+LjK3xhEZOZz91u6VgT+0/Z9jJycSLDkgX6gaM6FYFvuXSCuzbE4IWL5sxyx3WYzRO4/tw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wCRyFgn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78F8C4CED2;
	Wed, 11 Dec 2024 10:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733912437;
	bh=AxDltFLRVVzlvIw1IOEck6n/X0HRP7ggK3B9Rl+OlL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wCRyFgn64N+gD2WklLXJ8glulWuORMn2DvkSeBlmqpIp/VWBf+3va78akn/rwnYwt
	 eqbua/qcNDuPM5QHpzENjXIzDNVFa1f0mt4aw2TdtLK1Wtu9FiViK/EDMg1pC0cvrw
	 o9KFGyifyVN3lhMdfX7H2Mx7Wr0vXg9JWhWKP260=
Date: Wed, 11 Dec 2024 11:20:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: Patch "drm/sched: memset() 'job' in drm_sched_job_init()" has
 been added to the 6.12-stable tree
Message-ID: <2024121126-tableful-bath-f0a0@gregkh>
References: <20241210204128.3579664-1-sashal@kernel.org>
 <fcfc505ed42d7b263a209631c43734fb6674377e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcfc505ed42d7b263a209631c43734fb6674377e.camel@redhat.com>

On Wed, Dec 11, 2024 at 11:00:02AM +0100, Philipp Stanner wrote:
> On Tue, 2024-12-10 at 15:41 -0500, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     drm/sched: memset() 'job' in drm_sched_job_init()
> > 
> > to the 6.12-stable tree which can be found at:
> >    
> > http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      drm-sched-memset-job-in-drm_sched_job_init.patch
> > and it can be found in the queue-6.12 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable
> > tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Hi,
> 
> you can add it, it does improve things a bit.
> 
> But I'd like to use this opportunity to understand by what criteria you
> found and selected this patch? Stable was not on CC, neither does the
> patch contain a Fixes tag.

You did see the AUTOSEL emails with this commit in it back on November
24, right?  that should explain this.

thanks,

greg k-h

