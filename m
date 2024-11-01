Return-Path: <stable+bounces-89465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6909B886B
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 02:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA4C1C21DD6
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 01:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1521013211F;
	Fri,  1 Nov 2024 01:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NZWUxWD5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4238130AF6;
	Fri,  1 Nov 2024 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424411; cv=none; b=h6tjWyCiRGrb7cZiFiq5w+V1MH3CYxjpkFeNpsEeUfxF8wrHxZPnHtpQ1tJoSrrhIfO5s70tbYr6N/SACN3aIq3SPMx2P5xWNrH5oiKhBtOvfi5ERn4ocKDHcbOU57IpcYdde2GUzJ4X+r90y6x6nJDfac9pHT8w+XtvJGrubEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424411; c=relaxed/simple;
	bh=ibhMzT96PYFz0eZeyDW5+8ABm3gbwBnANcTXOR8Z5EE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P/88duJNqoFG0GRYWDz5DHkBkhUT7Furn2jEJzEXcMuXqQIkgcWJTuyxlASSmD9ACxv+tDLp6ItP1YWAuILAd0IoaBG1WVL9BI0F2sEjidGWvCa5/AByqlLRmAHP9GtUKEqAGGa/pWVO2kch4Pb6XVp1tUF/YjcH6zAe1JcsvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NZWUxWD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA6EC4CED2;
	Fri,  1 Nov 2024 01:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730424411;
	bh=ibhMzT96PYFz0eZeyDW5+8ABm3gbwBnANcTXOR8Z5EE=;
	h=From:To:Cc:Subject:Date:From;
	b=NZWUxWD5XAKBORr+PJ7BtbYciXh6NdYArkzASxCtPmop4b3mggYiODYqum396Lrrk
	 uHcS7UIdhY3IlgsVpuSS5PK2PBkpkC3SnWAMBsATcBAh7jvlrDkupa5MMVSKaFz6dR
	 uUiAgI1k/pxleMnJZdhpjUYbfVUyVoVUTz5XMuf0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.59
