Return-Path: <stable+bounces-118584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EA6A3F5ED
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2DF861EDB
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 13:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CBF20E318;
	Fri, 21 Feb 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f6lZ4Ao/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE8820E319;
	Fri, 21 Feb 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144483; cv=none; b=nRN8lRAZCdgqYPh2tmBfslsB7LEK8p1UNX/aY+vLFOpmwNkFtN+kW/fbbBarQjxx/6SX5Cnmc5XKwG6irNjsxO3ifE88rlJC6p7I0sqFQx3KCsKIZifbMnf2GjzNcv4zuoDSPMv/FJE8X7XbbI+Zx88Q8xnE+NtmBHjnSLulOok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144483; c=relaxed/simple;
	bh=5jpkIQ0WeRj7N0pOS+gJYU2VGA3H/hpyxyb+ePeN4mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tEqYRrqIyXBOzj/Ur4bd/2BWnqZ5BayJOBmmRoU2XBzZ9528pzIhoxBimmm9ZQLvAjW2yTWr4N9888vN2Zw+PaEj1ELHRI6pO+dieGOs1tKjyJRwG8uypQ1Hx0cB7dim76DqyvhmBe5mJYspoEmNfn+cDuK/ChGZXesJAT829hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f6lZ4Ao/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88754C4CEE8;
	Fri, 21 Feb 2025 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740144483;
	bh=5jpkIQ0WeRj7N0pOS+gJYU2VGA3H/hpyxyb+ePeN4mc=;
	h=From:To:Cc:Subject:Date:From;
	b=f6lZ4Ao/7uRLYKa1C9VWTC4PZzLLtGIaDGSJ/Z1dTMH+WshWxuoh0J9V7KYjlmsDU
	 SeooWo16dvKDMqESRCA1kVsEaPCQCxXnE1ora6LEVP5vANBZjSkcykP1QYvU56LqA3
	 yMwWf620Q753DJXMJBps7cGvSso/N7/Bm274Bg68=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.16
