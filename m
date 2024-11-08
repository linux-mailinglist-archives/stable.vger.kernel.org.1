Return-Path: <stable+bounces-91956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C30319C216E
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 17:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809A72838CE
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 16:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26E513BAD7;
	Fri,  8 Nov 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XaWWQbcb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8472719415D;
	Fri,  8 Nov 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081619; cv=none; b=KMxziLL8OpUTvFyy9IHGki4/Lg00TfE25OQ15OSJskV9F42DmQ2Da1WHso4RowKOumplDFERuYWJ0TT+3wJK1HXKhdrnUikgupsIxtUpH2TnTNvm5MMnfQwLN9CZN0iyHUIrv9XYEihCrAGcZC+IQKszstEPvuAOOD4kSdcg9tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081619; c=relaxed/simple;
	bh=nu0Lfm3ZbZUk/RjXKXlrXGaUhveMeoUOEZ+KZfIIsgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TmAHEnfjMHg/PCfnHGlao8IIaqjr8AulZhJs7dirTYVZBPjLWdhk1/BbUebqo+axqgYvTJSPIC/YoDFOeb9Z5gTxC6VHtlw9JMsrynfflEtKP6N+I9UehqvyqKOXUuehD0UEe1Ng8rMH5NYzTjVPPc8xf5bdzixbwkBKvHk6SAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XaWWQbcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4B1C4CECD;
	Fri,  8 Nov 2024 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731081619;
	bh=nu0Lfm3ZbZUk/RjXKXlrXGaUhveMeoUOEZ+KZfIIsgc=;
	h=From:To:Cc:Subject:Date:From;
	b=XaWWQbcbLBMJXqntZAwlSvwWymkJBXdWQwoS4WS4BN1Yz3MAHzwdhHnnvs5wUvV9/
	 /kDmgvdoSjCj1qTqIaMaUmLEcj9dmon6RXiKHpiqswE/O45ufbSoH/m475HHWwYN6N
	 wS3Afg2bYyT62t77mk19XfBPZwlZ5uOxBAe0Zg9o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.60
