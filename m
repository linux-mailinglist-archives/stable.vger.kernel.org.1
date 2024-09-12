Return-Path: <stable+bounces-75990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CED6976832
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 13:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30562832D5
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 11:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121FD1A262B;
	Thu, 12 Sep 2024 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1gAhdQ1V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33871A0BFF;
	Thu, 12 Sep 2024 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141726; cv=none; b=pr5Jxdpi7aqbHA/ADk5sM+T0Y9BpiqEx+T9IYlDTG1B8K7Bq408xLvYFkCPuHlc9+OUG9w6n3+iMA/BtV8YvBOK5vp6nM2k09g7Sd7FrsR9M9MsxEY59OkIQEwhZzGvleNz2+BvfVZjdxSvEgUIQ7zg7/AmdRjtR1J0ksGtt2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141726; c=relaxed/simple;
	bh=udUZLsGhFYeljvsSbGNSRiL2G41IISjx8uNgVlyrV5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kGDxtYHn2us0PDP/bKQSdUepNGrqO2bW7Gvg3/cbFcccoPLN6dw9k32HGrRrLgD/DrKxXL/0PnkzF/rMrs5Wq8kHCeaBhIDVUWlLEVCjljViOhKI8gwcgcEVXp/8P9D7uZy0CMmW49XlVGL4CKCZZvLsseSWOQ0lT46ClTvWiTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1gAhdQ1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D78EC4CEC3;
	Thu, 12 Sep 2024 11:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726141726;
	bh=udUZLsGhFYeljvsSbGNSRiL2G41IISjx8uNgVlyrV5E=;
	h=From:To:Cc:Subject:Date:From;
	b=1gAhdQ1VvaYuwEQBHG+Ih7bl+4sAj/l7ImDqctIZnFKgzakxi1VS74sRQWnXT/Cj8
	 xXfNtGJ3PLm1vm6+eUmikNWes1XgwkAN25GWS/x18XFtKKPEBywpTBDmr+vVSvYh5b
	 CnZeZKqxwL5AYNMFIl1jdJSxRrNPxpT2E63yLAAY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.110
