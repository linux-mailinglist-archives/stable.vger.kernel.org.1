Return-Path: <stable+bounces-106649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF849FF932
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 13:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A56C7A155B
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 12:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEADA1B0F0A;
	Thu,  2 Jan 2025 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YIKgtV+z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DDB3D68;
	Thu,  2 Jan 2025 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735819796; cv=none; b=nIxsKVvco3cili0nLB4D3OHr4c4uimmiXGbsq35IC6x1H7goNKxdgjik68kcCgO/ZYCXKx4UnOM/5IMaeOG905IgaUOT/hTb8MdvITBRzKEdb+ycFQkeyTYxI+dOndTKSnld/4B9cdhkPS6OGBw1hSfzYihkTSzVW75IldW+1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735819796; c=relaxed/simple;
	bh=IDWB+AooTY0y0vD38+AkLcMhVEuBCwGxzaLElyf54rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nlvgj8l9Sb6KzAd2k91iTObZWkDDDu2tdpq2tSAhj0wFAN83dWG/kLkqbsRW1K3gYEmmWpWynzjPvCS/J6MZUa/DbgT13XXPvcqcKvb5k5kmPxlQqdAITqvaNS7MjlPavryLwKhtcPeLwoHPDPx76OrV23viBdLB2MoqVDcdIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YIKgtV+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C7BC4CED0;
	Thu,  2 Jan 2025 12:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735819796;
	bh=IDWB+AooTY0y0vD38+AkLcMhVEuBCwGxzaLElyf54rQ=;
	h=From:To:Cc:Subject:Date:From;
	b=YIKgtV+zr54dZDk36Wwz+/SklDkaJ8O9dRBR55u7G0qrnnrYHWXQAg2L7sRQf+vBC
	 Rwuud5nONJ5++oWH5nwEcz1ND1bc4mQVBHOb0FuZFibXwwpqHw0MVpKyBwAGRl5fcd
	 qBKwxM0Nm3FlxsjLDs+4dOPTNZ78T49iwySAjKOU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.8
