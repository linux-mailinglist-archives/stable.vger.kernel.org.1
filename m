Return-Path: <stable+bounces-198209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0B3C9EF0A
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 13:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 183ED4E1376
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 12:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6846C2EA174;
	Wed,  3 Dec 2025 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uuhJKnge"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71C42E973D;
	Wed,  3 Dec 2025 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764763959; cv=none; b=FZtrf4AGNCk67euUW61VKdbyRHrr5yBseuw9v6xWRFoVDgYkJqqYx9jYA34HXo3c/gofq/XLHV2lsRqckqcbNFeLaqJlMEHTbeZhJS9cBm1r+jBk6tezAOEAFvXmRl9igHgzTV6Y7JB6egcNSeUYQ+0keS2hW8PcYlb/G51PxFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764763959; c=relaxed/simple;
	bh=Z5i0InmNLOgTp5/YpL/nInPDOppMEA64rFKVlvW2xW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DE+ZvccTxybP0rYtHLR+0mD7eVnzYF+0rfsLNW8uKaRFPqOZh3DXTATaz6hyZauzHyp5TVs0H2LqxJjr5qgNYN52z/eVgGCzj/TE977++4NntACJKcNR8n/DnaXHSpsigzV3TIKLf6wNOjkUN7LE8ChzjZAFosRwmkRVvrmlnVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uuhJKnge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B35C4CEFB;
	Wed,  3 Dec 2025 12:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764763958;
	bh=Z5i0InmNLOgTp5/YpL/nInPDOppMEA64rFKVlvW2xW4=;
	h=From:To:Cc:Subject:Date:From;
	b=uuhJKngekEyQy3FvY1AdKFw4f2PpY9ASseoz7dmGu9NkJLgt2s7GMIBCY/Wx+NXK2
	 1uEQjDCQBggVi/2ot6Qot3eHknjPElk+p5MqKFRgPTmc+DPI1gnbC6Tm0nQ57fBrWU
	 WPSzGZ12QFTXWFELFBcolTo4L5FIesl8Und3+gtk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.302
Date: Wed,  3 Dec 2025 13:12:32 +0100
Message-ID: <2025120319-blip-grime-93e8@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.302 kernel.

This is the LAST 5.4.y release.  It is now end-of-life and should not be
used by anyone, anymore.  As of this point in time, there are 1539
documented unfixed CVEs for this kernel branch, and that number will
only increase over time as more CVEs get assigned for kernel bugs.

