Return-Path: <stable+bounces-67647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8631951BDE
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 15:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44DA3B2489C
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 13:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38D51AC431;
	Wed, 14 Aug 2024 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DwQCeXiW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9151EA84;
	Wed, 14 Aug 2024 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642279; cv=none; b=ocF4xobSFwCkfme/8Wwgdu5YLYkDgsdV82c/phnD0qQqg91OCxBeDBPBirytd31PC5jFIISAzA/OoPTSo2kT+4MnVWQ3fg6/AEx4JuxKqblps0J4+0W2005+58BBJNk+aLTrf6ab61LLCXjOXRAcPAkvZvfwaAv8NniwsJwjUuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642279; c=relaxed/simple;
	bh=kY6zxL+TZlHU2xijdX/fVWVS2gwHBRJE7r9CgCa4egg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RW3nX5joUTv+zuOnqMWONHQA1fPKU9LJ0xAxgtrQmHHTdh9OzusJwnrb9bPKIn5zPO3WL0Oum6Aq7uJRLryr5cwPQslHP7V2CN+m1yan2uDLijiBhDoh9ESbXfrJ1W3HP+DpV80OLIYJ46vXPZ+y+2EKRWK/WQn/b1Xm7FFPYXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DwQCeXiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880A8C32786;
	Wed, 14 Aug 2024 13:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723642279;
	bh=kY6zxL+TZlHU2xijdX/fVWVS2gwHBRJE7r9CgCa4egg=;
	h=From:To:Cc:Subject:Date:From;
	b=DwQCeXiWDdx+1pjOkbvFTpKukEVwwtPG5OLUQj2bSZ2QvrxWvL5ulTbPI4rRM4a0s
	 tmYuFXGZlC8img2q6iaR34mxVebHrsgaK43UK7mbrzfsq64imCpw/xD3LprRX97Fah
	 A6VApWBPef4Jh8KHecOeJbGbz0C1IWXRymMV0bao=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.46