Date: Fri, 21 Feb 2025 14:27:55 +0100
Message-ID: <2025022155-skinhead-undergrad-14b0@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.16 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml |    2 
 Documentation/networking/iso15765-2.rst                                 |    4 
 Makefile                                                                |   15 -
 arch/alpha/include/uapi/asm/ptrace.h                                    |    2 
 arch/alpha/kernel/asm-offsets.c                                         |    4 
 arch/alpha/kernel/entry.S                                               |   24 -
 arch/alpha/kernel/traps.c                                               |    2 
 arch/alpha/mm/fault.c                                                   |    4 
 arch/arm64/Makefile                                                     |    4 
 arch/arm64/kernel/cacheinfo.c                                           |   12 
 arch/arm64/kernel/vdso/vdso.lds.S                                       |    1 
 arch/arm64/kernel/vmlinux.lds.S                                         |    1 
 arch/loongarch/kernel/genex.S                                           |   28 +
 arch/loongarch/kernel/idle.c                                            |    3 
 arch/loongarch/kernel/reset.c                                           |    6 
 arch/loongarch/kvm/main.c                                               |    4 
 arch/loongarch/lib/csum.c                                               |    2 
 arch/s390/pci/pci_bus.c                                                 |   20 +
 arch/s390/pci/pci_iov.c                                                 |   56 ++-
 arch/s390/pci/pci_iov.h                                                 |    7 
 arch/x86/Kconfig                                                        |    3 
 arch/x86/events/intel/core.c                                            |   33 --
 arch/x86/events/intel/ds.c                                              |   10 
 arch/x86/include/asm/kvm-x86-ops.h                                      |    1 
 arch/x86/include/asm/kvm_host.h                                         |    1 
 arch/x86/include/asm/mmu.h                                              |    2 
 arch/x86/include/asm/mmu_context.h                                      |    1 
 arch/x86/include/asm/msr-index.h                                        |    3 
 arch/x86/include/asm/perf_event.h                                       |   28 +
 arch/x86/include/asm/tlbflush.h                                         |    1 
 arch/x86/kernel/cpu/bugs.c                                              |   21 -
 arch/x86/kernel/static_call.c                                           |    1 
 arch/x86/kvm/hyperv.c                                                   |    6 
 arch/x86/kvm/mmu/mmu.c                                                  |    2 
 arch/x86/kvm/svm/nested.c                                               |   10 
 arch/x86/kvm/svm/svm.c                                                  |   13 
 arch/x86/kvm/vmx/main.c                                                 |    1 
 arch/x86/kvm/vmx/vmx.c                                                  |   10 
 arch/x86/kvm/vmx/x86_ops.h                                              |    1 
 arch/x86/kvm/x86.c                                                      |    3 
 arch/x86/mm/tlb.c                                                       |   35 ++
 arch/x86/xen/mmu_pv.c                                                   |   75 ++++-
 block/partitions/mac.c                                                  |   18 +
 drivers/acpi/x86/utils.c                                                |   13 
 drivers/base/regmap/regmap-irq.c                                        |    2 
 drivers/bluetooth/btintel_pcie.c                                        |    5 
 drivers/cpufreq/amd-pstate.c                                            |  102 ++----
 drivers/firmware/efi/efi.c                                              |    6 
 drivers/firmware/efi/libstub/randomalloc.c                              |    3 
 drivers/firmware/efi/libstub/relocate.c                                 |    3 
 drivers/firmware/qcom/qcom_scm-smc.c                                    |    3 
 drivers/gpio/gpio-bcm-kona.c                                            |   71 +++-
 drivers/gpio/gpio-stmpe.c                                               |   15 -
 drivers/gpio/gpiolib-acpi.c                                             |   14 
 drivers/gpio/gpiolib.c                                                  |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                                 |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c                  |    2 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                               |    3 
 drivers/gpu/drm/display/drm_dp_helper.c                                 |    2 
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c                           |    4 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h                |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c                           |    3 
 drivers/gpu/drm/msm/msm_gem_submit.c                                    |    3 
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c                         |    2 
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h                    |    1 
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c                            |    6 
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c                      |    7 
 drivers/gpu/drm/tidss/tidss_dispc.c                                     |   26 +
 drivers/gpu/drm/tidss/tidss_irq.c                                       |    2 
 drivers/gpu/drm/v3d/v3d_perfmon.c                                       |    5 
 drivers/gpu/drm/xe/xe_drm_client.c                                      |    2 
 drivers/gpu/drm/xe/xe_trace_bo.h                                        |   12 
 drivers/gpu/host1x/dev.c                                                |    2 
 drivers/gpu/host1x/intr.c                                               |    2 
 drivers/hid/hid-multitouch.c                                            |    5 
 drivers/hid/hid-steam.c                                                 |   41 ++
 drivers/hid/hid-thrustmaster.c                                          |    2 
 drivers/hid/hid-winwing.c                                               |    2 
 drivers/i3c/master/Kconfig                                              |   11 
 drivers/i3c/master/mipi-i3c-hci/Makefile                                |    1 
 drivers/i3c/master/mipi-i3c-hci/dma.c                                   |   17 +
 drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c                      |  148 ++++++++++
 drivers/infiniband/hw/efa/efa_main.c                                    |    9 
 drivers/iommu/amd/amd_iommu_types.h                                     |    1 
 drivers/iommu/amd/init.c                                                |    4 
 drivers/iommu/io-pgfault.c                                              |    1 
 drivers/media/dvb-frontends/cxd2841er.c                                 |    8 
 drivers/media/i2c/ds90ub913.c                                           |   25 +
 drivers/media/i2c/ds90ub953.c                                           |   46 ++-
 drivers/media/platform/broadcom/bcm2835-unicam.c                        |    8 
 drivers/media/test-drivers/vidtv/vidtv_bridge.c                         |    8 
 drivers/media/usb/uvc/uvc_driver.c                                      |   18 +
 drivers/media/usb/uvc/uvc_video.c                                       |   27 +
 drivers/media/usb/uvc/uvcvideo.h                                        |    1 
 drivers/mmc/host/mtk-sd.c                                               |   31 +-
 drivers/net/can/c_can/c_can_platform.c                                  |    5 
 drivers/net/can/ctucanfd/ctucanfd_base.c                                |   10 
 drivers/net/can/rockchip/rockchip_canfd-core.c                          |    2 
 drivers/net/can/usb/etas_es58x/es58x_devlink.c                          |    6 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                              |    5 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                             |    5 
 drivers/net/ethernet/intel/igc/igc_main.c                               |   22 -
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c                  |    4 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                                |   40 +-
 drivers/net/netdevsim/ipsec.c                                           |   12 
 drivers/net/team/team_core.c                                            |    4 
 drivers/net/vxlan/vxlan_core.c                                          |    7 
 drivers/net/wireless/ath/ath12k/wmi.c                                   |   61 +++-
 drivers/net/wireless/ath/ath12k/wmi.h                                   |    1 
 drivers/net/wireless/realtek/rtw89/pci.c                                |   17 -
 drivers/net/wireless/realtek/rtw89/pci.h                                |   11 
 drivers/net/wireless/realtek/rtw89/pci_be.c                             |    2 
 drivers/parport/parport_serial.c                                        |   12 
 drivers/pci/quirks.c                                                    |   15 -
 drivers/pci/switch/switchtec.c                                          |   26 +
 drivers/pinctrl/pinconf-generic.c                                       |    8 
 drivers/pinctrl/pinctrl-cy8c95x0.c                                      |   36 +-
 drivers/soc/tegra/fuse/fuse-tegra30.c                                   |   17 -
 drivers/spi/spi-sn-f-ospi.c                                             |    3 
 drivers/tty/serial/8250/8250.h                                          |    2 
 drivers/tty/serial/8250/8250_dma.c                                      |   16 +
 drivers/tty/serial/8250/8250_pci.c                                      |   76 ++---
 drivers/tty/serial/8250/8250_pci1xxxx.c                                 |   60 +++-
 drivers/tty/serial/8250/8250_port.c                                     |    9 
 drivers/tty/serial/serial_port.c                                        |    5 
 drivers/ufs/core/ufs_bsg.c                                              |    1 
 drivers/ufs/core/ufshcd.c                                               |  127 ++++----
 drivers/usb/class/cdc-acm.c                                             |   28 +
 drivers/usb/core/hub.c                                                  |   14 
 drivers/usb/core/quirks.c                                               |    6 
 drivers/usb/dwc2/gadget.c                                               |    1 
 drivers/usb/dwc3/gadget.c                                               |   34 ++
 drivers/usb/gadget/function/f_midi.c                                    |   17 -
 drivers/usb/gadget/udc/core.c                                           |    2 
 drivers/usb/gadget/udc/renesas_usb3.c                                   |    2 
 drivers/usb/host/pci-quirks.c                                           |    9 
 drivers/usb/host/xhci-pci.c                                             |    7 
 drivers/usb/roles/class.c                                               |    5 
 drivers/usb/serial/option.c                                             |   49 +--
 drivers/vfio/pci/nvgrace-gpu/main.c                                     |   95 ++++--
 drivers/vfio/pci/vfio_pci_rdwr.c                                        |    1 
 drivers/vfio/platform/vfio_platform_common.c                            |   10 
 drivers/video/fbdev/omap/lcd_dma.c                                      |    4 
 drivers/xen/swiotlb-xen.c                                               |   20 -
 fs/btrfs/extent_io.c                                                    |   29 +
 fs/btrfs/file.c                                                         |    4 
 fs/nfs/sysfs.c                                                          |    6 
 fs/nfsd/filecache.c                                                     |   11 
 fs/nfsd/nfs2acl.c                                                       |    2 
 fs/nfsd/nfs3acl.c                                                       |    2 
 fs/nfsd/nfs4callback.c                                                  |    7 
 fs/ntfs3/attrib.c                                                       |    4 
 fs/ntfs3/dir.c                                                          |    2 
 fs/ntfs3/frecord.c                                                      |   12 
 fs/ntfs3/fsntfs.c                                                       |    6 
 fs/ntfs3/index.c                                                        |    6 
 fs/ntfs3/inode.c                                                        |    3 
 fs/orangefs/orangefs-debugfs.c                                          |    4 
 fs/smb/client/cifsglob.h                                                |    1 
 fs/smb/client/file.c                                                    |    7 
 include/drm/display/drm_dp.h                                            |    1 
 include/kunit/platform_device.h                                         |    1 
 include/linux/blk-mq.h                                                  |   18 -
 include/linux/cgroup-defs.h                                             |    6 
 include/linux/efi.h                                                     |    1 
 include/linux/netdevice.h                                               |    6 
 include/linux/pci_ids.h                                                 |   11 
 include/linux/sched/task.h                                              |    1 
 include/net/dst.h                                                       |    9 
 include/net/ip.h                                                        |   13 
 include/net/l3mdev.h                                                    |    2 
 include/net/net_namespace.h                                             |    2 
 include/net/route.h                                                     |    9 
 include/ufs/ufshcd.h                                                    |    9 
 io_uring/kbuf.c                                                         |   15 -
 io_uring/uring_cmd.c                                                    |    3 
 io_uring/waitid.c                                                       |    4 
 kernel/cgroup/cgroup.c                                                  |   20 -
 kernel/cgroup/rstat.c                                                   |    1 
 kernel/sched/autogroup.c                                                |    4 
 kernel/sched/core.c                                                     |    7 
 kernel/sched/ext.c                                                      |   35 --
 kernel/sched/ext.h                                                      |    4 
 kernel/sched/sched.h                                                    |    2 
 kernel/time/clocksource.c                                               |    9 
 kernel/trace/ring_buffer.c                                              |   28 +
 kernel/trace/trace.c                                                    |    4 
 kernel/workqueue.c                                                      |   12 
 net/ax25/af_ax25.c                                                      |   11 
 net/batman-adv/bat_v.c                                                  |    2 
 net/batman-adv/bat_v_elp.c                                              |  122 +++++---
 net/batman-adv/bat_v_elp.h                                              |    2 
 net/batman-adv/types.h                                                  |    3 
 net/can/j1939/socket.c                                                  |    4 
 net/can/j1939/transport.c                                               |    5 
 net/core/fib_rules.c                                                    |   24 -
 net/core/flow_dissector.c                                               |   21 -
 net/core/neighbour.c                                                    |    8 
 net/ipv4/arp.c                                                          |    4 
 net/ipv4/devinet.c                                                      |    3 
 net/ipv4/icmp.c                                                         |   31 +-
 net/ipv4/route.c                                                        |   39 ++
 net/ipv6/icmp.c                                                         |   42 +-
 net/ipv6/ioam6_iptunnel.c                                               |   75 ++---
 net/ipv6/mcast.c                                                        |   45 +--
 net/ipv6/ndisc.c                                                        |   24 -
 net/ipv6/route.c                                                        |    7 
 net/ipv6/rpl_iptunnel.c                                                 |   59 ++-
 net/ipv6/seg6_iptunnel.c                                                |   98 ++++--
 net/openvswitch/datapath.c                                              |   12 
 net/vmw_vsock/af_vsock.c                                                |   12 
 rust/Makefile                                                           |    1 
 rust/kernel/rbtree.rs                                                   |    2 
 scripts/Makefile.defconf                                                |   13 
 scripts/Makefile.extrawarn                                              |   13 
 scripts/kconfig/Makefile                                                |    4 
 sound/soc/intel/boards/bytcr_rt5640.c                                   |   17 +
 tools/objtool/check.c                                                   |    1 
 tools/sched_ext/include/scx/common.bpf.h                                |   12 
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c                       |    6 
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c              |    9 
 tools/testing/selftests/gpio/gpio-sim.sh                                |   31 +-
 tools/testing/selftests/net/pmtu.sh                                     |  112 ++++++-
 tools/testing/selftests/net/rtnetlink.sh                                |    4 
 tools/tracing/rtla/src/timerlat_hist.c                                  |    8 
 tools/tracing/rtla/src/timerlat_top.c                                   |    8 
 226 files changed, 2386 insertions(+), 1012 deletions(-)

