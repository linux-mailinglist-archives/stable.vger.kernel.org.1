Return-Path: <stable+bounces-55955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6266891A607
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 14:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F47CB2157B
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 12:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD4814F12D;
	Thu, 27 Jun 2024 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dE5lev3I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F9114F11C;
	Thu, 27 Jun 2024 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489711; cv=none; b=pvJj+2KzPbTtd9cFDHtWGkLY82rqg6ZvksGHSSSYoRVW6WROSxqWrsYPog7OO/Fcif0WNH3ZUGx0gItesSs1jy4ggnzWYzUY0IPAR/4wlzH2KfmuTqO7QF6/UwXSOEEZnQIA3BQYWYPH2RaZmd5SU4PksqAW4zGescMNZpaRF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489711; c=relaxed/simple;
	bh=MMg/LQ69hmJSvP7kSAurnCAOsuEJBodJDYecuU8H5PM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r2ui4PZncvhh+PEVkqTglR8jpJE24kRsnzvxFn8NCc3owjzbfR9PVVaF31iDBwaln6r+GLgvHkAMN1jS2JC3cRfhRzbhHoGxrNXGeEEkmLvnz/K3gDiJ5Og+n2jGBE2DWKs6ZiKVnlPXFsa45KMCZiZxKYbcunpcVMTKHnacOds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dE5lev3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A1EC2BBFC;
	Thu, 27 Jun 2024 12:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719489710;
	bh=MMg/LQ69hmJSvP7kSAurnCAOsuEJBodJDYecuU8H5PM=;
	h=From:To:Cc:Subject:Date:From;
	b=dE5lev3I5bfUFdNeQCdzFOX7SzfG1H7f1IcYrokL5g0GkW0FXA+yE4hA95ecJSgk8
	 JblDzseTJ5MHr3ClV2tuQy7AiiPguWmxeceSpOZqEWB8f7ADQEZK2bDqa6fWrRkZ/K
	 ydnfzgsTIOQyv5q8Z2h8G4X8NDig8MLvjIZFF+jw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.96
