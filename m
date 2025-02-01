Return-Path: <stable+bounces-111907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217F9A24B3C
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 18:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3CF1886E75
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 17:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C8F1D416B;
	Sat,  1 Feb 2025 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fub27eFM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F1A1CAA9E;
	Sat,  1 Feb 2025 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738431964; cv=none; b=hb5XcK3llb+vKO8TSweptQJHvyJ2t/KmT7aZErMGyay+QhtrYgZWLLa/feZlcw7jIuERKf/FdHtUwBMs9f/OS0KQZ+ca5I3gSfVdsBFn9ilmaaxVOc8nfY/uBa0iWph8k1xpnjThv2AaN/3T86nPAxSWMQQDMcD5Qt8OQLjSkvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738431964; c=relaxed/simple;
	bh=fuy9fiSkpgLRHAbv6vFpgKyW+GAoW3hNs6p85Us9wc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i8H5v9roT3thDDgN6e5FQqujEpppjV27FIkeFJ+wqrsuCyV9QeJpDJ4azi8i3JHy4SY3NqSzIXyt7dZuzAAWlZFcBdV7xyu9Ozv8uAhT1BLW9icJ4K31iTKoZCUOV7O4D/mT2+vr0zaB/qB0uTNVFyZDISATpOpUVw830GMx25Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fub27eFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F45C4CEE0;
	Sat,  1 Feb 2025 17:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738431963;
	bh=fuy9fiSkpgLRHAbv6vFpgKyW+GAoW3hNs6p85Us9wc8=;
	h=From:To:Cc:Subject:Date:From;
	b=fub27eFMpruBUyNMRTK14grIRi15MCUG/EDkYm/NIczH50p9wqbEcyOwH4Eo/8bZk
	 GseufjT51F21U4miELHOmZHKyV02Uq9qU8zQN4xIaqGzq+4HOSH9HN75oFj1d9Y9Xc
	 ewbZsBLIoB9IEZZACGEbWY0pz1WhOAUctBT9ZD/Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.128
Date: Sat,  1 Feb 2025 18:45:48 +0100
Message-ID: <2025020149-reorder-footwear-3597@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.128 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                     |    2 
 block/ioctl.c                                                |    9 
 drivers/base/regmap/regmap.c                                 |   12 
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c        |    3 
 drivers/gpu/drm/v3d/v3d_irq.c                                |   16 
 drivers/hid/hid-ids.h                                        |    1 
 drivers/hid/hid-multitouch.c                                 |    8 
 drivers/input/joystick/xpad.c                                |    2 
 drivers/input/keyboard/atkbd.c                               |    2 
 drivers/irqchip/irq-sunxi-nmi.c                              |    3 
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c                  |    9 
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c                  |    9 
 drivers/scsi/scsi_transport_iscsi.c                          |    4 
 drivers/scsi/storvsc_drv.c                                   |    8 
 drivers/usb/gadget/function/u_serial.c                       |    8 
 drivers/usb/serial/quatech2.c                                |    2 
 drivers/vfio/platform/vfio_platform_common.c                 |   10 
 fs/ext4/super.c                                              |    3 
 fs/gfs2/file.c                                               |    1 
 fs/smb/client/smb2ops.c                                      |   47 +
 fs/smb/client/smb2pdu.c                                      |   10 
 fs/xfs/libxfs/xfs_alloc.c                                    |   27 +
 fs/xfs/libxfs/xfs_bmap.c                                     |   21 
 fs/xfs/libxfs/xfs_defer.c                                    |   28 -
 fs/xfs/libxfs/xfs_defer.h                                    |    2 
 fs/xfs/libxfs/xfs_inode_buf.c                                |    3 
 fs/xfs/libxfs/xfs_rtbitmap.c                                 |   33 +
 fs/xfs/libxfs/xfs_sb.h                                       |    2 
 fs/xfs/xfs_bmap_util.c                                       |   24 -
 fs/xfs/xfs_dquot.c                                           |    5 
 fs/xfs/xfs_dquot_item_recover.c                              |   21 
 fs/xfs/xfs_file.c                                            |   63 ++
 fs/xfs/xfs_inode.c                                           |   24 +
 fs/xfs/xfs_inode.h                                           |   17 
 fs/xfs/xfs_inode_item_recover.c                              |   14 
 fs/xfs/xfs_ioctl.c                                           |   30 -
 fs/xfs/xfs_iops.c                                            |    7 
 fs/xfs/xfs_log.c                                             |   23 
 fs/xfs/xfs_log_recover.c                                     |    2 
 fs/xfs/xfs_reflink.c                                         |    5 
 fs/xfs/xfs_rtalloc.c                                         |   33 +
 fs/xfs/xfs_rtalloc.h                                         |   27 -
 include/linux/seccomp.h                                      |    2 
 io_uring/io_uring.c                                          |    4 
 kernel/softirq.c                                             |   15 
 net/ipv4/ip_tunnel.c                                         |    2 
 net/ipv6/ip6_fib.c                                           |    8 
 net/ipv6/route.c                                             |   45 +
 net/sched/sch_ets.c                                          |    2 
 sound/soc/codecs/Kconfig                                     |    1 
 sound/soc/samsung/Kconfig                                    |    6 
 sound/soc/samsung/midas_wm1811.c                             |   24 -
 sound/usb/quirks.c                                           |    2 
 tools/testing/selftests/net/Makefile                         |    1 
 tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh |  262 +++++++++++
 55 files changed, 767 insertions(+), 187 deletions(-)

