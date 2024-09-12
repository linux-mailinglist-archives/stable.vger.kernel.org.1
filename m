Return-Path: <stable+bounces-75987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AF3976827
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 13:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECEBB1F2167C
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 11:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7BC1A263E;
	Thu, 12 Sep 2024 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KqrcqYX2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F6B1A0BEB;
	Thu, 12 Sep 2024 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141715; cv=none; b=plCWnItDksFA8/3MXh4YhXCMdJYfFw/Gw48CqAL8Gawk4hxbTt/dObXFA4e6lQ/n6Gl3AoHMpWVvdiEBfoHPb+KQt8TiHwYlwcwQCfrCWOiLLNhpOEfkKm5OxOq2/z0zSk0Q4WtfWm0wRq6hlGyKiOtCFGfpFJoPqAYI4EZdDis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141715; c=relaxed/simple;
	bh=bLeccdwGBWfX05/lIjTWGHolAX14sG0w5DUsRCBZ900=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kcmREmLFNUc0ZCUxKRWOuD/fxLeA3KrGM8hxU8l+9VCTfo3vm/CBHJCG01p9l0e3o5i1vu6Go1qzYtVhcyaC44VzTW3FHL6tifATBJYXtkZLbAtgyX5BADau4+mfsmkOw3hK363c5Tyem49bVxCEZd6LRd6ysOYA65Z7nPB+Ps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KqrcqYX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF19C4CEC3;
	Thu, 12 Sep 2024 11:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726141715;
	bh=bLeccdwGBWfX05/lIjTWGHolAX14sG0w5DUsRCBZ900=;
	h=From:To:Cc:Subject:Date:From;
	b=KqrcqYX2XZrLxJe9iIX8pYLRu1l3tLh1UXfspYv3dpDwFeFTjxpyv29dy9VJLK9Jy
	 ZLakPMxXruTveH9KgAEsLvKVWGwE1IrSIcZtH2t27Wdq8xnkY5s0Jt3yUr37N/JH8q
	 VhvmuKf1G63lEJCiGFZO/uVtRb09sG6T7BxxAd9Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.226
