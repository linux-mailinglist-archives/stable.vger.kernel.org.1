Return-Path: <stable+bounces-60770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3487D93A0A2
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 14:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D72282EE3
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 12:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDC315216A;
	Tue, 23 Jul 2024 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ShxKaBj6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC521514F3
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739371; cv=none; b=aMwy8NDYc/8zeywhJzgoTEIkpnicD3eTNLNPqMpPwZqxNQkQXkUdo1uedfVTGWgq103EgzGUZV6HeCHF6Jy/4M7hNT7pQC+dKEI9W11icwf8JQm3STlVRLYpHpfE4pT3S7qHuF9SprKIhWNLTujHX8v2Dd9iXwZTy2FM1246c8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739371; c=relaxed/simple;
	bh=E/ln2qQJFoGF3RYq3M+uws5d8TX4q1e7GR8UDuDuVSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tfo9wMEdgm0jNk65btuIwHBjZ9ulranCMMYXsOtTdDF24M8lKhyyHg0jIHubfa3djviAUX13zFafKEVEHNwxQC8dBpWjdiZhhhdic+s+ECYoc/Fqa/m77NPVTOcazhuobsgqQVtuCJb0MPZgPK4S49OqTJROcSUK0R1zJ83NiPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ShxKaBj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40133C4AF0A;
	Tue, 23 Jul 2024 12:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721739370;
	bh=E/ln2qQJFoGF3RYq3M+uws5d8TX4q1e7GR8UDuDuVSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShxKaBj6Kdnml/spnUw4+WpjkaSonz89pri/U1rXG/sUBlqn773q254cjDki88E5+
	 cXLW0Udw7uF+Y50hDVv3HxTgXl++nXHjhvbY0jLrSqYfCObXlc5ZOAZ0B6BlsPgYr7
	 tZzG/EbbaNrhyYqeSff5AIZ28fqIH5n746Kv/PMA=
Date: Tue, 23 Jul 2024 14:56:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jann Horn <jannh@google.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH stable 4.19-6.6] filelock: Remove locks reliably when
 fcntl/close race is detected
Message-ID: <2024072315-oppressor-traps-56a1@gregkh>
References: <20240722142250.155873-1-jannh@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index fb717dae9029..31659a2d9862 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2381,8 +2381,9 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
>  	error = do_lock_file_wait(filp, cmd, file_lock);
>  
>  	/*
> -	 * Attempt to detect a close/fcntl race and recover by releasing the
> -	 * lock that was just acquired. There is no need to do that when we're
> +	 * Detect close/fcntl races and recover by zapping all POSIX locks
> +	 * associated with this file and our files_struct, just like on
> +	 * filp_flush(). There is no need to do that when we're
>  	 * unlocking though, or for OFD locks.
>  	 */
>  	if (!error && file_lock->fl_type != F_UNLCK &&
> @@ -2397,9 +2398,7 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
>  		f = files_lookup_fd_locked(files, fd);
>  		spin_unlock(&files->file_lock);
>  		if (f != filp) {
> -			file_lock->fl_type = F_UNLCK;
> -			error = do_lock_file_wait(filp, cmd, file_lock);
> -			WARN_ON_ONCE(error);
> +			locks_remove_posix(filp, files);

Wait, this breaks the build on 5.4.y with the error:

fs/locks.c: In function ‘fcntl_setlk’:
fs/locks.c:2545:50: error: ‘files’ undeclared (first use in this function); did you mean ‘file’?
 2545 |                         locks_remove_posix(filp, files);
      |                                                  ^~~~~
      |                                                  file

I didn't do test-builds yesterday, my fault for not noticing this yet.

I've dropped this from the 5.4.y queues for now, can you fix this up and send
an updated version, or give me a hint as to what to do instead?  Odd that this
works on 4.19.y, let me see why...

thanks,

greg k-h

