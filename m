Return-Path: <stable+bounces-136989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1261EAA01C6
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 07:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61956482C4F
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 05:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8D220C488;
	Tue, 29 Apr 2025 05:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PD6cIvlM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6E726FD82;
	Tue, 29 Apr 2025 05:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745904288; cv=none; b=ImXiHqMP6/90G7rD8ftnRolU2Uxoq5XwmLTzvl6DffwH9FQ7YO8qpAuTsRy3kaKdj7UB9U/UpIALzcrtGrNliuoa3xgr7xHI/fxu/52pPRt+8WKli+2F8xgTRs38gdzg7DkmLxHjG1jRQ3162oD+tab1EqjHdyYjE4zNQS2hl5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745904288; c=relaxed/simple;
	bh=UqK7GBBSQ6CsjvCjN/5GbJ+c0FiRdwrwd7xWWu5Y5Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgTvEc5y0J3g6pulE1lqvgSX4cGWUDb45AlrfPat4vF5gYGpSkxxXKCNKMSSLDnKYXZEpsMa+qxUWVerFM2gDt6jlOo9/ZZxeksiX6CgyISfvZmO5kaAf1bNyw7icEwfa0KYTDQSc1iAOzRFj5L2emkTnhP9q8U21l6NoLX5QYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PD6cIvlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54080C4CEE3;
	Tue, 29 Apr 2025 05:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745904288;
	bh=UqK7GBBSQ6CsjvCjN/5GbJ+c0FiRdwrwd7xWWu5Y5Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PD6cIvlMDpcl7T+5wBlQJt/WYAMwm7/6FarDDxxiE7dVn8P/3+0VbVF0FHJv01SKp
	 /zNufR9rSZGhxMSgIVipec/gzPAUHKTr/lfOlFEXdzzYX2pgxjziIWoA5j7n1ZxNg5
	 p9mSjzH12ujDgpde3xghnTVXgPr0oMbEB7fW7AGQ=
Date: Tue, 29 Apr 2025 07:24:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Ramesh.Errabolu@amd.com, Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: Patch "drm/amdgpu: Remove amdgpu_device arg from free_sgt api
 (v2)" has been added to the 5.10-stable tree
Message-ID: <2025042922-elliptic-impish-9c91@gregkh>
References: <20250426134009.817330-1-sashal@kernel.org>
 <d5b5c2c8-4c44-4500-a56b-12888abda85b@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5b5c2c8-4c44-4500-a56b-12888abda85b@amd.com>

On Mon, Apr 28, 2025 at 08:20:02PM +0200, Christian König wrote:
> On 4/26/25 15:40, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     drm/amdgpu: Remove amdgpu_device arg from free_sgt api (v2)
> > 
> > to the 5.10-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      drm-amdgpu-remove-amdgpu_device-arg-from-free_sgt-ap.patch
> > and it can be found in the queue-5.10 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Mhm, why has that patch been picked up for backporting? It's a cleanup and not a bug fix.
> 
> When some other fix depends on it it's probably ok to backport it as well, but stand alone it would probably rather hurt than help,

That is exactly why it is needed, see below:

> >     Stable-dep-of: c0dd8a9253fa ("drm/amdgpu/dma_buf: fix page_link check")

Hope this helps, thanks!

greg k-h

