Return-Path: <stable+bounces-177760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B033B44238
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 18:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145C21889B8D
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 16:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0352C21D8;
	Thu,  4 Sep 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LJI4253r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30277287269
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002063; cv=none; b=ktMRdRbUCMQEF3IQKuFwqklKab5/X3Ez7Cj1ZjafazJqZnL7ajsdJ7VYpG+gJ359TBT4DQB+5rSOdoQqZUv89nmaJt8u6DH+tFztfjCRlFM/PsC+TNsR96DfQ6Bq3bvguVWAaD40hevTmWDBELmPFFWIz4W6G0KYlW3tsgYbvG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002063; c=relaxed/simple;
	bh=0SOI0yxv6ACxj6nBjxmmzEdcCpfAw2aYXbPcfR4+r7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msULuDTHsJZYSzwcsZ4trnN61fnyhZYstG3yDPGzqfmkFUJhycHP5cb85F6p9HxTgRzcGjmRD92xXk6BVTUMnG2vy3lYC2ibZo5TST87I4Ex/PTdzXzhX+lKSFNTjEYVDcjVtqfJE/WQs8Foi5idLpDfTXAgo2TeX0QO2TiJ64k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LJI4253r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3287FC4CEF6;
	Thu,  4 Sep 2025 16:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757002062;
	bh=0SOI0yxv6ACxj6nBjxmmzEdcCpfAw2aYXbPcfR4+r7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJI4253r21sUl3WXP0HF6LZXfctHAxdyfdoZnbkmVfi43G+xUPViutbBVaQ+l03yP
	 cjyCMMS7EgggTRZbkf9fZc8wD294H3fdZgL3zh5+NGM86iNneyNy/dVGXJfi2BeKvs
	 0GV+Me1ezDYyFEAUcr7en+H7wcq86rTLzLcPGU94=
Date: Thu, 4 Sep 2025 18:07:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jules Maselbas <jmaselbas@zdiv.net>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.12 00/95] 6.12.45-rc1 review
Message-ID: <2025090453-scorecard-entrust-fd1d@gregkh>
References: <20250902131939.601201881@linuxfoundation.org>
 <DCJ7CTIZJNOG.1RTW7M8MG9UG0@zdiv.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCJ7CTIZJNOG.1RTW7M8MG9UG0@zdiv.net>

On Wed, Sep 03, 2025 at 03:34:02PM +0200, Jules Maselbas wrote:
> Hi Greg,
> 
> Yesterday i experienced an issue with the amdgpu driver on v6.12.44, dmesg saying:
>     [drm:amdgpu_job_submit [amdgpu]] *ERROR* Trying to push to a killed entity
> 
> which causes the kernel to freeze/hang, not cool.
> 
> I think this issue is fixed by this commit [1]: aa5fc4362fac ("drm/amdgpu: fix task hang from failed job submission during process kill")
> it has a Fixes for the commit: 71598a5a7797 ("drm/amdgpu: Avoid extra evict-restore process.")
> which is in the v6.12.44 tree (but not in v6.12.43)
> 
> I am currently on v6.16.4 which include the fix above and i no longer have the issue.
> 
> It would be great to include the fix in the v6.12.45 release.
> 
> I am not subscribed to this mailing-list, please add me in CC in your reply.

Odd subject line :)

I've queued this up now, thanks.

greg k-h

