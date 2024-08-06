Return-Path: <stable+bounces-65506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE09949933
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 22:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D398AB255DE
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 20:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121737703;
	Tue,  6 Aug 2024 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0BwozzL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3954AEEA;
	Tue,  6 Aug 2024 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976555; cv=none; b=NILcPzAlH7MTT4juKpyHqibeHD8uycM91zU/ZkyTe6nz//RHDvNfU+h7BsnejPmp7HQ3nsDotnKcDA6wvFEsdufCDUmAnR4zeEzrirMqKHK7ZK9BGLbMZZDNy0LQka7badHJxelgJbAAjx5LlSOAM+VCQTsZrB4tt6MKrXwz2+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976555; c=relaxed/simple;
	bh=mQKKY+nJ0uY3IUjy66Pt5rpL9+oW2CYI1J7x+XK/Jeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWy4tV8G6P0vDnMA9+A7Wb/sZxirepd7I5RjUAlRY2NDZ0JyoB8EaYaobaM131uwyczQwnKLw6gj0jI99bhbVKebLh410/FKARVw1eUORwCQqLs/1fHhTRt0u+uQqTlQfM1BuaUheujYiAVHhcxyFI3NxCi4eD3/saWcTMn2rsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0BwozzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9740C32786;
	Tue,  6 Aug 2024 20:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976555;
	bh=mQKKY+nJ0uY3IUjy66Pt5rpL9+oW2CYI1J7x+XK/Jeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0BwozzLVeCTO5xLh+2V+tVO09O1fALeoDn/XLIOJCzgRktz/iS1yA7bnwjdwnB/L
	 3bNedjEs09by6tGVJUZ60VNgEcGGzRTf2d6a/LQQPrXssFqsfVZshykd5KREtpvdmQ
	 bwwqv1j/QfOXHj0zPqOvjYYXX4y2diTiFjZuZDIN4M8t2JAKxBR/DeYH7ezk6e2ORE
	 iC8hRd+pK5RJ3t17k4pBiFIVSnmH14+XBnYsIrTsscdO5uuImvaV8VHyJpOSqc7pht
	 96NnXIgZOeW06vJYckV1miaiQESD9FHrFwxFv9yyGIlSDgWcb8WLatR6+ZRjPk/yOo
	 4sHe8UcrxbZnw==
Date: Tue, 6 Aug 2024 13:35:53 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: Require FMODE_WRITE for atomic write
 ioctls
Message-ID: <20240806203553.GA2447@sol.localdomain>
References: <20240806-f2fs-atomic-write-v1-1-8a586e194fd7@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806-f2fs-atomic-write-v1-1-8a586e194fd7@google.com>

On Tue, Aug 06, 2024 at 04:07:16PM +0200, Jann Horn via Linux-f2fs-devel wrote:
> The F2FS ioctls for starting and committing atomic writes check for
> inode_owner_or_capable(), but this does not give LSMs like SELinux or
> Landlock an opportunity to deny the write access - if the caller's FSUID
> matches the inode's UID, inode_owner_or_capable() immediately returns true.
> 
> There are scenarios where LSMs want to deny a process the ability to write
> particular files, even files that the FSUID of the process owns; but this
> can currently partially be bypassed using atomic write ioctls in two ways:
> 
>  - F2FS_IOC_START_ATOMIC_REPLACE + F2FS_IOC_COMMIT_ATOMIC_WRITE can
>    truncate an inode to size 0
>  - F2FS_IOC_START_ATOMIC_WRITE + F2FS_IOC_ABORT_ATOMIC_WRITE can revert
>    changes another process concurrently made to a file
> 
> Fix it by requiring FMODE_WRITE for these operations, just like for
> F2FS_IOC_MOVE_RANGE. Since any legitimate caller should only be using these
> ioctls when intending to write into the file, that seems unlikely to break
> anything.
> 
> Fixes: 88b88a667971 ("f2fs: support atomic writes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  fs/f2fs/file.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

