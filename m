Return-Path: <stable+bounces-43753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D574D8C4A1B
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 01:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F211283735
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 23:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2293085631;
	Mon, 13 May 2024 23:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFb1UJeN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D727126F0D
	for <stable@vger.kernel.org>; Mon, 13 May 2024 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715643088; cv=none; b=sTyJ90qXSxiferXLRgF7nDK7byVOhiHRYQ8NqS/3JlWM5Jci9gCiDhxVfDQAOFyELEqSPE5IdbS1ZVXfutUXcCnxM/mYkDvv7ickHNBkQjkp2cC8RSJtTAD8j9G/NVV3L7P1ko0h/U8xU4U3hE7AbjYT+4PtfPd2+B1WoeCHd8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715643088; c=relaxed/simple;
	bh=H11ttCVacv6qiNX2r4NCWDjquqYwxUmncj/8eV/9gMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDTe5rRbpe/irj4BzFo1QF0CrGKZSTHmXvvhQKWFd03WYU2ciAGYDoweed9N8iK6WHoho4lAxKFnUGLOm2nlSBAEsAXqlaN9zNzoHHvo8g8F+YMxhNbjfrj4v4b/j7VGAR0fBQE1CeqOo+9zvrZOQIU0X1sIAOUFZaUQfx2KicM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFb1UJeN; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5e4f79007ffso3372701a12.2
        for <stable@vger.kernel.org>; Mon, 13 May 2024 16:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715643087; x=1716247887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qp3lCwGkNRkj5wDehhEzmZkkoR+drUeimm/AtLoNfBE=;
        b=XFb1UJeNQT0eOjdXAAxS3WUUYoiQ6HyFoNVZ+rX6e0PYqq4RWmRsHXIocNyFI5/8FG
         c6Nr88/PRJAt1Da1sUUdjSr0L5ZO+sh7uhDdsrYmHhj4viXlLwISi2ojoHDOSOiN+z1q
         fUYmOqj2gkJ0RVVXr0nLugdMg+GNxIJU5K7MCPGcIqfGkNk01LlxvWvqQ5J+QPQfJQPz
         izYeWh4Cc+DxvRLMYxA0rBc/kbswr0g0DBTzqfnWBZfB3VQ66CSnm6VVoIylEZr9d0V1
         XfNp7Ez6XBXNqIwRDhQvLJNtzKKBkw05wNWrlqMCcuAnI1eWi2JgZE1kN0UVWFph/cWm
         U6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715643087; x=1716247887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qp3lCwGkNRkj5wDehhEzmZkkoR+drUeimm/AtLoNfBE=;
        b=ssjIVI+lMw9T/qrQZvcYS4x0TR8D6vWf6Ed2MRPQyaLKQEZdq20nwYilJM8IEDi2UT
         050co/50/fQCSMjOhSIL6V6e3Q5EIs2MFWbyYX+OiDz5iPCCPzo7hsfFGlvWVjFMrkw3
         8pwzhsQkz20gl7bXpeEle/gqVE91Ps/bLB3/1Aps8X7/Sulkojgf772IqtYiiKLAEBbm
         C5ndcU0SC0H6fZSy5PVymxSlKgXCIj5ur92V0dtgJD/5tdKg8Pf3AxKYTFS2iDVGoo+/
         KYW8h5QX4DC2dum7eu/8L+Qzpa/qeqFu0b/DUvCKgW0E/xCkBJNPQ7nUst7Ol50H7mxK
         8dhQ==
X-Gm-Message-State: AOJu0YyfI0Cpv9TRNEqjgAeoPovMkUoZzrN4F9eBf5NmnHxrULuwVfsa
	k6W2/3f7M8pCniQVQlmwfmstrBbt4BGcKQVsc8NFWjpWAMfrOKdrj1p3RPID14soJ2RhYSISyuX
	fkmyE8pVq0pwbPqQs2NMeWBXE1C4=
