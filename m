Return-Path: <stable+bounces-67645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA2C951BDA
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 15:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19E11F237F1
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 13:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F14D1EA84;
	Wed, 14 Aug 2024 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LO7hXPZ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3FD1D52D;
	Wed, 14 Aug 2024 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642269; cv=none; b=RR+WEf5cYJZNpJMZAc5rhDQs/L8pJL6QHjVo+B/wTCN56Sgmw9laS44HDEk2XWwIozcxYIlS08JzTNEvlLVHEwjynBe1LIhSwqe4z2UZb+sB/NatbLL+kx33TEAuLfgeZSZ/49RBXXcxhoXM1ORppCwfO4wret3T2NxuIUgQ0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642269; c=relaxed/simple;
	bh=4AnB2u7BWQPplXzDtmdewnNdb0YNthHQoZZ9uWvlzWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jGmE81ow5QxHi2sUwkzs4Gpw+9vRJFg2lBRC6kyvL2iCGO4aAZREoqLRcZ4K+l8vX0jN8NKn9h0Mt+BmarPWEjQLaSMCb2FyKTAjzPjypZSLUzKekhsPXNo9z5ZCS8FvmkS/k4YUBdP8imQT7Fk8ITuD0gWKwsXTf3UGOP2HLZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LO7hXPZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E160C32786;
	Wed, 14 Aug 2024 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723642268;
	bh=4AnB2u7BWQPplXzDtmdewnNdb0YNthHQoZZ9uWvlzWo=;
	h=From:To:Cc:Subject:Date:From;
	b=LO7hXPZ9Sqsiz64iZI/KLei71erZEbX9m+UhH5+zzdqNhamZD9UvlNb82mspt37sG
	 QfZng+xRSqUCjCiDMnFIO2xhXmuaj6lDrMAT6qo5aLdD8/iZWF2jCVbZXl8GAllVST
	 rCUahx3Ania//zwnGv15lw3FSAe1xjnFOaoVXHWE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.105