All users of the 5.4 kernel series must upgrade to a newer branch as
this point in time.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                        |    2 
 arch/arc/include/asm/bitops.h                                   |    2 
 arch/mips/boot/dts/lantiq/danube.dtsi                           |    6 
 arch/mips/lantiq/xway/sysctrl.c                                 |    2 
 arch/mips/mti-malta/malta-init.c                                |   20 -
 arch/powerpc/kernel/eeh_driver.c                                |    2 
 arch/sparc/include/asm/elf_64.h                                 |    1 
 arch/sparc/kernel/module.c                                      |    1 
 arch/x86/entry/vsyscall/vsyscall_64.c                           |   17 +
 arch/x86/kernel/cpu/bugs.c                                      |    5 
 arch/x86/kernel/cpu/resctrl/monitor.c                           |   10 
 drivers/acpi/acpi_video.c                                       |    4 
 drivers/acpi/acpica/dsmethod.c                                  |   10 
 drivers/acpi/property.c                                         |   24 +
 drivers/acpi/video_detect.c                                     |    8 
 drivers/ata/libata-scsi.c                                       |    8 
 drivers/base/devcoredump.c                                      |  138 ++++++----
 drivers/base/regmap/regmap-slimbus.c                            |    6 
 drivers/bluetooth/btusb.c                                       |   13 
 drivers/bluetooth/hci_bcsp.c                                    |    3 
 drivers/char/misc.c                                             |    8 
 drivers/clocksource/timer-vf-pit.c                              |   22 -
 drivers/cpufreq/longhaul.c                                      |    3 
 drivers/dma/dw-edma/dw-edma-core.c                              |   22 +
 drivers/dma/mv_xor.c                                            |    4 
 drivers/dma/sh/shdma-base.c                                     |   25 +
 drivers/dma/sh/shdmac.c                                         |   17 -
 drivers/edac/altera_edac.c                                      |   22 +
 drivers/extcon/extcon-adc-jack.c                                |    2 
 drivers/firmware/arm_scmi/scmi_pm_domain.c                      |   13 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                        |    8 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                           |    9 
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c                        |    2 
 drivers/gpu/drm/nouveau/nvkm/core/enum.c                        |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                         |    5 
 drivers/hid/hid-ids.h                                           |    7 
 drivers/hid/hid-quirks.c                                        |   14 -
 drivers/hwmon/dell-smm-hwmon.c                                  |    7 
 drivers/iio/adc/spear_adc.c                                     |    9 
 drivers/input/keyboard/cros_ec_keyb.c                           |    6 
 drivers/input/misc/ati_remote2.c                                |    2 
 drivers/input/misc/cm109.c                                      |    2 
 drivers/input/misc/powermate.c                                  |    2 
 drivers/input/misc/yealink.c                                    |    2 
 drivers/input/tablet/acecad.c                                   |    2 
 drivers/input/tablet/pegasus_notetaker.c                        |   11 
 drivers/irqchip/irq-gic-v2m.c                                   |   13 
 drivers/isdn/hardware/mISDN/hfcsusb.c                           |   18 -
 drivers/media/i2c/ir-kbd-i2c.c                                  |    6 
 drivers/media/pci/ivtv/ivtv-alsa-pcm.c                          |    2 
 drivers/media/pci/ivtv/ivtv-driver.h                            |    3 
 drivers/media/pci/ivtv/ivtv-fileops.c                           |   18 -
 drivers/media/pci/ivtv/ivtv-irq.c                               |    4 
 drivers/media/rc/imon.c                                         |   61 ++--
 drivers/media/rc/redrat3.c                                      |    2 
 drivers/media/tuners/xc4000.c                                   |    8 
 drivers/media/tuners/xc5000.c                                   |   12 
 drivers/memstick/core/memstick.c                                |    8 
 drivers/mfd/madera-core.c                                       |    4 
 drivers/mfd/stmpe-i2c.c                                         |    1 
 drivers/mfd/stmpe.c                                             |    3 
 drivers/mmc/host/renesas_sdhi_core.c                            |    6 
 drivers/mmc/host/sdhci-msm.c                                    |   15 +
 drivers/net/can/usb/gs_usb.c                                    |   23 -
 drivers/net/dsa/b53/b53_common.c                                |   57 +++-
 drivers/net/dsa/b53/b53_regs.h                                  |    4 
 drivers/net/ethernet/cadence/macb_main.c                        |    4 
 drivers/net/ethernet/emulex/benet/be_main.c                     |    7 
 drivers/net/ethernet/freescale/fec_main.c                       |    2 
 drivers/net/ethernet/intel/fm10k/fm10k_common.c                 |    5 
 drivers/net/ethernet/intel/fm10k/fm10k_common.h                 |    2 
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c                     |    2 
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c                     |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c              |   15 -
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c           |    6 
 drivers/net/ethernet/qlogic/qede/qede_main.c                    |    2 
 drivers/net/ethernet/renesas/ravb_main.c                        |   16 +
 drivers/net/ethernet/renesas/sh_eth.c                           |    4 
 drivers/net/ethernet/ti/netcp_core.c                            |   10 
 drivers/net/phy/dp83867.c                                       |    6 
 drivers/net/phy/mdio_bus.c                                      |    5 
 drivers/net/usb/asix_devices.c                                  |   12 
 drivers/net/usb/qmi_wwan.c                                      |    6 
 drivers/net/usb/usbnet.c                                        |    2 
 drivers/net/wireless/ath/ath10k/wmi.c                           |    1 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c     |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c          |   21 -
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h          |    3 
 drivers/pci/p2pdma.c                                            |    2 
 drivers/pci/quirks.c                                            |    1 
 drivers/phy/cadence/cdns-dphy.c                                 |    4 
 drivers/regulator/fixed.c                                       |    6 
 drivers/remoteproc/qcom_q6v5.c                                  |    5 
 drivers/s390/net/ctcm_mpc.c                                     |    1 
 drivers/scsi/lpfc/lpfc_debugfs.h                                |    3 
 drivers/scsi/lpfc/lpfc_scsi.c                                   |   14 -
 drivers/scsi/pm8001/pm8001_ctl.c                                |    2 
 drivers/scsi/sg.c                                               |   10 
 drivers/soc/imx/gpc.c                                           |    2 
 drivers/soc/qcom/smem.c                                         |    2 
 drivers/soc/ti/knav_dma.c                                       |   14 -
 drivers/spi/spi-loopback-test.c                                 |   12 
 drivers/spi/spi.c                                               |   10 
 drivers/target/loopback/tcm_loop.c                              |    3 
 drivers/tee/tee_core.c                                          |    2 
 drivers/tty/serial/8250/8250_dw.c                               |  128 ++++-----
 drivers/uio/uio_hv_generic.c                                    |   21 +
 drivers/usb/gadget/function/f_fs.c                              |    8 
 drivers/usb/gadget/function/f_hid.c                             |    4 
 drivers/usb/gadget/function/f_ncm.c                             |    3 
 drivers/usb/host/xhci-plat.c                                    |    1 
 drivers/usb/mon/mon_bin.c                                       |   14 -
 drivers/video/backlight/lp855x_bl.c                             |    2 
 drivers/video/fbdev/aty/atyfb_base.c                            |    8 
 drivers/video/fbdev/core/bitblit.c                              |   33 ++
 drivers/video/fbdev/pvr2fb.c                                    |    2 
 drivers/video/fbdev/valkyriefb.c                                |    2 
 fs/9p/v9fs.c                                                    |    9 
 fs/btrfs/transaction.c                                          |    2 
 fs/ceph/locks.c                                                 |    5 
 fs/hpfs/namei.c                                                 |   18 -
 fs/jfs/inode.c                                                  |    8 
 fs/jfs/jfs_txnmgr.c                                             |    9 
 fs/nfs/nfs4client.c                                             |    1 
 fs/nfs/nfs4proc.c                                               |    6 
 fs/nfs/nfs4state.c                                              |    3 
 fs/open.c                                                       |   10 
 fs/orangefs/xattr.c                                             |   12 
 fs/proc/generic.c                                               |   12 
 include/linux/ata.h                                             |    1 
 include/linux/compiler_types.h                                  |    5 
 include/linux/filter.h                                          |    2 
 include/linux/mm.h                                              |    2 
 include/linux/shdma-base.h                                      |    2 
 include/linux/usb.h                                             |   16 -
 include/net/cls_cgroup.h                                        |    2 
 include/net/nfc/nci_core.h                                      |    2 
 include/net/pkt_sched.h                                         |   25 +
 kernel/events/uprobes.c                                         |    7 
 kernel/gcov/gcc_4_7.c                                           |    4 
 kernel/trace/trace_events_hist.c                                |    6 
 mm/page_alloc.c                                                 |    2 
 net/8021q/vlan.c                                                |    2 
 net/bluetooth/6lowpan.c                                         |   97 ++++---
 net/bluetooth/l2cap_core.c                                      |    1 
 net/bluetooth/sco.c                                             |    7 
 net/bridge/br_forward.c                                         |    3 
 net/core/netpoll.c                                              |    7 
 net/core/page_pool.c                                            |    6 
 net/core/sock.c                                                 |   15 -
 net/ipv4/nexthop.c                                              |    6 
 net/ipv4/route.c                                                |    5 
 net/ipv6/ah6.c                                                  |   50 ++-
 net/ipv6/raw.c                                                  |    2 
 net/ipv6/udp.c                                                  |    2 
 net/mac80211/rx.c                                               |   10 
 net/openvswitch/actions.c                                       |   68 ----
 net/openvswitch/flow_netlink.c                                  |   64 ----
 net/openvswitch/flow_netlink.h                                  |    2 
 net/rds/rds.h                                                   |    2 
 net/sched/act_ife.c                                             |   12 
 net/sched/sch_api.c                                             |   10 
 net/sched/sch_generic.c                                         |   24 -
 net/sched/sch_hfsc.c                                            |   16 -
 net/sched/sch_qfq.c                                             |    2 
 net/sctp/associola.c                                            |   10 
 net/sctp/chunk.c                                                |    2 
 net/sctp/diag.c                                                 |    7 
 net/sctp/endpointola.c                                          |    6 
 net/sctp/input.c                                                |    5 
 net/sctp/output.c                                               |    2 
 net/sctp/outqueue.c                                             |    6 
 net/sctp/sm_make_chunk.c                                        |    7 
 net/sctp/sm_sideeffect.c                                        |   16 -
 net/sctp/sm_statefuns.c                                         |    2 
 net/sctp/socket.c                                               |   12 
 net/sctp/stream.c                                               |    3 
 net/sctp/stream_interleave.c                                    |   23 -
 net/sctp/transport.c                                            |   15 -
 net/sctp/ulpqueue.c                                             |   15 -
 net/strparser/strparser.c                                       |    2 
 net/tipc/core.c                                                 |    4 
 net/tipc/core.h                                                 |    8 
 net/tipc/discover.c                                             |    4 
 net/tipc/link.c                                                 |    5 
 net/tipc/link.h                                                 |    1 
 net/tipc/net.c                                                  |   17 -
 net/vmw_vsock/af_vsock.c                                        |   40 ++
 scripts/kconfig/mconf.c                                         |    3 
 scripts/kconfig/nconf.c                                         |    3 
 sound/soc/codecs/cs4271.c                                       |   10 
 sound/soc/codecs/max98090.c                                     |    6 
 sound/soc/qcom/qdsp6/q6asm.c                                    |    2 
 sound/usb/mixer.c                                               |   11 
 tools/power/cpupower/lib/cpuidle.c                              |    5 
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c |   26 +
 tools/testing/selftests/Makefile                                |    2 
 tools/testing/selftests/bpf/test_lirc_mode2_user.c              |    2 
 tools/testing/selftests/net/fcnal-test.sh                       |    4 
 tools/testing/selftests/net/psock_tpacket.c                     |    4 
 200 files changed, 1294 insertions(+), 813 deletions(-)

