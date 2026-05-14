Return-Path: <stable+bounces-247214-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N1jIVPdBWokcgIAu9opvQ
	(envelope-from <stable+bounces-247214-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:33:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D55745432BC
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 847E43128E83
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E023E51F7;
	Thu, 14 May 2026 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="msgcQELb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71724223707;
	Thu, 14 May 2026 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768637; cv=none; b=BlhHgqEbwP+74sIhseBoVOZSPoH7fFmdVoZW31N53VTyphCf8axi1s+pNU/5SCADDyCTPw64A1wAr7wpNadLi9GTeBHxnkioTAkjYoSo46eLn6bDHRgFf5OvbrdFLXCOAacX9aZw1U0T8kPIMxlbgRTm/5M8mAg2O2mVxnZIHoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768637; c=relaxed/simple;
	bh=CNl3By5+C9BCzvjEbpGfLS163tuLMoI/D1SZ+EZMUEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t6IMavlDZwnXGr6filYmTMNNTpRmrE5BmCCfUDOj+Lr9XTugJmrJrmJUC4+Uh1rGu037hh4Oui9+QyL1FF81uzW/ExpkH5w89Ry5Coh7yWyQ78xUEzr8kAavEJf8XyEMtsimbpDPft0Pb3W0SjmOBVRFfHZRpMsmOsfPEstvcNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=msgcQELb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C85C2BCB8;
	Thu, 14 May 2026 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778768637;
	bh=CNl3By5+C9BCzvjEbpGfLS163tuLMoI/D1SZ+EZMUEY=;
	h=From:To:Cc:Subject:Date:From;
	b=msgcQELblNSwlsO302RasdrAHTKbFSXi+yki+8Rtb0VU4FyzLU7oVdVFNL6yRkYQA
	 t9Z3Gd5uGcTuEs0UjfmYOWjh9HJyhScp4UOETNWvzUkWOCMMJ1Zd3i8BvOeD+k7X73
	 MxemTTpHM8Q/2p01JyCFJePmPdgaRWpOvYe9ulx0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.88
Date: Thu, 14 May 2026 16:23:56 +0200
Message-ID: <2026051457-drainable-limpness-4d36@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D55745432BC
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
	TAGGED_FROM(0.00)[bounces-247214-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.954];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

I'm announcing the release of the 6.12.88 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                |    2 
 arch/arm64/include/asm/kvm_host.h                       |    2 
 arch/arm64/kvm/arm.c                                    |    5 
 arch/arm64/kvm/hyp/nvhe/setup.c                         |    6 
 arch/arm64/kvm/vgic/vgic-mmio-v2.c                      |    2 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                      |    2 
 arch/loongarch/include/asm/linkage.h                    |    2 
 arch/loongarch/kvm/exit.c                               |    1 
 arch/loongarch/kvm/interrupt.c                          |   14 +
 arch/loongarch/kvm/mmu.c                                |    2 
 arch/loongarch/kvm/switch.S                             |    2 
 arch/loongarch/kvm/timer.c                              |   10 
 arch/loongarch/kvm/vm.c                                 |    2 
 arch/loongarch/pci/acpi.c                               |    5 
 arch/loongarch/pci/pci.c                                |    3 
 arch/powerpc/kexec/Makefile                             |    2 
 arch/powerpc/platforms/pseries/svm.c                    |    1 
 arch/s390/kernel/debug.c                                |    5 
 arch/x86/include/asm/msr-index.h                        |    3 
 arch/x86/kernel/cpu/amd.c                               |    3 
 arch/x86/kernel/shstk.c                                 |   45 ++--
 arch/x86/kvm/hyperv.c                                   |    2 
 arch/x86/kvm/mmu/mmu.c                                  |   35 +--
 arch/x86/kvm/svm/nested.c                               |   12 -
 arch/x86/kvm/svm/svm.c                                  |    4 
 arch/x86/kvm/svm/svm.h                                  |    1 
 block/blk.h                                             |    2 
 drivers/acpi/cppc_acpi.c                                |    6 
 drivers/acpi/power.c                                    |    2 
 drivers/acpi/scan.c                                     |    2 
 drivers/acpi/video_detect.c                             |   16 +
 drivers/bluetooth/btmtk.c                               |   15 +
 drivers/bluetooth/virtio_bt.c                           |   39 ++-
 drivers/char/ipmi/ipmi_si_intf.c                        |   70 +++++-
 drivers/char/ipmi/ipmi_ssif.c                           |   23 +-
 drivers/clk/clk-rk808.c                                 |    2 
 drivers/clk/imx/clk-imx8-acm.c                          |    3 
 drivers/clk/microchip/clk-mpfs-ccc.c                    |    6 
 drivers/cpuidle/cpuidle-powernv.c                       |    5 
 drivers/cpuidle/cpuidle-pseries.c                       |    5 
 drivers/crypto/caam/caamalg_qi2.c                       |    4 
 drivers/crypto/caam/caamhash.c                          |    4 
 drivers/crypto/nx/nx-842.c                              |    8 
 drivers/extcon/extcon-ptn5150.c                         |   14 +
 drivers/gpio/gpiolib-of.c                               |    9 
 drivers/hwmon/corsair-psu.c                             |    4 
 drivers/hwmon/ltc2992.c                                 |   43 ++-
 drivers/hwmon/powerz.c                                  |    5 
 drivers/infiniband/hw/hns/hns_roce_qp.c                 |    7 
 drivers/infiniband/hw/mana/qp.c                         |   16 -
 drivers/infiniband/hw/mlx4/srq.c                        |    4 
 drivers/infiniband/hw/mlx5/main.c                       |    1 
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c             |    4 
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c         |    2 
 drivers/infiniband/sw/rxe/rxe_recv.c                    |   11 
 drivers/infiniband/sw/rxe/rxe_resp.c                    |   14 +
 drivers/iommu/amd/amd_iommu_types.h                     |    2 
 drivers/iommu/amd/init.c                                |    2 
 drivers/iommu/amd/iommu.c                               |   18 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c             |    7 
 drivers/iommu/iommufd/io_pagetable.c                    |   10 
 drivers/md/dm-ioctl.c                                   |    6 
 drivers/md/dm-verity-fec.c                              |    8 
 drivers/md/persistent-data/dm-btree-remove.c            |    8 
 drivers/md/raid10.c                                     |    2 
 drivers/mmc/core/card.h                                 |    5 
 drivers/mmc/core/queue.c                                |    9 
 drivers/mmc/core/quirks.h                               |    9 
 drivers/mtd/nand/spi/winbond.c                          |    4 
 drivers/mtd/spi-nor/debugfs.c                           |    4 
 drivers/net/ethernet/ibm/ibmveth.c                      |   22 +
 drivers/net/ethernet/ibm/ibmveth.h                      |    1 
 drivers/net/ethernet/intel/ice/ice_sf_eth.c             |    2 
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c |   36 +++
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c        |    2 
 drivers/net/ethernet/stmicro/stmmac/common.h            |    2 
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c         |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c       |   47 ++--
 drivers/net/ethernet/wangxun/libwx/wx_hw.c              |    7 
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c          |    2 
 drivers/net/gtp.c                                       |    2 
 drivers/net/wireless/ath/ath5k/base.c                   |    3 
 drivers/net/wireless/broadcom/b43/xmit.c                |    3 
 drivers/net/wireless/broadcom/b43legacy/xmit.c          |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c |    6 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c        |    7 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c         |    3 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c         |    6 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c         |    4 
 drivers/net/wireless/rsi/rsi_common.h                   |    5 
 drivers/net/wwan/t7xx/t7xx_modem_ops.c                  |   20 +
 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c              |   18 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.h                 |    2 
 drivers/nvme/host/apple.c                               |    6 
 drivers/nvme/target/core.c                              |    2 
 drivers/nvme/target/tcp.c                               |   26 ++
 drivers/parisc/lasi.c                                   |   12 -
 drivers/pci/pci.c                                       |    7 
 drivers/pci/pcie/aer.c                                  |    2 
 drivers/pci/pcie/aspm.c                                 |   17 +
 drivers/pci/setup-res.c                                 |    2 
 drivers/pmdomain/core.c                                 |   10 
 drivers/power/supply/max17042_battery.c                 |    2 
 drivers/spi/spi-microchip-core-qspi.c                   |   12 -
 drivers/spi/spi-rockchip.c                              |    4 
 drivers/spi/spi-s3c64xx.c                               |    5 
 drivers/spi/spi-sun4i.c                                 |   10 
 drivers/spi/spi-sun6i.c                                 |    8 
 drivers/spi/spi-synquacer.c                             |    8 
 drivers/spi/spi-ti-qspi.c                               |   14 -
 drivers/spi/spi-topcliff-pch.c                          |   11 
 drivers/spi/spi-zynqmp-gqspi.c                          |    4 
 drivers/staging/vme_user/vme_fake.c                     |    2 
 drivers/target/target_core_configfs.c                   |    2 
 drivers/thermal/sprd_thermal.c                          |    4 
 drivers/thermal/thermal_core.c                          |    6 
 drivers/usb/class/usblp.c                               |    3 
 drivers/usb/common/ulpi.c                               |    5 
 drivers/usb/gadget/udc/omap_udc.c                       |    4 
 drivers/usb/serial/option.c                             |    4 
 drivers/video/fbdev/core/fb_defio.c                     |  179 ++++++++++++----
 drivers/video/fbdev/udlfb.c                             |   31 ++
 fs/btrfs/space-info.c                                   |    2 
 fs/erofs/compress.h                                     |    2 
 fs/erofs/decompressor.c                                 |  163 ++++++--------
 fs/erofs/decompressor_deflate.c                         |    8 
 fs/erofs/decompressor_lzma.c                            |    8 
 fs/erofs/decompressor_zstd.c                            |    8 
 fs/erofs/zdata.c                                        |    2 
 fs/f2fs/data.c                                          |   28 ++
 fs/f2fs/extent_cache.c                                  |   17 -
 fs/f2fs/inode.c                                         |    2 
 fs/f2fs/sysfs.c                                         |   10 
 fs/file_table.c                                         |   22 +
 fs/hfsplus/bfind.c                                      |   51 ++++
 fs/hfsplus/catalog.c                                    |    4 
 fs/hfsplus/dir.c                                        |    2 
 fs/hfsplus/hfsplus_fs.h                                 |    9 
 fs/hfsplus/super.c                                      |    6 
 fs/isofs/export.c                                       |    2 
 fs/isofs/rock.c                                         |    9 
 fs/notify/fsnotify.c                                    |    2 
 fs/notify/mark.c                                        |   18 -
 fs/smb/client/cached_dir.c                              |    8 
 fs/smb/client/cifsacl.c                                 |   37 ++-
 fs/smb/client/smb2inode.c                               |   12 -
 fs/smb/client/smb2misc.c                                |    3 
 fs/smb/client/smb2ops.c                                 |   11 
 fs/smb/server/connection.c                              |   46 +++-
 fs/smb/server/connection.h                              |    1 
 fs/smb/server/smbacl.c                                  |   66 ++++-
 fs/tracefs/event_inode.c                                |   14 +
 fs/tracefs/inode.c                                      |    5 
 fs/tracefs/internal.h                                   |    3 
 fs/udf/misc.c                                           |    8 
 fs/udf/super.c                                          |    4 
 include/linux/dma-mapping.h                             |   17 +
 include/linux/fb.h                                      |    4 
 include/linux/fsnotify_backend.h                        |    1 
 include/linux/mm.h                                      |   12 -
 include/linux/mm_types.h                                |    7 
 include/linux/mmap_lock.h                               |   61 +++--
 include/linux/mmc/card.h                                |    1 
 include/linux/printk.h                                  |   13 +
 include/trace/events/rxrpc.h                            |    1 
 include/video/udlfb.h                                   |    1 
 kernel/bpf/arena.c                                      |   19 +
 kernel/exit.c                                           |    1 
 kernel/fork.c                                           |    5 
 kernel/tracepoint.c                                     |    2 
 lib/crypto/mpi/mpicoder.c                               |    2 
 lib/scatterlist.c                                       |    8 
 mm/damon/sysfs-schemes.c                                |   12 -
 mm/init-mm.c                                            |    2 
 net/bluetooth/hci_event.c                               |   27 ++
 net/bluetooth/l2cap_core.c                              |    8 
 net/bluetooth/l2cap_sock.c                              |    6 
 net/ceph/auth.c                                         |    2 
 net/ceph/mon_client.c                                   |    2 
 net/core/flow_dissector.c                               |   13 -
 net/core/rtnetlink.c                                    |    1 
 net/ipv4/ah4.c                                          |   14 +
 net/ipv6/ah6.c                                          |   14 +
 net/ipv6/ip6_gre.c                                      |    5 
 net/ipv6/xfrm6_protocol.c                               |    4 
 net/key/af_key.c                                        |   52 +++-
 net/mac80211/mlme.c                                     |    9 
 net/mac80211/rx.c                                       |    2 
 net/mac80211/util.c                                     |    4 
 net/mptcp/protocol.c                                    |    3 
 net/mptcp/sockopt.c                                     |   12 -
 net/mptcp/subflow.c                                     |    4 
 net/openvswitch/vport-netdev.c                          |    6 
 net/rds/message.c                                       |   20 +
 net/rxrpc/call_event.c                                  |    4 
 net/rxrpc/conn_event.c                                  |   30 ++
 net/sched/sch_red.c                                     |    2 
 net/unix/af_unix.c                                      |    3 
 net/vmw_vsock/hyperv_transport.c                        |    4 
 net/xfrm/xfrm_state.c                                   |   12 -
 net/xfrm/xfrm_user.c                                    |    1 
 security/selinux/hooks.c                                |    3 
 security/selinux/selinuxfs.c                            |   54 +---
 sound/core/oss/pcm_oss.c                                |   29 ++
 sound/drivers/aloop.c                                   |   44 ++-
 sound/firewire/tascam/tascam-hwdep.c                    |    1 
 sound/soc/amd/yc/acp6x-mach.c                           |   14 +
 sound/soc/fsl/fsl_easrc.c                               |    2 
 sound/soc/intel/boards/bytcr_wm5102.c                   |    1 
 sound/soc/qcom/qdsp6/q6apm-dai.c                        |    1 
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c                 |    2 
 sound/soc/qcom/qdsp6/q6apm.c                            |    3 
 sound/soc/sof/compress.c                                |    3 
 sound/usb/midi2.c                                       |    9 
 sound/usb/misc/ua101.c                                  |    7 
 sound/usb/stream.c                                      |    4 
 tools/arch/x86/include/asm/msr-index.h                  |    3 
 tools/testing/selftests/net/mptcp/mptcp_lib.sh          |   16 -
 tools/testing/selftests/net/mptcp/pm_netlink.sh         |   20 +
 tools/testing/vma/vma.c                                 |    4 
 tools/testing/vma/vma_internal.h                        |    4 
 221 files changed, 1795 insertions(+), 675 deletions(-)

Aaro Koskinen (1):
      USB: omap_udc: DMA: Don't enable burst 4 mode

Alexei Starovoitov (1):
      bpf: Fix use-after-free in arena_vm_close on fork

Amir Goldstein (1):
      fs: prepare for adding LSM blob to backing_file

André Draszik (1):
      power: supply: max17042: avoid overflow when determining health

Ankit Soni (1):
      iommu/amd: serialize sequence allocation under concurrent TLB invalidations

Bartosz Golaszewski (1):
      gpio: of: clear OF_POPULATED on hog nodes in remove path

Benjamin Berg (1):
      wifi: mac80211: use safe list iteration in radar detect work

Bibo Mao (2):
      LoongArch: KVM: Fix HW timer interrupt lost when inject interrupt by software
      LoongArch: KVM: Move unconditional delay into timer clear scenery

Bjoern Doebel (1):
      smb: client: use kzalloc to zero-initialize security descriptor buffer

Catherine (1):
      wifi: mac80211: drop stray 'static' from fast-RX rx_result

Cen Zhang (1):
      f2fs: add READ_ONCE() for i_blocks in f2fs_update_inode()

Chaitanya Kulkarni (2):
      nvmet-tcp: fix race between ICReq handling and queue teardown
      nvmet: avoid recursive nvmet-wq flush in nvmet_ctrl_free

Christian A. Ehrhardt (2):
      lib/scatterlist: fix length calculations in extract_kvec_to_sg
      lib/scatterlist: fix temp buffer in extract_user_to_sg()

Christoph Hellwig (1):
      dma-mapping: drop unneeded includes from dma-mapping.h

Conor Dooley (1):
      clk: microchip: mpfs-ccc: fix out of bounds access during output registration

Corey Minyard (3):
      ipmi: Add limits to event and receive message requests
      ipmi: Check event message buffer response for bad data
      ipmi:si: Return state to normal if message allocation fails

Cássio Gabriel (5):
      ALSA: usb-audio: midi2: Restart output URBs on resume
      ALSA: usb-audio: Fix UAC3 cluster descriptor size check
      ALSA: firewire-tascam: Do not drop unread control events
      ASoC: Intel: bytcr_wm5102: Fix MCLK leak on platform_clock_control error
      ALSA: aloop: Fix peer runtime UAF during format-change stop

DaeMyung Kang (1):
      ksmbd: rewrite stop_sessions() with restartable iteration

David Carlier (4):
      eventfs: Hold eventfs_mutex and SRCU when remount walks events
      octeon_ep_vf: add NULL check for napi_build_skb()
      gtp: disable BH before calling udp_tunnel_xmit_skb()
      tracepoint: balance regfunc() on func_add() failure in tracepoint_add_func()

David Howells (1):
      rxrpc: Fix conn-level packet handling to unshare RESPONSE packets

David Windsor (1):
      selinux: don't reserve xattr slot when we won't fill it

David Woodhouse (1):
      KVM: arm64: vgic: Fix IIDR revision field extracted from wrong value

Deepanshu Kartikey (1):
      hfsplus: fix uninit-value by validating catalog record size

Eric Biggers (2):
      dm-verity-fec: correctly reject too-small FEC devices
      dm-verity-fec: correctly reject too-small hash devices

Fabio Porcedda (1):
      USB: serial: option: add Telit Cinterion LE910Cx compositions

Fedor Pchelkin (1):
      nvme-apple: drop invalid put of admin queue reference count

Felix Gu (1):
      usb: ulpi: fix memory leak on ulpi_register() error paths

Fuad Tabba (1):
      KVM: arm64: Fix kvm_vcpu_initialized() macro parameter

Gang Yan (2):
      mptcp: sockopt: set timestamp flags on subflow socket, not msk
      mptcp: fix scheduling with atomic in timestamp sockopt

Gao Xiang (2):
      erofs: move {in,out}pages into struct z_erofs_decompress_req
      erofs: tidy up z_erofs_lz4_handle_overlap()

Greg Kroah-Hartman (4):
      scsi: target: configfs: Bound snprintf() return in tg_pt_gp_members_show()
      usb: usblp: fix heap leak in IEEE 1284 device ID via short response
      usb: usblp: fix uninitialized heap leak via LPGETSTATUS ioctl
      Linux 6.12.88

Guangshuo Li (4):
      ACPI: scan: Use acpi_dev_put() in object add error paths
      ice: fix double free in ice_sf_eth_activate() error path
      btrfs: fix double free in create_space_info() error path
      f2fs: fix uninitialized kobject put in f2fs_init_sysfs()

Hamza Mahfooz (1):
      hv_sock: fix ARM64 support

Hongling Zeng (1):
      parisc: Fix IRQ leak in LASI driver

Huacai Chen (2):
      LoongArch: Fix SYM_SIGFUNC_START definition for 32BIT
      LoongArch: Use per-root-bridge PCIH flag to skip mem resource fixup

Hyunwoo Kim (2):
      Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
      rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present

Ilya Maximets (1):
      openvswitch: vport: fix self-deadlock on release of tunnel ports

Jamal Hadi Salim (1):
      net/sched: sch_red: Replace direct dequeue call with peek and qdisc_dequeue_peeked

Jan Schär (1):
      ACPI: video: Add backlight=native quirk for Dell OptiPlex 7770 AIO

Jann Horn (1):
      exit: prevent preemption of oopsing TASK_DEAD task

Jason Gunthorpe (7):
      RDMA/hns: Fix unlocked call to hns_roce_qp_remove()
      RDMA/mana: Fix error unwind in mana_ib_create_qp_rss()
      RDMA/mana: Fix mana_destroy_wq_obj() cleanup in mana_ib_create_qp_rss()
      RDMA/mana: Validate rx_hash_key_len
      RDMA/mlx4: Fix resource leak on error in mlx4_ib_create_srq()
      RDMA/ocrdma: Don't NULL deref uctx on errors in ocrdma_copy_pd_uresp()
      RDMA/vmw_pvrdma: Fix double free on pvrdma_alloc_ucontext() error path

Jeongjun Park (1):
      wifi: rsi: fix kthread lifetime race between self-exit and external-stop

Jiawen Wu (2):
      net: txgbe: fix RTNL assertion warning when remove module
      net: libwx: fix VF illegal register access

Jiexun Wang (1):
      af_unix: Reject SIOCATMARK on non-stream sockets

Jinjie Ruan (1):
      ACPI: CPPC: Fix related_cpus inconsistency during CPU hotplug

Jiri Slaby (SUSE) (1):
      wifi: ath5k: do not access array OOB

Johan Hovold (12):
      spi: rockchip: fix controller deregistration
      spi: syncuacer: fix controller deregistration
      spi: sun4i: fix controller deregistration
      spi: ti-qspi: fix controller deregistration
      spi: sun6i: fix controller deregistration
      spi: zynqmp-gqspi: fix controller deregistration
      spi: s3c64xx: fix NULL-deref on driver unbind
      staging: vme_user: fix root device leak on init failure
      clk: rk808: fix OF node reference imbalance
      spi: microchip-core-qspi: fix controller deregistration
      spi: topcliff-pch: fix controller deregistration
      spi: topcliff-pch: fix use-after-free on unbind

Johannes Berg (1):
      wifi: mac80211: remove station if connection prep fails

Joseph Salisbury (1):
      ASoC: fsl_easrc: fix comment typo

Junrui Luo (3):
      md/raid10: fix divide-by-zero in setup_geo() with zero far_copies
      RDMA/mlx5: Fix error path fall-through in mlx5_ib_dev_res_srq_init()
      erofs: fix unsigned underflow in z_erofs_lz4_handle_overlap()

Kai Zen (1):
      net: rtnetlink: zero ifla_vf_broadcast to avoid stack infoleak in rtnl_fill_vfinfo

Leon Yen (1):
      wifi: mt76: mt7921: fix a potential clc buffer length underflow

Linus Torvalds (1):
      x86: shadow stacks: proper error handling for mmap lock

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix OOB read and infinite loop in hci_le_create_big_complete_evt

Lukas Wunner (4):
      lib/crypto: mpi: Fix integer underflow in mpi_read_raw_from_sgl()
      PCI: Update saved_config_space upon resource assignment
      PCI/AER: Stop ruling out unbound devices as error source
      PCI/ASPM: Fix pci_clear_and_set_config_dword() usage

Luke Wang (1):
      mmc: core: Optimize time for secure erase/trim for some Kingston eMMCs

Maoyi Xie (1):
      ip6_gre: Use cached t->net in ip6erspan_changelink().

Marc Zyngier (1):
      KVM: arm64: Wake-up from WFI when iqrchip is in userspace

Marek Szyprowski (1):
      wifi: brcmfmac: Fix potential use-after-free issue when stopping watchdog task

Mark Brown (1):
      ASoC: SOF: Don't allow pointer operations on unconfigured streams

Matthieu Baerts (NGI0) (3):
      selftests: mptcp: check output: catch cmd errors
      selftests: mptcp: pm: restrict 'unknown' check to pm_nl_ctl
      mptcp: fastclose msk when linger time is 0

Michael Bommarito (9):
      xfrm: ah: account for ESN high bits in async callbacks
      Bluetooth: virtio_bt: clamp rx length before skb_put
      Bluetooth: virtio_bt: validate rx pkt_type header length
      udf: reject descriptors with oversized CRC length
      isofs: validate Rock Ridge CE continuation extent against volume size
      isofs: validate block number from NFS file handle in isofs_export_iget
      smb: client: validate dacloffset before building DACL pointers
      RDMA/rxe: Reject non-8-byte ATOMIC_WRITE payloads
      RDMA/rxe: Reject unknown opcodes before ICRC processing

Michael S. Tsirkin (1):
      dma-mapping: add __dma_from_device_group_begin()/end()

Michal Kosiorek (1):
      xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete

Miklos Szeredi (1):
      fanotify: fix false positive on permission events

Mikulas Patocka (3):
      dm-thin: fix metadata refcount underflow
      dm: don't report warning when doing deferred remove
      dm: fix a buffer overflow in ioctl processing

Ming Yen Hsieh (1):
      wifi: mt76: mt7925: fix incorrect length field in txpower command

Mingming Cao (1):
      ibmveth: Disable GSO for packets with small MSS

Miquel Raynal (1):
      mtd: spinand: winbond: Declare the QE bit on W25NxxJW

Myeonghun Pak (1):
      hwmon: (corsair-psu) Close HID device on probe errors

Naman Jain (1):
      block: add pgmap check to biovec_phys_mergeable

Nan Li (1):
      net/rds: handle zerocopy send cleanup before the message is queued

Nicolin Chen (1):
      iommu/arm-smmu-v3: Add a missing dma_wmb() for hitless STE update

Paolo Bonzini (2):
      KVM: SVM: check validity of VMCB controls when returning from SMM
      KVM: x86: check for nEPT/nNPT in slow flush hypercalls

Pavitra Jha (1):
      net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler

Prathyushi Nangia (1):
      x86/CPU/AMD: Prevent improper isolation of shared resources in Zen2's op cache

Qiang Ma (1):
      LoongArch: KVM: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS

Qingfang Deng (1):
      flow_dissector: do not dissect PPPoE PFC frames

Quan Zhou (3):
      wifi: mt76: mt7925: fix AMPDU state handling in mt7925_tx_check_aggr
      wifi: mt76: mt7921: fix ROC abort flow interruption in mt7921_roc_work
      wifi: mt76: mt7925: fix incorrect TLV length in CLC command

Quentin Perret (1):
      KVM: arm64: Fix initialisation order in __pkvm_init_finalise()

Rafael J. Wysocki (1):
      thermal: core: Free thermal zone ID later during removal

Rajat Gupta (1):
      fbdev: udlfb: add vm_ops to dlfb_ops_mmap to prevent use-after-free

Raphael Zimmer (1):
      libceph: Fix slab-out-of-bounds access in auth message processing

Rick Edgecombe (1):
      x86/shstk: Prevent deadlock during shstk sigreturn

Ruijie Li (1):
      xfrm: provide message size for XFRM_MSG_MAPPING

Russell King (Oracle) (2):
      net: stmmac: avoid shadowing global buf_sz
      net: stmmac: rename STMMAC_GET_ENTRY() -> STMMAC_NEXT_ENTRY()

Sam Edwards (1):
      net: stmmac: Prevent NULL deref when RX memory exhausted

Sanman Pradhan (2):
      hwmon: (ltc2992) Clamp threshold writes to hardware range
      hwmon: (ltc2992) Fix u32 overflow in power read path

Sean Christopherson (1):
      KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

Seohyeon Maeng (1):
      udf: fix partition descriptor append bookkeeping

SeongJae Park (1):
      mm/damon/sysfs-schemes: protect memcg_path kfree() with damon_sysfs_lock

SeungJu Cheon (1):
      sound: ua101: fix division by zero at probe

Shardul Bankar (2):
      mptcp: use MPJoinSynAckHMacFailure for SynAck HMAC failure
      mptcp: use MPTCP_RST_EMPTCP for ACK HMAC validation failure

Shivam Kalra (1):
      ACPI: video: force native backlight on HP OMEN 16 (8A44)

Shota Zaizen (1):
      ksmbd: validate inherited ACE SID length

Shrikanth Hegde (1):
      cpuidle: powerpc: avoid double clear when breaking snooze

Shuai Xue (1):
      PCI/AER: Clear only error bits in PCIe Device Status

Shyam Prasad N (2):
      cifs: abort open_cached_dir if we don't request leases
      cifs: change_conf needs to be called for session setup

Sina Hassani (1):
      iommufd: Fix a race with concurrent allocation and unmap

Siwei Zhang (2):
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_new_connection_cb()
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_state_change_cb()

Sourabh Jain (1):
      powerpc/kdump: fix KASAN sanitization flag for core_$(BITS).o

Srinivas Kandagatla (3):
      ASoC: qcom: q6apm-dai: reset queue ptr on trigger stop
      ASoC: qcom: q6apm-lpass-dai: Fix multiple graph opens
      ASoC: qcom: q6apm: remove child devices when apm is removed

Stefan Eichenberger (1):
      clk: imx: imx8-acm: fix flags for acm clocks

Stephen Smalley (2):
      selinux: shrink critical section in sel_write_load()
      selinux: prune /sys/fs/selinux/disable

Suren Baghdasaryan (1):
      mm: convert mm_lock_seq to a proper seqcount

Takashi Iwai (2):
      ALSA: usb-audio: Avoid potential endless loop in convert_chmap_v3()
      ALSA: pcm: oss: Fix data race at accessing runtime.oss.trigger

Tao Cui (2):
      LoongArch: KVM: Fix missing EMULATE_FAIL in kvm_emu_mmio_read()
      LoongArch: KVM: Use kvm_set_pte() in kvm_flush_pte()

Thomas Weißschuh (1):
      hwmon: (powerz) Avoid cacheline sharing for DMA buffer

Thomas Zimmermann (1):
      fbdev: defio: Disconnect deferred I/O from the lifetime of struct fb_info

Thorsten Blum (5):
      thermal/drivers/sprd: Fix temperature clamping in sprd_thm_temp_to_rawdata
      thermal/drivers/sprd: Fix raw temperature clamping in sprd_thm_rawdata_to_temp
      crypto: nx - fix bounce buffer leaks in nx842_crypto_{alloc,free}_ctx
      printk: add print_hex_dump_devel()
      crypto: caam - guard HMAC key hex dumps in hash_digest_key

Tommaso Soncin (1):
      ASoC: amd: yc: Add HP OMEN Gaming Laptop 16-ap0xxx product line in quirk table

Tristan Madani (3):
      wifi: b43legacy: enforce bounds check on firmware key index in RX path
      wifi: b43: enforce bounds check on firmware key index in b43_rx()
      Bluetooth: btmtk: validate WMT event SKB length before struct access

Tudor Ambarus (1):
      mtd: spi-nor: debugfs: fix out-of-bounds read in spi_nor_params_show()

Ulf Hansson (1):
      pmdomain: core: Fix detach procedure for virtual devices in genpd

Uros Bizjak (1):
      iommu/amd: Use atomic64_inc_return() in iommu.c

Vasily Gorbik (1):
      s390/debug: Reject zero-length input in debug_input_flush_fn()

Wentao Guan (1):
      LoongArch: Fix potential ADE in loongson_gpu_fixup_dma_hang()

Xianglai Li (1):
      LoongArch: KVM: Fix "unreliable stack" for kvm_exc_entry

Xu Yang (1):
      extcon: ptn5150: handle pending IRQ events during system resume

Yilin Zhu (1):
      ipv6: xfrm6: release dst on error in xfrm6_rcv_encap()

Yongpeng Yang (3):
      f2fs: fix fiemap boundary handling when read extent cache is incomplete
      f2fs: fix incorrect multidevice info in trace_f2fs_map_blocks()
      f2fs: fix node_cnt race between extent node destroy and writeback

Zhengchuan Liang (1):
      net: af_key: zero aligned sockaddr tail in PF_KEY exports

Zilin Guan (1):
      hfsplus: fix held lock freed on hfsplus_fill_super()

Zisen Ye (2):
      smb/client: fix out-of-bounds read in smb2_compound_op()
      smb/client: fix out-of-bounds read in symlink_data()


