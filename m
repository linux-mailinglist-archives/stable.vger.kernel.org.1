Return-Path: <stable+bounces-62764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B26941015
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CC21C22A44
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 10:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BAB53E3A;
	Tue, 30 Jul 2024 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HLepo4l/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E991DA32
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337114; cv=none; b=ZgBsGIQhTeyGY9mTsyJMWQJ6Hn2+Rge8LGb/BB1I9XeRsewlxQWZg197EjferjjbQ3BRZD/4h41KtyJewEd+19GSc8j2I/cjh4kRop0XEsriM1w0IMKWY16xf1PyfB/lCiVRQO4+hGSjgNle7VYr42lUQqqfLUP7pqlkAQK5z9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337114; c=relaxed/simple;
	bh=Mdc1oF9k09u+TN72/KFl1wSlwcD4NTCa7FvUbvNw9H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayZy6Goojnc45yPN/yCBgweUJaii0MfyIeUeOCKd3WJlUsFM4Np6AkpKSBwl6pNnhH3vbGtjWWxCnDJciu1eUM4JT+YLLtD1hgCaAKCgz1MZuAjvpoyhlpm/fYnXGo9FEmzSh0lKHNh5GnmCJrpfi8HmXt5tJoV+5jUv+1f77vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HLepo4l/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75717C32782;
	Tue, 30 Jul 2024 10:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722337113;
	bh=Mdc1oF9k09u+TN72/KFl1wSlwcD4NTCa7FvUbvNw9H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLepo4l/cYvb6bwkWoF16jXt2LmyvZsrbb66OYagAE++tVnmldjN2hHQYrvqZ9QsX
	 7+S4iG9dk0TGQQXDSZgVOVl4emYs4jF9VdIKblDTohGV+cXMMN55mJMkshMWlzlzCI
	 5eDWYrAjs4stNn8/OTNdmETMVPZTSsz230BMAQPg=
Date: Tue, 30 Jul 2024 12:58:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: dongsheng.yang@easystack.cn, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] rbd: don't assume RBD_LOCK_STATE_LOCKED
 for exclusive" failed to apply to 6.10-stable tree
Message-ID: <2024073007-hatred-garland-cfa9@gregkh>
References: <2024073021-strut-specimen-8aad@gregkh>
 <CAOi1vP_hPytqPrhgwL7Oig6wKLs0Z2qz3S5BV=VtepATGvvN5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOi1vP_hPytqPrhgwL7Oig6wKLs0Z2qz3S5BV=VtepATGvvN5Q@mail.gmail.com>

On Tue, Jul 30, 2024 at 12:54:52PM +0200, Ilya Dryomov wrote:
> On Tue, Jul 30, 2024 at 12:25 PM <gregkh@linuxfoundation.org> wrote:
> >
> >
> > The patch below does not apply to the 6.10-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following commands:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 2237ceb71f89837ac47c5dce2aaa2c2b3a337a3c
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073021-strut-specimen-8aad@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..
> >
> > Possible dependencies:
> >
> > 2237ceb71f89 ("rbd: don't assume RBD_LOCK_STATE_LOCKED for exclusive mappings")
> >
> > thanks,
> >
> > greg k-h
> >
> > ------------------ original commit in Linus's tree ------------------
> >
> > From 2237ceb71f89837ac47c5dce2aaa2c2b3a337a3c Mon Sep 17 00:00:00 2001
> > From: Ilya Dryomov <idryomov@gmail.com>
> > Date: Tue, 23 Jul 2024 18:07:59 +0200
> > Subject: [PATCH] rbd: don't assume RBD_LOCK_STATE_LOCKED for exclusive
> >  mappings
> >
> > Every time a watch is reestablished after getting lost, we need to
> > update the cookie which involves quiescing exclusive lock.  For this,
> > we transition from RBD_LOCK_STATE_LOCKED to RBD_LOCK_STATE_QUIESCING
> > roughly for the duration of rbd_reacquire_lock() call.  If the mapping
> > is exclusive and I/O happens to arrive in this time window, it's failed
> > with EROFS (later translated to EIO) based on the wrong assumption in
> > rbd_img_exclusive_lock() -- "lock got released?" check there stopped
> > making sense with commit a2b1da09793d ("rbd: lock should be quiesced on
> > reacquire").
> >
> > To make it worse, any such I/O is added to the acquiring list before
> > EROFS is returned and this sets up for violating rbd_lock_del_request()
> > precondition that the request is either on the running list or not on
> > any list at all -- see commit ded080c86b3f ("rbd: don't move requests
> > to the running list on errors").  rbd_lock_del_request() ends up
> > processing these requests as if they were on the running list which
> > screws up quiescing_wait completion counter and ultimately leads to
> >
> >     rbd_assert(!completion_done(&rbd_dev->quiescing_wait));
> >
> > being triggered on the next watch error.
> >
> > Cc: stable@vger.kernel.org # 06ef84c4e9c4: rbd: rename RBD_LOCK_STATE_RELEASING and releasing_wait
> 
> Hi Greg,
> 
> Please grab commit f5c466a0fdb2 ("rbd: rename RBD_LOCK_STATE_RELEASING
> and releasing_wait") as a prerequisite for this one.  I forgot to adjust
> the SHA in the tag that specifies it after a rebase, sorry.
> 
> This applies to all stable kernels.

Now done, thanks.  I was wondering about that invalid sha1, odd that the
linux-next scripts didn't catch it :(

greg k-h

