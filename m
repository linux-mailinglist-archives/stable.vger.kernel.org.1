Return-Path: <stable+bounces-163698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C99DCB0D96D
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BC66C50A5
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 12:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249552E9754;
	Tue, 22 Jul 2025 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yWtLUkgX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E292E11AD
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186718; cv=none; b=eWF62dme9INYcgAo+gZRyNcxOGcC7ZhfxRkw3Yr1AdzLvI+z+uZQF5OU/vi+N0pkq1JwOFCJxoFxipS+mCS+vcEaKBErPyN4HAVj7OL3YgmEZ5M2XIMnKNIi/NI3LtJI4GcW4qTJa65K5zYNpX9Mqs1FBVvTPVL2AUwy5KrfkJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186718; c=relaxed/simple;
	bh=PMlaBPj7wcJuPmOVen6+UcwYtFJSOJ9ZJm3ambuCucw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5F064ptCYIru4kfDOOZbbkyAx86XHPFddcmhCZypK58M4C1Sg0sx5Hg3MetCdqmXaI8FbbMaYpQthPoxAEl89VzPoCcOxVE+X1QDCWlLV1xF+Rr1KTmRIgTuRDncE8kBHlzbgaSxp/e3VQaC0Jsi1b0zAlFpHxZKpk7uoNkXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yWtLUkgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B895CC4CEF1;
	Tue, 22 Jul 2025 12:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753186718;
	bh=PMlaBPj7wcJuPmOVen6+UcwYtFJSOJ9ZJm3ambuCucw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yWtLUkgXpJ2bHXNnSsGOSQie0YjldY8vDe9KKtr5mdZpwul/fgT3HwYQMVKv73oxl
	 NLDxUXjeuZaV9dtsvo6JWTGFZRzWkVppsc+GJYr59OdONquqDM+U+toMk+QCMrdh8k
	 XZPqBZISkHH+lWKwUVrlIT7+VhnvCPf/JVZl8iM0=
Date: Tue, 22 Jul 2025 14:18:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: chenridong <chenridong@huawei.com>, stable@vger.kernel.org,
	"stable-commits@vger.kernel.org Sasha Levin" <sashal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: Patch "Revert "cgroup_freezer: cgroup_freezing: Check if not
 frozen"" has been added to the 6.15-stable tree
Message-ID: <2025072222-effective-jumble-c817@gregkh>
References: <20250721125251.814862-1-sashal@kernel.org>
 <1bafc8a024da4a95b28c02430f3d0c9d@huawei.com>
 <3f80facc-8bef-4fc7-ac7e-59279906a707@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f80facc-8bef-4fc7-ac7e-59279906a707@huaweicloud.com>

On Tue, Jul 22, 2025 at 09:29:13AM +0800, Chen Ridong wrote:
> 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"
> > 
> > to the 6.15-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      revert-cgroup_freezer-cgroup_freezing-check-if-not-f.patch
> > and it can be found in the queue-6.15 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree, please let <stable@vger.kernel.org> know about it.
> > 
> 
> The patch ("sched,freezer: Remove unnecessary warning in __thaw_task") should also be merged to
> prevent triggering another warning in __thaw_task().

What is the git commit id of that change in Linus's tree?

thanks,

greg k-h