Abdun Nihaal (1):
      isdn: mISDN: hfcsusb: fix memory leak in hfcsusb_probe()

Al Viro (2):
      allow finish_no_open(file, ERR_PTR(-E...))
      nfs4_setup_readdir(): insufficient locking for ->d_parent->d_inode dereferencing

Albin Babu Varghese (1):
      fbdev: Add bounds checking in bit_putcs to fix vmalloc-out-of-bounds

Aleksander Jan Bajkowski (3):
      mips: lantiq: danube: add missing properties to cpu node
      mips: lantiq: danube: add missing device_type in pci node
      mips: lantiq: xway: sysctrl: rename stp clock

Aleksei Nikiforov (1):
      s390/ctcm: Fix double-kfree

Alexander Stein (2):
      mfd: stmpe: Remove IRQ domain upon removal
      mfd: stmpe-i2c: Add missing MODULE_LICENSE

Alexey Klimov (1):
      regmap: slimbus: fix bus_context pointer in regmap init calls

Amber Lin (1):
      drm/amdkfd: Tie UNMAP_LATENCY to queue_preemption

Amirreza Zarrabi (1):
      tee: allow a driver to allocate a tee_device without a pool

Andrey Vatoropin (1):
      be2net: pass wrb_params in case of OS2BMC

