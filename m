Return-Path: <stable+bounces-111712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD1FA23152
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 16:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604597A2E44
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49B71E9B23;
	Thu, 30 Jan 2025 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abutz/Uk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A1F1E1C22;
	Thu, 30 Jan 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738252718; cv=none; b=LFRfjPz3aEnp30FIg4kkoUqGPqH+fmpL63VTrEWPUPAfSLBI0oAigWaMXMFJ2ONLVPYNeyoeC/ErzU8B/YYjkPyAOz+uZwr4BXBfOFt2d/P9+CNvbXT2p4DKfGt3V3U1h5lYOogQ04hKEj/XD0FOKScoEp8SOijy1dxxSPXM+Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738252718; c=relaxed/simple;
	bh=QoRQmh6++CdHMehWXd5zc5R/DgqgxVbl/8RQ4uaQYNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbOKoTpFehBbpbEJeBG4MydPXdhmxMz1VagBq9q2OZA5gyugSmJZ4S+tzqgP5Za3aAhHR3q1gqbTEoeDupTnHR9xrvSS3qwhboZn4eMaAJBBtzsjHJt2GBepgfOd0HKMlSH2cYWRa5bG00QTmYB0bLxG4sNlbFAf8NuiUnxW6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abutz/Uk; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so1670040a91.3;
        Thu, 30 Jan 2025 07:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738252716; x=1738857516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HGZwZ9nhCeLmj/jBSs08wJin9wLaCBKJ3rsqMQyq/+Q=;
        b=abutz/UkP5ggphnBgfOei+ogPZooQG5D9LPjmWLgqwojS83Ehc7zE9Iy229Xch+h1E
         BZ3OMYy5OL+BKLe3k17bNcKN69EodNob1On6zBiMP9DRMpYarQ9I4PNw9S/4weKSnJ0F
         douVALB6886lmWshbY0aHi/dlZ0gUwH/S+dPqlRZI+ewHTdDjW5p5wBfz2pYEDQd7npg
         9MnKVdciOF8TNS6ZoJpReZyfw8OOxUyaoqsdOb2Zvel6Z6lst4WQKqpbBt54eLpTCUw8
         5Y9wUzb489OOzx+UY9cyNnT6ePqtqQMWaLDV5NeYyGnxSYwPhnefQw/FO9MR0pTHqLCZ
         rHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738252716; x=1738857516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGZwZ9nhCeLmj/jBSs08wJin9wLaCBKJ3rsqMQyq/+Q=;
        b=UUbI3OZpz6GpJ4AOGsTcBfqHeM6klOLqJLo590usHzZ9Yl7cRAarCW8e2Tto7dpW95
         JL3xlQuwW0mX0WkwiGFSQX4d7LiXE22zDnDIcoKs8/JocJnUA5EXhDML0E4nwysHGtrl
         qq3z+Fk8WWUdomlrpFc4psiQfGBmzCGXGgqRZrMWJa1S3XxeTfm4sYMB0y7VrCS/qAhh
         iMktN09IJ0YnIsaSMdbFvwQTZ6LRhJOKzWVMKDYqTlxOW0Cyns2xjCnW9lRxpWA69EsN
         SGiNBzpP+lLAXKogmgbPuz4CgBnaTADhF6NmdhGgaSvqCzjTgja36Krc5lq1DXoFAdL+
         o99w==
X-Forwarded-Encrypted: i=1; AJvYcCXdlK9efT1eVmAuLO7BMoN7/NNqw7nt9NZ1tdsSN46WLyRiLOr9GQtwlTn06DqjBkXlG4J24aK+9mHO9so=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8FZoAIR2/3NgEHxPyMQjrUDzv5of10Hd/4F9Yr9HgmiIDRdoc
	PynGcE8wmDfq0QOdTwbfXq8TOJByj6QHi/Yl18iTYd+y/yFxmjVmbJO3SDMJKBkD4NbNFFVgyS3
	Iy7nV+p2G7k9bUjjJJRTVdEqzmj0=
X-Gm-Gg: ASbGncv4NwhBDFZWCI+HmgNKh2bs7ECYjINs3refZTRuG5y6oGKaIlrbVn+vNwkCQXm
	4oj1cA0DvYmuziGywPEJYf9e+Q988AQPhNDf62QX0H7gHPL2DXO7gW4wrjh3uVGQeBUZbJTFSKz
	7DGW3bq1MdrkE=
X-Google-Smtp-Source: AGHT+IG/HecaiqVoxH5jPAOWTeIt+9mgmj6BMHMBqq555NR5Iq6fH52PZ9mOh4IGweXpch0m3azI93uwYeyJTOEfL28=
X-Received: by 2002:a17:90b:53c4:b0:2ee:d63f:d77 with SMTP id
 98e67ed59e1d1-2f83abd7ccfmr12066158a91.9.1738252715615; Thu, 30 Jan 2025
 07:58:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130133456.914329400@linuxfoundation.org>