Date: Fri,  1 Nov 2024 02:26:25 +0100
Message-ID: <2024110126-sludge-much-f0b4@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.59 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml       |   18 
 Makefile                                                               |    2 
 arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts                     |    2 
 arch/arm64/Makefile                                                    |    2 
 arch/arm64/kvm/arm.c                                                   |    3 
 arch/arm64/kvm/sys_regs.c                                              |    2 
 arch/arm64/kvm/vgic/vgic-init.c                                        |    6 
 arch/loongarch/include/asm/bootinfo.h                                  |    4 
 arch/loongarch/include/asm/kasan.h                                     |    2 
 arch/loongarch/kernel/process.c                                        |   16 
 arch/loongarch/kernel/setup.c                                          |    3 
 arch/loongarch/kernel/traps.c                                          |    5 
 arch/riscv/net/bpf_jit_comp64.c                                        |    4 
 arch/s390/include/asm/perf_event.h                                     |    1 
 arch/s390/pci/pci_event.c                                              |   17 
 arch/x86/Kconfig                                                       |    1 
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c                              |   23 
 arch/x86/kvm/svm/nested.c                                              |    6 
 drivers/accel/qaic/qaic_control.c                                      |    2 
 drivers/accel/qaic/qaic_data.c                                         |    6 
 drivers/acpi/button.c                                                  |   11 
 drivers/acpi/cppc_acpi.c                                               |  116 ++++
 drivers/acpi/prmt.c                                                    |   29 -
 drivers/acpi/resource.c                                                |    7 
 drivers/ata/libata-eh.c                                                |    1 
 drivers/cdrom/cdrom.c                                                  |    2 
 drivers/cpufreq/amd-pstate.c                                           |   10 
 drivers/cpufreq/cppc_cpufreq.c                                         |  139 -----
 drivers/firmware/arm_scmi/driver.c                                     |    4 
 drivers/firmware/arm_scmi/mailbox.c                                    |   32 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                               |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                                |    5 
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c              |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c                               |   17 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                            |    9 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c                   |    2 
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c                      |   19 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                     |    4 
 drivers/gpu/drm/vboxvideo/hgsmi_base.c                                 |   10 
 drivers/gpu/drm/vboxvideo/vboxvideo.h                                  |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c                                   |    4 
 drivers/iio/accel/bma400_core.c                                        |    3 
 drivers/iio/adc/Kconfig                                                |    2 
 drivers/iio/frequency/Kconfig                                          |   33 -
 drivers/infiniband/core/addr.c                                         |    2 
 drivers/infiniband/hw/bnxt_re/hw_counters.c                            |    6 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                               |   48 +
 drivers/infiniband/hw/bnxt_re/main.c                                   |   42 -
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                               |    4 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                               |    2 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                             |    4 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                              |   23 
 drivers/infiniband/hw/bnxt_re/qplib_res.h                              |   20 
 drivers/infiniband/hw/bnxt_re/qplib_sp.c                               |   22 
 drivers/infiniband/hw/bnxt_re/qplib_sp.h                               |    1 
 drivers/infiniband/hw/cxgb4/cm.c                                       |    9 
 drivers/infiniband/hw/irdma/cm.c                                       |    2 
 drivers/infiniband/ulp/srpt/ib_srpt.c                                  |   80 ++-
 drivers/irqchip/irq-renesas-rzg2l.c                                    |   94 +++
 drivers/net/dsa/mv88e6xxx/chip.c                                       |    2 
 drivers/net/dsa/mv88e6xxx/chip.h                                       |    6 
 drivers/net/dsa/mv88e6xxx/port.c                                       |    1 
 drivers/net/dsa/mv88e6xxx/ptp.c                                        |  108 ++--
 drivers/net/ethernet/aeroflex/greth.c                                  |    3 
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c                       |    1 
 drivers/net/ethernet/broadcom/bcmsysport.c                             |    1 
 drivers/net/ethernet/emulex/benet/be_main.c                            |   10 
 drivers/net/ethernet/freescale/fman/mac.c                              |   68 +-
 drivers/net/ethernet/freescale/fman/mac.h                              |    6 
 drivers/net/ethernet/i825xx/sun3_82586.c                               |    1 
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c                      |   82 ++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                    |    4 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                          |    8 
 drivers/net/ethernet/mellanox/mlx5/core/eq.c                           |    6 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                      |    5 
 drivers/net/ethernet/realtek/r8169_main.c                              |    4 
 drivers/net/ethernet/renesas/ravb_main.c                               |   25 
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c                      |   14 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                      |    2 
 drivers/net/hyperv/netvsc_drv.c                                        |   30 +
 drivers/net/macsec.c                                                   |   18 
 drivers/net/netdevsim/dev.c                                            |   15 
 drivers/net/phy/dp83822.c                                              |    4 
 drivers/net/plip/plip.c                                                |    2 
 drivers/net/usb/usbnet.c                                               |    4 
 drivers/net/vmxnet3/vmxnet3_xdp.c                                      |    2 
 drivers/net/wwan/wwan_core.c                                           |    2 
 drivers/nvme/host/pci.c                                                |   21 
 drivers/platform/x86/dell/dell-wmi-base.c                              |    9 
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c                     |    1 
 drivers/powercap/dtpm_devfreq.c                                        |    2 
 drivers/target/target_core_device.c                                    |    2 
 drivers/target/target_core_user.c                                      |    2 
 drivers/usb/dwc3/core.c                                                |   19 
 drivers/usb/dwc3/core.h                                                |    3 
 drivers/usb/gadget/function/f_uac2.c                                   |   13 
 drivers/usb/host/xhci-caps.h                                           |   85 +++
 drivers/usb/host/xhci-dbgcap.h                                         |    2 
 drivers/usb/host/xhci-dbgtty.c                                         |   73 ++
 drivers/usb/host/xhci-port.h                                           |  176 ++++++
 drivers/usb/host/xhci.h                                                |  262 ----------
 drivers/usb/typec/class.c                                              |    3 
 fs/btrfs/block-group.c                                                 |    2 
 fs/btrfs/dir-item.c                                                    |    4 
 fs/btrfs/inode.c                                                       |    7 
 fs/exec.c                                                              |   21 
 fs/jfs/jfs_dmap.c                                                      |    2 
 fs/nfsd/nfs4state.c                                                    |    2 
 fs/nilfs2/page.c                                                       |    6 
 fs/open.c                                                              |    2 
 fs/smb/client/fs_context.c                                             |    7 
 fs/smb/client/reparse.c                                                |   23 
 fs/smb/client/smb2ops.c                                                |    3 
 fs/smb/client/smb2pdu.c                                                |    9 
 fs/udf/balloc.c                                                        |   38 -
 fs/udf/directory.c                                                     |   23 
 fs/udf/inode.c                                                         |  202 +++++--
 fs/udf/partition.c                                                     |    6 
 fs/udf/super.c                                                         |    3 
 fs/udf/truncate.c                                                      |   43 +
 fs/udf/udfdecl.h                                                       |   15 
 include/acpi/cppc_acpi.h                                               |    2 
 include/linux/bpf.h                                                    |   14 
 include/linux/memcontrol.h                                             |   14 
 include/linux/netdevice.h                                              |   12 
 include/linux/task_work.h                                              |    6 
 include/linux/trace_events.h                                           |    6 
 include/net/bluetooth/bluetooth.h                                      |    1 
 include/net/genetlink.h                                                |    3 
 include/net/sock.h                                                     |    5 
 include/net/xfrm.h                                                     |   28 -
 include/trace/events/huge_memory.h                                     |   10 
 include/uapi/linux/bpf.h                                               |   20 
 kernel/bpf/btf.c                                                       |    1 
 kernel/bpf/devmap.c                                                    |   11 
 kernel/bpf/helpers.c                                                   |   10 
 kernel/bpf/ringbuf.c                                                   |    2 
 kernel/bpf/syscall.c                                                   |   47 +
 kernel/bpf/task_iter.c                                                 |    2 
 kernel/bpf/verifier.c                                                  |   99 +--
 kernel/sched/core.c                                                    |    4 
 kernel/task_work.c                                                     |   43 +
 kernel/time/posix-clock.c                                              |    6 
 kernel/trace/bpf_trace.c                                               |   11 
 kernel/trace/trace.c                                                   |    1 
 kernel/trace/trace_eprobe.c                                            |   15 
 kernel/trace/trace_fprobe.c                                            |   65 +-
 kernel/trace/trace_kprobe.c                                            |   78 ++
 kernel/trace/trace_probe.c                                             |  189 ++++++-
 kernel/trace/trace_probe.h                                             |   30 +
 kernel/trace/trace_probe_tmpl.h                                        |   10 
 kernel/trace/trace_uprobe.c                                            |  114 ++--
 lib/Kconfig.debug                                                      |    2 
 mm/khugepaged.c                                                        |  127 ++--
 net/bluetooth/af_bluetooth.c                                           |   22 
 net/bluetooth/bnep/core.c                                              |    3 
 net/bluetooth/iso.c                                                    |   18 
 net/bluetooth/sco.c                                                    |   18 
 net/core/filter.c                                                      |   50 -
 net/core/sock_map.c                                                    |    8 
 net/ipv4/devinet.c                                                     |   35 -
 net/ipv4/inet_connection_sock.c                                        |   21 
 net/ipv4/xfrm4_policy.c                                                |   40 -
 net/ipv6/xfrm6_policy.c                                                |   31 -
 net/l2tp/l2tp_netlink.c                                                |    4 
 net/netfilter/nf_bpf_link.c                                            |    7 
 net/netfilter/xt_NFLOG.c                                               |    2 
 net/netfilter/xt_TRACE.c                                               |    1 
 net/netfilter/xt_mark.c                                                |    2 
 net/netlink/genetlink.c                                                |   28 -
 net/sched/act_api.c                                                    |   23 
 net/sched/sch_generic.c                                                |   17 
 net/sched/sch_taprio.c                                                 |   21 
 net/smc/smc_pnet.c                                                     |    2 
 net/smc/smc_wr.c                                                       |    6 
 net/vmw_vsock/virtio_transport_common.c                                |   14 
 net/vmw_vsock/vsock_bpf.c                                              |    8 
 net/wireless/nl80211.c                                                 |    8 
 net/xfrm/xfrm_device.c                                                 |   11 
 net/xfrm/xfrm_policy.c                                                 |   50 +
 net/xfrm/xfrm_user.c                                                   |   10 
 security/selinux/selinuxfs.c                                           |   30 -
 sound/firewire/amdtp-stream.c                                          |    3 
 sound/pci/hda/Kconfig                                                  |    2 
 sound/pci/hda/patch_cs8409.c                                           |    5 
 sound/pci/hda/patch_realtek.c                                          |   48 +
 sound/soc/amd/yc/acp6x-mach.c                                          |    7 
 sound/soc/codecs/lpass-rx-macro.c                                      |    2 
 sound/soc/codecs/max98388.c                                            |    1 
 sound/soc/fsl/fsl_micfil.c                                             |   43 +
 sound/soc/fsl/fsl_sai.c                                                |    5 
 sound/soc/fsl/fsl_sai.h                                                |    1 
 sound/soc/loongson/loongson_card.c                                     |    1 
 sound/soc/qcom/lpass-cpu.c                                             |    2 
 sound/soc/qcom/sm8250.c                                                |    1 
 sound/soc/sh/rcar/core.c                                               |    7 
 tools/include/uapi/linux/bpf.h                                         |    7 
 tools/testing/selftests/bpf/Makefile                                   |    2 
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c                |   69 +-
 tools/testing/selftests/bpf/progs/verifier_helper_value_access.c       |    8 
 tools/testing/selftests/bpf/progs/verifier_raw_stack.c                 |    2 
 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    2 
 203 files changed, 2729 insertions(+), 1460 deletions(-)

