Return-Path: <stable+bounces-89463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5F89B8864
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 02:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04C31C21DEA
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 01:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D145A73451;
	Fri,  1 Nov 2024 01:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V5OC1+T2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EB562171;
	Fri,  1 Nov 2024 01:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424406; cv=none; b=Sx8l7JYWIeHYSH8XgNTGS0Ds495LJITchMjs0xeT4GayrB2uTFXtJdNlWzWsv29InpE8F/t/bVjm3A54e09l+cbQJQybqsBeGMhlb5rL/lH4jPrN484XBlxBAhyOk1BnzwlfFM+x1YmQ4Ly8jFXPnERhYi1OP0P+rrPykAldBMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424406; c=relaxed/simple;
	bh=+yRBltJxE8W+u1C8Vlby3m1W8KQG8Djd1RGiCJYGvPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BBurFP5BAYn4OiIiqbtfx3mrt+5W53whvNp6WMcVQpRav8xGQfjsoolrPDdywePVFDFPusRcrxfH4U29oLMWQFiMTEuVqKWK2OcMxE2gH3KwZw2rb3FWmY3NuDc0kUkb6CTH10MBUnTvjdfgXcvbbJfeLl47zoWKnPwZXfOZAEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V5OC1+T2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C819FC4CED1;
	Fri,  1 Nov 2024 01:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730424406;
	bh=+yRBltJxE8W+u1C8Vlby3m1W8KQG8Djd1RGiCJYGvPk=;
	h=From:To:Cc:Subject:Date:From;
	b=V5OC1+T2JXw2SnRNugelcfRKwbW/vwpIaaBYWOCut/NIFRFQF+cDq6S7b4+KOogkM
	 zicGTjhQkRze+hnm5pK15tfhZeNvMgtzCkVGgJXOjeb6pVoKgv862SaVmfWckPvOoy
	 xzmubPCysqNhMwbpFRvrjCLYpPJPVn/xpopUiahk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.115