X-Google-Smtp-Source: AGHT+IE3BH7/jugJi8nIxeM6Z291wP6oLQLhsKX3yECPQOEmawtXp5ZxwehVWFi4rU4w1OWjadbM05k5DPfjfcUtrVg=
X-Received: by 2002:a17:90a:4285:b0:2b9:461d:5777 with SMTP id
 98e67ed59e1d1-2b9461d57e7mr2602729a91.11.1715643086742; Mon, 13 May 2024
 16:31:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513213938.626201-1-bongiojp@gmail.com> <2024051453-blah-pushpin-3d0b@gregkh>
In-Reply-To: <2024051453-blah-pushpin-3d0b@gregkh>
From: Jeremy Bongio <bongiojp@gmail.com>
Date: Mon, 13 May 2024 16:31:15 -0700
Message-ID: <CANfQU3ye83rUvBnLP+=YLcpcfdcnKfLFAbPcQEgpxeyRFbbLBQ@mail.gmail.com>
Subject: Re: [PATCH] md: fix kmemleak of rdev->serial
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Li Nan <linan122@huawei.com>, Song Liu <song@kernel.org>, 
	Jeremy Bongio <jbongio@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Change-id is an artifact from gerrit. I didn't realize I left it in.

I was using my personal email for sending patches.
I will send and sign with the same email if that's less confusing.


On Mon, May 13, 2024 at 3:24=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, May 13, 2024 at 02:39:38PM -0700, Jeremy Bongio wrote:
> > From: Li Nan <linan122@huawei.com>
> >
> > commit 6cf350658736681b9d6b0b6e58c5c76b235bb4c4 upstream.
> >
> > If kobject_add() is fail in bind_rdev_to_array(), 'rdev->serial' will b=
e
> > alloc not be freed, and kmemleak occurs.
> >
> > unreferenced object 0xffff88815a350000 (size 49152):
> >   comm "mdadm", pid 789, jiffies 4294716910
> >   hex dump (first 32 bytes):
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace (crc f773277a):
> >     [<0000000058b0a453>] kmemleak_alloc+0x61/0xe0
> >     [<00000000366adf14>] __kmalloc_large_node+0x15e/0x270
> >     [<000000002e82961b>] __kmalloc_node.cold+0x11/0x7f
> >     [<00000000f206d60a>] kvmalloc_node+0x74/0x150
> >     [<0000000034bf3363>] rdev_init_serial+0x67/0x170
> >     [<0000000010e08fe9>] mddev_create_serial_pool+0x62/0x220
> >     [<00000000c3837bf0>] bind_rdev_to_array+0x2af/0x630
> >     [<0000000073c28560>] md_add_new_disk+0x400/0x9f0
> >     [<00000000770e30ff>] md_ioctl+0x15bf/0x1c10
> >     [<000000006cfab718>] blkdev_ioctl+0x191/0x3f0
> >     [<0000000085086a11>] vfs_ioctl+0x22/0x60
> >     [<0000000018b656fe>] __x64_sys_ioctl+0xba/0xe0
> >     [<00000000e54e675e>] do_syscall_64+0x71/0x150
> >     [<000000008b0ad622>] entry_SYSCALL_64_after_hwframe+0x6c/0x74
> >
> > backport change:
> > mddev_destroy_serial_pool third parameter was removed in mainline,
> > where there is no need to suspend within this function anymore.
> >
> > Fixes: 963c555e75b0 ("md: introduce mddev_create/destroy_wb_pool for th=
e change of member device")
> > Signed-off-by: Li Nan <linan122@huawei.com>
> > Signed-off-by: Song Liu <song@kernel.org>
> > Link: https://lore.kernel.org/r/20240208085556.2412922-1-linan666@huawe=
icloud.com
> > Change-Id: Icc4960dcaffedc663797e2d8b18a24c23e201932
>
> Why the change-id?
>
> And what kernel tree(s) is this backport for?
>
> > Signed-off-by: Jeremy Bongio <jbongio@google.com>
>
> This doesn't match the From: line of your email :(
>
> thanks,
>
> greg k-h