Aaro Koskinen (1):
      fbdev: omap: use threaded IRQ for LCD DMA

Aditya Kumar Singh (1):
      wifi: ath12k: fix handling of 6 GHz rules

Alan Stern (1):
      USB: hub: Ignore non-compliant devices with too many configs or interfaces

Alexander Hölzl (1):
      can: j1939: j1939_sk_send_loop(): fix unable to send messages with data length zero

Andrea Righi (1):
      sched_ext: Fix lock imbalance in dispatch_to_local_dsq()

Andrew Cooper (1):
      x86/static-call: Remove early_boot_irqs_disabled check to fix Xen PVH dom0

Andy Shevchenko (9):
      pinctrl: cy8c95x0: Avoid accessing reserved registers
      pinctrl: cy8c95x0: Enable regmap locking for debug
      pinctrl: cy8c95x0: Rename PWMSEL to SELPWM
      pinctrl: cy8c95x0: Respect IRQ trigger settings from firmware
      gpiolib: Fix crash on error in gpiochip_get_ngpios()
      serial: 8250_pci: Resolve WCH vendor ID ambiguity
      serial: 8250_pci: Share WCH IDs with parport_serial driver
      serial: port: Assign ->iotype correctly when ->iobase is set
      serial: port: Always update ->iotype in __uart_read_properties()