Andy Shevchenko (2):
      serial: 8250_dw: Use devm_clk_get_optional() to get the input clock
      serial: 8250_dw: Use devm_add_action_or_reset()

Anthony Iliopoulos (1):
      NFSv4.1: fix mount hang after CREATE_SESSION failure

Armin Wolf (1):
      hwmon: (dell-smm) Add support for Dell OptiPlex 7040

Arnd Bergmann (1):
      mfd: madera: Work around false-positive -Wininitialized warning

Artem Shimko (1):
      serial: 8250_dw: handle reset control deassert error

Babu Moger (1):
      x86/resctrl: Fix miscount of bandwidth event when reactivating previously unavailable RMID

Bart Van Assche (1):
      scsi: sg: Do not sleep in atomic context

Benjamin Berg (1):
      wifi: mac80211: skip rate verification for not captured PSDUs

Biju Das (1):
      mmc: host: renesas_sdhi: Fix the actual clock

Brahmajit Das (1):
      net: intel: fm10k: Fix parameter idx set but not used

Breno Leitao (1):
      net: netpoll: fix incorrect refcount handling causing incorrect cleanup

Buday Csaba (1):
      net: mdio: fix resource leak in mdiobus_register_device()

Celeste Liu (1):
      can: gs_usb: increase max interface to U8_MAX