Date: Thu, 27 Jun 2024 14:01:44 +0200
Message-ID: <2024062745-cache-popcorn-0e44@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.96 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml |    2 
 Makefile                                                             |    7 
 arch/arm/boot/dts/exynos4210-smdkv310.dts                            |    2 
 arch/arm/boot/dts/exynos4412-origen.dts                              |    2 
 arch/arm/boot/dts/exynos4412-smdk4412.dts                            |    2 
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi                     |    2 
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts                         |    2 
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts                    |    1 
 arch/arm64/kvm/vgic/vgic-init.c                                      |    2 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                                   |   15 +
 arch/arm64/kvm/vgic/vgic.h                                           |    2 
 arch/mips/bmips/setup.c                                              |    3 
 arch/mips/boot/dts/brcm/bcm63268.dtsi                                |    2 
 arch/mips/pci/ops-rc32434.c                                          |    4 
 arch/mips/pci/pcie-octeon.c                                          |    6 
 arch/powerpc/include/asm/hvcall.h                                    |    8 
 arch/powerpc/include/asm/io.h                                        |   24 +-
 arch/x86/include/asm/cpu_device_id.h                                 |   98 ++++++++++
 arch/x86/kernel/cpu/match.c                                          |    4 
 arch/x86/kvm/x86.c                                                   |    9 
 block/ioctl.c                                                        |    2 
 drivers/acpi/acpica/exregion.c                                       |   23 --
 drivers/bluetooth/ath3k.c                                            |   25 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c                           |    4 
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c                       |    6 
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h                                |    1 
 drivers/dma/idxd/irq.c                                               |    4 
 drivers/dma/ioat/init.c                                              |   67 +++---
 drivers/dma/ioat/registers.h                                         |    7 
 drivers/firmware/psci/psci.c                                         |    4 
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c                           |    2 
 drivers/gpu/drm/i915/display/intel_dp.c                              |    4 
 drivers/gpu/drm/lima/lima_bcast.c                                    |   12 +
 drivers/gpu/drm/lima/lima_bcast.h                                    |    3 
 drivers/gpu/drm/lima/lima_gp.c                                       |    8 
 drivers/gpu/drm/lima/lima_pp.c                                       |   18 +
 drivers/gpu/drm/lima/lima_sched.c                                    |    7 
 drivers/gpu/drm/lima/lima_sched.h                                    |    1 
 drivers/gpu/drm/radeon/sumo_dpm.c                                    |    2 
 drivers/hid/hid-asus.c                                               |   49 ++---
 drivers/hid/hid-ids.h                                                |    1 
 drivers/hid/hid-multitouch.c                                         |    6 
 drivers/i2c/busses/i2c-ocores.c                                      |    2 
 drivers/infiniband/hw/mlx5/srq.c                                     |   13 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                          |    2 
 drivers/net/dsa/realtek/rtl8366rb.c                                  |   87 ++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                            |    5 
 drivers/net/ethernet/intel/ice/ice.h                                 |    1 
 drivers/net/ethernet/intel/ice/ice_idc.c                             |   52 +++++
 drivers/net/ethernet/intel/ice/ice_main.c                            |   36 +--
 drivers/net/ethernet/intel/ice/ice_switch.c                          |    6 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c               |    5 
 drivers/net/ethernet/microchip/lan743x_ethtool.c                     |   44 ++++
 drivers/net/ethernet/microchip/lan743x_main.c                        |   48 ++++
 drivers/net/ethernet/microchip/lan743x_main.h                        |   28 ++
 drivers/net/ethernet/qualcomm/qca_debug.c                            |    6 
 drivers/net/ethernet/qualcomm/qca_spi.c                              |   16 -
 drivers/net/ethernet/qualcomm/qca_spi.h                              |    3 
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c                |    6 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                      |   40 ++--
 drivers/net/phy/mxl-gpy.c                                            |   93 ++++++---
 drivers/net/usb/ax88179_178a.c                                       |   18 +
 drivers/net/usb/rtl8150.c                                            |    3 
 drivers/net/virtio_net.c                                             |   12 +
 drivers/net/wireless/ath/ath.h                                       |    6 
 drivers/net/wireless/ath/ath9k/main.c                                |    3 
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c                      |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c                  |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c                 |    2 
 drivers/net/wireless/mediatek/mt76/sdio.c                            |    3 
 drivers/pci/pci.c                                                    |   12 +
 drivers/platform/x86/p2sb.c                                          |   29 +-
 drivers/platform/x86/toshiba_acpi.c                                  |   36 +++
 drivers/power/supply/cros_usbpd-charger.c                            |   11 -
 drivers/ptp/ptp_sysfs.c                                              |    3 
 drivers/regulator/bd71815-regulator.c                                |    2 
 drivers/regulator/core.c                                             |    1 
 drivers/scsi/qedi/qedi_debugfs.c                                     |   12 -
 drivers/soc/ti/ti_sci_pm_domains.c                                   |   20 +-
 drivers/spi/spi-stm32-qspi.c                                         |   12 -
 drivers/tty/serial/8250/8250_exar.c                                  |   42 ++++
 drivers/tty/serial/imx.c                                             |    7 
 drivers/tty/tty_ldisc.c                                              |    6 
 drivers/tty/vt/vt.c                                                  |   10 +
 drivers/usb/dwc3/dwc3-pci.c                                          |    8 
 drivers/usb/gadget/function/f_hid.c                                  |    6 
 drivers/usb/gadget/function/f_printer.c                              |    6 
 drivers/usb/gadget/function/rndis.c                                  |    4 
 drivers/usb/misc/uss720.c                                            |   20 +-
 fs/btrfs/block-group.c                                               |   11 -
 fs/f2fs/super.c                                                      |    2 
 fs/smb/client/cifsfs.c                                               |    2 
 fs/udf/udftime.c                                                     |   11 -
 include/linux/kcov.h                                                 |    2 
 include/linux/mod_devicetable.h                                      |    2 
 include/linux/tty_driver.h                                           |    8 
 include/net/sch_generic.h                                            |    1 
 io_uring/sqpoll.c                                                    |    8 
 kernel/gcov/gcc_4_7.c                                                |    4 
 kernel/gen_kheaders.sh                                               |    9 
 kernel/kcov.c                                                        |    1 
 kernel/padata.c                                                      |    8 
 kernel/rcu/rcutorture.c                                              |   16 -
 kernel/trace/Kconfig                                                 |    4 
 kernel/trace/preemptirq_delay_test.c                                 |    1 
 mm/page_table_check.c                                                |   11 +
 net/batman-adv/originator.c                                          |    2 
 net/core/drop_monitor.c                                              |   20 +-
 net/core/filter.c                                                    |    5 
 net/core/net_namespace.c                                             |    9 
 net/core/netpoll.c                                                   |    2 
 net/core/sock.c                                                      |    3 
 net/ipv4/cipso_ipv4.c                                                |   12 -
 net/ipv4/tcp_input.c                                                 |    1 
 net/ipv6/route.c                                                     |    4 
 net/ipv6/seg6_local.c                                                |    8 
 net/ipv6/xfrm6_policy.c                                              |    8 
 net/netfilter/ipset/ip_set_core.c                                    |   11 -
 net/netrom/nr_timer.c                                                |    3 
 net/packet/af_packet.c                                               |   26 +-
 net/sched/act_api.c                                                  |   66 ++++--
 net/sched/act_ct.c                                                   |   16 +
 net/sched/sch_api.c                                                  |    1 
 net/sched/sch_generic.c                                              |    4 
 net/sched/sch_htb.c                                                  |   22 --
 net/tipc/node.c                                                      |    1 
 sound/hda/intel-dsp-config.c                                         |    2 
 sound/pci/hda/patch_realtek.c                                        |   10 -
 sound/soc/intel/boards/sof_sdw.c                                     |    9 
 tools/perf/Documentation/perf-script.txt                             |    7 
 tools/perf/builtin-script.c                                          |   24 +-
 tools/testing/selftests/arm64/tags/tags_test.c                       |    4 
 tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c              |   26 --
 tools/testing/selftests/bpf/test_tc_tunnel.sh                        |   13 +
 virt/kvm/kvm_main.c                                                  |    5 
 135 files changed, 1109 insertions(+), 560 deletions(-)

