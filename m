Return-Path: <stable+bounces-212857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIZND+R+fGk8NgIAu9opvQ
	(envelope-from <stable+bounces-212857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 10:50:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B8AB90C9
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 10:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A72F1300F5EE
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4443446C9;
	Fri, 30 Jan 2026 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p4bD5YG6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0B5314D13;
	Fri, 30 Jan 2026 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769766609; cv=none; b=A/rGN1Xy+s2zWsIj7dATTU01CKCvpUPaTtVTVovGoAbIwu1vXuQqQ8ooKJRiLBiQHQm3PyxNdq6tc68n1Ju4DANqg4iQm3S0i6ZioESXSPiXKLwW8Us/meWS5IFfxxw6A5QB5Fh9YFjBN6NseW5dguaqeBp4N1f64uchNbivjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769766609; c=relaxed/simple;
	bh=wF7rEDQeqW5XyBz4mSNskhDS8A1GCZ4El1Yq4G+bhmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OBMGBDf/77ghfUGAvm0Anz/bxIdnP7a1Tk9STkfa8J6ypm+1VHGKtGded8jzvLt03OtzUAoOvbcANOZ/XQV61qweFfT3d14n0mSqxhQ/Zeh7Jo507E8bK1GylwJE7viYTOO/I8Aee/1yeDxEbnRGbgpeVq3Gp3VYyH2ekYgn+ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p4bD5YG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE4AC4AF0B;
	Fri, 30 Jan 2026 09:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769766608;
	bh=wF7rEDQeqW5XyBz4mSNskhDS8A1GCZ4El1Yq4G+bhmE=;
	h=From:To:Cc:Subject:Date:From;
	b=p4bD5YG6VFT+HBkPYhHS2kmNrWbWrNwf83Oxq51rNZ7AcNx1JYnmMTT5J17my4VWI
	 OMOCp8crvIIQYoTJf9IrIJqHb8UAE8GWddRIzVjTKknmtgcG0PqHzfcaYaCPSNFVq+
	 4fQYrwA6RF4DFwzoz6OCL7/PsmHQ85cVjEjlD9H4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.68
Date: Fri, 30 Jan 2026 10:50:00 +0100
Message-ID: <2026013001-dwindling-resemble-51e9@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212857-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,ynl-regen.sh:url]
X-Rspamd-Queue-Id: 97B8AB90C9
X-Rspamd-Action: no action