Abhishek Mohapatra (1):
      RDMA/bnxt_re: Fix the max CQ WQEs for older adapters

Aleksa Sarai (1):
      openat2: explicitly return -E2BIG for (usize > PAGE_SIZE)

Aleksandr Mishin (4):
      octeon_ep: Implement helper for iterating packets in Rx queue
      octeon_ep: Add SKB allocation failures handling in __octep_oq_process_rx()
      fsl/fman: Save device references taken in mac_probe()
      fsl/fman: Fix refcount handling of fman-related devices

Alexander Zubkov (1):
      RDMA/irdma: Fix misspelling of "accept*"

Alexey Klimov (2):
      ASoC: codecs: lpass-rx-macro: add missing CDC_RX_BCL_VBAT_RF_PROC2 to default regs values
      ASoC: qcom: sm8250: add qrb4210-rb2-sndcard compatible string

Andrea Parri (1):
      riscv, bpf: Make BPF_CMPXCHG fully ordered

Andrei Matei (1):
      bpf: Simplify checking size of helper accesses

Andrey Shumilin (1):
      ALSA: firewire-lib: Avoid division by zero in apply_constraint_to_size()

Andrii Nakryiko (3):
      uprobes: encapsulate preparation of uprobe args buffer
      uprobes: prepare uprobe args buffer lazily
      uprobes: prevent mutex_lock() under rcu_read_lock()

