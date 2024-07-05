Return-Path: <stable+bounces-58110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BDA9282AB
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 09:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9252CB22F4F
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 07:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0384114386C;
	Fri,  5 Jul 2024 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jjghX/jQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD7513BC11;
	Fri,  5 Jul 2024 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720164617; cv=none; b=HKND6ZBEKUmBW+vFgBbfWBobQe920rOy2L8wsh3t01xumvVqgewn0KV+5CWEG0F3SnaGBBP4I8zBZ8dDuqPgZT3Vh/m79cwc2ba+afeOW9WrELzJuYrdOaoPj9ZocPIkebyVEOxxX4sYITzERu5ZRgMq4+8kpvY2N0YljmCeJT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720164617; c=relaxed/simple;
	bh=5QyyPOdVuMlXBisCy5/BJAi02/g1ns9d/xd/4fl5b9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hO5+JsFmZE1+rwsk80hFJ4QpxBV+ZYaSt8bu1yTaq4gadcRTiCm3llB+NCohIhTQOJVWW9VWHuMOOlYKIM9AB8ZJcGzpCfMOk38hjE2Rj8AFbvI1mS02YeIV54HnOnDcRoQh8iElDus8MX6P/VA0pLfncISRhwrOsUUsXRLNl+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jjghX/jQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F7EC32786;
	Fri,  5 Jul 2024 07:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720164617;
	bh=5QyyPOdVuMlXBisCy5/BJAi02/g1ns9d/xd/4fl5b9I=;
	h=From:To:Cc:Subject:Date:From;
	b=jjghX/jQQ4y/3h0/1Jsxag9FophVDw/jfamty/KRKBZwyyw9IeQqd4FIsn9fM6Y9J
	 OLhJnSGytvoBn14Xv4dWxj7833XoY4hfED4U+8lVchluzIH/PBsm0ymOYkz+VJKQ9A
	 YxMUjwdHajbuTYIdQtChVxRqu7tHUxhCXXg3NKhs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.279
