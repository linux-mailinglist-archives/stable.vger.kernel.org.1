Return-Path: <stable+bounces-181696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A48B9E790
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 11:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5298C4C34DF
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A5E2E8E13;
	Thu, 25 Sep 2025 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ShB766Az"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390282E973F;
	Thu, 25 Sep 2025 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793407; cv=none; b=I63BjvnZ8WglOHpkGoDCiNJLXCcSqPfHBfdG4+RavQ5mRs60NyHY0+xE5NxhHhKbenLMT0dyDz2XeBJnEOdfqhe9GMV/Xe4mGy45AaI8Rs2pY2pk7yflaFBwYw7DKmfNr3KRkJ++jk053h2OJqC4Sl94WMzvUsRqlhmMRGGmJTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793407; c=relaxed/simple;
	bh=ah54Irker6bsMKeOBmTJ9EKpLzhXo/Odb6+Zew6ceOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nWLwDELx8D0CX9bApsf86+su9RMCExy48oMDptZxtf8Ndaa9xtp85K/cc28171AKMI3fYtlAevnF3T0y3WXohnUdlv/VdV6W7wAShhKDiJQPiaX//OrAoyVzjxlyN5kD3FTpq03CsOx9JCUjX5oBjTqVH4TMbMkBrG27P46eus0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ShB766Az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5589DC4CEF0;
	Thu, 25 Sep 2025 09:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758793406;
	bh=ah54Irker6bsMKeOBmTJ9EKpLzhXo/Odb6+Zew6ceOc=;
	h=From:To:Cc:Subject:Date:From;
	b=ShB766Az4QiB/xFID5MHeU/QZksYBpIdV+5o1P+6ZS331lUcluXRsp/yVhySoHGTk
	 30UGWsWuY+YrnRf44VfY7gR8Oz1yLLnQwPwSNI7aV0X5ZGyyNIWgHQJnRqB3YqUf/v
	 +N+utZj/A6mn9lTxfu25aQlWWfSY3/OAdTnQOMbY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.16.9
Date: Thu, 25 Sep 2025 11:43:10 +0200
Message-ID: <2025092511-ethanol-music-de7f@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.16.9 kernel.

All users of the 6.16 kernel series must upgrade.