Date: Fri,  8 Nov 2024 16:59:51 +0100
Message-ID: <2024110852-define-frenzied-289f@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.60 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi                     |    2 
 arch/riscv/kernel/acpi.c                                       |    4 
 arch/riscv/kernel/asm-offsets.c                                |    2 
 arch/riscv/kernel/cpu-hotplug.c                                |    2 
 arch/riscv/kernel/efi-header.S                                 |    2 
 arch/riscv/kernel/traps_misaligned.c                           |    2 
 arch/riscv/kernel/vdso/Makefile                                |    1 
 arch/x86/include/asm/bug.h                                     |   12 
 arch/x86/kernel/traps.c                                        |   71 ++
 block/blk-map.c                                                |    4 
 drivers/acpi/cppc_acpi.c                                       |    9 
 drivers/base/core.c                                            |   48 +-
 drivers/base/module.c                                          |    4 
 drivers/cxl/acpi.c                                             |    7 
 drivers/cxl/core/hdm.c                                         |   50 +-
 drivers/cxl/core/port.c                                        |   13 
 drivers/cxl/core/region.c                                      |   48 --
 drivers/cxl/core/trace.h                                       |   17 
 drivers/cxl/cxl.h                                              |    3 
 drivers/firmware/arm_sdei.c                                    |    2 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c             |    3 
 drivers/iio/adc/ad7124.c                                       |    2 
 drivers/iio/industrialio-gts-helper.c                          |    4 
 drivers/iio/light/veml6030.c                                   |    2 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                       |    4 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                     |   38 -
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h                     |    2 
 drivers/infiniband/hw/cxgb4/provider.c                         |    1 
 drivers/infiniband/hw/mlx5/qp.c                                |    4 
 drivers/input/joystick/xpad.c                                  |   12 
 drivers/input/touchscreen/edt-ft5x06.c                         |   19 
 drivers/misc/mei/client.c                                      |    4 
 drivers/misc/sgi-gru/grukservices.c                            |    2 
 drivers/misc/sgi-gru/grumain.c                                 |    4 
 drivers/misc/sgi-gru/grutlbpurge.c                             |    2 
 drivers/mmc/host/sdhci-pci-gli.c                               |   38 +
 drivers/mtd/spi-nor/winbond.c                                  |    7 
 drivers/net/ethernet/amd/mvme147.c                             |    7 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c            |   26 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c             |    7 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c               |    8 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h               |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c              |   22 
 drivers/net/gtp.c                                              |   22 
 drivers/net/macsec.c                                           |    3 
 drivers/net/mctp/mctp-i2c.c                                    |    3 
 drivers/net/netdevsim/fib.c                                    |    4 
 drivers/net/wireless/ath/ath10k/wmi-tlv.c                      |    7 
 drivers/net/wireless/ath/ath10k/wmi.c                          |    2 
 drivers/net/wireless/ath/ath11k/dp_rx.c                        |    7 
 drivers/net/wireless/broadcom/brcm80211/Kconfig                |    1 
 drivers/net/wireless/intel/iwlegacy/common.c                   |   15 
 drivers/net/wireless/intel/iwlegacy/common.h                   |   12 
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                    |   22 
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c          |   24 -
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                  |    3 
 drivers/nvme/target/auth.c                                     |    1 
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c                     |   10 
 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c                 |    1 
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c                        |    1 
 drivers/scsi/scsi_transport_fc.c                               |    4 
 drivers/spi/spi-fsl-dspi.c                                     |    6 
 drivers/spi/spi-geni-qcom.c                                    |    8 
 drivers/staging/iio/frequency/ad9832.c                         |    7 
 drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c |   70 +-
 drivers/thermal/thermal_core.c                                 |   25 -
 drivers/thunderbolt/tb.c                                       |   48 +-
 drivers/usb/gadget/udc/dummy_hcd.c                             |   57 +-
 drivers/usb/host/xhci-pci.c                                    |    6 
 drivers/usb/host/xhci-ring.c                                   |   16 
 drivers/usb/phy/phy.c                                          |    2 
 drivers/usb/typec/class.c                                      |    1 
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c                  |    4 
 fs/afs/dir.c                                                   |   25 +
 fs/afs/dir_edit.c                                              |   91 +++
 fs/afs/internal.h                                              |    2 
 fs/dax.c                                                       |   45 +
 fs/iomap/buffered-io.c                                         |    7 
 fs/nfs/delegation.c                                            |    5 
 fs/nilfs2/namei.c                                              |    3 
 fs/nilfs2/page.c                                               |    1 
 fs/ntfs3/file.c                                                |    9 
 fs/ntfs3/frecord.c                                             |    4 
 fs/ntfs3/inode.c                                               |   15 
 fs/ntfs3/lznt.c                                                |    3 
 fs/ntfs3/namei.c                                               |    2 
 fs/ntfs3/ntfs_fs.h                                             |    2 
 fs/ntfs3/record.c                                              |   31 -
 fs/ocfs2/file.c                                                |    8 
 fs/smb/client/cifs_unicode.c                                   |   17 
 fs/smb/client/reparse.c                                        |  174 ++++++-
 fs/smb/client/reparse.h                                        |    9 
 fs/smb/client/smb2inode.c                                      |    3 
 fs/smb/client/smb2proto.h                                      |    1 
 fs/xfs/xfs_filestream.c                                        |   23 
 fs/xfs/xfs_trace.h                                             |   15 
 include/acpi/cppc_acpi.h                                       |    2 
 include/linux/compiler-gcc.h                                   |    4 
 include/linux/device.h                                         |    3 
 include/linux/huge_mm.h                                        |   18 
 include/linux/iomap.h                                          |   19 
 include/linux/sched.h                                          |    2 
 include/linux/thermal.h                                        |    2 
 include/linux/ubsan.h                                          |    5 
 include/net/ip_tunnels.h                                       |    2 
 include/trace/events/afs.h                                     |  240 +---------
 init/init_task.c                                               |    1 
 io_uring/io_uring.c                                            |   13 
 io_uring/rw.c                                                  |   23 
 kernel/bpf/cgroup.c                                            |   19 
 kernel/bpf/lpm_trie.c                                          |    2 
 kernel/bpf/verifier.c                                          |    9 
 kernel/cgroup/cgroup.c                                         |    4 
 kernel/fork.c                                                  |    1 
 kernel/rcu/tasks.h                                             |   90 ++-
 kernel/sched/fair.c                                            |    4 
 lib/Kconfig.ubsan                                              |    4 
 lib/iov_iter.c                                                 |    6 
 mm/huge_memory.c                                               |   13 
 mm/kasan/kasan_test.c                                          |   27 -
 mm/memory.c                                                    |    9 
 mm/migrate.c                                                   |    2 
 mm/page_alloc.c                                                |   10 
 mm/shmem.c                                                     |    2 
 net/bluetooth/hci_sync.c                                       |   18 
 net/bpf/test_run.c                                             |    1 
 net/core/dev.c                                                 |    4 
 net/core/rtnetlink.c                                           |    4 
 net/ipv6/netfilter/nf_reject_ipv6.c                            |   15 
 net/mac80211/Kconfig                                           |    2 
 net/mac80211/agg-tx.c                                          |    4 
 net/mac80211/cfg.c                                             |    3 
 net/mac80211/key.c                                             |   42 +
 net/mptcp/protocol.c                                           |    2 
 net/netfilter/nft_payload.c                                    |    3 
 net/netfilter/x_tables.c                                       |    2 
 net/sched/sch_api.c                                            |    2 
 net/sunrpc/svc.c                                               |    9 
 net/wireless/core.c                                            |    1 
 sound/pci/hda/patch_realtek.c                                  |   23 
 sound/soc/codecs/cs42l51.c                                     |    7 
 sound/soc/sof/ipc4-control.c                                   |  175 +++++++
 sound/soc/sof/ipc4-topology.c                                  |   49 +-
 sound/soc/sof/ipc4-topology.h                                  |   19 
 sound/usb/mixer_quirks.c                                       |    3 
 tools/mm/page-types.c                                          |    9 
 tools/mm/slabinfo.c                                            |    4 
 tools/testing/cxl/test/cxl.c                                   |   14 
 tools/testing/selftests/bpf/bpf_experimental.h                 |   31 +
 tools/testing/selftests/mm/uffd-common.c                       |    5 
 tools/testing/selftests/mm/uffd-common.h                       |    3 
 tools/testing/selftests/mm/uffd-unit-tests.c                   |   21 
 tools/usb/usbip/src/usbip_detach.c                             |    1 
 154 files changed, 1653 insertions(+), 771 deletions(-)