In-Reply-To: <20250130133456.914329400@linuxfoundation.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Thu, 30 Jan 2025 16:58:23 +0100
X-Gm-Features: AWEUYZlu5-eS8fzqAeNwcfG3zpiErf9DOFZPfYUz3QMizdmJ6bBIV_1fYaOerjw
Message-ID: <CADo9pHgCDcSp46UH9VANw8svKb9bZZuh5U4Yc8r0XG6fQ0G=4Q@mail.gmail.com>
Subject: Re: [PATCH 6.13 00/25] 6.13.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

running Arch Linux with the testing repos enabled:
https://archlinux.org/ https://archboot.com/
https://wiki.archlinux.org/title/Arch_Testing_Team

Den tors 30 jan. 2025 kl 14:59 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> This is the start of the stable review cycle for the 6.13.1 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Feb 2025 13:34:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 6.13.1-rc1
>
> Jack Greiner <jack@emoss.org>
>     Input: xpad - add support for wooting two he (arm)
>
> Matheos Mattsson <matheos.mattsson@gmail.com>
>     Input: xpad - add support for Nacon Evol-X Xbox One Controller
>
> Leonardo Brondani Schenkel <leonardo@schenkel.net>
>     Input: xpad - improve name of 8BitDo controller 2dc8:3106
>
> Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
>     Input: xpad - add QH Electronics VID/PID
>
> Nilton Perim Neto <niltonperimneto@gmail.com>
>     Input: xpad - add unofficial Xbox 360 wireless receiver clone
>
> Mark Pearson <mpearson-lenovo@squebb.ca>
>     Input: atkbd - map F23 key to support default copilot shortcut
>
> Nicolas Nobelis <nicolas@nobelis.eu>
>     Input: xpad - add support for Nacon Pro Compact
>
> Jann Horn <jannh@google.com>
>     io_uring/rsrc: require cloned buffers to share accounting contexts
>
> Jason Gerecke <jason.gerecke@wacom.com>
>     HID: wacom: Initialize brightness of LED trigger
>
> Hans de Goede <hdegoede@redhat.com>
>     wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
>
> Lianqin Hu <hulianqin@vivo.com>
>     ALSA: usb-audio: Add delay quirk for USB Audio Device
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Revert "usb: gadget: u_serial: Disable ep before setting port to null to fix the crash caused by port being null"
>
> Qasim Ijaz <qasdev00@gmail.com>
>     USB: serial: quatech2: fix null-ptr-deref in qt2_process_read_urb()
>
> Easwar Hariharan <eahariha@linux.microsoft.com>
>     scsi: storvsc: Ratelimit warning logs to prevent VM denial of service
>
> Alex Williamson <alex.williamson@redhat.com>
>     vfio/platform: check the bounds of read/write syscalls
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     cachestat: fix page cache statistics permission checking
>
> Jiri Kosina <jikos@kernel.org>
>     Revert "HID: multitouch: Add support for lenovo Y9000P Touchpad"
>
> Jamal Hadi Salim <jhs@mojatatu.com>
>     net: sched: fix ets qdisc OOB Indexing
>
> Paulo Alcantara <pc@manguebit.com>
>     smb: client: handle lack of EA support in smb2_query_path_info()
>
> Chuck Lever <chuck.lever@oracle.com>
>     libfs: Use d_children list to iterate simple_offset directories
>
> Chuck Lever <chuck.lever@oracle.com>
>     libfs: Replace simple_offset end-of-directory detection
>
> Chuck Lever <chuck.lever@oracle.com>
>     Revert "libfs: fix infinite directory reads for offset dir"
>
> Chuck Lever <chuck.lever@oracle.com>
>     Revert "libfs: Add simple_offset_empty()"
>
> Chuck Lever <chuck.lever@oracle.com>
>     libfs: Return ENOSPC when the directory offset range is exhausted
>
> Andreas Gruenbacher <agruenba@redhat.com>
>     gfs2: Truncate address space when flipping GFS2_DIF_JDATA flag
>
>
> -------------
>
> Diffstat:
>
>  Makefile                                     |   4 +-
>  drivers/hid/hid-ids.h                        |   1 -
>  drivers/hid/hid-multitouch.c                 |   8 +-
>  drivers/hid/wacom_sys.c                      |  24 ++--
>  drivers/input/joystick/xpad.c                |   9 +-
>  drivers/input/keyboard/atkbd.c               |   2 +-
>  drivers/net/wireless/realtek/rtl8xxxu/core.c |  20 ++++
>  drivers/scsi/storvsc_drv.c                   |   8 +-
>  drivers/usb/gadget/function/u_serial.c       |   8 +-
>  drivers/usb/serial/quatech2.c                |   2 +-
>  drivers/vfio/platform/vfio_platform_common.c |  10 ++
>  fs/gfs2/file.c                               |   1 +
>  fs/libfs.c                                   | 162 +++++++++++++--------------
>  fs/smb/client/smb2inode.c                    | 104 ++++++++++++-----
>  include/linux/fs.h                           |   1 -
>  io_uring/rsrc.c                              |   7 ++
>  mm/filemap.c                                 |  17 +++
>  mm/shmem.c                                   |   4 +-
>  net/sched/sch_ets.c                          |   2 +
>  sound/usb/quirks.c                           |   2 +
>  20 files changed, 251 insertions(+), 145 deletions(-)
>
>
>