The updated 6.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.16.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/serial/8250.yaml          |   77 +++--
 Documentation/netlink/specs/conntrack.yaml                  |    9 
 Documentation/netlink/specs/mptcp_pm.yaml                   |    4 
 Makefile                                                    |    2 
 arch/loongarch/Kconfig                                      |   12 
 arch/loongarch/Makefile                                     |   15 
 arch/loongarch/include/asm/acenv.h                          |    7 
 arch/loongarch/include/asm/kvm_mmu.h                        |   20 +
 arch/loongarch/kernel/env.c                                 |    2 
 arch/loongarch/kernel/stacktrace.c                          |    3 
 arch/loongarch/kernel/vdso.c                                |    3 
 arch/loongarch/kvm/intc/eiointc.c                           |   87 +++--
 arch/loongarch/kvm/intc/pch_pic.c                           |   21 -
 arch/loongarch/kvm/mmu.c                                    |    8 
 arch/s390/include/asm/pci_insn.h                            |   10 
 arch/um/drivers/virtio_uml.c                                |    6 
 arch/um/os-Linux/file.c                                     |    2 
 arch/x86/include/asm/sev.h                                  |   38 +-
 arch/x86/kvm/svm/svm.c                                      |    3 
 crypto/af_alg.c                                             |   10 
 drivers/block/zram/zram_drv.c                               |    8 
 drivers/clk/sunxi-ng/ccu_mp.c                               |    2 
 drivers/crypto/ccp/sev-dev.c                                |    2 
 drivers/dpll/dpll_netlink.c                                 |    4 
 drivers/gpio/gpiolib-acpi-core.c                            |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                  |   16 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                  |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                  |   24 -
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                     |   36 ++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           |   39 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                   |    2 
 drivers/gpu/drm/bridge/analogix/anx7625.c                   |    6 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c         |    6 
 drivers/gpu/drm/xe/abi/guc_actions_abi.h                    |    5 
 drivers/gpu/drm/xe/abi/guc_klvs_abi.h                       |   40 ++
 drivers/gpu/drm/xe/xe_exec_queue.c                          |   22 -
 drivers/gpu/drm/xe/xe_exec_queue_types.h                    |    8 
 drivers/gpu/drm/xe/xe_execlist.c                            |   25 +
 drivers/gpu/drm/xe/xe_execlist_types.h                      |    2 
 drivers/gpu/drm/xe/xe_gt.c                                  |    3 
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c                  |    1 
 drivers/gpu/drm/xe/xe_guc.c                                 |   62 +++-
 drivers/gpu/drm/xe/xe_guc.h                                 |    1 
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h                |    4 
 drivers/gpu/drm/xe/xe_guc_submit.c                          |  139 +++++++--
 drivers/gpu/drm/xe/xe_guc_submit.h                          |    2 
 drivers/gpu/drm/xe/xe_tile_sysfs.c                          |   12 
 drivers/gpu/drm/xe/xe_uc.c                                  |    4 
 drivers/gpu/drm/xe/xe_vm.c                                  |    4 
 drivers/iommu/amd/amd_iommu_types.h                         |    1 
 drivers/iommu/amd/init.c                                    |    9 
 drivers/iommu/amd/io_pgtable.c                              |   25 +
 drivers/iommu/intel/iommu.c                                 |    7 
 drivers/iommu/s390-iommu.c                                  |   29 +
 drivers/md/dm-raid.c                                        |    6 
 drivers/md/dm-stripe.c                                      |   10 
 drivers/mmc/host/mvsdio.c                                   |    2 
 drivers/mmc/host/sdhci-pci-gli.c                            |   68 ++++
 drivers/mmc/host/sdhci-uhs2.c                               |    3 
 drivers/mmc/host/sdhci.c                                    |   34 +-
 drivers/net/bonding/bond_main.c                             |    2 
 drivers/net/ethernet/broadcom/cnic.c                        |    3 
 drivers/net/ethernet/cavium/liquidio/request_manager.c      |    2 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c         |    2 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c                 |    3 
 drivers/net/ethernet/intel/ice/ice_txrx.c                   |   80 ++---
 drivers/net/ethernet/intel/ice/ice_txrx.h                   |    1 
 drivers/net/ethernet/intel/igc/igc.h                        |    1 
 drivers/net/ethernet/intel/igc/igc_main.c                   |   12 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c               |   22 -
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c         |   16 +
 drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c    |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c       |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h             |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h    |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c           |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c            |   27 +
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c           |    1 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c           |    4 
 drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h          |   15 
 drivers/net/ethernet/mellanox/mlx5/core/port.c              |    6 
 drivers/net/ethernet/natsemi/ns83820.c                      |   13 
 drivers/net/ethernet/qlogic/qed/qed_debug.c                 |    7 
 drivers/net/wireless/mediatek/mt76/mac80211.c               |    2 
 drivers/net/wireless/microchip/wilc1000/wlan_cfg.c          |   37 +-
 drivers/net/wireless/microchip/wilc1000/wlan_cfg.h          |    5 
 drivers/nvme/host/core.c                                    |   18 -
 drivers/pcmcia/omap_cf.c                                    |    8 
 drivers/platform/x86/asus-nb-wmi.c                          |   25 +
 drivers/platform/x86/asus-wmi.h                             |    3 
 drivers/power/supply/bq27xxx_battery.c                      |    4 
 fs/btrfs/delayed-inode.c                                    |    3 
 fs/btrfs/inode.c                                            |   11 
 fs/btrfs/tree-checker.c                                     |    4 
 fs/btrfs/tree-log.c                                         |    2 
 fs/btrfs/zoned.c                                            |    2 
 fs/nilfs2/sysfs.c                                           |    4 
 fs/nilfs2/sysfs.h                                           |    8 
 fs/smb/client/cifsproto.h                                   |    4 
 fs/smb/client/inode.c                                       |   23 +
 fs/smb/client/misc.c                                        |   38 +-
 fs/smb/client/smbdirect.c                                   |  132 +++++---
 fs/smb/client/smbdirect.h                                   |   23 -
 fs/smb/common/smbdirect/smbdirect_socket.h                  |   29 +
 fs/smb/server/transport_rdma.c                              |  183 ++++++++----
 include/crypto/if_alg.h                                     |   10 
 include/linux/io_uring_types.h                              |    3 
 include/linux/mlx5/driver.h                                 |    1 
 include/linux/swap.h                                        |   10 
 include/net/dst_metadata.h                                  |   11 
 include/net/sock.h                                          |    5 
 include/sound/sdca.h                                        |    1 
 include/uapi/linux/mptcp.h                                  |    2 
 include/uapi/linux/mptcp_pm.h                               |    4 
 io_uring/io-wq.c                                            |    6 
 io_uring/io_uring.c                                         |   10 
 io_uring/io_uring.h                                         |    4 
 io_uring/msg_ring.c                                         |   24 -
 io_uring/notif.c                                            |    2 
 io_uring/poll.c                                             |    2 
 io_uring/timeout.c                                          |    2 
 io_uring/uring_cmd.c                                        |    2 
 kernel/cgroup/cgroup.c                                      |   43 ++
 kernel/sched/ext.c                                          |    6 
 mm/gup.c                                                    |   52 ++-
 mm/mlock.c                                                  |    6 
 mm/swap.c                                                   |   50 +--
 mm/vmscan.c                                                 |    2 
 net/ipv4/tcp.c                                              |    5 
 net/ipv4/tcp_ao.c                                           |    4 
 net/mac80211/driver-ops.h                                   |    2 
 net/mac80211/main.c                                         |    7 
 net/mptcp/options.c                                         |    6 
 net/mptcp/pm_netlink.c                                      |    7 
 net/mptcp/protocol.c                                        |   16 +
 net/mptcp/subflow.c                                         |    4 
 net/rds/ib_frmr.c                                           |   20 -
 net/rfkill/rfkill-gpio.c                                    |    4 
 net/rxrpc/rxgk.c                                            |   18 -
 net/rxrpc/rxgk_app.c                                        |   29 +
 net/rxrpc/rxgk_common.h                                     |   14 
 net/tls/tls.h                                               |    1 
 net/tls/tls_strp.c                                          |   14 
 net/tls/tls_sw.c                                            |    3 
 samples/damon/mtier.c                                       |   25 -
 samples/damon/prcl.c                                        |   31 +-
 samples/damon/wsse.c                                        |   22 -
 sound/firewire/motu/motu-hwdep.c                            |    2 
 sound/pci/hda/patch_realtek.c                               |    1 
 sound/soc/amd/acp/acp-i2s.c                                 |   11 
 sound/soc/codecs/sma1307.c                                  |    7 
 sound/soc/codecs/wm8940.c                                   |    9 
 sound/soc/codecs/wm8974.c                                   |    8 
 sound/soc/intel/catpt/pcm.c                                 |   23 +
 sound/soc/qcom/qdsp6/audioreach.c                           |    1 
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c                     |    7 
 sound/soc/sdca/sdca_device.c                                |   20 +
 sound/soc/sdca/sdca_functions.c                             |   13 
 sound/soc/sdca/sdca_regmap.c                                |    2 
 sound/soc/sof/intel/hda-stream.c                            |    2 
 sound/usb/qcom/qc_audio_offload.c                           |   92 +++---
 tools/arch/loongarch/include/asm/inst.h                     |   12 
 tools/objtool/arch/loongarch/decode.c                       |   33 +-
 tools/perf/util/maps.c                                      |    9 
 tools/testing/selftests/net/mptcp/mptcp_connect.c           |   11 
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c           |   16 -
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c               |    7 
 tools/testing/selftests/net/mptcp/userspace_pm.sh           |   14 
 169 files changed, 1794 insertions(+), 821 deletions(-)