Adrian Hunter (1):
      perf script: Show also errors for --insn-trace option

Ajrat Makhmutov (1):
      ALSA: hda/realtek: Enable headset mic on IdeaPad 330-17IKB 81DM

Aleksandr Aprelkov (1):
      iommu/arm-smmu-v3: Free MSIs in case of ENOMEM

Aleksandr Nogikh (1):
      kcov: don't lose track of remote references during softirqs

Alessandro Carminati (Red Hat) (1):
      selftests/bpf: Prevent client connect before server bind in test_tc_tunnel.sh

Alex Deucher (2):
      drm/radeon: fix UBSAN warning in kv_dpm.c
      drm/amdgpu: fix UBSAN warning in kv_dpm.c

Alex Henrie (1):
      usb: misc: uss720: check for incompatible versions of the Belkin F5U002

Andrew Ballance (1):
      hid: asus: asus_report_fixup: fix potential read out of bounds

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for ProBook 445/465 G11.

Arnd Bergmann (1):
      wifi: ath9k: work around memset overflow warning

Arvid Norlander (1):
      platform/x86: toshiba_acpi: Add quirk for buttons on Z830

Ben Fradella (1):
      platform/x86: p2sb: Don't init until unassigned resources have been assigned

Biju Das (1):
      regulator: core: Fix modpost error "regulator_get_regmap" undefined

Bjorn Helgaas (2):
      dmaengine: ioat: Drop redundant pci_enable_pcie_error_reporting()
      dmaengine: ioat: use PCI core macros for PCIe Capability

Boris Burkov (1):
      btrfs: retry block group reclaim without infinite loop

Breno Leitao (2):
      netpoll: Fix race condition in netpoll_owner_active
      KVM: Fix a data race on last_boosted_vcpu in kvm_vcpu_on_spin()

Changbin Du (1):
      perf: script: add raw|disasm arguments to --insn-trace option

Chenghai Huang (1):
      crypto: hisilicon/sec - Fix memory leak for sec resource release

Christian Marangi (1):
      mips: bmips: BCM6358: make sure CBR is correctly set

Christophe JAILLET (1):
      usb: gadget: function: Remove usage of the deprecated ida_simple_xx() API

Dan Carpenter (1):
      ptp: fix integer overflow in max_vclocks_store

David Ruth (1):
      net/sched: act_api: fix possible infinite loop in tcf_idr_check_alloc()

Davide Caratti (2):
      net/sched: fix false lockdep warning on qdisc root lock
      net/sched: unregister lockdep keys in qdisc_create/qdisc_alloc error path

Dustin L. Howett (1):
      ALSA: hda/realtek: Remove Framework Laptop 16 from quirks

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Limit mic boost on N14AP7

En-Wei Wu (1):
      ice: avoid IRQ collision to fix init failure on ACPI S3 resume

Eric Dumazet (6):
      batman-adv: bypass empty buckets in batadv_purge_orig_ref()
      af_packet: avoid a false positive warning in packet_setsockopt()
      ipv6: prevent possible NULL deref in fib6_nh_init()
      ipv6: prevent possible NULL dereference in rt6_probe()
      xfrm6: check ip6_dst_idev() return value in xfrm6_get_saddr()
      tcp: clear tp->retrans_stamp in tcp_rcv_fastopen_synack()

