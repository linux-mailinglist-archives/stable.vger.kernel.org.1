Return-Path: <stable+bounces-119834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4EAA47E0B
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 13:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15058161E19
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 12:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE7E2222BA;
	Thu, 27 Feb 2025 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CRWNDAkL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74921270040;
	Thu, 27 Feb 2025 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660133; cv=none; b=HfD91CoT1Gy7Sfjzbu1mqHHY9ELMjkkxv6bhnd1ejJz5vq5KWIdJrXqhU9mkxRhrfn4NvMfqnzm1z5ezPbzn1ugKLBy/ky6toeiqy3ExDC1zptS00KQuoT8jWK1BzZPcEoFe+53jN21xpsSFLdkFPzrqMIpY5q10UQVNmNm9rcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660133; c=relaxed/simple;
	bh=ckgmKyL9NgmaWwxGrJFbpWUL/m40gO/bAhSUetqukIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UtiJ8QuZOYM88uEKeX0uERBg5ncuBAwN10UiM0ivFIj83bBlk/zqDBVOtFHu5ffIbDTByiwF6VhE+4YR997vUSmrdToWp1VCRQl26swR9F+badilarFeAv0O0V5fPuUL31NtMnO7AlbP7z+0JXlWweigmYYdl4m/NtZ8a7P5BEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CRWNDAkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67CEC4CEDD;
	Thu, 27 Feb 2025 12:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740660132;
	bh=ckgmKyL9NgmaWwxGrJFbpWUL/m40gO/bAhSUetqukIQ=;
	h=From:To:Cc:Subject:Date:From;
	b=CRWNDAkLLH00cMaSJxkHLg2F7wTaJPPD0URLug8Q7w0YmZFvwYjwpVP5hMaQ0FcyB
	 apOhtoLZVBeuKFPeWj7yaI/D5su/F9HpzENnTXRS3KQdlFvQriu33Xy/d9xvQug6dB
	 MPnYfqCOEQHcckkSBV26RHZ0zukhFvO1BafeUUdA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.80