Andy Strohman (1):
      batman-adv: fix panic during interface removal

Andy-ld Lu (1):
      mmc: mtk-sd: Fix register settings for hs400(es) mode

Ankit Agrawal (2):
      vfio/nvgrace-gpu: Read dvsec register to determine need for uncached resmem
      vfio/nvgrace-gpu: Expose the blackwell device PF BAR1 to the VM

Ard Biesheuvel (1):
      efi: Avoid cold plugged memory for placing the kernel

Arnd Bergmann (1):
      media: cxd2841er: fix 64-bit division on gcc-9

Artur Weber (3):
      gpio: bcm-kona: Fix GPIO lock/unlock for banks above bank 0
      gpio: bcm-kona: Make sure GPIO bits are unlocked when requesting IRQ
      gpio: bcm-kona: Add missing newline to dev_err format string

Avri Altman (5):
      scsi: ufs: core: Introduce ufshcd_has_pending_tasks()
      scsi: ufs: core: Prepare to introduce a new clock_gating lock
      scsi: ufs: core: Introduce a new clock_gating lock
      scsi: ufs: Fix toggling of clk_gating.state when clock gating is not allowed
      scsi: ufs: core: Ensure clk_gating.lock is used only after initialization

Bibo Mao (1):
      LoongArch: KVM: Fix typo issue about GCFG feature detection