Anumula Murali Mohan Reddy (2):
      RDMA/core: Fix ENODEV error for iWARP test over vlan
      RDMA/cxgb4: Fix RDMA_CM_EVENT_UNREACHABLE error for iWARP

Armin Wolf (1):
      platform/x86: dell-wmi: Ignore suspend notifications

Bart Van Assche (1):
      RDMA/srpt: Make slab cache names unique

Bhargava Chenna Marreddy (1):
      RDMA/bnxt_re: Fix a bug while setting up Level-2 PBL pages

Binbin Zhou (1):
      ASoC: loongson: Fix component check failed on FDT systems

Chancel Liu (1):
      ASoC: fsl_micfil: Add a flag to distinguish with different volume control types

Christian Heusel (1):
      ACPI: resource: Add LG 16T90SP to irq1_level_low_skip_override[]

Claudiu Beznea (3):
      irqchip/renesas-rzg2l: Align struct member names to tabs
      irqchip/renesas-rzg2l: Document structure members
      irqchip/renesas-rzg2l: Add support for suspend to RAM

Colin Ian King (2):
      octeontx2-af: Fix potential integer overflows on integer shifts
      ASoC: max98388: Fix missing increment of variable slot_found

Cosmin Ratiu (1):
      net/mlx5: Unregister notifier on eswitch init failure