Date: Wed, 14 Aug 2024 15:31:09 +0200
Message-ID: <2024081409-impure-dodge-646e@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.46 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/cifs/usage.rst                                        |    2 
 Documentation/admin-guide/kernel-parameters.txt                                 |   10 
 Documentation/arch/arm64/silicon-errata.rst                                     |   36 ++
 Documentation/hwmon/corsair-psu.rst                                             |    6 
 Makefile                                                                        |    2 
 arch/arm64/Kconfig                                                              |   38 ++
 arch/arm64/include/asm/barrier.h                                                |    4 
 arch/arm64/include/asm/cputype.h                                                |   16 +
 arch/arm64/kernel/cpu_errata.c                                                  |   31 ++
 arch/arm64/kernel/cpufeature.c                                                  |   12 
 arch/arm64/kernel/proton-pack.c                                                 |   12 
 arch/arm64/tools/cpucaps                                                        |    1 
 arch/loongarch/kernel/efi.c                                                     |    6 
 arch/parisc/Kconfig                                                             |    1 
 arch/parisc/include/asm/cache.h                                                 |   11 
 arch/parisc/net/bpf_jit_core.c                                                  |    2 
 arch/x86/include/asm/msr-index.h                                                |    1 
 arch/x86/include/asm/qspinlock.h                                                |   12 
 arch/x86/kernel/cpu/mtrr/mtrr.c                                                 |    2 
 arch/x86/kernel/paravirt.c                                                      |    7 
 arch/x86/mm/pti.c                                                               |    8 
 drivers/acpi/battery.c                                                          |   16 -
 drivers/acpi/sbs.c                                                              |   23 -
 drivers/base/core.c                                                             |   13 
 drivers/base/module.c                                                           |    4 
 drivers/bluetooth/btnxpuart.c                                                   |    2 
 drivers/clocksource/sh_cmt.c                                                    |   13 
 drivers/gpio/gpiolib.c                                                          |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                      |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                                         |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c                                      |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                                         |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                                        |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h                                        |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c                                     |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                               |    9 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c                     |    3 
 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c |    5 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                                |    8 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c                                 |    8 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c                             |   57 +--
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c                             |   14 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c                           |   36 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                                       |   16 -
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c                               |    5 
 drivers/gpu/drm/display/drm_dp_mst_topology.c                                   |   11 
 drivers/gpu/drm/drm_client_modeset.c                                            |    5 
 drivers/gpu/drm/i915/gem/i915_gem_mman.c                                        |   55 +++
 drivers/gpu/drm/lima/lima_drv.c                                                 |    1 
 drivers/gpu/drm/mgag200/mgag200_i2c.c                                           |    8 
 drivers/gpu/drm/nouveau/nouveau_uvmm.c                                          |    6 
 drivers/gpu/drm/radeon/pptable.h                                                |    2 
 drivers/hwmon/corsair-psu.c                                                     |    7 
 drivers/i2c/busses/i2c-qcom-geni.c                                              |    5 
 drivers/i2c/i2c-smbus.c                                                         |   64 +++-
 drivers/irqchip/irq-loongarch-cpu.c                                             |    6 
 drivers/irqchip/irq-mbigen.c                                                    |   20 +
 drivers/irqchip/irq-meson-gpio.c                                                |   14 
 drivers/irqchip/irq-xilinx-intc.c                                               |    2 
 drivers/md/md.c                                                                 |    1 
 drivers/md/raid5.c                                                              |   20 -
 drivers/media/platform/amphion/vdec.c                                           |    2 
 drivers/media/platform/amphion/venc.c                                           |    2 
 drivers/media/tuners/xc2028.c                                                   |    9 
 drivers/media/usb/uvc/uvc_video.c                                               |   37 ++
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c                                  |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c                                   |  125 ++++----
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h                                       |   13 
 drivers/net/dsa/bcm_sf2.c                                                       |    4 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c                              |   14 
 drivers/net/ethernet/freescale/fec_ptp.c                                        |    3 
 drivers/net/ethernet/intel/ice/ice_main.c                                       |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                                 |    3 
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c                         |   23 +
 drivers/net/usb/qmi_wwan.c                                                      |    1 
 drivers/net/wireless/ath/ath12k/core.h                                          |    2 
 drivers/net/wireless/ath/ath12k/dp_rx.c                                         |    1 
 drivers/net/wireless/ath/ath12k/hif.h                                           |   18 -
 drivers/net/wireless/ath/ath12k/pci.c                                           |   21 +
 drivers/nvme/host/pci.c                                                         |    6 
 drivers/platform/x86/intel/ifs/core.c                                           |    3 
 drivers/platform/x86/intel/ifs/ifs.h                                            |   30 +
 drivers/platform/x86/intel/ifs/runtest.c                                        |   31 +-
 drivers/power/supply/axp288_charger.c                                           |   22 -
 drivers/power/supply/qcom_battmgr.c                                             |    8 
 drivers/s390/char/sclp_sd.c                                                     |   10 
 drivers/scsi/mpi3mr/mpi3mr_os.c                                                 |   11 
 drivers/scsi/mpt3sas/mpt3sas_base.c                                             |   20 +
 drivers/spi/spi-fsl-lpspi.c                                                     |    6 
 drivers/spi/spidev.c                                                            |    1 
 drivers/tty/serial/serial_core.c                                                |    8 
 drivers/ufs/core/ufshcd.c                                                       |   14 
 drivers/usb/gadget/function/f_midi2.c                                           |   21 -
 drivers/usb/gadget/function/u_audio.c                                           |   42 ++
 drivers/usb/gadget/function/u_serial.c                                          |    1 
 drivers/usb/gadget/udc/core.c                                                   |   10 
 drivers/usb/serial/usb_debug.c                                                  |    7 
 drivers/usb/usbip/vhci_hcd.c                                                    |    9 
 drivers/vhost/vdpa.c                                                            |    8 
 drivers/xen/privcmd.c                                                           |   25 -
 fs/btrfs/ctree.h                                                                |    1 
 fs/btrfs/extent_io.c                                                            |    4 
 fs/btrfs/file.c                                                                 |   60 ++-
 fs/btrfs/free-space-cache.c                                                     |    1 
 fs/btrfs/print-tree.c                                                           |    2 
 fs/ext4/inline.c                                                                |    6 
 fs/jbd2/journal.c                                                               |    1 
 fs/smb/client/cifs_debug.c                                                      |    2 
 fs/smb/client/cifsglob.h                                                        |    8 
 fs/smb/client/inode.c                                                           |   17 -
 fs/smb/client/misc.c                                                            |    9 
 fs/smb/client/reparse.c                                                         |    4 
 fs/smb/client/reparse.h                                                         |   19 +
 fs/smb/client/smb2inode.c                                                       |    2 
 fs/smb/client/smb2pdu.c                                                         |    3 
 fs/tracefs/event_inode.c                                                        |    4 
 fs/tracefs/inode.c                                                              |   12 
 fs/tracefs/internal.h                                                           |    5 
 fs/udf/balloc.c                                                                 |   36 --
 fs/xfs/xfs_log_recover.c                                                        |   20 -
 include/linux/blk-integrity.h                                                   |   16 -
 include/linux/clocksource.h                                                     |   14 
 include/linux/fs.h                                                              |    2 
 include/linux/pci_ids.h                                                         |    2 
 include/linux/profile.h                                                         |    1 
 include/linux/trace_events.h                                                    |    1 
 include/linux/virtio_net.h                                                      |   16 -
 include/net/ip6_route.h                                                         |   20 -
 include/trace/events/intel_ifs.h                                                |   16 -
 kernel/irq/irqdesc.c                                                            |    1 
 kernel/jump_label.c                                                             |    4 
 kernel/kcov.c                                                                   |   15 
 kernel/kprobes.c                                                                |    4 
 kernel/module/main.c                                                            |   41 ++
 kernel/padata.c                                                                 |    7 
 kernel/profile.c                                                                |   11 
 kernel/rcu/rcutorture.c                                                         |    2 
 kernel/rcu/tree.c                                                               |   10 
 kernel/sched/core.c                                                             |   68 +++-
 kernel/sched/cputime.c                                                          |    6 
 kernel/sched/stats.c                                                            |   10 
 kernel/time/clocksource-wdtest.c                                                |   13 
 kernel/time/clocksource.c                                                       |   10 
 kernel/time/ntp.c                                                               |    9 
 kernel/time/tick-broadcast.c                                                    |    3 
 kernel/time/timekeeping.c                                                       |    2 
 kernel/trace/tracing_map.c                                                      |    6 
 mm/huge_memory.c                                                                |    4 
 mm/hugetlb.c                                                                    |   14 
 mm/memcontrol.c                                                                 |   22 +
 net/bluetooth/hci_sync.c                                                        |   14 
 net/bluetooth/l2cap_core.c                                                      |    1 
 net/bridge/br_multicast.c                                                       |    4 
 net/core/link_watch.c                                                           |    4 
 net/ipv4/tcp_offload.c                                                          |    3 
 net/ipv4/udp_offload.c                                                          |    4 
 net/ipv6/ip6_output.c                                                           |    1 
 net/ipv6/route.c                                                                |    2 
 net/l2tp/l2tp_core.c                                                            |   15 
 net/mptcp/options.c                                                             |    3 
 net/mptcp/pm.c                                                                  |   12 
 net/mptcp/pm_netlink.c                                                          |   65 +++-
 net/mptcp/pm_userspace.c                                                        |   18 +
 net/mptcp/protocol.h                                                            |    3 
 net/mptcp/subflow.c                                                             |    3 
 net/netfilter/nf_tables_api.c                                                   |  154 ----------
 net/sctp/input.c                                                                |   19 -
 net/smc/smc_stats.h                                                             |    2 
 net/sunrpc/sched.c                                                              |    4 
 net/unix/af_unix.c                                                              |   34 --
 net/wireless/nl80211.c                                                          |   37 +-
 sound/pci/hda/patch_hdmi.c                                                      |    2 
 sound/pci/hda/patch_realtek.c                                                   |    1 
 sound/soc/amd/yc/acp6x-mach.c                                                   |    7 
 sound/soc/codecs/wcd938x-sdw.c                                                  |    4 
 sound/soc/codecs/wsa881x.c                                                      |    2 
 sound/soc/codecs/wsa883x.c                                                      |   10 
 sound/soc/codecs/wsa884x.c                                                      |   10 
 sound/soc/meson/axg-fifo.c                                                      |   26 -
 sound/soc/sof/mediatek/mt8195/mt8195.c                                          |    2 
 sound/soc/sti/sti_uniperif.c                                                    |    2 
 sound/soc/sti/uniperif.h                                                        |    1 
 sound/soc/sti/uniperif_player.c                                                 |    1 
 sound/soc/sti/uniperif_reader.c                                                 |    1 
 sound/usb/line6/driver.c                                                        |    5 
 sound/usb/quirks-table.h                                                        |    4 
 tools/arch/arm64/include/asm/cputype.h                                          |    6 
 tools/testing/selftests/bpf/prog_tests/send_signal.c                            |    3 
 tools/testing/selftests/mm/Makefile                                             |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                                 |   57 ++-
 tools/testing/selftests/net/mptcp/simult_flows.sh                               |    6 
 tools/testing/selftests/rcutorture/bin/torture.sh                               |    2 
 192 files changed, 1598 insertions(+), 807 deletions(-)