Erico Nunes (2):
      drm/lima: add mask irq callback to gp and pp
      drm/lima: mask irqs in timeout path before hard reset

Esben Haabendal (1):
      serial: imx: Introduce timeout when waiting on transmitter empty

Fabio Estevam (1):
      arm64: dts: imx93-11x11-evk: Remove the 'no-sdio' property

Florian Fainelli (1):
      MIPS: dts: bcm63268: Add missing properties to the TWD node

Florian Westphal (1):
      bpf: Avoid splat in pskb_pull_reason

Frank Li (1):
      arm64: dts: imx8qm-mek: fix gpio number for reg_usdhc2_vmmc

Gavrilov Ilia (1):
      netrom: Fix a memory leak in nr_heartbeat_expiry()

Greg Kroah-Hartman (1):
      Linux 6.1.96

Grygorii Tertychnyi (1):
      i2c: ocores: set IACK bit after core is enabled

Hans de Goede (1):
      usb: dwc3: pci: Don't set "linux,phy_charger_detect" property on Lenovo Yoga Tab2 1380

Heng Qi (1):
      virtio_net: checksum offloading handling fix

Herbert Xu (1):
      padata: Disable BH when taking works lock on MT path

Ignat Korchagin (1):
      net: do not leave a dangling sk pointer, when socket creation fails

Ilpo Järvinen (1):
      MIPS: Routerboard 532: Fix vendor retry check code

Jani Nikula (1):
      drm/i915/mso: using joiner is not possible with eDP MSO

Jeff Johnson (1):
      tracing: Add MODULE_DESCRIPTION() to preemptirq_delay_test

Jens Axboe (1):
      io_uring/sqpoll: work around a potential audit memory leak

Jianguo Wu (1):
      seg6: fix parameter passing when calling NF_HOOK() in End.DX4 and End.DX6 behaviors

Joao Pinto (1):
      Avoid hw_desc array overrun in dw-axi-dmac

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: improve reset check

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix suspicious rcu_dereference_protected()

Justin Stitt (1):
      block/ioctl: prefer different overflow check

Kalle Niemi (1):
      regulator: bd71815: fix ramp values

Krzysztof Kozlowski (4):
      dt-bindings: i2c: google,cros-ec-i2c-tunnel: correct path to i2c-controller schema
      ARM: dts: samsung: smdkv310: fix keypad no-autorepeat
      ARM: dts: samsung: exynos4412-origen: fix keypad no-autorepeat
      ARM: dts: samsung: smdk4412: fix keypad no-autorepeat

Kunwu Chan (1):
      kselftest: arm64: Add a null pointer check

Leon Yen (1):
      wifi: mt76: mt7921s: fix potential hung tasks during chip recovery

Li RongQing (1):
      dmaengine: idxd: Fix possible Use-After-Free in irq_process_work_list

Linus Torvalds (2):
      tty: add the option to have a tty reject a new ldisc
      Revert "mm: mmap: allow for the maximum number of bits for randomizing mmap_base by default"

Luiz Angelo Daros de Luca (1):
      net: dsa: realtek: keep default LED state in rtl8366rb

Luke D. Jones (1):
      HID: asus: fix more n-key report descriptors if n-key quirked

Manish Rangankar (1):
      scsi: qedi: Fix crash while reading debugfs attribute

Marc Zyngier (1):
      KVM: arm64: Disassociate vcpus from redistributor region on teardown

Marcin Szycik (1):
      ice: Fix VSI list rule with ICE_SW_LKUP_LAST type

Mario Limonciello (1):
      PCI/PM: Avoid D3cold for HP Pavilion 17 PC/1972 PCIe Ports

Martin Leung (1):
      drm/amd/display: revert Exit idle optimizations before HDCP execution

Masahiro Yamada (1):
      Revert "kheaders: substituting --sort in archive creation"

Masami Hiramatsu (Google) (1):
      tracing: Build event generation tests only as modules

Matthias Maennich (1):
      kheaders: explicitly define file modes for archived headers

Max Krummenacher (1):
      arm64: dts: freescale: imx8mm-verdin: enable hysteresis on slow input pin

Michael Ellerman (1):
      powerpc/io: Avoid clang null pointer arithmetic warnings

Michal Swiatkowski (1):
      ice: move RDMA init to ice_idc.c

Nathan Chancellor (1):
      kbuild: Remove support for Clang's ThinLTO caching

Nathan Lynch (1):
      powerpc/pseries: Enforce hcall result buffer validity and size