Alan Stern (1):
      USB: gadget: dummy-hcd: Fix "task hung" problem

Alexander Usyskin (1):
      mei: use kvmalloc for read buffer

Alexandre Ghiti (1):
      riscv: vdso: Prevent the compiler from inserting calls to memset()

Amit Cohen (1):
      mlxsw: spectrum_ptp: Add missing verification before pushing Tx header

Andrew Ballance (1):
      fs/ntfs3: Check if more than chunk-size bytes are written

Andrey Konovalov (2):
      usb: gadget: dummy_hcd: execute hrtimer callback in softirq context
      kasan: remove vmalloc_percpu test

Basavaraj Natikar (1):
      xhci: Use pm_runtime_get to prevent RPM on unsupported systems

Ben Chuang (2):
      mmc: sdhci-pci-gli: GL9767: Fix low power mode on the set clock function
      mmc: sdhci-pci-gli: GL9767: Fix low power mode in the SD Express process

Ben Hutchings (1):
      wifi: iwlegacy: Fix "field-spanning write" warning in il_enqueue_hcmd()

Benjamin Marzinski (1):
      scsi: scsi_transport_fc: Allow setting rport state to current state

Benoît Monin (1):
      net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension

Brenton Simpson (1):
      Input: xpad - sort xpad_device by vendor and product ID

Byeonguk Jeong (1):
      bpf: Fix out-of-bounds write in trie_get_next_key()

Chen Ridong (1):
      cgroup/bpf: use a dedicated workqueue for cgroup bpf destruction

