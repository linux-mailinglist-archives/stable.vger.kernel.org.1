Return-Path: <stable+bounces-75993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5324C97683A
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 13:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ACC1B23E1E
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B411A42D1;
	Thu, 12 Sep 2024 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZCM31cjs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03E1A0BEA;
	Thu, 12 Sep 2024 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141737; cv=none; b=bZAtbE/4/l1p4VYgfAnsTXwR1yUfuRudqHkwX7DVOTPqhmcseDTlk9l1zjjlCmMmfIRgOYAKmYmWWYMG2JC6rOoAyJEa/X7Mje8oiVgr9KBz6eXvyuxhmIi/Gldp7CgW/33PiIHXGCUxpHbjNyLxfxeanRxB2a6oHepY44DLs1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141737; c=relaxed/simple;
	bh=8c5GBxjOqJm5tJn3c6BFqwc6TDEyW7rkX2CpiUxKuoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fgsCGPtppIy8qnIQOTKgsteUOfdjEv3ldBr7vQRobxgjQuePXWZRJAx20olKXA8U9Qkq+UPVeQmaqq5rFYZ78EvE7WHMhiVPDcFgLFZrwAQO9bm8tn9wffMXmT/RCTA/UkxOMfRWTrCq79pCiU+zKXSEFSBAuEr5+B+RHjMe7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZCM31cjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99781C4CECD;
	Thu, 12 Sep 2024 11:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726141737;
	bh=8c5GBxjOqJm5tJn3c6BFqwc6TDEyW7rkX2CpiUxKuoo=;
	h=From:To:Cc:Subject:Date:From;
	b=ZCM31cjs8E8UTrWtXuy6Q1xdaKMbth+BLfqkYdv4zJReyIgKWkbSyZmnoDvMVIa8G
	 B/tZdWHEkSCn/VGUVcjDvhIQnpmSoNprhZvfj07L0MbbR83wquoWO2319Iy52rfVGh
	 cCXbAPdPFuw/3U2ypfxoRKaDdGMqYxTXnhPasRL0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.51