Ajay.Kathat@microchip.com (1):
      wifi: wilc1000: avoid buffer overflow in WID string configuration

Alex Deucher (2):
      drm/amdkfd: add proper handling for S0ix
      drm/amdgpu: suspend KFD and KGD user queues for S0ix

Alex Elder (1):
      dt-bindings: serial: 8250: move a constraint

Alexey Nepomnyashih (1):
      net: liquidio: fix overflow in octeon_init_instr_queue()

Amadeusz Sławiński (1):
      ASoC: Intel: catpt: Expose correct bit depth to userspace

Anderson Nascimento (1):
      net/tcp: Fix a NULL pointer dereference when using TCP-AO with TCP_REPAIR

Andrea Righi (1):
      Revert "sched_ext: Skip per-CPU tasks in scx_bpf_reenqueue_local()"

Antheas Kapenekakis (2):
      platform/x86: asus-wmi: Fix ROG button mapping, tablet mode on ASUS ROG Z13
      platform/x86: asus-wmi: Re-add extra keys to ignore_key_wlan quirk

Ben Chuang (3):
      mmc: sdhci: Move the code related to setting the clock from sdhci_set_ios_common() into sdhci_set_ios()
      mmc: sdhci-pci-gli: GL9767: Fix initializing the UHS-II interface during a power-on
      mmc: sdhci-uhs2: Fix calling incorrect sdhci_set_clock() function

