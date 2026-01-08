Return-Path: <stable+bounces-206378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8047D043C9
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF87633F87BB
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4062D3A86;
	Thu,  8 Jan 2026 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IGNwqNk0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7AB2C21F0
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887754; cv=none; b=lmAJWIxQmSMmq6YcCzFW1hIJ2tbPoWHQGyw/DGbQH/x+fDIC+krrmpUDF7bUlBaDk3NizM/V1bavor/nHxA/lCnfPndcJa1PgG+jxeMJ0n4W+C+azWTYL4eGbvpwNkQuwUfbHImJpsZSWYr97R6XYsEdpxgWOWSTVnAgXaOPxbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887754; c=relaxed/simple;
	bh=SD1JwZ9K/+i+ZNB0tLMhRfhQrjG8a9p/8HpMNFnk/1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seaSOka3tdmZPDnfh+zX9ZiZQZKnbYXDIfUNl0fk1lk0uZQX5m4npFz1XoVgfmciOpjhkDkMLDkN0DTsyF9S3RNaQjAthYy29s9tQ3kGggmKecr4Wq8o5b/Y7/wz+H+UrypGQLTFmGrLZHgdblN9lpUwtMdJqu69N2f58RL2goo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IGNwqNk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE05BC116C6;
	Thu,  8 Jan 2026 15:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767887753;
	bh=SD1JwZ9K/+i+ZNB0tLMhRfhQrjG8a9p/8HpMNFnk/1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGNwqNk03ZDQhBWC8QQc/5GnoqM9u/0J8woUQDBGfD/zR3vLEVgPvvXg2Lh1Xw6OG
	 CAszaF6w0aG8HLpNQYqyQhQqiSR3c2N1dnPIf5uv93PenM38r2bW+VTkJaueYIOT/J
	 4crbDNXdSma4m9Q/hs4QMf6uN5jMlBRWbJuw7tmw=
Date: Thu, 8 Jan 2026 16:55:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: David =?iso-8859-1?Q?Nystr=F6m?= <david.nystrom@est.tech>
Cc: stable@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Ye Bin <yebin10@huawei.com>, Sasha Levin <sashal@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 5.10.y v2 0/2] Backport 2 commits to fix a KASAN ext4
 splat
Message-ID: <2026010810-delusion-dividers-74f4@gregkh>
References: <20251217-ext4_splat-v2-0-3c84bb2c1cd0@est.tech>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251217-ext4_splat-v2-0-3c84bb2c1cd0@est.tech>

On Wed, Dec 17, 2025 at 10:55:56AM +0100, David Nyström wrote:
> Backport commit:5701875f9609 ("ext4: fix out-of-bound read in
> ext4_xattr_inode_dec_ref_all()" to linux 5.10 branch.
> The fix depends on commit:69f3a3039b0d ("ext4: introduce ITAIL helper")
> In order to make a clean backport on stable kernel, backport 2 commits.
> 
> It has a single merge conflict where static inline int, which changed 
> to static int.
> 
> Signed-off-by: David Nyström <david.nystrom@est.tech>
> ---
> Changes in v2:
> - Resend identical patchset with correct "Upstream commit" denotation.
> - Link to v1: https://patch.msgid.link/20251216-ext4_splat-v1-0-b76fd8748f44@est.tech
> 
> ---
> Ye Bin (2):
>       ext4: introduce ITAIL helper
>       ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()
> 
>  fs/ext4/inode.c |  5 +++++
>  fs/ext4/xattr.c | 32 ++++----------------------------
>  fs/ext4/xattr.h | 10 ++++++++++
>  3 files changed, 19 insertions(+), 28 deletions(-)
> ---
> base-commit: f964b940099f9982d723d4c77988d4b0dda9c165
> change-id: 20251215-ext4_splat-f59c1acd9e88
> 
> Best regards,
> --  
> David Nyström <david.nystrom@est.tech>
> 
> 

We can't take patches only for an older kernel tree, and not newer ones.
Otherwise you will have a regression when upgrading.

Please resend patches for all applicable kernel trees and we will be
glad to queue them all up.

thanks

greg k-h