Bjorn Helgaas (1):
      PCI: Avoid FLR for Mediatek MT7922 WiFi

Brian Norris (1):
      kunit: platform: Resolve 'struct completion' warning

Charles Han (2):
      HID: winwing: Add NULL check in winwing_init_led()
      HID: multitouch: Add NULL check in mt_input_configured

Chester A. Unal (1):
      USB: serial: option: add MeiG Smart SLM828

Chris Brandt (1):
      drm: renesas: rz-du: Increase supported resolutions

Christian Gmeiner (1):
      drm/v3d: Stop active perfmon if it is being destroyed

Chuyi Zhou (2):
      sched_ext: Fix the incorrect bpf_list kfunc API in common.bpf.h.
      sched_ext: Use SCX_CALL_OP_TASK in task_tick_scx

Claudiu Beznea (1):
      pinctrl: pinconf-generic: Print unsigned value if a format is registered

Dai Ngo (1):
      NFSD: fix hang in nfsd4_shutdown_callback

Dan Carpenter (1):
      drm/msm/gem: prevent integer overflow in msm_ioctl_gem_submit()

David Sterba (1):
      btrfs: rename __get_extent_map() and pass btrfs_inode

Devarsh Thakkar (2):
      drm/tidss: Fix race condition while handling interrupt registers
      drm/tidss: Clear the interrupt status for interrupts being disabled

Dhananjay Ugwekar (7):
      cpufreq/amd-pstate: Call cppc_set_epp_perf in the reenable function
      cpufreq/amd-pstate: Align offline flow of shared memory and MSR based systems
      cpufreq/amd-pstate: Refactor amd_pstate_epp_reenable() and amd_pstate_epp_offline()
      cpufreq/amd-pstate: Remove the cppc_state check in offline/online functions
      cpufreq/amd-pstate: Merge amd_pstate_epp_cpu_offline() and amd_pstate_epp_offline()
      cpufreq/amd-pstate: Fix cpufreq_policy ref counting
      cpufreq/amd-pstate: Remove the goto label in amd_pstate_update_limits

Dmitry Baryshkov (1):
      drm/msm/dpu1: don't choke on disabling the writeback connector

Edward Adam Davis (1):
      media: vidtv: Fix a null-ptr-deref in vidtv_mux_stop_thread

Elson Roy Serrao (1):
      usb: roles: set switch registered flag early on

Eric Dumazet (23):
      net: fib_rules: annotate data-races around rule->[io]ifindex
      ndisc: ndisc_send_redirect() must use dev_get_by_index_rcu()
      vrf: use RCU protection in l3mdev_l3_out()
      vxlan: check vxlan_vnigroup_init() return value
      team: better TEAM_OPTION_TYPE_STRING validation
      ipv4: add RCU protection to ip4_dst_hoplimit()
      ipv4: use RCU protection in ip_dst_mtu_maybe_forward()
      net: add dev_net_rcu() helper
      ipv4: use RCU protection in ipv4_default_advmss()
      ipv4: use RCU protection in rt_is_expired()
      ipv4: use RCU protection in inet_select_addr()
      ipv4: use RCU protection in __ip_rt_update_pmtu()
      ipv4: icmp: convert to dev_net_rcu()
      flow_dissector: use RCU protection to fetch dev_net()
      ipv6: use RCU protection in ip6_default_advmss()
      ipv6: icmp: convert to dev_net_rcu()
      ndisc: use RCU protection in ndisc_alloc_skb()
      neighbour: use RCU protection in __neigh_notify()
      arp: use RCU protection in arp_xmit()
      openvswitch: use RCU protection in ovs_vport_cmd_fill_info()
      ndisc: extend RCU protection in ndisc_send_skb()
      ipv6: mcast: extend RCU protection in igmp6_send()
      ipv6: mcast: add RCU protection to mld_newpack()

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FN990B compositions
      USB: serial: option: fix Telit Cinterion FN990A name