Date: Thu, 12 Sep 2024 13:48:20 +0200
Message-ID: <2024091221-dreamboat-lifter-6c82@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.226 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/locking/hwspinlock.rst                           |   11 
 Makefile                                                       |    2 
 arch/arm64/include/asm/acpi.h                                  |   12 
 arch/arm64/kernel/acpi_numa.c                                  |   11 
 arch/mips/kernel/cevt-r4k.c                                    |   15 
 arch/s390/kernel/vmlinux.lds.S                                 |    9 
 arch/um/drivers/line.c                                         |    2 
 arch/x86/mm/pti.c                                              |   45 +-
 block/bio-integrity.c                                          |   11 
 block/blk-integrity.c                                          |    2 
 drivers/acpi/acpi_processor.c                                  |   15 
 drivers/android/binder.c                                       |    1 
 drivers/ata/libata-core.c                                      |    4 
 drivers/ata/pata_macio.c                                       |    7 
 drivers/base/devres.c                                          |    1 
 drivers/clk/qcom/clk-alpha-pll.c                               |    6 
 drivers/clocksource/timer-imx-tpm.c                            |   16 
 drivers/clocksource/timer-of.c                                 |   17 
 drivers/clocksource/timer-of.h                                 |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c                       |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c                   |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c                        |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                       |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                       |    4 
 drivers/gpu/drm/amd/amdgpu/df_v1_7.c                           |    2 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c                         |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h                          |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                      |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h                      |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |    5 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c      |    3 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c           |    3 
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c             |   17 
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c                 |   17 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c            |   28 +
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c                |   13 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c            |    5 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c            |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c            |   15 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c          |   90 +++-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c          |    8 
 drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c        |    6 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                 |    6 
 drivers/gpu/drm/i915/i915_sw_fence.c                           |    8 
 drivers/gpu/drm/meson/meson_plane.c                            |   17 
 drivers/hid/hid-cougar.c                                       |    2 
 drivers/hv/vmbus_drv.c                                         |    1 
 drivers/hwmon/adc128d818.c                                     |    4 
 drivers/hwmon/lm95234.c                                        |    9 
 drivers/hwmon/nct6775.c                                        |    2 
 drivers/hwmon/w83627ehf.c                                      |    4 
 drivers/hwspinlock/hwspinlock_core.c                           |   28 +
 drivers/hwspinlock/hwspinlock_internal.h                       |    3 
 drivers/iio/adc/ad7124.c                                       |    1 
 drivers/iio/buffer/industrialio-buffer-dmaengine.c             |    4 
 drivers/iio/inkern.c                                           |    8 
 drivers/input/misc/uinput.c                                    |   14 
 drivers/iommu/intel/dmar.c                                     |    2 
 drivers/iommu/sun50i-iommu.c                                   |    1 
 drivers/irqchip/irq-armada-370-xp.c                            |    4 
 drivers/irqchip/irq-gic-v2m.c                                  |    6 
 drivers/leds/leds-spi-byte.c                                   |    6 
 drivers/md/dm-init.c                                           |    4 
 drivers/media/platform/qcom/camss/camss.c                      |    5 
 drivers/media/test-drivers/vivid/vivid-vid-cap.c               |   17 
 drivers/media/test-drivers/vivid/vivid-vid-out.c               |   16 
 drivers/media/usb/uvc/uvc_driver.c                             |   18 
 drivers/misc/vmw_vmci/vmci_resource.c                          |    3 
 drivers/mmc/host/cqhci.c                                       |    2 
 drivers/mmc/host/dw_mmc.c                                      |    4 
 drivers/mmc/host/sdhci-of-aspeed.c                             |    1 
 drivers/net/bareudp.c                                          |   22 -
 drivers/net/can/spi/mcp251x.c                                  |    2 
 drivers/net/dsa/vitesse-vsc73xx-core.c                         |   10 
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c                 |   20 -
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c             |   10 
 drivers/net/ethernet/intel/igb/igb_main.c                      |   10 
 drivers/net/ethernet/intel/igc/igc_main.c                      |    1 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                |    2 
 drivers/net/geneve.c                                           |    8 
 drivers/net/usb/ch9200.c                                       |    4 
 drivers/net/usb/cx82310_eth.c                                  |    5 
 drivers/net/usb/ipheth.c                                       |    4 
 drivers/net/usb/kaweth.c                                       |    3 
 drivers/net/usb/mcs7830.c                                      |    4 
 drivers/net/usb/qmi_wwan.c                                     |    1 
 drivers/net/usb/sierra_net.c                                   |    6 
 drivers/net/usb/sr9700.c                                       |    4 
 drivers/net/usb/sr9800.c                                       |    5 
 drivers/net/usb/usbnet.c                                       |   23 -
 drivers/net/virtio_net.c                                       |    8 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c |    1 
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c                |    3 
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h                |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                   |    6 
 drivers/net/wireless/marvell/mwifiex/main.h                    |    3 
 drivers/nvme/target/tcp.c                                      |    4 
 drivers/nvmem/core.c                                           |    6 
 drivers/of/irq.c                                               |   15 
 drivers/pci/controller/dwc/pci-keystone.c                      |   44 ++
 drivers/pci/controller/dwc/pcie-al.c                           |   16 
 drivers/pci/hotplug/pnv_php.c                                  |    3 
 drivers/pci/pci.c                                              |   35 +
 drivers/pcmcia/yenta_socket.c                                  |    6 
 drivers/platform/x86/dell-smbios-base.c                        |    5 
 drivers/staging/iio/frequency/ad9834.c                         |    2 
 drivers/uio/uio_hv_generic.c                                   |   11 
 drivers/usb/storage/uas.c                                      |    1 
 drivers/usb/typec/ucsi/ucsi.h                                  |    2 
 drivers/usb/usbip/stub_rx.c                                    |   77 ++-
 fs/btrfs/extent-tree.c                                         |   32 +
 fs/btrfs/inode.c                                               |    2 
 fs/btrfs/ioctl.c                                               |    5 
 fs/btrfs/transaction.c                                         |   24 +
 fs/btrfs/transaction.h                                         |    2 
 fs/ext4/page-io.c                                              |   14 
 fs/fuse/file.c                                                 |    8 
 fs/fuse/xattr.c                                                |    4 
 fs/lockd/svc.c                                                 |    3 
 fs/nfs/callback.c                                              |    3 
 fs/nfs/super.c                                                 |    2 
 fs/nfsd/export.c                                               |   32 +
 fs/nfsd/export.h                                               |    4 
 fs/nfsd/netns.h                                                |   25 +
 fs/nfsd/nfs4proc.c                                             |    6 
 fs/nfsd/nfscache.c                                             |  200 +++++-----
 fs/nfsd/nfsctl.c                                               |   24 -
 fs/nfsd/nfsd.h                                                 |    1 
 fs/nfsd/nfsfh.c                                                |    3 
 fs/nfsd/nfssvc.c                                               |   38 -
 fs/nfsd/stats.c                                                |   52 +-
 fs/nfsd/stats.h                                                |   85 +---
 fs/nfsd/trace.h                                                |   22 +
 fs/nfsd/vfs.c                                                  |    6 
 fs/nilfs2/recovery.c                                           |   35 +
 fs/nilfs2/segment.c                                            |   10 
 fs/nilfs2/sysfs.c                                              |  117 +++--
 fs/notify/fsnotify.c                                           |   31 +
 fs/notify/fsnotify.h                                           |    2 
 fs/notify/mark.c                                               |   32 +
 fs/squashfs/inode.c                                            |    7 
 fs/udf/super.c                                                 |   24 +
 include/linux/cgroup-defs.h                                    |  107 +----
 include/linux/cgroup.h                                         |   22 -
 include/linux/fsnotify_backend.h                               |    8 
 include/linux/hwspinlock.h                                     |    6 
 include/linux/i2c.h                                            |    2 
 include/linux/sunrpc/svc.h                                     |    5 
 include/net/bluetooth/hci_core.h                               |    5 
 kernel/cgroup/cgroup.c                                         |   65 +--
 kernel/dma/debug.c                                             |    5 
 kernel/events/core.c                                           |   18 
 kernel/events/internal.h                                       |    1 
 kernel/events/ring_buffer.c                                    |    2 
 kernel/events/uprobes.c                                        |    3 
 kernel/locking/rtmutex.c                                       |    4 
 kernel/rcu/tasks.h                                             |    2 
 kernel/smp.c                                                   |    1 
 kernel/trace/trace.c                                           |    2 
 lib/generic-radix-tree.c                                       |    2 
 mm/memcontrol.c                                                |   23 +
 net/8021q/vlan_core.c                                          |    7 
 net/bluetooth/mgmt.c                                           |   60 +--
 net/bluetooth/smp.c                                            |    7 
 net/bridge/br_fdb.c                                            |    6 
 net/can/bcm.c                                                  |    4 
 net/core/netclassid_cgroup.c                                   |    7 
 net/core/netprio_cgroup.c                                      |   10 
 net/ethernet/eth.c                                             |    7 
 net/ipv4/af_inet.c                                             |   19 
 net/ipv4/fou.c                                                 |   62 +--
 net/ipv4/gre_offload.c                                         |   12 
 net/ipv4/inet_hashtables.c                                     |    2 
 net/ipv4/tcp_bpf.c                                             |    2 
 net/ipv4/udp_offload.c                                         |    6 
 net/ipv6/ila/ila.h                                             |    1 
 net/ipv6/ila/ila_main.c                                        |    6 
 net/ipv6/ila/ila_xlat.c                                        |   13 
 net/ipv6/ip6_offload.c                                         |   14 
 net/ipv6/udp_offload.c                                         |    2 
 net/mptcp/options.c                                            |   34 -
 net/mptcp/pm.c                                                 |   24 -
 net/mptcp/pm_netlink.c                                         |   59 +-
 net/mptcp/protocol.c                                           |   54 +-
 net/mptcp/protocol.h                                           |    4 
 net/mptcp/subflow.c                                            |   50 +-
 net/netfilter/nf_conncount.c                                   |    8 
 net/sched/sch_cake.c                                           |   11 
 net/sched/sch_netem.c                                          |    9 
 net/sunrpc/stats.c                                             |    2 
 net/sunrpc/svc.c                                               |   36 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c                              |    2 
 net/sunrpc/xprtsock.c                                          |    7 
 net/unix/af_unix.c                                             |    9 
 net/wireless/scan.c                                            |   46 +-
 security/apparmor/apparmorfs.c                                 |    4 
 security/smack/smack_lsm.c                                     |   14 
 sound/hda/hdmi_chmap.c                                         |   18 
 sound/pci/hda/hda_generic.c                                    |   63 +++
 sound/pci/hda/hda_generic.h                                    |    1 
 sound/pci/hda/patch_conexant.c                                 |   13 
 sound/pci/hda/patch_realtek.c                                  |   10 
 sound/soc/soc-dapm.c                                           |    1 
 sound/soc/soc-topology.c                                       |    2 
 tools/lib/bpf/libbpf.c                                         |    4 
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c             |    4 
 206 files changed, 1799 insertions(+), 1097 deletions(-)

