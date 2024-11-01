Return-Path: <stable+bounces-89460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0699B885E
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 02:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB95282A1A
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 01:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01983CF73;
	Fri,  1 Nov 2024 01:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dyAZMncS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5142020328;
	Fri,  1 Nov 2024 01:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424383; cv=none; b=gIoidLBZnmskfArvpL6SDsS///tqz9iy0bXt4c4ywpGPlZ3cmiFWBGp5SwwsyX/e2akqKBZdiC1Z5u3dAGViXc0ZFI8d+SJI614N2jXDHtG24E9Fp2Sw1Ht64kfh77O8bel2eNqHZ6Ui3C9ogOlHPY0ZPmTDIJkqpsGgU9Vkfe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424383; c=relaxed/simple;
	bh=9DTQ9JWfECVJu9Y8T6tm74SnZ1ndAWRO0zBPgiJ7DTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NiSoDbZP3w2yiA9kBpD2xBJSwBFsUZ8jwMs0oPlU0NVJL/uQMWFkj9yM0GLRqAcbYWBurxaAZwf0NuDt36YHLhKhCX+OhbhjAuxwy+O5oTJUtZQIo8JLWKPK3COTwOPfRviMIM58M//0RjB2vcxYEROb4woFMxPMqx98cS2A42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dyAZMncS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B430C4CEC3;
	Fri,  1 Nov 2024 01:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730424382;
	bh=9DTQ9JWfECVJu9Y8T6tm74SnZ1ndAWRO0zBPgiJ7DTc=;
	h=From:To:Cc:Subject:Date:From;
	b=dyAZMncSjWF6qkPUIkmmD9TVt6olAZntDCXgfunsk9KgxV/MNtvwzj7gY+bgWJkIW
	 nGLt4zNS1DKOwON4pg8V6w2RxqOD1Ep4+JgE+cCq/UbAPz8gzk1RVgCry1z2AT6Ulg
	 A4+TGIxmhRqj5bB3FndWPHBVAzKrVisOhmn/0zBg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.170