Date: Fri,  1 Nov 2024 02:26:16 +0100
Message-ID: <2024110117-wince-enjoyer-47d7@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.115 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml |   18 
 Documentation/networking/driver.rst                              |   97 ++-
 Makefile                                                         |    2 
 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts                        |    2 
 arch/arm64/Makefile                                              |    2 
 arch/arm64/include/asm/uprobes.h                                 |   12 
 arch/arm64/kernel/probes/uprobes.c                               |    4 
 arch/arm64/kvm/arm.c                                             |    3 
 arch/arm64/kvm/vgic/vgic-init.c                                  |    6 
 arch/loongarch/Kconfig                                           |    1 
 arch/loongarch/include/asm/bootinfo.h                            |    4 
 arch/loongarch/include/asm/page.h                                |    1 
 arch/loongarch/include/asm/vdso/gettimeofday.h                   |    9 
 arch/loongarch/include/asm/vdso/vdso.h                           |   32 +
 arch/loongarch/kernel/process.c                                  |   16 
 arch/loongarch/kernel/setup.c                                    |    3 
 arch/loongarch/kernel/vdso.c                                     |   98 +++
 arch/loongarch/vdso/vgetcpu.c                                    |    2 
 arch/riscv/net/bpf_jit_comp64.c                                  |    4 
 arch/s390/include/asm/perf_event.h                               |    1 
 arch/s390/pci/pci_event.c                                        |   17 
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c                        |   23 
 arch/x86/kvm/svm/nested.c                                        |    6 
 block/bfq-iosched.c                                              |   37 -
 drivers/acpi/button.c                                            |   11 
 drivers/acpi/cppc_acpi.c                                         |  116 ++++
 drivers/acpi/prmt.c                                              |   29 -
 drivers/acpi/resource.c                                          |    7 
 drivers/cpufreq/cppc_cpufreq.c                                   |  139 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                         |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                          |    5 
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c        |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                      |    9 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c             |    1 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c             |    3 
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c                |   19 
 drivers/gpu/drm/msm/dsi/dsi_host.c                               |    2 
 drivers/gpu/drm/vboxvideo/hgsmi_base.c                           |   10 
 drivers/gpu/drm/vboxvideo/vboxvideo.h                            |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c                             |    4 
 drivers/iio/accel/bma400_core.c                                  |    3 
 drivers/iio/frequency/Kconfig                                    |   33 -
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                         |    2 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                       |    2 
 drivers/infiniband/hw/bnxt_re/qplib_res.c                        |   21 
 drivers/infiniband/hw/cxgb4/cm.c                                 |    9 
 drivers/infiniband/hw/irdma/cm.c                                 |    2 
 drivers/infiniband/ulp/srpt/ib_srpt.c                            |   80 ++-
 drivers/irqchip/irq-renesas-rzg2l.c                              |   94 +++
 drivers/net/dsa/mv88e6xxx/port.c                                 |    1 
 drivers/net/ethernet/aeroflex/greth.c                            |    3 
 drivers/net/ethernet/broadcom/bcmsysport.c                       |    1 
 drivers/net/ethernet/emulex/benet/be_main.c                      |   10 
 drivers/net/ethernet/i825xx/sun3_82586.c                         |    1 
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c                |   82 ++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c              |    4 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                    |  138 ++---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                |    5 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                   |   15 
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h              |    2 
 drivers/net/ethernet/realtek/r8169_main.c                        |    4 
 drivers/net/ethernet/renesas/ravb_main.c                         |   25 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                |    2 
 drivers/net/hyperv/netvsc_drv.c                                  |   30 +
 drivers/net/macsec.c                                             |   18 
 drivers/net/netdevsim/dev.c                                      |   15 
 drivers/net/phy/dp83822.c                                        |    4 
 drivers/net/plip/plip.c                                          |    2 
 drivers/net/usb/usbnet.c                                         |    4 
 drivers/net/wwan/wwan_core.c                                     |    2 
 drivers/platform/x86/dell/dell-wmi-base.c                        |    9 
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c               |    1 
 drivers/powercap/dtpm_devfreq.c                                  |    2 
 drivers/pps/clients/pps-ldisc.c                                  |    6 
 drivers/target/target_core_device.c                              |    2 
 drivers/target/target_core_user.c                                |    2 
 drivers/tty/serial/imx.c                                         |   17 
 drivers/tty/serial/max3100.c                                     |    2 
 drivers/tty/serial/max310x.c                                     |    3 
 drivers/tty/serial/serial_core.c                                 |   32 -
 drivers/tty/serial/sunhv.c                                       |    8 
 drivers/usb/dwc3/core.c                                          |   19 
 drivers/usb/dwc3/core.h                                          |    3 
 drivers/usb/gadget/composite.c                                   |   40 +
 drivers/usb/gadget/function/f_uac2.c                             |   13 
 drivers/usb/host/xhci-caps.h                                     |   85 +++
 drivers/usb/host/xhci-dbgcap.h                                   |    2 
 drivers/usb/host/xhci-dbgtty.c                                   |   73 ++
 drivers/usb/host/xhci-port.h                                     |  176 ++++++
 drivers/usb/host/xhci.h                                          |  262 ----------
 drivers/usb/typec/class.c                                        |    3 
 fs/btrfs/block-group.c                                           |    2 
 fs/btrfs/dir-item.c                                              |    4 
 fs/btrfs/inode.c                                                 |    7 
 fs/exec.c                                                        |   21 
 fs/jfs/jfs_dmap.c                                                |    2 
 fs/nilfs2/page.c                                                 |    6 
 fs/ntfs3/record.c                                                |   67 ++
 fs/open.c                                                        |    2 
 fs/smb/client/smb2pdu.c                                          |    9 
 fs/udf/inode.c                                                   |   49 +
 fs/udf/truncate.c                                                |   10 
 fs/udf/udfdecl.h                                                 |    5 
 include/acpi/cppc_acpi.h                                         |    2 
 include/linux/netdevice.h                                        |   13 
 include/linux/serial_core.h                                      |    6 
 include/linux/tty_ldisc.h                                        |    4 
 include/linux/usb/composite.h                                    |    6 
 include/linux/usb/gadget.h                                       |    1 
 include/net/bluetooth/bluetooth.h                                |    1 
 include/net/genetlink.h                                          |    3 
 include/net/netdev_queues.h                                      |  144 +++++
 include/net/xfrm.h                                               |   28 -
 include/uapi/linux/bpf.h                                         |   13 
 kernel/bpf/btf.c                                                 |    1 
 kernel/bpf/devmap.c                                              |   11 
 kernel/bpf/ringbuf.c                                             |   12 
 kernel/bpf/task_iter.c                                           |    2 
 kernel/bpf/verifier.c                                            |    8 
 kernel/time/posix-clock.c                                        |    6 
 kernel/trace/bpf_trace.c                                         |    2 
 kernel/trace/trace_probe.c                                       |    2 
 net/bluetooth/af_bluetooth.c                                     |   22 
 net/bluetooth/bnep/core.c                                        |    3 
 net/bluetooth/iso.c                                              |   18 
 net/bluetooth/sco.c                                              |   18 
 net/core/filter.c                                                |    8 
 net/ipv4/devinet.c                                               |   35 -
 net/ipv4/inet_connection_sock.c                                  |   21 
 net/ipv4/xfrm4_policy.c                                          |   40 -
 net/ipv6/xfrm6_policy.c                                          |   31 -
 net/l2tp/l2tp_netlink.c                                          |    4 
 net/netfilter/xt_NFLOG.c                                         |    2 
 net/netfilter/xt_TRACE.c                                         |    1 
 net/netfilter/xt_mark.c                                          |    2 
 net/netlink/genetlink.c                                          |   28 -
 net/sched/act_api.c                                              |   23 
 net/sched/sch_generic.c                                          |   17 
 net/sched/sch_taprio.c                                           |    3 
 net/smc/smc_pnet.c                                               |    2 
 net/wireless/nl80211.c                                           |    8 
 net/xfrm/xfrm_device.c                                           |   11 
 net/xfrm/xfrm_policy.c                                           |   50 +
 net/xfrm/xfrm_user.c                                             |   10 
 security/selinux/selinuxfs.c                                     |   27 -
 sound/firewire/amdtp-stream.c                                    |    3 
 sound/pci/hda/patch_cs8409.c                                     |    5 
 sound/pci/hda/patch_realtek.c                                    |   48 +
 sound/soc/codecs/lpass-rx-macro.c                                |    2 
 sound/soc/fsl/fsl_sai.c                                          |    5 
 sound/soc/fsl/fsl_sai.h                                          |    1 
 sound/soc/qcom/lpass-cpu.c                                       |    2 
 sound/soc/qcom/sm8250.c                                          |    1 
 tools/testing/selftests/bpf/Makefile                             |    2 
 154 files changed, 1985 insertions(+), 1067 deletions(-)

