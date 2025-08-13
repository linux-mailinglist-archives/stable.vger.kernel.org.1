Return-Path: <stable+bounces-169468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A205EB25703
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 00:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 113677BB461
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 22:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F852FB98C;
	Wed, 13 Aug 2025 22:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+qz99a0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86872FB97E;
	Wed, 13 Aug 2025 22:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125665; cv=none; b=jI9R8NpijR2DABm+BDMM1woRSw+sOYc5RFA5D2qLjpXTf+CK0zEspB53O6tiaC+Hfxe7flRglND0WP7OsQF+TXigl8aETdq32Jv86hpBLUuoPH4mZ8kB08740gcXg3FhBYocs7Vc5soNmhnkC5zyFjG3Ob/UCoVunT45lKjL5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125665; c=relaxed/simple;
	bh=ksOA1ZYQc5I/LWOdn33ATOxKibvefPW87yJVaQMG18Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cln9qddbVFY14fzhCtfmdgovyeYkX8kUVTnoRDUoKq4D+oacrnwj8yPFJnTR183qlcviJjokoXsz1NLcoMmhs2GeN+Z0kDycxTQi5P6bpYPiAn4iXszDFCZMjWv3xvZZ1V8JPfpnSf04E1Z9RZsKeCY6o+mvG/Z2Z6qEZ+2BKDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+qz99a0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2ebe86ecso492076b3a.3;
        Wed, 13 Aug 2025 15:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755125662; x=1755730462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rDHn+oYNmStnVa6tSsk6HXiPZMflUf1Vr6xx73S8mY=;
        b=U+qz99a0xBrxw0mPwRr791Aypj3MGyFi2qrptWIZla0ESHjBFxs5rt1ADQdQlDSgIU
         a0sCscR06U5zPIkX06pkTtOBGIIEx0TZOeDp5Y8zHQcXL7fxd3qNRjf+GB4uTGIpQR3f
         mTos5bssYNjpBTkvzY1TKyuJ5nfxSta9iCNnQBHKyQt3PONk6WmMNu2R/LZScDA/bqrx
         WnFGKNFqfmdLnXwKUqUDF5WR44UVGv4ndeZrVmKYuggQ82cOkyRXtYATlUyBr8Qw210A
         5SIelQfCjfudl5W1pl4Xt9m/giaAhHQEW2JRgux/4MFGwLn/OcOne8CUd6QNqtVsIpD7
         Y+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755125662; x=1755730462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rDHn+oYNmStnVa6tSsk6HXiPZMflUf1Vr6xx73S8mY=;
        b=JtZipyILwMtILQSyIcG4eXq8EflFrKV0IOVccaHrybAg/yOTdKFVe2Ritnv5sZ/KEM
         D5i6L5cq/nVjVB51bk5Skz3mE+nSQ0bJd5XnZ4CDmvZWPT5T08ueEM/isNzauQlnUKeC
         9r2lyuHQp8kBJ/J2xR3y6/zwrFD655WhOgP1UaMHsCUFPm42NAz8ruIsgPQAI08OLGth
         x0x7YOtE0KRcgiwzU5w8NJ2rI875kPoRLvT0a+yolv9n0++NM21bIljst7DDzpZ1vJdO
         6Nlf59LhnmGZPTwuxKMQdx3qz9HPYanfFz2YGlHok4hFsDLU4aiKtYF+fvgjPPlI9+hc
         kltQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAbu32WEL5mKaqk+e/0D1ufQzz3T4te+xSXaJpHzwPnK18zAXdskv5BHmOkvEoG1IBWT2K5Sw+39g6@vger.kernel.org, AJvYcCVGtZjJ9eqP1wJiqLPn4CvnoLdQFSA1/d7E0Mm+bsi8HBkuLoGNNPeJm19UXRaIxjTay8tO0Az/Ey8nGfE=@vger.kernel.org, AJvYcCXx/FHNUdM0dYa8hdpu2r1aQMCzjpNH85pveEk6hmqA8iQxj+TKFfec9ip2Hz+NaESE4cg52tVX@vger.kernel.org
X-Gm-Message-State: AOJu0YxoWAPV49ypa6FCj/0gcYr/BCUFar3TNA7WuA7bFps19He4bne4
	CgCnqvE7u/hu8tZelzg7dnKyAbElvCqz7bjGgTr+WDt1ffVznPWS+YdV
