Return-Path: <stable+bounces-95802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C01089DC33F
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 13:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85961282593
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 12:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E839719B5A9;
	Fri, 29 Nov 2024 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bZ1a+inM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B402155A59
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732882351; cv=none; b=aJ+8YnH14t4n1AXmgjp+DtJOEL0KSuUFp/dDwJ+yybfn3WYRcg9aLEjjBWyuSD66NLcgxAzM7FvEeng8nj0NbEw/4DCcOupWsvQJxSaqFfgZjIcNW6/I32uWX4BD52iEixDTJrPeeJFTIxaWgLNVXA8JigBbByQkmJl8M7tdXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732882351; c=relaxed/simple;
	bh=KzkFzladwctQQ592V6GDeboxQLlaT4BvkmewxnKdPjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwmYcqiyLx/qFiBV5NfRE1/EoUpjC+Q9J5NY9miEM25p6SSlMGpL5Es2DqLyCApBL/hpWerUxcGtplGOcKKXxAm2nvNHMXCwvMBiyYjToG1qGyKoIaqyupZHW2N9gAZBwBHhcoeZ8NruK40NxHXltG86FELumrGmU5kMlUwxbLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bZ1a+inM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC89AC4CECF;
	Fri, 29 Nov 2024 12:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732882351;
	bh=KzkFzladwctQQ592V6GDeboxQLlaT4BvkmewxnKdPjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZ1a+inMUl5NNuccZEGjAbYmfV8AE+AxBlQc8mOXxHD9cggWtiHYIlqflZ4k20Pbd
	 bAMnSPXEued3j9j39Pdcdvkrg4tKMdzZYgqK2QW0KzZaRhbICu9gLAkPSJj+DSmtTn
	 yVSeBGHse7IcXWra8bVojpK4agbW0fCeIh8apv6k=
Date: Fri, 29 Nov 2024 13:12:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc: stable@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	Sasha Levin <sashal@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 5.15] kernfs: switch global kernfs_rwsem lock to per-fs
 lock
Message-ID: <2024112923-constrict-respect-a0a6@gregkh>
References: <20241129113236.209845-1-jpiotrowski@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129113236.209845-1-jpiotrowski@linux.microsoft.com>

On Fri, Nov 29, 2024 at 12:32:36PM +0100, Jeremi Piotrowski wrote:
> From: Minchan Kim <minchan@kernel.org>
> 
> [ Upstream commit 393c3714081a53795bbff0e985d24146def6f57f ]
> 
> The kernfs implementation has big lock granularity(kernfs_rwsem) so
> every kernfs-based(e.g., sysfs, cgroup) fs are able to compete the
> lock. It makes trouble for some cases to wait the global lock
> for a long time even though they are totally independent contexts
> each other.
> 
> A general example is process A goes under direct reclaim with holding
> the lock when it accessed the file in sysfs and process B is waiting
> the lock with exclusive mode and then process C is waiting the lock
> until process B could finish the job after it gets the lock from
> process A.
> 
> This patch switches the global kernfs_rwsem to per-fs lock, which
> put the rwsem into kernfs_root.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> Link: https://lore.kernel.org/r/20211118230008.2679780-1-minchan@kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> ---
> Hi Stable Maintainers,
> 
> This upstream commit fixes a kernel hang due to severe lock contention on
> kernfs_rwsem that occurs when container workloads perform a lot of cgroupfs
> accesses. Could you please apply to 5.15.y? I cherry-pick the upstream commit
> to v5.15.173 and then performed `git format-patch`.

This should not hang, but rather just reduce contention, right?  Do you
have real performance numbers that show this is needed?  What workloads
are overloading cgroupfs?  And why not just switch them to 6.1.y
kernels or newer?

thanks,

greg k-h