Aleksa Sarai (1):
      openat2: explicitly return -E2BIG for (usize > PAGE_SIZE)

Aleksandr Mishin (2):
      octeon_ep: Implement helper for iterating packets in Rx queue
      octeon_ep: Add SKB allocation failures handling in __octep_oq_process_rx()

Alexander Zubkov (1):
      RDMA/irdma: Fix misspelling of "accept*"

Alexey Klimov (2):
      ASoC: codecs: lpass-rx-macro: add missing CDC_RX_BCL_VBAT_RF_PROC2 to default regs values
      ASoC: qcom: sm8250: add qrb4210-rb2-sndcard compatible string

Andrea Parri (1):
      riscv, bpf: Make BPF_CMPXCHG fully ordered

Andrey Shumilin (1):
      ALSA: firewire-lib: Avoid division by zero in apply_constraint_to_size()

Anumula Murali Mohan Reddy (1):
      RDMA/cxgb4: Fix RDMA_CM_EVENT_UNREACHABLE error for iWARP

Armin Wolf (1):
      platform/x86: dell-wmi: Ignore suspend notifications

Bart Van Assche (1):
      RDMA/srpt: Make slab cache names unique

Bhargava Chenna Marreddy (1):
      RDMA/bnxt_re: Fix a bug while setting up Level-2 PBL pages

Christian Heusel (1):
      ACPI: resource: Add LG 16T90SP to irq1_level_low_skip_override[]

Claudiu Beznea (3):
      irqchip/renesas-rzg2l: Align struct member names to tabs
      irqchip/renesas-rzg2l: Document structure members
      irqchip/renesas-rzg2l: Add support for suspend to RAM

Colin Ian King (1):
      octeontx2-af: Fix potential integer overflows on integer shifts

Cosmin Ratiu (1):
      net/mlx5: Unregister notifier on eswitch init failure

Crag Wang (1):
      platform/x86: dell-sysman: add support for alienware products

Dan Carpenter (1):
      ACPI: PRM: Clean up guid type in struct prm_handler_info

Dave Kleikamp (1):
      jfs: Fix sanity check in dbMount

Dmitry Antipov (1):
      net: sched: fix use-after-free in taprio_change()

Dmitry Baryshkov (1):
      drm/msm/dpu: make sure phys resources are properly initialized

Douglas Anderson (2):
      drm/msm: Avoid NULL dereference in msm_disp_state_print_regs()
      drm/msm: Allocate memory for disp snapshot with kvzalloc()

Elson Roy Serrao (1):
      usb: gadget: Add function wakeup support

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

