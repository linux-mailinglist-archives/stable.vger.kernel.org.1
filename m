Return-Path: <stable+bounces-214674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGMcFXcWhmk1JgQAu9opvQ
	(envelope-from <stable+bounces-214674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 17:27:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF971003DD
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 17:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D2993002928
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 16:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DBA329363;
	Fri,  6 Feb 2026 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F2WKuYTt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BD22D59E8;
	Fri,  6 Feb 2026 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395248; cv=none; b=MIiZuxrboXL8QkKPrK0ChqLXp8URYw4ZEexP8Rznaa/KFScNClSODDePKf0Nr9xv6qlXf4zChhe9vpZmKld9I161x8Ld+r7NKLhv9st3bmxIiw9u9JcnZTSdz6Hlg5x/bzxjkoOhaGwC53gYa2cz7lrLgUIaId2Pg8rfNwWvfMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395248; c=relaxed/simple;
	bh=LeOao/lM3Z3HeNIsS6O6WyNd1DH9jnnHMmeL8f+HF1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AtJ8NC9/jm9q2e35MsdSVlZC/fabRkA9EWogyyUWf0pf8Q6FdFHqI8g1G5l1vjiKNrJdZ72CxwLpDY77TivQQoxpjqsuzvunjrIZJIinya+08twvUCRzkrzNftWl4bLmK0grPf3Ti8GEKlDOCIzva4srnNcFEm6JFNLArCnYsPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F2WKuYTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB77C19422;
	Fri,  6 Feb 2026 16:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770395247;
	bh=LeOao/lM3Z3HeNIsS6O6WyNd1DH9jnnHMmeL8f+HF1Q=;
	h=From:To:Cc:Subject:Date:From;
	b=F2WKuYTt5eCJt0hYIWIC1zCZ6pLyMWdNyR7jrc0fw+3wwkGUlidnO+NmpcmS2d6F4
	 LBzEu04POlRewz+nz/9CCf9UfwlUPqLt1xCUq+SKh4wJqEpE57WTwYPe3KwAHbYb2v
	 PEPNVhaw5b6g7WcPJGAa4Q+Au+CmlOFrOHZXRwEw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.249
Date: Fri,  6 Feb 2026 17:27:22 +0100
Message-ID: <2026020623-bush-pavement-8fb5@gregkh>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214674-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DF971003DD
X-Rspamd-Action: no action

I'm announcing the release of the 5.10.249 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/netlink/specs/fou.yaml                           |  130 
 Makefile                                                       |    2 
 arch/x86/events/perf_event.h                                   |   13 
 arch/x86/kernel/cpu/resctrl/core.c                             |   21 
 arch/x86/kernel/cpu/resctrl/internal.h                         |    3 
 crypto/authencesn.c                                            |    6 
 drivers/base/core.c                                            |    1 
 drivers/base/regmap/regmap.c                                   |    4 
 drivers/bluetooth/hci_ldisc.c                                  |    4 
 drivers/dma/at_hdmac.c                                         |    9 
 drivers/dma/bcm-sba-raid.c                                     |    6 
 drivers/dma/lpc18xx-dmamux.c                                   |   19 
 drivers/dma/stm32-dmamux.c                                     |   22 
 drivers/dma/tegra210-adma.c                                    |   10 
 drivers/dma/ti/dma-crossbar.c                                  |   18 
 drivers/dma/ti/k3-udma-private.c                               |    2 
 drivers/dma/ti/omap-dma.c                                      |    4 
 drivers/dma/xilinx/xilinx_dma.c                                |    7 
 drivers/edac/i3200_edac.c                                      |   11 
 drivers/edac/x38_edac.c                                        |    9 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c          |   18 
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c                      |   23 
 drivers/gpu/drm/imx/imx-tve.c                                  |   70 
 drivers/gpu/drm/nouveau/dispnv50/curs507a.c                    |    1 
 drivers/gpu/drm/panel/panel-simple.c                           |    1 
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c                         |    4 
 drivers/hid/hid-uclogic-core.c                                 |   12 
 drivers/hid/usbhid/hid-core.c                                  |   17 
 drivers/hwtracing/intel_th/core.c                              |   19 
 drivers/iio/adc/ad9467.c                                       |    2 
 drivers/iio/adc/at91-sama5d2_adc.c                             |    1 
 drivers/iio/adc/exynos_adc.c                                   |   13 
 drivers/iio/dac/ad5686.c                                       |    6 
 drivers/input/serio/i8042-acpipnpio.h                          |   18 
 drivers/irqchip/irq-gic-v3-its.c                               |    8 
 drivers/isdn/mISDN/timerdev.c                                  |   13 
 drivers/leds/led-class.c                                       |   10 
 drivers/misc/mei/mei-trace.h                                   |   18 
 drivers/misc/uacce/uacce.c                                     |   42 
 drivers/mmc/host/rtsx_pci_sdmmc.c                              |   41 
 drivers/net/bonding/bond_main.c                                |    5 
 drivers/net/can/usb/ems_usb.c                                  |    8 
 drivers/net/can/usb/esd_usb2.c                                 |    9 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c               |    9 
 drivers/net/can/usb/mcba_usb.c                                 |    8 
 drivers/net/can/usb/usb_8dev.c                                 |    8 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                       |    5 
 drivers/net/ethernet/emulex/benet/be_cmds.c                    |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h         |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c        |    2 
 drivers/net/ethernet/intel/ice/ice_main.c                      |    1 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c                 |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                |   86 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h       |    7 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c              |   22 
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c             |   21 
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h             |    4 
 drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c |    2 
 drivers/net/ethernet/rocker/rocker_main.c                      |    5 
 drivers/net/ipvlan/ipvlan.h                                    |    2 
 drivers/net/ipvlan/ipvlan_core.c                               |   16 
 drivers/net/ipvlan/ipvlan_main.c                               |   49 
 drivers/net/macvlan.c                                          |   84 
 drivers/net/usb/dm9601.c                                       |    4 
 drivers/net/usb/usbnet.c                                       |    9 
 drivers/net/wireless/ath/ath10k/ce.c                           |   16 
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c           |    6 
 drivers/net/wireless/rsi/rsi_91x_mac80211.c                    |    1 
 drivers/nvme/host/fabrics.c                                    |   15 
 drivers/nvme/host/fabrics.h                                    |    1 
 drivers/nvme/host/fc.c                                         |    5 
 drivers/nvme/host/nvme.h                                       |   14 
 drivers/nvme/host/pci.c                                        |   39 
 drivers/nvme/host/rdma.c                                       |    1 
 drivers/nvme/host/tcp.c                                        |    1 
 drivers/nvme/target/tcp.c                                      |   28 
 drivers/of/base.c                                              |    8 
 drivers/of/platform.c                                          |    2 
 drivers/phy/broadcom/phy-bcm-ns-usb3.c                         |    2 
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c                  |   12 
 drivers/phy/st/phy-stm32-usbphyc.c                             |    2 
 drivers/phy/tegra/xusb-tegra186.c                              |    3 
 drivers/pinctrl/meson/pinctrl-meson.c                          |    2 
 drivers/ptp/ptp_chardev.c                                      |   37 
 drivers/ptp/ptp_private.h                                      |   16 
 drivers/scsi/be2iscsi/be_mgmt.c                                |    1 
 drivers/scsi/scsi_error.c                                      |   11 
 drivers/scsi/scsi_lib.c                                        |    8 
 drivers/scsi/storvsc_drv.c                                     |    3 
 drivers/slimbus/core.c                                         |   19 
 drivers/staging/comedi/comedi.h                                |    2 
 drivers/staging/comedi/comedi_fops.c                           |    2 
 drivers/staging/comedi/drivers/dmm32at.c                       |   32 
 drivers/staging/comedi/range.c                                 |    2 
 drivers/staging/iio/adc/ad7280a.c                              |  289 +-
 drivers/target/sbp/sbp_target.c                                |    4 
 drivers/usb/dwc3/core.c                                        |    2 
 drivers/usb/dwc3/core.h                                        |    1 
 drivers/usb/host/ohci-platform.c                               |    1 
 drivers/usb/host/uhci-platform.c                               |    1 
 drivers/usb/serial/ftdi_sio.c                                  |    1 
 drivers/usb/serial/ftdi_sio_ids.h                              |    2 
 drivers/usb/serial/option.c                                    |    1 
 drivers/video/fbdev/core/fbcon.c                               |   34 
 drivers/w1/slaves/w1_therm.c                                   |   69 
 drivers/w1/w1.c                                                |    2 
 drivers/xen/xen-scsiback.c                                     |    1 
 fs/btrfs/transaction.c                                         |   11 
 fs/ext4/xattr.c                                                |    1 
 fs/fs-writeback.c                                              |   14 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                      |    2 
 fs/xfs/libxfs/xfs_ialloc.c                                     |   11 
 include/linux/mlx5/mlx5_ifc.h                                  |   27 
 include/linux/nvme.h                                           |    3 
 include/linux/pagewalk.h                                       |    3 
 include/linux/posix-clock.h                                    |   39 
 include/linux/textsearch.h                                     |    1 
 include/net/nfc/nfc.h                                          |    2 
 include/sound/pcm.h                                            |    2 
 include/uapi/linux/if_link.h                                   |    1 
 kernel/bpf/cgroup.c                                            |    8 
 kernel/dma/pool.c                                              |    7 
 kernel/time/posix-clock.c                                      |   53 
 mm/ksm.c                                                       |  115 
 mm/migrate.c                                                   |   14 
 mm/pagewalk.c                                                  |   20 
 net/bpf/test_run.c                                             |    5 
 net/bridge/br_input.c                                          |    2 
 net/can/j1939/transport.c                                      |   10 
 net/core/filter.c                                              |   25 
 net/ipv4/Makefile                                              |    1 
 net/ipv4/fou.c                                                 | 1315 ----------
 net/ipv4/fou_core.c                                            | 1285 +++++++++
 net/ipv4/fou_nl.c                                              |   48 
 net/ipv4/fou_nl.h                                              |   25 
 net/ipv4/ip_gre.c                                              |   11 
 net/ipv6/ip6_tunnel.c                                          |    2 
 net/ipv6/seg6_hmac.c                                           |    3 
 net/l2tp/l2tp_core.c                                           |    4 
 net/netfilter/nft_connlimit.c                                  |    2 
 net/netrom/nr_route.c                                          |   13 
 net/nfc/core.c                                                 |   27 
 net/nfc/llcp_commands.c                                        |   17 
 net/nfc/llcp_core.c                                            |    4 
 net/nfc/nci/core.c                                             |    4 
 net/sched/act_ife.c                                            |   12 
 net/sched/sch_qfq.c                                            |    8 
 net/sched/sch_teql.c                                           |    5 
 net/sctp/sm_statefuns.c                                        |   36 
 sound/core/oss/pcm_oss.c                                       |    4 
 sound/core/pcm_native.c                                        |    9 
 sound/pci/ctxfi/ctamixer.c                                     |    2 
 sound/soc/codecs/tlv320adcx140.c                               |    4 
 sound/usb/mixer.c                                              |   22 
 tools/testing/selftests/net/fcnal-test.sh                      |    2 
 tools/testing/vsock/util.c                                     |   12 
 156 files changed, 2977 insertions(+), 1986 deletions(-)

Abdun Nihaal (1):
      scsi: xen: scsiback: Fix potential memory leak in scsiback_remove()

Alexander Usyskin (1):
      mei: trace: treat reg parameter as string

Andrey Vatoropin (1):
      be2net: Fix NULL pointer dereference in be_cmd_get_mac_from_list

Arnd Bergmann (1):
      irqchip/gic-v3-its: Avoid truncating memory addresses

Arun Raghavan (1):
      ALSA: usb: Increase volume range that triggers a warning

Bagas Sanjaya (1):
      textsearch: describe @list member in ts_ops search

Bartosz Golaszewski (1):
      pinctrl: meson: mark the GPIO controller as sleeping

Benjamin Tissoires (1):
      HID: usbhid: paper over wrong bNumDescriptor field

Berk Cem Goksel (1):
      ALSA: usb-audio: Fix use-after-free in snd_usb_mixer_free()

Brian Foster (1):
      xfs: set max_agbno to allow sparse alloc of last full inode chunk

Chen Ni (1):
      net/sched: act_ife: convert comma to semicolon

Cheng-Yu Lee (1):
      regmap: Fix race condition in hwspinlock irqsave routine

Chenghai Huang (1):
      uacce: ensure safe queue release with state management

Christophe JAILLET (1):
      macvlan: Use 'hash' iterators to simplify code

Dan Carpenter (2):
      phy: stm32-usphyc: Fix off by one in probe()
      wifi: mwifiex: Fix a loop in mwifiex_update_ampdu_rxwinsize()

Daniel Borkmann (1):
      bpf: Do not let BPF test infra emit invalid GSO types to stack

Daniel Wagner (1):
      nvme-fc: rename free_ctrl callback to match name pattern

David Hildenbrand (1):
      mm/pagewalk: add walk_page_range_vma()

David Jeffery (1):
      scsi: core: Wake up the error handler when final completions race against each other

Dmitry Skorodumov (1):
      ipvlan: Make the addrs_lock be per port

Emil Svendsen (1):
      ASoC: tlv320adcx140: fix word length

Eric Biggers (1):
      ipv6: sr: Fix MAC comparison to be constant-time

Eric Dumazet (8):
      ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()
      macvlan: fix possible UAF in macvlan_forward_source()
      ipv4: ip_gre: make ipgre_header() robust
      net/sched: sch_qfq: do not free existing class in qfq_change_class()
      l2tp: avoid one data-race in l2tp_tunnel_del_work()
      mISDN: annotate data-race around dev->work
      bonding: provide a net pointer to __skb_flow_dissect()
      net/sched: act_ife: avoid possible NULL deref

Ethan Nelson-Moore (2):
      USB: serial: ftdi_sio: add support for PICAXE AXE027 cable
      net: usb: dm9601: remove broken SR9700 support

Fernand Sieber (1):
      perf/x86/intel: Do not enable BTS for guests

Gal Pressman (2):
      net/mlx5e: Expose rx_oversize_pkts_buffer counter
      net/mlx5e: Account for netdev stats in ndo_get_stats64

Greg Kroah-Hartman (2):
      Revert "selftests: Replace sleep with slowwait"
      Linux 5.10.249

Hans de Goede (1):
      leds: led-class: Only Add LED to leds_list when it is fully ready

Haotian Zhang (1):
      dmaengine: omap-dma: fix dma_pool resource leak in error paths

Haoxiang Li (6):
      EDAC/x38: Fix a resource leak in x38_probe1()
      EDAC/i3200: Fix a resource leak in i3200_probe1()
      drm/vmwgfx: Fix an error return check in vmw_compat_shader_add()
      w1: fix redundant counter decrement in w1_attach_slave_device()
      scsi: be2iscsi: Fix a memory leak in beiscsi_boot_get_sinfo()
      drm/amdkfd: fix a memory leak in device_queue_manager_init()

Henry Martin (1):
      HID: uclogic: Add NULL check in uclogic_input_configured()

Huacai Chen (1):
      USB: OHCI/UHCI: Add soft dependencies on ehci_platform

Ian Abbott (2):
      comedi: dmm32at: serialize use of paged registers
      comedi: Fix getting range information for subdevices 16 to 255

Jakub Kicinski (3):
      netlink: add a proto specification for FOU
      net: fou: rename the source for linking
      net: fou: use policy and operation tables generated from the spec

Jamal Hadi Salim (2):
      net/sched: Enforce that teql can only be used as root qdisc
      net/sched: qfq: Use cl_is_active to determine whether class is active in qfq_rm_from_ag

Jaroslav Kysela (1):
      ALSA: pcm: Improve the fix for race of buffer access at PCM OSS layer

Jeongjun Park (1):
      netrom: fix double-free in nr_route_frame()

Jesse Brandeburg (1):
      ice: stop counting UDP csum mismatch as rx_errors

Jethro Beekman (1):
      macvlan: Add nodst option to macvlan type source

Jia-Hong Su (1):
      Bluetooth: hci_uart: fix null-ptr-deref in hci_uart_write_work

Jijie Shao (2):
      net: hns3: fix wrong GENMASK() for HCLGE_FD_AD_COUNTER_NUM_M
      net: hns3: fix the HCLGE_FD_AD_NXT_KEY error setting issue

Jiri Slaby (SUSE) (1):
      fbcon: always restore the old font data in fbcon_do_set_font()

Johan Hovold (13):
      dmaengine: at_hdmac: fix device leak on of_dma_xlate()
      dmaengine: bcm-sba-raid: fix device leak on probe
      dmaengine: lpc18xx-dmamux: fix device leak on route allocation
      dmaengine: ti: dma-crossbar: fix device leak on dra7x route allocation
      dmaengine: ti: dma-crossbar: fix device leak on am335x route allocation
      dmaengine: ti: k3-udma: fix device leak on udma lookup
      slimbus: core: fix runtime PM imbalance on report present
      slimbus: core: fix device reference leak on report present
      intel_th: fix device leak on output open()
      dmaengine: stm32: dmamux: fix OF node leak on route allocation failure
      dmaengine: stm32: dmamux: fix device leak on route allocation
      iio: adc: exynos_adc: fix OF populate on driver rebind
      drm/imx/tve: fix probe device leak

Jonathan Cameron (1):
      staging:iio:adc:ad7280a: Register define cleanup.

Keith Busch (1):
      nvme-pci: do not directly handle subsys reset fallout

Kery Qi (2):
      rocker: fix memory leak in rocker_world_port_post_fini()
      scsi: firewire: sbp-target: Fix overflow in sbp_make_tpg()

Krzysztof Kozlowski (1):
      phy: broadcom: ns-usb3: Fix Wvoid-pointer-to-enum-cast warning (again)

Kuniyuki Iwashima (4):
      gue: Fix skb memleak with inner IP protocol 0.
      fou: Don't allow 0 for FOU_ATTR_IPPROTO.
      nfc: llcp: Fix memleak in nfc_llcp_send_ui_frame().
      nfc: nci: Fix race between rfkill and nci_unregister_device().

Kübrich, Andreas (1):
      iio: dac: ad5686: add AD5695R to ad5686_chip_info_tbl

Laurent Vivier (1):
      usbnet: limit max_mtu based on device's hard_mtu

Laveesh Bansal (1):
      writeback: fix 100% CPU usage when dirtytime_expire_interval is 0

Linus Torvalds (1):
      Fix memory leak in posix_clock_open()

Long Li (1):
      scsi: storvsc: Process unsupported MODE_SENSE_10

Louis Chauvet (1):
      phy: rockchip: inno-usb2: fix disconnection in gadget mode

Luca Ceresoli (1):
      phy: rockchip: inno-usb2: fix communication disruption in gadget mode

Lyude Paul (1):
      drm/nouveau/disp/nv50-: Set lock_core in curs507a_prepare

Marc Kleine-Budde (5):
      can: ems_usb: ems_usb_read_bulk_callback(): fix URB memory leak
      can: kvaser_usb: kvaser_usb_read_bulk_callback(): fix URB memory leak
      can: mcba_usb: mcba_usb_read_bulk_callback(): fix URB memory leak
      can: usb_8dev: usb_8dev_read_bulk_callback(): fix URB memory leak
      can: esd_usb: esd_usb_read_bulk_callback(): fix URB memory leak

Marek Vasut (2):
      drm/panel-simple: fix connector type for DataImage SCF0700C48GGU18 panel
      wifi: rsi: Fix memory corruption due to not set vif driver data size

Martin Kaiser (1):
      net: bridge: fix static key check

Martin Willi (1):
      macvlan: Fix leaking skb in source mode with nodst option

Matthew Schwartz (1):
      mmc: rtsx_pci_sdmmc: implement sdmmc_card_busy function

Matthew Wilcox (Oracle) (1):
      migrate: correct lock ordering for hugetlb file folios

Maurizio Lombardi (1):
      nvmet-tcp: remove boilerplate code

Nilay Shroff (1):
      nvme: fix PCIe subsystem reset controller state transition

Pablo Neira Ayuso (1):
      netfilter: nf_tables: typo NULL check in _clone() function

Paul Chaignon (1):
      bpf: Reject narrower access to pointer ctx fields

Pavel Zhigulin (1):
      iio: adc: ad7280a: handle spi_setup() errors in probe()

Pedro Demarchi Gomes (1):
      ksm: use range-walk function to jump over holes in scan_get_next_rmap_item

Pei Xiao (1):
      iio: adc: at91-sama5d2_adc: Fix potential use-after-free in sama5d2_adc driver

Philipp Zabel (2):
      drm/imx: imx-tve: use local encoder and connector variables
      drm/imx: imx-tve: move initialization into probe

Rahul Rameshbabu (1):
      HID: uclogic: Correct devm device reference for hidinput input_dev name

Raju Rangoju (1):
      amd-xgbe: avoid misleading per-packet error log

Ratheesh Kannoth (1):
      octeontx2-af: Fix error handling

Rob Herring (Arm) (1):
      of: platform: Use default match table for /firmware

Robbie Ko (1):
      btrfs: fix deadlock in wait_current_trans() due to ignored transaction type

Saeed Mahameed (1):
      net/mlx5: Add HW definitions of vport debug counters

Sai Sree Kartheek Adivi (1):
      dma/pool: distinguish between missing and exhausted atomic pools

Sheetal (1):
      dmaengine: tegra-adma: Fix use-after-free

Shigeru Yoshida (1):
      fbdev: fbcon: Properly revert changes when vc_resize() failed

Shivam Kumar (1):
      nvme-tcp: fix NULL pointer dereferences in nvmet_tcp_build_pdu_iovec

Stefano Garzarella (1):
      vsock/test: add a final full barrier after run all tests

Suraj Gupta (1):
      dmaengine: xilinx_dma: Fix uninitialized addr_width when "xlnx,addrwidth" property is missing

Taeyang Lee (1):
      crypto: authencesn - reject too-short AAD (assoclen<8) to match ESP/ESN spec

Takashi Iwai (1):
      ALSA: ctxfi: Fix potential OOB access in audio mixer handling

Tetsuo Handa (2):
      net: can: j1939: j1939_xtp_rx_rts_session_active(): deactivate session upon receiving the second rts
      fbdev: fbcon: release buffer when fbcon_do_set_font() failed

Thinh Nguyen (1):
      usb: dwc3: Check for USB4 IP_NAME

Thomas Fourier (2):
      wifi: ath10k: fix dma_free_coherent() pointer
      octeontx2: Fix otx2_dma_map_page() error return code

Thorsten Blum (1):
      w1: therm: Fix off-by-one buffer overflow in alarms_store

Timur Kristóf (2):
      drm/amd/pm: Don't clear SI SMC table when setting power limit
      drm/amd/pm: Workaround SI powertune issue on Radeon 430 (v2)

Tomas Melin (1):
      iio: adc: ad9467: fix ad9434 vref mask

Ulrich Mohr (1):
      USB: serial: option: add Telit LE910 MBIM composition

Wayne Chang (1):
      phy: tegra: xusb: Explicitly configure HS_DISCON_LEVEL to 0x7

Weigang He (1):
      of: fix reference count leak in of_alias_scan()

Wenkai Lin (1):
      uacce: fix cdev handling in the cleanup path

Wojtek Wasko (2):
      posix-clock: Store file pointer in struct posix_clock_context
      ptp: Add PHC file mode checks. Allow RO adjtime() without FMODE_WRITE.

Xabier Marquiegui (1):
      posix-clock: introduce posix_clock_context concept

Xiaochen Shen (2):
      x86/resctrl: Fix memory bandwidth counter width for Hygon
      x86/resctrl: Add missing resctrl initialization for Hygon

Xin Long (1):
      sctp: move SCTP_CMD_ASSOC_SHKEY right after SCTP_CMD_PEER_INIT

Yafang Shao (1):
      net/mlx5e: Report rx_discards_phy via rx_dropped

Yang Erkun (1):
      ext4: fix iloc.bh leak in ext4_xattr_inode_update_ref

Yang Guang (1):
      w1: w1_therm: use swap() to make code cleaner

Yang Shen (1):
      uacce: implement mremap in uacce_vm_ops to return -EPERM

Yang Yingliang (1):
      driver core: fix potential null-ptr-deref in device_add()

Zheng Yongjun (1):
      sctp: sm_statefuns: Fix spelling mistakes

Zilin Guan (3):
      pnfs/flexfiles: Fix memory leak in nfs4_ff_alloc_deviceid_node()
      net/mlx5: Fix memory leak in esw_acl_ingress_lgcy_setup()
      net: mvpp2: cls: Fix memory leak in mvpp2_ethtool_cls_rule_ins()

feng (1):
      Input: i8042 - add quirk for ASUS Zenbook UX425QA_UM425QA

gongqi (1):
      Input: i8042 - add quirks for MECHREVO Wujie 15X Pro