Alex Hung (1):
      drm/amd/display: Add null checker before passing variables

Andi Kleen (1):
      x86/mtrr: Check if fixed MTRRs exist before saving them

Andi Shyti (2):
      drm/i915/gem: Fix Virtual Memory mapping boundaries calculation
      drm/i915/gem: Adjust vma offset for framebuffer mmap offset

Andrey Konovalov (1):
      kcov: properly check for softirq context

Anton Khirnov (1):
      Bluetooth: hci_sync: avoid dup filtering when passive scanning with adv monitor

Arnaldo Carvalho de Melo (1):
      tools headers arm64: Sync arm64's cputype.h with the kernel sources

Arseniy Krasnov (1):
      irqchip/meson-gpio: Convert meson_gpio_irq_controller::lock to 'raw_spinlock_t'

Baochen Qiang (1):
      wifi: ath12k: fix memory leak in ath12k_dp_rx_peer_frag_setup()

Bartosz Golaszewski (1):
      net: stmmac: qcom-ethqos: enable SGMII loopback during DMA reset on sa8775p-ride-r3

Benjamin Coddington (1):
      SUNRPC: Fix a race to wake a sync task

Besar Wicaksono (1):
      arm64: Add Neoverse-V2 part

Bill Wendling (1):
      drm/radeon: Remove __counted_by from StateArray.states[]