Date: Fri,  1 Nov 2024 02:26:06 +0100
Message-ID: <2024110107-epidermis-exonerate-e12b@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.170 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                            |    2 
 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts           |    2 
 arch/arm64/Makefile                                 |    2 
 arch/arm64/include/asm/uprobes.h                    |   12 
 arch/arm64/kernel/probes/uprobes.c                  |    4 
 arch/s390/include/asm/perf_event.h                  |    1 
 arch/s390/kvm/gaccess.c                             |  162 +++++++-----
 arch/s390/kvm/gaccess.h                             |   14 -
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c           |   23 +
 arch/x86/kvm/svm/nested.c                           |    6 
 block/bfq-iosched.c                                 |   37 +-
 drivers/acpi/button.c                               |   11 
 drivers/acpi/resource.c                             |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c            |   15 -
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c   |   19 -
 drivers/gpu/drm/msm/dsi/dsi_host.c                  |    2 
 drivers/gpu/drm/vboxvideo/hgsmi_base.c              |   10 
 drivers/gpu/drm/vboxvideo/vboxvideo.h               |    4 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h            |    2 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c          |    2 
 drivers/infiniband/hw/bnxt_re/qplib_res.c           |   21 -
 drivers/infiniband/hw/cxgb4/cm.c                    |    9 
 drivers/infiniband/hw/irdma/cm.c                    |    2 
 drivers/net/dsa/mv88e6xxx/port.c                    |    1 
 drivers/net/ethernet/aeroflex/greth.c               |    3 
 drivers/net/ethernet/broadcom/bcmsysport.c          |    1 
 drivers/net/ethernet/emulex/benet/be_main.c         |   10 
 drivers/net/ethernet/i825xx/sun3_82586.c            |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c |    4 
 drivers/net/ethernet/realtek/r8169_main.c           |    4 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c   |    2 
 drivers/net/hyperv/netvsc_drv.c                     |   30 ++
 drivers/net/macsec.c                                |   18 -
 drivers/net/phy/dp83822.c                           |    4 
 drivers/net/plip/plip.c                             |    2 
 drivers/net/usb/usbnet.c                            |    4 
 drivers/net/wwan/wwan_core.c                        |    2 
 drivers/platform/x86/dell/dell-wmi-base.c           |    9 
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c  |    1 
 drivers/target/target_core_device.c                 |    2 
 drivers/target/target_core_user.c                   |    2 
 drivers/tty/serial/serial_core.c                    |   16 -
 drivers/usb/dwc3/core.c                             |   19 +
 drivers/usb/dwc3/core.h                             |    3 
 drivers/usb/gadget/composite.c                      |   40 +++
 drivers/usb/host/xhci-caps.h                        |   85 ++++++
 drivers/usb/host/xhci-port.h                        |  176 +++++++++++++
 drivers/usb/host/xhci.h                             |  262 --------------------
 drivers/usb/typec/class.c                           |    3 
 fs/btrfs/block-group.c                              |    2 
 fs/cifs/smb2pdu.c                                   |    9 
 fs/exec.c                                           |   21 -
 fs/jfs/jfs_dmap.c                                   |    2 
 fs/nilfs2/page.c                                    |    6 
 fs/open.c                                           |    2 
 fs/udf/inode.c                                      |    9 
 include/linux/usb/composite.h                       |    6 
 include/linux/usb/gadget.h                          |    1 
 include/net/genetlink.h                             |    3 
 include/net/xfrm.h                                  |   28 +-
 include/uapi/linux/bpf.h                            |   13 
 kernel/bpf/devmap.c                                 |   11 
 kernel/time/posix-clock.c                           |    6 
 kernel/trace/bpf_trace.c                            |    2 
 kernel/trace/trace_probe.c                          |    2 
 net/bluetooth/bnep/core.c                           |    3 
 net/core/filter.c                                   |    8 
 net/ipv4/devinet.c                                  |   35 +-
 net/ipv4/inet_connection_sock.c                     |   21 +
 net/ipv4/xfrm4_policy.c                             |   40 +--
 net/ipv6/xfrm6_policy.c                             |   31 +-
 net/l2tp/l2tp_netlink.c                             |    4 
 net/netfilter/xt_NFLOG.c                            |    2 
 net/netfilter/xt_TRACE.c                            |    1 
 net/netfilter/xt_mark.c                             |    2 
 net/netlink/genetlink.c                             |   28 +-
 net/sched/sch_taprio.c                              |    3 
 net/smc/smc_pnet.c                                  |    2 
 net/wireless/nl80211.c                              |    8 
 net/xfrm/xfrm_device.c                              |   11 
 net/xfrm/xfrm_policy.c                              |   50 ++-
 net/xfrm/xfrm_user.c                                |   10 
 security/selinux/selinuxfs.c                        |   27 +-
 sound/firewire/amdtp-stream.c                       |    3 
 sound/pci/hda/patch_cs8409.c                        |    5 
 sound/pci/hda/patch_realtek.c                       |   48 ++-
 sound/soc/codecs/lpass-rx-macro.c                   |    2 
 sound/soc/fsl/fsl_sai.c                             |    5 
 sound/soc/fsl/fsl_sai.h                             |    1 
 sound/soc/qcom/lpass-cpu.c                          |    2 
 sound/soc/qcom/sm8250.c                             |    1 
 91 files changed, 905 insertions(+), 644 deletions(-)

Aleksa Sarai (1):
      openat2: explicitly return -E2BIG for (usize > PAGE_SIZE)

Alexander Zubkov (1):
      RDMA/irdma: Fix misspelling of "accept*"

Alexey Klimov (2):
      ASoC: codecs: lpass-rx-macro: add missing CDC_RX_BCL_VBAT_RF_PROC2 to default regs values
      ASoC: qcom: sm8250: add qrb4210-rb2-sndcard compatible string

Andrey Shumilin (1):
      ALSA: firewire-lib: Avoid division by zero in apply_constraint_to_size()

Anumula Murali Mohan Reddy (1):
      RDMA/cxgb4: Fix RDMA_CM_EVENT_UNREACHABLE error for iWARP

Armin Wolf (1):
      platform/x86: dell-wmi: Ignore suspend notifications

Bhargava Chenna Marreddy (1):
      RDMA/bnxt_re: Fix a bug while setting up Level-2 PBL pages

Christian Heusel (1):
      ACPI: resource: Add LG 16T90SP to irq1_level_low_skip_override[]

Colin Ian King (1):
      octeontx2-af: Fix potential integer overflows on integer shifts

Crag Wang (1):
      platform/x86: dell-sysman: add support for alienware products

Dave Kleikamp (1):
      jfs: Fix sanity check in dbMount