Date: Thu, 12 Sep 2024 13:48:44 +0200
Message-ID: <2024091245-prologue-economic-5aab@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.51 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 MAINTAINERS                                                    |    2 
 Makefile                                                       |    2 
 arch/arm/include/asm/pgtable.h                                 |    2 
 arch/arm64/include/asm/acpi.h                                  |   12 
 arch/arm64/kernel/acpi_numa.c                                  |   11 
 arch/loongarch/kernel/relocate.c                               |    4 
 arch/mips/kernel/cevt-r4k.c                                    |   15 
 arch/powerpc/include/asm/nohash/mmu-e500.h                     |    3 
 arch/powerpc/kernel/vdso/vdso32.lds.S                          |    4 
 arch/powerpc/kernel/vdso/vdso64.lds.S                          |    4 
 arch/powerpc/lib/qspinlock.c                                   |   10 
 arch/powerpc/mm/nohash/Makefile                                |    2 
 arch/powerpc/mm/nohash/tlb.c                                   |  398 ----------
 arch/powerpc/mm/nohash/tlb_64e.c                               |  361 +++++++++
 arch/powerpc/mm/nohash/tlb_low_64e.S                           |  195 ----
 arch/riscv/Kconfig                                             |    5 
 arch/riscv/include/asm/kfence.h                                |    4 
 arch/riscv/include/asm/membarrier.h                            |   31 
 arch/riscv/include/asm/pgtable-64.h                            |   22 
 arch/riscv/include/asm/pgtable.h                               |   33 
 arch/riscv/kernel/efi.c                                        |    2 
 arch/riscv/kernel/head.S                                       |    3 
 arch/riscv/kernel/probes/kprobes.c                             |    5 
 arch/riscv/kvm/mmu.c                                           |   22 
 arch/riscv/mm/Makefile                                         |    3 
 arch/riscv/mm/context.c                                        |    2 
 arch/riscv/mm/fault.c                                          |   16 
 arch/riscv/mm/hugetlbpage.c                                    |   12 
 arch/riscv/mm/init.c                                           |    2 
 arch/riscv/mm/kasan_init.c                                     |   45 -
 arch/riscv/mm/pageattr.c                                       |   44 -
 arch/riscv/mm/pgtable.c                                        |   51 +
 arch/s390/kernel/vmlinux.lds.S                                 |    9 
 arch/um/drivers/line.c                                         |    2 
 arch/x86/coco/tdx/tdx.c                                        |    1 
 arch/x86/events/intel/core.c                                   |   23 
 arch/x86/include/asm/fpu/types.h                               |    7 
 arch/x86/include/asm/page_64.h                                 |    1 
 arch/x86/include/asm/pgtable_64_types.h                        |    4 
 arch/x86/kernel/apic/apic.c                                    |   11 
 arch/x86/kernel/fpu/xstate.c                                   |    3 
 arch/x86/kernel/fpu/xstate.h                                   |    4 
 arch/x86/kvm/svm/svm.c                                         |   15 
 arch/x86/kvm/x86.c                                             |    2 
 arch/x86/lib/iomem.c                                           |    5 
 arch/x86/mm/init_64.c                                          |    4 
 arch/x86/mm/kaslr.c                                            |   32 
 arch/x86/mm/pti.c                                              |   45 -
 drivers/accel/habanalabs/gaudi2/gaudi2_security.c              |    1 
 drivers/acpi/acpi_processor.c                                  |   15 
 drivers/acpi/cppc_acpi.c                                       |   13 
 drivers/android/binder.c                                       |    1 
 drivers/ata/libata-core.c                                      |    4 
 drivers/ata/libata-scsi.c                                      |   24 
 drivers/ata/pata_macio.c                                       |    7 
 drivers/base/devres.c                                          |    1 
 drivers/base/regmap/regcache-maple.c                           |    3 
 drivers/block/ublk_drv.c                                       |    2 
 drivers/bluetooth/btnxpuart.c                                  |   12 
 drivers/bluetooth/hci_qca.c                                    |    1 
 drivers/clk/qcom/clk-alpha-pll.c                               |    6 
 drivers/clk/qcom/clk-rcg.h                                     |    1 
 drivers/clk/qcom/clk-rcg2.c                                    |   30 
 drivers/clk/qcom/gcc-ipq9574.c                                 |   12 
 drivers/clk/qcom/gcc-sm8550.c                                  |   54 -
 drivers/clk/starfive/clk-starfive-jh7110-sys.c                 |   31 
 drivers/clk/starfive/clk-starfive-jh71x0.h                     |    2 
 drivers/clocksource/timer-imx-tpm.c                            |   16 
 drivers/clocksource/timer-of.c                                 |   17 
 drivers/clocksource/timer-of.h                                 |    1 
 drivers/cpufreq/amd-pstate.c                                   |  147 +++
 drivers/crypto/intel/qat/qat_common/adf_gen2_pfvf.c            |    4 
 drivers/crypto/intel/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c   |    8 
 drivers/crypto/starfive/jh7110-cryp.h                          |    4 
 drivers/crypto/starfive/jh7110-rsa.c                           |   15 
 drivers/cxl/core/region.c                                      |    5 
 drivers/firmware/cirrus/cs_dsp.c                               |    3 
 drivers/gpio/gpio-rockchip.c                                   |    1 
 drivers/gpio/gpio-zynqmp-modepin.c                             |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                         |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c                    |   30 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c                        |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h                        |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                       |    4 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                         |    8 
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c                           |   28 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |    2 
 drivers/gpu/drm/amd/display/dc/link/link_factory.c             |    6 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c     |   15 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                      |    6 
 drivers/gpu/drm/i915/gt/uc/intel_gsc_uc.c                      |    2 
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.h                       |    5 
 drivers/gpu/drm/i915/i915_sw_fence.c                           |    8 
 drivers/hid/amd-sfh-hid/amd_sfh_hid.c                          |    4 
 drivers/hid/hid-cougar.c                                       |    2 
 drivers/hv/vmbus_drv.c                                         |    1 
 drivers/hwmon/adc128d818.c                                     |    4 
 drivers/hwmon/hp-wmi-sensors.c                                 |    2 
 drivers/hwmon/lm95234.c                                        |    9 
 drivers/hwmon/nct6775-core.c                                   |    2 
 drivers/hwmon/w83627ehf.c                                      |    4 
 drivers/i3c/master/mipi-i3c-hci/dma.c                          |    5 
 drivers/i3c/master/svc-i3c-master.c                            |   58 +
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
 drivers/misc/fastrpc.c                                         |    5 
 drivers/misc/vmw_vmci/vmci_resource.c                          |    3 
 drivers/mmc/core/quirks.h                                      |   22 
 drivers/mmc/core/sd.c                                          |    4 
 drivers/mmc/host/cqhci-core.c                                  |    2 
 drivers/mmc/host/dw_mmc.c                                      |    4 
 drivers/mmc/host/sdhci-of-aspeed.c                             |    1 
 drivers/net/bareudp.c                                          |   22 
 drivers/net/can/kvaser_pciefd.c                                |   43 -
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
 drivers/net/ethernet/intel/e1000e/ich8lan.c                    |    2 
 drivers/net/ethernet/intel/ice/ice.h                           |    2 
 drivers/net/ethernet/intel/ice/ice_lib.c                       |   34 
 drivers/net/ethernet/intel/ice/ice_main.c                      |   46 -
 drivers/net/ethernet/intel/ice/ice_xsk.c                       |    3 
 drivers/net/ethernet/intel/igb/igb_main.c                      |   10 
 drivers/net/ethernet/intel/igc/igc_main.c                      |    1 
 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c           |   14 
 drivers/net/ethernet/microsoft/mana/mana_en.c                  |   22 
 drivers/net/mctp/mctp-serial.c                                 |    4 
 drivers/net/phy/phy_device.c                                   |    2 
 drivers/net/usb/ipheth.c                                       |    2 
 drivers/net/usb/r8152.c                                        |   17 
 drivers/net/usb/usbnet.c                                       |   11 
 drivers/net/wireless/ath/ath12k/mac.c                          |    9 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h                   |    3 
 drivers/net/wireless/marvell/mwifiex/main.h                    |    3 
 drivers/net/wireless/realtek/rtw88/usb.c                       |   13 
 drivers/nvme/host/pci.c                                        |   17 
 drivers/nvme/target/tcp.c                                      |    4 
 drivers/nvmem/core.c                                           |    6 
 drivers/of/irq.c                                               |   15 
 drivers/pci/controller/dwc/pci-keystone.c                      |   44 +
 drivers/pci/hotplug/pnv_php.c                                  |    3 
 drivers/pci/pci.c                                              |   35 
 drivers/pcmcia/yenta_socket.c                                  |    6 
 drivers/phy/xilinx/phy-zynqmp.c                                |    1 
 drivers/platform/x86/dell/dell-smbios-base.c                   |    5 
 drivers/scsi/pm8001/pm8001_sas.c                               |    4 
 drivers/spi/spi-fsl-lpspi.c                                    |   31 
 drivers/spi/spi-hisi-kunpeng.c                                 |    3 
 drivers/spi/spi-rockchip.c                                     |   23 
 drivers/staging/iio/frequency/ad9834.c                         |    2 
 drivers/ufs/core/ufshcd.c                                      |    7 
 drivers/uio/uio_hv_generic.c                                   |   11 
 drivers/usb/dwc3/core.c                                        |   15 
 drivers/usb/dwc3/core.h                                        |    2 
 drivers/usb/dwc3/gadget.c                                      |   41 -
 drivers/usb/gadget/udc/aspeed_udc.c                            |    2 
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.c                    |   12 
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.h                    |    9 
 drivers/usb/storage/uas.c                                      |    1 
 drivers/vfio/vfio_iommu_spapr_tce.c                            |   13 
 drivers/virtio/virtio_ring.c                                   |    4 
 drivers/xen/privcmd.c                                          |   10 
 fs/binfmt_elf.c                                                |    5 
 fs/btrfs/ctree.c                                               |   12 
 fs/btrfs/ctree.h                                               |    1 
 fs/btrfs/extent-tree.c                                         |   32 
 fs/btrfs/file.c                                                |   25 
 fs/btrfs/inode.c                                               |    2 
 fs/btrfs/transaction.h                                         |    6 
 fs/ext4/fast_commit.c                                          |    8 
 fs/fscache/main.c                                              |    1 
 fs/fuse/dir.c                                                  |    2 
 fs/fuse/file.c                                                 |    8 
 fs/fuse/xattr.c                                                |    4 
 fs/jbd2/recovery.c                                             |   30 
 fs/nfs/super.c                                                 |    2 
 fs/nilfs2/recovery.c                                           |   35 
 fs/nilfs2/segment.c                                            |   10 
 fs/nilfs2/sysfs.c                                              |   43 -
 fs/ntfs3/dir.c                                                 |   52 -
 fs/ntfs3/frecord.c                                             |    4 
 fs/smb/client/smb2inode.c                                      |    3 
 fs/smb/client/smb2ops.c                                        |   16 
 fs/smb/server/oplock.c                                         |    2 
 fs/smb/server/smb2pdu.c                                        |   14 
 fs/smb/server/transport_tcp.c                                  |    4 
 fs/squashfs/inode.c                                            |    7 
 fs/tracefs/event_inode.c                                       |    2 
 fs/udf/super.c                                                 |   15 
 fs/xattr.c                                                     |   91 +-
 include/acpi/cppc_acpi.h                                       |    5 
 include/linux/amd-pstate.h                                     |    4 
 include/linux/bpf-cgroup.h                                     |   16 
 include/linux/mm.h                                             |    4 
 include/linux/pgtable.h                                        |   21 
 include/linux/regulator/consumer.h                             |    8 
 include/net/bluetooth/hci.h                                    |    3 
 include/net/bluetooth/hci_core.h                               |   25 
 include/net/bluetooth/hci_sync.h                               |   24 
 include/net/mana/mana.h                                        |    2 
 include/net/sock.h                                             |    6 
 include/uapi/drm/drm_fourcc.h                                  |   18 
 kernel/bpf/cgroup.c                                            |   25 
 kernel/bpf/verifier.c                                          |    4 
 kernel/cgroup/cgroup.c                                         |    2 
 kernel/dma/map_benchmark.c                                     |   16 
 kernel/events/core.c                                           |   18 
 kernel/events/internal.h                                       |    1 
 kernel/events/ring_buffer.c                                    |    2 
 kernel/events/uprobes.c                                        |    3 
 kernel/kexec_file.c                                            |    2 
 kernel/locking/rtmutex.c                                       |    9 
 kernel/resource.c                                              |    6 
 kernel/sched/core.c                                            |    5 
 kernel/smp.c                                                   |    1 
 kernel/trace/trace.c                                           |    2 
 kernel/trace/trace_osnoise.c                                   |   50 -
 kernel/workqueue.c                                             |   12 
 lib/generic-radix-tree.c                                       |    2 
 mm/memory_hotplug.c                                            |    2 
 mm/sparse.c                                                    |    2 
 mm/userfaultfd.c                                               |   29 
 mm/vmalloc.c                                                   |    2 
 mm/vmscan.c                                                    |   24 
 net/bluetooth/hci_conn.c                                       |  158 ---
 net/bluetooth/hci_event.c                                      |   27 
 net/bluetooth/hci_sync.c                                       |  307 +++++++
 net/bluetooth/mgmt.c                                           |  144 +--
 net/bluetooth/smp.c                                            |    7 
 net/bridge/br_fdb.c                                            |    6 
 net/can/bcm.c                                                  |    4 
 net/core/sock.c                                                |    8 
 net/ipv4/fou_core.c                                            |   29 
 net/ipv4/tcp_bpf.c                                             |    2 
 net/ipv4/tcp_input.c                                           |    6 
 net/ipv6/ila/ila.h                                             |    1 
 net/ipv6/ila/ila_main.c                                        |    6 
 net/ipv6/ila/ila_xlat.c                                        |   13 
 net/netfilter/nf_conncount.c                                   |    8 
 net/sched/sch_cake.c                                           |   11 
 net/sched/sch_netem.c                                          |    9 
 net/socket.c                                                   |  104 +-
 net/unix/af_unix.c                                             |    9 
 rust/Makefile                                                  |    4 
 rust/kernel/types.rs                                           |    2 
 rust/macros/module.rs                                          |    6 
 security/smack/smack_lsm.c                                     |   12 
 sound/core/control.c                                           |    6 
 sound/hda/hdmi_chmap.c                                         |   18 
 sound/pci/hda/patch_conexant.c                                 |   11 
 sound/pci/hda/patch_realtek.c                                  |   10 
 sound/soc/codecs/tas2781-fmwlib.c                              |   71 -
 sound/soc/soc-dapm.c                                           |    1 
 sound/soc/soc-topology.c                                       |    2 
 sound/soc/sof/topology.c                                       |    2 
 sound/soc/sunxi/sun4i-i2s.c                                    |  143 +--
 sound/soc/tegra/tegra210_ahub.c                                |   10 
 tools/lib/bpf/libbpf.c                                         |    4 
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c             |    4 
 tools/testing/selftests/net/Makefile                           |    3 
 285 files changed, 3297 insertions(+), 2004 deletions(-)

