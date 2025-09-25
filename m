Return-Path: <stable+bounces-181694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C8FB9E782
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 11:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DEB71BC4DDC
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 09:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063862EAD15;
	Thu, 25 Sep 2025 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="drI+Z/ge"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11472EA47E;
	Thu, 25 Sep 2025 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793397; cv=none; b=NFp3gIXw4vNb3qMjyecD4dAI6++kSuX3LllcBbNJqB4v8/91TtVs4xzCn/uQ+LvyKsiJSYR21mEtMFuooLIi8ptNDkm5Lk65ueVOVdWhsA5AvJYQJm1g4EOEhEqTzPUf/zpCfsNfY087TTCIaw5XAMMkK5JBZDvTUHQQlfAJmY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793397; c=relaxed/simple;
	bh=ZDe+K86ZT07ojCB3haJhDgB4ClhIYNE+s3fn5Wwsws4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oh2OOH5P+46x/CVlNHvx7PSFyXnU4PkHSNKRLYXnRjHFBvl2MmLSDHzLDnyql/SBUjiVt566icwdC9Ja0SG2YPi8jUOikcCs89Ax0FnyjhoTiqPN8Tc4OUku8XavWTk501Dg2jYtosxDkFMR6TEuDewvb3Yq/BwMzARoo1e83pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=drI+Z/ge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8255C4CEF7;
	Thu, 25 Sep 2025 09:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758793397;
	bh=ZDe+K86ZT07ojCB3haJhDgB4ClhIYNE+s3fn5Wwsws4=;
	h=From:To:Cc:Subject:Date:From;
	b=drI+Z/genC6XzHxUPVwFfvQqZCNcuhYg9N8yyaBH6khK6lmvNWXYfgvtapWfWfLsj
	 mwWauLANptww/g/FAD0y86aoHpK8JlIYx8Orr1QFIdhtqLH01TKIYyxTdzM0jHZtDl
	 GzkDHpCxA+5VKZLGU1tCuJ8lPI9P5cOee8PNyq08=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.49