X-Gm-Gg: ASbGncsf+R8YY1I0zgmTcZDr4Gq++52lrNQqUoUILGznANL91bcYxJKkHyEZ/d+0nFf
	LZ3mVEDU1a8I5+DBAYHS88L2s2JS5SHr318ff/9FZ3IqGTV8iYyHC9h83lmwKEK50BaUMy5/Go2
	eum3Qn8fajjjQ2/mVfEq2lMXxvJhJAdqmjLPrmmLQ67zEtc12FYDDTYRM+0+8bTo4V9NFoK/o2n
	R28H2GUO5Mqw2M7Pw6ZIPppN95svlRe1i3RdsZxLzE1Nz9hnRyRFJOBzeJnloYW/aPyvTR5O8f6
	J84dG9swVxgUFQ+/tgxYz/wInuSE888TKMKrz6Q1xT461NiZsb9+Fh+axZZ1F5EdmeGMGZZP0S+
	pu1OEq0tiMJ33dtMaM5M7kPMClSSIP4whyu3kkyk8036EZD3KW56k
X-Google-Smtp-Source: AGHT+IHKB2x0pH0kr/ASedsmJegn+M6BnJoflQRmkhfRzXI2Iy3lSRrG++Zakpxd73EM4143YVAfbQ==
X-Received: by 2002:a05:6a00:124f:b0:76b:42e5:fa84 with SMTP id d2e1a72fcca58-76e2fa5b419mr1534613b3a.7.1755125661758;
        Wed, 13 Aug 2025 15:54:21 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-76bccfd1d8csm32813848b3a.101.2025.08.13.15.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:54:21 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: stern@rowland.harvard.edu
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	stable@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	usbwifi2024@gmail.com,
	zenmchen@gmail.com
Subject: Re: [PATCH] USB: storage: Ignore driver CD mode for Realtek multi-mode Wi-Fi dongles
Date: Thu, 14 Aug 2025 06:54:15 +0800
Message-ID: <20250813225417.4792-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <03d4c721-f96d-4ace-b01e-c7adef150209@rowland.harvard.edu>
References: <03d4c721-f96d-4ace-b01e-c7adef150209@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Alan Stern <stern@rowland.harvard.edu> 於 2025年8月14日 週四 上午2:19寫道：
>
> On Thu, Aug 14, 2025 at 01:53:12AM +0800, Zenm Chen wrote:
> > Alan Stern <stern@rowland.harvard.edu> 於 2025年8月14日 週四 上午12:58寫道：
> > >
> > > On Thu, Aug 14, 2025 at 12:24:15AM +0800, Zenm Chen wrote:
> > > > Many Realtek USB Wi-Fi dongles released in recent years have two modes:
> > > > one is driver CD mode which has Windows driver onboard, another one is
> > > > Wi-Fi mode. Add the US_FL_IGNORE_DEVICE quirk for these multi-mode devices.
> > > > Otherwise, usb_modeswitch may fail to switch them to Wi-Fi mode.
> > >
> > > There are several other entries like this already in the unusual_devs.h
> > > file.  But I wonder if we really still need them.  Shouldn't the
> > > usb_modeswitch program be smart enough by now to know how to handle
> > > these things?
> >
> > Hi Alan,
> >
> > Thanks for your review and reply.
> >
> > Without this patch applied, usb_modeswitch cannot switch my Mercury MW310UH
> > into Wi-Fi mode [1].
>
> Don't post a link to a video; it's not very helpful.  Instead, copy the
> output from the usb_modeswitch program and include it in an email
> message.

Sorry about that.

>
> > I also ran into a similar problem like [2] with D-Link
> > AX9U, so I believe this patch is needed.
>
> Maybe it is and maybe not.  It depends on where the underlying problem
> is.  If the problem is in the device then yes, the patch probably is
> needed.  But if the problem is in usb_modeswitch then the patch probably
> is not needed.
>
> > > In theory, someone might want to access the Windows driver on the
> > > emulated CD.  With this quirk, they wouldn't be able to.
> > >
> >
> > Actually an emulated CD doesn't appear when I insert these 2 Wi-Fi dongles into
> > my Linux PC, so users cannot access that Windows driver even if this patch is not
> > applied.
>
> What does happen when you insert the WiFi dongle?  That is, what
> messages appear in the dmesg log?

OS: Arch Linux
Kernel version: 6.15.9-arch1-1

These are the messages shown in the kernel log when the dongles were inserted.

