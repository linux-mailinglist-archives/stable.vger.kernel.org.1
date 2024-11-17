Return-Path: <stable+bounces-93691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E376D9D0446
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 15:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5913BB2270D
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFE11D90C5;
	Sun, 17 Nov 2024 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0KeiNXSU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4731DACA1;
	Sun, 17 Nov 2024 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731853136; cv=none; b=gcaFEOScBxwb/h4OwTlNuiFoyll9VGYF36y+msJLEQU2CmGuS3G0NXTvGNjznlo7LkdU+C/ATqrLzlCG+NMppqzEGe5PC3AjhWOMnR2n1nprxP59woU8ogMeRbrKclgcq1IGtAwlkXuAvnzhfk+UhtjGxnNGhOelpxx+nRmQ6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731853136; c=relaxed/simple;
	bh=ihe4X2ISDh4c/57WwkNShq0WjLAzQVcmsX1e6ucmpgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A7we0tqk34r+qTeXPIs95rgYpQj8KDyvF5rpMxrXYMD2OE2i3V0i2gM/l3A7JOxnRXy+IApq+5ZHvIf6OiHAhdMwXn7AYjnIhtOY/u9oETAamOZgbUaRU07Wgcl9IGUCaXNQvZmgiRZGWlRBrVYg1Y4DCHm9HrA/u2Ydimo8Osg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0KeiNXSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47E6C4CED8;
	Sun, 17 Nov 2024 14:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731853136;
	bh=ihe4X2ISDh4c/57WwkNShq0WjLAzQVcmsX1e6ucmpgA=;
	h=From:To:Cc:Subject:Date:From;
	b=0KeiNXSUcxWBdGKmjSJ2/zfReV+UeQ68nBXUyukAbekD1Nt9PKesZDFlmln3cep8I
	 WBZDH5qDPwiyvCNl2LH3GnGdVQrlf/r6xzxoZgu7fVdI1UyaPLtocNEUdYIO6uViuU
	 5kg5QQKi+trUpieguRRQGGiioF5o9OhUmtmdV8D0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.118
Date: Sun, 17 Nov 2024 15:18:23 +0100
Message-ID: <2024111723-caliber-enable-ee57@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.118 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                               |    2 
 arch/loongarch/include/asm/loongarch.h                 |    2 
 arch/powerpc/platforms/powernv/opal-irqchip.c          |    1 
 block/elevator.c                                       |    4 
 crypto/algapi.c                                        |    2 
 drivers/crypto/marvell/cesa/hash.c                     |   12 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c             |   14 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h             |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c           |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c               |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                    |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                    |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                    |    3 
 drivers/hid/hid-ids.h                                  |    1 
 drivers/hid/hid-lenovo.c                               |    8 
 drivers/hid/hid-multitouch.c                           |   13 +
 drivers/irqchip/irq-mscc-ocelot.c                      |    4 
 drivers/md/raid10.c                                    |   23 +-
 drivers/net/usb/qmi_wwan.c                             |    1 
 drivers/nvme/host/core.c                               |   31 +--
 drivers/nvme/host/multipath.c                          |   33 +++
 drivers/nvme/host/nvme.h                               |    1 
 drivers/nvme/host/tcp.c                                |    7 
 drivers/platform/x86/x86-android-tablets.c             |    3 
 drivers/vdpa/ifcvf/ifcvf_base.c                        |    2 
 fs/ext4/super.c                                        |    2 
 fs/ntfs3/inode.c                                       |    9 
 fs/ocfs2/file.c                                        |    9 
 include/net/bluetooth/hci_core.h                       |    3 
 io_uring/io_uring.c                                    |    5 
 kernel/bpf/verifier.c                                  |    4 
 kernel/trace/trace_uprobe.c                            |   86 +++++----
 mm/slab_common.c                                       |    2 
 net/9p/client.c                                        |   12 +
 net/bluetooth/af_bluetooth.c                           |   10 -
 net/bluetooth/hci_conn.c                               |  154 +++++++++++++----
 net/bluetooth/hci_core.c                               |   50 +----
 net/bluetooth/hci_event.c                              |   20 +-
 net/bluetooth/hci_sync.c                               |   44 +---
 net/bluetooth/l2cap_core.c                             |    9 
 net/bluetooth/mgmt.c                                   |   15 +
 net/core/filter.c                                      |    2 
 sound/Kconfig                                          |    2 
 47 files changed, 393 insertions(+), 238 deletions(-)