Crag Wang (1):
      platform/x86: dell-sysman: add support for alienware products

Dan Carpenter (1):
      ACPI: PRM: Clean up guid type in struct prm_handler_info

Daniel Borkmann (4):
      vmxnet3: Fix packet corruption in vmxnet3_xdp_xmit_frame
      bpf: Add MEM_WRITE attribute
      bpf: Fix overloading of MEM_UNINIT's meaning
      bpf: Remove MEM_UNINIT from skb/xdp MTU helpers

Dave Kleikamp (1):
      jfs: Fix sanity check in dbMount

David Lawrence Glanzman (1):
      ASoC: amd: yc: Add quirk for HP Dragonfly pro one

Dhananjay Ugwekar (1):
      cpufreq/amd-pstate: Fix amd_pstate mode switch on shared memory systems

Dimitar Kanaliev (1):
      bpf: Fix truncation bug in coerce_reg_to_size_sx()

Dmitry Antipov (2):
      net: sched: fix use-after-free in taprio_change()
      net: sched: use RCU read-side critical section in taprio_dump()

Dmitry Baryshkov (2):
      drm/msm/dpu: make sure phys resources are properly initialized
      drm/msm/dpu: check for overflow in _dpu_crtc_setup_lm_bounds()

Douglas Anderson (2):
      drm/msm: Avoid NULL dereference in msm_disp_state_print_regs()
      drm/msm: Allocate memory for disp snapshot with kvzalloc()

Eric Biggers (1):
      ALSA: hda/tas2781: select CRC32 instead of CRC32_SARWATE

Eric Dumazet (3):
      netdevsim: use cond_resched() in nsim_dev_trap_report_work()
      genetlink: hold RCU in genlmsg_mcast()
      net: fix races in netdev_tx_sent_queue()/dev_watchdog()

Eyal Birger (2):
      xfrm: extract dst lookup parameters into a struct
      xfrm: respect ip protocols rules criteria when performing dst lookups

Fabrizio Castro (1):
      irqchip/renesas-rzg2l: Fix missing put_device

Florian Kauer (1):
      bpf: devmap: provide rxq after redirect

Florian Klink (1):
      ARM: dts: bcm2837-rpi-cm3-io3: Fix HDMI hpd-gpio pin

Florian Westphal (1):
      netfilter: bpf: must hold reference on net namespace

Frank Li (1):
      XHCI: Separate PORT and CAPs macros into dedicated file

Gal Pressman (1):
      ravb: Remove setting of RX software timestamp

Gianfranco Trad (1):
      udf: fix uninit-value use in udf_get_fileshortad

Greg Kroah-Hartman (1):
      Linux 6.6.59

Haiyang Zhang (1):
      hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event

Hans de Goede (1):
      drm/vboxvideo: Replace fake VLA at end of vbva_mouse_pointer_shape with real VLA

Heiko Carstens (1):
      s390: Initialize psw mask in perf_arch_fetch_caller_regs()

Heiner Kallweit (1):
      r8169: avoid unsolicited interrupts

Henrique Carvalho (1):
      smb: client: Handle kstrdup failures for passwords

Huacai Chen (3):
      LoongArch: Get correct cores_per_package for SMT systems
      LoongArch: Enable IRQ if do_ale() triggered in irq-enabled context
      LoongArch: Make KASAN usable for variable cpu_vabits

Ian Forbes (1):
      drm/vmwgfx: Handle possible ENOMEM in vmw_stdu_connector_atomic_check

Ilkka Koskinen (1):
      KVM: arm64: Fix shift-out-of-bounds bug

Jakub Boehm (1):
      net: plip: fix break; causing plip to never transmit