Date: Thu, 12 Sep 2024 13:48:34 +0200
Message-ID: <2024091235-unharmed-depress-a08d@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.110 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm64/include/asm/acpi.h                                  |   12 
 arch/arm64/kernel/acpi_numa.c                                  |   11 
 arch/mips/kernel/cevt-r4k.c                                    |   15 
 arch/powerpc/include/asm/nohash/mmu-e500.h                     |    3 
 arch/powerpc/mm/nohash/Makefile                                |    2 
 arch/powerpc/mm/nohash/tlb.c                                   |  398 ----------
 arch/powerpc/mm/nohash/tlb_64e.c                               |  361 +++++++++
 arch/powerpc/mm/nohash/tlb_low_64e.S                           |  195 ----
 arch/riscv/kernel/head.S                                       |    3 
 arch/s390/kernel/vmlinux.lds.S                                 |    9 
 arch/um/drivers/line.c                                         |    2 
 arch/x86/coco/tdx/tdx.c                                        |    1 
 arch/x86/events/intel/core.c                                   |   23 
 arch/x86/include/asm/fpu/types.h                               |    7 
 arch/x86/include/asm/page_64.h                                 |    1 
 arch/x86/include/asm/pgtable_64_types.h                        |    4 
 arch/x86/kernel/fpu/xstate.c                                   |    3 
 arch/x86/kernel/fpu/xstate.h                                   |    4 
 arch/x86/kvm/svm/svm.c                                         |   15 
 arch/x86/kvm/x86.c                                             |    2 
 arch/x86/lib/iomem.c                                           |    5 
 arch/x86/mm/init_64.c                                          |    4 
 arch/x86/mm/kaslr.c                                            |   32 
 arch/x86/mm/pti.c                                              |   45 -
 drivers/acpi/acpi_processor.c                                  |   15 
 drivers/android/binder.c                                       |    1 
 drivers/ata/libata-core.c                                      |    4 
 drivers/ata/pata_macio.c                                       |    7 
 drivers/base/devres.c                                          |    1 
 drivers/block/ublk_drv.c                                       |    2 
 drivers/clk/qcom/clk-alpha-pll.c                               |    6 
 drivers/clocksource/timer-imx-tpm.c                            |   16 
 drivers/clocksource/timer-of.c                                 |   17 
 drivers/clocksource/timer-of.h                                 |    1 
 drivers/crypto/qat/qat_common/adf_gen2_pfvf.c                  |    4 
 drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c         |    8 
 drivers/firmware/cirrus/cs_dsp.c                               |    3 
 drivers/gpio/gpio-rockchip.c                                   |    1 
 drivers/gpio/gpio-zynqmp-modepin.c                             |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c                    |   30 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                       |    4 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                         |    8 
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c                           |   28 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |    2 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c     |   15 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                      |    6 
 drivers/gpu/drm/i915/i915_sw_fence.c                           |    8 
 drivers/hid/amd-sfh-hid/amd_sfh_hid.c                          |    4 
 drivers/hid/hid-cougar.c                                       |    2 
 drivers/hv/vmbus_drv.c                                         |    1 
 drivers/hwmon/adc128d818.c                                     |    4 
 drivers/hwmon/lm95234.c                                        |    9 
 drivers/hwmon/nct6775-core.c                                   |    2 
 drivers/hwmon/w83627ehf.c                                      |    4 
 drivers/i3c/master/mipi-i3c-hci/dma.c                          |    5 
 drivers/iio/adc/ad7124.c                                       |   27 
 drivers/iio/adc/ad7606.c                                       |   28 
 drivers/iio/adc/ad7606.h                                       |    2 
 drivers/iio/adc/ad7606_par.c                                   |   48 +
 drivers/iio/buffer/industrialio-buffer-dmaengine.c             |    4 
 drivers/iio/inkern.c                                           |    8 
 drivers/input/misc/uinput.c                                    |   14 
 drivers/input/touchscreen/ili210x.c                            |    6 
 drivers/iommu/intel/dmar.c                                     |    2 
 drivers/iommu/sun50i-iommu.c                                   |    1 
 drivers/irqchip/irq-armada-370-xp.c                            |    4 
 drivers/irqchip/irq-gic-v2m.c                                  |    6 
 drivers/leds/leds-spi-byte.c                                   |    6 
 drivers/md/dm-init.c                                           |    4 
 drivers/media/platform/qcom/camss/camss.c                      |    5 
 drivers/media/test-drivers/vivid/vivid-vid-cap.c               |   17 
 drivers/media/test-drivers/vivid/vivid-vid-out.c               |   16 
 drivers/misc/vmw_vmci/vmci_resource.c                          |    3 
 drivers/mmc/core/quirks.h                                      |   22 
 drivers/mmc/core/sd.c                                          |    4 
 drivers/mmc/host/cqhci-core.c                                  |    2 
 drivers/mmc/host/dw_mmc.c                                      |    4 
 drivers/mmc/host/sdhci-of-aspeed.c                             |    1 
 drivers/net/bareudp.c                                          |   22 
 drivers/net/can/m_can/m_can.c                                  |    5 
 drivers/net/can/spi/mcp251x.c                                  |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c                 |   28 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ram.c                  |   11 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c                 |   23 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c                   |  165 ++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c                  |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c            |   22 
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h                      |   42 -
 drivers/net/dsa/vitesse-vsc73xx-core.c                         |   10 
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c                 |   20 
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c             |   10 
 drivers/net/ethernet/intel/ice/ice_main.c                      |   61 -
 drivers/net/ethernet/intel/igb/igb_main.c                      |   10 
 drivers/net/ethernet/intel/igc/igc_main.c                      |    1 
 drivers/net/ethernet/microsoft/mana/mana.h                     |    2 
 drivers/net/ethernet/microsoft/mana/mana_en.c                  |   22 
 drivers/net/mctp/mctp-serial.c                                 |    4 
 drivers/net/usb/ipheth.c                                       |    2 
 drivers/net/usb/usbnet.c                                       |   11 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c |    1 
 drivers/net/wireless/marvell/mwifiex/main.h                    |    3 
 drivers/nvme/host/pci.c                                        |   11 
 drivers/nvme/target/tcp.c                                      |    4 
 drivers/nvmem/core.c                                           |    6 
 drivers/of/irq.c                                               |   15 
 drivers/pci/controller/dwc/pci-keystone.c                      |   44 +
 drivers/pci/hotplug/pnv_php.c                                  |    3 
 drivers/pci/pci.c                                              |   35 
 drivers/pcmcia/yenta_socket.c                                  |    6 
 drivers/phy/xilinx/phy-zynqmp.c                                |    1 
 drivers/platform/x86/dell/dell-smbios-base.c                   |    5 
 drivers/regulator/of_regulator.c                               |   92 ++
 drivers/spi/spi-rockchip.c                                     |   23 
 drivers/staging/iio/frequency/ad9834.c                         |    2 
 drivers/uio/uio_hv_generic.c                                   |   11 
 drivers/usb/dwc3/core.c                                        |   15 
 drivers/usb/dwc3/core.h                                        |    2 
 drivers/usb/gadget/udc/aspeed_udc.c                            |    2 
 drivers/usb/storage/uas.c                                      |    1 
 fs/binfmt_elf.c                                                |    5 
 fs/btrfs/ctree.c                                               |   12 
 fs/btrfs/ctree.h                                               |    1 
 fs/btrfs/extent-tree.c                                         |   32 
 fs/btrfs/file.c                                                |   25 
 fs/btrfs/inode.c                                               |    2 
 fs/btrfs/transaction.h                                         |    6 
 fs/ext4/fast_commit.c                                          |    8 
 fs/fuse/dev.c                                                  |    6 
 fs/fuse/dir.c                                                  |   72 +
 fs/fuse/file.c                                                 |   51 +
 fs/fuse/fuse_i.h                                               |    8 
 fs/fuse/inode.c                                                |    3 
 fs/fuse/xattr.c                                                |    4 
 fs/nfs/super.c                                                 |    2 
 fs/nilfs2/recovery.c                                           |   35 
 fs/nilfs2/segment.c                                            |   10 
 fs/nilfs2/sysfs.c                                              |   43 -
 fs/ntfs3/dir.c                                                 |   52 -
 fs/ntfs3/frecord.c                                             |    4 
 fs/smb/client/smb2ops.c                                        |   16 
 fs/smb/server/smb2pdu.c                                        |    4 
 fs/smb/server/transport_tcp.c                                  |    4 
 fs/squashfs/inode.c                                            |    7 
 fs/udf/super.c                                                 |   15 
 include/linux/mm.h                                             |    4 
 include/linux/regulator/consumer.h                             |   16 
 include/net/bluetooth/hci_core.h                               |    5 
 include/uapi/drm/drm_fourcc.h                                  |   18 
 include/uapi/linux/fuse.h                                      |   46 +
 io_uring/io-wq.c                                               |   16 
 io_uring/sqpoll.c                                              |    1 
 kernel/bpf/btf.c                                               |   13 
 kernel/cgroup/cgroup.c                                         |    2 
 kernel/dma/map_benchmark.c                                     |   16 
 kernel/events/core.c                                           |   18 
 kernel/events/internal.h                                       |    1 
 kernel/events/ring_buffer.c                                    |    2 
 kernel/events/uprobes.c                                        |    3 
 kernel/locking/rtmutex.c                                       |    9 
 kernel/resource.c                                              |    6 
 kernel/smp.c                                                   |    1 
 kernel/trace/trace.c                                           |    2 
 kernel/workqueue.c                                             |   12 
 lib/generic-radix-tree.c                                       |    2 
 mm/memcontrol.c                                                |   22 
 mm/memory_hotplug.c                                            |    2 
 mm/sparse.c                                                    |    2 
 net/bluetooth/mgmt.c                                           |   60 -
 net/bluetooth/smp.c                                            |    7 
 net/bridge/br_fdb.c                                            |    6 
 net/can/bcm.c                                                  |    4 
 net/ipv4/fou.c                                                 |   29 
 net/ipv4/tcp_bpf.c                                             |    2 
 net/ipv4/tcp_input.c                                           |    6 
 net/ipv6/ila/ila.h                                             |    1 
 net/ipv6/ila/ila_main.c                                        |    6 
 net/ipv6/ila/ila_xlat.c                                        |   13 
 net/netfilter/nf_conncount.c                                   |    8 
 net/sched/sch_cake.c                                           |   11 
 net/sched/sch_netem.c                                          |    9 
 net/unix/af_unix.c                                             |    9 
 rust/Makefile                                                  |    4 
 security/smack/smack_lsm.c                                     |   12 
 sound/core/control.c                                           |    6 
 sound/hda/hdmi_chmap.c                                         |   18 
 sound/pci/hda/patch_conexant.c                                 |   11 
 sound/pci/hda/patch_realtek.c                                  |   10 
 sound/soc/soc-dapm.c                                           |    1 
 sound/soc/soc-topology.c                                       |    2 
 sound/soc/sof/topology.c                                       |    2 
 sound/soc/sunxi/sun4i-i2s.c                                    |  143 +--
 sound/soc/tegra/tegra210_ahub.c                                |   10 
 tools/lib/bpf/libbpf.c                                         |    4 
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c             |    4 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                |  234 ++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh                 |   15 
 197 files changed, 2263 insertions(+), 1399 deletions(-)