Christoffer Sandberg (2):
      ALSA: hda/realtek: Fix headset mic on TUXEDO Gemini 17 Gen3
      ALSA: hda/realtek: Fix headset mic on TUXEDO Stellaris 16 Gen6 mb1

Christoph Hellwig (3):
      iomap: improve shared block detection in iomap_unshare_iter
      iomap: turn iomap_want_unshare_iter into an inline function
      xfs: fix finding a last resort AG in xfs_filestream_pick_ag

Christophe JAILLET (1):
      ASoC: cs42l51: Fix some error handling paths in cs42l51_probe()

Chuck Lever (1):
      SUNRPC: Remove BUG_ON call sites

Chunyan Zhang (2):
      riscv: Remove unused GENERATING_ASM_OFFSETS
      riscv: Remove duplicated GET_RM

Dai Ngo (1):
      NFS: remove revoked delegation from server's delegation list

Dan Williams (3):
      cxl/port: Fix use-after-free, permit out-of-order decoder shutdown
      cxl/port: Fix cxl_bus_rescan() vs bus_rescan_devices()
      cxl/acpi: Ensure ports ready at cxl_acpi_probe() return

Daniel Gabay (1):
      wifi: iwlwifi: mvm: Fix response handling in iwl_mvm_send_recovery_cmd()

Daniel Palmer (1):
      net: amd: mvme147: Fix probe banner message

Darrick J. Wong (4):
      iomap: don't bother unsharing delalloc extents
      iomap: share iomap_unshare_iter predicate code with fsdax
      fsdax: remove zeroing code from dax_unshare_iter
      fsdax: dax_unshare_iter needs to copy entire blocks

David Hildenbrand (1):
      mm: don't install PMD mappings when THPs are disabled by the hw/process/vma

David Howells (2):
      afs: Automatically generate trace tag enums
      afs: Fix missing subdir edit when renamed between parent dirs

Dimitri Sivanich (1):
      misc: sgi-gru: Don't disable preemption in GRU driver

Dmitry Torokhov (1):
      Input: edt-ft5x06 - fix regmap leak when probe fails

Dong Chenchen (1):
      netfilter: Fix use-after-free in get_info()

Eduard Zingerman (1):
      bpf: Force checkpoint when jmp history is too long

Edward Adam Davis (1):
      ocfs2: pass u64 to ocfs2_truncate_inline maybe overflow

Edward Liaw (2):
      Revert "selftests/mm: fix deadlock for fork after pthread_create on ARM"
      Revert "selftests/mm: replace atomic_bool with pthread_barrier_t"

Emmanuel Grumbach (2):
      wifi: iwlwifi: mvm: disconnect station vifs if recovery failed
      wifi: iwlwifi: mvm: don't add default link in fw restart flow

Eric Dumazet (1):
      netfilter: nf_reject_ipv6: fix potential crash in nf_send_reset6()

Faisal Hassan (1):
      xhci: Fix Link TRB DMA in command ring stopped completion event

Felix Fietkau (2):
      wifi: mac80211: skip non-uploaded keys in ieee80211_iter_keys
      wifi: mac80211: do not pass a stopped vif to the driver in .get_txpower

Frank Li (1):
      spi: spi-fsl-dspi: Fix crash when not using GPIO chip select

Furong Xu (1):
      net: stmmac: TSO: Fix unbalanced DMA map/unmap for non-paged SKB data

Gatlin Newhouse (1):
      x86/traps: Enable UBSAN traps on x86

Geert Uytterhoeven (2):
      mac80211: MAC80211_MESSAGE_TRACING should depend on TRACING
      wifi: brcm80211: BRCM_TRACING should depend on TRACING

Georgi Djakov (1):
      spi: geni-qcom: Fix boot warning related to pm_runtime and devres

Gil Fine (1):
      thunderbolt: Honor TMU requirements in the domain when setting TMU mode

Greg Kroah-Hartman (2):
      Revert "driver core: Fix uevent_show() vs driver detach race"
      Linux 6.6.60

Gregory Price (1):
      vmscan,migrate: fix page count imbalance on node stats when demoting pages

Haibo Chen (1):
      arm64: dts: imx8ulp: correct the flexspi compatible string

