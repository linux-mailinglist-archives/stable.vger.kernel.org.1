Return-Path: <stable+bounces-181689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EECCAB9E75A
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 11:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCDF17D64B
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 09:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498A02E973F;
	Thu, 25 Sep 2025 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y73zA5c9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25F42D7DD1;
	Thu, 25 Sep 2025 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793376; cv=none; b=kuF17YtmIFEsSy4wTuK4w3qdaNs6urHVEzpzUfRVe0cyDUgE0GxnoCaR1a5ljz57ai2VLMGefucJpObfZ/JzIYqbZCajrlLI6JDKZhI9GOL0ILHAt+8heuB2d4z8F8KKvHBDCOMdMiR1hbTKNViAyjw6VuWyvm3pDW69PPVqARs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793376; c=relaxed/simple;
	bh=9M11BPcwzQLFXNnc+3evzvnWrycgXjlKRAg6+DFWd6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZanlH+1Fh9n9ALa5h6xVRgUZyBwm0ElCMAqVlCNLi0xL/m2AbT3A9Pd+4U4r7HC+BQjGKW3CdeOs1ALVA99NyXi2WBEyXS2g8OmmZBIfeGnthso5W7stjhM9UkK/dV2oDY657asKeVIxgmaKl62ub/vwdW/C9HhOC8QJ8NBD4DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y73zA5c9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA812C4CEF0;
	Thu, 25 Sep 2025 09:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758793375;
	bh=9M11BPcwzQLFXNnc+3evzvnWrycgXjlKRAg6+DFWd6w=;
	h=From:To:Cc:Subject:Date:From;
	b=y73zA5c9t9VdutbP+XKVIhFTY1cjxTvQhHSF4cRUW3x9KeRPqYmAGpZFwTZB9UoMn
	 A6dVgqiCXJH9VMZd7v7PEjQS0x1GlhLljD9PB0Jgnc7nspCjQCWzfB8kSHjaZ/zLnp
	 0n8wh+/d315kDkZE1lkkVhjh+tFLEwdn6g2fJ/eI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.154
