Return-Path: <stable+bounces-167127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C74CB224F4
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 12:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B69D564E39
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 10:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B582EBBBB;
	Tue, 12 Aug 2025 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wOIYbuTi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCEF2EB5C3;
	Tue, 12 Aug 2025 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995830; cv=none; b=AmKmZEQkYwcnagjPo7hehOFDqgPH2FtrYAnQWS6Y7gc0zHSFvXLXF/ZAx/jaqCj3VEs2NTDxxYHjgRkEs7rc8+85Yuacgr8k7UpwqTRmsLoYNIZXx+kG0wYnylF1Fo8tl53VJwCDMuqRXawGcU00HwjgNSMOxQimsOu8OAilep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995830; c=relaxed/simple;
	bh=u9Nsd/HGEybF6jnWhLv2pKeQYGpCtZn/AueJ3h0v2vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDjo2FkOy6qG6llxo5w+PjLJa6WwQSgscLaSfhnC0Lx6pLmsvIg8r+QEDtCvyrgaOvBM/ExK7uCWB9uXiNYKNSS0f+egj2DUEWHuaO8ynnsXh4OXuoSt1xreIz8nypkRmkffiK9NbG1WnS5xUfspX2P5YjOtOaEqrR0GEwZZspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wOIYbuTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D287C4CEF0;
	Tue, 12 Aug 2025 10:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754995829;
	bh=u9Nsd/HGEybF6jnWhLv2pKeQYGpCtZn/AueJ3h0v2vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wOIYbuTicuNXav3fej090zi1elsZMFRPlVDhOS9xlB3x8SpVVZhj0iN8j2fwHu2zD
	 vKwbIGkK4UhRCoMhk6OUpPh76By/G7W+JDm5O5ItAcR1uI/YG38ldgYTWMZLH4s1Ah
	 JFgeInpfbmWYnMx8EygWz3yslC6QDad3mCIFCGB0=
Date: Tue, 12 Aug 2025 12:50:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: rpeterso@redhat.com, agruenba@redhat.com, gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6.6] gfs2: replace sd_aspace with sd_inode
Message-ID: <2025081207-thermos-secret-ce3a@gregkh>
References: <20250805194005.327445-1-sumanth.gavini.ref@yahoo.com>
 <20250805194005.327445-1-sumanth.gavini@yahoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805194005.327445-1-sumanth.gavini@yahoo.com>

On Tue, Aug 05, 2025 at 02:40:04PM -0500, Sumanth Gavini wrote:
> commit ae9f3bd8259a0a8f67be2420e66bb05fbb95af48 upstream.
> 
> Currently, sdp->sd_aspace and the per-inode metadata address spaces use
> sb->s_bdev->bd_mapping->host as their ->host; folios in those address
> spaces will thus appear to be on bdev rather than on gfs2 filesystems.
> This is a problem because gfs2 doesn't support cgroup writeback
> (SB_I_CGROUPWB), but bdev does.
> 
> Fix that by using a "dummy" gfs2 inode as ->host in those address
> spaces.  When coming from a folio, folio->mapping->host->i_sb will then
> be a gfs2 super block and the SB_I_CGROUPWB flag will not be set in
> sb->s_iflags.
> 
> Based on a previous version from Bob Peterson from several years ago.
> Thanks to Tetsuo Handa, Jan Kara, and Rafael Aquini for helping figure
> this out.
> 
> Fixes: aaa2cacf8184 ("writeback: add lockdep annotation to inode_to_wb()")
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
> ---

This is very different from the original commit and you did not document
that :(

Please fix up and resend.

thanks,

greg k-h

