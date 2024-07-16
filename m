Return-Path: <stable+bounces-60289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8993F932FE2
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A58282281
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E33619E7FE;
	Tue, 16 Jul 2024 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sScQPm+b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EAC54BD4;
	Tue, 16 Jul 2024 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154230; cv=none; b=scMbA6iuUanm0q6fnKHEXrTVekldvlPZg1Vvgr7LatCbXR5qITf+rlLRqIRegaz+Id/eLel98iQJcgYTUF3xMnCAmGeRv45W9TU2ei2DUipPUwt/Pq6LI4s1GIqK/S9YerWi7Qm7Yz6psEK2i70xLEd/jV2DtpQSw1LlTEwvuVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154230; c=relaxed/simple;
	bh=z5yTdBXbmrMVIksJABLAp8nR3U28hpuOwDGdNX8jAWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLYSsvb7CIjGJ7LTaDU89BJFKPn/zvJ5ZPRsdMcEaqVp1eBz78YGxivdjM8JEEHxi3PcqSAeM1KuaO6IbOBcrWnWuGOMFhD15mU/iBoFOJTuYp5/Am8QB7QAr0dsR4nyre6SASV3hbXpMSsK0FC3KpM426d6c+dGQ6WISe4VflE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sScQPm+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7832C116B1;
	Tue, 16 Jul 2024 18:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721154230;
	bh=z5yTdBXbmrMVIksJABLAp8nR3U28hpuOwDGdNX8jAWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sScQPm+bxV6RPHIQdQPUJ9LyeWwGPcuCOO/uBdtHabJv0sB1PVQjeoGSOafTCk67A
	 1pNvASiVdhDM88B2yT5WDhciJ2yOpD2nuAuwIJ6K6/cxbNQIm7goa1pHCMkgPOYb9w
	 eUCRwMmLnc+5RMtg0XOyG2MfAE3uZ3vjUaUNQerY=
Date: Tue, 16 Jul 2024 20:23:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y 0/7] Backport patches for DAMON merge regions fix
Message-ID: <2024071624-mustiness-quarterly-f34e@gregkh>
References: <20240716175205.51280-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716175205.51280-1-sj@kernel.org>

On Tue, Jul 16, 2024 at 10:51:58AM -0700, SeongJae Park wrote:
> Commit 310d6c15e910 ("mm/damon/core: merge regions aggressively when
> max_nr_regions") causes a build warning [1] on 6.1.y.  That was due to
> unnecessarily strict type check from max().
> 
> Fix the warning by backporting a minmax.h upstream commit that made the
> type check less strict for unnecessary case, and upstream commits that
> it depends on.
> 
> Note that all patches except the third one ("minmax: fix header
> inclusions") are clean cherry-picks of upstream commit.  For the third
> one, a minor conflict fix was needed.
> 
> [1] https://lore.kernel.org/2024071519-janitor-robe-779f@gregkh

Thanks for these, I'll queue them up after this round of -rc releases go
out in a few days.

greg k-h

