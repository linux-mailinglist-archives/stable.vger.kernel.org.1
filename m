Return-Path: <stable+bounces-110816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BFBA1CD74
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 19:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED391882AA0
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3661D1509BD;
	Sun, 26 Jan 2025 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbAf8DXI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61104964F
	for <stable@vger.kernel.org>; Sun, 26 Jan 2025 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737916477; cv=none; b=pb/1Hz1w0AwFiurnRSUl3ISHEuthEj5HsNMJbqfJLfdlgKsVEzxDorP7VtzLAmHV2quFD2ZEgQ5KjmVrqQJpJsdwRWRJ7nfjvBkI2Q+Kh/CIE7yCmRiW62g598cqsfBb4ntwKE0V9rnGhnJ5tnJVSAkBkeGqtadM2peQrPr/dIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737916477; c=relaxed/simple;
	bh=fcTYjkoQ6Dihp3e4sq41ND1/ThKQL+4mId8sEpTkexg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCmzZOlOgvdWa8d1kq+YYOHTbG7cs5nMnCLDdNZL+oCTrPAr16qAFutE6erBSqxoPtSmsyLeY0zXsUq0RuausZS06K/s4ahmnLiYd2Mlw+PnX3PTOQJA9IHpw/F6gUBihDgBJ6Lk/iZza7F06gKyKHH0y87YKvQv6tDXE2GVDpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbAf8DXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC4FC4CED3;
	Sun, 26 Jan 2025 18:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737916476;
	bh=fcTYjkoQ6Dihp3e4sq41ND1/ThKQL+4mId8sEpTkexg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hbAf8DXI5hPXfU73Ork675tdgCmW8b3nicPrPkuN2KqC75tV4p7hsEFnIBJxOlqQs
	 5/cVVcTIaags1hq1RDNs5EX8A/gWTt4h/bQXxZU4qYRGlWHLgGeIYUkVkSsEZpcsna
	 ufsJZZm0TYv6HfqIupfUQG+OMtyMOY23BpJyMhB3UUuoT+9NXsJld6GSPWVxbDZEGk
	 C4s5fFH4cxfcl8LfUu71et26ryu4tp7ARbeje4m4ONiE2jOZLf1UqBIUf8rJuiRRkz
	 GZ5FsJN2Xn6ku76bs7J1V6ecscLHdD/krZs97Mi1T6RCpScdPjNRTguEcvkJU8i586
	 RtUqvElVmJnhg==
Received: by pali.im (Postfix)
	id BB0B746D; Sun, 26 Jan 2025 19:34:24 +0100 (CET)
Date: Sun, 26 Jan 2025 19:34:24 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
	Paulo Alcantara <pc@manguebit.com>
Subject: Re: Backport smb client fix for special files
Message-ID: <20250126183424.oumzbwflyunn75uv@pali>
References: <20250126150558.qybkjdcx3qbhmgcb@pali>
 <2025012647-implode-levitator-502a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025012647-implode-levitator-502a@gregkh>
User-Agent: NeoMutt/20180716

On Sunday 26 January 2025 17:17:25 Greg KH wrote:
> On Sun, Jan 26, 2025 at 04:05:58PM +0100, Pali Rohár wrote:
> > Hello,
> > 
> > I would like to propose backporting this commit to stable releases:
> > https://git.kernel.org/torvalds/c/3681c74d342db75b0d641ba60de27bf73e16e66b
> > smb: client: handle lack of EA support in smb2_query_path_info()
> 
> Doesn't that need to go into a release first?

Ou, it really is not released yet. I was just rebasing my branch on top
of the Linus's master branch and somehow I thought that changes which
"git rebase" dropped from my branch were already released.

So sure, first the change needs to be released and then it could be
proposed for backporting.

> > It is fixing support for querying special files (fifo/socket/block/char)
> > over SMB2+ servers which do not support extended attributes and reparse
> > point at the same time on one inode, which applied for older Windows
> > servers (pre-Win10).
> > 
> > I think that commit should have line:
> > Fixes: ea41367b2a60 ("smb: client: introduce SMB2_OP_QUERY_WSL_EA")
> > 
> > Note that the mention commit depends on:
> > ca4b2c460743 ("fs/smb/client: avoid querying SMB2_OP_QUERY_WSL_EA for SMB3 POSIX")
> 
> So what exactly should the series of commits be that we backport and to
> what kernel tree(s)?

I would propose to backport these two commits (in this order):
ca4b2c460743 ("fs/smb/client: avoid querying SMB2_OP_QUERY_WSL_EA for SMB3 POSIX")
3681c74d342d ("smb: client: handle lack of EA support in smb2_query_path_info()")

into all stable branches which already contain this commit:
ea41367b2a60 ("smb: client: introduce SMB2_OP_QUERY_WSL_EA")

Hopefully it is clear now.

> thanks,
> 
> greg k-h