Abhishek Pandit-Subedi (1):
      usb: typec: ucsi: Fix null pointer dereference in trace

Aleksandr Mishin (3):
      PCI: al: Check IORESOURCE_BUS existence during probe
      platform/x86: dell-smbios: Fix error path in dell_smbios_init()
      staging: iio: frequency: ad9834: Validate frequency parameter value

Alex Hung (4):
      drm/amd/display: Check gpio_id before used as array index
      drm/amd/display: Check num_valid_sets before accessing reader_wm_sets[]
      drm/amd/display: Check msg_id before processing transcation
      drm/amd/display: Skip wbscl_set_scaler_filter if filter is null

Amadeusz Sławiński (1):
      ASoC: topology: Properly initialize soc_enum values

Amir Goldstein (1):
      fsnotify: clear PARENT_WATCHED flags lazily

Andreas Ziegler (1):
      libbpf: Add NULL checks to bpf_object__{prev_map,next_map}

Andy Shevchenko (3):
      leds: spi-byte: Call of_node_put() on error path
      drm/i915/fence: Mark debug_fence_init_onstack() with __maybe_unused
      drm/i915/fence: Mark debug_fence_free() with __maybe_unused

Arend van Spriel (1):
      wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3

Benjamin Marzinski (1):
      dm init: Handle minors larger than 255