Bob Zhou (1):
      drm/amd/pm: Fix the null pointer dereference for vega10_hwmgr

Chen Yu (1):
      x86/paravirt: Fix incorrect virt spinlock setting on bare metal

Chi Zhiling (1):
      media: xc2028: avoid use-after-free in load_firmware_cb()

Chris Wulff (2):
      usb: gadget: core: Check for unset descriptor
      usb: gadget: u_audio: Check return codes from usb_ep_enable and config_ep_by_speed.

Christoph Hellwig (1):
      xfs: fix log recovery buffer allocation for the legacy h_size fixup

Csókás, Bence (1):
      net: fec: Stop PPS on driver remove

Curtis Malainey (1):
      ASoC: SOF: Remove libraries from topology lookups

Damien Le Moal (2):
      scsi: mpt3sas: Avoid IOMMU page faults on REPORT ZONES
      scsi: mpi3mr: Avoid IOMMU page faults on REPORT ZONES

Dan Williams (1):
      driver core: Fix uevent_show() vs driver detach race

Daniele Palmas (1):
      net: usb: qmi_wwan: fix memory leak for not ip packets

Dave Airlie (1):
      nouveau: set placement to original placement on uvmm validate.

Dmitry Antipov (1):
      Bluetooth: l2cap: always unlock channel in l2cap_conless_channel()

Dragan Simic (1):
      drm/lima: Mark simple_ondemand governor as softdep

Dragos Tatulea (1):
      net/mlx5e: SHAMPO, Fix invalid WQ linked list unlink

Dustin L. Howett (1):
      ALSA: hda/realtek: Add Framework Laptop 13 (Intel Core Ultra) to quirks

Eric Dumazet (1):
      net: linkwatch: use system_unbound_wq

FUJITA Tomonori (1):
      PCI: Add Edimax Vendor ID to pci_ids.h

Fangzhi Zuo (1):
      drm/amd/display: Skip Recompute DSC Params if no Stream on Link

Feng Tang (1):
      clocksource: Scale the watchdog read retries automatically

Filipe Manana (3):
      btrfs: fix bitmap leak when loading free space cache on duplicate entry
      btrfs: fix corruption after buffer fault in during direct IO append write
      btrfs: fix double inode unlock for direct IO sync writes

Florian Fainelli (1):
      net: bcmgenet: Properly overlay PHY and MAC Wake-on-LAN capabilities

Florian Westphal (1):
      netfilter: nf_tables: prefer nft_chain_validate

