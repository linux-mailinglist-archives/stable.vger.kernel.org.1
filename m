Return-Path: <stable+bounces-93694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF76A9D044D
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 15:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40A3B23271
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 14:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300141DBB3A;
	Sun, 17 Nov 2024 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wo8/Mmbp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88A81DBB32;
	Sun, 17 Nov 2024 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731853149; cv=none; b=LE63ouOvLBdoFzPwp02v7bjr6P/v2UtGiBy1IaodiQAbAg7S6OQwD/aV2I2AhxfygA4yJVslQZjtvQjzd6WU6H7qVdrxoeAtZTETBWOTpCGkgM7FhayaPQFjFNvgBVRmGFSaIASkw8bP2EM08LlR0G499TZJe8Sktthvy0b22h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731853149; c=relaxed/simple;
	bh=MholhmARuGnlj5dpkDG6vrdfvJ9EGFus9Z7t0FIYVzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lj57ZHfDO5ja/qywNTpiZPcdP13RBFNxBTg0cRX2o37aaq6il4oj62+CduYlI5V1Ey8pB9y8qvLaPEDZbJs1rXw5at/k4Um3FsDe8QmUrmWZJBWuPtC82qMt9s+8TUMlyBmakgX0giv3k1Ilsd5tnjDCdyxrG2C/VUrpCVpsnl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wo8/Mmbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51376C4CED7;
	Sun, 17 Nov 2024 14:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731853149;
	bh=MholhmARuGnlj5dpkDG6vrdfvJ9EGFus9Z7t0FIYVzQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Wo8/MmbpIQiqZGyZQOkcLkpUFGNXnLYhfdPI4iaRDbXjr08Dq5HAlQllNUY9Zhg01
	 L9/mMWeum5mztZ+oolrC/esO/Q1lqaJhBFGeDo9+ryq4wcBeCMKk2l7d1MiomlxHB5
	 Fwbp1cz7ZXjC26D3z7zkuf7j4DOyl1oSDjZKL3hs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.11.9
Date: Sun, 17 Nov 2024 15:18:38 +0100
Message-ID: <2024111738-deodorant-twiddle-f9c2@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.11.9 kernel.

All users of the 6.11 kernel series must upgrade.