Date: Fri,  5 Jul 2024 09:30:12 +0200
Message-ID: <2024070510-superbowl-bony-e5ce@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.279 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                         |    2 
 arch/arm/boot/dts/exynos4210-smdkv310.dts                        |    2 
 arch/arm/boot/dts/exynos4412-origen.dts                          |    2 
 arch/arm/boot/dts/exynos4412-smdk4412.dts                        |    2 
 arch/arm/boot/dts/rk3066a.dtsi                                   |    1 
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi                         |    2 
 arch/arm64/boot/dts/rockchip/rk3368.dtsi                         |    3 
 arch/csky/include/uapi/asm/unistd.h                              |    1 
 arch/hexagon/include/asm/syscalls.h                              |    6 
 arch/hexagon/include/uapi/asm/unistd.h                           |    1 
 arch/hexagon/kernel/syscalltab.c                                 |    7 
 arch/mips/bmips/setup.c                                          |    3 
 arch/mips/pci/ops-rc32434.c                                      |    4 
 arch/mips/pci/pcie-octeon.c                                      |    6 
 arch/parisc/kernel/syscalls/syscall.tbl                          |    4 
 arch/powerpc/include/asm/hvcall.h                                |    8 
 arch/powerpc/include/asm/io.h                                    |   24 
 arch/sparc/kernel/syscalls/syscall.tbl                           |    2 
 arch/x86/kernel/amd_nb.c                                         |    9 
 arch/x86/kernel/time.c                                           |   20 
 drivers/acpi/acpica/exregion.c                                   |   23 
 drivers/ata/libata-core.c                                        |    8 
 drivers/base/core.c                                              |    3 
 drivers/bluetooth/ath3k.c                                        |   25 
 drivers/dma/dma-axi-dmac.c                                       |    2 
 drivers/dma/ioat/init.c                                          |    1 
 drivers/gpio/Kconfig                                             |    2 
 drivers/gpio/gpio-davinci.c                                      |    5 
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                              |    2 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c      |    6 
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c       |    2 
 drivers/gpu/drm/bridge/panel.c                                   |    7 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c                         |    7 
 drivers/gpu/drm/exynos/exynos_hdmi.c                             |    7 
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c                        |    6 
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c                    |    6 
 drivers/gpu/drm/radeon/sumo_dpm.c                                |    2 
 drivers/greybus/interface.c                                      |    1 
 drivers/hid/hid-core.c                                           |    1 
 drivers/hid/hid-logitech-dj.c                                    |    4 
 drivers/hv/hv_util.c                                             |   19 
 drivers/hwtracing/intel_th/pci.c                                 |   25 
 drivers/i2c/busses/i2c-at91-slave.c                              |    3 
 drivers/i2c/busses/i2c-ocores.c                                  |    2 
 drivers/iio/adc/ad7266.c                                         |    2 
 drivers/iio/chemical/bme680.h                                    |    2 
 drivers/iio/chemical/bme680_core.c                               |   62 +-
 drivers/iio/dac/ad5592r-base.c                                   |   56 -
 drivers/iio/dac/ad5592r-base.h                                   |    1 
 drivers/input/input.c                                            |  105 ++-
 drivers/iommu/amd_iommu_init.c                                   |    9 
 drivers/media/dvb-core/dvbdev.c                                  |    2 
 drivers/misc/mei/pci-me.c                                        |    4 
 drivers/misc/vmw_vmci/vmci_event.c                               |    6 
 drivers/mmc/host/sdhci-pci-core.c                                |   11 
 drivers/mmc/host/sdhci.c                                         |   25 
 drivers/mtd/nand/spi/macronix.c                                  |   99 +++
 drivers/mtd/parsers/redboot.c                                    |    2 
 drivers/net/dsa/microchip/ksz9477.c                              |    6 
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c                |   11 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                 |   14 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                |    3 
 drivers/net/ethernet/mellanox/mlx5/core/fw.c                     |    4 
 drivers/net/ethernet/mellanox/mlx5/core/health.c                 |    8 
 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c            |    4 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                  |    4 
 drivers/net/phy/micrel.c                                         |   15 
 drivers/net/usb/ax88179_178a.c                                   |    6 
 drivers/net/usb/rtl8150.c                                        |    3 
 drivers/net/virtio_net.c                                         |   12 
 drivers/net/vxlan.c                                              |    4 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                     |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                      |   10 
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h                      |    9 
 drivers/pci/controller/pcie-rockchip-ep.c                        |    6 
 drivers/pci/pci.c                                                |   12 
 drivers/pinctrl/core.c                                           |    2 
 drivers/pinctrl/pinctrl-rockchip.c                               |   63 +-
 drivers/ptp/ptp_chardev.c                                        |    3 
 drivers/pwm/pwm-stm32.c                                          |    3 
 drivers/regulator/core.c                                         |    1 
 drivers/scsi/mpt3sas/mpt3sas_base.c                              |   19 
 drivers/scsi/qedi/qedi_debugfs.c                                 |   12 
 drivers/soc/ti/wkup_m3_ipc.c                                     |    7 
 drivers/tty/serial/mcf.c                                         |    2 
 drivers/tty/serial/sc16is7xx.c                                   |   25 
 drivers/usb/atm/cxacru.c                                         |   14 
 drivers/usb/class/cdc-wdm.c                                      |    4 
 drivers/usb/gadget/function/f_fs.c                               |    4 
 drivers/usb/gadget/function/f_printer.c                          |    1 
 drivers/usb/host/xhci-pci.c                                      |    7 
 drivers/usb/host/xhci-ring.c                                     |    5 
 drivers/usb/misc/uss720.c                                        |   20 
 drivers/usb/musb/da8xx.c                                         |    8 
 drivers/usb/storage/alauda.c                                     |    9 
 fs/jfs/xattr.c                                                   |    4 
 fs/nfs/read.c                                                    |    4 
 fs/nilfs2/dir.c                                                  |   59 -
 fs/nilfs2/segment.c                                              |    3 
 fs/ocfs2/file.c                                                  |    2 
 fs/ocfs2/namei.c                                                 |    2 
 fs/open.c                                                        |    4 
 fs/proc/vmcore.c                                                 |    2 
 fs/udf/udftime.c                                                 |   11 
 include/linux/compat.h                                           |    2 
 include/linux/iommu.h                                            |    2 
 include/linux/micrel_phy.h                                       |    1 
 include/linux/nvme.h                                             |    4 
 include/linux/pci.h                                              |    9 
 include/linux/syscalls.h                                         |    2 
 include/net/bluetooth/hci_core.h                                 |   36 +
 include/net/netfilter/nf_tables.h                                |    5 
 include/uapi/asm-generic/hugetlb_encode.h                        |   24 
 kernel/events/core.c                                             |   13 
 kernel/gcov/gcc_4_7.c                                            |    4 
 kernel/gen_kheaders.sh                                           |    9 
 kernel/rcu/rcutorture.c                                          |    3 
 kernel/time/tick-common.c                                        |   42 -
 kernel/trace/preemptirq_delay_test.c                             |    1 
 net/batman-adv/originator.c                                      |   29 
 net/bluetooth/l2cap_core.c                                       |    8 
 net/can/j1939/main.c                                             |    6 
 net/can/j1939/transport.c                                        |   21 
 net/core/drop_monitor.c                                          |   20 
 net/core/net_namespace.c                                         |    9 
 net/core/sock.c                                                  |    6 
 net/ipv4/af_inet.c                                               |   23 
 net/ipv4/cipso_ipv4.c                                            |   12 
 net/ipv4/tcp.c                                                   |   16 
 net/ipv6/af_inet6.c                                              |   24 
 net/ipv6/ip6_fib.c                                               |    6 
 net/ipv6/ipv6_sockglue.c                                         |    9 
 net/ipv6/route.c                                                 |    9 
 net/ipv6/seg6_iptunnel.c                                         |   14 
 net/ipv6/tcp_ipv6.c                                              |    9 
 net/ipv6/xfrm6_policy.c                                          |    8 
 net/iucv/iucv.c                                                  |   26 
 net/mac80211/mesh_pathtbl.c                                      |   13 
 net/mac80211/sta_info.c                                          |    4 
 net/netfilter/ipset/ip_set_core.c                                |   92 +-
 net/netfilter/ipset/ip_set_list_set.c                            |   30 
 net/netfilter/nf_tables_api.c                                    |   13 
 net/netfilter/nft_exthdr.c                                       |   17 
 net/netfilter/nft_lookup.c                                       |    3 
 net/netrom/nr_timer.c                                            |    3 
 net/sched/act_api.c                                              |   66 +-
 net/sched/sch_multiq.c                                           |    2 
 net/sched/sch_taprio.c                                           |   15 
 net/sunrpc/auth_gss/auth_gss.c                                   |    4 
 net/unix/af_unix.c                                               |   47 -
 net/unix/diag.c                                                  |   12 
 net/wireless/pmsr.c                                              |    8 
 sound/soc/fsl/fsl-asoc-card.c                                    |    3 
 sound/soc/ti/davinci-mcasp.c                                     |  310 ++++------
 sound/synth/emux/soundfont.c                                     |   17 
 tools/include/asm-generic/hugetlb_encode.h                       |   20 
 tools/testing/selftests/bpf/test_tc_tunnel.sh                    |   13 
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc |    3 
 tools/testing/selftests/vm/compaction_test.c                     |  103 +--
 159 files changed, 1466 insertions(+), 841 deletions(-)