Mercury MW310UH: 
[ 4405.000985] usb 3-2: new high-speed USB device number 31 using ehci-pci
[ 4405.126736] usb 3-2: New USB device found, idVendor=0bda, idProduct=a192, bcdDevice= 2.00
[ 4405.126750] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[ 4405.126756] usb 3-2: Product: DISK
[ 4405.126760] usb 3-2: Manufacturer: Realtek
[ 4405.127200] usb-storage 3-2:1.0: USB Mass Storage device detected
[ 4405.127632] scsi host8: usb-storage 3-2:1.0
[ 4406.155867] scsi 8:0:0:0: CD-ROM            Realtek  USB Disk autorun 1.00 PQ: 0 ANSI: 0 CCS
[ 4406.164982] sr 8:0:0:0: [sr0] scsi-1 drive
[ 4406.169602] sr 8:0:0:0: [sr0] Hmm, seems the drive doesn't support multisession CD's
[ 4406.282981] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4406.530027] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4406.776991] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4407.023992] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4407.263927] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4407.510987] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4407.757988] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4408.004967] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4408.244989] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4408.491971] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4408.738973] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4408.985967] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4409.225847] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4409.473012] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4409.719978] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4409.966958] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4410.206962] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4410.453952] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4410.700965] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4410.947959] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4411.187950] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4411.434956] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4411.681959] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4411.928970] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4412.054904] sr 8:0:0:0: Attached scsi CD-ROM sr0
[ 4412.055122] sr 8:0:0:0: Attached scsi generic sg3 type 5
[ 4412.168955] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4412.416956] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4412.663960] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4412.910947] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4413.150951] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4413.397994] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4413.645959] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4413.892990] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4414.133942] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4414.380798] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4414.621191] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4414.867934] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4415.117949] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4415.364797] usb 3-2: reset high-speed USB device number 31 using ehci-pci

... Countless "usb 3-2: reset high-speed USB device number 31 using ehci-pci" appearred here.

[ 4854.437661] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4854.684646] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4856.951643] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4857.198641] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4857.445642] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4857.692644] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4859.959629] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4860.207512] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4860.454675] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4860.701628] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4862.968616] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4863.215613] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4863.462670] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4863.709608] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4865.975479] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4866.224610] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4866.471590] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4866.718605] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4868.983453] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4869.230624] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4869.477582] usb 3-2: reset high-speed USB device number 31 using ehci-pci
[ 4869.724579] usb 3-2: reset high-speed USB device number 31 using ehci-pci