Aaradhana Sahu (1):
      wifi: ath12k: fix uninitialize symbol error on ath12k_peer_assoc_h_he()

Ajith C (1):
      wifi: ath12k: fix firmware crash due to invalid peer nss

Aleksandr Mishin (2):
      platform/x86: dell-smbios: Fix error path in dell_smbios_init()
      staging: iio: frequency: ad9834: Validate frequency parameter value

Alex Deucher (1):
      Revert "drm/amdgpu: align pp_power_profile_mode with kernel docs"

Alex Hung (3):
      drm/amd/display: Run DC_LOG_DC after checking link->link_enc
      drm/amd/display: Check HDCP returned status
      drm/amd/display: Check denominator pbn_div before used

Alexandre Ghiti (5):
      riscv: Use WRITE_ONCE() when setting page table entries
      mm: Introduce pudp/p4dp/pgdp_get() functions
      riscv: mm: Only compile pgtable.c if MMU
      riscv: Use accessors to page table entries instead of direct dereference
      riscv: Do not restrict memory size because of linear mapping on nommu

Alexey Dobriyan (1):
      ELF: fix kernel.randomize_va_space double read

Alison Schofield (1):
      cxl/region: Verify target positions using the ordered target list

Amadeusz Sławiński (1):
      ASoC: topology: Properly initialize soc_enum values