Adam Miotk (1):
      drm/bridge/panel: Fix runtime warning on panel bridge release

Adrian Hunter (2):
      mmc: sdhci: Do not invert write-protect twice
      mmc: sdhci: Do not lock spinlock around mmc_gpio_get_ro()

Alan Stern (1):
      USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

Aleksandr Mishin (2):
      liquidio: Adjust a NULL pointer handling path in lio_vf_rep_copy_packet
      gpio: davinci: Validate the obtained number of IRQs

Alessandro Carminati (Red Hat) (1):
      selftests/bpf: Prevent client connect before server bind in test_tc_tunnel.sh

Alex Bee (1):
      arm64: dts: rockchip: Add sound-dai-cells for RK3368

Alex Deucher (2):
      drm/radeon: fix UBSAN warning in kv_dpm.c
      drm/amdgpu: fix UBSAN warning in kv_dpm.c

Alex Henrie (1):
      usb: misc: uss720: check for incompatible versions of the Belkin F5U002

Alexander Shishkin (5):
      intel_th: pci: Add Granite Rapids support
      intel_th: pci: Add Granite Rapids SOC support
      intel_th: pci: Add Sapphire Rapids SOC support
      intel_th: pci: Add Meteor Lake-S support
      intel_th: pci: Add Lunar Lake support