D-Link AX9U:
[ 6400.069566] usb 3-2: new high-speed USB device number 38 using ehci-pci
[ 6400.195236] usb 3-2: New USB device found, idVendor=0bda, idProduct=1a2b, bcdDevice= 0.00
[ 6400.195250] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[ 6400.195256] usb 3-2: Product: DISK
[ 6400.195261] usb 3-2: Manufacturer: Realtek
[ 6400.197475] usb-storage 3-2:1.0: USB Mass Storage device detected
[ 6400.197768] scsi host8: usb-storage 3-2:1.0
[ 6401.481648] scsi 8:0:0:0: CD-ROM            RTK      Driver Storage   2.04 PQ: 0 ANSI: 0 CCS
[ 6401.483955] sr 8:0:0:0: [sr0] scsi3-mmc drive: 0x/0x caddy
[ 6401.487626] sr 8:0:0:0: Attached scsi CD-ROM sr0
[ 6401.487828] sr 8:0:0:0: Attached scsi generic sg3 type 5
[ 6432.007456] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6462.723317] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6493.447105] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6524.163962] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6554.882745] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6565.190684] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6595.846508] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6626.562333] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6657.283170] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6688.002984] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6718.721814] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6749.445506] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6759.549662] INFO: task (udev-worker):2838 blocked for more than 122 seconds.
[ 6759.549677]       Not tainted 6.15.9-arch1-1 #1
[ 6759.549682] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 6759.549685] task:(udev-worker)   state:D stack:0     pid:2838  tgid:2838  ppid:329    task_flags:0x400140 flags:0x00004002
[ 6759.549697] Call Trace:
[ 6759.549701]  <TASK>
[ 6759.549709]  __schedule+0x409/0x1330
[ 6759.549727]  schedule+0x27/0xd0
[ 6759.549735]  schedule_preempt_disabled+0x15/0x30
[ 6759.549743]  __mutex_lock.constprop.0+0x481/0x880
[ 6759.549754]  ? __pfx_blkdev_open+0x10/0x10
[ 6759.549763]  bdev_open+0x2a0/0x3d0
[ 6759.549771]  ? __pfx_blkdev_open+0x10/0x10
[ 6759.549777]  blkdev_open+0xa5/0x100
[ 6759.549785]  do_dentry_open+0x170/0x5d0
[ 6759.549794]  vfs_open+0x30/0x100
[ 6759.549804]  path_openat+0x717/0x1300
[ 6759.549813]  ? path_openat+0x98c/0x1300
[ 6759.549821]  do_filp_open+0xd8/0x180
[ 6759.549834]  do_sys_openat2+0x88/0xe0
[ 6759.549841]  __x64_sys_openat+0x61/0xa0
[ 6759.549847]  do_syscall_64+0x7b/0x810
[ 6759.549856]  ? do_syscall_64+0x87/0x810
[ 6759.549863]  ? do_syscall_64+0x87/0x810
[ 6759.549869]  ? set_pte_range+0xe2/0x200
[ 6759.549879]  ? set_ptes.isra.0+0x36/0x80
[ 6759.549886]  ? finish_fault+0x22f/0x460
[ 6759.549895]  ? do_fault+0x3a7/0x5b0
[ 6759.549903]  ? ___pte_offset_map+0x1b/0x180
[ 6759.549912]  ? __handle_mm_fault+0x7de/0xfd0
[ 6759.549918]  ? do_epoll_ctl+0xa80/0xdd0
[ 6759.549926]  ? __count_memcg_events+0xb0/0x150
[ 6759.549934]  ? count_memcg_events.constprop.0+0x1a/0x30
[ 6759.549941]  ? handle_mm_fault+0x1d2/0x2d0
[ 6759.549948]  ? do_user_addr_fault+0x181/0x690
[ 6759.549957]  ? irqentry_exit_to_user_mode+0x2c/0x1b0
[ 6759.549966]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 6759.549974] RIP: 0033:0x7fc19fe931ce
[ 6759.549995] RSP: 002b:00007ffe87a741b0 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
[ 6759.550003] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc19fe931ce
[ 6759.550008] RDX: 0000000000080900 RSI: 00007ffe87a74270 RDI: ffffffffffffff9c
[ 6759.550012] RBP: 00007ffe87a741c0 R08: 0000000000000000 R09: 0000000000000000
[ 6759.550017] R10: 0000000000000000 R11: 0000000000000202 R12: 000055eaf18c4470
[ 6759.550021] R13: 00007ffe87a74500 R14: 0000000000080900 R15: 0000000000000015
[ 6759.550030]  </TASK>
[ 6759.550054] INFO: task (udev-worker):2838 is blocked on a mutex likely owned by task udisksd:706.
[ 6759.550059] task:udisksd         state:D stack:0     pid:706   tgid:706   ppid:1      task_flags:0x400100 flags:0x00004002
[ 6759.550068] Call Trace:
[ 6759.550071]  <TASK>
[ 6759.550075]  __schedule+0x409/0x1330
[ 6759.550084]  ? lock_timer_base+0x70/0x90
[ 6759.550094]  schedule+0x27/0xd0
[ 6759.550101]  schedule_timeout+0x83/0x100
[ 6759.550109]  ? __pfx_process_timeout+0x10/0x10
[ 6759.550117]  io_schedule_timeout+0x5b/0x90
[ 6759.550124]  wait_for_completion_io_timeout+0x7f/0x1a0
[ 6759.550134]  blk_execute_rq+0xee/0x170
[ 6759.550145]  scsi_execute_cmd+0x100/0x420
[ 6759.550157]  scsi_test_unit_ready+0x6f/0xf0
[ 6759.550172]  sr_drive_status+0x57/0x120 [sr_mod de25504f195c3fb7b76d163270dae636af6d4152]
[ 6759.550187]  cdrom_open+0xd4/0xab0 [cdrom ff26b01442b014534657abb98fa7fb688822fb56]
[ 6759.550208]  ? __disk_unblock_events+0x26/0xc0
[ 6759.550219]  ? disk_check_media_change+0x96/0xe0
[ 6759.550229]  sr_block_open+0x71/0x110 [sr_mod de25504f195c3fb7b76d163270dae636af6d4152]
[ 6759.550239]  ? __pfx_blkdev_open+0x10/0x10
[ 6759.550246]  blkdev_get_whole+0x2c/0xe0
[ 6759.550253]  ? __pfx_blkdev_open+0x10/0x10
[ 6759.550259]  bdev_open+0x201/0x3d0
[ 6759.550266]  ? __pfx_blkdev_open+0x10/0x10
[ 6759.550272]  blkdev_open+0xa5/0x100
[ 6759.550279]  do_dentry_open+0x170/0x5d0
[ 6759.550287]  vfs_open+0x30/0x100
[ 6759.550296]  path_openat+0x717/0x1300
[ 6759.550304]  ? __memcg_slab_free_hook+0xf7/0x140
[ 6759.550312]  do_filp_open+0xd8/0x180
[ 6759.550325]  do_sys_openat2+0x88/0xe0
[ 6759.550386]  __x64_sys_openat+0x61/0xa0
[ 6759.550397]  do_syscall_64+0x7b/0x810
[ 6759.550406]  ? vfs_read+0x2af/0x390
[ 6759.550419]  ? ksys_read+0xa8/0xe0
[ 6759.550429]  ? syscall_exit_to_user_mode+0x37/0x1c0
[ 6759.550439]  ? do_syscall_64+0x87/0x810
[ 6759.550448]  ? irqentry_exit_to_user_mode+0x2c/0x1b0
[ 6759.550458]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 6759.550466] RIP: 0033:0x7f3ced89f042
[ 6759.550479] RSP: 002b:00007fff0e8d04f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[ 6759.550488] RAX: ffffffffffffffda RBX: 0000562237bedca0 RCX: 00007f3ced89f042
[ 6759.550494] RDX: 0000000000000000 RSI: 0000562237bbc6e0 RDI: ffffffffffffff9c
[ 6759.550499] RBP: 00007fff0e8d0520 R08: 0000000000000000 R09: 0000000000000000
[ 6759.550504] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff0e8d0650
[ 6759.550509] R13: 00007fff0e8d0654 R14: 0000562237bf1b80 R15: 0000562237bb0fe0
[ 6759.550520]  </TASK>
[ 6780.163423] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6787.459425] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6797.765312] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6828.289146] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6859.013081] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6889.732859] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6900.036820] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6930.692665] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6961.412477] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 6992.132215] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 7022.852189] usb 3-2: reset high-speed USB device number 38 using ehci-pci
[ 7030.145050] usb 3-2: reset high-speed USB device number 38 using ehci-pci