Alessandro Zanni (1):
      fs: Fix uninitialized value issue in from_kuid and from_kgid

Andrii Nakryiko (1):
      uprobes: encapsulate preparation of uprobe args buffer

Greg Joyce (1):
      nvme: disable CC.CRIME (NVME_CC_CRIME)

Greg Kroah-Hartman (6):
      Revert "Bluetooth: fix use-after-free in accessing skb after sending it"
      Revert "Bluetooth: hci_sync: Fix overwriting request callback"
      Revert "Bluetooth: af_bluetooth: Fix deadlock"
      Revert "Bluetooth: hci_core: Fix possible buffer overflow"
      Revert "Bluetooth: hci_conn: Consolidate code for aborting connections"
      Linux 6.1.118

Hagar Hemdan (1):
      io_uring: fix possible deadlock in io_register_iowq_max_workers()

Hannes Reinecke (1):
      nvme: tcp: avoid race between queue_lock lock and destroy

Hans de Goede (2):
      HID: lenovo: Add support for Thinkpad X1 Tablet Gen 3 keyboard
      platform/x86: x86-android-tablets: Fix use after free on platform_device_register() errors

Herbert Xu (2):
      crypto: api - Fix liveliness check in crypto_alg_tested
      crypto: marvell/cesa - Disable hash algorithms

Ian Forbes (1):
      drm/vmwgfx: Limit display layout ioctl array size to VMWGFX_NUM_DISPLAY_UNITS

Jiawei Ye (1):
      bpf: Fix mismatched RCU unlock flavour in bpf_out_neigh_v6

Julian Vetter (1):
      sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML

Keith Busch (1):
      nvme-multipath: defer partition scanning

Kenneth Albanowski (1):
      HID: multitouch: Add quirk for Logitech Bolt receiver w/ Casa touchpad

Konstantin Komarov (1):
      fs/ntfs3: Fix general protection fault in run_is_mapped_full

Li Nan (1):
      md/raid10: improve code of mrdev in raid10_sync_request

Linus Torvalds (1):
      9p: fix slab cache name creation for real

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix uaf in l2cap_connect

Michael Ellerman (1):
      powerpc/powernv: Free name on error in opal_event_init()

Nilay Shroff (1):
      nvme: make keep-alive synchronous operation

Pedro Falcato (1):
      9p: Avoid creating multiple slab caches with the same name

Philip Yang (1):
      drm/amdkfd: amdkfd_free_gtt_mem clear the correct pointer

Qiao Ma (1):
      uprobe: avoid out-of-bounds memory access of fetching args

Qun-Wei Lin (1):
      mm: krealloc: Fix MTE false alarm in __do_krealloc

Reinhard Speyerer (1):
      net: usb: qmi_wwan: add Fibocom FG132 0x0112 composition

Rik van Riel (1):
      bpf: use kvzmalloc to allocate BPF verifier environment

Sergey Matsievskiy (1):
      irqchip/ocelot: Fix trigger register address

Stefan Blum (1):
      HID: multitouch: Add support for B2402FVA track point

SurajSonawane2415 (1):
      block: Fix elevator_get_default() checking for NULL q->tag_set

WangYuli (1):
      HID: multitouch: Add quirk for HONOR MagicBook Art 14 touchpad

Xiaxi Shen (1):
      ext4: fix timer use-after-free on failed mount

Yanteng Si (1):
      LoongArch: Use "Exception return address" to comment ERA

Yuan Can (1):
      vDPA/ifcvf: Fix pci_read_config_byte() return code handling