Date: Thu, 25 Sep 2025 11:43:02 +0200
Message-ID: <2025092503-barman-headrest-4083@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.49 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/hw-vuln/srso.rst               |   13 
 Documentation/netlink/specs/mptcp_pm.yaml                |    4 
 Makefile                                                 |    2 
 arch/loongarch/Kconfig                                   |    8 
 arch/loongarch/include/asm/acenv.h                       |    7 
 arch/loongarch/kernel/env.c                              |    2 
 arch/loongarch/kernel/stacktrace.c                       |    3 
 arch/loongarch/kernel/vdso.c                             |    3 
 arch/um/drivers/virtio_uml.c                             |    6 
 arch/um/os-Linux/file.c                                  |    2 
 arch/x86/events/intel/core.c                             |    2 
 arch/x86/include/asm/cpufeatures.h                       |    5 
 arch/x86/include/asm/msr-index.h                         |    1 
 arch/x86/kernel/cpu/bugs.c                               |   28 +-
 arch/x86/kvm/svm/svm.c                                   |   68 ++++
 arch/x86/kvm/svm/svm.h                                   |    2 
 arch/x86/lib/msr.c                                       |    2 
 crypto/af_alg.c                                          |   10 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c        |   39 ++
 drivers/gpu/drm/bridge/analogix/anx7625.c                |    6 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c      |    6 
 drivers/gpu/drm/xe/xe_tile_sysfs.c                       |   12 
 drivers/gpu/drm/xe/xe_vm.c                               |    4 
 drivers/iommu/amd/amd_iommu_types.h                      |    1 
 drivers/iommu/amd/io_pgtable.c                           |   25 +
 drivers/iommu/intel/iommu.c                              |    7 
 drivers/md/dm-raid.c                                     |    6 
 drivers/md/dm-stripe.c                                   |   10 
 drivers/mmc/host/mvsdio.c                                |    2 
 drivers/net/bonding/bond_main.c                          |    2 
 drivers/net/ethernet/broadcom/cnic.c                     |    3 
 drivers/net/ethernet/cavium/liquidio/request_manager.c   |    2 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c      |    2 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c              |    3 
 drivers/net/ethernet/intel/ice/ice.h                     |    3 
 drivers/net/ethernet/intel/ice/ice_base.c                |   34 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c                |   80 ++---
 drivers/net/ethernet/intel/ice/ice_txrx.h                |    4 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c            |    7 
 drivers/net/ethernet/intel/igc/igc.h                     |    1 
 drivers/net/ethernet/intel/igc/igc_main.c                |   12 
 drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c         |   27 +
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c        |    1 
 drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h       |   15 +
 drivers/net/ethernet/natsemi/ns83820.c                   |   13 
 drivers/net/ethernet/qlogic/qed/qed_debug.c              |    7 
 drivers/net/vmxnet3/vmxnet3_drv.c                        |   10 
 drivers/net/wireless/microchip/wilc1000/wlan_cfg.c       |   37 +-
 drivers/net/wireless/microchip/wilc1000/wlan_cfg.h       |    5 
 drivers/nvme/host/core.c                                 |   18 -
 drivers/pcmcia/omap_cf.c                                 |    8 
 drivers/platform/x86/asus-nb-wmi.c                       |   25 +
 drivers/platform/x86/asus-wmi.h                          |    3 
 drivers/power/supply/bq27xxx_battery.c                   |    4 
 drivers/rtc/rtc-pcf2127.c                                |   10 
 drivers/usb/host/xhci-dbgcap.c                           |   94 ++++--
 drivers/usb/host/xhci-debugfs.c                          |    5 
 drivers/usb/host/xhci-mem.c                              |   74 ++---
 drivers/usb/host/xhci.c                                  |   24 -
 drivers/usb/host/xhci.h                                  |    9 
 fs/btrfs/tree-checker.c                                  |    4 
 fs/btrfs/tree-log.c                                      |    2 
 fs/nilfs2/sysfs.c                                        |    4 
 fs/nilfs2/sysfs.h                                        |    8 
 fs/smb/client/cifsproto.h                                |    4 
 fs/smb/client/inode.c                                    |    6 
 fs/smb/client/misc.c                                     |   38 +-
 fs/smb/client/smbdirect.c                                |    7 
 fs/smb/server/transport_rdma.c                           |   26 +
 include/crypto/if_alg.h                                  |   10 
 include/linux/io_uring_types.h                           |    4 
 include/linux/minmax.h                                   |  205 ++++++---------
 include/linux/mlx5/driver.h                              |    1 
 include/linux/mm.h                                       |   55 ++++
 include/uapi/linux/mptcp.h                               |    2 
 include/uapi/linux/mptcp_pm.h                            |    4 
 io_uring/io_uring.c                                      |   12 
 io_uring/io_uring.h                                      |   13 
 io_uring/kbuf.h                                          |    2 
 io_uring/msg_ring.c                                      |   24 -
 io_uring/notif.c                                         |    2 
 io_uring/poll.c                                          |    3 
 io_uring/timeout.c                                       |    2 
 io_uring/uring_cmd.c                                     |    6 
 kernel/cgroup/cgroup.c                                   |   43 ++-
 mm/gup.c                                                 |   41 ++-
 mm/migrate.c                                             |   22 -
 mm/vmscan.c                                              |    2 
 net/ipv4/tcp.c                                           |    5 
 net/ipv4/tcp_ao.c                                        |    4 
 net/mac80211/driver-ops.h                                |    2 
 net/mac80211/main.c                                      |    7 
 net/mptcp/options.c                                      |    6 
 net/mptcp/pm_netlink.c                                   |    7 
 net/mptcp/protocol.c                                     |   16 +
 net/mptcp/subflow.c                                      |    4 
 net/rds/ib_frmr.c                                        |   20 -
 net/rfkill/rfkill-gpio.c                                 |    4 
 net/tls/tls.h                                            |    1 
 net/tls/tls_strp.c                                       |   14 -
 net/tls/tls_sw.c                                         |    3 
 sound/firewire/motu/motu-hwdep.c                         |    2 
 sound/pci/hda/patch_realtek.c                            |    1 
 sound/soc/codecs/wm8940.c                                |    9 
 sound/soc/codecs/wm8974.c                                |    8 
 sound/soc/intel/catpt/pcm.c                              |   23 +
 sound/soc/qcom/qdsp6/audioreach.c                        |    1 
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c                  |    7 
 sound/soc/sof/intel/hda-stream.c                         |    2 
 tools/arch/loongarch/include/asm/inst.h                  |   12 
 tools/objtool/arch/loongarch/decode.c                    |   33 ++
 tools/testing/selftests/net/mptcp/mptcp_connect.c        |   11 
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c        |   16 -
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c            |    7 
 tools/testing/selftests/net/mptcp/userspace_pm.sh        |   14 -
 118 files changed, 1062 insertions(+), 564 deletions(-)