Fabrice Gasnier (1):
      usb: dwc2: gadget: remove of_node reference upon udc_stop

Fedor Pchelkin (1):
      can: ctucanfd: handle skb allocation failure

Filipe Manana (2):
      btrfs: fix hole expansion when writing at an offset beyond EOF
      btrfs: fix stale page cache after race between readahead and direct IO write

Greg Kroah-Hartman (2):
      Revert "vfio/platform: check the bounds of read/write syscalls"
      Linux 6.12.16

Guixin Liu (1):
      scsi: ufs: bsg: Set bsg_queue to NULL after removal

Guo Ren (1):
      usb: gadget: udc: renesas_usb3: Fix compiler warning

Hangbin Liu (2):
      netdevsim: print human readable IP address
      selftests: rtnetlink: update netdevsim ipsec output format

Hans de Goede (2):
      ACPI: x86: Add skip i2c clients quirk for Vexia EDU ATLA 10 tablet 5V
      ASoC: Intel: bytcr_rt5640: Add DMI quirk for Vexia Edu Atla 10 tablet 5V

Huacai Chen (1):
      USB: pci-quirks: Fix HCCPARAMS register error for LS7A EHCI

Imre Deak (1):
      drm: Fix DSC BPP increment decoding

Isaac Scott (3):
      media: uvcvideo: Implement dual stream quirk to fix loss of usb packets
      media: uvcvideo: Add new quirk definition for the Sonix Technology Co. 292a camera
      media: uvcvideo: Add Kurokesu C1 PRO camera

Ivan Kokshaysky (3):
      alpha: make stack 16-byte aligned (most cases)
      alpha: replace hardcoded stack offsets with autogenerated ones
      alpha: align stack for page fault and user unaligned trap handlers

Jakub Kicinski (2):
      net: ipv6: fix dst ref loops in rpl, seg6 and ioam6 lwtunnels
      net: ipv6: fix dst refleaks in rpl, seg6 and ioam6 lwtunnels

Jann Horn (3):
      usb: cdc-acm: Check control transfer buffer size before access
      usb: cdc-acm: Fix handling of oversized fragments
      partitions: mac: fix handling of bogus partition table

Jarkko Nikula (2):
      i3c: mipi-i3c-hci: Add Intel specific quirk to ring resuming
      i3c: mipi-i3c-hci: Add support for MIPI I3C HCI on PCI bus

Jason Xing (1):
      bpf: handle implicit declaration of function gettid in bpf_iter.c

Jeff Layton (1):
      nfsd: validate the nfsd_serv pointer before calling svc_wake_up

Jens Axboe (2):
      io_uring/uring_cmd: remove dead req_has_async_data() check
      block: cleanup and fix batch completion adding conditions

Jiang Liu (2):
      drm/amdgpu: bail out when failed to load fw in psp_init_cap_microcode()
      drm/amdgpu: avoid buffer overflow attach in smu_sys_set_pp_table()

Jiasheng Jiang (1):
      regmap-irq: Add missing kfree()

Jiri Olsa (1):
      selftests/bpf: Fix uprobe consumer test

Johan Hovold (1):
      USB: serial: option: drop MeiG Smart defines

John Keeping (2):
      usb: gadget: f_midi: fix MIDI Streaming descriptor lengths
      serial: 8250: Fix fifo underflow on flush

Joshua Hay (1):
      idpf: call set_real_num_queues in idpf_open

Juergen Gross (2):
      xen/swiotlb: relax alignment requirements
      x86/xen: allow larger contiguous memory regions in PV guests

Justin Iurman (4):
      include: net: add static inline dst_dev_overhead() to dst.h
      net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue
      net: ipv6: seg6_iptunnel: mitigate 2-realloc issue
      net: ipv6: rpl_iptunnel: mitigate 2-realloc issue

Justin M. Forbes (1):
      rust: kbuild: add -fzero-init-padding-bits to bindgen_skip_cflags