Alexandru Ardelean (1):
      iio: dac: ad5592r: un-indent code-block for scale read

Amjad Ouled-Ameur (1):
      drm/komeda: check for error-valued pointer

Andrew Davis (1):
      soc: ti: wkup_m3_ipc: Send NULL dummy message instead of pointer message

Arnd Bergmann (5):
      sparc: fix old compat_sys_select()
      parisc: use correct compat recv/recvfrom syscalls
      csky, hexagon: fix broken sys_sync_file_range
      hexagon: fix fadvise64_64 calling conventions
      ftruncate: pass a signed offset

Biju Das (1):
      regulator: core: Fix modpost error "regulator_get_regmap" undefined

Breno Leitao (1):
      scsi: mpt3sas: Avoid test/set_bit() operating in non-allocated memory

Chen Hanxiao (1):
      SUNRPC: return proper error from gss_wrap_req_priv

Christian Marangi (1):
      mips: bmips: BCM6358: make sure CBR is correctly set

Colin Ian King (1):
      ASoC: ti: davinci-mcasp: remove redundant assignment to variable ret

Dan Carpenter (1):
      usb: musb: da8xx: fix a resource leak in probe()

Daniel Borkmann (1):
      vxlan: Fix regression when dropping packets due to invalid src addresses

David Ruth (1):
      net/sched: act_api: fix possible infinite loop in tcf_idr_check_alloc()

Dawei Li (2):
      net/iucv: Avoid explicit cpumask var allocation on stack
      net/dpaa2: Avoid explicit cpumask var allocation on stack

Denis Arefev (1):
      mtd: partitions: redboot: Added conversion of operands to a larger type

Dev Jain (2):
      selftests/mm: compaction_test: fix incorrect write of zero to nr_hugepages
      selftests/mm: compaction_test: fix bogus test success on Aarch64

Dirk Behme (1):
      drivers: core: synchronize really_probe() and dev_uevent()

Divya Koppera (1):
      net: phy: mchp: Add support for LAN8814 QUAD PHY

Dmitry Torokhov (1):
      Input: try trimming too long modalias strings

Elinor Montmasson (1):
      ASoC: fsl-asoc-card: set priv->pdev before using it

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: don't read past the mfuart notifcation

Enguerrand de Ribaucourt (1):
      net: phy: micrel: add Microchip KSZ 9477 to the device table

Eric Dumazet (9):
      ipv6: sr: block BH in seg6_output_core() and seg6_input_core()
      net/sched: taprio: always validate TCA_TAPRIO_ATTR_PRIOMAP
      ipv6: fix possible race in __fib6_drop_pcpu_from()
      tcp: fix race in tcp_v6_syn_recv_sock()
      batman-adv: bypass empty buckets in batadv_purge_orig_ref()
      ipv6: prevent possible NULL deref in fib6_nh_init()
      ipv6: prevent possible NULL dereference in rt6_probe()
      xfrm6: check ip6_dst_idev() return value in xfrm6_get_saddr()
      ipv6: annotate some data-races around sk->sk_prot

Fernando Yang (1):
      iio: adc: ad7266: Fix variable checking bug