Bob Zhou (1):
      drm/amd/pm: Fix the null pointer dereference for vega10_hwmgr

Breno Leitao (1):
      virtio_net: Fix napi_skb_cache_put warning

Camila Alvarez (1):
      HID: cougar: fix slab-out-of-bounds Read in cougar_report_fixup

Carlos Llamas (1):
      binder: fix UAF caused by offsets overwrite

Casey Schaufler (1):
      smack: tcp: ipv4, fix incorrect labeling

Chen Ni (1):
      media: qcom: camss: Add check for v4l2_fwnode_endpoint_parse

Christoffer Sandberg (1):
      ALSA: hda/conexant: Add pincfg quirk to enable top speakers on Sirius devices

Christoph Hellwig (2):
      block: remove the blk_flush_integrity call in blk_integrity_unregister
      block: initialize integrity buffer to zero before writing it to media

Chuck Lever (7):
      NFSD: Refactor nfsd_reply_cache_free_locked()
      NFSD: Rename nfsd_reply_cache_alloc()
      NFSD: Replace nfsd_prune_bucket()
      NFSD: Refactor the duplicate reply cache shrinker
      NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
      NFSD: Fix frame size warning in svc_export_parse()
      svcrdma: Catch another Reply chunk overflow case

Cong Wang (1):
      tcp_bpf: fix return value of tcp_bpf_sendmsg()

Connor O'Brien (2):
      bpf, cgroups: Fix cgroup v2 fallback on v1/v2 mixed mode
      bpf, cgroup: Assign cgroup in cgroup_sk_alloc when called from interrupt

Daiwei Li (1):
      igb: Fix not clearing TimeSync interrupts for 82580

Dan Carpenter (1):
      igc: Unlock on error in igc_io_resume()

Dan Williams (1):
      PCI: Add missing bridge lock to pci_bus_lock()

Daniel Borkmann (1):
      net, sunrpc: Remap EPERM in case of connection failure in xs_tcp_setup_socket

