Return-Path: <stable+bounces-56115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEDD91CB92
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 10:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DE81C21016
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 08:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E84376F5;
	Sat, 29 Jun 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t8OwwRjD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372511109
	for <stable@vger.kernel.org>; Sat, 29 Jun 2024 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719648656; cv=none; b=DySB5YAgGEbn5R2gFAHfYOYXo7CelXq7Y8Bz4Vc6C11nRxLRm5So8eLyZ9REsuUWU0kB6S+Wf/LWCBZfi+dpBuLmxjxCS5hdXFGotHFKbiImfffQM6EIyusI1rbLx/aSLIGHnI9/yn6ea/Y8O6nyINipJcrck0FA8WoHNqhXoWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719648656; c=relaxed/simple;
	bh=pmJKqCGfPvaLcZyMLLjmpoZTsxOKWBtVI+HT1VebSSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ram0XZBBmhI3fBPE0G2Nvw10PtCIra4hCOWAfAxYrpSZmeeTrY/TEu6GNQRmZhf0tswYBfPWwQ7fzAsj6yLFqAEJYcHXCGORKI866XB/QBuR3FKPGz4wGLvXJ0MODfjxx0jazHeotY3ACfhF04+j5/nxgXMo1aGxDQI3yW1mMsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t8OwwRjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32710C2BBFC;
	Sat, 29 Jun 2024 08:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719648655;
	bh=pmJKqCGfPvaLcZyMLLjmpoZTsxOKWBtVI+HT1VebSSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t8OwwRjDwuQy58oDr0dZ0aFBINFQe/dVXyRa1K9wAT9aJ4w7BMuPBfNLrog46iH/+
	 NXncviOA84vlWV5SdlNZdz6p+G+JenZx+Vu6uOtplkS/48K1oLQbhynOTqDrlwAsg8
	 khGStbSMNf9ScUdpa+bTXpGelwcz+O6wNLEmzHVg=
Date: Sat, 29 Jun 2024 10:10:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Cc: rpeterso@redhat.com, agruenba@redhat.com, cluster-devel@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1.96] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
Message-ID: <2024062953-problem-truth-ce3c@gregkh>
References: <54398cb8-92e0-4ed2-8691-38f6d48efc9a@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54398cb8-92e0-4ed2-8691-38f6d48efc9a@gmail.com>

On Fri, Jun 28, 2024 at 12:07:52PM -0600, Clayton Casciato wrote:
> [ Upstream commit bdcb8aa434c6d36b5c215d02a9ef07551be25a37 ]
> 
> In gfs2_put_super(), whether withdrawn or not, the quota should
> be cleaned up by gfs2_quota_cleanup().
> 
> Otherwise, struct gfs2_sbd will be freed before gfs2_qd_dealloc (rcu
> callback) has run for all gfs2_quota_data objects, resulting in
> use-after-free.
> 
> Also, gfs2_destroy_threads() and gfs2_quota_cleanup() is already called
> by gfs2_make_fs_ro(), so in gfs2_put_super(), after calling
> gfs2_make_fs_ro(), there is no need to call them again.
> 
> The origin of a cherry-pick conflict is the (relevant) code block added in
> commit f66af88e3321 ("gfs2: Stop using gfs2_make_fs_ro for withdraw")
> 
> There are no references to gfs2_withdrawn() nor gfs2_destroy_threads() in
> gfs2_put_super(), so we can simply call gfs2_quota_cleanup() in a new else
> block as bdcb8aa434c6 achieves.
> 
> Else braces were used for consistency with the if block.
> 
> Sponsor: 21SoftWare LLC

That's not a valid tag for kernel commits, sorry.

> Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>

What happened to the original authorship information, and all of the
other signed-off-by that were on the original commit?  YOu can not just
delete them, would you want someone doing that to a patch you
contributed?

as-is, we can't take this, please fix up.

thanks,

greg k-h