Andrea Parri (1):
      membarrier: riscv: Add full memory barrier in switch_mm()

Andreas Hindborg (1):
      rust: kbuild: fix export of bss symbols

Andreas Ziegler (1):
      libbpf: Add NULL checks to bpf_object__{prev_map,next_map}

Andy Shevchenko (3):
      leds: spi-byte: Call of_node_put() on error path
      drm/i915/fence: Mark debug_fence_init_onstack() with __maybe_unused
      drm/i915/fence: Mark debug_fence_free() with __maybe_unused

Anton Blanchard (1):
      riscv: Fix toolchain vector detection

Arend van Spriel (1):
      wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3

Armin Wolf (1):
      hwmon: (hp-wmi-sensors) Check if WMI event data exists

Arnd Bergmann (1):
      regmap: maple: work around gcc-14.1 false-positive warning

Aurabindo Pillai (1):
      drm/amd: Add gfx12 swizzle mode defs

Baokun Li (1):
      fscache: delete fscache_cookie_lru_timer when fscache exits to avoid UAF

Benjamin Marzinski (1):
      dm init: Handle minors larger than 255

Boqun Feng (2):
      rust: types: Make Opaque::get const
      rust: macros: provide correct provenance when constructing THIS_MODULE

Breno Leitao (4):
      bpf: Add sockptr support for getsockopt
      bpf: Add sockptr support for setsockopt
      net/socket: Break down __sys_setsockopt
      net/socket: Break down __sys_getsockopt

