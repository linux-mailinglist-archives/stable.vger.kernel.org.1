Return-Path: <stable+bounces-60789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E26A293A20A
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 15:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5B9282A80
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 13:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C3B152780;
	Tue, 23 Jul 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AJ5SIkxf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F488F70
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742764; cv=none; b=MIOJ4sPd7d56s0soMAbXUCeO3NnnwFV/Lvi5d7hY5lV7ovguy5oXpAflhh4C7AgRt0hj2+E8sOSub+UBSkog81uhQgxyX7JGH7w/w2ZNvorhM0FJ1xq6MLKJc6aVS+58p4/NUH4e3CSP3EMSfjivbhyEtBH6ZXGxslNJ9AZJekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742764; c=relaxed/simple;
	bh=U0OPuNQpp7Vdpx7uvYwVWpaGqdc+O1V8tPKvSnyKra4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j28AMtRaBSyPQtGJMETWqLunY22eWwNnjCSggdEKtuhzIH4BIOhVIAuTy514dxJOs1zpbMnF/bW4FPcRe4Oi069eFiT+UJ9NmbBM3X4fkve31yjdvv1tYVsjuSlABHYAuBjNCi37PuH/6LrEya4SpVklt/LE2hxLE8BT8N5K16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AJ5SIkxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F6DC4AF0A;
	Tue, 23 Jul 2024 13:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721742764;
	bh=U0OPuNQpp7Vdpx7uvYwVWpaGqdc+O1V8tPKvSnyKra4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AJ5SIkxfF9IdKsJoUNIuz9H3vx4TdkF3fD2fQVlr5LIGSxkmf83uRDLrIcb2VfNy+
	 GFri+IjmmOMKgt5w+ux1/N+ytQsvqmW71vKRT5Zu0QwARGkIxd10PaTEZnDXPmppO1
	 FP6NerHzMkllqOLANDhscXfL927YmUeTozOvQx18=
Date: Tue, 23 Jul 2024 15:52:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jann Horn <jannh@google.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH stable 4.19-6.6] filelock: Remove locks reliably when
 fcntl/close race is detected
Message-ID: <2024072310-anointer-unusable-fd67@gregkh>
References: <20240722142250.155873-1-jannh@google.com>
 <2024072315-oppressor-traps-56a1@gregkh>
 <2024072353-deceptive-subsector-54fb@gregkh>
 <2024072328-delirious-wired-1720@gregkh>
 <CAG48ez0hRdmTjTO6+6qeEra89i_c3-2c_n84KeMV3=jdJv1thA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0hRdmTjTO6+6qeEra89i_c3-2c_n84KeMV3=jdJv1thA@mail.gmail.com>

