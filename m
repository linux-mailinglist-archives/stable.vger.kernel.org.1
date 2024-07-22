Return-Path: <stable+bounces-60711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D726593929A
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 18:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7845B1F220BA
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E9B16EB65;
	Mon, 22 Jul 2024 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CsSfz2wH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B8216EB63
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721666042; cv=none; b=MkdD26ef9Ar0C0X2Y1bTZIP1rLEycRYUYbdwfI0EvkvkSqmJ3gZq3Pp/TuvcyLOyFTIfpt/ralb8+Ur7lclXPlGYiLMihXw2b05hvQKmyjdCpny/Uax1ygDaSODjLurQoLfxSL42bfgRXSBLG4Q0PG9bm/5J3PmG9Ql1/THYcBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721666042; c=relaxed/simple;
	bh=2zErkkCXOo6QAcVxi+vE5cUp0C6FLuFy/WOwkoAGVqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEZBTZZRyEnc5/Wx0hgQed8yxBvPpFtd/Gv+Em9j6QGRJDYhBNMRZAh95fTCRqynNg8LOxzhaFxEuFQWmU8hOyTrTED/YuxNne5Q08TO4BmTv/fyTIqcbWzNeoekQIjr2/YKVD3UVCp3GzzGEyG6rTndVWUZ65mLm1Sva8xo55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CsSfz2wH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE73C32782;
	Mon, 22 Jul 2024 16:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721666041;
	bh=2zErkkCXOo6QAcVxi+vE5cUp0C6FLuFy/WOwkoAGVqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CsSfz2wHfzj9HBw+29N9L8WjgOSO+mfpdaB29XFFVp4wlA6UgDWAx3renpuOO87Fu
	 c4w5NGoOjPOdA+PZnQ+Vuyu+8zSFofsZlmNOe7bxy9S+iW/VZkPBvZnRP3zNJp4nyR
	 FN8UVdomjwl9q9OTTY7FF584r75E+Igt3u0F3jeI=
Date: Mon, 22 Jul 2024 18:33:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jann Horn <jannh@google.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH stable 4.19-6.6] filelock: Remove locks reliably when
 fcntl/close race is detected
Message-ID: <2024072249-frostily-palatable-8482@gregkh>
References: <20240722142250.155873-1-jannh@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722142250.155873-1-jannh@google.com>

On Mon, Jul 22, 2024 at 04:22:50PM +0200, Jann Horn wrote:
> commit 3cad1bc010416c6dd780643476bc59ed742436b9 upstream.
> 
> When fcntl_setlk() races with close(), it removes the created lock with
> do_lock_file_wait().
> However, LSMs can allow the first do_lock_file_wait() that created the lock
> while denying the second do_lock_file_wait() that tries to remove the lock.
> In theory (but AFAIK not in practice), posix_lock_file() could also fail to
> remove a lock due to GFP_KERNEL allocation failure (when splitting a range
> in the middle).
> 
> After the bug has been triggered, use-after-free reads will occur in
> lock_get_status() when userspace reads /proc/locks. This can likely be used
> to read arbitrary kernel memory, but can't corrupt kernel memory.
> This only affects systems with SELinux / Smack / AppArmor / BPF-LSM in
> enforcing mode and only works from some security contexts.
> 
> Fix it by calling locks_remove_posix() instead, which is designed to
> reliably get rid of POSIX locks associated with the given file and
> files_struct and is also used by filp_flush().
> 
> Fixes: c293621bbf67 ("[PATCH] stale POSIX lock handling")
> Cc: stable@kernel.org
> Link: https://bugs.chromium.org/p/project-zero/issues/detail?id=2563
> Signed-off-by: Jann Horn <jannh@google.com>
> Link: https://lore.kernel.org/r/20240702-fs-lock-recover-2-v1-1-edd456f63789@google.com
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> [stable fixup: ->c.flc_type was ->fl_type in older kernels]
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  fs/locks.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Now queued up, thanks.

greg k-h