Florian Westphal (1):
      netfilter: nftables: exthdr: fix 4-byte stack OOB write

Gal Pressman (1):
      net/mlx5e: Fix features validation check for tunneled UDP (non-VXLAN) packets

Gavrilov Ilia (1):
      netrom: Fix a memory leak in nr_heartbeat_expiry()

George Shen (1):
      drm/amd/display: Handle Y carry-over in VCP X.Y calculation

Greg Kroah-Hartman (2):
      jfs: xattr: fix buffer overflow for invalid xattr
      Linux 5.4.279

Gregor Herburger (1):
      gpio: tqmx86: fix typo in Kconfig label

Grygorii Tertychnyi (1):
      i2c: ocores: set IACK bit after core is enabled

Hagar Gamal Halim Hemdan (1):
      vmci: prevent speculation leaks by sanitizing event in event_deliver()

Hagar Hemdan (1):
      pinctrl: fix deadlock in create_pinctrl() when handling -EPROBE_DEFER

Haifeng Xu (1):
      perf/core: Fix missing wakeup when waiting for context reference

Hangyu Hua (1):
      net: sched: sch_multiq: fix possible OOB write in multiq_tune()

Hannes Reinecke (1):
      nvme: fixup comment for nvme RDMA Provider Type

Heng Qi (1):
      virtio_net: checksum offloading handling fix

Huang-Huang Bao (3):
      pinctrl: rockchip: fix pinmux bits for RK3328 GPIO2-B pins
      pinctrl: rockchip: fix pinmux bits for RK3328 GPIO3-B pins
      pinctrl: rockchip: fix pinmux reset in rockchip_pmx_set

Hugo Villeneuve (2):
      serial: sc16is7xx: replace hardcoded divisor value with BIT() macro
      serial: sc16is7xx: fix bug in sc16is7xx_set_baud() when using prescaler

Ilpo Järvinen (2):
      MIPS: Routerboard 532: Fix vendor retry check code
      mmc: sdhci-pci: Convert PCIBIOS_* return codes to errnos

Jaime Liao (1):
      mtd: spinand: macronix: Add support for serial NAND flash

Jani Nikula (1):
      drm/exynos/vidi: fix memory leak in .get_modes()

Jason Xing (1):
      tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB

Jean Delvare (1):
      i2c: at91: Fix the functionality flags of the slave-only interface

Jean-Michel Hautbois (1):
      tty: mcf: MCF54418 has 10 UARTS

Jeff Johnson (1):
      tracing: Add MODULE_DESCRIPTION() to preemptirq_delay_test

Joao Paulo Goncalves (1):
      ASoC: ti: davinci-mcasp: Fix race condition during probe

Johan Hovold (1):
      arm64: dts: qcom: qcs404: fix bluetooth device address

Johan Jonker (1):
      ARM: dts: rockchip: rk3066a: add #sound-dai-cells to hdmi node

Johannes Berg (1):
      wifi: iwlwifi: mvm: revert gen2 TX A-MPDU size to 64

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: improve link status logs

José Expósito (1):
      HID: logitech-dj: Fix memory leak in logi_dj_recv_switch_to_dj_mode()

Jozsef Kadlecsik (2):
      netfilter: ipset: Fix race between namespace cleanup and gc in the list:set type
      netfilter: ipset: Fix suspicious rcu_dereference_protected()

Karol Kolacinski (1):
      ptp: Fix error message on failed pin verification

Krzysztof Kozlowski (3):
      ARM: dts: samsung: smdkv310: fix keypad no-autorepeat
      ARM: dts: samsung: exynos4412-origen: fix keypad no-autorepeat
      ARM: dts: samsung: smdk4412: fix keypad no-autorepeat

Kuangyi Chiang (2):
      xhci: Apply reset resume quirk to Etron EJ188 xHCI host
      xhci: Apply broken streams quirk to Etron EJ188 xHCI host

Kun(llfl) (1):
      iommu/amd: Fix sysfs leak in iommu init