Frederic Weisbecker (1):
      rcu: Fix rcu_barrier() VS post CPUHP_TEARDOWN_CPU invocation

Gaosheng Cui (2):
      i2c: qcom-geni: Add missing clk_disable_unprepare in geni_i2c_runtime_resume
      i2c: qcom-geni: Add missing geni_icc_disable in geni_i2c_runtime_resume

Geert Uytterhoeven (1):
      spi: spidev: Add missing spi_device_id for bh2228fv

George Kennedy (1):
      serial: core: check uartclk for zero to avoid divide by zero

Gleb Korobeynikov (1):
      cifs: cifs_inval_name_dfs_link_error: correct the check for fullpath

Greg Kroah-Hartman (1):
      Linux 6.6.46

Grzegorz Nitka (1):
      ice: Fix reset handler

Guenter Roeck (2):
      i2c: smbus: Improve handling of stuck alerts
      i2c: smbus: Send alert notifications to all devices if source not found

Hagar Hemdan (1):
      gpio: prevent potential speculation leaks in gpio_device_get_desc()

Hans de Goede (2):
      power: supply: axp288_charger: Fix constant_charge_voltage writes
      power: supply: axp288_charger: Round constant_charge_voltage writes down

Huacai Chen (1):
      irqchip/loongarch-cpu: Fix return value of lpic_gsi_to_irq()

Ivan Lipski (1):
      Revert "drm/amd/display: Add NULL check for 'afb' before dereferencing in amdgpu_dm_plane_handle_cursor_update"

James Chapman (1):
      l2tp: fix lockdep splat

Jason Wang (1):
      vhost-vdpa: switch to use vmf_insert_pfn() in the fault handler

Jens Axboe (1):
      block: use the right type for stub rq_integrity_vec()

Jerome Audu (1):
      ASoC: sti: add missing probe entry for player and reader

Jerome Brunet (1):
      ASoC: meson: axg-fifo: fix irq scheduling issue with PREEMPT_RT

Jesse Zhang (1):
      drm/admgpu: fix dereferencing null pointer context

Jithu Joseph (2):
      platform/x86/intel/ifs: Store IFS generation number
      platform/x86/intel/ifs: Gen2 Scan test support

Joe Hattori (1):
      net: dsa: bcm_sf2: Fix a possible memory leak in bcm_sf2_mdio_register()

Johan Hovold (1):
      wifi: ath12k: fix soft lockup on suspend

Johannes Berg (2):
      wifi: nl80211: disallow setting special AP channel widths
      wifi: nl80211: don't give key data to userspace

Joshua Ashton (1):
      drm/amdgpu: Forward soft recovery errors to userspace

Justin Stitt (2):
      ntp: Clamp maxerror and esterror to operating range
      ntp: Safeguard against time_constant overflow

Kang Yang (1):
      wifi: ath12k: add CE and ext IRQ flag to indicate irq_handler

Karthikeyan Periyasamy (1):
      wifi: ath12k: rename the sc naming convention to ab

Kemeng Shi (1):
      jbd2: avoid memleak in jbd2_journal_write_metadata_buffer

Krzysztof Kozlowski (4):
      ASoC: codecs: wcd938x-sdw: Correct Soundwire ports mask
      ASoC: codecs: wsa881x: Correct Soundwire ports mask
      ASoC: codecs: wsa883x: Correct Soundwire ports mask
      ASoC: codecs: wsa884x: Correct Soundwire ports mask

Kuniyuki Iwashima (2):
      sctp: Fix null-ptr-deref in reuseport_add_sock().
      af_unix: Don't retry after unix_state_lock_nested() in unix_stream_connect().

Kuppuswamy Sathyanarayanan (1):
      platform/x86/intel/ifs: Initialize union ifs_status to zero

Li Nan (1):
      md: do not delete safemode_timer in mddev_suspend

Linus Torvalds (2):
      module: warn about excessively long module waits
      module: make waiting for a concurrent module loader interruptible

Lucas Stach (1):
      drm/bridge: analogix_dp: properly handle zero sized AUX transactions

Luke Wang (1):
      Bluetooth: btnxpuart: Shutdown timer and prevent rearming when driver unloading

Ma Jun (4):
      drm/amdgpu/pm: Fix the param type of set_power_profile_mode
      drm/amdgpu/pm: Fix the null pointer dereference for smu7
      drm/amdgpu: Fix the null pointer dereference to ras_manager
      drm/amdgpu/pm: Fix the null pointer dereference in apply_state_adjust_rules

