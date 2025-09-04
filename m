Return-Path: <stable+bounces-177761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0815AB4429A
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 18:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B703F1C83AAD
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6E9224B04;
	Thu,  4 Sep 2025 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f/tNhjGP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F0F2248AF
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003016; cv=none; b=QTGE4KrjO2lMwmHkZTG7Rx0SUu1iUoeXETZpCjPRHu6xCF0Wu6OZVPDXzH4xkZk1XgSdnIfuBG2s70rmAd6cIPLQHBojmlr1QmS3j0EiDphrGnXRpQtJuFFN4v9Vw83K3v2w+3r7uJ+aLzM+A8V1xY1hP6mIaCnKzU9iKvhs4kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003016; c=relaxed/simple;
	bh=KrGYLpVHbqqiw3f6/nMp/V+ws+LxEGPVPZu4avylxv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqRTDFz5JiMJw+O5GvWoEuoscu0aH7z220DM+M1r3BOD6/jf8IAZTa0X0585hSQozlR0hRdBIvWW9Ibw1XEvw0FvrJN39kT4/Dd1SQqH22FVc/LyDazm3Kwgf8zwGnQ9EAlwOwhevUxLSedSNS7YbTXOBD12cWqj63ZJy44B5Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f/tNhjGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63758C4CEF0;
	Thu,  4 Sep 2025 16:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757003015;
	bh=KrGYLpVHbqqiw3f6/nMp/V+ws+LxEGPVPZu4avylxv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f/tNhjGPbPK3KwrN8OPyQ0ZGKn49NmQ2Ysu4CwFRjG4KVIqAlOO8PUNjwY/heajIC
	 g6vAffrqyc9elRnRnXuyJZ10nsxkJjsU2iDagzZ0llFPJthDPaUS0IDdibdflv7N/d
	 ovtoFstZBEUyMcSUAd3cLK7Hcm0gyMsyU1e4V6jk=
Date: Thu, 4 Sep 2025 18:23:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jules Maselbas <jmaselbas@zdiv.net>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.12 00/95] 6.12.45-rc1 review
Message-ID: <2025090436-endearing-district-4d58@gregkh>
References: <20250902131939.601201881@linuxfoundation.org>
 <DCJ7CTIZJNOG.1RTW7M8MG9UG0@zdiv.net>
 <2025090453-scorecard-entrust-fd1d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025090453-scorecard-entrust-fd1d@gregkh>

On Thu, Sep 04, 2025 at 06:07:39PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 03, 2025 at 03:34:02PM +0200, Jules Maselbas wrote:
> > Hi Greg,
> > 
> > Yesterday i experienced an issue with the amdgpu driver on v6.12.44, dmesg saying:
> >     [drm:amdgpu_job_submit [amdgpu]] *ERROR* Trying to push to a killed entity
> > 
> > which causes the kernel to freeze/hang, not cool.
> > 
> > I think this issue is fixed by this commit [1]: aa5fc4362fac ("drm/amdgpu: fix task hang from failed job submission during process kill")
> > it has a Fixes for the commit: 71598a5a7797 ("drm/amdgpu: Avoid extra evict-restore process.")
> > which is in the v6.12.44 tree (but not in v6.12.43)
> > 
> > I am currently on v6.16.4 which include the fix above and i no longer have the issue.
> > 
> > It would be great to include the fix in the v6.12.45 release.
> > 
> > I am not subscribed to this mailing-list, please add me in CC in your reply.
> 
> Odd subject line :)
> 
> I've queued this up now, thanks.

OOps, nope, now dropped.  This fails to build, so how did you test this?

Please send a working patch for this if you want it in 6.12.y.

thanks,

greg k-h