Date: Wed, 14 Aug 2024 15:31:03 +0200
Message-ID: <2024081403-frail-late-f8e5@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.105 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/cifs/usage.rst                    |    2 
 Documentation/admin-guide/kernel-parameters.txt             |   10 
 Documentation/arm64/silicon-errata.rst                      |   36 ++
 Makefile                                                    |    2 
 arch/arm64/Kconfig                                          |   38 ++
 arch/arm64/include/asm/barrier.h                            |    4 
 arch/arm64/include/asm/cputype.h                            |   16 +
 arch/arm64/kernel/cpu_errata.c                              |   31 ++
 arch/arm64/kernel/cpufeature.c                              |   12 
 arch/arm64/kernel/proton-pack.c                             |   12 
 arch/arm64/tools/cpucaps                                    |    1 
 arch/x86/kernel/cpu/mtrr/mtrr.c                             |    2 
 arch/x86/mm/pti.c                                           |    8 
 block/blk-mq.c                                              |    6 
 block/mq-deadline.c                                         |   20 +
 drivers/acpi/battery.c                                      |   16 -
 drivers/acpi/sbs.c                                          |   23 -
 drivers/base/core.c                                         |   13 
 drivers/base/module.c                                       |    4 
 drivers/bus/mhi/host/pci_generic.c                          |    3 
 drivers/clocksource/sh_cmt.c                                |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                  |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                     |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                    |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h                    |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           |    9 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c |    3 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c            |    8 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c             |    8 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c         |   57 ++-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c         |   14 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c       |   36 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                   |   16 -
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c           |    5 
 drivers/gpu/drm/display/drm_dp_mst_topology.c               |   11 
 drivers/gpu/drm/drm_client_modeset.c                        |    5 
 drivers/gpu/drm/lima/lima_drv.c                             |    1 
 drivers/gpu/drm/mgag200/mgag200_i2c.c                       |    8 
 drivers/i2c/busses/i2c-qcom-geni.c                          |   63 ++++
 drivers/i2c/i2c-smbus.c                                     |   64 +++-
 drivers/irqchip/irq-loongarch-cpu.c                         |    6 
 drivers/irqchip/irq-mbigen.c                                |   20 +
 drivers/irqchip/irq-meson-gpio.c                            |   14 
 drivers/irqchip/irq-xilinx-intc.c                           |    2 
 drivers/md/md.c                                             |    1 
 drivers/md/raid5.c                                          |   20 -
 drivers/media/platform/amphion/vdec.c                       |    2 
 drivers/media/platform/amphion/venc.c                       |    2 
 drivers/media/tuners/xc2028.c                               |    9 
 drivers/media/usb/uvc/uvc_video.c                           |   37 ++
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c              |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c               |  125 ++++----
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h                   |   13 
 drivers/net/dsa/bcm_sf2.c                                   |    4 
 drivers/net/ethernet/freescale/fec_ptp.c                    |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c             |    3 
 drivers/net/usb/qmi_wwan.c                                  |    1 
 drivers/nvme/host/pci.c                                     |    6 
 drivers/platform/x86/intel/ifs/ifs.h                        |   28 +
 drivers/platform/x86/intel/ifs/runtest.c                    |   31 +-
 drivers/power/supply/axp288_charger.c                       |   22 -
 drivers/s390/char/sclp_sd.c                                 |   10 
 drivers/scsi/mpi3mr/mpi3mr_os.c                             |   11 
 drivers/scsi/mpt3sas/mpt3sas_base.c                         |   20 +
 drivers/spi/spi-fsl-lpspi.c                                 |    6 
 drivers/spi/spidev.c                                        |    1 
 drivers/tty/serial/serial_core.c                            |    8 
 drivers/ufs/core/ufshcd.c                                   |   11 
 drivers/usb/gadget/function/u_audio.c                       |   42 ++
 drivers/usb/gadget/function/u_serial.c                      |    1 
 drivers/usb/gadget/udc/core.c                               |   10 
 drivers/usb/serial/usb_debug.c                              |    7 
 drivers/usb/usbip/vhci_hcd.c                                |    9 
 drivers/vhost/vdpa.c                                        |    8 
 fs/btrfs/ctree.h                                            |    1 
 fs/btrfs/file.c                                             |   60 +++-
 fs/btrfs/free-space-cache.c                                 |    1 
 fs/btrfs/print-tree.c                                       |    2 
 fs/ext4/inline.c                                            |    6 
 fs/ext4/mballoc.c                                           |    3 
 fs/jbd2/journal.c                                           |    1 
 fs/smb/client/cifs_debug.c                                  |    2 
 fs/smb/client/cifsglob.h                                    |    8 
 fs/smb/client/smb2pdu.c                                     |    3 
 fs/udf/balloc.c                                             |   36 --
 fs/xfs/xfs_log_recover.c                                    |   20 -
 include/linux/blk-integrity.h                               |   16 -
 include/linux/clocksource.h                                 |   14 
 include/linux/pci_ids.h                                     |    2 
 include/linux/profile.h                                     |    1 
 include/linux/trace_events.h                                |    1 
 include/net/ip6_route.h                                     |   20 -
 include/net/netfilter/nf_tables.h                           |    4 
 include/trace/events/intel_ifs.h                            |   16 -
 kernel/irq/irqdesc.c                                        |    1 
 kernel/jump_label.c                                         |    4 
 kernel/kcov.c                                               |   15 -
 kernel/kprobes.c                                            |    4 
 kernel/padata.c                                             |    7 
 kernel/profile.c                                            |   11 
 kernel/rcu/rcutorture.c                                     |    2 
 kernel/rcu/tree.c                                           |   10 
 kernel/sched/core.c                                         |   27 +
 kernel/sched/cputime.c                                      |    6 
 kernel/sched/stats.c                                        |   10 
 kernel/time/clocksource-wdtest.c                            |   13 
 kernel/time/clocksource.c                                   |   10 
 kernel/time/ntp.c                                           |    9 
 kernel/time/tick-broadcast.c                                |    3 
 kernel/time/timekeeping.c                                   |    2 
 kernel/trace/tracing_map.c                                  |    6 
 mm/huge_memory.c                                            |    2 
 mm/hugetlb.c                                                |   14 
 net/bluetooth/hci_sync.c                                    |   14 
 net/bluetooth/l2cap_core.c                                  |    1 
 net/bridge/br_multicast.c                                   |    4 
 net/core/link_watch.c                                       |    4 
 net/ipv6/ip6_output.c                                       |    1 
 net/ipv6/route.c                                            |    2 
 net/l2tp/l2tp_core.c                                        |   15 -
 net/mptcp/mib.c                                             |    2 
 net/mptcp/mib.h                                             |    2 
 net/mptcp/pm.c                                              |   12 
 net/mptcp/pm_netlink.c                                      |   39 +-
 net/mptcp/pm_userspace.c                                    |   18 +
 net/mptcp/protocol.h                                        |    4 
 net/mptcp/subflow.c                                         |    9 
 net/netfilter/nf_tables_api.c                               |  172 +-----------
 net/netfilter/nft_connlimit.c                               |    4 
 net/netfilter/nft_counter.c                                 |    4 
 net/netfilter/nft_dynset.c                                  |    2 
 net/netfilter/nft_last.c                                    |    4 
 net/netfilter/nft_limit.c                                   |   14 
 net/netfilter/nft_quota.c                                   |    4 
 net/sctp/input.c                                            |   19 -
 net/sunrpc/sched.c                                          |    4 
 net/unix/af_unix.c                                          |   34 --
 net/wireless/nl80211.c                                      |   37 ++
 sound/pci/hda/patch_hdmi.c                                  |    2 
 sound/pci/hda/patch_realtek.c                               |    1 
 sound/soc/amd/yc/acp6x-mach.c                               |    7 
 sound/soc/codecs/wcd938x-sdw.c                              |    4 
 sound/soc/codecs/wsa881x.c                                  |    2 
 sound/soc/codecs/wsa883x.c                                  |   10 
 sound/soc/meson/axg-fifo.c                                  |   26 -
 sound/soc/sof/mediatek/mt8195/mt8195.c                      |    2 
 sound/usb/line6/driver.c                                    |    5 
 sound/usb/quirks-table.h                                    |    4 
 tools/arch/arm64/include/asm/cputype.h                      |    6 
 tools/bpf/bpftool/prog.c                                    |    4 
 tools/testing/selftests/bpf/prog_tests/send_signal.c        |    3 
 tools/testing/selftests/net/mptcp/mptcp_join.sh             |   75 ++++-
 tools/testing/selftests/rcutorture/bin/torture.sh           |    6 
 153 files changed, 1347 insertions(+), 699 deletions(-)