Ma Ke (1):
      drm/client: fix null pointer dereference in drm_client_modeset_probe

Manivannan Sadhasivam (1):
      scsi: ufs: core: Do not set link to OFF state while waking up from hibernation

Marc Kleine-Budde (2):
      can: mcp251xfd: tef: prepare to workaround broken TEF FIFO tail index erratum
      can: mcp251xfd: tef: update workaround for erratum DS80000789E 6 of mcp2518fd

Marek Marczykowski-Górecki (1):
      USB: serial: debug: do not echo input by default

Mark Rutland (12):
      arm64: barrier: Restore spec_bar() macro
      arm64: cputype: Add Cortex-X4 definitions
      arm64: cputype: Add Neoverse-V3 definitions
      arm64: errata: Add workaround for Arm errata 3194386 and 3312417
      arm64: cputype: Add Cortex-X3 definitions
      arm64: cputype: Add Cortex-A720 definitions
      arm64: cputype: Add Cortex-X925 definitions
      arm64: errata: Unify speculative SSBS errata logic
      arm64: errata: Expand speculative SSBS workaround
      arm64: cputype: Add Cortex-X1C definitions
      arm64: cputype: Add Cortex-A725 definitions
      arm64: errata: Expand speculative SSBS workaround (again)

Masami Hiramatsu (Google) (1):
      kprobes: Fix to check symbol prefixes correctly

Mathias Krause (3):
      tracefs: Fix inode allocation
      eventfs: Don't return NULL in eventfs_create_dir()
      eventfs: Use SRCU for freeing eventfs_inodes

Matthieu Baerts (NGI0) (9):
      mptcp: fully established after ADD_ADDR echo on MPJ
      mptcp: pm: fix backup support in signal endpoints
      mptcp: pm: deny endp with signal + subflow + port
      mptcp: pm: reduce indentation blocks
      mptcp: pm: don't try to create sf if alloc failed
      mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set
      selftests: mptcp: join: ability to invert ADD_ADDR check
      selftests: mptcp: join: test both signal & subflow
      Revert "selftests: mptcp: simult flows: mark 'unbalanced' tests as flaky"

Menglong Dong (1):
      bpf: kprobe: remove unused declaring of bpf_kprobe_override

Miao Wang (1):
      LoongArch: Enable general EFI poweroff method

Miaohe Lin (1):
      mm/hugetlb: fix potential race in __update_and_free_hugetlb_folio()

Michael Strauss (1):
      drm/amd/display: Add delay to improve LTTPR UHBR interop

Michal Pecio (1):
      media: uvcvideo: Fix the bandwdith quirk on USB 3.x

Mikulas Patocka (3):
      block: change rq_integrity_vec to respect the iterator
      parisc: fix unaligned accesses in BPF
      parisc: fix a possible DMA corruption

Ming Qian (1):
      media: amphion: Remove lock in s_ctrl callback

Neil Armstrong (1):
      power: supply: qcom_battmgr: return EAGAIN when firmware service is not up

Nico Pache (1):
      selftests: mm: add s390 to ARCH check

Nicolas Dichtel (1):
      ipv6: fix source address selection with route leak

Niklas Söderlund (1):
      clocksource/drivers/sh_cmt: Address race condition for clock events

Nikolay Aleksandrov (1):
      net: bridge: mcast: wait for previous gc cycles when removing port

Oliver Neukum (1):
      usb: vhci-hcd: Do not drop references before new references are gained

Paolo Abeni (1):
      selftests: mptcp: fix error path

Paul E. McKenney (2):
      rcutorture: Fix rcu_torture_fwd_cb_cr() data race
      clocksource: Fix brown-bag boolean thinko in cs_watchdog_read()

Paulo Alcantara (1):
      smb: client: handle lack of FSCTL_GET_REPARSE_POINT support

Peter Oberparleiter (1):
      s390/sclp: Prevent release of buffer in I/O

Peter Zijlstra (3):
      jump_label: Fix the fix, brown paper bags galore
      x86/mm: Fix pti_clone_pgtable() alignment assumption
      x86/mm: Fix pti_clone_entry_text() for i386

Prashanth K (1):
      usb: gadget: u_serial: Set start_delayed during suspend