Brian Johannesmeyer (1):
      x86/kmsan: Fix hook for unaligned accesses

Brian Norris (1):
      spi: rockchip: Resolve unbalanced runtime PM / system PM handling

Camila Alvarez (1):
      HID: cougar: fix slab-out-of-bounds Read in cougar_report_fixup

Carlos Llamas (1):
      binder: fix UAF caused by offsets overwrite

Carlos Song (1):
      spi: spi-fsl-lpspi: limit PRESCALE bit in TCR register

Chen Ni (1):
      media: qcom: camss: Add check for v4l2_fwnode_endpoint_parse

Chen-Yu Tsai (1):
      ASoc: SOF: topology: Clear SOF link platform name upon unload

ChenXiaoSong (1):
      smb/server: fix potential null-ptr-deref of lease_ctx_info in smb2_open()

Christian König (1):
      drm/amdgpu: reject gang submit on reserved VMIDs

Christoffer Sandberg (1):
      ALSA: hda/conexant: Add pincfg quirk to enable top speakers on Sirius devices

Christophe Leroy (2):
      powerpc/64e: Define mmu_pte_psize static
      powerpc/vdso: Don't discard rela sections

Cong Wang (1):
      tcp_bpf: fix return value of tcp_bpf_sendmsg()

Daiwei Li (1):
      igb: Fix not clearing TimeSync interrupts for 82580

Dan Carpenter (2):
      ksmbd: Unlock on in ksmbd_tcp_set_interfaces()
      igc: Unlock on error in igc_io_resume()

Dan Williams (1):
      PCI: Add missing bridge lock to pci_bus_lock()

Daniel Lezcano (1):
      clocksource/drivers/timer-of: Remove percpu irq related code

Daniele Ceraolo Spurio (1):
      drm/i915: Do not attempt to load the GSC multiple times

Danijel Slivka (1):
      drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts

David Fernandez Gonzalez (1):
      VMCI: Fix use-after-free when removing resource in vmci_resource_remove()

David Howells (2):
      cifs: Fix FALLOC_FL_ZERO_RANGE to preflush buffered part of target region
      vfs: Fix potential circular locking through setxattr() and removexattr()