Kan Liang (2):
      perf/x86/intel: Clean up PEBS-via-PT on hybrid
      perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF

Kartik Rajput (1):
      soc/tegra: fuse: Update Tegra234 nvmem keepout list

Kees Cook (1):
      kbuild: Use -fzero-init-padding-bits=all

Kiran K (1):
      Bluetooth: btintel_pcie: Fix a potential race condition

Koichiro Den (1):
      selftests: gpio: gpio-sim: Fix missing chip disablements

Konstantin Komarov (1):
      fs/ntfs3: Unify inode corruption marking with _ntfs_bad_inode()

Krzysztof Karas (1):
      drm/i915/selftests: avoid using uninitialized context

Krzysztof Kozlowski (2):
      firmware: qcom: scm: smc: Handle missing SCM device
      can: c_can: fix unbalanced runtime PM disable in error path

Kunihiko Hayashi (1):
      spi: sn-f-ospi: Fix division by zero

Lai Jiangshan (1):
      workqueue: Put the pwq after detaching the rescuer from the pool

Lei Huang (1):
      USB: quirks: add USB_QUIRK_NO_LPM quirk for Teclast dist

Li Lingfeng (1):
      nfsd: clear acl_access/acl_default after releasing them

Lu Baolu (1):
      iommu: Fix potential memory leak in iopf_queue_remove_device()

Maksym Planeta (1):
      Grab mm lock before grabbing pt lock

Marco Crivellari (1):
      LoongArch: Fix idle VS timer enqueue

Marek Vasut (1):
      USB: cdc-acm: Fill in Renesas R-Car D3 USB Download mode quirk

Mario Limonciello (2):
      gpiolib: acpi: Add a quirk for Acer Nitro ANV14
      cpufreq/amd-pstate: convert mutex use to guard()

Masahiro Yamada (2):
      tools: fix annoying "mkdir -p ..." logs when building tools in parallel
      kbuild: suppress stdout from merge_config for silent builds

Mathias Nyman (1):
      USB: Add USB_QUIRK_NO_LPM quirk for sony xperia xz1 smartphone

Maxime Ripard (1):
      drm/tests: hdmi: Fix WW_MUTEX_SLOWPATH failures

Michael Margolin (1):
      RDMA/efa: Reset device on probe failure

Michal Luczaj (2):
      vsock: Keep the binding until socket destruction
      vsock: Orphan socket after transport release

Michal Pecio (1):
      usb: xhci: Restore xhci_pci support for Renesas HCs

Miguel Ojeda (3):
      arm64: rust: clean Rust 1.85.0 warning using softfloat target
      objtool/rust: add one more `noreturn` Rust function
      rust: rbtree: fix overindented list item

Mike Marshall (1):
      orangefs: fix a oob in orangefs_debug_write

Muhammad Adeel (1):
      cgroup: Remove steal time from usage_usec

Murad Masimov (1):
      ax25: Fix refcount leak caused by setting SO_BINDTODEVICE sockopt

Nathan Chancellor (2):
      scripts/Makefile.extrawarn: Do not show clang's non-kprintf warnings at W=1
      arm64: Handle .ARM.attributes section in linker scripts

Naushir Patuck (1):
      media: bcm2835-unicam: Disable trigger mode operation

Niklas Schnelle (2):
      s390/pci: Pull search for parent PF out of zpci_iov_setup_virtfn()
      s390/pci: Fix handling of isolated VFs

Patrick Bellasi (1):
      x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit

Pavel Begunkov (2):
      io_uring/waitid: don't abuse io_tw_state
      io_uring/kbuf: reallocate buf lists on upgrade

Ping-Ke Shih (1):
      wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit

Radu Rendec (1):
      arm64: cacheinfo: Avoid out-of-bounds write to cacheinfo array

Rakesh Babu Saladi (1):
      PCI: switchtec: Add Microchip PCI100X device IDs

Ramesh Thomas (1):
      vfio/pci: Enable iowrite64 and ioread64 for vfio pci

Rengarajan S (1):
      8250: microchip: pci1xxxx: Add workaround for RTS bit toggle

Reyders Morales (1):
      Documentation/networking: fix basic node example document ISO 15765-2

Rik van Riel (1):
      x86/mm/tlb: Only trim the mm_cpumask once a second

Robin van der Gracht (1):
      can: rockchip: rkcanfd_handle_rx_fifo_overflow_int(): bail out if skb cannot be allocated