Ajay.Kathat@microchip.com (1):
      wifi: wilc1000: avoid buffer overflow in WID string configuration

Alexey Nepomnyashih (1):
      net: liquidio: fix overflow in octeon_init_instr_queue()

Amadeusz Sławiński (1):
      ASoC: Intel: catpt: Expose correct bit depth to userspace

Anderson Nascimento (1):
      net/tcp: Fix a NULL pointer dereference when using TCP-AO with TCP_REPAIR

Antheas Kapenekakis (2):
      platform/x86: asus-wmi: Fix ROG button mapping, tablet mode on ASUS ROG Z13
      platform/x86: asus-wmi: Re-add extra keys to ignore_key_wlan quirk

Borislav Petkov (1):
      x86/bugs: KVM: Add support for SRSO_MSR_FIX

Borislav Petkov (AMD) (1):
      x86/bugs: Add SRSO_USER_KERNEL_NO support

Bruno Thomsen (1):
      rtc: pcf2127: fix SPI command byte for PCF2131 backport

Charles Keepax (3):
      ASoC: wm8940: Correct PLL rate rounding
      ASoC: wm8940: Correct typo in control name
      ASoC: wm8974: Correct PLL rate rounding

Chen Ridong (1):
      cgroup: split cgroup_destroy_wq into 3 workqueues

Christoph Hellwig (1):
      nvme: fix PI insert on write

Colin Ian King (1):
      ASoC: SOF: Intel: hda-stream: Fix incorrect variable used in error message

Dan Carpenter (1):
      drm/xe: Fix a NULL vs IS_ERR() in xe_vm_add_compute_exec_queue()

David Laight (7):
      minmax.h: add whitespace around operators and after commas
      minmax.h: update some comments
      minmax.h: reduce the #define expansion of min(), max() and clamp()
      minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()
      minmax.h: move all the clamp() definitions after the min/max() ones
      minmax.h: simplify the variants of clamp()
      minmax.h: remove some #defines that are only expanded once

Duoming Zhou (2):
      cnic: Fix use-after-free bugs in cnic_delete_task
      octeontx2-pf: Fix use-after-free bugs in otx2_sync_tstamp()

Eugene Koira (1):
      iommu/vt-d: Fix __domain_mapping()'s usage of switch_to_super_page()

Filipe Manana (1):
      btrfs: fix invalid extref key setup when replaying dentry

Geert Uytterhoeven (1):
      pcmcia: omap_cf: Mark driver struct with __refdata to prevent section mismatch

Geliang Tang (1):
      selftests: mptcp: sockopt: fix error messages

Greg Kroah-Hartman (1):
      Linux 6.12.49

Guangshuo Li (1):
      LoongArch: vDSO: Check kcalloc() result in init_vdso()

H. Nikolaus Schaller (2):
      power: supply: bq27xxx: fix error return in case of no bq27000 hdq battery
      power: supply: bq27xxx: restrict no-battery detection to bq27000

Hangbin Liu (2):
      bonding: set random address only when slaves already exist
      bonding: don't set oif to bond dev when getting NS target destination

Hans de Goede (1):
      net: rfkill: gpio: Fix crash due to dereferencering uninitialized pointer

Herbert Xu (2):
      crypto: af_alg - Disallow concurrent writes in af_alg_sendmsg
      crypto: af_alg - Set merge to zero early in af_alg_sendmsg

Huacai Chen (1):
      LoongArch: Align ACPI structures if ARCH_STRICT_ALIGN enabled

Hugh Dickins (2):
      mm: revert "mm: vmscan.c: fix OOM on swap stress test"
      mm/gup: check ref_count instead of lru before migration

Håkon Bugge (1):
      rds: ib: Increment i_fastreg_wrs before bailing out

Ioana Ciornei (1):
      dpaa2-switch: fix buffer pool seeding for control traffic

Ivan Lipski (1):
      drm/amd/display: Allow RX6xxx & RX7700 to invoke amdgpu_irq_get/put

Jacob Keller (2):
      ice: store max_frame and rx_buf_len only in ice_rx_ring
      ice: fix Rx page leak on multi-buffer frames

Jakub Kicinski (1):
      tls: make sure to abort the stream if headers are bogus

Jamie Bainbridge (1):
      qed: Don't collect too many protection override GRC elements

Jens Axboe (4):
      io_uring: backport io_should_terminate_tw()
      io_uring: include dying ring in task_work "should cancel" state
      io_uring/msg_ring: kill alloc_cache for io_kiocb allocations
      io_uring/kbuf: drop WARN_ON_ONCE() from incremental length check