Aleksandr Mishin (2):
      platform/x86: dell-smbios: Fix error path in dell_smbios_init()
      staging: iio: frequency: ad9834: Validate frequency parameter value

Alex Deucher (1):
      Revert "drm/amdgpu: align pp_power_profile_mode with kernel docs"

Alex Hung (2):
      drm/amd/display: Check HDCP returned status
      drm/amd/display: Check denominator pbn_div before used

Alexey Dobriyan (1):
      ELF: fix kernel.randomize_va_space double read

Amadeusz Sławiński (1):
      ASoC: topology: Properly initialize soc_enum values

Andreas Hindborg (1):
      rust: kbuild: fix export of bss symbols

Andreas Ziegler (1):
      libbpf: Add NULL checks to bpf_object__{prev_map,next_map}

Andy Shevchenko (3):
      leds: spi-byte: Call of_node_put() on error path
      drm/i915/fence: Mark debug_fence_init_onstack() with __maybe_unused
      drm/i915/fence: Mark debug_fence_free() with __maybe_unused

Arend van Spriel (1):
      wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3

Aurabindo Pillai (1):
      drm/amd: Add gfx12 swizzle mode defs

Benjamin Marzinski (1):
      dm init: Handle minors larger than 255

Brian Johannesmeyer (1):
      x86/kmsan: Fix hook for unaligned accesses