Date: Thu, 27 Feb 2025 04:41:01 -0800
Message-ID: <2025022702-sarcastic-floral-af7f@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.80 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/networking/strparser.rst                       |    9 
 Makefile                                                     |    2 
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                     |    1 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                         |  213 ++++----
 arch/arm64/boot/dts/qcom/sm8550.dtsi                         |  265 +++++------
 arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts |    6 
 arch/arm64/include/asm/mman.h                                |    9 
 arch/powerpc/include/asm/book3s/64/hash-4k.h                 |   28 +
 arch/powerpc/include/asm/book3s/64/pgtable.h                 |   26 -
 arch/powerpc/lib/code-patching.c                             |    2 
 arch/x86/Kconfig                                             |    3 
 arch/x86/events/intel/core.c                                 |   17 
 arch/x86/include/asm/perf_event.h                            |   26 +
 arch/x86/kernel/cpu/bugs.c                                   |   21 
 drivers/bluetooth/btqca.c                                    |  110 +++-
 drivers/cpufreq/Kconfig                                      |    2 
 drivers/cpufreq/cpufreq-dt-platdev.c                         |    1 
 drivers/edac/qcom_edac.c                                     |    4 
 drivers/firmware/qcom_scm.c                                  |    5 
 drivers/gpu/drm/i915/display/intel_display.c                 |   18 
 drivers/gpu/drm/i915/display/intel_dp_link_training.c        |   15 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                  |    3 
 drivers/gpu/drm/msm/msm_drv.h                                |   11 
 drivers/gpu/drm/msm/msm_gem.c                                |    6 
 drivers/gpu/drm/msm/msm_gem_submit.c                         |   39 -
 drivers/gpu/drm/nouveau/nouveau_svm.c                        |    9 
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c              |    2 
 drivers/gpu/drm/tidss/tidss_dispc.c                          |   22 
 drivers/gpu/drm/tidss/tidss_irq.c                            |    2 
 drivers/input/mouse/synaptics.c                              |   56 +-
 drivers/input/mouse/synaptics.h                              |    1 
 drivers/md/md-bitmap.c                                       |   34 -
 drivers/md/md-bitmap.h                                       |    9 
 drivers/md/md-cluster.c                                      |   34 -
 drivers/md/md.c                                              |  185 +++----
 drivers/md/md.h                                              |    5 
 drivers/media/usb/uvc/uvc_ctrl.c                             |   99 +++-
 drivers/media/usb/uvc/uvc_v4l2.c                             |    2 
 drivers/media/usb/uvc/uvcvideo.h                             |    9 
 drivers/mtd/nand/raw/cadence-nand-controller.c               |   42 +
 drivers/net/ethernet/ibm/ibmvnic.c                           |   85 ++-
 drivers/net/ethernet/ibm/ibmvnic.h                           |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c            |    4 
 drivers/net/ethernet/netronome/nfp/bpf/cmsg.c                |    2 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c            |    1 
 drivers/net/geneve.c                                         |   16 
 drivers/net/gtp.c                                            |    5 
 drivers/nvme/host/ioctl.c                                    |    3 
 drivers/nvmem/core.c                                         |   32 -
 drivers/nvmem/imx-ocotp-ele.c                                |   22 
 drivers/nvmem/imx-ocotp.c                                    |   11 
 drivers/nvmem/internals.h                                    |   37 +
 drivers/nvmem/layouts/onie-tlv.c                             |    3 
 drivers/nvmem/layouts/sl28vpd.c                              |    3 
 drivers/nvmem/mtk-efuse.c                                    |   11 
 drivers/power/supply/da9150-fg.c                             |    4 
 drivers/s390/net/ism_drv.c                                   |   14 
 drivers/scsi/scsi_lib.c                                      |    8 
 drivers/scsi/sd.c                                            |    4 
 drivers/soc/loongson/loongson2_guts.c                        |    5 
 drivers/soc/mediatek/mtk-devapc.c                            |    7 
 drivers/tee/optee/supp.c                                     |   35 -
 drivers/usb/gadget/function/f_midi.c                         |    2 
 drivers/usb/gadget/udc/core.c                                |   11 
 fs/nilfs2/dir.c                                              |   24 
 fs/nilfs2/namei.c                                            |   37 -
 fs/nilfs2/nilfs.h                                            |   10 
 fs/smb/client/smb2ops.c                                      |    4 
 fs/xfs/libxfs/xfs_ag.c                                       |   47 -
 fs/xfs/libxfs/xfs_ag.h                                       |    6 
 fs/xfs/libxfs/xfs_alloc.c                                    |    9 
 fs/xfs/libxfs/xfs_alloc.h                                    |    4 
 fs/xfs/libxfs/xfs_attr.c                                     |  190 +++----
 fs/xfs/libxfs/xfs_attr_leaf.c                                |   40 -
 fs/xfs/libxfs/xfs_attr_leaf.h                                |    2 
 fs/xfs/libxfs/xfs_bmap.c                                     |  140 +----
 fs/xfs/libxfs/xfs_da_btree.c                                 |    5 
 fs/xfs/libxfs/xfs_inode_fork.c                               |   10 
 fs/xfs/libxfs/xfs_rtbitmap.c                                 |    2 
 fs/xfs/xfs_buf_item_recover.c                                |   70 ++
 fs/xfs/xfs_filestream.c                                      |   96 +--
 fs/xfs/xfs_fsops.c                                           |   18 
 fs/xfs/xfs_icache.c                                          |   39 -
 fs/xfs/xfs_inode.c                                           |    2 
 fs/xfs/xfs_inode.h                                           |    5 
 fs/xfs/xfs_ioctl.c                                           |    4 
 fs/xfs/xfs_log.h                                             |    1 
 fs/xfs/xfs_log_cil.c                                         |   11 
 fs/xfs/xfs_log_recover.c                                     |    9 
 fs/xfs/xfs_mount.c                                           |    4 
 fs/xfs/xfs_qm_bhv.c                                          |   41 +
 fs/xfs/xfs_reflink.c                                         |    3 
 fs/xfs/xfs_reflink.h                                         |   19 
 fs/xfs/xfs_super.c                                           |   11 
 include/linux/netdevice.h                                    |    2 
 include/linux/nvmem-provider.h                               |   17 
 include/linux/serio.h                                        |    3 
 include/linux/skmsg.h                                        |    2 
 include/net/strparser.h                                      |    2 
 include/net/tcp.h                                            |   22 
 include/trace/events/oom.h                                   |   36 +
 io_uring/io_uring.c                                          |    2 
 kernel/acct.c                                                |  134 +++--
 kernel/bpf/bpf_cgrp_storage.c                                |    2 
 kernel/bpf/ringbuf.c                                         |    4 
 kernel/bpf/syscall.c                                         |   43 -
 kernel/trace/ftrace.c                                        |    3 
 kernel/trace/trace_functions.c                               |    6 
 lib/iov_iter.c                                               |    3 
 mm/madvise.c                                                 |   11 
 mm/memcontrol.c                                              |    7 
 mm/oom_kill.c                                                |   14 
 net/bpf/test_run.c                                           |    5 
 net/core/dev.c                                               |   37 +
 net/core/drop_monitor.c                                      |   29 -
 net/core/flow_dissector.c                                    |   49 +-
 net/core/skmsg.c                                             |    7 
 net/core/sock_map.c                                          |    8 
 net/ipv4/arp.c                                               |    2 
 net/ipv4/tcp.c                                               |   29 -
 net/ipv4/tcp_bpf.c                                           |   36 +
 net/ipv4/tcp_fastopen.c                                      |    4 
 net/ipv4/tcp_input.c                                         |   20 
 net/ipv4/tcp_ipv4.c                                          |    2 
 net/sched/cls_api.c                                          |    2 
 net/strparser/strparser.c                                    |   11 
 net/vmw_vsock/af_vsock.c                                     |    3 
 net/vmw_vsock/vsock_bpf.c                                    |    2 
 sound/core/seq/seq_clientmgr.c                               |   12 
 sound/pci/hda/hda_codec.c                                    |    4 
 sound/pci/hda/patch_conexant.c                               |    1 
 sound/pci/hda/patch_cs8409-tables.c                          |    6 
 sound/pci/hda/patch_cs8409.c                                 |   20 
 sound/pci/hda/patch_cs8409.h                                 |    5 
 sound/pci/hda/patch_realtek.c                                |    1 
 sound/soc/fsl/fsl_micfil.c                                   |    2 
 sound/soc/rockchip/rockchip_i2s_tdm.c                        |    4 
 sound/soc/sh/rz-ssi.c                                        |    2 
 sound/soc/sof/pcm.c                                          |    2 
 sound/soc/sof/stream-ipc.c                                   |    6 
 140 files changed, 1935 insertions(+), 1233 deletions(-)