Date: Thu,  2 Jan 2025 13:09:47 +0100
Message-ID: <2025010248-cyclic-require-ef89@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.8 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arch/arm64/silicon-errata.rst                 |    5 
 Documentation/devicetree/bindings/sound/realtek,rt5645.yaml |    2 
 Makefile                                                    |    2 
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi                   |    8 
 arch/loongarch/include/asm/inst.h                           |   12 
 arch/loongarch/kernel/efi.c                                 |    2 
 arch/loongarch/kernel/inst.c                                |    2 
 arch/loongarch/net/bpf_jit.c                                |    6 
 arch/powerpc/platforms/book3s/vas-api.c                     |   36 ++
 arch/x86/events/intel/core.c                                |   12 
 arch/x86/events/intel/ds.c                                  |    1 
 arch/x86/events/intel/uncore.c                              |    1 
 arch/x86/kernel/cet.c                                       |   30 ++
 block/blk-mq.c                                              |   15 -
 drivers/acpi/arm64/iort.c                                   |    2 
 drivers/base/regmap/regmap.c                                |    4 
 drivers/block/ublk_drv.c                                    |   26 +
 drivers/block/virtio_blk.c                                  |    7 
 drivers/bluetooth/btusb.c                                   |   41 +-
 drivers/dma/amd/qdma/qdma.c                                 |   28 -
 drivers/dma/apple-admac.c                                   |    7 
 drivers/dma/at_xdmac.c                                      |    2 
 drivers/dma/dw/acpi.c                                       |    6 
 drivers/dma/dw/internal.h                                   |    8 
 drivers/dma/dw/pci.c                                        |    4 
 drivers/dma/fsl-edma-common.h                               |    1 
 drivers/dma/fsl-edma-main.c                                 |   41 ++
 drivers/dma/ls2x-apb-dma.c                                  |    2 
 drivers/dma/mv_xor.c                                        |    2 
 drivers/dma/tegra186-gpc-dma.c                              |   10 
 drivers/gpu/drm/display/drm_dp_mst_topology.c               |   24 +
 drivers/gpu/drm/xe/xe_devcoredump.c                         |   69 ++--
 drivers/i2c/busses/i2c-imx.c                                |    1 
 drivers/i2c/busses/i2c-microchip-corei2c.c                  |  122 ++++++--
 drivers/media/dvb-frontends/dib3000mb.c                     |    2 
 drivers/mtd/nand/raw/arasan-nand-controller.c               |   11 
 drivers/mtd/nand/raw/atmel/pmecc.c                          |    4 
 drivers/mtd/nand/raw/diskonchip.c                           |    2 
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h              |   13 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                 |   28 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c             |    2 
 drivers/pci/msi/irqdomain.c                                 |    7 
 drivers/pci/msi/msi.c                                       |    4 
 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c           |    6 
 drivers/phy/phy-core.c                                      |   21 -
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c                     |    2 
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c          |    2 
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c           |    3 
 drivers/platform/chrome/cros_ec_lpc.c                       |    4 
 drivers/platform/x86/asus-nb-wmi.c                          |    1 
 drivers/power/supply/bq24190_charger.c                      |   12 
 drivers/power/supply/cros_charge-control.c                  |   36 +-
 drivers/power/supply/gpio-charger.c                         |    8 
 drivers/scsi/megaraid/megaraid_sas_base.c                   |    5 
 drivers/scsi/mpi3mr/mpi3mr.h                                |    9 
 drivers/scsi/mpi3mr/mpi3mr_app.c                            |   36 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c                             |  121 +++-----
 drivers/scsi/mpi3mr/mpi3mr_os.c                             |    2 
 drivers/scsi/mpt3sas/mpt3sas_base.c                         |    7 
 drivers/scsi/qla1280.h                                      |   12 
 drivers/scsi/storvsc_drv.c                                  |    7 
 drivers/spi/spi-intel-pci.c                                 |    2 
 drivers/spi/spi-omap2-mcspi.c                               |    6 
 drivers/virt/coco/tdx-guest/tdx-guest.c                     |    4 
 drivers/watchdog/Kconfig                                    |    1 
 drivers/watchdog/it87_wdt.c                                 |   39 ++
 drivers/watchdog/mtk_wdt.c                                  |    6 
 drivers/watchdog/rzg2l_wdt.c                                |   20 +
 drivers/watchdog/s3c2410_wdt.c                              |    8 
 fs/btrfs/ctree.c                                            |   11 
 fs/btrfs/inode.c                                            |  129 ++++++--
 fs/btrfs/qgroup.c                                           |    3 
 fs/btrfs/relocation.c                                       |    6 
 fs/btrfs/send.c                                             |    6 
 fs/btrfs/sysfs.c                                            |    6 
 fs/ceph/file.c                                              |    2 
 fs/nfsd/export.c                                            |   31 --
 fs/nfsd/export.h                                            |    4 
 fs/nfsd/nfs4callback.c                                      |    4 
 fs/smb/client/Kconfig                                       |    1 
 fs/smb/client/smb2pdu.c                                     |    3 
 fs/smb/server/smb_common.c                                  |    4 
 fs/udf/namei.c                                              |   16 +
 include/linux/platform_data/amd_qdma.h                      |    2 
 include/linux/sched.h                                       |    3 
 include/linux/skmsg.h                                       |   11 
 include/linux/trace_events.h                                |    2 
 include/linux/vmstat.h                                      |    2 
 include/net/sock.h                                          |   10 
 include/uapi/linux/stddef.h                                 |   13 
 io_uring/sqpoll.c                                           |    6 
 kernel/bpf/verifier.c                                       |   18 -
 kernel/fork.c                                               |   13 
 kernel/trace/trace.c                                        |    3 
 kernel/trace/trace_kprobe.c                                 |    2 
 net/ceph/osd_client.c                                       |    2 
 net/core/filter.c                                           |   21 +
 net/core/skmsg.c                                            |    6 
 net/ipv4/tcp_bpf.c                                          |    6 
 sound/core/memalloc.c                                       |    2 
 sound/core/ump.c                                            |   26 +
 sound/pci/hda/patch_conexant.c                              |   28 +
 sound/sh/sh_dac_audio.c                                     |    5 
 sound/soc/amd/ps/pci-ps.c                                   |   17 +
 sound/soc/intel/boards/sof_sdw.c                            |   23 +
 sound/soc/sof/intel/hda-dai.c                               |   25 +
 sound/soc/sof/intel/hda.h                                   |    2 
 tools/include/uapi/linux/stddef.h                           |   15 -
 tools/objtool/noreturns.h                                   |    1 
 tools/testing/selftests/bpf/progs/dynptr_fail.c             |   22 -
 tools/testing/selftests/bpf/progs/iters_state_safety.c      |   14 
 tools/testing/selftests/bpf/progs/iters_testmod_seq.c       |    4 
 tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c |    2 
 tools/testing/selftests/bpf/progs/verifier_bits_iter.c      |    4 
 tools/testing/selftests/bpf/trace_helpers.c                 |    4 
 tools/tracing/rtla/src/timerlat_hist.c                      |  177 ++++++------
 116 files changed, 1166 insertions(+), 545 deletions(-)