Brian Norris (1):
      spi: rockchip: Resolve unbalanced runtime PM / system PM handling

Camila Alvarez (1):
      HID: cougar: fix slab-out-of-bounds Read in cougar_report_fixup

Carlos Llamas (1):
      binder: fix UAF caused by offsets overwrite

Chen Ni (1):
      media: qcom: camss: Add check for v4l2_fwnode_endpoint_parse

Chen-Yu Tsai (1):
      ASoc: SOF: topology: Clear SOF link platform name upon unload

Christoffer Sandberg (1):
      ALSA: hda/conexant: Add pincfg quirk to enable top speakers on Sirius devices

Christophe Leroy (1):
      powerpc/64e: Define mmu_pte_psize static

Cong Wang (1):
      tcp_bpf: fix return value of tcp_bpf_sendmsg()

Corentin Labbe (1):
      regulator: Add of_regulator_bulk_get_all

Daiwei Li (1):
      igb: Fix not clearing TimeSync interrupts for 82580

Dan Carpenter (2):
      ksmbd: Unlock on in ksmbd_tcp_set_interfaces()
      igc: Unlock on error in igc_io_resume()

Dan Williams (1):
      PCI: Add missing bridge lock to pci_bus_lock()

Daniel Lezcano (1):
      clocksource/drivers/timer-of: Remove percpu irq related code

Danijel Slivka (1):
      drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts

David Fernandez Gonzalez (1):
      VMCI: Fix use-after-free when removing resource in vmci_resource_remove()

David Howells (1):
      cifs: Fix FALLOC_FL_ZERO_RANGE to preflush buffered part of target region

David Lechner (1):
      iio: buffer-dmaengine: fix releasing dma channel on error

David Sterba (1):
      btrfs: initialize location to fix -Wmaybe-uninitialized in btrfs_lookup_dentry()

Dawid Osuchowski (1):
      ice: Add netif_device_attach/detach into PF reset flow

Dharmendra Singh (1):
      fuse: allow non-extending parallel direct writes on the same file

Dmitry Torokhov (2):
      Input: ili210x - use kvmalloc() to allocate buffer for firmware update
      Input: uinput - reject requests with unreasonable number of slots

Douglas Anderson (1):
      regulator: core: Stub devm_regulator_bulk_get_const() if !CONFIG_REGULATOR