Javier Carrasco (3):
      iio: frequency: {admv4420,adrf6780}: format Kconfig entries
      iio: frequency: admv4420: fix missing select REMAP_SPI in Kconfig
      iio: adc: ti-lmp92064: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig

Jessica Zhang (1):
      drm/msm/dpu: don't always program merge_3d block

Jinjie Ruan (1):
      posix-clock: posix-clock: Fix unbalanced locking in pc_clock_settime()

Jiri Olsa (6):
      bpf: Fix memory leak in bpf_core_apply
      bpf: Add missed value to kprobe perf link info
      bpf: Add cookie to perf_event bpf_link_info records
      selftests/bpf: Use bpf_link__destroy in fill_link_info tests
      selftests/bpf: Add cookies check for perf_event fill_link_info test
      bpf,perf: Fix perf_event_detach_bpf_prog error handling

Jiri Slaby (SUSE) (2):
      xhci: dbgtty: remove kfifo_out() wrapper
      xhci: dbgtty: use kfifo from tty_port struct

John Keeping (1):
      usb: gadget: f_uac2: fix non-newline-terminated function name

Jonathan Marek (2):
      drm/msm/dsi: improve/fix dsc pclk calculation
      drm/msm/dsi: fix 32-bit signed integer extension in pclk_rate calculation

Jordan Rome (1):
      bpf: Fix iter/task tid filtering

Josh Poimboeuf (1):
      cdrom: Avoid barrier_nospec() in cdrom_ioctl_media_changed()

José Relvas (1):
      ALSA: hda/realtek: Add subwoofer quirk for Acer Predator G9-593

Justin Chen (1):
      firmware: arm_scmi: Queue in scmi layer for mailbox implementation

Kai Shen (1):
      net/smc: Fix memory leak when using percpu refs

Kailang Yang (1):
      ALSA: hda/realtek: Update default depop procedure

Kalesh AP (7):
      RDMA/bnxt_re: Fix a possible memory leak
      RDMA/bnxt_re: Add a check for memory allocation
      RDMA/bnxt_re: Fix out of bound check
      RDMA/bnxt_re: Return more meaningful error
      RDMA/bnxt_re: Fix the GID table length
      RDMA/bnxt_re: Avoid creating fence MR for newer adapters
      RDMA/bnxt_re: Fix unconditional fence for newer adapters

Kevin Groeneveld (1):
      usb: gadget: f_uac2: fix return value for UAC2_ATTRIBUTE_STRING store

Koba Ko (1):
      ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM handler and context

Kuniyuki Iwashima (1):
      tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().

Lad Prabhakar (1):
      ASoC: rsnd: Fix probe failure on HiHope boards due to endpoint parsing

Lee Jones (1):
      usb: gadget: f_uac2: Replace snprintf() with the safer scnprintf() variant

Leo Yan (1):
      tracing: Consider the NULL character when validating the event length

Li RongQing (1):
      net/smc: Fix searching in list of known pnetids in smc_pnet_add_pnetid

Lin Ma (1):
      net: wwan: fix global oob in wwan_rtnl_policy

Linus Torvalds (1):
      task_work: make TWA_NMI_CURRENT handling conditional on IRQ_WORK

Luiz Augusto von Dentz (2):
      Bluetooth: SCO: Fix UAF on sco_sock_timeout
      Bluetooth: ISO: Fix UAF on iso_sock_timeout

Maher Sanalla (1):
      net/mlx5: Check for invalid vector index on EQ creation

Marc Zyngier (1):
      KVM: arm64: Don't eagerly teardown the vgic on init error

Mario Limonciello (2):
      drm/amd: Guard against bad data for ATIF ACPI method
      drm/amd/display: Disable PSR-SU on Parade 08-01 TCON too

Mark Rutland (1):
      arm64: Force position-independent veneers

Martin Kletzander (1):
      x86/resctrl: Avoid overflow in MB settings in bw_validate()