Aaron Kling (1):
      drm/nouveau/pmu: Fix gp10b firmware guard

Abel Wu (1):
      bpf: Fix deadlock when freeing cgroup storage

Andreas Kemnade (1):
      cpufreq: fix using cpufreq-dt as module

Andrew Kreimer (1):
      xfs: fix a typo

Andrey Vatoropin (1):
      power: supply: da9150-fg: fix potential overflow

Andrii Nakryiko (2):
      bpf: unify VM_WRITE vs VM_MAYWRITE use in BPF map mmaping logic
      bpf: avoid holding freeze_mutex during mmap operation

Breno Leitao (2):
      net: Add non-RCU dev_getbyhwaddr() helper
      arp: switch to dev_getbyhwaddr() in arp_req_set_public()

Brian Foster (2):
      xfs: skip background cowblock trims on inodes open for write
      xfs: don't free cowblocks from under dirty pagecache on unshare

Caleb Sander Mateos (1):
      nvme/ioctl: add missing space in err message

Carlos Galo (1):
      mm: update mark_victim tracepoints fields

Catalin Marinas (1):
      arm64: mte: Do not allow PROT_MTE on MAP_HUGETLB user mappings

Chen Ridong (1):
      memcg: fix soft lockup in the OOM process

Chen-Yu Tsai (1):
      arm64: dts: mediatek: mt8183: Disable DSI display output by default

Cheng Jiang (1):
      Bluetooth: qca: Update firmware-name to support board specific nvm

Chi Zhiling (1):
      xfs: Reduce unnecessary searches when searching for the best extents

Christian Brauner (2):
      acct: perform last write from workqueue
      acct: block access to kernel internal filesystems

Christoph Hellwig (15):
      xfs: assert a valid limit in xfs_rtfind_forw
      xfs: merge xfs_attr_leaf_try_add into xfs_attr_leaf_addname
      xfs: return bool from xfs_attr3_leaf_add
      xfs: distinguish extra split from real ENOSPC from xfs_attr3_leaf_split
      xfs: distinguish extra split from real ENOSPC from xfs_attr_node_try_addname
      xfs: fold xfs_bmap_alloc_userdata into xfs_bmapi_allocate
      xfs: don't ifdef around the exact minlen allocations
      xfs: call xfs_bmap_exact_minlen_extent_alloc from xfs_bmap_btalloc
      xfs: support lowmode allocations in xfs_bmap_exact_minlen_extent_alloc
      xfs: pass the exact range to initialize to xfs_initialize_perag
      xfs: update the file system geometry after recoverying superblock buffers
      xfs: error out when a superblock buffer update reduces the agcount
      xfs: don't use __GFP_RETRY_MAYFAIL in xfs_initialize_perag
      xfs: update the pag for the last AG at recovery time
      xfs: streamline xfs_filestream_pick_ag