I'm announcing the release of the 6.12.68 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml   |    1 
 Documentation/netlink/specs/fou.yaml                      |    2 
 Makefile                                                  |    2 
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                    |   16 
 arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts    |    1 
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts        |    1 
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts     |    4 
 arch/arm64/kernel/hibernate.c                             |    2 
 arch/arm64/kernel/signal.c                                |    4 
 arch/x86/events/perf_event.h                              |   13 
 arch/x86/include/asm/kfence.h                             |   29 +
 arch/x86/mm/fault.c                                       |   15 
 crypto/authencesn.c                                       |    6 
 drivers/accel/ivpu/ivpu_gem.c                             |    3 
 drivers/ata/ahci.c                                        |   10 
 drivers/ata/libata-core.c                                 |   32 +
 drivers/ata/libata-sata.c                                 |    2 
 drivers/base/regmap/regmap.c                              |    4 
 drivers/char/tpm/Kconfig                                  |    1 
 drivers/char/tpm/tpm2-sessions.c                          |    6 
 drivers/clocksource/timer-riscv.c                         |    3 
 drivers/comedi/comedi_fops.c                              |    2 
 drivers/comedi/drivers/dmm32at.c                          |   32 +
 drivers/comedi/range.c                                    |    2 
 drivers/dma/ti/k3-udma.c                                  |   36 ++
 drivers/dpll/dpll_core.c                                  |   12 
 drivers/gpio/gpiolib-cdev.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                    |   12 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                |   23 -
 drivers/gpu/drm/imagination/pvr_fw_trace.c                |    8 
 drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/conn.h   |   95 ++++-
 drivers/gpu/drm/nouveau/nouveau_display.c                 |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c          |   73 +++-
 drivers/hv/hv_common.c                                    |   12 
 drivers/hwtracing/intel_th/core.c                         |   19 -
 drivers/iio/accel/adxl380.c                               |    6 
 drivers/iio/accel/st_accel_core.c                         |   72 ++++
 drivers/iio/adc/ad7280a.c                                 |    4 
 drivers/iio/adc/ad9467.c                                  |    2 
 drivers/iio/adc/at91-sama5d2_adc.c                        |    1 
 drivers/iio/adc/exynos_adc.c                              |   13 
 drivers/iio/adc/pac1934.c                                 |    6 
 drivers/iio/chemical/scd4x.c                              |    6 
 drivers/iio/dac/ad5686.c                                  |    6 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c              |   15 
 drivers/iio/industrialio-core.c                           |   12 
 drivers/input/serio/i8042-acpipnpio.h                     |   18 +
 drivers/interconnect/debugfs-client.c                     |    5 
 drivers/irqchip/irq-gic-v3-its.c                          |    8 
 drivers/isdn/mISDN/timerdev.c                             |   13 
 drivers/leds/led-class.c                                  |   10 
 drivers/misc/mei/mei-trace.h                              |   18 -
 drivers/misc/uacce/uacce.c                                |   48 ++
 drivers/mmc/host/rtsx_pci_sdmmc.c                         |   41 ++
 drivers/mmc/host/sdhci-of-dwcmshc.c                       |    7 
 drivers/net/bonding/bond_main.c                           |   11 
 drivers/net/can/usb/ems_usb.c                             |    8 
 drivers/net/can/usb/esd_usb.c                             |    9 
 drivers/net/can/usb/gs_usb.c                              |    7 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c          |    9 
 drivers/net/can/usb/mcba_usb.c                            |    8 
 drivers/net/can/usb/usb_8dev.c                            |    8 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                  |    5 
 drivers/net/ethernet/emulex/benet/be_cmds.c               |    3 
 drivers/net/ethernet/emulex/benet/be_main.c               |    8 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c           |   69 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h    |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   |    2 
 drivers/net/ethernet/intel/ice/ice.h                      |    1 
 drivers/net/ethernet/intel/ice/ice_common.c               |    2 
 drivers/net/ethernet/intel/ice/ice_ethtool.c              |    6 
 drivers/net/ethernet/intel/ice/ice_lib.c                  |   29 +
 drivers/net/ethernet/intel/ice/ice_main.c                 |   28 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c              |    4 
 drivers/net/ethernet/intel/igc/igc_main.c                 |    5 
 drivers/net/ethernet/intel/igc/igc_ptp.c                  |   43 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c           |   86 +++--
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h  |    7 
 drivers/net/ipvlan/ipvlan.h                               |    2 
 drivers/net/ipvlan/ipvlan_core.c                          |   16 
 drivers/net/ipvlan/ipvlan_main.c                          |   49 +-
 drivers/net/netdevsim/bpf.c                               |    6 
 drivers/net/netdevsim/dev.c                               |    2 
 drivers/net/netdevsim/netdevsim.h                         |    1 
 drivers/net/phy/sfp.c                                     |    2 
 drivers/net/usb/dm9601.c                                  |    4 
 drivers/net/usb/usbnet.c                                  |    9 
 drivers/net/veth.c                                        |    8 
 drivers/net/wireless/ath/ath10k/ce.c                      |   16 
 drivers/net/wireless/ath/ath11k/dp_rx.c                   |    4 
 drivers/net/wireless/ath/ath12k/ce.c                      |   12 
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c      |    6 
 drivers/net/wireless/rsi/rsi_91x_mac80211.c               |    1 
 drivers/nfc/virtual_ncidev.c                              |    4 
 drivers/of/base.c                                         |    8 
 drivers/of/platform.c                                     |    2 
 drivers/platform/x86/amd/wbrf.c                           |    4 
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c              |    8 
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h              |   12 
 drivers/pmdomain/imx/imx8m-blk-ctrl.c                     |   11 
 drivers/pmdomain/qcom/rpmhpd.c                            |    4 
 drivers/ptp/ptp_chardev.c                                 |   16 
 drivers/s390/crypto/ap_card.c                             |    2 
 drivers/s390/crypto/ap_queue.c                            |    2 
 drivers/scsi/qla2xxx/qla_isr.c                            |    7 
 drivers/scsi/scsi_error.c                                 |   11 
 drivers/scsi/scsi_lib.c                                   |    8 
 drivers/scsi/storvsc_drv.c                                |    3 
 drivers/slimbus/core.c                                    |   19 -
 drivers/spi/spi-sprd-adi.c                                |   33 -
 drivers/tty/serial/8250/8250_pci.c                        |    2 
 drivers/vhost/vsock.c                                     |   11 
 drivers/w1/slaves/w1_therm.c                              |   62 +--
 drivers/w1/w1.c                                           |    2 
 drivers/xen/xen-scsiback.c                                |    1 
 fs/btrfs/block-group.c                                    |    6 
 fs/btrfs/disk-io.c                                        |    2 
 fs/btrfs/space-info.c                                     |   22 -
 fs/btrfs/space-info.h                                     |    6 
 fs/exfat/namei.c                                          |   20 -
 fs/ntfs3/inode.c                                          |    7 
 include/dt-bindings/power/qcom,rpmhpd.h                   |  234 ++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h                    |  225 -------------
 include/linux/iio/iio-opaque.h                            |    2 
 include/linux/posix-clock.h                               |    6 
 include/linux/skbuff.h                                    |    2 
 include/linux/virtio_vsock.h                              |   39 +-
 include/uapi/linux/comedi.h                               |    2 
 io_uring/io-wq.c                                          |    2 
 kernel/sched/ext.c                                        |    2 
 kernel/sched/fair.c                                       |    6 
 kernel/sched/idle.c                                       |    6 
 kernel/time/clocksource.c                                 |    2 
 kernel/time/posix-clock.c                                 |    3 
 kernel/trace/trace_events_hist.c                          |    9 
 kernel/trace/trace_events_synth.c                         |    8 
 mm/migrate.c                                              |   12 
 mm/rmap.c                                                 |   20 -
 net/bpf/test_run.c                                        |    5 
 net/core/datagram.c                                       |   14 
 net/core/filter.c                                         |    7 
 net/dsa/dsa.c                                             |    2 
 net/ipv4/fou_core.c                                       |    3 
 net/ipv4/fou_nl.c                                         |    2 
 net/ipv6/ndisc.c                                          |    4 
 net/l2tp/l2tp_core.c                                      |    8 
 net/mac80211/scan.c                                       |    9 
 net/netrom/nr_route.c                                     |   13 
 net/openvswitch/vport.c                                   |   11 
 net/sched/act_ife.c                                       |    6 
 net/sched/sch_qfq.c                                       |    2 
 net/sched/sch_teql.c                                      |    5 
 net/sctp/sm_statefuns.c                                   |   10 
 net/vmw_vsock/virtio_transport.c                          |    6 
 net/vmw_vsock/virtio_transport_common.c                   |   45 +-
 scripts/kconfig/nconf-cfg.sh                              |   11 
 security/keys/trusted-keys/trusted_tpm2.c                 |    4 
 sound/pci/ctxfi/ctamixer.c                                |    2 
 sound/usb/mixer.c                                         |   22 +
 sound/usb/mixer_scarlett2.c                               |    6 
 tools/net/ynl/ynl-regen.sh                                |    2 
 tools/testing/selftests/bpf/prog_tests/perf_link.c        |   15 
 tools/testing/selftests/net/amt.sh                        |    7 
 tools/testing/selftests/net/fib-onlink-tests.sh           |   71 +---
 tools/testing/selftests/ptp/testptp.c                     |   97 ++++-
 tools/testing/vsock/vsock_test.c                          |   11 
 167 files changed, 1691 insertions(+), 882 deletions(-)