Aapo Vienamo (1):
      spi: intel: Add Panther Lake SPI controller support

Akhil R (1):
      dmaengine: tegra: Return correct DMA status when paused

Alexander Lobakin (1):
      stddef: make __struct_group() UAPI C++-friendly

Andrea Righi (1):
      bpf: Fix bpf_get_smp_processor_id() on !CONFIG_SMP

Andy Shevchenko (1):
      dmaengine: dw: Select only supported masters for ACPI devices

Armin Wolf (1):
      platform/x86: asus-nb-wmi: Ignore unknown event 0xCF

Bart Van Assche (1):
      mm/vmstat: fix a W=1 clang compiler warning

Bharath SM (1):
      smb: fix bytes written value in /proc/fs/cifs/Stats

Binbin Zhou (1):
      dmaengine: loongson2-apb: Change GENMASK to GENMASK_ULL

Boris Burkov (2):
      btrfs: check folio mapping after unlock in put_file_data()
      btrfs: check folio mapping after unlock in relocate_one_folio()

Brahmajit Das (1):
      smb: server: Fix building with GCC 15

Carlos Song (1):
      i2c: imx: add imx7d compatible string for applying erratum ERR007805

Cathy Avery (1):
      scsi: storvsc: Do not flag MAINTENANCE_IN return of SRB_STATUS_DATA_OVERRUN as an error

Chen Ridong (2):
      dmaengine: at_xdmac: avoid null_prt_deref in at_xdmac_prep_dma_memset
      freezer, sched: Report frozen tasks as 'D' instead of 'R'

Chen-Yu Tsai (1):
      ASoC: dt-bindings: realtek,rt5645: Fix CPVDD voltage comment

Chris Lu (4):
      Bluetooth: btusb: mediatek: move Bluetooth power off command position
      Bluetooth: btusb: mediatek: add callback function in btusb_disconnect
      Bluetooth: btusb: mediatek: add intf release flow when usb disconnect
      Bluetooth: btusb: mediatek: change the conditions for ISO interface

Christian Göttsche (1):
      tracing: Constify string literal data member in struct trace_event_call

Chukun Pan (1):
      phy: rockchip: naneng-combphy: fix phy reset

Claudiu Beznea (1):
      watchdog: rzg2l_wdt: Power on the watchdog domain in the restart handler

Cong Wang (2):
      tcp_bpf: Charge receive socket buffer in bpf_tcp_ingress()
      bpf: Check negative offsets in __bpf_skb_min_len()

Conor Dooley (2):
      i2c: microchip-core: actually use repeated sends
      i2c: microchip-core: fix "ghost" detections

Cristian Ciocaltea (1):
      phy: rockchip: samsung-hdptx: Set drvdata before enabling runtime PM

Dan Carpenter (1):
      mtd: rawnand: fix double free in atmel_pmecc_create_user()