Dumitru Ceclan (2):
      iio: adc: ad7124: fix config comparison
      iio: adc: ad7124: fix chip ID mismatch

Eric Dumazet (1):
      ila: call nf_unregister_net_hooks() sooner

Faisal Hassan (1):
      usb: dwc3: core: update LC timer as per USB Spec V3.2

Filipe Manana (2):
      btrfs: replace BUG_ON() with error handling at update_ref_for_cow()
      btrfs: fix race between direct IO write and fsync when using same fd

Geert Uytterhoeven (1):
      nvmem: Fix return type of devm_nvmem_device_get() in kerneldoc

Georg Gottleuber (1):
      nvme-pci: Add sleep quirk for Samsung 990 Evo

Greg Kroah-Hartman (1):
      Linux 6.1.110

Guenter Roeck (4):
      hwmon: (adc128d818) Fix underflows seen when writing limit attributes
      hwmon: (lm95234) Fix underflows seen when writing limit attributes
      hwmon: (nct6775-core) Fix underflows seen when writing limit attributes
      hwmon: (w83627ehf) Fix underflows seen when writing limit attributes

Guillaume Nault (1):
      bareudp: Fix device stats updates.

Guillaume Stols (1):
      iio: adc: ad7606: remove frstdata check for serial mode

Hans Verkuil (2):
      media: vivid: fix wrong sizeimage value for mplane
      media: vivid: don't set HDMI TX controls if there are no HDMI outputs

Hareshx Sankar Raj (1):
      crypto: qat - fix unintentional re-enabling of error interrupts

Hawking Zhang (1):
      drm/amdgpu: Fix smatch static checker warning

Heiko Carstens (1):
      s390/vmlinux.lds.S: Move ro_after_init section behind rodata section

Jacky Bai (2):
      clocksource/drivers/imx-tpm: Fix return -ETIME when delta exceeds INT_MAX
      clocksource/drivers/imx-tpm: Fix next event not taking effect sometime

Jacob Pan (1):
      iommu/vt-d: Handle volatile descriptor status read

James Morse (1):
      arm64: acpi: Move get_cpu_for_acpi_id() to a header

Jan Kara (1):
      udf: Avoid excessive partition lengths

Jann Horn (1):
      fuse: use unsigned type for getxattr/listxattr size truncation

Jarkko Nikula (1):
      i3c: mipi-i3c-hci: Error out instead on BUG_ON() in IBI DMA setup

Jens Axboe (1):
      io_uring/io-wq: stop setting PF_NO_SETAFFINITY on io-wq workers

Jernej Skrabec (1):
      iommu: sun50i: clear bypass register

Jiaxun Yang (1):
      MIPS: cevt-r4k: Don't call get_c0_compare_int if timer irq is installed

Joanne Koong (1):
      fuse: update stats for pages in dropped aux writeback list

Johannes Berg (1):
      um: line: always fill *error_out in setup_one_line()

Jonas Gorski (1):
      net: bridge: br_fdb_external_learn_add(): always set EXT_LEARN

Jonathan Bell (1):
      mmc: core: apply SD quirks earlier during probe

Jonathan Cameron (3):
      ACPI: processor: Return an error if acpi_processor_get_info() fails in processor_add()
      ACPI: processor: Fix memory leaks in error paths of processor_add()
      arm64: acpi: Harden get_cpu_for_acpi_id() against missing CPU entry

Josef Bacik (2):
      btrfs: replace BUG_ON with ASSERT in walk_down_proc()
      btrfs: clean up our handling of refs == 0 in snapshot delete

Jules Irenge (1):
      pcmcia: Use resource_size function on resource object

Kan Liang (1):
      perf/x86/intel: Limit the period on Haswell

Kent Overstreet (1):
      lib/generic-radix-tree.c: Fix rare race in __genradix_ptr_alloc()

Kirill A. Shutemov (1):
      x86/tdx: Fix data leak in mmio_read()

Kishon Vijay Abraham I (1):
      PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)

Konstantin Andreev (1):
      smack: unix sockets: fix accept()ed socket label

Konstantin Komarov (2):
      fs/ntfs3: One more reason to mark inode bad
      fs/ntfs3: Check more cases when directory is corrupted

Krishna Kumar (1):
      pci/hotplug/pnv_php: Fix hotplug driver crash on Powernv