Christophe Leroy (2):
      powerpc/64s: Rewrite __real_pte() and __rpte_to_hidx() as static inline
      powerpc/code-patching: Fix KASAN hit by not flagging text patching area as VM_ALLOC

Cong Wang (2):
      flow_dissector: Fix handling of mixed port and port-range keys
      flow_dissector: Fix port range key handling in BPF conversion

Cosmin Ratiu (1):
      net/mlx5e: Don't call cleanup on profile rollback failure

Dan Carpenter (2):
      ASoC: renesas: rz-ssi: Add a check for negative sample_space
      drm/msm/gem: prevent integer overflow in msm_ioctl_gem_submit()

Darrick J. Wong (4):
      xfs: validate inumber in xfs_iget
      xfs: fix a sloppy memory handling bug in xfs_iroot_realloc
      xfs: report realtime block quota limits on realtime directories
      xfs: don't over-report free space or inodes in statvfs

David Hildenbrand (1):
      nouveau/svm: fix missing folio unlock + put after make_device_exclusive_range()

Devarsh Thakkar (1):
      drm/tidss: Fix race condition while handling interrupt registers

Dmitry Torokhov (2):
      Input: serio - define serio_pause_rx guard to pause and resume serio ports
      Input: synaptics - fix crash when enabling pass-through port

Douglas Gilbert (1):
      scsi: core: Handle depopulation and restoration in progress

Gavrilov Ilia (1):
      drop_monitor: fix incorrect initialization order

Greg Kroah-Hartman (1):
      Linux 6.6.80

Haoxiang Li (3):
      soc: loongson: loongson2_guts: Add check for devm_kstrdup()
      nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()
      smb: client: Add check for next_buffer in receive_encrypted_standard()

Igor Pylypiv (1):
      scsi: core: Do not retry I/Os during depopulation

Imre Deak (1):
      drm/i915/dp: Fix error handling during 128b/132b link training

Jakub Kicinski (1):
      tcp: adjust rcvq_space after updating scaling ratio

Jeff Johnson (1):
      cpufreq: dt-platdev: add missing MODULE_DESCRIPTION() macro

Jessica Zhang (1):
      drm/msm/dpu: Disable dither in phys encoder cleanup

Jiayuan Chen (3):
      strparser: Add read_sock callback
      bpf: Fix wrong copied_seq calculation
      bpf: Disable non stream socket for strparser

Jill Donahue (1):
      USB: gadget: f_midi: f_midi_complete to call queue_work

John Keeping (1):
      ASoC: rockchip: i2s-tdm: fix shift config for SND_SOC_DAIFMT_DSP_[AB]

John Veness (1):
      ALSA: hda/conexant: Add quirk for HP ProBook 450 G4 mute LED

Julian Ruess (1):
      s390/ism: add release function for struct device

Kailang Yang (1):
      ALSA: hda/realtek: Fixup ALC225 depop procedure

Kan Liang (1):
      perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF

Komal Bajaj (1):
      EDAC/qcom: Correct interrupt enable register configuration

Krzysztof Kozlowski (4):
      firmware: qcom: scm: Fix missing read barrier in qcom_scm_is_available()
      arm64: dts: qcom: sm8450: Fix ADSP memory base and length
      arm64: dts: qcom: sm8550: Fix ADSP memory base and length
      soc: mediatek: mtk-devapc: Fix leaking IO map on driver remove

Kuniyuki Iwashima (3):
      geneve: Fix use-after-free in geneve_find_dev().
      gtp: Suppress list corruption splat in gtp_net_exit_batch_rtnl().
      geneve: Suppress list corruption splat in geneve_destroy_tunnels().

Ling Xu (1):
      arm64: dts: qcom: sm8550: Add dma-coherent property

Michael Ellerman (1):
      powerpc/64s/mm: Move __real_pte stubs into hash-4k.h

Michal Luczaj (2):
      sockmap, vsock: For connectible sockets allow only connected
      vsock/bpf: Warn on socket without transport

Miquel Raynal (3):
      nvmem: Create a header for internal sharing
      nvmem: Simplify the ->add_cells() hook
      nvmem: Move and rename ->fixup_cell_info()

Neil Armstrong (2):
      arm64: dts: qcom: sm8450: add missing qcom,non-secure-domain property
      arm64: dts: qcom: sm8550: add missing qcom,non-secure-domain property