Dimitri Fedrau (1):
      power: supply: gpio-charger: Fix set charge current limits

Dragan Simic (1):
      smb: client: Deduplicate "select NETFS_SUPPORT" in Kconfig

Dustin L. Howett (1):
      platform/chrome: cros_ec_lpc: fix product identity for early Framework Laptops

Emmanuel Grumbach (1):
      wifi: iwlwifi: be less noisy if the NIC is dead in S3

Fedor Pchelkin (1):
      ALSA: memalloc: prefer dma_mapping_error() over explicit address checking

Filipe Manana (4):
      btrfs: fix race with memory mapped writes when activating swap file
      btrfs: avoid monopolizing a core when activating a swap file
      btrfs: fix swap file activation failure due to extents that used to be shared
      btrfs: fix use-after-free when COWing tree bock and tracing is enabled

Greg Kroah-Hartman (1):
      Linux 6.12.8

Hans de Goede (1):
      power: supply: bq24190: Fix BQ24296 Vbus regulator support

Haren Myneni (1):
      powerpc/pseries/vas: Add close() callback in vas_vm_ops struct

Huacai Chen (1):
      LoongArch: Fix reserving screen info memory for above-4G firmware

Ilya Dryomov (1):
      ceph: allocate sparse_ext map only for sparse reads

Imre Deak (1):
      drm/dp_mst: Ensure mst_primary pointer is valid in drm_dp_mst_handle_up_req()

James Hilliard (1):
      watchdog: it87_wdt: add PWRGD enable quirk for Qotom QCML04

Jan Kara (2):
      udf: Skip parent dir link count update if corrupted
      udf: Verify inode link counts before performing rename

Javier Carrasco (1):
      dmaengine: mv_xor: fix child node refcount handling in early exit

Jerome Marchand (1):
      selftests/bpf: Fix compilation error in get_uprobe_offset()

Joe Hattori (1):
      dmaengine: fsl-edma: implement the cleanup path of fsl_edma3_attach_pd()

John Harrison (1):
      drm/xe: Move the coredump registration to the worker thread

Julian Sun (1):
      btrfs: fix transaction atomicity bug when enabling simple quotas

Justin Chen (1):
      phy: usb: Toggle the PHY power during init

Kan Liang (3):
      perf/x86/intel/uncore: Add Clearwater Forest support
      perf/x86/intel: Fix bitmask of OCR and FRONTEND events for LNC
      perf/x86/intel/ds: Add PEBS format 6

Krishna Kurapati (1):
      phy: qcom-qmp: Fix register name in RX Lane config of SC8280XP

Kumar Kartikeya Dwivedi (1):
      bpf: Zero index arg error string for dynptr and iter

Li RongQing (1):
      virt: tdx-guest: Just leak decrypted memory on unrecoverable errors

Lizhi Hou (1):
      dmaengine: amd: qdma: Remove using the private get and set dma_ops APIs

Lizhi Xu (1):
      tracing: Prevent bad count for tracing_cpumask_write

Lorenzo Stoakes (1):
      fork: avoid inappropriate uprobe access to invalid mm

Maciej Andrzejewski (2):
      mtd: rawnand: arasan: Fix double assertion of chip-select
      mtd: rawnand: arasan: Fix missing de-registration of NAND

Magnus Lindholm (1):
      scsi: qla1280: Fix hw revision numbering for ISP1020/1040

Mark Brown (1):
      regmap: Use correct format specifier for logging range errors

Masami Hiramatsu (Google) (1):
      tracing/kprobe: Make trace_kprobe's module callback called after jump_label update

Matthew Brost (1):
      drm/xe: Take PM ref in delayed snapshot capture worker

Ming Lei (3):
      virtio-blk: don't keep queue frozen during system suspend
      blk-mq: register cpuhp callback after hctx is added to xarray table
      ublk: detach gendisk from ublk device if add_disk() fails

NeilBrown (1):
      nfsd: restore callback functionality for NFSv4.0