Masami Hiramatsu (Google) (4):
      tracing/fprobe-event: cleanup: Fix a wrong comment in fprobe event
      tracing/probes: cleanup: Set trace_probe::nr_args at trace_probe_init
      tracing/probes: Support $argN in return probe (kprobe and fprobe)
      tracing: probes: Fix to zero initialize a local variable

Mateusz Guzik (1):
      exec: don't WARN for racy path_noexec check

Mathias Nyman (1):
      xhci: dbc: honor usb transfer size boundaries.

Matthew Wilcox (Oracle) (5):
      mm: convert collapse_huge_page() to use a folio
      mm/khugepaged: use a folio more in collapse_file()
      khugepaged: inline hpage_collapse_alloc_folio()
      khugepaged: convert alloc_charge_hpage to alloc_charge_folio
      khugepaged: remove hpage from collapse_file()

Maurizio Lombardi (1):
      nvme-pci: fix race condition between reset and nvme_dev_disable()

Michal Luczaj (4):
      bpf, sockmap: SK_DROP on attempted redirects of unsupported af_vsock
      vsock: Update rx_bytes on read_skb()
      vsock: Update msg_count on read_skb()
      bpf, vsock: Drop static vsock_bpf_prot initialization

Michel Alex (1):
      net: phy: dp83822: Fix reset pin definitions

Mikel Rychliski (1):
      tracing/probes: Fix MAX_TRACE_ARGS limit handling

Mikhail Lobanov (1):
      iio: accel: bma400: Fix uninitialized variable field_value in tap event handling.

Miquel Raynal (2):
      ASoC: dt-bindings: davinci-mcasp: Fix interrupts property
      ASoC: dt-bindings: davinci-mcasp: Fix interrupt properties

Murad Masimov (1):
      ALSA: hda/cs8409: Fix possible NULL dereference

Naohiro Aota (1):
      btrfs: zoned: fix zone unusable accounting for freed reserved extent

Niklas Cassel (1):
      ata: libata: Set DID_TIME_OUT for commands that actually timed out

Niklas Schnelle (1):
      s390/pci: Handle PCI error codes other than 0x3a

Niklas Söderlund (1):
      net: ravb: Only advertise Rx/Tx timestamps if hardware supports it

Oliver Neukum (2):
      net: usb: usbnet: fix race in probe failure
      net: usb: usbnet: fix name regression

Pablo Neira Ayuso (1):
      netfilter: xtables: fix typo causing some targets not to load on IPv6

Pali Rohár (1):
      cifs: Validate content of NFS reparse point buffer

Paritosh Dixit (1):
      net: stmmac: dwmac-tegra: Fix link bring-up sequence

Paul Moore (1):
      selinux: improve error checking in sel_write_load()

Paulo Alcantara (1):
      smb: client: fix OOBs when building SMB2_IOCTL request

Pawan Gupta (1):
      x86/lam: Disable ADDRESS_MASKING in most cases

Peter Rashleigh (2):
      net: dsa: mv88e6xxx: Fix the max_vid definition for the MV88E6361
      net: dsa: mv88e6xxx: Fix error when setting port policy on mv88e6393x

Petr Vaganov (1):
      xfrm: fix one more kernel-infoleak in algo dumping

Pranjal Ramajor Asha Kanojiya (1):
      accel/qaic: Fix the for loop used to walk SG table

Praveen Kumar Kannoju (1):
      net/sched: adjust device watchdog timer to detect stopped queue at right time

Qiao Ma (1):
      uprobe: avoid out-of-bounds memory access of fetching args

Roger Quadros (1):
      usb: dwc3: core: Fix system suspend on TI AM62 platforms

Ryusuke Konishi (1):
      nilfs2: fix kernel bug due to missing clearing of buffer delay flag

Sabrina Dubroca (2):
      macsec: don't increment counters for an unrelated SA
      xfrm: validate new SA's prefixlen using SA family when sel.family is unset

Saravanan Vajravel (1):
      RDMA/bnxt_re: Fix incorrect AVID type in WQE structure

Sean Christopherson (1):
      KVM: nSVM: Ignore nCR3[4:0] when loading PDPTEs from memory

Sebastian Andrzej Siewior (1):
      task_work: Add TWA_NMI_CURRENT as an additional notify mode.