The updated 6.11.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.11.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                |    2 
 arch/loongarch/include/asm/loongarch.h                  |    2 
 arch/loongarch/kvm/timer.c                              |    7 -
 arch/loongarch/kvm/vcpu.c                               |    2 
 arch/powerpc/platforms/powernv/opal-irqchip.c           |    1 
 arch/riscv/kvm/aia_imsic.c                              |    8 -
 block/elevator.c                                        |    4 
 crypto/algapi.c                                         |    2 
 drivers/crypto/marvell/cesa/hash.c                      |   12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                |    6 -
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                   |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                    |   26 +++++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                     |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                     |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                     |    3 
 drivers/gpu/drm/xe/xe_device.c                          |    2 
 drivers/gpu/drm/xe/xe_force_wake.c                      |   12 +-
 drivers/gpu/drm/xe/xe_guc_ct.c                          |   18 +++
 drivers/gpu/drm/xe/xe_guc_submit.c                      |   14 ++
 drivers/gpu/drm/xe/xe_query.c                           |    6 -
 drivers/gpu/drm/xe/xe_sync.c                            |    3 
 drivers/hid/hid-ids.h                                   |    2 
 drivers/hid/hid-lenovo.c                                |    8 +
 drivers/hid/hid-multitouch.c                            |   13 ++
 drivers/hid/i2c-hid/i2c-hid-core.c                      |   10 +
 drivers/infiniband/sw/siw/siw_qp_tx.c                   |    2 
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c              |    4 
 drivers/irqchip/irq-mscc-ocelot.c                       |    4 
 drivers/net/mdio/mdio-bcm-unimac.c                      |    1 
 drivers/net/usb/qmi_wwan.c                              |    1 
 drivers/nvme/host/core.c                                |   52 +++++-----
 drivers/nvme/host/multipath.c                           |   33 ++++++
 drivers/nvme/host/nvme.h                                |    1 
 drivers/nvme/host/tcp.c                                 |    7 -
 drivers/nvme/target/loop.c                              |   13 ++
 drivers/nvme/target/passthru.c                          |    6 -
 drivers/pinctrl/intel/Kconfig                           |    1 
 drivers/pinctrl/pinctrl-aw9523.c                        |    6 -
 drivers/s390/crypto/ap_bus.c                            |    3 
 drivers/s390/crypto/ap_bus.h                            |    2 
 drivers/s390/crypto/ap_queue.c                          |   28 +++--
 drivers/vdpa/ifcvf/ifcvf_base.c                         |    2 
 drivers/virtio/virtio_pci_common.c                      |   24 +++-
 drivers/virtio/virtio_pci_common.h                      |    1 
 drivers/virtio/virtio_pci_modern.c                      |   12 --
 fs/9p/fid.c                                             |    5 
 fs/afs/internal.h                                       |    2 
 fs/afs/rxrpc.c                                          |   83 +++++++++++-----
 fs/netfs/locking.c                                      |    3 
 fs/ocfs2/file.c                                         |    9 +
 fs/smb/client/connect.c                                 |   14 ++
 include/net/tls.h                                       |   12 +-
 kernel/bpf/syscall.c                                    |   14 +-
 kernel/bpf/verifier.c                                   |    4 
 mm/slab_common.c                                        |    2 
 net/9p/client.c                                         |   12 ++
 net/core/filter.c                                       |    2 
 samples/landlock/sandboxer.c                            |   32 +++++-
 sound/Kconfig                                           |    2 
 sound/pci/hda/patch_realtek.c                           |   29 +++++
 sound/soc/amd/yc/acp6x-mach.c                           |   14 ++
 sound/soc/codecs/aw88399.c                              |    2 
 sound/soc/codecs/lpass-rx-macro.c                       |   15 +-
 sound/soc/codecs/rt722-sdca-sdw.c                       |    2 
 sound/soc/fsl/fsl_micfil.c                              |   38 +++++++
 sound/soc/intel/avs/core.c                              |    3 
 sound/soc/intel/avs/pcm.c                               |   19 +++
 sound/soc/intel/avs/pcm.h                               |   16 +++
 sound/soc/intel/common/soc-acpi-intel-lnl-match.c       |   38 +++++++
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c |    9 +
 tools/testing/selftests/bpf/progs/verifier_scalar_ids.c |   67 ++++++++++++
 72 files changed, 664 insertions(+), 164 deletions(-)

Alessandro Zanni (1):
      fs: Fix uninitialized value issue in from_kuid and from_kgid

Alexey Klimov (1):
      ASoC: codecs: lpass-rx-macro: fix RXn(rx,n) macro for DSM_CTL and SEC7 regs

Amadeusz Sławiński (1):
      ASoC: Intel: avs: Update stream status in a separate thread

Andy Shevchenko (1):
      pinctrl: intel: platform: Add Panther Lake to the list of supported

Badal Nilawar (1):
      drm/xe/guc/ct: Flush g2h worker in case of g2h response timeout

Baojun Xu (1):
      ALSA: hda/tas2781: Add new quirk for Lenovo, ASUS, Dell projects

Bartłomiej Maryńczak (1):
      HID: i2c-hid: Delayed i2c resume wakeup for 0x0d42 Goodix touchpad

Breno Leitao (1):
      nvme/host: Fix RCU list traversal to use SRCU primitive

Christian Heusel (1):
      ASoC: amd: yc: Add quirk for ASUS Vivobook S15 M3502RA

Cyan Yang (1):
      RISCV: KVM: use raw_spinlock for critical section in imsic

David Howells (2):
      netfs: Downgrade i_rwsem for a buffered write
      afs: Fix lock recursion

Derek Fang (1):
      ASoC: Intel: soc-acpi: lnl: Add match entry for TM2 laptops

Dominique Martinet (1):
      9p: v9fs_fid_find: also lookup by inode if not found dentry

Eduard Zingerman (1):
      selftests/bpf: Verify that sync_linked_regs preserves subreg_def

Feng Liu (1):
      virtio_pci: Fix admin vq cleanup by using correct info pointer

Greg Joyce (1):
      nvme: disable CC.CRIME (NVME_CC_CRIME)

Greg Kroah-Hartman (1):
      Linux 6.11.9