David Lechner (1):
      iio: buffer-dmaengine: fix releasing dma channel on error

David Sterba (1):
      btrfs: initialize location to fix -Wmaybe-uninitialized in btrfs_lookup_dentry()

Dawid Osuchowski (1):
      ice: Add netif_device_attach/detach into PF reset flow

Devyn Liu (1):
      spi: hisi-kunpeng: Add verification for the max_frequency provided by the firmware

Dmitry Torokhov (2):
      Input: ili210x - use kvmalloc() to allocate buffer for firmware update
      Input: uinput - reject requests with unreasonable number of slots

Douglas Anderson (2):
      regulator: core: Stub devm_regulator_bulk_get_const() if !CONFIG_REGULATOR
      Bluetooth: qca: If memdump doesn't work, re-enable IBS

Dumitru Ceclan (2):
      iio: adc: ad7124: fix config comparison
      iio: adc: ad7124: fix chip ID mismatch

Eric Dumazet (1):
      ila: call nf_unregister_net_hooks() sooner

Eric Joyner (1):
      ice: Check all ice_vsi_rebuild() errors in function

Faisal Hassan (1):
      usb: dwc3: core: update LC timer as per USB Spec V3.2

Filipe Manana (2):
      btrfs: replace BUG_ON() with error handling at update_ref_for_cow()
      btrfs: fix race between direct IO write and fsync when using same fd

Frank Li (1):
      i3c: master: svc: resend target address when get NACK

Geert Uytterhoeven (1):
      nvmem: Fix return type of devm_nvmem_device_get() in kerneldoc

Georg Gottleuber (1):
      nvme-pci: Add sleep quirk for Samsung 990 Evo

Greg Kroah-Hartman (1):
      Linux 6.6.51

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

Hayes Wang (1):
      r8152: fix the firmware doesn't work

Heiko Carstens (1):
      s390/vmlinux.lds.S: Move ro_after_init section behind rodata section

Huacai Chen (1):
      LoongArch: Use correct API to map cmdline in relocate_kernel()

Igor Pylypiv (3):
      scsi: pm80xx: Set phy->enable_completion only when we wait for it
      ata: libata-scsi: Remove redundant sense_buffer memsets
      ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before using result_tf

Jacky Bai (2):
      clocksource/drivers/imx-tpm: Fix return -ETIME when delta exceeds INT_MAX
      clocksource/drivers/imx-tpm: Fix next event not taking effect sometime

Jacob Pan (1):
      iommu/vt-d: Handle volatile descriptor status read

James Morse (1):
      arm64: acpi: Move get_cpu_for_acpi_id() to a header

Jamie Bainbridge (1):
      selftests: net: enable bind tests

Jan Kara (1):
      udf: Avoid excessive partition lengths

Jann Horn (3):
      fuse: use unsigned type for getxattr/listxattr size truncation
      userfaultfd: don't BUG_ON() if khugepaged yanks our page table
      userfaultfd: fix checks for huge PMDs

Jarkko Nikula (1):
      i3c: mipi-i3c-hci: Error out instead on BUG_ON() in IBI DMA setup

Jens Emil Schulz Østergaard (1):
      net: microchip: vcap: Fix use-after-free error in kunit test

Jernej Skrabec (1):
      iommu: sun50i: clear bypass register

Jia Jie Ho (2):
      crypto: starfive - Align rsa input data to 32-bit
      crypto: starfive - Fix nent assignment in rsa dec

Jiaxun Yang (1):
      MIPS: cevt-r4k: Don't call get_c0_compare_int if timer irq is installed

Jinjie Ruan (1):
      net: phy: Fix missing of_node_put() for leds

Joanne Koong (1):
      fuse: update stats for pages in dropped aux writeback list

Johannes Berg (2):
      wifi: iwlwifi: mvm: use IWL_FW_CHECK for link ID check
      um: line: always fill *error_out in setup_one_line()

Jonas Dreßler (3):
      Bluetooth: hci_event: Use HCI error defines instead of magic values
      Bluetooth: hci_conn: Only do ACL connections sequentially
      Bluetooth: Remove pending ACL connection attempts

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

Keith Busch (1):
      nvme-pci: allocate tagset on reset if necessary

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

Kyoungrul Kim (1):
      scsi: ufs: core: Remove SCSI host only if added

Larysa Zaremba (2):
      ice: protect XDP configuration with a mutex
      ice: do not bring the VSI up, if it was down before the XDP setup