Abdun Nihaal (1):
      scsi: xen: scsiback: Fix potential memory leak in scsiback_remove()

Akhil P Oommen (1):
      dt-bindings: power: qcom,rpmpd: add Turbo L5 corner

Alex Ramírez (2):
      drm/nouveau: add missing DCB connector types
      drm/nouveau: implement missing DCB connector types; gracefully handle unknown connectors

Alexander Usyskin (1):
      mei: trace: treat reg parameter as string

Alok Tiwari (1):
      octeontx2: cn10k: fix RX flowid TCAM mask handling

Andrew Cooper (1):
      x86/kfence: avoid writing L1TF-vulnerable PTEs

Andrey Vatoropin (1):
      be2net: Fix NULL pointer dereference in be_cmd_get_mac_from_list

Andy Shevchenko (2):
      iio: core: add missing mutex_destroy in iio_dev_release()
      iio: core: Replace lockdep_set_class() + mutex_init() by combined call

Arkadiusz Kozdra (1):
      kconfig: fix static linking of nconf

Arnd Bergmann (1):
      irqchip/gic-v3-its: Avoid truncating memory addresses

Arun Raghavan (1):
      ALSA: usb: Increase volume range that triggers a warning

Bartlomiej Kubik (1):
      fs/ntfs3: Initialize allocated memory before use