When trying to mount these two Wi-Fi dongles' driver CD, I got this error.
$ sudo mount /dev/sr0 /mnt/tmp
mount: /mnt/tmp: fsconfig() failed: /dev/sr0: Can't open blockdev.
       dmesg(1) may have more information after failed mount system call.


usb_modeswitch can switch D-Link AX9U into Wi-Fi mode successfully, but it took a 
very long time (about 40 seconds).

$ lsusb
Bus 001 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 002: ID 0bda:5852 Realtek Semiconductor Corp. Bluetooth Radio
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 002: ID 2717:4106 Xiaomi Inc. MediaTek MT7601U [MI WiFi]
Bus 003 Device 035: ID 0bda:1a2b Realtek Semiconductor Corp. RTL8188GU 802.11n WLAN Adapter (Driver CDROM Mode)
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 002: ID 046d:c077 Logitech, Inc. Mouse
Bus 004 Device 003: ID 05af:1023 Jing-Mold Enterprise Co., Ltd Ghost Key Elimiantion Keyboard
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 007 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 008 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub

$ sudo  usb_modeswitch -v 0bda -p 1a2b -KW
Take all parameters from the command line


 * usb_modeswitch: handle USB devices with multiple modes
 * Version 2.6.2 (C) Josua Dietze 2017
 * Based on libusb1/libusbx

 ! PLEASE REPORT NEW CONFIGURATIONS !

DefaultVendor=  0x0bda
DefaultProduct= 0x1a2b

StandardEject=1

Look for default devices ...
  found USB ID 2717:4106
  found USB ID 0bda:1a2b
   vendor ID matched
   product ID matched
  found USB ID 1d6b:0002
  found USB ID 05af:1023
  found USB ID 046d:c077
  found USB ID 1d6b:0001
  found USB ID 1d6b:0002
  found USB ID 0bda:5852
   vendor ID matched
  found USB ID 1d6b:0001
  found USB ID 1d6b:0003
  found USB ID 1d6b:0002
  found USB ID 1d6b:0003
  found USB ID 1d6b:0002
 Found devices in default mode (1)