Krzysztof Kozlowski (1):
      gpio: rockchip: fix OF node leak in probe()

Kuniyuki Iwashima (4):
      af_unix: Remove put_pid()/put_cred() in copy_peercred().
      can: bcm: Remove proc entry when dev is unregistered.
      fou: Fix null-ptr-deref in GRO.
      tcp: Don't drop SYN+ACK for simultaneous connect().

Larysa Zaremba (1):
      ice: do not bring the VSI up, if it was down before the XDP setup

Li Nan (1):
      ublk_drv: fix NULL pointer dereference in ublk_ctrl_start_recovery()

Liao Chen (2):
      mmc: sdhci-of-aspeed: fix module autoloading
      gpio: modepin: Enable module autoloading

Luis Henriques (SUSE) (1):
      ext4: fix possible tid_t sequence overflows

Luiz Augusto von Dentz (2):
      Revert "Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE"
      Bluetooth: MGMT: Ignore keys being loaded with invalid type

Ma Ke (2):
      irqchip/gic-v2m: Fix refcount leak in gicv2m_of_init()
      usb: gadget: aspeed_udc: validate endpoint index for ast udc

Maciej Fijalkowski (2):
      ice: Use ice_max_xdp_frame_size() in ice_xdp_setup_prog()
      ice: allow hot-swapping XDP programs

Marc Kleine-Budde (5):
      can: mcp251xfd: fix ring configuration when switching from CAN-CC to CAN-FD mode
      can: mcp251xfd: mcp251xfd_handle_rxif_ring_uinc(): factor out in separate function
      can: mcp251xfd: rx: prepare to workaround broken RX FIFO head index erratum
      can: mcp251xfd: clarify the meaning of timestamp
      can: mcp251xfd: rx: add workaround for erratum DS80000789E 6 of mcp2518fd

Marek Olšák (2):
      drm/amdgpu: check for LINEAR_ALIGNED correctly in check_tiling_flags_gfx6
      drm/amdgpu: handle gfx12 in amdgpu_display_verify_sizes

Matt Johnston (1):
      net: mctp-serial: Fix missing escapes on transmit

Matteo Martelli (2):
      iio: fix scale application in iio_convert_raw_to_processed_unlocked
      ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s mode

Matthew Maurer (1):
      rust: Use awk instead of recent xargs

Matthieu Baerts (NGI0) (4):
      selftests: mptcp: fix backport issues
      selftests: mptcp: join: validate event numbers
      selftests: mptcp: join: check re-re-adding ID 0 signal
      tcp: process the 3rd ACK with sk_socket for TFO/MPTCP

Maurizio Lombardi (1):
      nvmet-tcp: fix kernel crash if commands allocation fails

Maxim Levitsky (1):
      KVM: SVM: fix emulation of msr reads/writes of MSR_FS_BASE and MSR_GS_BASE

Maximilien Perreault (1):
      ALSA: hda/realtek: Support mute LED on HP Laptop 14-dq2xxx

Michael Ellerman (3):
      ata: pata_macio: Use WARN instead of BUG
      powerpc/64e: remove unused IBM HTW code
      powerpc/64e: split out nohash Book3E 64-bit code

Michal Koutný (1):
      io_uring/sqpoll: Do not set PF_NO_SETAFFINITY on sqpoll threads

Miklos Szeredi (3):
      fuse: add "expire only" mode to FUSE_NOTIFY_INVAL_ENTRY
      fuse: add request extension
      fuse: add feature flag for expire-only

Mitchell Levy (1):
      x86/fpu: Avoid writing LBR bit to IA32_XSS unless supported

Mohan Kumar (1):
      ASoC: tegra: Fix CBB error during probe()

Naman Jain (1):
      Drivers: hv: vmbus: Fix rescind handling in uio_hv_generic

Namjae Jeon (1):
      ksmbd: unset the binding mark of a reused connection

Nicholas Piggin (2):
      workqueue: wq_watchdog_touch is always called with valid CPU
      workqueue: Improve scalability of workqueue watchdog touch

Oliver Neukum (2):
      usbnet: modern method to get random MAC
      usbnet: ipheth: race between ipheth_close and error handling

Olivier Sobrie (1):
      HID: amd_sfh: free driver_data after destroying hid device