Heinrich Schuchardt (1):
      riscv: efi: Set NX compat flag in PE/COFF header

Hugh Dickins (1):
      iov_iter: fix copy_page_from_iter_atomic() if KMAP_LOCAL_FORCE_MAP

Ido Schimmel (2):
      ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_init_flow()
      mlxsw: spectrum_ipip: Fix memory leak when changing remote IPv6 address

Jan Schär (1):
      ALSA: usb-audio: Add quirks for Dell WD19 dock

Javier Carrasco (3):
      usb: typec: fix unreleased fwnode_handle in typec_port_register_altmodes()
      usb: typec: qcom-pmic-typec: use fwnode_handle_put() to release fwnodes
      iio: light: veml6030: fix microlux value calculation

Jens Axboe (1):
      io_uring/rw: fix missing NOWAIT check for O_DIRECT start write

Jeongjun Park (1):
      mm: shmem: fix data-race in shmem_getattr()

Jianbo Liu (1):
      macsec: Fix use-after-free while sending the offloading packet

Jinjie Ruan (2):
      iio: gts-helper: Fix memory leaks for the error path of iio_gts_build_avail_scale_table()
      iio: gts-helper: Fix memory leaks in iio_gts_build_avail_scale_table()

Johan Hovold (2):
      phy: qcom: qmp-usb: fix NULL-deref on runtime suspend
      phy: qcom: qmp-usb-legacy: fix NULL-deref on runtime suspend

Johannes Berg (2):
      wifi: cfg80211: clear wdev->cqm_config pointer on free
      wifi: iwlwifi: mvm: fix 6 GHz scan construction

Kailang Yang (1):
      ALSA: hda/realtek: Limit internal Mic boost on Dell platform

Kefeng Wang (1):
      mm: huge_memory: add vma_thp_disabled() and thp_disabled_by_hw()

Konstantin Komarov (8):
      fs/ntfs3: Fix warning possible deadlock in ntfs_set_state
      fs/ntfs3: Stale inode instead of bad
      fs/ntfs3: Add rough attr alloc_size check
      fs/ntfs3: Fix possible deadlock in mi_read
      fs/ntfs3: Additional check in ni_clear()
      fs/ntfs3: Fix general protection fault in run_is_mapped_full
      fs/ntfs3: Additional check in ntfs_file_release
      fs/ntfs3: Sequential field availability check in mi_enum_attr()

Leon Romanovsky (1):
      RDMA/cxgb4: Dump vendor specific QP details

Ley Foon Tan (1):
      net: stmmac: dwmac4: Fix high address display by updating reg_space[] from register values

Manikanta Pubbisetty (1):
      wifi: ath10k: Fix memory leak in management tx

Marcello Sylvester Bauer (2):
      usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler
      usb: gadget: dummy_hcd: Set transfer interval to 1 microframe

Marco Elver (1):
      kasan: Fix Software Tag-Based KASAN with GCC

Matt Fleming (1):
      mm/page_alloc: let GFP_ATOMIC order-0 allocs access highatomic reserves

Matt Johnston (1):
      mctp i2c: handle NULL header address

Matthieu Baerts (NGI0) (1):
      mptcp: init: protect sched with rcu_read_lock

Michael Walle (1):
      mtd: spi-nor: winbond: fix w25q128 regression

Pablo Neira Ayuso (2):
      gtp: allow -1 to be specified as file description from userspace
      netfilter: nft_payload: sanitize offset and length before calling skb_checksum()

Pali Rohár (2):
      cifs: Improve creating native symlinks pointing to directory
      cifs: Fix creating native symlinks pointing to current or parent directory

Patrisious Haddad (1):
      RDMA/mlx5: Round max_rd_atomic/max_dest_rd_atomic up instead of down

Paul E. McKenney (3):
      rcu-tasks: Pull sampling of ->percpu_dequeue_lim out of loop
      rcu-tasks: Add data to eliminate RCU-tasks/do_exit() deadlocks
      rcu-tasks: Initialize data to eliminate RCU-tasks/do_exit() deadlocks

Paulo Alcantara (2):
      smb: client: fix parsing of device numbers
      smb: client: set correct device number on nfs reparse points