Bibo Mao (5):
      LoongArch: KVM: Avoid copy_*_user() with lock hold in kvm_eiointc_ctrl_access()
      LoongArch: KVM: Avoid copy_*_user() with lock hold in kvm_eiointc_regs_access()
      LoongArch: KVM: Avoid copy_*_user() with lock hold in kvm_eiointc_sw_status_access()
      LoongArch: KVM: Avoid copy_*_user() with lock hold in kvm_pch_pic_regs_access()
      LoongArch: KVM: Fix VM migration failure with PTW enabled

Borislav Petkov (AMD) (1):
      crypto: ccp - Always pass in an error pointer to __sev_platform_shutdown_locked()

Charles Keepax (4):
      ASoC: wm8940: Correct PLL rate rounding
      ASoC: wm8940: Correct typo in control name
      ASoC: wm8974: Correct PLL rate rounding
      ASoC: SDCA: Fix return value in sdca_regmap_mbq_size()

Chen Ridong (1):
      cgroup: split cgroup_destroy_wq into 3 workqueues

Chen-Yu Tsai (1):
      clk: sunxi-ng: mp: Fix dual-divider clock rate readback

Christoph Hellwig (1):
      nvme: fix PI insert on write

Colin Ian King (1):
      ASoC: SOF: Intel: hda-stream: Fix incorrect variable used in error message

Dan Carpenter (2):
      ASoC: codec: sma1307: Fix memory corruption in sma1307_setting_loaded()
      drm/xe: Fix a NULL vs IS_ERR() in xe_vm_add_compute_exec_queue()

Daniele Ceraolo Spurio (3):
      drm/xe: Fix error handling if PXP fails to start
      drm/xe/guc: Enable extended CAT error reporting
      drm/xe/guc: Set RCS/CCS yield policy

David Howells (2):
      rxrpc: Fix unhandled errors in rxgk_verify_packet_integrity()
      rxrpc: Fix untrusted unsigned subtract

Duoming Zhou (2):
      cnic: Fix use-after-free bugs in cnic_delete_task
      octeontx2-pf: Fix use-after-free bugs in otx2_sync_tstamp()

Eric Dumazet (1):
      net: clear sk->sk_ino in sk_set_socket(sk, NULL)

Eugene Koira (1):
      iommu/vt-d: Fix __domain_mapping()'s usage of switch_to_super_page()

Felix Fietkau (1):
      wifi: mt76: do not add non-sta wcid entries to the poll list

Filipe Manana (1):
      btrfs: fix invalid extref key setup when replaying dentry

Frank Li (1):
      dt-bindings: serial: 8250: allow clock 'uartclk' and 'reg' for nxp,lpc1850-uart