On Tue, Jul 23, 2024 at 03:36:07PM +0200, Jann Horn wrote:
> On Tue, Jul 23, 2024 at 3:09 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jul 23, 2024 at 03:00:28PM +0200, Greg KH wrote:
> > > On Tue, Jul 23, 2024 at 02:56:08PM +0200, Greg KH wrote:
> > > > On Mon, Jul 22, 2024 at 04:22:50PM +0200, Jann Horn wrote:
> > > > > commit 3cad1bc010416c6dd780643476bc59ed742436b9 upstream.
> > > > >
> > > > > When fcntl_setlk() races with close(), it removes the created lock with
> > > > > do_lock_file_wait().
> > > > > However, LSMs can allow the first do_lock_file_wait() that created the lock
> > > > > while denying the second do_lock_file_wait() that tries to remove the lock.
> > > > > In theory (but AFAIK not in practice), posix_lock_file() could also fail to
> > > > > remove a lock due to GFP_KERNEL allocation failure (when splitting a range
> > > > > in the middle).
> > > > >
> > > > > After the bug has been triggered, use-after-free reads will occur in
> > > > > lock_get_status() when userspace reads /proc/locks. This can likely be used
> > > > > to read arbitrary kernel memory, but can't corrupt kernel memory.
> > > > > This only affects systems with SELinux / Smack / AppArmor / BPF-LSM in
> > > > > enforcing mode and only works from some security contexts.
> > > > >
> > > > > Fix it by calling locks_remove_posix() instead, which is designed to
> > > > > reliably get rid of POSIX locks associated with the given file and
> > > > > files_struct and is also used by filp_flush().
> > > > >
> > > > > Fixes: c293621bbf67 ("[PATCH] stale POSIX lock handling")
> > > > > Cc: stable@kernel.org
> > > > > Link: https://bugs.chromium.org/p/project-zero/issues/detail?id=2563
> > > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > > Link: https://lore.kernel.org/r/20240702-fs-lock-recover-2-v1-1-edd456f63789@google.com
> > > > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > [stable fixup: ->c.flc_type was ->fl_type in older kernels]
> > > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > > ---
> > > > >  fs/locks.c | 9 ++++-----
> > > > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/fs/locks.c b/fs/locks.c
> > > > > index fb717dae9029..31659a2d9862 100644
> > > > > --- a/fs/locks.c
> > > > > +++ b/fs/locks.c
> > > > > @@ -2381,8 +2381,9 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
> > > > >   error = do_lock_file_wait(filp, cmd, file_lock);
> > > > >
> > > > >   /*
> > > > > -  * Attempt to detect a close/fcntl race and recover by releasing the
> > > > > -  * lock that was just acquired. There is no need to do that when we're
> > > > > +  * Detect close/fcntl races and recover by zapping all POSIX locks
> > > > > +  * associated with this file and our files_struct, just like on
> > > > > +  * filp_flush(). There is no need to do that when we're
> > > > >    * unlocking though, or for OFD locks.
> > > > >    */
> > > > >   if (!error && file_lock->fl_type != F_UNLCK &&
> > > > > @@ -2397,9 +2398,7 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
> > > > >           f = files_lookup_fd_locked(files, fd);
> > > > >           spin_unlock(&files->file_lock);
> > > > >           if (f != filp) {
> > > > > -                 file_lock->fl_type = F_UNLCK;
> > > > > -                 error = do_lock_file_wait(filp, cmd, file_lock);
> > > > > -                 WARN_ON_ONCE(error);
> > > > > +                 locks_remove_posix(filp, files);
> > > >
> > > > Wait, this breaks the build on 5.4.y with the error:
> > > >
> > > > fs/locks.c: In function ‘fcntl_setlk’:
> > > > fs/locks.c:2545:50: error: ‘files’ undeclared (first use in this function); did you mean ‘file’?
> > > >  2545 |                         locks_remove_posix(filp, files);
> > > >       |                                                  ^~~~~
> > > >       |                                                  file
> > > >
> > > > I didn't do test-builds yesterday, my fault for not noticing this yet.
> > > >
> > > > I've dropped this from the 5.4.y queues for now, can you fix this up and send
> > > > an updated version, or give me a hint as to what to do instead?  Odd that this
> > > > works on 4.19.y, let me see why...
> > >
> > > Ah, I see why, it applied to the wrong function in 4.19 and that didn't
> > > get built on my test systems (i.e. 64bit only.)  And I see how to fix
> > > this up, let me go do that now, sorry for the noise.
> >
> > And it's fixed now on 5.4.y as well, I just reference current->files and
> > all is good.
> 
> Uuuugh, but actually as you mentioned the buggy code is duplicated
> (which was why you had that build success for 4.19). Even in mainline
> there are two versions and I missed the one for 64-bit offsets on
> 32-bit systems.
> 
> So I guess I gotta go back and send another patch to mainline for the
> second path, and then get that through stable too... bleh.

Hey, the stable review process found a bug in mainline, that's a good
thing!  :)

If you need help backporting, I'm glad to do so.

thanks,

greg k-h

