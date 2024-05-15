Return-Path: <stable+bounces-45192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BFE8C6A9C
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 18:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A14D284914
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 16:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5313FA2A;
	Wed, 15 May 2024 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rr2G/0EI"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CAD5660
	for <stable@vger.kernel.org>; Wed, 15 May 2024 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790682; cv=none; b=MfU09obXiVyT5ylhP6Axomj98O5Or5vkSjy980FEKJJ4p775jcJa3GR5QFSNlmJ03gWYvNOqGfd+4AunpcvcU4bNyLS4z2LqObzm5BpV6lM4Wgzg8g1iWnx9oYVjE2PC9l+ZZubs08WfVStMIiz+lBxI86ei9GiZj9lCLuR40D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790682; c=relaxed/simple;
	bh=sfyua9Yc8tvS222gvzK1VRgYKMt/fhJswzDlGjgG8IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEA/Rg4zRN/D2fs2h+siAxSpGvd3YjK228vg7uxKVeG/xlQBwjKbqOEgykMlRNuBmdwz9xmUfRZXq1ZiYUigjHb0rfG6Df9S/eFPT+Myw9NHpnhHhcyuBkJZLKk35O16qjWFQfdf5ysk7sT6+pFlfNN3de7A3HzfFnxnYWosri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rr2G/0EI; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-622f5a0badcso36666997b3.2
        for <stable@vger.kernel.org>; Wed, 15 May 2024 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715790679; x=1716395479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNcxnX5krXb8EzzF+UclW+WZmcx5qsJQodXo8b9hweE=;
        b=Rr2G/0EImjcHGoLLZBvYA5bK/pZ8C4PTz+9BKimWUPCV3PpXnT5Tar8fehZ9GLSLe/
         IxWlvYCjRD/pD9wv0icPweatretsKAeXzrWIqXi8QQ0FvTS5vIiMYyJ4nZuiDZmiFmqs
         Dsbx/ZoUALbEiuCCsJROVVoe71M86UWlkFwVNrajTc5qb38jBryo97T/MJGnAoeXZ2vu
         VxxFpdDFJIlGEzo7eYlA6TthKYuKyj59jHEvUdE/WCowpBguQ71GcsX61DqcLiUnK9bG
         HqFCg9GuDNECyF3qrCSZ8jSqOOxRL8pdq/CwGDpxImyMi9v9WZESnj7Tgx1iEEdUxo6g
         mcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715790679; x=1716395479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNcxnX5krXb8EzzF+UclW+WZmcx5qsJQodXo8b9hweE=;
        b=uQq//JkRe4qWiqySzq6jBqjjzvh30gHEpQDArjkQCfVuNc6bP/NDVsgENJLga+J4gX
         fM0OJ+9SJ/T+g7mFPTDul+4hvEvT4pZi6/Hzmn6YmqvqODZXg3lFdx+XStRrCN+feQ6m
         x0ztBL+8PXkTq3WJ8LNvDIgHXJbSU5HiXKbHdH3DTdBCKEEC9TkkPPmxC/sCL3DjsCS4
         m20Xzt8SVWMaTUD+E53Pu1wwzbyIbX8onLD3xrvHswSwWev9LnNg8S1Lix+bSCok6YJ7
         El5kpnABjbEv5gak9hFnkNGh9zFY8eNQzJTGIBiAqO+lecdFH30FIe3t+fuo+FfkZynZ
         tTPg==
X-Gm-Message-State: AOJu0YzWdmkrZGoGi7G/mxUPrMu04x/FdU7G2iDPpbHpq+bkmGObDCJM
	iHKQxPyo33KyRHqEs6UZm7hR/+uv4gMi/0f98T+q9s5SHEPXdROvIDVzovaXLoC+RmQ0qa3oBrZ
	5OEXJitDN0ThlPlJB8ksM5JHSHCcgzqEQeqTY
X-Google-Smtp-Source: AGHT+IGD2WHtXpkipld10Auaut6BPHXAp73I/mhO7Vg5XFd2/8MwOCCIImnkEZZCR9BzvIwC6M1p0oDg+myM4hepAEg=
X-Received: by 2002:a05:690c:6a0c:b0:609:fec8:779c with SMTP id
 00721157ae682-622b0193d89mr166637877b3.52.1715790679458; Wed, 15 May 2024
 09:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513233058.885052-1-jbongio@google.com> <2024051523-precision-rosy-eac3@gregkh>
In-Reply-To: <2024051523-precision-rosy-eac3@gregkh>
From: Jeremy Bongio <jbongio@google.com>
Date: Wed, 15 May 2024 09:31:07 -0700
Message-ID: <CAOvQCn5LEhFw8njxO7oa9Q_Ku3b7UEEmJUAqPw9aTO3Gu90kRg@mail.gmail.com>
Subject: Re: [PATCH] md: fix kmemleak of rdev->serial
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Li Nan <linan122@huawei.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

5.4 doesn't have "mddev_destroy_serial_pool" ... More work would be
needed to figure out if the vulnerability exists and how to fix it.

The patch also applies to 5.15, but I haven't tested it.

On Wed, May 15, 2024 at 12:33=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
>
> On Mon, May 13, 2024 at 11:30:58PM +0000, Jeremy Bongio wrote:
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
> > Signed-off-by: Jeremy Bongio <jbongio@google.com>
> > ---
> >
> > This backport is tested on LTS 5.10, 6.1, 6.6
>
> So this is not needed in 5.15.y or 5.4.y?  Why not?
>
> thanks,
>
> greg k-h