Berk Cem Goksel (1):
      ALSA: usb-audio: Fix use-after-free in snd_usb_mixer_free()

Boris Burkov (1):
      btrfs: fix racy bitfield write in btrfs_clear_space_info_full()

Brajesh Gupta (1):
      drm/imagination: Wait for FW trace update command completion

Cedric Xing (1):
      x86: make page fault handling disable interrupts properly

Cheng-Yu Lee (1):
      regmap: Fix race condition in hwspinlock irqsave routine

Chenghai Huang (2):
      uacce: fix isolate sysfs check condition
      uacce: ensure safe queue release with state management

Chwee-Lin Choong (1):
      igc: fix race condition in TX timestamp read for register 0

Cody Haas (1):
      ice: Fix persistent failure in ice_get_rxfh

Damien Le Moal (1):
      ata: libata-core: Introduce ata_dev_config_lpm()

Dan Carpenter (1):
      wifi: mwifiex: Fix a loop in mwifiex_update_ampdu_rxwinsize()

Daniel Borkmann (1):
      bpf: Do not let BPF test infra emit invalid GSO types to stack

Dave Ertman (1):
      ice: Avoid detrimental cleanup for bond during interface stop

David Hildenbrand (Red Hat) (1):
      mm/rmap: fix two comments related to huge_pmd_unshare()

David Jeffery (1):
      scsi: core: Wake up the error handler when final completions race against each other

David Yang (4):
      veth: fix data race in veth_get_ethtool_stats
      net: hns3: fix data race in hns3_fetch_stats
      be2net: fix data race in be_get_new_eqd
      net: openvswitch: fix data race in ovs_vport_get_upcall_stats

Ding Hui (1):
      ice: Fix incorrect timeout ice_release_res()

Dmitry Baryshkov (1):
      dt-bindings: power: qcom-rpmpd: split RPMh domains definitions

Dmitry Skorodumov (1):
      ipvlan: Make the addrs_lock be per port

Eric Biggers (1):
      tpm: Compare HMAC values in constant time

Eric Dumazet (6):
      bonding: limit BOND_MODE_8023AD to Ethernet devices
      l2tp: avoid one data-race in l2tp_tunnel_del_work()
      mISDN: annotate data-race around dev->work
      ipv6: annotate data-race in ndisc_router_discovery()
      bonding: provide a net pointer to __skb_flow_dissect()
      net/sched: act_ife: avoid possible NULL deref