Frank Li (1):
      XHCI: Separate PORT and CAPs macros into dedicated file

Gal Pressman (1):
      ravb: Remove setting of RX software timestamp

Gianfranco Trad (1):
      udf: fix uninit-value use in udf_get_fileshortad

Greg Kroah-Hartman (1):
      Linux 6.1.115

Haiyang Zhang (1):
      hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event

Hans de Goede (1):
      drm/vboxvideo: Replace fake VLA at end of vbva_mouse_pointer_shape with real VLA

Heiko Carstens (1):
      s390: Initialize psw mask in perf_arch_fetch_caller_regs()

Heiner Kallweit (1):
      r8169: avoid unsolicited interrupts

Huacai Chen (1):
      LoongArch: Get correct cores_per_package for SMT systems

Ian Forbes (1):
      drm/vmwgfx: Handle possible ENOMEM in vmw_stdu_connector_atomic_check

Ilpo Järvinen (2):
      tty/serial: Make ->dcd_change()+uart_handle_dcd_change() status bool active
      serial: Make uart_handle_cts_change() status param bool active

Jakub Boehm (1):
      net: plip: fix break; causing plip to never transmit

Jakub Kicinski (2):
      docs: net: reformat driver.rst from a list to sections
      net: provide macros for commonly copied lockless queue stop/wake code

Javier Carrasco (2):
      iio: frequency: {admv4420,adrf6780}: format Kconfig entries
      iio: frequency: admv4420: fix missing select REMAP_SPI in Kconfig

Jessica Zhang (1):
      drm/msm/dpu: don't always program merge_3d block

Jinjie Ruan (1):
      posix-clock: posix-clock: Fix unbalanced locking in pc_clock_settime()

Jiri Olsa (2):
      bpf: Fix memory leak in bpf_core_apply
      bpf,perf: Fix perf_event_detach_bpf_prog error handling

Jiri Slaby (SUSE) (3):
      xhci: dbgtty: remove kfifo_out() wrapper
      xhci: dbgtty: use kfifo from tty_port struct
      serial: protect uart_port_dtr_rts() in uart_shutdown() too

John Keeping (1):
      usb: gadget: f_uac2: fix non-newline-terminated function name

Jonathan Marek (1):
      drm/msm/dsi: fix 32-bit signed integer extension in pclk_rate calculation

Jordan Rome (1):
      bpf: Fix iter/task tid filtering

José Relvas (1):
      ALSA: hda/realtek: Add subwoofer quirk for Acer Predator G9-593

Kailang Yang (1):
      ALSA: hda/realtek: Update default depop procedure

Kalesh AP (2):
      RDMA/bnxt_re: Add a check for memory allocation
      RDMA/bnxt_re: Return more meaningful error

Kevin Groeneveld (1):
      usb: gadget: f_uac2: fix return value for UAC2_ATTRIBUTE_STRING store

Koba Ko (1):
      ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM handler and context

Konstantin Komarov (1):
      fs/ntfs3: Add more attributes checks in mi_enum_attr()

Kuniyuki Iwashima (1):
      tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().

Lee Jones (1):
      usb: gadget: f_uac2: Replace snprintf() with the safer scnprintf() variant

Leo Yan (1):
      tracing: Consider the NULL character when validating the event length

Li RongQing (1):
      net/smc: Fix searching in list of known pnetids in smc_pnet_add_pnetid

Lin Ma (1):
      net: wwan: fix global oob in wwan_rtnl_policy

Luiz Augusto von Dentz (2):
      Bluetooth: SCO: Fix UAF on sco_sock_timeout
      Bluetooth: ISO: Fix UAF on iso_sock_timeout

Marc Zyngier (1):
      KVM: arm64: Don't eagerly teardown the vgic on init error

Marek Vasut (1):
      serial: imx: Update mctrl old_status on RTSD interrupt

Marijn Suijten (1):
      drm/msm/dpu: Wire up DSC mask for active CTL configuration

Mario Limonciello (2):
      drm/amd: Guard against bad data for ATIF ACPI method
      drm/amd/display: Disable PSR-SU on Parade 08-01 TCON too

Mark Rutland (2):
      arm64: probes: Fix uprobes for big-endian kernels
      arm64: Force position-independent veneers

Martin Kletzander (1):
      x86/resctrl: Avoid overflow in MB settings in bw_validate()

Mateusz Guzik (1):
      exec: don't WARN for racy path_noexec check

Mathias Nyman (1):
      xhci: dbc: honor usb transfer size boundaries.

