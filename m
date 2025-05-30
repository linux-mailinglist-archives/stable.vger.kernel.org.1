Return-Path: <stable+bounces-148159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C50BCAC8D42
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 13:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F77917906B
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 11:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BDF22A4FA;
	Fri, 30 May 2025 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WR7fYaP6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59FB20B806
	for <stable@vger.kernel.org>; Fri, 30 May 2025 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748606357; cv=none; b=DOZnNwCGiK0lQTUo6GKx6uCxCJDN6rLOC34TDpD1Tqqq07Mn+2txW/Kq9kUTVit6dAP9U1aCnuyrQBNwfypgas9bShyLf/V/Py1aPYw7jsLcIap+G+KFf9QuwX9hUUm2ll3hTu20azv1F2HfN1evGQGBy/RCA6kAlQb+pUUsjTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748606357; c=relaxed/simple;
	bh=NBYGeyTmazLtPAyxLjNU58YVvtlO11OxKAHMHAc6Egk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlLsEriwXFFtTKxEK0OA7r1O7H9S16geff7GQsdUf/t9RJbx7MGdFgCUm5nXkwdZUoYmL+/iCBzjE76/A9xjjGgvjpIgS9Qr9NWXTMfdXH+9bvmYqmEDftBh6ZnaOYlJg9JUL4Ay0l2Cr2MszR3l/ZInKF2L1nZAZdYb4lLO02M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WR7fYaP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793E9C4CEE9;
	Fri, 30 May 2025 11:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748606357;
	bh=NBYGeyTmazLtPAyxLjNU58YVvtlO11OxKAHMHAc6Egk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WR7fYaP6ugqtgESzcT+FJYp2tWWe0DMCrArdEDS7FUvF0V8d+DYGSFv41DtRpFgtN
	 r1lXqNr/NjvLnF9URuqCLu5gApu2Nq0M9lXxPI/Fy4XB4SnDOohOxh5LgvlrCTeUYz
	 MxOoka180Kq8Qbns01tROIXKkc/J9hjCmyc/2FFU=
Date: Fri, 30 May 2025 13:59:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: airlied@gmail.com, akpm@linux-foundation.org, alexander.deucher@amd.com,
	brgerst@gmail.com, christian.koenig@amd.com, hch@lst.de,
	hpa@zytor.com, jgross@suse.com, mingo@kernel.org,
	pierre-eric.pelloux-prayer@amd.com, simona@ffwll.ch,
	spasswolf@web.de, torvalds@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/mm/init: Handle the special case of
 device private pages" failed to apply to 5.15-stable tree
Message-ID: <2025053035-prison-lagged-0a17@gregkh>
References: <2025052750-fondness-revocable-a23b@gregkh>
 <0c1d51d3-7f25-4a7e-b97e-dc2177d6bfb6@nvidia.com>
 <300d265c-ff6c-4e01-a841-e8925e5d6d3b@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <300d265c-ff6c-4e01-a841-e8925e5d6d3b@nvidia.com>

On Fri, May 30, 2025 at 07:54:32PM +1000, Balbir Singh wrote:
> On 5/28/25 08:59, Balbir Singh wrote:
> > On 5/28/25 02:55, gregkh@linuxfoundation.org wrote:
> >>
> >> The patch below does not apply to the 5.15-stable tree.
> >> If someone wants it applied there, or to any other stable or longterm
> >> tree, then please email the backport, including the original git commit
> >> id to <stable@vger.kernel.org>.
> >>
> >> To reproduce the conflict and resubmit, you may use the following commands:
> >>
> >> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> >> git checkout FETCH_HEAD
> >> git cherry-pick -x 7170130e4c72ce0caa0cb42a1627c635cc262821
> >> # <resolve conflicts, build, test, etc.>
> >> git commit -s
> >> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052750-fondness-revocable-a23b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> >>
> >> Possible dependencies:
> >>
> >>
> > 
> > We only need it if 7ffb791423c7 gets backported. I can take a look and see if we need the patch and why the application of the patch failed
> > 
> > Balbir
> > 
> 
> Hi, Greg
> 
> FYI: I was able to cherry pick 7170130e4c72ce0caa0cb42a1627c635cc262821 on top of
> 5.15.y (5.15.184) on my machine
> 
> I ran the steps below
> 
> >> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> >> git checkout FETCH_HEAD
> >> git cherry-pick -x 7170130e4c72ce0caa0cb42a1627c635cc262821
> 
> I saw no conflicts. Am I missing something?

Did you test build it as the instructions above asked you to do?

Try it and see what happens :)

thanks,

greg k-h