Alex Hung (1):
      drm/amd/display: Add null checker before passing variables

Andi Kleen (1):
      x86/mtrr: Check if fixed MTRRs exist before saving them

Andrey Konovalov (1):
      kcov: properly check for softirq context

Anton Khirnov (1):
      Bluetooth: hci_sync: avoid dup filtering when passive scanning with adv monitor

Arnaldo Carvalho de Melo (1):
      tools headers arm64: Sync arm64's cputype.h with the kernel sources

Arseniy Krasnov (1):
      irqchip/meson-gpio: Convert meson_gpio_irq_controller::lock to 'raw_spinlock_t'

Bart Van Assche (2):
      block: Call .limit_depth() after .hctx has been set
      block/mq-deadline: Fix the tag reservation code

Benjamin Coddington (1):
      SUNRPC: Fix a race to wake a sync task

Besar Wicaksono (1):
      arm64: Add Neoverse-V2 part

Bob Zhou (1):
      drm/amd/pm: Fix the null pointer dereference for vega10_hwmgr

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

Daniele Palmas (2):
      net: usb: qmi_wwan: fix memory leak for not ip packets
      bus: mhi: host: pci_generic: add support for Telit FE990 modem

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

Florian Westphal (2):
      netfilter: nf_tables: allow clone callbacks to sleep
      netfilter: nf_tables: prefer nft_chain_validate