Leon Hwang (1):
      bpf, verifier: Correct tail_call_reachable for bpf prog

Li Nan (1):
      ublk_drv: fix NULL pointer dereference in ublk_ctrl_start_recovery()

Liao Chen (2):
      mmc: sdhci-of-aspeed: fix module autoloading
      gpio: modepin: Enable module autoloading

Luis Henriques (SUSE) (1):
      ext4: fix possible tid_t sequence overflows

Luiz Augusto von Dentz (10):
      Revert "Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE"
      Bluetooth: MGMT: Ignore keys being loaded with invalid type
      Bluetooth: hci_conn: Fix UAF Write in __hci_acl_create_connection_sync
      Bluetooth: hci_sync: Add helper functions to manipulate cmd_sync queue
      Bluetooth: hci_sync: Attempt to dequeue connection attempt
      Bluetooth: hci_sync: Introduce hci_cmd_sync_run/hci_cmd_sync_run_once
      Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT
      Bluetooth: hci_sync: Fix UAF in hci_acl_create_conn_sync
      Bluetooth: hci_sync: Fix UAF on create_le_conn_complete
      Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync

Ma Ke (2):
      irqchip/gic-v2m: Fix refcount leak in gicv2m_of_init()
      usb: gadget: aspeed_udc: validate endpoint index for ast udc

Marc Kleine-Budde (5):
      can: mcp251xfd: fix ring configuration when switching from CAN-CC to CAN-FD mode
      can: mcp251xfd: mcp251xfd_handle_rxif_ring_uinc(): factor out in separate function
      can: mcp251xfd: rx: prepare to workaround broken RX FIFO head index erratum
      can: mcp251xfd: clarify the meaning of timestamp
      can: mcp251xfd: rx: add workaround for erratum DS80000789E 6 of mcp2518fd

Marcin Ślusarz (1):
      wifi: rtw88: usb: schedule rx work after everything is set up

Marek Olšák (2):
      drm/amdgpu: check for LINEAR_ALIGNED correctly in check_tiling_flags_gfx6
      drm/amdgpu: handle gfx12 in amdgpu_display_verify_sizes

Martin Jocic (5):
      can: kvaser_pciefd: Skip redundant NULL pointer check in ISR
      can: kvaser_pciefd: Remove unnecessary comment
      can: kvaser_pciefd: Rename board_irq to pci_irq
      can: kvaser_pciefd: Move reset of DMA RX buffers to the end of the ISR
      can: kvaser_pciefd: Use a single write when releasing RX buffers

Matt Johnston (1):
      net: mctp-serial: Fix missing escapes on transmit

Matteo Martelli (2):
      iio: fix scale application in iio_convert_raw_to_processed_unlocked
      ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s mode

Matthew Maurer (1):
      rust: Use awk instead of recent xargs

Matthieu Baerts (NGI0) (1):
      tcp: process the 3rd ACK with sk_socket for TFO/MPTCP

Maurizio Lombardi (1):
      nvmet-tcp: fix kernel crash if commands allocation fails

Maxim Levitsky (1):
      KVM: SVM: fix emulation of msr reads/writes of MSR_FS_BASE and MSR_GS_BASE

Maximilien Perreault (1):
      ALSA: hda/realtek: Support mute LED on HP Laptop 14-dq2xxx

Meng Li (2):
      ACPI: CPPC: Add helper to get the highest performance value
      cpufreq: amd-pstate: Enable amd-pstate preferred core support

Michael Ellerman (3):
      ata: pata_macio: Use WARN instead of BUG
      powerpc/64e: remove unused IBM HTW code
      powerpc/64e: split out nohash Book3E 64-bit code

Mitchell Levy (1):
      x86/fpu: Avoid writing LBR bit to IA32_XSS unless supported

Mohan Kumar (1):
      ASoC: tegra: Fix CBB error during probe()

Naman Jain (1):
      Drivers: hv: vmbus: Fix rescind handling in uio_hv_generic

Namjae Jeon (1):
      ksmbd: unset the binding mark of a reused connection

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Fix Null pointer dereference in btnxpuart_flush()

Nicholas Piggin (2):
      workqueue: wq_watchdog_touch is always called with valid CPU
      workqueue: Improve scalability of workqueue watchdog touch

Nysal Jan K.A. (1):
      powerpc/qspinlock: Fix deadlock in MCS queue

Oliver Neukum (2):
      usbnet: modern method to get random MAC
      usbnet: ipheth: race between ipheth_close and error handling

Olivier Sobrie (1):
      HID: amd_sfh: free driver_data after destroying hid device