Hannes Reinecke (1):
      nvme: tcp: avoid race between queue_lock lock and destroy

Hans de Goede (1):
      HID: lenovo: Add support for Thinkpad X1 Tablet Gen 3 keyboard

Harald Freudenberger (1):
      s390/ap: Fix CCA crypto card behavior within protected execution environment

Herbert Xu (2):
      crypto: api - Fix liveliness check in crypto_alg_tested
      crypto: marvell/cesa - Disable hash algorithms

Hou Tao (1):
      bpf: Check validity of link->type in bpf_link_show_fdinfo()

Huacai Chen (1):
      LoongArch: KVM: Mark hrtimer to expire in hard interrupt context

Ian Forbes (1):
      drm/vmwgfx: Limit display layout ioctl array size to VMWGFX_NUM_DISPLAY_UNITS

Ilya Dudikov (1):
      ASoC: amd: yc: Fix non-functional mic on ASUS E1404FA

Jack Yu (1):
      ASoC: rt722-sdca: increase clk_stop_timeout to fix clock stop issue

Jiawei Ye (1):
      bpf: Fix mismatched RCU unlock flavour in bpf_out_neigh_v6

Julian Vetter (1):
      sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML

Keith Busch (1):
      nvme-multipath: defer partition scanning

Kenneth Albanowski (1):
      HID: multitouch: Add quirk for Logitech Bolt receiver w/ Casa touchpad

Kuniyuki Iwashima (1):
      smb: client: Fix use-after-free of network namespace.

Linus Torvalds (1):
      9p: fix slab cache name creation for real

Linus Walleij (1):
      net: phy: mdio-bcm-unimac: Add BCM6846 support

Lucas De Marchi (1):
      drm/xe/query: Increase timestamp width

Matthieu Buffet (1):
      samples/landlock: Fix port parsing in sandboxer

Michael Ellerman (1):
      powerpc/powernv: Free name on error in opal_event_init()

Nilay Shroff (3):
      nvmet-passthru: clear EUID/NGUID/UUID while using loop target
      nvme-loop: flush off pending I/O while shutting down loop controller
      nvme: make keep-alive synchronous operation

Nirmoy Das (2):
      drm/xe/ufence: Prefetch ufence addr to catch bogus address
      drm/xe: Don't restart parallel queues multiple times on GT reset

Pedro Falcato (1):
      9p: Avoid creating multiple slab caches with the same name

Philip Yang (1):
      drm/amdkfd: Accounting pdd vram_usage for svm

Qun-Wei Lin (1):
      mm: krealloc: Fix MTE false alarm in __do_krealloc

Reinhard Speyerer (1):
      net: usb: qmi_wwan: add Fibocom FG132 0x0112 composition

Rik van Riel (1):
      bpf: use kvzmalloc to allocate BPF verifier environment

Robin Murphy (1):
      iommu/arm-smmu: Clarify MMU-500 CPRE workaround

Rosen Penev (1):
      pinctrl: aw9523: add missing mutex_destroy

Sergey Matsievskiy (1):
      irqchip/ocelot: Fix trigger register address

Shengjiu Wang (1):
      ASoC: fsl_micfil: Add sample rate constraint

Showrya M N (1):
      RDMA/siw: Add sendpage_ok() check to disable MSG_SPLICE_PAGES

Shuicheng Lin (2):
      drm/xe: Enlarge the invalidation timeout from 150 to 500
      drm/xe: Handle unreliable MMIO reads during forcewake

Stefan Blum (1):
      HID: multitouch: Add support for B2402FVA track point

SurajSonawane2415 (1):
      block: Fix elevator_get_default() checking for NULL q->tag_set

Tyrone Wu (1):
      selftests/bpf: Assert link info uprobe_multi count & path_size if unset

WangYuli (1):
      HID: multitouch: Add quirk for HONOR MagicBook Art 14 touchpad

Yanteng Si (1):
      LoongArch: Use "Exception return address" to comment ERA

Yuan Can (1):
      vDPA/ifcvf: Fix pci_read_config_byte() return code handling

Zhu Jun (1):
      ASoC: codecs: Fix error handling in aw_dev_get_dsp_status function

Zijian Zhang (1):
      bpf: Add sk_is_inet and IS_ICSK check in tls_sw_has_ctx_tx/rx