Frederic Weisbecker (1):
      rcu: Fix rcu_barrier() VS post CPUHP_TEARDOWN_CPU invocation

Gaosheng Cui (2):
      i2c: qcom-geni: Add missing clk_disable_unprepare in geni_i2c_runtime_resume
      i2c: qcom-geni: Add missing geni_icc_disable in geni_i2c_runtime_resume

Geert Uytterhoeven (1):
      spi: spidev: Add missing spi_device_id for bh2228fv

Geliang Tang (1):
      mptcp: export local_address

George Kennedy (1):
      serial: core: check uartclk for zero to avoid divide by zero

Greg Kroah-Hartman (2):
      Revert "bpftool: Mount bpffs when pinmaps path not under the bpffs"
      Linux 6.1.105

Guenter Roeck (2):
      i2c: smbus: Improve handling of stuck alerts
      i2c: smbus: Send alert notifications to all devices if source not found

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

Jerome Brunet (1):
      ASoC: meson: axg-fifo: fix irq scheduling issue with PREEMPT_RT

Jithu Joseph (1):
      platform/x86/intel/ifs: Gen2 Scan test support

Joe Hattori (1):
      net: dsa: bcm_sf2: Fix a possible memory leak in bcm_sf2_mdio_register()

Johannes Berg (2):
      wifi: nl80211: disallow setting special AP channel widths
      wifi: nl80211: don't give key data to userspace

Justin Stitt (2):
      ntp: Clamp maxerror and esterror to operating range
      ntp: Safeguard against time_constant overflow

Kemeng Shi (2):
      jbd2: avoid memleak in jbd2_journal_write_metadata_buffer
      ext4: fix wrong unit use in ext4_mb_find_by_goal

Krzysztof Kozlowski (3):
      ASoC: codecs: wcd938x-sdw: Correct Soundwire ports mask
      ASoC: codecs: wsa881x: Correct Soundwire ports mask
      ASoC: codecs: wsa883x: Correct Soundwire ports mask

Kuniyuki Iwashima (2):
      sctp: Fix null-ptr-deref in reuseport_add_sock().
      af_unix: Don't retry after unix_state_lock_nested() in unix_stream_connect().

Kuppuswamy Sathyanarayanan (1):
      platform/x86/intel/ifs: Initialize union ifs_status to zero

Li Nan (1):
      md: do not delete safemode_timer in mddev_suspend

Lucas Stach (1):
      drm/bridge: analogix_dp: properly handle zero sized AUX transactions

Ma Jun (4):
      drm/amdgpu/pm: Fix the param type of set_power_profile_mode
      drm/amdgpu/pm: Fix the null pointer dereference for smu7
      drm/amdgpu: Fix the null pointer dereference to ras_manager
      drm/amdgpu/pm: Fix the null pointer dereference in apply_state_adjust_rules

Ma Ke (1):
      drm/client: fix null pointer dereference in drm_client_modeset_probe

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

Matthieu Baerts (NGI0) (5):
      mptcp: mib: count MPJ with backup flag
      mptcp: pm: fix backup support in signal endpoints
      selftests: mptcp: join: validate backup in MPJ
      selftests: mptcp: join: check backup support in signal endp
      mptcp: pm: deny endp with signal + subflow + port

Menglong Dong (1):
      bpf: kprobe: remove unused declaring of bpf_kprobe_override

Miaohe Lin (1):
      mm/hugetlb: fix potential race in __update_and_free_hugetlb_folio()

Michal Pecio (1):
      media: uvcvideo: Fix the bandwdith quirk on USB 3.x

Mikulas Patocka (1):
      block: change rq_integrity_vec to respect the iterator

Ming Qian (1):
      media: amphion: Remove lock in s_ctrl callback