Geert Uytterhoeven (1):
      pcmcia: omap_cf: Mark driver struct with __refdata to prevent section mismatch

Geliang Tang (1):
      selftests: mptcp: sockopt: fix error messages

Greg Kroah-Hartman (1):
      Linux 6.16.9

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

Honggyu Kim (1):
      samples/damon: change enable parameters to enabled

Huacai Chen (1):
      LoongArch: Align ACPI structures if ARCH_STRICT_ALIGN enabled

Hugh Dickins (5):
      mm/gup: check ref_count instead of lru before migration
      mm: revert "mm/gup: clear the LRU flag of a page before adding to LRU batch"
      mm/gup: local lru_add_drain() to avoid lru_add_drain_all()
      mm: revert "mm: vmscan.c: fix OOM on swap stress test"
      mm: folio_may_be_lru_cached() unless folio_test_large()

Håkon Bugge (1):
      rds: ib: Increment i_fastreg_wrs before bailing out

Ian Rogers (1):
      perf maps: Ensure kmap is set up for all inserts

Ilya Maximets (1):
      net: dst_metadata: fix IP_DF bit not extracted from tunnel headers

Ioana Ciornei (1):
      dpaa2-switch: fix buffer pool seeding for control traffic

Ivan Lipski (1):
      drm/amd/display: Allow RX6xxx & RX7700 to invoke amdgpu_irq_get/put

Ivan Vecera (1):
      dpll: fix clock quality level reporting

Jacob Keller (1):
      ice: fix Rx page leak on multi-buffer frames

Jakub Kicinski (1):
      tls: make sure to abort the stream if headers are bogus

Jamie Bainbridge (1):
      qed: Don't collect too many protection override GRC elements

Jedrzej Jagielski (2):
      ixgbe: initialize aci.lock before it's used
      ixgbe: destroy aci.lock later within ixgbe_remove path

Jens Axboe (2):
      io_uring: include dying ring in task_work "should cancel" state
      io_uring/msg_ring: kill alloc_cache for io_kiocb allocations

Jianbo Liu (1):
      net/mlx5e: Harden uplink netdev access against device unbind

Johannes Thumshirn (1):
      btrfs: zoned: fix incorrect ASSERT in btrfs_zoned_reserve_data_reloc_bg()

Kamal Heib (1):
      octeon_ep: Validate the VF ID

Kohei Enju (1):
      igc: don't fail igc_probe() on LED setup error

Krzysztof Kozlowski (1):
      ASoC: qcom: q6apm-lpass-dais: Fix NULL pointer dereference if source graph failed

Kuniyuki Iwashima (1):
      tcp: Clear tcp_sk(sk)->fastopen_rsk in tcp_disconnect().

Lachlan Hodges (1):
      wifi: mac80211: increase scan_ies_len for S1G

Lama Kayal (1):
      net/mlx5e: Add a miss level for ipsec crypto offload

Li Tian (1):
      net/mlx5: Not returning mlx5_link_info table when speed is unknown

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

Maciej Strozek (1):
      ASoC: SDCA: Add quirk for incorrect function types for 3 systems

Mario Limonciello (1):
      drm/amd: Only restore cached manual clock settings in restore if OD enabled

Matthew Rosato (1):
      iommu/s390: Fix memory corruption when using identity domain

Matthieu Baerts (NGI0) (7):
      mptcp: set remote_deny_join_id0 on SYN recv
      selftests: mptcp: userspace pm: validate deny-join-id0 flag
      mptcp: tfo: record 'deny join id0' info
      mptcp: propagate shutdown to subflows when possible
      selftests: mptcp: connect: catch IO errors on listen side
      selftests: mptcp: avoid spurious errors on TCP disconnect
      mptcp: pm: nl: announce deny-join-id0 flag

Max Kellermann (1):
      io_uring/io-wq: fix `max_workers` breakage and `nr_workers` underflow

Miaoqian Lin (1):
      um: virtio_uml: Fix use-after-free after put_device in probe