Nick Child (4):
      ibmvnic: Return error code on TX scrq flush fail
      ibmvnic: Introduce send sub-crq direct
      ibmvnic: Add stat for tx direct vs tx batched
      ibmvnic: Don't reference skb after sending to VIOS

Nick Hu (1):
      net: axienet: Set mac_managed_pm

Nikita Zhandarovich (1):
      ASoC: fsl_micfil: Enable default case in micfil_set_quality()

Niravkumar L Rabara (3):
      mtd: rawnand: cadence: fix error code in cadence_nand_init()
      mtd: rawnand: cadence: use dma_map_resource for sdma address
      mtd: rawnand: cadence: fix incorrect device in dma_unmap_single

Ojaswin Mujoo (1):
      xfs: Check for delayed allocations before setting extsize

Patrick Bellasi (1):
      x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit

Pavel Begunkov (2):
      io_uring: prevent opcode speculation
      lib/iov_iter: fix import_iovec_ubuf iovec management

Peter Ujfalusi (2):
      ASoC: SOF: stream-ipc: Check for cstream nullity in sof_ipc_msg_data()
      ASoC: SOF: pcm: Clear the susbstream pointer to NULL on close

Pierre Riteau (1):
      net/sched: cls_api: fix error handling causing NULL dereference

Ricardo Cañuelo Navarro (1):
      mm,madvise,hugetlb: check for 0-length range after end address adjustment

Ricardo Ribalda (3):
      media: uvcvideo: Refactor iterators
      media: uvcvideo: Only save async fh if success
      media: uvcvideo: Remove dangling pointers

Rob Clark (2):
      drm/msm/gem: Demote userspace errors to DRM_UT_DRIVER
      drm/msm: Avoid rounding up to one jiffy

Roy Luo (2):
      USB: gadget: core: create sysfs link between udc and gadget
      usb: gadget: core: flush gadget workqueue after device removal

Ryusuke Konishi (3):
      nilfs2: move page release outside of nilfs_delete_entry and nilfs_set_link
      nilfs2: eliminate staggered calls to kunmap in nilfs_rename
      nilfs2: handle errors that nilfs_prepare_chunk() may return

Sabrina Dubroca (1):
      tcp: drop secpath at the same time as we currently drop dst

Sascha Hauer (1):
      nvmem: imx-ocotp-ele: fix MAC address byte order

Sebastian Andrzej Siewior (1):
      ftrace: Correct preemption accounting for function tracing.

Shigeru Yoshida (1):
      bpf, test_run: Fix use-after-free issue in eth_skb_pkt_type()

Steven Rostedt (1):
      ftrace: Do not add duplicate entries in subops manager ops

Sumit Garg (1):
      tee: optee: Fix supplicant wait loop

Takashi Iwai (1):
      ALSA: seq: Drop UMP events when no UMP-conversion is set

Tianling Shen (1):
      arm64: dts: rockchip: change eth phy mode to rgmii-id for orangepi r1 plus lts

Tomi Valkeinen (1):
      drm/tidss: Add simple K2G manual reset

Uros Bizjak (1):
      xfs: Use try_cmpxchg() in xlog_cil_insert_pcp_aggregate()

Uwe Kleine-König (1):
      soc/mediatek: mtk-devapc: Convert to platform remove callback returning void

Ville Syrjälä (1):
      drm/i915: Make sure all planes in use by the joiner have their crtc included

Vitaly Rodionov (1):
      ALSA: hda/cirrus: Correct the full scale volume set logic

Wentao Liang (1):
      ALSA: hda: Add error check for snd_ctl_rename_id() in snd_hda_create_dig_out_ctls()

Yan Zhai (1):
      bpf: skip non exist keys in generic_map_lookup_batch

Yu Kuai (9):
      md: use separate work_struct for md_start_sync()
      md: factor out a helper from mddev_put()
      md: simplify md_seq_ops
      md/md-bitmap: replace md_bitmap_status() with a new helper md_bitmap_get_stats()
      md/md-cluster: fix spares warnings for __le64
      md/md-bitmap: add 'sync_size' into struct md_bitmap_stats
      md/md-bitmap: Synchronize bitmap_get_stats() with bitmap lifetime
      md: fix missing flush of sync_work
      md: Fix md_seq_ops() regressions

Zhang Zekun (1):
      xfs: Remove empty declartion in header file

Zijun Hu (2):
      Bluetooth: qca: Support downloading board id specific NVM for WCN7850
      Bluetooth: qca: Fix poor RF performance for WCN6855


