Return-Path: <stable+bounces-43748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBEC8C48F3
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 23:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A48284650
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 21:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12681728;
	Mon, 13 May 2024 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZnMeDNo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F50175A6
	for <stable@vger.kernel.org>; Mon, 13 May 2024 21:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715636457; cv=none; b=VrqD2+x+tl/Q1Te/xBLeDpscQkAJxBc9VdC62WCEFEkxYtrPn500DJwvz3REXj0OOwF5H6wTwl9JI1D0PhBEJrjAftmT1gYIj0IeMRg8JoSQeATHl2vEmb0qWAEcjZL30IeBrJYu+Sl0mGsDbjc+LhAuLmiJtss9Yra9/bObBe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715636457; c=relaxed/simple;
	bh=PH8xe7AhP4iKP1pQrMxEwbydA9ktRGbpY5h5G19l21g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7iKC+aOuXbHH+PkVPtkQ5U1WxCOYlrrGYS1tZIaBI5/zu4/+p6Ku2JedgzoxHyGVpz/JghgkrfTEONb11T1ioh74OpO+UaEzfLYYp/jV2BL1T0B54vxc75svDCmtb6aBTWW0nZ+7ELcqDSLZaM1xF5u52F/1yt4sQjU6h+ygwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZnMeDNo; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3693991a12.1
        for <stable@vger.kernel.org>; Mon, 13 May 2024 14:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715636456; x=1716241256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FasF68URS/K0JAKTGhfXJzAY0ILkzP+0NWYxqIjpOk=;
        b=eZnMeDNonU2HzW0jkHy+zY3tjee+pTVXLGI1an5pyoPQeGYtcnBvHFREUlPWp6K4Q6
         J51SV6qZP/oK25dJlEEKQn5FiVqGV61LI0kRuu7lVG5kWRK56dLRu5ZeUnrORxBqNAhp
         fbE3D8ILoCLWOSfjTU0dDzYeql0ED8Gvfm8GotY7GWKF9YueZ5yljpn1o6eYojvOq5KJ
         GSxx+LgOgqfKt05KkYjgyTr7m+Rigpf2Zn6tESln7uIj1uyD6tMi19SX38P5immJNbLT
         EG04Kir/8Ng90XY7S0xW7uoZfHQ+jPwMOKXxYcx/aal4w5Kf7ca2w3q+h10S6h6KVvsi
         2Ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715636456; x=1716241256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FasF68URS/K0JAKTGhfXJzAY0ILkzP+0NWYxqIjpOk=;
        b=ZmBAFrTfe7Nyc2cC8hr+Dad/liikrRKkys36E6qZRBDvmrixa5neAFFSFIDt1Yd8NX
         s5bNE/bhGxHsHruO2/sldhvXBScOT6kg+F4CP6w1oLngbQwNP9yuZfs9d8JtcgY890Bt
         A8RG4WVMv6X9t2T5la1uAVPt5MU7BGwzhcM5+mbnurhXDa2ogo7l8knPxLuih8WjDeXB
         ceO2IwC0OjVoVMULvFx1I/MAMpxoLBm1NSbqD7geq8hx6bV5prnpADTFoj1Syq/dtJIf
         pOkK2xQzuLg+OvFxh5YMX2axUBNvkjwknGqXnmPuyh75p/0muxjYM5OiUqGz7xa7XUdQ
         G2pg==
X-Gm-Message-State: AOJu0Yz/PllEXi55LlpNWJsjnLtdMOn9+xpb8KyvyFV1zew8jHo271mO
	ZPYUaZO1rPdy4+XLk9l01FefdMe99XbEFaxjpUijgTP6fXKRM3D8THeyKZAELwajcatKvjtFzhs
	/3xGi3qQTbiz16MY8cIbIRVv7JVUVfTr7ffw=
X-Google-Smtp-Source: AGHT+IHXXNlK9noYaUK4YyxlcQn/E0mOWgGPdkX0P8YP2V3hfh07+98/6ElQhMRayWSfB5OQIHrUeTqhTAiYpAErE4A=
X-Received: by 2002:a17:90a:f98e:b0:2b4:33cd:173c with SMTP id
 98e67ed59e1d1-2b6ccd8612emr9922638a91.42.1715636455794; Mon, 13 May 2024
 14:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513192024.568296-1-bongiojp@gmail.com> <2024051346-numerous-recognize-8a0a@gregkh>
In-Reply-To: <2024051346-numerous-recognize-8a0a@gregkh>
From: Jeremy Bongio <bongiojp@gmail.com>
Date: Mon, 13 May 2024 14:40:44 -0700
Message-ID: <CANfQU3wVVtaLhSYvg2ZWjmpsJTP1ijBed283RKGidPop938qhg@mail.gmail.com>
Subject: Re: [PATCH] md: fix kmemleak of rdev->serial
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Li Nan <linan122@huawei.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resubmitted with
1. upstream sha1 line
2. explanation for why the backport differs from mainline
3. signoff

On Mon, May 13, 2024 at 1:53=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, May 13, 2024 at 12:20:24PM -0700, Jeremy Bongio wrote:
> > From: Li Nan <linan122@huawei.com>
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
> > Fixes: 963c555e75b0 ("md: introduce mddev_create/destroy_wb_pool for th=
e change of member device")
> > Signed-off-by: Li Nan <linan122@huawei.com>
> > Signed-off-by: Song Liu <song@kernel.org>
> > Link: https://lore.kernel.org/r/20240208085556.2412922-1-linan666@huawe=
icloud.com
> > Change-Id: Icc4960dcaffedc663797e2d8b18a24c23e201932
> > ---
> >  drivers/md/md.c | 1 +
> >  1 file changed, 1 insertion(+)
>
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.
>
> </formletter>