Alex Williamson (1):
      vfio/platform: check the bounds of read/write syscalls

Alexey Dobriyan (1):
      block: fix integer overflow in BLKSECDISCARD

Alper Nebi Yasak (1):
      ASoC: samsung: midas_wm1811: Map missing jack kcontrols

Andreas Gruenbacher (1):
      gfs2: Truncate address space when flipping GFS2_DIF_JDATA flag

Anjaneyulu (1):
      wifi: iwlwifi: add a few rate index validity checks

Catherine Hoang (1):
      xfs: allow read IO and FICLONE to run concurrently

Charles Keepax (3):
      ASoC: wm8994: Add depends on MFD core
      ASoC: samsung: Add missing selects for MFD_WM8994
      ASoC: samsung: Add missing depends on I2C

Cheng Lin (1):
      xfs: introduce protection for drop nlink

Christoph Hellwig (4):
      xfs: handle nimaps=0 from xfs_bmapi_write in xfs_alloc_file_space
      xfs: only remap the written blocks in xfs_reflink_end_cow_extent
      xfs: clean up FS_XFLAG_REALTIME handling in xfs_ioctl_setattr_xflags
      xfs: respect the stable writes flag on the RT device

Cosmin Tanislav (1):
      regmap: detach regmap from dev on regmap_exit

Darrick J. Wong (8):
      xfs: bump max fsgeom struct version
      xfs: hoist freeing of rt data fork extent mappings
      xfs: prevent rt growfs when quota is enabled
      xfs: rt stubs should return negative errnos when rt disabled
      xfs: fix units conversion error in xfs_bmap_del_extent_delay
      xfs: make sure maxlen is still congruent with prod when rounding down
      xfs: clean up dqblk extraction
      xfs: dquot recovery does not validate the recovered dquot

Dave Chinner (1):
      xfs: inode recovery does not validate the recovered inode

Easwar Hariharan (1):
      scsi: storvsc: Ratelimit warning logs to prevent VM denial of service

Enzo Matsumiya (1):
      smb: client: fix UAF in async decryption

Greg Kroah-Hartman (2):
      Revert "usb: gadget: u_serial: Disable ep before setting port to null to fix the crash caused by port being null"
      Linux 6.1.128

Ido Schimmel (1):
      ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()

Jack Greiner (1):
      Input: xpad - add support for wooting two he (arm)

Jamal Hadi Salim (1):
      net: sched: fix ets qdisc OOB Indexing

Jiri Kosina (1):
      Revert "HID: multitouch: Add support for lenovo Y9000P Touchpad"

K Prateek Nayak (1):
      softirq: Allow raising SCHED_SOFTIRQ from SMP-call-function on RT kernel

Leah Rumancik (1):
      xfs: up(ic_sema) if flushing data device fails

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for USB Audio Device

Linus Walleij (1):
      seccomp: Stub for !CONFIG_SECCOMP

Long Li (2):
      xfs: factor out xfs_defer_pending_abort
      xfs: abort intent items when recovery intents fail

Luis Henriques (SUSE) (1):
      ext4: fix access to uninitialised lock in fc replay path

Marek Szyprowski (1):
      ASoC: samsung: midas_wm1811: Fix 'Headphone Switch' control creation

Mark Pearson (1):
      Input: atkbd - map F23 key to support default copilot shortcut

Maíra Canal (1):
      drm/v3d: Assign job pointer to NULL before signaling the fence

Nilton Perim Neto (1):
      Input: xpad - add unofficial Xbox 360 wireless receiver clone

Omar Sandoval (1):
      xfs: fix internal error from AGFL exhaustion

Omid Ehtemam-Haghighi (1):
      ipv6: Fix soft lockups in fib6_select_path under high next hop churn

Paulo Alcantara (1):
      smb: client: fix NULL ptr deref in crypto_aead_setkey()

Pavel Begunkov (1):
      io_uring: fix waiters missing wake ups

Philippe Simons (1):
      irqchip/sunxi-nmi: Add missing SKIP_WAKE flag

Qasim Ijaz (1):
      USB: serial: quatech2: fix null-ptr-deref in qt2_process_read_urb()

Tom Chung (1):
      drm/amd/display: Use HW lock mgr for PSR1

Xiang Zhang (1):
      scsi: iscsi: Fix redundant response for ISCSI_UEVENT_GET_HOST_STATS request