Charalampos Mitrodimas (1):
      net: ipv6: fix field-spanning memcpy warning in AH output

Chelsy Ratnawat (1):
      media: fix uninitialized symbol warnings

Chris Morgan (1):
      regulator: fixed: use dev_err_probe for register

Christian Bruel (1):
      irqchip/gic-v2m: Handle Multiple MSI base IRQ Alignment

Christoph Paasch (1):
      net: When removing nexthops, don't call synchronize_net if it is not necessary

Chuang Wang (1):
      ipv4: route: Prevent rt_bind_exception() from rebinding stale fnhe

Cryolitia PukNgae (1):
      ALSA: usb-audio: apply quirk for MOONDROP Quark2

Daniel Lezcano (1):
      clocksource/drivers/vf-pit: Replace raw_readl/writel to readl/writel

Daniel Palmer (1):
      fbdev: atyfb: Check if pll_ops->init_pll failed

David Ahern (2):
      selftests: Disable dad for ipv6 in fcnal-test.sh
      selftests: Replace sleep with slowwait

David Kaplan (1):
      x86/bugs: Fix reporting of LFENCE retpoline

Dennis Beier (1):
      cpufreq/longhaul: handle NULL policy in longhaul_exit

Devendra K Verma (1):
      dmaengine: dw-edma: Set status for callback_result

Dragos Tatulea (1):
      page_pool: Clamp pool size to max 16K pages

Emanuele Ghidoli (1):
      net: phy: dp83867: Disable EEE support as not implemented

Eric Dumazet (5):
      net: call cond_resched() less often in __release_sock()
      ipv6: np->rxpmtu race annotation
      sctp: prevent possible shift-out-of-bounds in sctp_transport_update_rto
      net_sched: remove need_resched() from qdisc_run()
      net_sched: limit try_bulk_dequeue_skb() batches

Filipe Manana (1):
      btrfs: use smp_mb__after_atomic() when forcing COW in create_pending_snapshot()

Florian Fuchs (1):
      fbdev: pvr2fb: Fix leftover reference to ONCHIP_NR_DMA_CHANNELS

Forest Crossman (1):
      usb: mon: Increase BUFF_MAX to 64 MiB to support multi-MB URBs

Gal Pressman (2):
      net/mlx5e: Fix maxrate wraparound in threshold between units
      net/mlx5e: Fix wraparound in rate limiting for values above 255 Gbps

Geoffrey McRae (1):
      drm/amdkfd: return -ENOTTY for unsupported IOCTLs

Gokul Sivakumar (1):
      wifi: brcmfmac: fix crash while sending Action Frames in standalone AP Mode