Date: Thu, 25 Sep 2025 11:42:50 +0200
Message-ID: <2025092551-wrinkly-approval-d988@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.154 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                               |    2 
 arch/loongarch/include/asm/acenv.h                     |    7 -
 arch/loongarch/kernel/env.c                            |    2 
 arch/um/drivers/virtio_uml.c                           |    6 
 arch/x86/kvm/svm/svm.c                                 |    3 
 crypto/af_alg.c                                        |  112 ++++++-----------
 drivers/gpu/drm/bridge/analogix/anx7625.c              |    6 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |    6 
 drivers/iommu/intel/iommu.c                            |    7 -
 drivers/mmc/host/mvsdio.c                              |    2 
 drivers/net/bonding/bond_main.c                        |    1 
 drivers/net/ethernet/broadcom/cnic.c                   |    3 
 drivers/net/ethernet/cavium/liquidio/request_manager.c |    2 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c    |    2 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c            |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c  |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c      |    2 
 drivers/net/ethernet/natsemi/ns83820.c                 |   13 -
 drivers/net/ethernet/qlogic/qed/qed_debug.c            |    7 -
 drivers/pcmcia/omap_cf.c                               |    8 +
 drivers/phy/broadcom/phy-bcm-ns-usb3.c                 |    9 -
 drivers/phy/marvell/phy-berlin-usb.c                   |    7 -
 drivers/phy/ralink/phy-ralink-usb.c                    |   10 -
 drivers/phy/rockchip/phy-rockchip-pcie.c               |   11 -
 drivers/phy/rockchip/phy-rockchip-usb.c                |   10 -
 drivers/phy/ti/phy-omap-control.c                      |    9 -
 drivers/phy/ti/phy-omap-usb2.c                         |   24 ++-
 drivers/phy/ti/phy-ti-pipe3.c                          |   14 --
 drivers/power/supply/bq27xxx_battery.c                 |    4 
 drivers/usb/host/xhci-dbgcap.c                         |   94 ++++++++++----
 fs/btrfs/tree-checker.c                                |    4 
 fs/btrfs/tree-log.c                                    |    2 
 fs/nilfs2/sysfs.c                                      |    4 
 fs/nilfs2/sysfs.h                                      |    8 -
 fs/smb/client/smbdirect.c                              |    4 
 fs/smb/server/transport_rdma.c                         |   26 ++-
 include/crypto/if_alg.h                                |   10 -
 include/uapi/linux/mptcp.h                             |    6 
 io_uring/io_uring.c                                    |   13 +
 io_uring/io_uring.h                                    |   13 +
 io_uring/poll.c                                        |    3 
 io_uring/timeout.c                                     |    2 
 kernel/cgroup/cgroup.c                                 |   43 +++++-
 net/ipv4/tcp.c                                         |    5 
 net/mac80211/driver-ops.h                              |    2 
 net/mac80211/main.c                                    |    7 -
 net/mptcp/pm_netlink.c                                 |    7 +
 net/mptcp/protocol.c                                   |   15 ++
 net/mptcp/subflow.c                                    |    4 
 net/rds/ib_frmr.c                                      |   20 +--
 net/rfkill/rfkill-gpio.c                               |   22 ++-
 net/tls/tls.h                                          |    1 
 net/tls/tls_strp.c                                     |   14 +-
 net/tls/tls_sw.c                                       |    3 
 sound/firewire/motu/motu-hwdep.c                       |    2 
 sound/pci/hda/patch_realtek.c                          |    1 
 sound/soc/codecs/wm8940.c                              |    2 
 sound/soc/codecs/wm8974.c                              |    8 -
 sound/soc/qcom/qdsp6/audioreach.c                      |    1 
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c                |   38 +++--
 sound/soc/sof/intel/hda-stream.c                       |    2 
 tools/testing/selftests/net/mptcp/mptcp_connect.c      |   11 -
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c          |    7 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh      |   14 +-
 64 files changed, 440 insertions(+), 272 deletions(-)

Alexey Nepomnyashih (1):
      net: liquidio: fix overflow in octeon_init_instr_queue()

Charles Keepax (2):
      ASoC: wm8940: Correct typo in control name
      ASoC: wm8974: Correct PLL rate rounding

Chen Ridong (1):
      cgroup: split cgroup_destroy_wq into 3 workqueues

Colin Ian King (1):
      ASoC: SOF: Intel: hda-stream: Fix incorrect variable used in error message

David Howells (2):
      crypto: af_alg: Indent the loop in af_alg_sendmsg()
      crypto: af_alg: Convert af_alg_sendpage() to use MSG_SPLICE_PAGES

Duoming Zhou (2):
      cnic: Fix use-after-free bugs in cnic_delete_task
      octeontx2-pf: Fix use-after-free bugs in otx2_sync_tstamp()

Eugene Koira (1):
      iommu/vt-d: Fix __domain_mapping()'s usage of switch_to_super_page()

Filipe Manana (1):
      btrfs: fix invalid extref key setup when replaying dentry

Geert Uytterhoeven (1):
      pcmcia: omap_cf: Mark driver struct with __refdata to prevent section mismatch

Greg Kroah-Hartman (1):
      Linux 6.1.154

H. Nikolaus Schaller (2):
      power: supply: bq27xxx: fix error return in case of no bq27000 hdq battery
      power: supply: bq27xxx: restrict no-battery detection to bq27000

Hangbin Liu (1):
      bonding: don't set oif to bond dev when getting NS target destination

Hans de Goede (1):
      net: rfkill: gpio: Fix crash due to dereferencering uninitialized pointer

Herbert Xu (2):
      crypto: af_alg - Set merge to zero early in af_alg_sendmsg
      crypto: af_alg - Disallow concurrent writes in af_alg_sendmsg

Huacai Chen (1):
      LoongArch: Align ACPI structures if ARCH_STRICT_ALIGN enabled

