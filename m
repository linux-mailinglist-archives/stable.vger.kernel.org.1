Return-Path: <stable+bounces-110789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6332EA1CC9A
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B0B37A21EC
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427F22EAF7;
	Sun, 26 Jan 2025 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NnikSmzN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D732233062
	for <stable@vger.kernel.org>; Sun, 26 Jan 2025 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737908304; cv=none; b=o/tcRohO76aZiH+9HC38vcXyUTeRStPQoJrI8a1GGDtaNyQNoiIP0IreT2xxuMeP1xbYF0yaJxDoJJ1sXeYnvmq3o+Ppp5LTTfwvbX4ypAafhXmtvQEdHrv9Gnfl6mpj2i7qs1swWJCrWYDGmpPY/HK/MDjhtHU5HfsTQ0AeqTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737908304; c=relaxed/simple;
	bh=YElPr/Vw5/6LP+wt1sS04ue7EYQ2Gi5mPhtlj9eSk2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJ1TjvZ9jKopBCbW5BP5EkWRfQFPGQLARVCjOo+B3z3Sux54u25+qz7z1rpmWy0Ihjn+FmGLSBs11VTN7it36seqY+Qbxk3lg7FxNFI8O0rk6XQUP2aUfCKw39724qGzGnS4AzdGJlbiEhl/5KnPWsjCpz0RGrVaEnyDNaxtTlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NnikSmzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A3BC4CED3;
	Sun, 26 Jan 2025 16:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737908303;
	bh=YElPr/Vw5/6LP+wt1sS04ue7EYQ2Gi5mPhtlj9eSk2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NnikSmzNnMZuC18hk8gizJppkEDZ884yYnwR6WgA5RVjwb4UH7+Y+SQ3yfplt8u8G
	 EjLbfSKmOZO6kYXkrDLNYRv0aWHiU6kLG0mplEBMGlssP3GeeyP7dltl4xMYoDQaOE
	 CM70FJz5XFQPTew85wn8Jtllyvhsfw4LF25DuaPA=
Date: Sun, 26 Jan 2025 17:17:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
	Paulo Alcantara <pc@manguebit.com>
Subject: Re: Backport smb client fix for special files
Message-ID: <2025012647-implode-levitator-502a@gregkh>
References: <20250126150558.qybkjdcx3qbhmgcb@pali>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250126150558.qybkjdcx3qbhmgcb@pali>

On Sun, Jan 26, 2025 at 04:05:58PM +0100, Pali Rohár wrote:
> Hello,
> 
> I would like to propose backporting this commit to stable releases:
> https://git.kernel.org/torvalds/c/3681c74d342db75b0d641ba60de27bf73e16e66b
> smb: client: handle lack of EA support in smb2_query_path_info()

Doesn't that need to go into a release first?

> It is fixing support for querying special files (fifo/socket/block/char)
> over SMB2+ servers which do not support extended attributes and reparse
> point at the same time on one inode, which applied for older Windows
> servers (pre-Win10).
> 
> I think that commit should have line:
> Fixes: ea41367b2a60 ("smb: client: introduce SMB2_OP_QUERY_WSL_EA")
> 
> Note that the mention commit depends on:
> ca4b2c460743 ("fs/smb/client: avoid querying SMB2_OP_QUERY_WSL_EA for SMB3 POSIX")

So what exactly should the series of commits be that we backport and to
what kernel tree(s)?

thanks,

greg k-h