Greg Kroah-Hartman (1):
      Linux 5.4.302

Haein Lee (1):
      ALSA: usb-audio: Fix NULL pointer dereference in snd_usb_mixer_controls_badd

Hamza Mahfooz (1):
      scsi: target: tcm_loop: Fix segfault in tcm_loop_tpg_address_show()

Hangbin Liu (1):
      net: vlan: sync VLAN features with lower device

Hans de Goede (2):
      ACPICA: dispatcher: Use acpi_ds_clear_operands() in acpi_ds_call_control_method()
      spi: Try to get ACPI GPIO IRQ earlier

Haotian Zhang (2):
      regulator: fixed: fix GPIO descriptor leak on register failure
      ASoC: cs4271: Fix regulator leak on probe failure

Harikrishna Shenoy (1):
      phy: cadence: cdns-dphy: Enable lower resolutions in dphy

Ian Forbes (1):
      drm/vmwgfx: Validate command header size against SVGA_CMD_MAX_DATASIZE

Ido Schimmel (1):
      bridge: Redirect to backup port when port is administratively down

Ilya Maximets (1):
      net: openvswitch: remove never-working support for setting nsh fields

Isaac J. Manjarres (1):
      mm/page_alloc: fix hash table order logging in alloc_large_system_hash()

Ivan Pravdin (1):
      Bluetooth: bcsp: receive data only if registered

Jakub Acs (1):
      mm/ksm: fix flag-dropping behavior in ksm_madvise

Jakub Horký (2):
      kconfig/mconf: Initialize the default locale at startup
      kconfig/nconf: Initialize the default locale at startup

Jens Reidel (1):
      soc: qcom: smem: Fix endian-unaware access of num_entries

Jiayi Li (1):
      memstick: Add timeout to prevent indefinite waiting

Jiri Olsa (1):
      uprobe: Do not emulate/sstep original instruction when ip is changed

Jonas Gorski (3):
      net: dsa: b53: fix resetting speed and pause on forced link
      net: dsa: b53: fix enabling ip multicast
      net: dsa: b53: stop reading ARL entries if search is done

Joshua Watt (1):
      NFS4: Fix state renewals missing after boot

Junjie Cao (1):
      fbdev: bitblit: bound-check glyph index in bit_putcs*

Juraj Šarinay (1):
      net: nfc: nci: Increase NCI_DATA_TIMEOUT to 3000 ms

Justin Tee (2):
      scsi: lpfc: Check return status of lpfc_reset_flush_io_context during TGT_RESET
      scsi: lpfc: Define size of debugfs entry for xri rebalancing

Kaushlendra Kumar (1):
      tools/cpupower: Fix incorrect size in cpuidle_state_disable()

Kees Cook (1):
      arc: Fix __fls() const-foldability via __builtin_clzl()

Kirill A. Shutemov (1):
      x86/vsyscall: Do not require X86_PF_INSTR to emulate vsyscall

Koakuma (1):
      sparc/module: Add R_SPARC_UA64 relocation handling

Krishna Kurapati (1):
      usb: xhci: plat: Facilitate using autosuspend for xhci plat devices

Krzysztof Kozlowski (2):
      extcon: adc-jack: Fix wakeup source leaks on device unbind
      extcon: adc-jack: Cleanup wakeup source only if it was enabled

Kuniyuki Iwashima (2):
      net: Call trace_sock_exceed_buf_limit() for memcg failure with SK_MEM_RECV.
      tipc: Fix use-after-free in tipc_mon_reinit_self().

Lad Prabhakar (1):
      net: ravb: Enforce descriptor type ordering

Laurent Pinchart (1):
      media: pci: ivtv: Don't create fake v4l2_fh

Len Brown (2):
      tools/power x86_energy_perf_policy: Enhance HWP enable
      tools/power x86_energy_perf_policy: Prefer driver HWP limits

Lizhi Xu (1):
      usbnet: Prevents free active kevent