Michal Wajdeczko (1):
      drm/xe/pf: Drop rounddown_pow_of_two fair LMEM limitation

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

Niklas Schnelle (1):
      iommu/s390: Make attach succeed when the device was surprise removed

Paulo Alcantara (2):
      smb: client: fix filename matching of deferred files
      smb: client: fix file open check in __cifs_unlink()

Praful Adiga (1):
      ALSA: hda/realtek: Fix mute led for HP Laptop 15-dw4xx

Qi Xi (1):
      drm: bridge: cdns-mhdp8546: Fix missing mutex unlock on error path

Qu Wenruo (1):
      btrfs: tree-checker: fix the incorrect inode ref size check

Remy D. Farley (1):
      doc/netlink: Fix typos in operation attributes

Sathesh B Edara (1):
      octeon_ep: fix VF MAC address lifecycle handling

SeongJae Park (3):
      samples/damon/prcl: fix boot time enable crash
      samples/damon/mtier: avoid starting DAMON before initialization
      samples/damon/prcl: avoid starting DAMON before initialization

Sergey Senozhatsky (1):
      zram: fix slot write race condition

Shuicheng Lin (1):
      drm/xe/tile: Release kobject for the failure path

Stefan Metzmacher (10):
      smb: server: let smb_direct_writev() respect SMB_DIRECT_MAX_SEND_SGES
      ksmbd: smbdirect: verify remaining_data_length respects max_fragmented_recv_size
      smb: smbdirect: introduce smbdirect_socket.recv_io.expected
      smb: client: make use of smbdirect_socket->recv_io.expected
      smb: smbdirect: introduce struct smbdirect_recv_io
      smb: client: make use of struct smbdirect_recv_io
      smb: client: let recv_done verify data_offset, data_length and remaining_data_length
      smb: client: use disable[_delayed]_work_sync in smbdirect.c
      smb: client: let smbd_destroy() call disable_work_sync(&info->post_send_credits_work)
      smb: client: fix smbdirect_recv_io leak in smbd_negotiate() error path

Sébastien Szymanski (1):
      gpiolib: acpi: initialize acpi_gpio_info struct

Takashi Iwai (1):
      ALSA: usb: qcom: Fix false-positive address space check

Takashi Sakamoto (1):
      ALSA: firewire-motu: drop EPOLLOUT from poll return values as write is not supported

Tao Cui (1):
      LoongArch: Check the return value when creating kobj

Tariq Toukan (1):
      Revert "net/mlx5e: Update and set Xon/Xoff upon port speed set"

Thomas Fourier (1):
      mmc: mvsdio: Fix dma_unmap_sg() nents value

Tiezhu Yang (6):
      LoongArch: Update help info of ARCH_STRICT_ALIGN
      objtool/LoongArch: Mark types based on break immediate code
      objtool/LoongArch: Mark special atomic instruction as INSN_BUG type
      LoongArch: Fix unreliable stack for live patching
      LoongArch: Make LTO case independent in Makefile
      LoongArch: Handle jump tables options for RUST

Tiwei Bie (1):
      um: Fix FD copy size in os_rcv_fd_msg()

Tom Lendacky (1):
      x86/sev: Guard sev_evict_cache() with CONFIG_AMD_MEM_ENCRYPT

Vasant Hegde (2):
      iommu/amd/pgtbl: Fix possible race while increase page table level
      iommu/amd: Fix alias device DTE setting

Venkata Prasad Potturu (1):
      ASoC: amd: acp: Fix incorrect retrival of acp_chip_info

Yang Xiuwei (1):
      io_uring: fix incorrect io_kiocb reference in io_link_skb

Yeounsu Moon (1):
      net: natsemi: fix `rx_dropped` double accounting on `netif_rx()` failure

Yixun Lan (1):
      dt-bindings: serial: 8250: spacemit: set clocks property as required

Zhen Ni (1):
      iommu/amd: Fix ivrs_base memleak in early_amd_iommu_init()

austinchang (1):
      btrfs: initialize inode::file_extent_tree after i_mode has been set