Kuniyuki Iwashima (10):
      af_unix: Annotate data-race of sk->sk_state in unix_inq_len().
      af_unix: Annotate data-races around sk->sk_state in unix_write_space() and poll().
      af_unix: Annotate data-races around sk->sk_state in sendmsg() and recvmsg().
      af_unix: Annotate data-races around sk->sk_state in UNIX_DIAG.
      af_unix: Annotate data-race of net->unx.sysctl_max_dgram_qlen.
      af_unix: Use unix_recvq_full_lockless() in unix_stream_connect().
      af_unix: Use skb_queue_len_lockless() in sk_diag_show_rqlen().
      af_unix: Annotate data-race of sk->sk_shutdown in sk_diag_fill().
      ipv6: Fix data races around sk->sk_prot.
      tcp: Fix data races around icsk->icsk_af_ops.

Laurent Pinchart (1):
      drm/panel: ilitek-ili9881c: Fix warning with GPIO controllers that sleep

Lin Ma (1):
      wifi: cfg80211: pmsr: use correct nla_get_uX functions

Linus Torvalds (1):
      x86: stop playing stack games in profile_pc()

Lu Baolu (1):
      iommu: Return right value in iommu_sva_bind_device()

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ

Ma Ke (2):
      drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_ld_modes
      drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_hd_modes

Manish Rangankar (1):
      scsi: qedi: Fix crash while reading debugfs attribute

Marc Ferland (1):
      iio: dac: ad5592r: fix temperature channel scaling value

Marek Szyprowski (1):
      drm/exynos: hdmi: report safe 640x480 mode as a fallback when no EDID found

Mario Limonciello (1):
      PCI/PM: Avoid D3cold for HP Pavilion 17 PC/1972 PCIe Ports

Masahiro Yamada (1):
      Revert "kheaders: substituting --sort in archive creation"

Mathias Nyman (1):
      xhci: Set correct transferred length for cancelled bulk transfers

Matthew Wilcox (Oracle) (3):
      nilfs2: Remove check for PageError
      nilfs2: return the mapped address from nilfs_get_page()
      nfs: Leave pages in the pagecache if readpage failed

Matthias Goergens (1):
      hugetlb_encode.h: fix undefined behaviour (34 << 26)

Matthias Maennich (1):
      kheaders: explicitly define file modes for archived headers

Michael Ellerman (1):
      powerpc/io: Avoid clang null pointer arithmetic warnings

Moshe Shemesh (1):
      net/mlx5: Stop waiting for PCI if pci channel is offline

Muhammad Usama Anjum (1):
      selftests/mm: conform test to TAP format output

Nathan Lynch (1):
      powerpc/pseries: Enforce hcall result buffer validity and size

Naveen Naidu (1):
      PCI: Add PCI_ERROR_RESPONSE and related definitions

Nicolas Escande (1):
      wifi: mac80211: mesh: Fix leak of mesh_preq_queue objects

Nikita Shubin (1):
      dmaengine: ioatdma: Fix missing kmem_cache_destroy()

Nikita Zhandarovich (2):
      HID: core: remove unnecessary WARN_ON() in implement()
      usb: atm: cxacru: fix endpoint checking in cxacru_bind()

Niklas Cassel (1):
      ata: libata-core: Fix double free on error

Nuno Sa (1):
      dmaengine: axi-dmac: fix possible race in remove()

Oleg Nesterov (1):
      tick/nohz_full: Don't abuse smp_call_function_single() in tick_setup_device()

Oleksij Rempel (2):
      net: can: j1939: recover socket queue on CAN bus error during BAM transmission
      net: can: j1939: enhanced error handling for tightly received RTS messages in xtp_rx_rts_session_new

Oliver Neukum (2):
      net: usb: rtl8150 fix unintiatilzed variables in rtl8150_get_link_ksettings
      usb: gadget: printer: SS+ support

Ondrej Mosnacek (1):
      cipso: fix total option length computation

Oswald Buddenhagen (1):
      ALSA: emux: improve patch ioctl data validation