Pavel Begunkov (1):
      io_uring: always lock __io_cqring_overflow_flush

Pedro Tammela (1):
      net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROOT

Peter Ujfalusi (3):
      ASoC: SOF: ipc4-topology: Add definition for generic switch/enum control
      ASoC: SOF: ipc4-control: Add support for ALSA switch control
      ASoC: SOF: ipc4-control: Add support for ALSA enum control

Pierre Gondois (1):
      ACPI: CPPC: Make rmw_lock a raw_spin_lock

Rafael J. Wysocki (3):
      thermal: core: Make thermal_zone_device_unregister() return after freeing the zone
      thermal: core: Rework thermal zone availability check
      thermal: core: Free tzp copy along with the thermal zone

Remi Pommarel (1):
      wifi: ath11k: Fix invalid ring usage in full monitor mode

Richard Zhu (1):
      phy: freescale: imx8m-pcie: Do CMN_RST just before PHY PLL lock check

Ryusuke Konishi (2):
      nilfs2: fix potential deadlock with newly created symlinks
      nilfs2: fix kernel bug due to missing clearing of checked flag

Sabyrzhan Tasbolatov (1):
      x86/traps: move kmsan check after instrumentation_begin

Selvin Xavier (2):
      RDMA/bnxt_re: Fix the usage of control path spin locks
      RDMA/bnxt_re: synchronize the qp-handle table array

Shawn Wang (1):
      sched/numa: Fix the potential null pointer dereference in task_numa_work()

Shiju Jose (1):
      cxl/events: Fix Trace DRAM Event Record

Srinivasan Shanmugam (1):
      drm/amd/display: Add null checks for 'stream' and 'plane' before dereferencing

Stefan Kerkmann (1):
      Input: xpad - add support for 8BitDo Ultimate 2C Wireless Controller

Sungwoo Kim (1):
      Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs

Toke Høiland-Jørgensen (1):
      bpf, test_run: Fix LIVE_FRAME frame update after a page has been recycled

Ville Syrjälä (1):
      wifi: iwlegacy: Clear stale interrupts before resuming device

Vitaliy Shevtsov (1):
      nvmet-auth: assign dh_key to NULL after kfree_sensitive

Wang Liang (1):
      net: fix crash when config small gso_max_size/gso_ipv4_max_size

WangYuli (1):
      riscv: Use '%u' to format the output of 'cpu'

Wladislav Wiebe (1):
      tools/mm: -Werror fixes in page-types/slabinfo

Xinyu Zhang (1):
      block: fix sanity checks in blk_rq_map_user_bvec

Xiongfeng Wang (1):
      firmware: arm_sdei: Fix the input parameter of cpuhp_remove_state()

Xiu Jianfeng (1):
      cgroup: Fix potential overflow issue when checking max_depth

Yonghong Song (1):
      selftests/bpf: Add bpf_percpu_obj_{new,drop}() macro in bpf_experimental.h

Yunhui Cui (1):
      RISC-V: ACPI: fix early_ioremap to early_memremap

Zhang Rui (2):
      thermal: intel: int340x: processor: Remove MMIO RAPL CPU hotplug support
      thermal: intel: int340x: processor: Add MMIO RAPL PL4 support

Zichen Xie (1):
      netdevsim: Add trailing zero to terminate the string in nsim_nexthop_bucket_activity_write()

Zicheng Qu (2):
      staging: iio: frequency: ad9832: fix division by zero in ad9832_calc_freqreg()
      iio: adc: ad7124: fix division by zero in ad7124_set_channel_odr()

Zijun Hu (1):
      usb: phy: Fix API devm_usb_put_phy() can not release the phy

Zong-Zhe Yang (1):
      wifi: mac80211: fix NULL dereference at band check in starting tx ba session

Zongmin Zhou (1):
      usbip: tools: Fix detach_port() invalid port error path

Zqiang (1):
      rcu-tasks: Fix access non-existent percpu rtpcp variable in rcu_tasks_need_gpcb()

lei lu (1):
      ntfs3: Add bounds checking to mi_enum_attr()