Daniel Lezcano (1):
      clocksource/drivers/timer-of: Remove percpu irq related code

David Fernandez Gonzalez (1):
      VMCI: Fix use-after-free when removing resource in vmci_resource_remove()

David Lechner (1):
      iio: buffer-dmaengine: fix releasing dma channel on error

David Sterba (1):
      btrfs: initialize location to fix -Wmaybe-uninitialized in btrfs_lookup_dentry()

Dmitry Torokhov (1):
      Input: uinput - reject requests with unreasonable number of slots

Dumitru Ceclan (1):
      iio: adc: ad7124: fix chip ID mismatch

Eric Dumazet (4):
      ila: call nf_unregister_net_hooks() sooner
      fou: remove sparse errors
      gro: remove rcu_read_lock/rcu_read_unlock from gro_receive handlers
      gro: remove rcu_read_lock/rcu_read_unlock from gro_complete handlers

Filipe Manana (1):
      btrfs: fix use-after-free after failure to create a snapshot

Geert Uytterhoeven (1):
      nvmem: Fix return type of devm_nvmem_device_get() in kerneldoc

Greg Kroah-Hartman (1):
      Linux 5.10.226

Guenter Roeck (4):
      hwmon: (adc128d818) Fix underflows seen when writing limit attributes
      hwmon: (lm95234) Fix underflows seen when writing limit attributes
      hwmon: (nct6775-core) Fix underflows seen when writing limit attributes
      hwmon: (w83627ehf) Fix underflows seen when writing limit attributes

Guillaume Nault (1):
      bareudp: Fix device stats updates.

Hans Verkuil (2):
      media: vivid: fix wrong sizeimage value for mplane
      media: vivid: don't set HDMI TX controls if there are no HDMI outputs

Haoran Liu (1):
      drm/meson: plane: Add error handling

Heiko Carstens (1):
      s390/vmlinux.lds.S: Move ro_after_init section behind rodata section

Hersen Wu (3):
      drm/amd/display: Stop amdgpu_dm initialize when stream nums greater than 6
      drm/amd/display: Add array index check for hdcp ddc access
      drm/amd/display: Fix Coverity INTEGER_OVERFLOW within dal_gpio_service_create

Jacky Bai (2):
      clocksource/drivers/imx-tpm: Fix return -ETIME when delta exceeds INT_MAX
      clocksource/drivers/imx-tpm: Fix next event not taking effect sometime

Jacob Pan (1):
      iommu/vt-d: Handle volatile descriptor status read

Jakub Kicinski (1):
      net: usb: don't write directly to netdev->dev_addr

James Morse (1):
      arm64: acpi: Move get_cpu_for_acpi_id() to a header

Jan Kara (3):
      udf: Limit file size to 4TB
      ext4: handle redirtying in ext4_bio_write_page()
      udf: Avoid excessive partition lengths

Jann Horn (1):
      fuse: use unsigned type for getxattr/listxattr size truncation

Jeff Layton (2):
      nfsd: move reply cache initialization into nfsd startup
      nfsd: move init of percpu reply_cache_stats counters back to nfsd_init_net

Jernej Skrabec (1):
      iommu: sun50i: clear bypass register

Jesse Zhang (4):
      drm/amd/pm: fix warning using uninitialized value of max_vid_step
      drm/amd/pm: fix the Out-of-bounds read warning
      drm/amdgpu: the warning dereferencing obj for nbio_v7_4
      drm/amd/pm: check negtive return for table entries

Jiaxun Yang (1):
      MIPS: cevt-r4k: Don't call get_c0_compare_int if timer irq is installed

Joanne Koong (1):
      fuse: update stats for pages in dropped aux writeback list

Johannes Berg (2):
      wifi: cfg80211: make hash table duplicates more survivable
      um: line: always fill *error_out in setup_one_line()

Jonas Gorski (1):
      net: bridge: br_fdb_external_learn_add(): always set EXT_LEARN

Jonathan Cameron (3):
      ACPI: processor: Return an error if acpi_processor_get_info() fails in processor_add()
      ACPI: processor: Fix memory leaks in error paths of processor_add()
      arm64: acpi: Harden get_cpu_for_acpi_id() against missing CPU entry

