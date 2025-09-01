Return-Path: <stable+bounces-176906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDA4B3EF15
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 22:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39EB2C1FBE
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 20:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36F017A2EB;
	Mon,  1 Sep 2025 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VUbTMXYq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E768248C
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756845; cv=none; b=LML6Gu9ZqP68h+jL6NFfWn5duGJWnw3+nD5GTOPOlrsSaQOPpWKA5NfHGFCliLCzYArOwM8+4aMRSMdLFCmr0YyV63vawwOuS8im4P1pdHj0waoyRvLZ+WfaQXWijNtuNRRPKLqIB5pRwcwD5PKh2b6zHqztxwD8GgN2MNqcITY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756845; c=relaxed/simple;
	bh=jTgLGBYnp83yQZTNoCJCr1j3OzKhYuamorr35DI7XFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fxol3+THvNb2ksH9KUN2HyNXG36WgDUAmT6B0qr5RjzusrbGfoi6ye5XwYXDmAJGsiv67FoTdGpD5l2NZ6G5urXn3ivWPAa88i0zatgraZ3Y+aHK0AS+5ZhKNCa1UK8xgtmSLiyDy2hycH8fCjiRS0FrdRS4K9TZMizMsqxhC/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VUbTMXYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD5DC4CEF0;
	Mon,  1 Sep 2025 20:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756756844;
	bh=jTgLGBYnp83yQZTNoCJCr1j3OzKhYuamorr35DI7XFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUbTMXYq86qaWeGD3zUZcpnFkpgzZ35awzMlybWzMAwaXTRotwXLbRJUP/uY8utS9
	 H1+QUV0IPRKUjMvKdPL6dtSYGIiDZOyyo/2RwhOdd/uMGvXN+rG52Bc43awuv2HbPg
	 sXHiIY2ABjqB7fdDEQWlgpMBxYpxHpyVu5A4tvn8=
Date: Mon, 1 Sep 2025 22:00:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Norbert Manthey <nmanthey@amazon.de>
Cc: stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com,
	Dmitry Safonov <dima@arista.com>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?w5ZtZXIgRXJkaW7DpyBZYcSfbXVybHU=?= <oeygmrl@amazon.de>
Subject: Re: [PATCH 6.1.y 1/1] fs: relax assertions on failure to encode file
 handles
Message-ID: <2025090116-repent-living-b7de@gregkh>
References: <2025011112-racing-handbrake-a317@gregkh>
 <20250901153559.14799-1-nmanthey@amazon.de>
 <20250901153559.14799-2-nmanthey@amazon.de>
 <2025090114-bodacious-daffodil-2f2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025090114-bodacious-daffodil-2f2e@gregkh>

On Mon, Sep 01, 2025 at 09:54:03PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 01, 2025 at 03:35:59PM +0000, Norbert Manthey wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> > 
> > commit 974e3fe0ac61de85015bbe5a4990cf4127b304b2 upstream.
> > 
> > Encoding file handles is usually performed by a filesystem >encode_fh()
> > method that may fail for various reasons.
> > 
> > The legacy users of exportfs_encode_fh(), namely, nfsd and
> > name_to_handle_at(2) syscall are ready to cope with the possibility
> > of failure to encode a file handle.
> > 
> > There are a few other users of exportfs_encode_{fh,fid}() that
> > currently have a WARN_ON() assertion when ->encode_fh() fails.
> > Relax those assertions because they are wrong.
> > 
> > The second linked bug report states commit 16aac5ad1fa9 ("ovl: support
> > encoding non-decodable file handles") in v6.6 as the regressing commit,
> > but this is not accurate.
> > 
> > The aforementioned commit only increases the chances of the assertion
> > and allows triggering the assertion with the reproducer using overlayfs,
> > inotify and drop_caches.
> > 
> > Triggering this assertion was always possible with other filesystems and
> > other reasons of ->encode_fh() failures and more particularly, it was
> > also possible with the exact same reproducer using overlayfs that is
> > mounted with options index=on,nfs_export=on also on kernels < v6.6.
> > Therefore, I am not listing the aforementioned commit as a Fixes commit.
> > 
> > Backport hint: this patch will have a trivial conflict applying to
> > v6.6.y, and other trivial conflicts applying to stable kernels < v6.6.
> > 
> > Reported-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
> > Tested-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/linux-unionfs/671fd40c.050a0220.4735a.024f.GAE@google.com/
> > Reported-by: Dmitry Safonov <dima@arista.com>
> > Closes: https://lore.kernel.org/linux-fsdevel/CAGrbwDTLt6drB9eaUagnQVgdPBmhLfqqxAf3F+Juqy_o6oP8uw@mail.gmail.com/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > Link: https://lore.kernel.org/r/20241219115301.465396-1-amir73il@gmail.com
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I never signed off on the original commit, so why was this added?
> 
> > 
> > (fuzzy picked from commit f47c834a9131ae64bee3c462f4e610c67b0a000f)
> > Applied with LLM-adjusted hunks for 1 functions from us.amazon.nova
> > - Changed the function call from `exportfs_encode_fid` to `exportfs_encode_inode_fh` to match the destination code.

Wait, that was just fuzz matching, the real body didn't even change.

> > - Removed the warning message as per the patch.

I do not understand this change, what exactly was this?

> Please put this in the proper place, and in the proper format, if you
> want to add "notes" to the backport.
> 
> But really, it took a LLM to determine an abi change?  That feels like
> total overkill as you then had to actually manually check it as well.
> But hey, it's your cpu cycles to burn, not mine...

Again, total overkill, 1 minute doing a simple git merge resolution
would have done the same thing, right?

confused as to why this took a whole new tool?  We have good merge
resolution tools for git these days, what's wrong with using one of the
many ones out there?

thanks,

greg k-h