Ethan Nelson-Moore (1):
      net: usb: dm9601: remove broken SR9700 support

Felix Gu (1):
      spi: spi-sprd-adi: Fix double free in probe error path

Fernand Sieber (1):
      perf/x86/intel: Do not enable BTS for guests

Fiona Klute (1):
      iio: chemical: scd4x: fix reported channel endianness

Francesco Lavra (2):
      iio: imu: st_lsm6dsx: fix iio_chan_spec for sensors without event detection
      iio: accel: adxl380: fix handling of unavailable "INT1" interrupt

Georgi Djakov (1):
      interconnect: debugfs: initialize src_node and dst_node to empty strings

Geraldo Nascimento (2):
      arm64: dts: rockchip: remove dangerous max-link-speed from helios64
      arm64: dts: rockchip: remove redundant max-link-speed from nanopi-r4s

Greg Kroah-Hartman (1):
      Linux 6.12.68

Hamza Mahfooz (1):
      net: sfp: add potron quirk to the H-COM SPP425H-GAB4 SFP+ Stick

Hans de Goede (1):
      leds: led-class: Only Add LED to leds_list when it is fully ready

Haoxiang Li (1):
      w1: fix redundant counter decrement in w1_attach_slave_device()

Harald Freudenberger (1):
      s390/ap: Fix wrong APQN fill calculation

Ian Abbott (2):
      comedi: dmm32at: serialize use of paged registers
      comedi: Fix getting range information for subdevices 16 to 255

Ihor Solodrai (1):
      selftests/bpf: Check for timeout in perf_link test

Ivan Vecera (1):
      dpll: Prevent duplicate registrations

Jacob Keller (1):
      ice: initialize ring_stats->syncp

Jamal Hadi Salim (2):
      net/sched: Enforce that teql can only be used as root qdisc
      net/sched: qfq: Use cl_is_active to determine whether class is active in qfq_rm_from_ag

Jens Axboe (1):
      io_uring/io-wq: check IO_WQ_BIT_EXIT inside work run loop

Jeongjun Park (1):
      netrom: fix double-free in nr_route_frame()

Jiasheng Jiang (1):
      scsi: qla2xxx: Sanitize payload size to prevent member overflow

Jijie Shao (2):
      net: hns3: fix wrong GENMASK() for HCLGE_FD_AD_COUNTER_NUM_M
      net: hns3: fix the HCLGE_FD_AD_NXT_KEY error setting issue

Johan Hovold (4):
      slimbus: core: fix runtime PM imbalance on report present
      slimbus: core: fix device reference leak on report present
      intel_th: fix device leak on output open()
      iio: adc: exynos_adc: fix OF populate on driver rebind

Konrad Dybcio (3):
      dt-bindings: power: qcom,rpmpd: Add SC8280XP_MXC_AO
      pmdomain: qcom: rpmhpd: Add MXC to SC8280XP
      arm64: dts: qcom: sc8280xp: Add missing VDD_MXC links

Kuniyuki Iwashima (4):
      l2tp: Fix memleak in l2tp_udp_encap_recv().
      gue: Fix skb memleak with inner IP protocol 0.
      tools: ynl: Specify --no-line-number in ynl-regen.sh.
      fou: Don't allow 0 for FOU_ATTR_IPPROTO.

Kurt Kanzenbach (1):
      igc: Restore default Qbv schedule when changing channels

Kübrich, Andreas (1):
      iio: dac: ad5686: add AD5695R to ad5686_chip_info_tbl

Lachlan Hodges (1):
      wifi: mac80211: don't perform DA check on S1G beacon

Laurent Vivier (1):
      usbnet: limit max_mtu based on device's hard_mtu

Likun Gao (1):
      drm/amdgpu: remove frame cntl for gfx v12