Pali Rohár (1):
      irqchip/armada-370-xp: Do not allow mapping IRQ 0 and 1

Paulo Alcantara (2):
      smb: client: fix double put of @cfile in smb2_set_path_size()
      smb: client: fix double put of @cfile in smb2_rename_path()

Pawel Dembicki (1):
      net: dsa: vsc73xx: fix possible subblocks range of CAPT block

Pawel Laszczak (1):
      usb: cdns2: Fix controller reset issue

Perry Yuan (1):
      cpufreq: amd-pstate: fix the highest frequency issue which limits performance

Peter Zijlstra (1):
      perf/aux: Fix AUX buffer serialization

Petr Tesarik (1):
      kexec_file: fix elfcorehdr digest exclusion when CONFIG_CRASH_HOTPLUG=y

Phillip Lougher (1):
      Squashfs: sanity check symbolic link size

Prashanth K (1):
      usb: dwc3: Avoid waking up gadget during startxfer

Rakesh Ughreja (1):
      accel/habanalabs/gaudi2: unsecure edma max outstanding register

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

Samuel Holland (1):
      riscv: kprobes: Use patch_text_nosync() for insn slots

Sascha Hauer (1):
      wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()

Sasha Neftin (1):
      intel: legacy: Partial revert of field get conversion

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

Shantanu Goel (1):
      usb: uas: set host status byte on data completion error

Shenghao Ding (1):
      ASoc: TAS2781: replace beXX_to_cpup with get_unaligned_beXX for potentially broken alignment

Shivaprasad G Bhat (1):
      vfio/spapr: Always clear TCEs before unsetting the window

Simon Arlott (1):
      can: mcp251x: fix deadlock if an interrupt occurs during mcp251x_open

Simon Horman (1):
      can: m_can: Release irq on error in m_can_open

Souradeep Chakrabarti (1):
      net: mana: Fix error handling in mana_create_txq/rxq's NAPI cleanup

Stefan Wahren (1):
      spi: spi-fsl-lpspi: Fix off-by-one in prescale max

Stefan Wiehler (1):
      of/irq: Prevent device address out-of-bounds read in interrupt map walk

Stephen Boyd (2):
      clk: qcom: gcc-sm8550: Don't use parking clk_ops for QUPs
      clk: qcom: gcc-sm8550: Don't park the USB RCG at registration time

Stephen Hemminger (1):
      sch/netem: fix use after free in netem_dequeue

Steven Rostedt (4):
      tracing/osnoise: Use a cpumask to know what threads are kthreads
      tracing/timerlat: Only clear timer if a kthread exists
      tracing/timerlat: Add interface_lock around clearing of kthread in stop_kthread()
      eventfs: Use list_del_rcu() for SRCU protected list variable

Sukrut Bellary (1):
      misc: fastrpc: Fix double free of 'buf' in error path

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

Tze-nan Wu (1):
      bpf, net: Fix a potential race in do_sock_getsockopt()

Usama Arif (1):
      Revert "mm: skip CMA pages when they are not available"

Vern Hao (1):
      mm/vmscan: use folio_migratetype() instead of get_pageblock_migratetype()

Viresh Kumar (1):
      xen: privcmd: Fix possible access to a freed kirqfd instance

Vladimir Oltean (1):
      net: dpaa: avoid on-stack arrays of NR_CPUS elements

Waiman Long (1):
      cgroup: Protect css->cgroup write under css_set_lock

Will Deacon (1):
      mm: vmalloc: ensure vmap_block is initialised before adding to queue

Xingyu Wu (1):
      clk: starfive: jh7110-sys: Add notifier for PLL0 clock

Xuan Zhuo (1):
      virtio_ring: fix KMSAN error for premapped mode

Ye Bin (1):
      jbd2: avoid mount failed when commit block is partial submitted

Yicong Yang (1):
      dma-mapping: benchmark: Don't starve others when doing the test

Yifan Zha (1):
      drm/amdgpu: Set no_hw_access when VF request full GPU fails

Yunjian Wang (1):
      netfilter: nf_conncount: fix wrong variable type

Yuntao Wang (1):
      x86/apic: Make x2apic_disable() work correctly

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

devi priya (1):
      clk: qcom: ipq9574: Update the alpha PLL type for GPLLs

robelin (1):
      ASoC: dapm: Fix UAF for snd_soc_pcm_runtime object

yang.zhang (1):
      riscv: set trap vector earlier

yangyun (1):
      fuse: fix memory leak in fuse_create_open


