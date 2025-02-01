Return-Path: <stable+bounces-111897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E93AA24ADF
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 17:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A4D165710
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 16:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB84B1C5F34;
	Sat,  1 Feb 2025 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TQuJcPtz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891751C3C14;
	Sat,  1 Feb 2025 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738429183; cv=none; b=CP9lorCVLO7nVgTy0LNSaM6K7ywMhO9X21saLraD3hcn+qZAqzR5jp8xiCehAcmG4Vp/5cbMPjhbUUVf4tZihv9qo0zrUe9ix/08OZI9+HmI7Xx1E00IYlC4xPQRqVfEEiFiIx70pYz3Zkja28mFjouVT/H6YpGa/jmfcoe87uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738429183; c=relaxed/simple;
	bh=YaT8hUKAwlkVQN1HAl8KYPeow30zxtcKS/0UO6q+LGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gq49NI5Z8usLSAUA1PrX769Ch2oDgrbM50hhJfQ4x6cae7GQOe7dQnMPDFaJnk/nN7Aczni2sD7hqSx/T+xI/S4fAKjCl/FZDiYRTejTzHYAeZnd5ly5kb4F1Exb4odT78XL70jveyb5X8m/1Jk8/6Umxi2Pm+kHX4VLDJDO5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TQuJcPtz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BBDC4CED3;
	Sat,  1 Feb 2025 16:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738429183;
	bh=YaT8hUKAwlkVQN1HAl8KYPeow30zxtcKS/0UO6q+LGE=;
	h=From:To:Cc:Subject:Date:From;
	b=TQuJcPtzF/yhG2HV3vFJY+iYs8v9r4Jl+1hNRwrNqJbHBcTe/tjQvZFLzlG6S9aZb
	 L4dLobfL192kRy7ugjAyt99U1YFOkklJPI5sT72viamN+U8O/5VBbXoDL+St+r8aRV
	 5jtwV+AfIrPHiSu82YzhNYQTwRaBLZ/G7qli7RFQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.13.1
Date: Sat,  1 Feb 2025 17:59:37 +0100
Message-ID: <2025020138-helpful-lagoon-c270@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.13.1 kernel.

All users of the 6.13 kernel series must upgrade.

The updated 6.13.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.13.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                     |    2 
 drivers/gpu/drm/v3d/v3d_irq.c                |   16 ++
 drivers/hid/hid-ids.h                        |    1 
 drivers/hid/hid-multitouch.c                 |    8 -
 drivers/hid/wacom_sys.c                      |   24 ++--
 drivers/input/joystick/xpad.c                |    9 +
 drivers/input/keyboard/atkbd.c               |    2 
 drivers/net/wireless/realtek/rtl8xxxu/core.c |   20 +++
 drivers/scsi/storvsc_drv.c                   |    8 +
 drivers/usb/gadget/function/u_serial.c       |    8 -
 drivers/usb/serial/quatech2.c                |    2 
 drivers/vfio/platform/vfio_platform_common.c |   10 +
 fs/gfs2/file.c                               |    1 
 fs/libfs.c                                   |  162 ++++++++++++---------------
 fs/smb/client/smb2inode.c                    |   92 +++++++++++----
 include/linux/fs.h                           |    1 
 io_uring/rsrc.c                              |    7 +
 mm/filemap.c                                 |   17 ++
 mm/shmem.c                                   |    4 
 net/sched/sch_ets.c                          |    2 
 sound/usb/quirks.c                           |    2 
 tools/power/cpupower/Makefile                |    8 +
 22 files changed, 264 insertions(+), 142 deletions(-)

Alex Williamson (1):
      vfio/platform: check the bounds of read/write syscalls

Andreas Gruenbacher (1):
      gfs2: Truncate address space when flipping GFS2_DIF_JDATA flag

Chuck Lever (5):
      libfs: Return ENOSPC when the directory offset range is exhausted
      Revert "libfs: Add simple_offset_empty()"
      Revert "libfs: fix infinite directory reads for offset dir"
      libfs: Replace simple_offset end-of-directory detection
      libfs: Use d_children list to iterate simple_offset directories

Easwar Hariharan (1):
      scsi: storvsc: Ratelimit warning logs to prevent VM denial of service

Greg Kroah-Hartman (2):
      Revert "usb: gadget: u_serial: Disable ep before setting port to null to fix the crash caused by port being null"
      Linux 6.13.1

Hans de Goede (1):
      wifi: rtl8xxxu: add more missing rtl8192cu USB IDs

Jack Greiner (1):
      Input: xpad - add support for wooting two he (arm)

Jamal Hadi Salim (1):
      net: sched: fix ets qdisc OOB Indexing

Jann Horn (1):
      io_uring/rsrc: require cloned buffers to share accounting contexts

Jason Gerecke (1):
      HID: wacom: Initialize brightness of LED trigger

Jiri Kosina (1):
      Revert "HID: multitouch: Add support for lenovo Y9000P Touchpad"

Leonardo Brondani Schenkel (1):
      Input: xpad - improve name of 8BitDo controller 2dc8:3106

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for USB Audio Device

Linus Torvalds (1):
      cachestat: fix page cache statistics permission checking

Mark Pearson (1):
      Input: atkbd - map F23 key to support default copilot shortcut

Matheos Mattsson (1):
      Input: xpad - add support for Nacon Evol-X Xbox One Controller

Maíra Canal (1):
      drm/v3d: Assign job pointer to NULL before signaling the fence

Nicolas Nobelis (1):
      Input: xpad - add support for Nacon Pro Compact

Nilton Perim Neto (1):
      Input: xpad - add unofficial Xbox 360 wireless receiver clone

Paulo Alcantara (1):
      smb: client: handle lack of EA support in smb2_query_path_info()

Peng Fan (1):
      pm: cpupower: Makefile: Fix cross compilation

Pierre-Loup A. Griffais (1):
      Input: xpad - add QH Electronics VID/PID

Qasim Ijaz (1):
      USB: serial: quatech2: fix null-ptr-deref in qt2_process_read_urb()