Josef Bacik (12):
      sunrpc: don't change ->sv_stats if it doesn't exist
      nfsd: stop setting ->pg_stats for unused stats
      sunrpc: pass in the sv_stats struct through svc_create_pooled
      sunrpc: remove ->pg_stats from svc_program
      sunrpc: use the struct net as the svc proc private
      nfsd: rename NFSD_NET_* to NFSD_STATS_*
      nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
      nfsd: make all of the nfsd stats per-network namespace
      nfsd: remove nfsd_stats, make th_cnt a global counter
      nfsd: make svc_stat per-network namespace instead of global
      btrfs: replace BUG_ON with ASSERT in walk_down_proc()
      btrfs: clean up our handling of refs == 0 in snapshot delete

Jules Irenge (1):
      pcmcia: Use resource_size function on resource object

Kent Overstreet (1):
      lib/generic-radix-tree.c: Fix rare race in __genradix_ptr_alloc()

Kishon Vijay Abraham I (1):
      PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)

Konstantin Andreev (1):
      smack: unix sockets: fix accept()ed socket label

Krishna Kumar (1):
      pci/hotplug/pnv_php: Fix hotplug driver crash on Powernv

Kuniyuki Iwashima (3):
      af_unix: Remove put_pid()/put_cred() in copy_peercred().
      can: bcm: Remove proc entry when dev is unregistered.
      fou: Fix null-ptr-deref in GRO.

Leesoo Ahn (1):
      apparmor: fix possible NULL pointer dereference

Len Baker (1):
      drivers/net/usb: Remove all strcpy() uses

Liao Chen (1):
      mmc: sdhci-of-aspeed: fix module autoloading

Luiz Augusto von Dentz (2):
      Revert "Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE"
      Bluetooth: MGMT: Ignore keys being loaded with invalid type

Ma Jun (5):
      drm/amdgpu: Fix uninitialized variable warning in amdgpu_afmt_acr
      drm/amdgpu/pm: Fix uninitialized variable agc_btc_response
      drm/amdgpu: Fix out-of-bounds write warning
      drm/amdgpu: Fix out-of-bounds read of df_v1_7_channel_number
      drm/amdgpu/pm: Check input value for CUSTOM profile mode setting on legacy SOCs

Ma Ke (1):
      irqchip/gic-v2m: Fix refcount leak in gicv2m_of_init()

Matteo Martelli (1):
      iio: fix scale application in iio_convert_raw_to_processed_unlocked

Matthieu Baerts (NGI0) (2):
      mptcp: pr_debug: add missing \n at the end
      mptcp: pm: avoid possible UaF when selecting endp

Maurizio Lombardi (1):
      nvmet-tcp: fix kernel crash if commands allocation fails

Maximilien Perreault (1):
      ALSA: hda/realtek: Support mute LED on HP Laptop 14-dq2xxx

Michael Chen (1):
      drm/amdkfd: Reconcile the definition and use of oem_id in struct kfd_topology_device

Michael Ellerman (1):
      ata: pata_macio: Use WARN instead of BUG

Naman Jain (1):
      Drivers: hv: vmbus: Fix rescind handling in uio_hv_generic

NeilBrown (1):
      NFSD: simplify error paths in nfsd_svc()

Nikita Kiryushin (1):
      rcu-tasks: Fix show_rcu_tasks_trace_gp_kthread buffer overflow

Oliver Neukum (2):
      usbnet: modern method to get random MAC
      usbnet: ipheth: race between ipheth_close and error handling

Pali Rohár (1):
      irqchip/armada-370-xp: Do not allow mapping IRQ 0 and 1

Pawel Dembicki (1):
      net: dsa: vsc73xx: fix possible subblocks range of CAPT block

Peter Zijlstra (1):
      perf/aux: Fix AUX buffer serialization

Philip Mueller (1):
      drm: panel-orientation-quirks: Add quirk for OrangePi Neo

Phillip Lougher (1):
      Squashfs: sanity check symbolic link size

Qing Wang (1):
      nilfs2: replace snprintf in show functions with sysfs_emit

Ricardo Ribalda (1):
      media: uvcvideo: Enforce alignment of frame and interval