Michel Alex (1):
      net: phy: dp83822: Fix reset pin definitions

Mikhail Lobanov (1):
      iio: accel: bma400: Fix uninitialized variable field_value in tap event handling.

Miquel Raynal (2):
      ASoC: dt-bindings: davinci-mcasp: Fix interrupts property
      ASoC: dt-bindings: davinci-mcasp: Fix interrupt properties

Murad Masimov (1):
      ALSA: hda/cs8409: Fix possible NULL dereference

Naohiro Aota (1):
      btrfs: zoned: fix zone unusable accounting for freed reserved extent

Niklas Schnelle (1):
      s390/pci: Handle PCI error codes other than 0x3a

Niklas Söderlund (1):
      net: ravb: Only advertise Rx/Tx timestamps if hardware supports it

Oliver Neukum (2):
      net: usb: usbnet: fix race in probe failure
      net: usb: usbnet: fix name regression

Pablo Neira Ayuso (1):
      netfilter: xtables: fix typo causing some targets not to load on IPv6

Paul Moore (1):
      selinux: improve error checking in sel_write_load()

Paulo Alcantara (1):
      smb: client: fix OOBs when building SMB2_IOCTL request

Peter Rashleigh (1):
      net: dsa: mv88e6xxx: Fix error when setting port policy on mv88e6393x

Petr Vaganov (1):
      xfrm: fix one more kernel-infoleak in algo dumping

Praveen Kumar Kannoju (1):
      net/sched: adjust device watchdog timer to detect stopped queue at right time

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

Shay Drory (3):
      net/mlx5: Remove redundant cmdif revision check
      net/mlx5: split mlx5_cmd_init() to probe and reload routines
      net/mlx5: Fix command bitmask initialization

Shengjiu Wang (1):
      ASoC: fsl_sai: Enable 'FIFO continue on error' FCONT bit

Shubham Panwar (1):
      ACPI: button: Add DMI quirk for Samsung Galaxy Book2 to fix initial lid detection issue

Srinivasan Shanmugam (1):
      drm/amd/amdgpu: Fix double unlock in amdgpu_mes_add_ring

Thadeu Lima de Souza Cascardo (1):
      usb: typec: altmode should keep reference to parent

Thomas Weißschuh (1):
      LoongArch: Don't crash in stack_top() for tasks without vDSO

Tiezhu Yang (1):
      LoongArch: Add support to clone a time namespace

Toke Høiland-Jørgensen (2):
      bpf: Make sure internal and UAPI bpf_redirect flags don't overlap
      bpf: fix kfunc btf caching for modules

Tony Ambardar (1):
      selftests/bpf: Fix cross-compiling urandom_read

Vincent Guittot (1):
      cpufreq/cppc: Move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}()

Vladimir Oltean (1):
      net/sched: act_api: deny mismatched skip_sw/skip_hw flags for actions created by classifiers

Wander Lairson Costa (1):
      bpf: Use raw_spinlock_t in ringbuf

Wang Hai (6):
      net: ethernet: aeroflex: fix potential memory leak in greth_start_xmit_gbit()
      net: xilinx: axienet: fix potential memory leak in axienet_start_xmit()
      net: systemport: fix potential memory leak in bcm_sysport_xmit()
      scsi: target: core: Fix null-ptr-deref in target_alloc_device()
      net/sun3_82586: fix potential memory leak in sun3_82586_send_packet()
      be2net: fix potential memory leak in be_xmit()

Xin Long (1):
      ipv4: give an IPv4 dev to blackhole_netdev

Ye Bin (1):
      Bluetooth: bnep: fix wild-memory-access in proto_unregister

Yu Kuai (1):
      block, bfq: fix procress reference leakage for bfqq in merge chain

Yuan Can (1):
      powercap: dtpm_devfreq: Fix error check against dev_pm_qos_add_request()

Yue Haibing (1):
      btrfs: fix passing 0 to ERR_PTR in btrfs_search_dir_index_item()

Zhao Mengmeng (1):
      udf: refactor udf_current_aext() to handle error

Zichen Xie (1):
      ASoC: qcom: Fix NULL Dereference in asoc_qcom_lpass_cpu_platform_probe()

junhua huang (2):
      arm64:uprobe fix the uprobe SWBP_INSN in big-endian
      arm64/uprobes: change the uprobe_opcode_t typedef to fix the sparse warning

liwei (1):
      cpufreq: CPPC: fix perf_to_khz/khz_to_perf conversion exception