Nikita Zhandarovich (1):
      media: dvb-frontends: dib3000mb: fix uninit-value in dib3000_write_reg

Pavel Begunkov (1):
      io_uring/sqpoll: fix sqpoll error handling races

Peter Griffin (1):
      Revert "watchdog: s3c2410_wdt: use exynos_get_pmu_regmap_by_phandle() for PMU regs"

Peter Ujfalusi (1):
      ASoC: SOF: Intel: hda-dai: Do not release the link DMA on STOP

Purushothama Siddaiah (1):
      spi: omap2-mcspi: Fix the IS_ERR() bug for devm_clk_get_optional_enabled()

Qinxin Xia (1):
      ACPI/IORT: Add PMCG platform information for HiSilicon HIP09A

Qu Wenruo (1):
      btrfs: sysfs: fix direct super block member reads

Ranjan Kumar (5):
      scsi: mpt3sas: Diag-Reset when Doorbell-In-Use bit is set during driver load time
      scsi: mpi3mr: Synchronize access to ioctl data buffer
      scsi: mpi3mr: Fix corrupt config pages PHY state is switched in sysfs
      scsi: mpi3mr: Start controller indexing from 0
      scsi: mpi3mr: Handling of fault code for insufficient power

Richard Fitzgerald (2):
      ASoC: Intel: sof_sdw: Fix DMI match for Lenovo 21QA and 21QB
      ASoC: Intel: sof_sdw: Fix DMI match for Lenovo 21Q6 and 21Q7

Sasha Finkelstein (1):
      dmaengine: apple-admac: Avoid accessing registers in probe

Takashi Iwai (6):
      ALSA: ump: Don't open legacy substream for an inactive group
      ALSA: ump: Indicate the inactive group in legacy substream names
      ALSA: ump: Update legacy substream names upon FB info update
      ALSA: sh: Use standard helper for buffer accesses
      ALSA: ump: Shut up truncated string warning
      ALSA: sh: Fix wrong argument order for copy_from_iter()

Thomas Gleixner (1):
      PCI/MSI: Handle lack of irqdomain gracefully

Thomas Weißschuh (3):
      power: supply: cros_charge-control: add mutex for driver data
      power: supply: cros_charge-control: allow start_threshold == end_threshold
      power: supply: cros_charge-control: hide start threshold on v2 cmd

Tiezhu Yang (1):
      LoongArch: BPF: Adjust the parameter of emit_jirl()

Tomas Glozar (1):
      rtla/timerlat: Fix histogram ALL for zero samples

Tomas Henzl (1):
      scsi: megaraid_sas: Fix for a potential deadlock

Venkata Prasad Potturu (1):
      ASoC: amd: ps: Fix for enabling DMIC on acp63 platform via _DSD entry

Willow Cunningham (1):
      arm64: dts: broadcom: Fix L2 linesize for Raspberry Pi 5

Xin Li (Intel) (1):
      x86/fred: Clear WFE in missing-ENDBRANCH #CPs

Yang Erkun (1):
      nfsd: Revert "nfsd: release svc_expkey/svc_export with rcu_work"

Yassine Oudjana (1):
      watchdog: mediatek: Add support for MT6735 TOPRGU/WDT

Zichen Xie (1):
      mtd: diskonchip: Cast an operand to prevent potential overflow

Zijian Zhang (1):
      tcp_bpf: Add sk_rmem_alloc related logic for tcp_bpf ingress redirection

Zijun Hu (5):
      phy: core: Fix an OF node refcount leakage in _of_phy_get()
      phy: core: Fix an OF node refcount leakage in of_phy_provider_lookup()
      phy: core: Fix that API devm_phy_put() fails to release the phy
      phy: core: Fix that API devm_of_phy_provider_unregister() fails to unregister the phy provider
      phy: core: Fix that API devm_phy_destroy() fails to destroy the phy

bo liu (1):
      ALSA: hda/conexant: fix Z60MR100 startup pop issue

chenchangcheng (1):
      objtool: Add bch2_trans_unlocked_error() to bcachefs noreturns


