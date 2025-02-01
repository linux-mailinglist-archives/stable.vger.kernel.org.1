Return-Path: <stable+bounces-111910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09506A24B42
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 18:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B701887055
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 17:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AC21D5ADC;
	Sat,  1 Feb 2025 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KT3v9zwA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E421BC9FB;
	Sat,  1 Feb 2025 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738431974; cv=none; b=geyfrB9JDnay4eM23ka9tgIKI9Qlh0mpPKLUzqx0ZiQOhDpITQXdn4wdBDNpeFLdUDNpF9TOYbv8lL6qNyyD38ukmL9pGiU66d+xPfCrDlfXbieE4jN4n7S3dETaLGKCSMeBNR5ro68Gs/jTmJgGilZv7LCU5PSDAv6zvnLb0QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738431974; c=relaxed/simple;
	bh=k3GfAHGhehFtQ+3XNZngi8W6lAbhA3kuCQtgN05zDEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZChqDhyXV7EOXKjytFlCNul0d3oM7NmvuB0bFR/ll1TaxdV4Wk3z+198siRHcP28toqaCMDwR5wfWXku1KXOPSWZednloyugNB1LZl+sf3PC2gRPNa/1Yl1gQA9gTZ38MNcBgk9Kq03qbIGIXyA59Ah8eO92+u5tZmgzU1pMr+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KT3v9zwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D77C4CEE0;
	Sat,  1 Feb 2025 17:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738431974;
	bh=k3GfAHGhehFtQ+3XNZngi8W6lAbhA3kuCQtgN05zDEk=;
	h=From:To:Cc:Subject:Date:From;
	b=KT3v9zwAepacQW2rxzoEt/iR9wasK3B6ZFeaQdLfNGUaod7XkHR3JDplODWcSiSsb
	 lwFpc19FUAw55EZdMfpLcj7q9FqsQvUMwkYIA28UfSp1eOTV4p8xGsHNJ2Xa/oRKbY
	 GQV6cLTZuq6joz/puJ/ipYRAZFDid0R0nu7ug/Eo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.12
Date: Sat,  1 Feb 2025 18:45:53 +0100
Message-ID: <2025020154-tribunal-bonnet-9db4@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.12 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                                       |    2 
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c                          |    3 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c |    4 
 drivers/gpu/drm/drm_connector.c                                                |    3 
 drivers/gpu/drm/v3d/v3d_irq.c                                                  |   16 
 drivers/hid/hid-ids.h                                                          |    1 
 drivers/hid/hid-multitouch.c                                                   |    8 
 drivers/hid/wacom_sys.c                                                        |   24 -
 drivers/hwmon/drivetemp.c                                                      |    2 
 drivers/input/joystick/xpad.c                                                  |    9 
 drivers/input/keyboard/atkbd.c                                                 |    2 
 drivers/irqchip/irq-sunxi-nmi.c                                                |    3 
 drivers/net/wireless/realtek/rtl8xxxu/core.c                                   |   20 +
 drivers/of/unittest-data/tests-platform.dtsi                                   |   13 
 drivers/of/unittest.c                                                          |   14 
 drivers/scsi/scsi_transport_iscsi.c                                            |    4 
 drivers/scsi/storvsc_drv.c                                                     |    8 
 drivers/usb/gadget/function/u_serial.c                                         |    8 
 drivers/usb/serial/quatech2.c                                                  |    2 
 drivers/vfio/platform/vfio_platform_common.c                                   |   10 
 fs/gfs2/file.c                                                                 |    1 
 fs/libfs.c                                                                     |  162 ++++------
 fs/smb/client/smb2inode.c                                                      |   92 ++++-
 include/linux/fs.h                                                             |    1 
 include/linux/seccomp.h                                                        |    2 
 io_uring/rsrc.c                                                                |    7 
 mm/filemap.c                                                                   |   19 +
 mm/shmem.c                                                                     |    4 
 mm/zswap.c                                                                     |   90 +++--
 net/sched/sch_ets.c                                                            |    2 
 sound/pci/hda/patch_realtek.c                                                  |    4 
 sound/soc/codecs/Kconfig                                                       |    1 
 sound/soc/codecs/cs42l43.c                                                     |    1 
 sound/soc/codecs/es8316.c                                                      |   10 
 sound/soc/samsung/Kconfig                                                      |    6 
 sound/usb/quirks.c                                                             |    2 
 36 files changed, 379 insertions(+), 181 deletions(-)

Alex Hung (1):
      drm/amd/display: Initialize denominator defaults to 1

Alex Williamson (1):
      vfio/platform: check the bounds of read/write syscalls

Andreas Gruenbacher (1):
      gfs2: Truncate address space when flipping GFS2_DIF_JDATA flag

Charles Keepax (3):
      ASoC: wm8994: Add depends on MFD core
      ASoC: samsung: Add missing selects for MFD_WM8994
      ASoC: samsung: Add missing depends on I2C

Chuck Lever (5):
      libfs: Return ENOSPC when the directory offset range is exhausted
      Revert "libfs: Add simple_offset_empty()"
      Revert "libfs: fix infinite directory reads for offset dir"
      libfs: Replace simple_offset end-of-directory detection
      libfs: Use d_children list to iterate simple_offset directories

Cristian Ciocaltea (1):
      drm/connector: hdmi: Validate supported_formats matches ycbcr_420_allowed

Easwar Hariharan (1):
      scsi: storvsc: Ratelimit warning logs to prevent VM denial of service

Greg Kroah-Hartman (2):
      Revert "usb: gadget: u_serial: Disable ep before setting port to null to fix the crash caused by port being null"
      Linux 6.12.12

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

Linus Walleij (1):
      seccomp: Stub for !CONFIG_SECCOMP

Maciej Strozek (1):
      ASoC: cs42l43: Add codec force suspend/resume ops

Marian Postevca (1):
      ASoC: codecs: es8316: Fix HW rate calculation for 48Mhz MCLK

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

Philippe Simons (1):
      irqchip/sunxi-nmi: Add missing SKIP_WAKE flag

Pierre-Loup A. Griffais (1):
      Input: xpad - add QH Electronics VID/PID

Qasim Ijaz (1):
      USB: serial: quatech2: fix null-ptr-deref in qt2_process_read_urb()

Rob Herring (Arm) (1):
      of/unittest: Add test that of_address_to_resource() fails on non-translatable address

Russell Harmon (1):
      hwmon: (drivetemp) Set scsi command timeout to 10s

Tom Chung (1):
      drm/amd/display: Use HW lock mgr for PSR1

Xiang Zhang (1):
      scsi: iscsi: Fix redundant response for ISCSI_UEVENT_GET_HOST_STATS request

Yage Geng (1):
      ALSA: hda/realtek: Fix volume adjustment issue on Lenovo ThinkBook 16P Gen5

Yosry Ahmed (2):
      mm: zswap: properly synchronize freeing resources during CPU hotunplug
      mm: zswap: move allocations during CPU init outside the lock