Long Li (1):
      scsi: storvsc: Process unsupported MODE_SENSE_10

Lyude Paul (1):
      drm/nouveau/disp: Set drm_mode_config_funcs.atomic_(check|commit)

Mahesh Bandewar (1):
      selftest/ptp: update ptp selftest to exercise the gettimex options

Marc Kleine-Budde (6):
      can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL on usb_submit_urb() error
      can: ems_usb: ems_usb_read_bulk_callback(): fix URB memory leak
      can: kvaser_usb: kvaser_usb_read_bulk_callback(): fix URB memory leak
      can: mcba_usb: mcba_usb_read_bulk_callback(): fix URB memory leak
      can: usb_8dev: usb_8dev_read_bulk_callback(): fix URB memory leak
      can: esd_usb: esd_usb_read_bulk_callback(): fix URB memory leak

Marek Vasut (1):
      wifi: rsi: Fix memory corruption due to not set vif driver data size

Mario Limonciello (3):
      platform/x86: hp-bioscfg: Fix kobject warnings for empty attribute names
      platform/x86: hp-bioscfg: Fix kernel panic in GET_INSTANCE_ID macro
      platform/x86: hp-bioscfg: Fix automatic module loading

Mark Harmstone (1):
      btrfs: fix missing fields in superblock backup with BLOCK_GROUP_TREE

Mark Rutland (1):
      arm64/fpsimd: signal: Allocate SSVE storage when restoring ZA

Markus Koeniger (1):
      iio: accel: iis328dq: fix gain values

Marnix Rijnart (1):
      serial: 8250_pci: Fix broken RS485 for F81504/508/512

Matthew Schwartz (1):
      mmc: rtsx_pci_sdmmc: implement sdmmc_card_busy function

Matthew Wilcox (Oracle) (1):
      migrate: correct lock ordering for hugetlb file folios

Melbin K Mathew (2):
      vsock/virtio: fix potential underflow in virtio_transport_get_credit()
      vsock/virtio: cap TX credit to local buffer size

Michael Kelley (1):
      Drivers: hv: Always do Hyper-V panic notification in hv_kmsg_dump()

Michal Luczaj (1):
      vsock/virtio: Coalesce only linear skb

Ming Qian (1):
      pmdomain: imx8m-blk-ctrl: Remove separate rst and clk mask for 8mq vpu

Naohiko Shimizu (1):
      riscv: clocksource: Fix stimecmp update hazard on RV32

Niklas Cassel (5):
      ata: ahci: Do not read the per port area for unimplemented ports
      ata: libata-sata: Improve link_power_management_supported sysfs attribute
      ata: libata: Add cpr_log to ata_dev_print_features() early return
      ata: libata: Call ata_dev_config_lpm() for ATAPI devices
      ata: libata: Print features also for ATAPI devices

Ondrej Jirman (1):
      arm64: dts: rockchip: Fix voltage threshold for volume keys for Pinephone Pro

P Praneesh (1):
      wifi: ath11k: fix RCU stall while reaping monitor destination ring

Pavel Zhigulin (1):
      iio: adc: ad7280a: handle spi_setup() errors in probe()

Pei Xiao (1):
      iio: adc: at91-sama5d2_adc: Fix potential use-after-free in sama5d2_adc driver

Raju Rangoju (1):
      amd-xgbe: avoid misleading per-packet error log

Rasmus Villemoes (1):
      iio: core: add separate lockdep class for info_exist_lock

Ratheesh Kannoth (1):
      octeontx2-af: Fix error handling

Ricardo B. Marlière (1):
      selftests: net: fib-onlink-tests: Convert to use namespaces by default

Rob Herring (Arm) (1):
      of: platform: Use default match table for /firmware

Samasth Norway Ananda (1):
      ALSA: scarlett2: Fix buffer overflow in config retrieval

Shawn Lin (1):
      mmc: sdhci-of-dwcmshc: Prevent illegal clock reduction in HS200/HS400 mode