Selvin Xavier (3):
      RDMA/bnxt_re: Support new 5760X P7 devices
      RDMA/bnxt_re: Update the BAR offsets
      RDMA/bnxt_re: Fix the offset for GenP7 adapters for user applications

Shay Drory (1):
      net/mlx5: Fix command bitmask initialization

Shenghao Yang (3):
      net: dsa: mv88e6xxx: group cycle counter coefficients
      net: dsa: mv88e6xxx: read cycle counter period from hardware
      net: dsa: mv88e6xxx: support 4000ps cycle counter period

Shengjiu Wang (1):
      ASoC: fsl_sai: Enable 'FIFO continue on error' FCONT bit

Shubham Panwar (1):
      ACPI: button: Add DMI quirk for Samsung Galaxy Book2 to fix initial lid detection issue

Srinivasan Shanmugam (1):
      drm/amd/amdgpu: Fix double unlock in amdgpu_mes_add_ring

Su Hui (2):
      firmware: arm_scmi: Fix the double free in scmi_debugfs_common_setup()
      smb: client: fix possible double free in smb2_set_ea()

Thadeu Lima de Souza Cascardo (1):
      usb: typec: altmode should keep reference to parent

Thomas Weißschuh (1):
      LoongArch: Don't crash in stack_top() for tasks without vDSO

Timo Grautstueck (1):
      lib/Kconfig.debug: fix grammar in RUST_BUILD_ASSERT_ALLOW

Toke Høiland-Jørgensen (2):
      bpf: Make sure internal and UAPI bpf_redirect flags don't overlap
      bpf: fix kfunc btf caching for modules

Tony Ambardar (1):
      selftests/bpf: Fix cross-compiling urandom_read

Tyrone Wu (3):
      bpf: fix unpopulated name_len field in perf_event link info
      selftests/bpf: fix perf_event link info name_len assertion
      bpf: Fix link info netfilter flags to populate defrag flag

Vincent Guittot (1):
      cpufreq/cppc: Move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}()

Vishal Moola (Oracle) (1):
      mm/khugepaged: convert alloc_charge_hpage() to use folios

Vladimir Oltean (1):
      net/sched: act_api: deny mismatched skip_sw/skip_hw flags for actions created by classifiers

Waiman Long (1):
      sched/core: Disable page allocation in task_tick_mm_cid()

Wang Hai (7):
      net: ethernet: aeroflex: fix potential memory leak in greth_start_xmit_gbit()
      net: xilinx: axienet: fix potential memory leak in axienet_start_xmit()
      net: systemport: fix potential memory leak in bcm_sysport_xmit()
      net: bcmasp: fix potential memory leak in bcmasp_xmit()
      scsi: target: core: Fix null-ptr-deref in target_alloc_device()
      net/sun3_82586: fix potential memory leak in sun3_82586_send_packet()
      be2net: fix potential memory leak in be_xmit()

William Butler (1):
      nvme-pci: set doorbell config before unquiescing

Xin Long (1):
      ipv4: give an IPv4 dev to blackhole_netdev

Yang Erkun (1):
      nfsd: cancel nfsd_shrinker_work using sync mode in nfs4_state_shutdown_net

Yang Shi (1):
      mm: khugepaged: fix the arguments order in khugepaged_collapse_file trace point

Ye Bin (1):
      Bluetooth: bnep: fix wild-memory-access in proto_unregister

Yuan Can (1):
      powercap: dtpm_devfreq: Fix error check against dev_pm_qos_add_request()

Yue Haibing (1):
      btrfs: fix passing 0 to ERR_PTR in btrfs_search_dir_index_item()

Zhao Mengmeng (3):
      udf: refactor udf_current_aext() to handle error
      udf: refactor udf_next_aext() to handle error
      udf: refactor inode_bmap() to handle error

Zichen Xie (1):
      ASoC: qcom: Fix NULL Dereference in asoc_qcom_lpass_cpu_platform_probe()

liwei (1):
      cpufreq: CPPC: fix perf_to_khz/khz_to_perf conversion exception


