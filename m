Return-Path: <stable+bounces-111261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FFBA229D2
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 09:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDE41669F4
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 08:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE281953A1;
	Thu, 30 Jan 2025 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v7Z+RdZN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9921922D8
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738226920; cv=none; b=eBRGJBQ0m0DGxuwphcLT8FQV6JrSnFHw3hDXU5YKcTGOQrAImULGSBmPUZda4id9oLbY46W32N960iEcJZDn7tO8KxkIuW3rbx6hxJFJp5f8x4HQDzgtzC16+iYLJvMQeatbWUAHS2FpPMRMWaHTenRqz/SmtuAvsErrW2tYhPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738226920; c=relaxed/simple;
	bh=Zzd0Tn1ouBVPqzgveIkWIU/sLiUR2EWoGcgx5falcJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4AYng9q2OVZJaCVq8DbwgWG5EZxNbaFqciZQPdjEuqLEHL7CWilCIyE+6Qj5w7BlWVas6u4/lGWAgqBkGQPeJ21s4LK6Q50TteMKb6PxZRlH0QbHCsVQwg6hokOJlJkRloWBJmecIvgDjgKLA3Nkxj0nLKq88xI6EdOLn53wiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v7Z+RdZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABDFC4CED2;
	Thu, 30 Jan 2025 08:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738226919;
	bh=Zzd0Tn1ouBVPqzgveIkWIU/sLiUR2EWoGcgx5falcJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v7Z+RdZN9exvftwPuDeD72iXvkODRMKOgn886QM27lfYobwe9TdYYq6tPjn5xYyNa
	 dUvjiK+9QwYxe68JvvE6nTDtCunkKaRNTjKtW8UOuf37PyeUw5vclMxBU9fN7zcaWx
	 oj9Lmkcv4EjDetkVlFV5iEzMU1qMbi8BtsQQBh5k=
Date: Thu, 30 Jan 2025 09:48:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
	Paulo Alcantara <pc@manguebit.com>
Subject: Re: Backport smb client fix for special files
Message-ID: <2025013029-qualifier-stopwatch-0547@gregkh>
References: <20250126150558.qybkjdcx3qbhmgcb@pali>
 <2025012647-implode-levitator-502a@gregkh>
 <20250126183424.oumzbwflyunn75uv@pali>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250126183424.oumzbwflyunn75uv@pali>

On Sun, Jan 26, 2025 at 07:34:24PM +0100, Pali Rohár wrote:
> On Sunday 26 January 2025 17:17:25 Greg KH wrote:
> > On Sun, Jan 26, 2025 at 04:05:58PM +0100, Pali Rohár wrote:
> > > Hello,
> > > 
> > > I would like to propose backporting this commit to stable releases:
> > > https://git.kernel.org/torvalds/c/3681c74d342db75b0d641ba60de27bf73e16e66b
> > > smb: client: handle lack of EA support in smb2_query_path_info()
> > 
> > Doesn't that need to go into a release first?
> 
> Ou, it really is not released yet. I was just rebasing my branch on top
> of the Linus's master branch and somehow I thought that changes which
> "git rebase" dropped from my branch were already released.
> 
> So sure, first the change needs to be released and then it could be
> proposed for backporting.
> 
> > > It is fixing support for querying special files (fifo/socket/block/char)
> > > over SMB2+ servers which do not support extended attributes and reparse
> > > point at the same time on one inode, which applied for older Windows
> > > servers (pre-Win10).
> > > 
> > > I think that commit should have line:
> > > Fixes: ea41367b2a60 ("smb: client: introduce SMB2_OP_QUERY_WSL_EA")
> > > 
> > > Note that the mention commit depends on:
> > > ca4b2c460743 ("fs/smb/client: avoid querying SMB2_OP_QUERY_WSL_EA for SMB3 POSIX")
> > 
> > So what exactly should the series of commits be that we backport and to
> > what kernel tree(s)?
> 
> I would propose to backport these two commits (in this order):
> ca4b2c460743 ("fs/smb/client: avoid querying SMB2_OP_QUERY_WSL_EA for SMB3 POSIX")
> 3681c74d342d ("smb: client: handle lack of EA support in smb2_query_path_info()")
> 
> into all stable branches which already contain this commit:
> ea41367b2a60 ("smb: client: introduce SMB2_OP_QUERY_WSL_EA")
> 
> Hopefully it is clear now.

Yes, now queued up properly, thanks!

greg k-h