Richard Fitzgerald (2):
      i2c: Fix conditional for substituting empty ACPI functions
      i2c: Use IS_REACHABLE() for substituting empty ACPI functions

Richard Maina (1):
      hwspinlock: Introduce hwspin_lock_bust()

Rik van Riel (1):
      dma-debug: avoid deadlock between dma debug vs printk and netconsole

Roland Xu (1):
      rtmutex: Drop rt_mutex::wait_lock before scheduling

Ryusuke Konishi (3):
      nilfs2: fix missing cleanup on rollforward recovery error
      nilfs2: fix state management in error path of log writing function
      nilfs2: protect references to superblock parameters exposed in sysfs

Sam Protsenko (1):
      mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K

Sascha Hauer (1):
      wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()

Satya Priya Kakitapalli (2):
      clk: qcom: clk-alpha-pll: Fix the pll post div mask
      clk: qcom: clk-alpha-pll: Fix the trion pll postdiv set rate API

Saurabh Sengar (1):
      uio_hv_generic: Fix kernel NULL pointer dereference in hv_uio_rescind

Seunghwan Baek (1):
      mmc: cqhci: Fix checking of CQHCI_HALT state

Shahar S Matityahu (1):
      wifi: iwlwifi: remove fw_running op

Shakeel Butt (1):
      memcg: protect concurrent access to mem_cgroup_idr

Shannon Nelson (1):
      ionic: fix potential irq name truncation

Shantanu Goel (1):
      usb: uas: set host status byte on data completion error

Simon Arlott (1):
      can: mcp251x: fix deadlock if an interrupt occurs during mcp251x_open

Simon Holesch (1):
      usbip: Don't submit special requests twice

Stanislav Fomichev (1):
      net: set SOCK_RCU_FREE before inserting socket into hashtable

Stefan Wiehler (1):
      of/irq: Prevent device address out-of-bounds read in interrupt map walk

Stephen Hemminger (1):
      sch/netem: fix use after free in netem_dequeue

Sven Schnelle (1):
      uprobes: Use kzalloc to allocate xol area

Takashi Iwai (3):
      ALSA: hda/generic: Add a helper to mute speakers at suspend/shutdown
      ALSA: hda/conexant: Mute speakers at suspend / shutdown
      ALSA: hda: Add input value sanity checks to HDMI channel map controls

Terry Cheong (1):
      ALSA: hda/realtek: add patch for internal mic in Lenovo V145

Thomas Gleixner (1):
      x86/mm: Fix PTI for i386 some more

Tim Huang (6):
      drm/amdgpu: fix overflowed array index read warning
      drm/amd/pm: fix uninitialized variable warning for smu8_hwmgr
      drm/amdgpu: fix uninitialized scalar variable warning
      drm/amd/pm: fix uninitialized variable warnings for vega10_hwmgr
      drm/amdgpu: fix ucode out-of-bounds read warning
      drm/amdgpu: fix mc_data out-of-bounds read warning

Toke Høiland-Jørgensen (1):
      sched: sch_cake: fix bulk flow accounting logic for host fairness

Trond Myklebust (1):
      NFSv4: Add missing rescheduling points in nfs_client_return_marked_delegations

Vladimir Oltean (1):
      net: dpaa: avoid on-stack arrays of NR_CPUS elements

Waiman Long (1):
      cgroup: Protect css->cgroup write under css_set_lock

Yunjian Wang (1):
      netfilter: nf_conncount: fix wrong variable type

ZHANG Yuntian (1):
      net: usb: qmi_wwan: add MeiG Smart SRM825L

Zenghui Yu (1):
      kselftests: dmabuf-heaps: Ensure the driver name is null-terminated

Zheng Qixing (1):
      ata: libata: Fix memory leak for error path in ata_host_alloc()

Zheng Yejian (1):
      tracing: Avoid possible softlockup in tracing_iter_reset()

Zhigang Luo (1):
      drm/amdgpu: avoid reading vf2pf info size from FB

Zijun Hu (1):
      devres: Initialize an uninitialized struct member

Zqiang (1):
      smp: Add missing destroy_work_on_stack() call in smp_call_on_cpu()

robelin (1):
      ASoC: dapm: Fix UAF for snd_soc_pcm_runtime object