Shuhao Fu (1):
      exfat: fix refcount leak in exfat_find

Siddharth Vadapalli (1):
      dmaengine: ti: k3-udma: Enable second resource range for BCDMA and PKTDMA

Srish Srinivasan (1):
      keys/trusted_keys: fix handle passed to tpm_buf_append_name during unseal

Stefano Garzarella (1):
      vsock/test: fix seqpacket message bounds test

Steven Rostedt (1):
      tracing: Fix crash on synthetic stacktrace field usage

Taehee Yoo (1):
      selftests: net: amt: wait longer for connection before sending packets

Taeyang Lee (1):
      crypto: authencesn - reject too-short AAD (assoclen<8) to match ESP/ESN spec

Takashi Iwai (1):
      ALSA: ctxfi: Fix potential OOB access in audio mixer handling

Taniya Das (1):
      dt-bindings: power: qcom,rpmpd: document the SM8750 RPMh Power Domains

Thadeu Lima de Souza Cascardo (1):
      Revert "nfc/nci: Add the inconsistency check between the input data length and count"

Thomas Fourier (3):
      wifi: ath10k: fix dma_free_coherent() pointer
      wifi: ath12k: fix dma_free_coherent() pointer
      octeontx2: Fix otx2_dma_map_page() error return code

Thomas Gleixner (1):
      clocksource: Reduce watchdog readout delay limit to prevent false positives

Thorsten Blum (2):
      w1: therm: Fix off-by-one buffer overflow in alarms_store
      iio: adc: pac1934: Fix clamped value in pac1934_reg_snapshot

Timur Kristóf (2):
      drm/amd/pm: Don't clear SI SMC table when setting power limit
      drm/amd/pm: Workaround SI powertune issue on Radeon 430 (v2)

Tomas Melin (1):
      iio: adc: ad9467: fix ad9434 vref mask

Tomasz Rusinowicz (1):
      accel/ivpu: Fix race condition when unbinding BOs

Tzung-Bi Shih (1):
      gpio: cdev: Correct return code on memory allocation failure

Vincent Guittot (1):
      sched/fair: Fix pelt clock sync when entering idle

Vladimir Oltean (1):
      net: dsa: fix off-by-one in maximum bridge ID determination

Weigang He (1):
      of: fix reference count leak in of_alias_scan()

Wenkai Lin (1):
      uacce: fix cdev handling in the cleanup path

Will Deacon (8):
      vsock/virtio: Move length check to callers of virtio_vsock_skb_rx_put()
      vsock/virtio: Rename virtio_vsock_alloc_skb()
      vsock/virtio: Move SKB allocation lower-bound check to callers
      vsock/virtio: Rename virtio_vsock_skb_rx_put()
      vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers
      vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers
      net: Introduce skb_copy_datagram_from_iter_full()
      vsock/virtio: Fix message iterator handling on transmit path

Wojtek Wasko (3):
      posix-clock: Store file pointer in struct posix_clock_context
      ptp: Add PHC file mode checks. Allow RO adjtime() without FMODE_WRITE.
      testptp: Add option to open PHC in readonly mode

Xin Long (1):
      sctp: move SCTP_CMD_ASSOC_SHKEY right after SCTP_CMD_PEER_INIT

Yang Shen (1):
      uacce: implement mremap in uacce_vm_ops to return -EPERM

Yun Lu (1):
      netdevsim: fix a race issue related to the operation on bpf_bound_progs list

Zhaoyang Huang (1):
      arm64: Set __nocfi on swsusp_arch_resume()

Zilin Guan (1):
      platform/x86/amd: Fix memory leak in wbrf_record()

Zqiang (1):
      sched_ext: Fix possible deadlock in the deferred_irq_workfn()

feng (1):
      Input: i8042 - add quirk for ASUS Zenbook UX425QA_UM425QA

gongqi (1):
      Input: i8042 - add quirks for MECHREVO Wujie 15X Pro