Roger Quadros (2):
      net: ethernet: ti: am65-cpsw: fix memleak in certain XDP cases
      net: ethernet: ti: am65_cpsw: fix tx_cleanup for XDP case

Roy Luo (1):
      usb: gadget: core: flush gadget workqueue after device removal

Rupinderjit Singh (1):
      gpu: host1x: Fix a use of uninitialized mutex

Sean Christopherson (4):
      KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if local APIC isn't in-kernel
      KVM: x86: Load DR6 with guest value only before entering .vcpu_run() loop
      KVM: nSVM: Enter guest mode before initializing nested NPT MMU
      perf/x86/intel: Ensure LBRs are disabled when a CPU is starting

Selvarasu Ganesan (2):
      usb: gadget: f_midi: Fixing wMaxPacketSize exceeded issue during MIDI bind retries
      usb: dwc3: Fix timeout issue during controller enter/exit from halt state

Shakeel Butt (1):
      cgroup: fix race between fork and cgroup.kill

Shyam Prasad N (1):
      cifs: pick channels for individual subrequests

Song Yoong Siang (1):
      igc: Set buffer type for empty frames in igc_init_empty_frame

Sridhar Samudrala (2):
      idpf: fix handling rsc packet with a single segment
      idpf: record rx queue in skb for RSC packets

Stefan Eichenberger (1):
      usb: core: fix pipe creation for get_bMaxPacketSize0

Stephan Gerhold (1):
      drm/msm/dpu: fix x1e80100 intf_6 underrun/vsync interrupt

Steven Rostedt (4):
      ring-buffer: Unlock resize on mmap error
      tracing: Do not allow mmap() of persistent ring buffer
      ring-buffer: Validate the persistent meta data subbuf array
      ring-buffer: Update pages_touched to reflect persistent buffer content

Sven Eckelmann (2):
      batman-adv: Ignore neighbor throughput metrics in error case
      batman-adv: Drop unmanaged ELP metric worker

Takashi Iwai (1):
      PCI/DPC: Quirk PIO log size for Intel Raptor Lake-P

Tejas Upadhyay (1):
      drm/xe/client: bo->client does not need bos_lock

Tejun Heo (1):
      sched_ext: Fix incorrect autogroup migration detection

Thomas Hellström (1):
      drm/xe/tracing: Fix a potential TP_printk UAF

Thomas Weißschuh (1):
      kbuild: userprogs: fix bitsize and target detection on clang

Tomas Glozar (2):
      rtla/timerlat_hist: Abort event processing on second signal
      rtla/timerlat_top: Abort event processing on second signal

Tomi Valkeinen (4):
      media: i2c: ds90ub913: Add error handling to ub913_hw_init()
      media: i2c: ds90ub953: Add error handling for i2c reads/writes
      drm/tidss: Fix issue in irq handling causing irq-flood issue
      drm/rcar-du: dsi: Fix PHY lock bit check

Tulio Fernandes (1):
      HID: hid-thrustmaster: fix stack-out-of-bounds read in usb_check_int_endpoints()

Varadarajan Narayanan (1):
      regulator: qcom_smd: Add l2, l5 sub-node to mp5496 regulator

Vasant Hegde (1):
      iommu/amd: Expicitly enable CNTRL.EPHEn bit in resume path

Vicki Pfau (3):
      HID: hid-steam: Don't use cancel_delayed_work_sync in IRQ context
      HID: hid-steam: Make sure rumble work is canceled on removal
      HID: hid-steam: Move hidraw input (un)registering to work

Vincent Mailhol (1):
      can: etas_es58x: fix potential NULL pointer dereference on udev->serial

Vladimir Vdovin (1):
      net: ipv4: Cache pmtu for all packet paths if multipath enabled

Waiman Long (2):
      clocksource: Use pr_info() for "Checking clocksource synchronization" message
      clocksource: Use migrate_disable() to avoid calling get_random_u32() in atomic context

Wentao Liang (2):
      gpio: stmpe: Check return value of stmpe_reg_read in stmpe_gpio_irq_sync_unlock
      mlxsw: Add return value check for mlxsw_sp_port_get_stats_raw()

Yuli Wang (1):
      LoongArch: csum: Fix OoB access in IP checksum code for negative lengths

Zdenek Bouska (1):
      igc: Fix HW RX timestamp when passed by ZC XDP

Zhu Lingshan (1):
      amdkfd: properly free gang_ctx_bo when failed to init user queue

Zichen Xie (1):
      NFS: Fix potential buffer overflowin nfs_sysfs_link_rpc_client()