Jianbo Liu (1):
      net/mlx5e: Harden uplink netdev access against device unbind

Kan Liang (1):
      perf/x86/intel: Fix crash in icl_update_topdown_event()

Kohei Enju (1):
      igc: don't fail igc_probe() on LED setup error

Krzysztof Kozlowski (1):
      ASoC: qcom: q6apm-lpass-dais: Fix NULL pointer dereference if source graph failed

Kuniyuki Iwashima (1):
      tcp: Clear tcp_sk(sk)->fastopen_rsk in tcp_disconnect().

Lachlan Hodges (1):
      wifi: mac80211: increase scan_ies_len for S1G

Li Zhe (1):
      gup: optimize longterm pin_user_pages() for large folio

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

Matthieu Baerts (NGI0) (7):
      mptcp: set remote_deny_join_id0 on SYN recv
      selftests: mptcp: userspace pm: validate deny-join-id0 flag
      mptcp: tfo: record 'deny join id0' info
      mptcp: propagate shutdown to subflows when possible
      selftests: mptcp: connect: catch IO errors on listen side
      selftests: mptcp: avoid spurious errors on TCP disconnect
      mptcp: pm: nl: announce deny-join-id0 flag

Miaoqian Lin (1):
      um: virtio_uml: Fix use-after-free after put_device in probe

Mikulas Patocka (2):
      dm-raid: don't set io_min and io_opt for raid1
      dm-stripe: fix a possible integer overflow

Mohammad Rafi Shaik (2):
      ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S interface
      ASoC: qcom: q6apm-lpass-dais: Fix missing set_fmt DAI op for I2S

Namjae Jeon (1):
      ksmbd: smbdirect: validate data_offset and data_length field of smb_direct_data_transfer

Nathan Chancellor (1):
      nilfs2: fix CFI failure when accessing /sys/fs/nilfs2/features/*

Niklas Neronin (2):
      usb: xhci: introduce macro for ring segment list iteration
      usb: xhci: remove option to change a default ring's TRB cycle bit

Paulo Alcantara (1):
      smb: client: fix filename matching of deferred files

Pavel Begunkov (1):
      io_uring/cmd: let cmds to know about dying task

Praful Adiga (1):
      ALSA: hda/realtek: Fix mute led for HP Laptop 15-dw4xx

Qi Xi (1):
      drm: bridge: cdns-mhdp8546: Fix missing mutex unlock on error path

Qu Wenruo (1):
      btrfs: tree-checker: fix the incorrect inode ref size check

Sankararaman Jayaraman (1):
      vmxnet3: unregister xdp rxq info in the reset path

Sathesh B Edara (1):
      octeon_ep: fix VF MAC address lifecycle handling

Sean Christopherson (1):
      KVM: SVM: Set/clear SRSO's BP_SPEC_REDUCE on 0 <=> 1 VM count transitions

Shivank Garg (1):
      mm: add folio_expected_ref_count() for reference count calculation

Shuicheng Lin (1):
      drm/xe/tile: Release kobject for the failure path

Stefan Metzmacher (3):
      ksmbd: smbdirect: verify remaining_data_length respects max_fragmented_recv_size
      smb: client: let smbd_destroy() call disable_work_sync(&info->post_send_credits_work)
      smb: client: fix smbdirect_recv_io leak in smbd_negotiate() error path

Takashi Sakamoto (1):
      ALSA: firewire-motu: drop EPOLLOUT from poll return values as write is not supported

Tao Cui (1):
      LoongArch: Check the return value when creating kobj

Tariq Toukan (1):
      Revert "net/mlx5e: Update and set Xon/Xoff upon port speed set"

Thomas Fourier (1):
      mmc: mvsdio: Fix dma_unmap_sg() nents value

Tiezhu Yang (4):
      LoongArch: Update help info of ARCH_STRICT_ALIGN
      objtool/LoongArch: Mark types based on break immediate code
      objtool/LoongArch: Mark special atomic instruction as INSN_BUG type
      LoongArch: Fix unreliable stack for live patching

Tiwei Bie (1):
      um: Fix FD copy size in os_rcv_fd_msg()

Vasant Hegde (1):
      iommu/amd/pgtbl: Fix possible race while increase page table level

Yang Xiuwei (1):
      io_uring: fix incorrect io_kiocb reference in io_link_skb

Yeounsu Moon (1):
      net: natsemi: fix `rx_dropped` double accounting on `netif_rx()` failure


