Return-Path: <stable+bounces-106190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D9C9FD19B
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 08:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C3F3A0601
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 07:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86295D8F0;
	Fri, 27 Dec 2024 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l1vgJz4z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F6B1876
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735285808; cv=none; b=KA3UB0rnPh838LwR3uuQUace0l8awxFAmBFoqsEtQ7b3J7buWdPq9rvPrzp+an1/KloOAMHwLH0GHQXiDze3nMbUMfUA4ilIWmZQtDtYSdtCKkRk4I3gOoI8iMhZRgGoIKbvHuRlVXclHKL89SU50B7XBEtYkLiA9KrOd7jXvgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735285808; c=relaxed/simple;
	bh=478NuM9+ec7vITnk68za+MFkKJzL1ftv6yIk1cadl4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiMIhBbl7ry5A/YCFnr+F5F7y/zhRnlytzY9uWjqwwrwbRPzlUSGKp1gPbTXrVWYMmyBnS0k7SebRZDoq1/sn3fPqEcyih+gpQvoHJ6d8ygSpF5GhqwCYq/wxgjQZcTNFdaTVyi1ryUmWTHYET1nGr7+1PGvXnYU1D9ZDW5iQOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l1vgJz4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FDCC4CED0;
	Fri, 27 Dec 2024 07:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735285806;
	bh=478NuM9+ec7vITnk68za+MFkKJzL1ftv6yIk1cadl4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l1vgJz4zrfjB93PrDQYftu+AtbeOYhKH5wJ4DcrBjSatm2OAQcH7WBNdRJdtGVTHN
	 HmU4HI7ctjwmath6sLfcKpI5RSfC4OdQUtTXpSvF4OIi5n2bOkCpHGsQGSBdFIIAGe
	 d0tgiX6B+223mKX/n/OMvPajET9BJTfLrYDvk0yU=
Date: Fri, 27 Dec 2024 08:50:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH] drm/amdgpu: fix backport of commit 73dae652dcac
Message-ID: <2024122742-chili-unvarying-2e32@gregkh>
References: <20241227073700.3102801-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227073700.3102801-1-alexander.deucher@amd.com>

On Fri, Dec 27, 2024 at 02:37:00AM -0500, Alex Deucher wrote:
> Commit 73dae652dcac ("drm/amdgpu: rework resume handling for display (v2)")
> missed a small code change when it was backported resulting in an automatic
> backlight control breakage.  Fix the backport.
> 
> Note that this patch is not in Linus' tree as it is not required there;
> the bug was introduced in the backport.
> 
> Fixes: 99a02eab8251 ("drm/amdgpu: rework resume handling for display (v2)")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3853
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org # 6.11.x

So the 6.12.y backport is ok?  What exact trees is this fix for?

thanks,

greg k-h