Dmitry Antipov (1):
      net: sched: fix use-after-free in taprio_change()

Douglas Anderson (2):
      drm/msm: Avoid NULL dereference in msm_disp_state_print_regs()
      drm/msm: Allocate memory for disp snapshot with kvzalloc()

Elson Roy Serrao (1):
      usb: gadget: Add function wakeup support

Eric Dumazet (1):
      genetlink: hold RCU in genlmsg_mcast()

Eyal Birger (2):
      xfrm: extract dst lookup parameters into a struct
      xfrm: respect ip protocols rules criteria when performing dst lookups

Florian Kauer (1):
      bpf: devmap: provide rxq after redirect

Florian Klink (1):
      ARM: dts: bcm2837-rpi-cm3-io3: Fix HDMI hpd-gpio pin

Frank Li (1):
      XHCI: Separate PORT and CAPs macros into dedicated file

Gianfranco Trad (1):
      udf: fix uninit-value use in udf_get_fileshortad

Greg Kroah-Hartman (1):
      Linux 5.15.170

Haiyang Zhang (1):
      hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event

Hans de Goede (1):
      drm/vboxvideo: Replace fake VLA at end of vbva_mouse_pointer_shape with real VLA

Heiko Carstens (1):
      s390: Initialize psw mask in perf_arch_fetch_caller_regs()

Heiner Kallweit (1):
      r8169: avoid unsolicited interrupts

Jakub Boehm (1):
      net: plip: fix break; causing plip to never transmit

Janis Schoetterl-Glausch (3):
      KVM: s390: gaccess: Refactor gpa and length calculation
      KVM: s390: gaccess: Refactor access address range check
      KVM: s390: gaccess: Cleanup access to guest pages

Jinjie Ruan (1):
      posix-clock: posix-clock: Fix unbalanced locking in pc_clock_settime()

Jiri Olsa (1):
      bpf,perf: Fix perf_event_detach_bpf_prog error handling

Jiri Slaby (SUSE) (1):
      serial: protect uart_port_dtr_rts() in uart_shutdown() too

Jonathan Marek (1):
      drm/msm/dsi: fix 32-bit signed integer extension in pclk_rate calculation

José Relvas (1):
      ALSA: hda/realtek: Add subwoofer quirk for Acer Predator G9-593

Kailang Yang (1):
      ALSA: hda/realtek: Update default depop procedure

Kalesh AP (2):
      RDMA/bnxt_re: Add a check for memory allocation
      RDMA/bnxt_re: Return more meaningful error

Kuniyuki Iwashima (1):
      tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().

Leo Yan (1):
      tracing: Consider the NULL character when validating the event length

Li RongQing (1):
      net/smc: Fix searching in list of known pnetids in smc_pnet_add_pnetid

Lin Ma (1):
      net: wwan: fix global oob in wwan_rtnl_policy

Mario Limonciello (1):
      drm/amd: Guard against bad data for ATIF ACPI method

Mark Rutland (2):
      arm64: probes: Fix uprobes for big-endian kernels
      arm64: Force position-independent veneers

Martin Kletzander (1):
      x86/resctrl: Avoid overflow in MB settings in bw_validate()

Mateusz Guzik (1):
      exec: don't WARN for racy path_noexec check

Michel Alex (1):
      net: phy: dp83822: Fix reset pin definitions

Murad Masimov (1):
      ALSA: hda/cs8409: Fix possible NULL dereference

Naohiro Aota (1):
      btrfs: zoned: fix zone unusable accounting for freed reserved extent

Nico Boehr (1):
      KVM: s390: gaccess: Check if guest address is in memslot

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

Shengjiu Wang (1):
      ASoC: fsl_sai: Enable 'FIFO continue on error' FCONT bit

Shubham Panwar (1):
      ACPI: button: Add DMI quirk for Samsung Galaxy Book2 to fix initial lid detection issue

Thadeu Lima de Souza Cascardo (1):
      usb: typec: altmode should keep reference to parent

Toke Høiland-Jørgensen (1):
      bpf: Make sure internal and UAPI bpf_redirect flags don't overlap

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

Zichen Xie (1):
      ASoC: qcom: Fix NULL Dereference in asoc_qcom_lpass_cpu_platform_probe()

junhua huang (2):
      arm64:uprobe fix the uprobe SWBP_INSN in big-endian
      arm64/uprobes: change the uprobe_opcode_t typedef to fix the sparse warning