Loic Poulain (1):
      wifi: ath10k: Fix memory leak on unsupported WMI command

Long Li (1):
      uio_hv_generic: Set event for all channels on the device

Luiz Augusto von Dentz (1):
      Bluetooth: SCO: Fix UAF on sco_conn_free

Maarten Lankhorst (1):
      devcoredump: Fix circular locking dependency with devcd->mutex.

Maciej W. Rozycki (1):
      MIPS: Malta: Fix !EVA SOC-it PCI MMIO

Marcos Del Sol Vives (1):
      PCI: Disable MSI on RDC PCI to PCIe bridges

Mario Limonciello (AMD) (1):
      ACPI: video: force native for Lenovo 82K8

Miaoqian Lin (3):
      net: usb: asix_devices: Check return value of usbnet_get_endpoints
      fbdev: valkyriefb: Fix reference count leak in valkyriefb_init
      pmdomain: imx: Fix reference count leak in imx_gpc_remove

Michal Luczaj (1):
      vsock: Ignore signal/timeout on connect() if already established

Mike Marshall (1):
      orangefs: fix xattr related buffer overflow...

Nai-Chen Cheng (1):
      selftests/Makefile: include $(INSTALL_DEP_TARGETS) in clean target to clean net/lib dependency

Nate Karstens (1):
      strparser: Fix signed/unsigned mismatch bug

Nathan Chancellor (1):
      net: qede: Initialize qede_ll_ops with designated initializer

Niklas Cassel (1):
      ata: libata-scsi: Fix system suspend for a security locked drive

Niklas Schnelle (1):
      powerpc/eeh: Use result of error_detected() in uevent

Niklas Söderlund (1):
      net: sh_eth: Disable WoL if system can not suspend

Niravkumar L Rabara (2):
      EDAC/altera: Handle OCRAM ECC enable after warm reset
      EDAC/altera: Use INTTEST register for Ethernet and USB SBE injection

Nishanth Menon (1):
      net: ethernet: ti: netcp: Standardize knav_dma_open_channel to return NULL on error

Olga Kornievskaia (1):
      NFSv4: handle ERR_GRACE on delegation recalls

Owen Gu (1):
      usb: gadget: f_fs: Fix epfile null pointer access after ep enable.

Pauli Virtanen (4):
      Bluetooth: 6lowpan: reset link-local header on ipv6 recv path
      Bluetooth: 6lowpan: fix BDADDR_LE vs ADDR_LE_DEV address type confusion
      Bluetooth: 6lowpan: Don't hold spin lock over sleeping functions
      Bluetooth: L2CAP: export l2cap_chan_hold for modules

Peter Oberparleiter (1):
      gcov: add support for GCC 15

Peter Zijlstra (1):
      compiler_types: Move unused static inline functions warning to W=2

Qendrim Maxhuni (1):
      net: usb: qmi_wwan: initialize MAC header offset in qmimux_rx_fixup

Qianfeng Rong (2):
      scsi: pm8001: Use int instead of u32 to store error codes
      media: redrat3: use int type to store negative error codes

Randall P. Embry (2):
      9p: fix /sys/fs/9p/caches overwriting itself
      9p: sysfs_init: don't hardcode error to ENOMEM

Ranganath V N (1):
      net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak

Raphael Pinsonneault-Thibeault (1):
      Bluetooth: btusb: reorder cleanup in btusb_disconnect to avoid UAF

René Rebe (1):
      ALSA: usb-audio: fix uac2 clock source at terminal parser

Ricardo B. Marlière (1):
      selftests/bpf: Fix bpf_prog_detach2 usage in test_lirc_mode2

Rodrigo Gobbi (1):
      iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel and avg sample before setting register

Rosen Penev (1):
      dmaengine: mv_xor: match alloc_wc and free_wc

Russell King (1):
      net: dsa/b53: change b53_force_port_config() pause argument

Sakari Ailus (1):
      ACPI: property: Return present device nodes only on fwnode interface