Pali Rohár (1):
      irqchip/armada-370-xp: Do not allow mapping IRQ 0 and 1

Pawel Dembicki (1):
      net: dsa: vsc73xx: fix possible subblocks range of CAPT block

Peng Wu (1):
      regulator: of: fix a NULL vs IS_ERR() check in of_regulator_bulk_get_all()

Peter Zijlstra (1):
      perf/aux: Fix AUX buffer serialization

Phillip Lougher (1):
      Squashfs: sanity check symbolic link size

Ravi Bangoria (1):
      KVM: SVM: Don't advertise Bus Lock Detect to guest if SVM support is missing

Richard Fitzgerald (1):
      firmware: cs_dsp: Don't allow writes to read-only controls

Roland Xu (1):
      rtmutex: Drop rt_mutex::wait_lock before scheduling

Ryusuke Konishi (3):
      nilfs2: fix missing cleanup on rollforward recovery error
      nilfs2: protect references to superblock parameters exposed in sysfs
      nilfs2: fix state management in error path of log writing function

Sam Protsenko (1):
      mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K

Sascha Hauer (1):
      wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()

Satya Priya Kakitapalli (2):
      clk: qcom: clk-alpha-pll: Fix the pll post div mask
      clk: qcom: clk-alpha-pll: Fix the trion pll postdiv set rate API

Saurabh Sengar (1):
      uio_hv_generic: Fix kernel NULL pointer dereference in hv_uio_rescind

Sean Anderson (1):
      phy: zynqmp: Take the phy mutex in xlate

Sean Christopherson (1):
      KVM: x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS

Seunghwan Baek (1):
      mmc: cqhci: Fix checking of CQHCI_HALT state

Shakeel Butt (1):
      memcg: protect concurrent access to mem_cgroup_idr

Shantanu Goel (1):
      usb: uas: set host status byte on data completion error

Simon Arlott (1):
      can: mcp251x: fix deadlock if an interrupt occurs during mcp251x_open

Simon Horman (1):
      can: m_can: Release irq on error in m_can_open

Souradeep Chakrabarti (1):
      net: mana: Fix error handling in mana_create_txq/rxq's NAPI cleanup

Stefan Wiehler (1):
      of/irq: Prevent device address out-of-bounds read in interrupt map walk

Stephen Hemminger (1):
      sch/netem: fix use after free in netem_dequeue

Sven Schnelle (1):
      uprobes: Use kzalloc to allocate xol area

Takashi Iwai (2):
      ALSA: control: Apply sanity check of input values for user elements
      ALSA: hda: Add input value sanity checks to HDMI channel map controls

Terry Cheong (1):
      ALSA: hda/realtek: add patch for internal mic in Lenovo V145

Thomas Gleixner (2):
      x86/kaslr: Expose and use the end of the physical memory address space
      x86/mm: Fix PTI for i386 some more

Toke Høiland-Jørgensen (1):
      sched: sch_cake: fix bulk flow accounting logic for host fairness

Trond Myklebust (1):
      NFSv4: Add missing rescheduling points in nfs_client_return_marked_delegations

Vladimir Oltean (1):
      net: dpaa: avoid on-stack arrays of NR_CPUS elements

Waiman Long (1):
      cgroup: Protect css->cgroup write under css_set_lock

Yicong Yang (1):
      dma-mapping: benchmark: Don't starve others when doing the test

Yifan Zha (1):
      drm/amdgpu: Set no_hw_access when VF request full GPU fails

Yonghong Song (1):
      bpf: Silence a warning in btf_type_id_size()

Yunjian Wang (1):
      netfilter: nf_conncount: fix wrong variable type

Zenghui Yu (1):
      kselftests: dmabuf-heaps: Ensure the driver name is null-terminated

Zheng Qixing (1):
      ata: libata: Fix memory leak for error path in ata_host_alloc()

Zheng Yejian (1):
      tracing: Avoid possible softlockup in tracing_iter_reset()

Zijun Hu (1):
      devres: Initialize an uninitialized struct member

Zqiang (1):
      smp: Add missing destroy_work_on_stack() call in smp_call_on_cpu()

robelin (1):
      ASoC: dapm: Fix UAF for snd_soc_pcm_runtime object

yang.zhang (1):
      riscv: set trap vector earlier

yangyun (1):
      fuse: fix memory leak in fuse_create_open