Nicholas Kazlauskas (1):
      drm/amd/display: Exit idle optimizations before HDCP execution

Nikita Shubin (4):
      dmaengine: ioatdma: Fix leaking on version mismatch
      dmaengine: ioatdma: Fix error path in ioat3_dma_probe()
      dmaengine: ioatdma: Fix kmemleak in ioat_pci_probe()
      dmaengine: ioatdma: Fix missing kmem_cache_destroy()

Oleksij Rempel (1):
      net: stmmac: Assign configured channel value to EXTTS event

Oliver Neukum (1):
      net: usb: rtl8150 fix unintiatilzed variables in rtl8150_get_link_ksettings

Ondrej Mosnacek (1):
      cipso: fix total option length computation

Parker Newman (1):
      serial: exar: adding missing CTI and Exar PCI ids

Patrice Chotard (2):
      spi: stm32: qspi: Fix dual flash mode sanity test in stm32_qspi_setup()
      spi: stm32: qspi: Clamp stm32_qspi_get_mode() output to CCR_BUSWIDTH_4

Patrisious Haddad (1):
      RDMA/mlx5: Add check for srq max_sge attribute

Paul E. McKenney (1):
      rcutorture: Fix rcu_torture_one_read() pipe_count overflow comment

Pavan Chebbi (1):
      bnxt_en: Restore PTP tx_avail count in case of skb_pad() error

Pedro Tammela (1):
      net/sched: act_api: rely on rcu in tcf_idr_check_alloc

Peter Oberparleiter (1):
      gcov: add support for GCC 14

Peter Ujfalusi (1):
      ALSA/hda: intel-dsp-config: Document AVS as dsp_driver option

Peter Xu (1):
      mm/page_table_check: fix crash on ZONE_DEVICE

Pierre-Louis Bossart (1):
      ASoC: Intel: sof_sdw: add JD2 quirk for HP Omen 14

Rafael Aquini (1):
      mm: mmap: allow for the maximum number of bits for randomizing mmap_base by default

Raju Lakkaraju (3):
      net: lan743x: disable WOL upon resume to restore full data path operation
      net: lan743x: Support WOL at both the PHY and MAC appropriately
      net: phy: mxl-gpy: Remove interrupt mask clearing from config_init

Raju Rangoju (1):
      ACPICA: Revert "ACPICA: avoid Info: mapping multiple BARs. Your kernel is fine."

Roman Smirnov (1):
      udf: udftime: prevent overflow in udf_disk_stamp_to_time()

Sean Christopherson (1):
      KVM: x86: Always sync PIR to IRR prior to scanning I/O APIC routes

Sean O'Brien (1):
      HID: Add quirk for Logitech Casa touchpad

Simon Horman (1):
      octeontx2-pf: Add error handling to VLAN unoffload handling

Songyang Li (1):
      MIPS: Octeon: Add PCIe link status check

Stefan Binding (1):
      ALSA: hda/realtek: Add quirks for Lenovo 13X

Stefan Wahren (1):
      qca_spi: Make interrupt remembering atomic

Steve French (1):
      cifs: fix typo in module parameter enable_gcm_256

Sudeep Holla (1):
      firmware: psci: Fix return value from psci_system_suspend()

Tomi Valkeinen (1):
      pmdomain: ti-sci: Fix duplicate PD referrals

Tony Luck (2):
      x86/cpu/vfm: Add new macros to work with (vendor/family/model) values
      x86/cpu: Fix x86_match_cpu() to match just X86_VENDOR_INTEL

Tzung-Bi Shih (1):
      power: supply: cros_usbpd: provide ID table for avoiding fallback match

Uri Arev (1):
      Bluetooth: ath3k: Fix multiple issues reported by checkpatch.pl

Wander Lairson Costa (1):
      drop_monitor: replace spin_lock by raw_spin_lock

Xiaolei Wang (1):
      net: stmmac: No need to calculate speed divider when offload is disabled

Xin Long (2):
      tipc: force a dst refcount before doing decryption
      sched: act_ct: add netns into the key of tcf_ct_flow_table

Xu Liang (1):
      net: phy: mxl-gpy: enhance delay time required by loopback disable function

Yonghong Song (1):
      selftests/bpf: Fix flaky test btf_map_in_map/lookup_update

Yue Haibing (1):
      netns: Make get_net_ns() handle zero refcount net

Yunlei He (1):
      f2fs: remove clear SB_INLINECRYPT flag in default_options

Zqiang (2):
      rcutorture: Make stall-tasks directly exit when rcutorture tests end
      rcutorture: Fix invalid context warning when enable srcu barrier testing