Saket Dumbre (1):
      ACPICA: Update dsmethod.c to get rid of unused variable warning

Sarthak Garg (1):
      mmc: sdhci-msm: Enable tuning for SDR50 mode for SD card

Seungjin Bae (1):
      Input: pegasus-notetaker - fix potential out-of-bounds access

Seyediman Seyedarab (1):
      drm/nouveau: replace snprintf() with scnprintf() in nvkm_snprintbf()

Sharique Mohammad (1):
      ASoC: max98090/91: fixed max98091 ALSA widget powering up/down

Shaurya Rane (1):
      jfs: fix uninitialized waitqueue in transaction manager

Srinivas Kandagatla (1):
      ASoC: qdsp6: q6asm: do not sleep while atomic

Stefan Wiehler (2):
      sctp: Hold RCU read lock while iterating over address list
      sctp: Prevent TOCTOU out-of-bounds write

Stephan Gerhold (1):
      remoteproc: qcom: q6v5: Avoid handling handover twice

Sudeep Holla (1):
      pmdomain: arm: scmi: Fix genpd leak on provider registration failure

Sungho Kim (1):
      PCI/P2PDMA: Fix incorrect pointer usage in devm_kfree() call

Svyatoslav Ryhel (1):
      video: backlight: lp855x_bl: Set correct EPROM start for LP8556

Tetsuo Handa (2):
      media: imon: make send_packet() more robust
      jfs: Verify inode mode when loading from disk

Thomas Andreatta (1):
      dmaengine: sh: setup_xref error handling

Thomas Weißschuh (2):
      spi: loopback-test: Don't use %pK through printk
      bpf: Don't use %pK through printk

Théo Lebrun (1):
      net: macb: avoid dealing with endianness in macb_set_hwaddr()

Tomeu Vizoso (1):
      drm/etnaviv: fix flush sequence logic

Tristan Lobb (1):
      HID: quirks: avoid Cooler Master MM712 dongle wakeup bug

Tzung-Bi Shih (1):
      Input: cros_ec_keyb - fix an invalid memory access

Ujwal Kundur (1):
      rds: Fix endianness annotation for RDS_MPATH_HASH

Viacheslav Dubeyko (1):
      ceph: add checking of wait_for_completion_killable() return value

Vincent Mailhol (2):
      usb: deprecate the third argument of usb_maxpacket()
      Input: remove third argument of usb_maxpacket()

Wake Liu (2):
      selftests/net: Replace non-standard __WORDSIZE with sizeof(long) * 8
      selftests/net: Ensure assert() triggers in psock_tpacket.c

Wei Fang (1):
      net: fec: correct rx_bytes statistic for the case SHIFT16 is set

Wei Yang (1):
      fs/proc: fix uaf in proc_readdir_de()

William Wu (1):
      usb: gadget: f_hid: Fix zero length packet transfer

Xiang Mei (1):
      net/sched: sch_qfq: Fix null-deref in agg_dequeue

Xin Long (2):
      sctp: get netns from asoc and ep base
      tipc: simplify the finalize work queue

Yafang Shao (1):
      net/cls_cgroup: Fix task_get_classid() during qdisc run

Yikang Yue (1):
      fs/hpfs: Fix error code for new_inode() failure in mkdir/create/mknod/symlink

Yuhao Jiang (1):
      ACPI: video: Fix use-after-free in acpi_video_switch_brightness()

Zhang Heng (1):
      HID: quirks: work around VID/PID conflict for 0x4c4a/0x4155

Zijun Hu (1):
      char: misc: Does not request module for miscdevice with dynamic minor

Zilin Guan (2):
      tracing: Fix memory leaks in create_field_var()
      mlxsw: spectrum: Fix memory leak in mlxsw_sp_flower_stats()

raub camaioni (1):
      usb: gadget: f_ncm: Fix MAC assignment NCM ethernet

Álvaro Fernández Rojas (1):
      net: dsa: b53: prevent GMII_PORT_OVERRIDE_CTRL access on BCM5325