Pablo Neira Ayuso (2):
      netfilter: nf_tables: validate family when identifying table via handle
      netfilter: nf_tables: fully validate NFT_DATA_VALUE on store to data registers

Paul E. McKenney (1):
      rcutorture: Fix rcu_torture_one_read() pipe_count overflow comment

Pedro Tammela (1):
      net/sched: act_api: rely on rcu in tcf_idr_check_alloc

Peter Oberparleiter (1):
      gcov: add support for GCC 14

Peter Ujfalusi (4):
      ASoC: ti: davinci-mcasp: Use platform_get_irq_byname_optional
      ASoC: ti: davinci-mcasp: Remove legacy dma_request parsing
      ASoC: ti: davinci-mcasp: Simplify the configuration parameter handling
      ASoC: ti: davinci-mcasp: Handle missing required DT properties

Petr Pavlu (1):
      net/ipv6: Fix the RT cache flush via sysctl using a previous delay

Raju Rangoju (1):
      ACPICA: Revert "ACPICA: avoid Info: mapping multiple BARs. Your kernel is fine."

Remi Pommarel (1):
      wifi: mac80211: Fix deadlock in ieee80211_sta_ps_deliver_wakeup()

Ricardo Ribalda (1):
      media: dvbdev: Initialize sbuf

Rick Wertenbroek (1):
      PCI: rockchip-ep: Remove wrong mask on subsys_vendor_id

Rik van Riel (1):
      fs/proc: fix softlockup in __read_vmcore

Roman Smirnov (1):
      udf: udftime: prevent overflow in udf_disk_stamp_to_time()

Ryusuke Konishi (2):
      nilfs2: fix nilfs_empty_dir() misjudgment and long loop on I/O errors
      nilfs2: fix potential kernel bug due to lack of writeback flag waiting

Sergiu Cuciurean (1):
      iio: dac: ad5592r-base: Replace indio_dev->mlock with own device lock

Shahar S Matityahu (1):
      wifi: iwlwifi: dbg_ini: move iwl_dbg_tlv_free outside of debugfs ifdef

Shichao Lai (1):
      usb-storage: alauda: Check whether the media is initialized

Shigeru Yoshida (1):
      net: can: j1939: Initialize unused data in j1939_send_one()

Sicong Huang (1):
      greybus: Fix use-after-free bug in gb_interface_release due to race condition.

Songyang Li (1):
      MIPS: Octeon: Add PCIe link status check

Steven Rostedt (Google) (1):
      tracing/selftests: Fix kprobe event name test for .isra. functions

Su Yue (2):
      ocfs2: use coarse time for new created files
      ocfs2: fix races between hole punching and AIO+DIO

Sven Eckelmann (1):
      batman-adv: Don't accept TT entries for out-of-spec VIDs

Taehee Yoo (1):
      ionic: fix use after netif_napi_del()

Tomas Winkler (1):
      mei: me: release irq in mei_me_pci_resume error path

Tristram Ha (1):
      net: dsa: microchip: fix initial port flush problem

Uri Arev (1):
      Bluetooth: ath3k: Fix multiple issues reported by checkpatch.pl

Uwe Kleine-König (1):
      pwm: stm32: Refuse too small period requests

Vasileios Amoiridis (4):
      iio: chemical: bme680: Fix pressure value output
      iio: chemical: bme680: Fix calibration data variable
      iio: chemical: bme680: Fix overflows in compensate() functions
      iio: chemical: bme680: Fix sensor data read operation

Vineeth Pillai (1):
      hv_utils: drain the timesync packets on onchannelcallback

Wander Lairson Costa (1):
      drop_monitor: replace spin_lock by raw_spin_lock

Wesley Cheng (1):
      usb: gadget: f_fs: Fix race between aio_cancel() and AIO request complete

Yazen Ghannam (1):
      x86/amd_nb: Check for invalid SMN reads

Yue Haibing (1):
      netns: Make get_net_ns() handle zero refcount net

Zhang Qilong (1):
      ASoC: ti: davinci-mcasp: remove always zero of davinci_mcasp_get_dt_params