Håkon Bugge (1):
      rds: ib: Increment i_fastreg_wrs before bailing out

Ioana Ciornei (1):
      dpaa2-switch: fix buffer pool seeding for control traffic

Jakub Kicinski (1):
      tls: make sure to abort the stream if headers are bogus

Jamie Bainbridge (1):
      qed: Don't collect too many protection override GRC elements

Jens Axboe (2):
      io_uring: backport io_should_terminate_tw()
      io_uring: include dying ring in task_work "should cancel" state

Johan Hovold (1):
      phy: ti: omap-usb2: fix device leak at unbind

Krzysztof Kozlowski (2):
      phy: broadcom: ns-usb3: fix Wvoid-pointer-to-enum-cast warning
      ASoC: qcom: q6apm-lpass-dais: Fix NULL pointer dereference if source graph failed

Kuniyuki Iwashima (1):
      tcp: Clear tcp_sk(sk)->fastopen_rsk in tcp_disconnect().

Lachlan Hodges (1):
      wifi: mac80211: increase scan_ies_len for S1G

Liao Yuanhong (1):
      wifi: mac80211: fix incorrect type for ret

Loic Poulain (1):
      drm: bridge: anx7625: Fix NULL pointer dereference with early IRQ

Maciej Fijalkowski (1):
      i40e: remove redundant memory barrier when cleaning Tx descs

Maciej S. Szmigiero (1):
      KVM: SVM: Sync TPR from LAPIC into VMCB::V_TPR even if AVIC is active

Mathias Nyman (2):
      xhci: dbc: decouple endpoint allocation from initialization
      xhci: dbc: Fix full DbC transfer ring after several reconnects

Matthieu Baerts (NGI0) (6):
      mptcp: set remote_deny_join_id0 on SYN recv
      selftests: mptcp: avoid spurious errors on TCP disconnect
      mptcp: pm: nl: announce deny-join-id0 flag
      selftests: mptcp: userspace pm: validate deny-join-id0 flag
      mptcp: propagate shutdown to subflows when possible
      selftests: mptcp: connect: catch IO errors on listen side

Miaoqian Lin (1):
      um: virtio_uml: Fix use-after-free after put_device in probe

Mohammad Rafi Shaik (2):
      ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S interface
      ASoC: qcom: q6apm-lpass-dais: Fix missing set_fmt DAI op for I2S

Namjae Jeon (1):
      ksmbd: smbdirect: validate data_offset and data_length field of smb_direct_data_transfer

Nathan Chancellor (1):
      nilfs2: fix CFI failure when accessing /sys/fs/nilfs2/features/*

Philipp Zabel (1):
      net: rfkill: gpio: add DT support

Praful Adiga (1):
      ALSA: hda/realtek: Fix mute led for HP Laptop 15-dw4xx

Qi Xi (1):
      drm: bridge: cdns-mhdp8546: Fix missing mutex unlock on error path

Qu Wenruo (1):
      btrfs: tree-checker: fix the incorrect inode ref size check

Rob Herring (1):
      phy: Use device_get_match_data()

Srinivas Kandagatla (2):
      ASoC: qcom: q6apm-lpass-dai: close graphs before opening a new one
      ASoC: q6apm-lpass-dai: close graph on prepare errors

Stefan Metzmacher (2):
      ksmbd: smbdirect: verify remaining_data_length respects max_fragmented_recv_size
      smb: client: fix smbdirect_recv_io leak in smbd_negotiate() error path

Takashi Sakamoto (1):
      ALSA: firewire-motu: drop EPOLLOUT from poll return values as write is not supported

Tao Cui (1):
      LoongArch: Check the return value when creating kobj

Tariq Toukan (1):
      Revert "net/mlx5e: Update and set Xon/Xoff upon port speed set"

Thomas Fourier (1):
      mmc: mvsdio: Fix dma_unmap_sg() nents value

Yeounsu Moon (1):
      net: natsemi: fix `rx_dropped` double accounting on `netif_rx()` failure