Qu Wenruo (2):
      btrfs: do not clear page dirty inside extent_write_locked_range()
      btrfs: avoid using fixed char array size for tree names

Radhey Shyam Pandey (1):
      irqchip/xilinx: Fix shift out of bounds

Ricardo Ribalda (1):
      media: uvcvideo: Ignore empty TS packets

Roman Smirnov (1):
      udf: prevent integer overflow in udf_bitmap_free_blocks()

Shakeel Butt (1):
      memcg: protect concurrent access to mem_cgroup_idr

Shay Drory (1):
      genirq/irqdesc: Honor caller provided affinity in alloc_desc()

Srinivas Kandagatla (2):
      ASoC: codecs: wsa883x: parse port-mapping information
      ASoC: codecs: wsa884x: parse port-mapping information

Srinivasan Shanmugam (1):
      drm/amd/display: Add NULL check for 'afb' before dereferencing in amdgpu_dm_plane_handle_cursor_update

Stefan Wahren (1):
      spi: spi-fsl-lpspi: Fix scldiv calculation

Steve French (1):
      smb3: fix setting SecurityFlags when encryption is required

Steven 'Steve' Kendall (1):
      ALSA: hda: Add HP MP9 G4 Retail System AMS to force connect list

Steven Rostedt (1):
      tracefs: Use generic inode RCU for synchronizing freeing

Takashi Iwai (5):
      ALSA: usb-audio: Re-add ScratchAmp quirk entries
      ALSA: line6: Fix racy access to midibuf
      ALSA: hda/hdmi: Yet more pin fix for HP EliteDesk 800 G4
      usb: gadget: midi2: Fix the response for FB info with block 0xff
      ASoC: amd: yc: Add quirk entry for OMEN by HP Gaming Laptop 16-n0xxx

Tetsuo Handa (1):
      profiling: remove profile=sleep support

Thomas Gleixner (2):
      tick/broadcast: Move per CPU pointer access into the atomic section
      timekeeping: Fix bogus clock_was_set() invocation in do_adjtimex()

Thomas Weißschuh (2):
      ACPI: battery: create alarm sysfs attribute atomically
      ACPI: SBS: manage alarm sysfs attribute through psy core

Thomas Zimmermann (2):
      drm/mgag200: Set DDC timeout in milliseconds
      drm/mgag200: Bind I2C lifetime to DRM device

Tim Huang (1):
      drm/amdgpu: fix potential resource leak warning

Tze-nan Wu (1):
      tracing: Fix overflow in get_free_elt()

Vamshi Gajjela (1):
      scsi: ufs: core: Fix hba->last_dme_cmd_tstamp timestamp updating logic

Victor Skvortsov (1):
      drm/amdgpu: Add lock around VF RLCG interface

Viresh Kumar (1):
      xen: privcmd: Switch from mutex to spinlock for irqfds

Waiman Long (1):
      padata: Fix possible divide-by-0 panic in padata_mt_helper()

Wayne Lin (1):
      drm/dp_mst: Skip CSN if topology probing is not done yet

Wilken Gottwalt (1):
      hwmon: corsair-psu: add USB id of HX1200i Series 2023 psu

Willem de Bruijn (1):
      net: drop bad gso csum_start and offset in virtio_net_hdr

Xiaxi Shen (1):
      ext4: fix uninitialized variable in ext4_inlinedir_to_tree

Yang Shi (2):
      mm: huge_memory: don't force huge page alignment on 32 bit
      mm: huge_memory: use !CONFIG_64BIT to relax huge page alignment on 32 bit machines

Yang Yingliang (4):
      sched/smt: Introduce sched_smt_present_inc/dec() helper
      sched/smt: Fix unbalance sched_smt_present dec/inc
      sched/core: Introduce sched_set_rq_on/offline() helper
      sched/core: Fix unbalance set_rq_online/offline() in sched_cpu_deactivate()

Yipeng Zou (1):
      irqchip/mbigen: Fix mbigen node address layout

Yonghong Song (1):
      selftests/bpf: Fix send_signal test with nested CONFIG_PARAVIRT

Yu Kuai (1):
      md/raid5: avoid BUG_ON() while continue reshape after reassembling

Zheng Zucheng (1):
      sched/cputime: Fix mul_u64_u64_div_u64() precision for cputime

Zhengchao Shao (1):
      net/smc: add the max value of fallback reason count


