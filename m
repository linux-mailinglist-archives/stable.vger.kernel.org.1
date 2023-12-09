Return-Path: <stable+bounces-5112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BCD80B406
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E40FB20A6F
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 11:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A6E13FFD;
	Sat,  9 Dec 2023 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v25XDNS3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AC012B6C
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 11:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD4BC433C7;
	Sat,  9 Dec 2023 11:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702122122;
	bh=CFfoXxwmKEOrqcE5cKBtFLqsco6aPEU/2TJ0Ib6iijo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v25XDNS3SZ9t5zjGC+NHfZTR5rUnp74LNAxBqAfxJe8X4Nh96m9VT5mT1vIVNBGSP
	 s5XzF9WM0rbW1RXEHdmNDHBBuPcbrVHi6VdnRF2zVCMAjQ62TW7uI0AaHjsormb3HJ
	 rWTzrb0/wwaZ0sZY4GKXWXKsVEFNTBecmPbAE/gc=
Date: Sat, 9 Dec 2023 12:41:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Carlos Llamas <cmllamas@google.com>, stable@vger.kernel.org,
	syzbot+7f10c1653e35933c0f1e@syzkaller.appspotmail.com,
	Alice Ryhl <aliceryhl@google.com>, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH 6.1] binder: fix memory leaks of spam and pending work
Message-ID: <2023120940-quotation-reenter-bf58@gregkh>
References: <20231208034923.998315-1-cmllamas@google.com>
 <ZXQSnm8Ye5IYzniU@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXQSnm8Ye5IYzniU@sashalap>

On Sat, Dec 09, 2023 at 02:09:18AM -0500, Sasha Levin wrote:
> On Fri, Dec 08, 2023 at 03:49:23AM +0000, Carlos Llamas wrote:
> > commit 1aa3aaf8953c84bad398adf6c3cabc9d6685bf7d upstream
> > 
> > A transaction complete work is allocated and queued for each
> > transaction. Under certain conditions the work->type might be marked as
> > BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT to notify userspace about
> > potential spamming threads or as BINDER_WORK_TRANSACTION_PENDING when
> > the target is currently frozen.
> > 
> > However, these work types are not being handled in binder_release_work()
> > so they will leak during a cleanup. This was reported by syzkaller with
> > the following kmemleak dump:
> > 
> > BUG: memory leak
> > unreferenced object 0xffff88810e2d6de0 (size 32):
> >  comm "syz-executor338", pid 5046, jiffies 4294968230 (age 13.590s)
> >  hex dump (first 32 bytes):
> >    e0 6d 2d 0e 81 88 ff ff e0 6d 2d 0e 81 88 ff ff  .m-......m-.....
> >    04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >  backtrace:
> >    [<ffffffff81573b75>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1114
> >    [<ffffffff83d41873>] kmalloc include/linux/slab.h:599 [inline]
> >    [<ffffffff83d41873>] kzalloc include/linux/slab.h:720 [inline]
> >    [<ffffffff83d41873>] binder_transaction+0x573/0x4050 drivers/android/binder.c:3152
> >    [<ffffffff83d45a05>] binder_thread_write+0x6b5/0x1860 drivers/android/binder.c:4010
> >    [<ffffffff83d486dc>] binder_ioctl_write_read drivers/android/binder.c:5066 [inline]
> >    [<ffffffff83d486dc>] binder_ioctl+0x1b2c/0x3cf0 drivers/android/binder.c:5352
> >    [<ffffffff816b25f2>] vfs_ioctl fs/ioctl.c:51 [inline]
> >    [<ffffffff816b25f2>] __do_sys_ioctl fs/ioctl.c:871 [inline]
> >    [<ffffffff816b25f2>] __se_sys_ioctl fs/ioctl.c:857 [inline]
> >    [<ffffffff816b25f2>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:857
> >    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
> >    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 
> > Fix the leaks by kfreeing these work types in binder_release_work() and
> > handle them as a BINDER_WORK_TRANSACTION_COMPLETE cleanup.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: a7dc1e6f99df ("binder: tell userspace to dump current backtrace when detected oneway spamming")
> > Reported-by: syzbot+7f10c1653e35933c0f1e@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=7f10c1653e35933c0f1e
> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Acked-by: Todd Kjos <tkjos@google.com>
> > Link: https://lore.kernel.org/r/20230922175138.230331-1-cmllamas@google.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > [cmllamas: backport to v6.1 by dropping BINDER_WORK_TRANSACTION_PENDING
> > as commit 0567461a7a6e is not present. Remove fixes tag accordingly.]
> 
> Queued up, thanks!

Did you not push this out?  I don't see this in the queue at the moment.

thanks,

greg k-h