Access device 035 on bus 003
Get the current device configuration ...
Current configuration number is 1
Use interface number 0
 with class 8
Use endpoints 0x05 (out) and 0x84 (in)

USB description data (for identification)
-------------------------
Manufacturer: Realtek
     Product: DISK
  Serial No.: not provided
-------------------------
Sending standard EJECT sequence
Looking for active drivers ...
 OK, driver detached
Set up interface 0
Use endpoint 0x05 for message sending ...
Trying to send message 1 to endpoint 0x05 ...
 Sending the message returned error -7. Try to continue
Read the response to message 1 (CSW) ...
 Response successfully read (13 bytes), status 1
Trying to send message 2 to endpoint 0x05 ...
 OK, message successfully sent
Read the response to message 2 (CSW) ...
 Response successfully read (13 bytes), status 0
Trying to send message 3 to endpoint 0x05 ...
libusb: error [submit_bulk_transfer] submiturb failed, errno=113
 Sending the message returned error -1. Try to continue
Read the response to message 3 (CSW) ...
 Device seems to have vanished after reading. Good.
 Device is gone, skip any further commands
-> Run lsusb to note any changes. Bye!

$ lsusb
Bus 001 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 002: ID 0bda:5852 Realtek Semiconductor Corp. Bluetooth Radio
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 002: ID 2717:4106 Xiaomi Inc. MediaTek MT7601U [MI WiFi]
Bus 003 Device 036: ID 2001:332a D-Link Corp. 802.11ax WLAN Adapter
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 002: ID 046d:c077 Logitech, Inc. Mouse
Bus 004 Device 003: ID 05af:1023 Jing-Mold Enterprise Co., Ltd Ghost Key Elimiantion Keyboard
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 007 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 008 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub


On the other side, Mercury MW310UH cannot be switched successfully.

$ sudo  usb_modeswitch -v 0bda -p a192 -KW
Take all parameters from the command line


 * usb_modeswitch: handle USB devices with multiple modes
 * Version 2.6.2 (C) Josua Dietze 2017
 * Based on libusb1/libusbx

 ! PLEASE REPORT NEW CONFIGURATIONS !

DefaultVendor=  0x0bda
DefaultProduct= 0xa192

StandardEject=1

Look for default devices ...
  found USB ID 2717:4106
  found USB ID 0bda:a192
   vendor ID matched
   product ID matched
  found USB ID 1d6b:0002
  found USB ID 05af:1023
  found USB ID 046d:c077
  found USB ID 1d6b:0001
  found USB ID 1d6b:0002
  found USB ID 0bda:5852
   vendor ID matched
  found USB ID 1d6b:0001
  found USB ID 1d6b:0003
  found USB ID 1d6b:0002
  found USB ID 1d6b:0003
  found USB ID 1d6b:0002
 Found devices in default mode (1)
Access device 033 on bus 003
Get the current device configuration ...
Current configuration number is 1
Use interface number 0
 with class 8
Use endpoints 0x0b (out) and 0x8a (in)

USB description data (for identification)
-------------------------
Manufacturer: Realtek
     Product: DISK
  Serial No.: not provided
-------------------------
Sending standard EJECT sequence
Looking for active drivers ...
 OK, driver detached
Set up interface 0
Use endpoint 0x0b for message sending ...
Trying to send message 1 to endpoint 0x0b ...
 OK, message successfully sent
Read the response to message 1 (CSW) ...
 Response reading failed (error -8)
 Device is gone, skip any further commands
-> Run lsusb to note any changes. Bye!

$ lsusb
Bus 001 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 002: ID 0bda:5852 Realtek Semiconductor Corp. Bluetooth Radio
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 002: ID 2717:4106 Xiaomi Inc. MediaTek MT7601U [MI WiFi]
Bus 003 Device 033: ID 0bda:a192 Realtek Semiconductor Corp. DISK
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 002: ID 046d:c077 Logitech, Inc. Mouse
Bus 004 Device 003: ID 05af:1023 Jing-Mold Enterprise Co., Ltd Ghost Key Elimiantion Keyboard
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 007 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 008 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub

>
> Also, can you collect a usbmon trace showing what happens when the
> dongle is plugged in?

I am not familiar with this, but I will try these days, thank you!

>
> Alan Stern