Neil Armstrong (1):
      i2c: qcom-geni: add desc struct to prepare support for I2C Master Hub variant

Nicolas Dichtel (1):
      ipv6: fix source address selection with route leak

Niklas Söderlund (1):
      clocksource/drivers/sh_cmt: Address race condition for clock events

Nikolay Aleksandrov (1):
      net: bridge: mcast: wait for previous gc cycles when removing port

Oliver Neukum (1):
      usb: vhci-hcd: Do not drop references before new references are gained

Pablo Neira Ayuso (1):
      netfilter: nf_tables: bail out if stateful expression provides no .clone

Paul E. McKenney (3):
      rcutorture: Fix rcu_torture_fwd_cb_cr() data race
      torture: Enable clocksource watchdog with "tsc=watchdog"
      clocksource: Fix brown-bag boolean thinko in cs_watchdog_read()

Peter Oberparleiter (1):
      s390/sclp: Prevent release of buffer in I/O

Peter Zijlstra (3):
      jump_label: Fix the fix, brown paper bags galore
      x86/mm: Fix pti_clone_pgtable() alignment assumption
      x86/mm: Fix pti_clone_entry_text() for i386

Prashanth K (1):
      usb: gadget: u_serial: Set start_delayed during suspend

Qu Wenruo (1):
      btrfs: avoid using fixed char array size for tree names

Radhey Shyam Pandey (1):
      irqchip/xilinx: Fix shift out of bounds

Ricardo Ribalda (1):
      media: uvcvideo: Ignore empty TS packets

Roman Smirnov (1):
      udf: prevent integer overflow in udf_bitmap_free_blocks()

Shay Drory (1):
      genirq/irqdesc: Honor caller provided affinity in alloc_desc()

Srinivas Kandagatla (1):
      ASoC: codecs: wsa883x: parse port-mapping information

Srinivasan Shanmugam (1):
      drm/amd/display: Add NULL check for 'afb' before dereferencing in amdgpu_dm_plane_handle_cursor_update

Stefan Wahren (1):
      spi: spi-fsl-lpspi: Fix scldiv calculation

Steve French (1):
      smb3: fix setting SecurityFlags when encryption is required

Steven 'Steve' Kendall (1):
      ALSA: hda: Add HP MP9 G4 Retail System AMS to force connect list

Takashi Iwai (4):
      ALSA: usb-audio: Re-add ScratchAmp quirk entries
      ALSA: line6: Fix racy access to midibuf
      ALSA: hda/hdmi: Yet more pin fix for HP EliteDesk 800 G4
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

Tze-nan Wu (1):
      tracing: Fix overflow in get_free_elt()

Vamshi Gajjela (1):
      scsi: ufs: core: Fix hba->last_dme_cmd_tstamp timestamp updating logic

Victor Skvortsov (1):
      drm/amdgpu: Add lock around VF RLCG interface

Waiman Long (1):
      padata: Fix possible divide-by-0 panic in padata_mt_helper()

Wayne Lin (1):
      drm/dp_mst: Skip CSN if topology probing is not done yet

Xiaxi Shen (1):
      ext4: fix uninitialized variable in ext4_inlinedir_to_tree

Yang Shi (1):
      mm: huge_memory: use !CONFIG_64BIT to relax huge page alignment on 32 bit machines

Yang Yingliang (3):
      sched/smt: Introduce sched_smt_present_inc/dec() helper
      sched/smt: Fix unbalance sched_smt_present dec/inc
      i2c: qcom-geni: fix missing clk_disable_unprepare() and geni_se_resources_off()

Yipeng Zou (1):
      irqchip/mbigen: Fix mbigen node address layout

Yonghong Song (1):
      selftests/bpf: Fix send_signal test with nested CONFIG_PARAVIRT

Yu Kuai (1):
      md/raid5: avoid BUG_ON() while continue reshape after reassembling

Zheng Zucheng (1):
      sched/cputime: Fix mul_u64_u64_div_u64() precision for cputime


