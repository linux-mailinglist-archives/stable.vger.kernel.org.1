Return-Path: <stable+bounces-75982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0950D976819
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 13:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6F51F215C8
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 11:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14E619F430;
	Thu, 12 Sep 2024 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QkazCQ/i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72170185B5C;
	Thu, 12 Sep 2024 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141692; cv=none; b=LAua7j4qMK3wtEfRqfAMVNZZQketuEe2yQNKiKsxCm5LYfxaQwLOTmop1PU83fJcgPvDvmkELSm3Vw061CtAecenUQtMzkH0rwlrlyin/psZFMm6ttRvfdx6seJMbC3C2rv47FKqsYnpfpihEtiJTjm5wY2M7vdL6b4iRXplBzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141692; c=relaxed/simple;
	bh=WtAaRdOqx2elMZacmp2UQRLiILTkHHX4bpxeHoW33vk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u47q2HfFDf+Yc9bejMO8VICPG90wXkfQaeK0FWB1jp7ysEdzoxii7zc4z2jyF2N5fV8eSIXqLX2lfrmvKykNANe8gyqn+a0Ftsppaq4/g0M2jRNNiElaD8Uc1v5dXA5tgeb2yrmncl4C3ZmDAW/pdjqk+tPPhXDjs9zej6ydElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QkazCQ/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECEEC4CEC3;
	Thu, 12 Sep 2024 11:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726141691;
	bh=WtAaRdOqx2elMZacmp2UQRLiILTkHHX4bpxeHoW33vk=;
	h=From:To:Cc:Subject:Date:From;
	b=QkazCQ/itFMd33Ea5bmTJr5udf+cngyBuVcuk425BI0Bsjb8FF/3sAhoUl9XmnMi7
	 kTAdY9FmlQnIMDisWYg2KWn0GyvRQ6fC21S9cPRg/g4nDCF2wZ8BJkZXhpXmW1iMyv
	 FtfOM5Ys+pMI4uI2cJeqzeXFuMDWlhStev09D+oo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.322
Date: Thu, 12 Sep 2024 13:48:06 +0200
Message-ID: <2024091207-muster-slapping-175b@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.19.322 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/parisc/kernel/irq.c                                       |    4 
 arch/um/drivers/line.c                                         |    2 
 block/bio-integrity.c                                          |   11 
 drivers/acpi/acpi_processor.c                                  |   15 -
 drivers/ata/libata-core.c                                      |    4 
 drivers/ata/pata_macio.c                                       |    7 
 drivers/base/devres.c                                          |    1 
 drivers/clk/qcom/clk-alpha-pll.c                               |    2 
 drivers/clocksource/timer-imx-tpm.c                            |   16 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c                       |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c                   |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c                        |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                       |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h                          |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                      |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h                      |    5 
 drivers/gpu/drm/i915/i915_sw_fence.c                           |    8 
 drivers/hid/hid-cougar.c                                       |    2 
 drivers/hv/vmbus_drv.c                                         |    1 
 drivers/hwmon/adc128d818.c                                     |    4 
 drivers/hwmon/lm95234.c                                        |    9 
 drivers/hwmon/nct6775.c                                        |    2 
 drivers/hwmon/w83627ehf.c                                      |    4 
 drivers/iio/buffer/industrialio-buffer-dmaengine.c             |    4 
 drivers/iio/inkern.c                                           |    8 
 drivers/input/misc/uinput.c                                    |   14 +
 drivers/iommu/dmar.c                                           |    2 
 drivers/irqchip/irq-armada-370-xp.c                            |    4 
 drivers/media/platform/qcom/camss/camss.c                      |    5 
 drivers/media/usb/uvc/uvc_driver.c                             |   18 +
 drivers/misc/vmw_vmci/vmci_resource.c                          |    3 
 drivers/mmc/host/dw_mmc.c                                      |    4 
 drivers/net/dsa/vitesse-vsc73xx.c                              |   10 
 drivers/net/ethernet/intel/igb/igb_main.c                      |   10 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c       |    9 
 drivers/net/ethernet/rocker/rocker_main.c                      |    1 
 drivers/net/usb/ch9200.c                                       |    4 
 drivers/net/usb/cx82310_eth.c                                  |   56 +++-
 drivers/net/usb/ipheth.c                                       |    4 
 drivers/net/usb/kaweth.c                                       |    3 
 drivers/net/usb/mcs7830.c                                      |    4 
 drivers/net/usb/qmi_wwan.c                                     |    1 
 drivers/net/usb/sierra_net.c                                   |    6 
 drivers/net/usb/sr9700.c                                       |    4 
 drivers/net/usb/sr9800.c                                       |    5 
 drivers/net/usb/usbnet.c                                       |   23 -
 drivers/net/virtio_net.c                                       |    8 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c |    1 
 drivers/net/wireless/marvell/mwifiex/main.h                    |    3 
 drivers/nvmem/core.c                                           |    6 
 drivers/of/irq.c                                               |   15 -
 drivers/pci/hotplug/pnv_php.c                                  |    3 
 drivers/pci/pci.c                                              |   35 +-
 drivers/pcmcia/yenta_socket.c                                  |    6 
 drivers/platform/x86/dell-smbios-base.c                        |    5 
 drivers/uio/uio_hv_generic.c                                   |   11 
 drivers/usb/dwc3/dwc3-st.c                                     |   12 
 drivers/usb/usbip/stub_rx.c                                    |   77 +++---
 fs/btrfs/extent-tree.c                                         |   32 +-
 fs/btrfs/inode.c                                               |    2 
 fs/fuse/xattr.c                                                |    4 
 fs/nilfs2/recovery.c                                           |   35 ++
 fs/nilfs2/segment.c                                            |   10 
 fs/nilfs2/sysfs.c                                              |  117 +++++----
 fs/squashfs/inode.c                                            |    7 
 fs/udf/super.c                                                 |   24 +
 include/linux/ring_buffer.h                                    |    3 
 include/net/net_namespace.h                                    |    5 
 include/net/switchdev.h                                        |    3 
 include/uapi/linux/neighbour.h                                 |    1 
 kernel/cgroup/cgroup.c                                         |    2 
 kernel/events/uprobes.c                                        |    3 
 kernel/locking/rtmutex.c                                       |    4 
 kernel/smp.c                                                   |    1 
 kernel/trace/ring_buffer.c                                     |   23 -
 kernel/trace/trace.c                                           |    6 
 kernel/trace/trace_functions_graph.c                           |    2 
 net/bridge/br.c                                                |    4 
 net/bridge/br_fdb.c                                            |  128 +++++-----
 net/bridge/br_input.c                                          |    2 
 net/bridge/br_private.h                                        |   18 -
 net/bridge/br_switchdev.c                                      |   11 
 net/can/bcm.c                                                  |    4 
 net/core/net_namespace.c                                       |   28 ++
 net/dsa/slave.c                                                |    1 
 net/ipv6/ila/ila.h                                             |    1 
 net/ipv6/ila/ila_main.c                                        |    6 
 net/ipv6/ila/ila_xlat.c                                        |   13 -
 net/netfilter/nf_conncount.c                                   |    8 
 net/rfkill/core.c                                              |    4 
 net/sched/sch_netem.c                                          |    9 
 net/sunrpc/xprtsock.c                                          |    7 
 net/unix/af_unix.c                                             |    9 
 security/apparmor/apparmorfs.c                                 |    4 
 security/smack/smack_lsm.c                                     |   14 -
 sound/hda/hdmi_chmap.c                                         |   18 +
 sound/pci/hda/patch_conexant.c                                 |   11 
 sound/usb/helper.c                                             |   17 +
 sound/usb/helper.h                                             |    1 
 sound/usb/quirks.c                                             |   14 -
 101 files changed, 768 insertions(+), 345 deletions(-)

Aleksandr Mishin (1):
      platform/x86: dell-smbios: Fix error path in dell_smbios_init()

Andy Shevchenko (2):
      drm/i915/fence: Mark debug_fence_init_onstack() with __maybe_unused
      drm/i915/fence: Mark debug_fence_free() with __maybe_unused

Arend van Spriel (1):
      wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3

Breno Leitao (1):
      virtio_net: Fix napi_skb_cache_put warning

Camila Alvarez (1):
      HID: cougar: fix slab-out-of-bounds Read in cougar_report_fixup

Casey Schaufler (1):
      smack: tcp: ipv4, fix incorrect labeling

Chen Ni (1):
      media: qcom: camss: Add check for v4l2_fwnode_endpoint_parse

Christoffer Sandberg (1):
      ALSA: hda/conexant: Add pincfg quirk to enable top speakers on Sirius devices

Christoph Hellwig (1):
      block: initialize integrity buffer to zero before writing it to media

Daiwei Li (1):
      igb: Fix not clearing TimeSync interrupts for 82580

Dan Williams (1):
      PCI: Add missing bridge lock to pci_bus_lock()

Daniel Borkmann (1):
      net, sunrpc: Remap EPERM in case of connection failure in xs_tcp_setup_socket

David Fernandez Gonzalez (1):
      VMCI: Fix use-after-free when removing resource in vmci_resource_remove()

David Lechner (1):
      iio: buffer-dmaengine: fix releasing dma channel on error

David Sterba (1):
      btrfs: initialize location to fix -Wmaybe-uninitialized in btrfs_lookup_dentry()

Dmitry Torokhov (1):
      Input: uinput - reject requests with unreasonable number of slots

Eric Dumazet (2):
      netns: add pre_exit method to struct pernet_operations
      ila: call nf_unregister_net_hooks() sooner

Geert Uytterhoeven (1):
      nvmem: Fix return type of devm_nvmem_device_get() in kerneldoc

Greg Kroah-Hartman (2):
      Revert "parisc: Use irq_enter_rcu() to fix warning at kernel/context_tracking.c:367"
      Linux 4.19.322

Guenter Roeck (4):
      hwmon: (adc128d818) Fix underflows seen when writing limit attributes
      hwmon: (lm95234) Fix underflows seen when writing limit attributes
      hwmon: (nct6775-core) Fix underflows seen when writing limit attributes
      hwmon: (w83627ehf) Fix underflows seen when writing limit attributes

Hillf Danton (1):
      ALSA: usb-audio: Fix gpf in snd_usb_pipe_sanity_check

Ido Schimmel (1):
      bridge: switchdev: Allow clearing FDB entry offload indication

Jacky Bai (2):
      clocksource/drivers/imx-tpm: Fix return -ETIME when delta exceeds INT_MAX
      clocksource/drivers/imx-tpm: Fix next event not taking effect sometime

Jacob Pan (1):
      iommu/vt-d: Handle volatile descriptor status read

Jakub Kicinski (1):
      net: usb: don't write directly to netdev->dev_addr

Jan Kara (2):
      udf: Limit file size to 4TB
      udf: Avoid excessive partition lengths

Jann Horn (1):
      fuse: use unsigned type for getxattr/listxattr size truncation

Johannes Berg (1):
      um: line: always fill *error_out in setup_one_line()

Jonas Gorski (1):
      net: bridge: br_fdb_external_learn_add(): always set EXT_LEARN

Jonathan Cameron (2):
      ACPI: processor: Return an error if acpi_processor_get_info() fails in processor_add()
      ACPI: processor: Fix memory leaks in error paths of processor_add()

Josef Bacik (2):
      btrfs: replace BUG_ON with ASSERT in walk_down_proc()
      btrfs: clean up our handling of refs == 0 in snapshot delete

Jules Irenge (1):
      pcmcia: Use resource_size function on resource object

Konstantin Andreev (1):
      smack: unix sockets: fix accept()ed socket label

Krishna Kumar (1):
      pci/hotplug/pnv_php: Fix hotplug driver crash on Powernv

Krzysztof Kozlowski (1):
      usb: dwc3: st: add missing depopulate in probe error path

Kuniyuki Iwashima (2):
      af_unix: Remove put_pid()/put_cred() in copy_peercred().
      can: bcm: Remove proc entry when dev is unregistered.

Leesoo Ahn (1):
      apparmor: fix possible NULL pointer dereference

Len Baker (1):
      drivers/net/usb: Remove all strcpy() uses

Li RongQing (1):
      netns: restore ops before calling ops_exit_list

Ma Jun (1):
      drm/amdgpu: Fix uninitialized variable warning in amdgpu_afmt_acr

Matteo Martelli (1):
      iio: fix scale application in iio_convert_raw_to_processed_unlocked

Michael Chen (1):
      drm/amdkfd: Reconcile the definition and use of oem_id in struct kfd_topology_device

Michael Ellerman (1):
      ata: pata_macio: Use WARN instead of BUG

Naman Jain (1):
      Drivers: hv: vmbus: Fix rescind handling in uio_hv_generic

Nikolay Aleksandrov (6):
      net: bridge: add support for sticky fdb entries
      net: bridge: fdb: convert is_local to bitops
      net: bridge: fdb: convert is_static to bitops
      net: bridge: fdb: convert is_sticky to bitops
      net: bridge: fdb: convert added_by_user to bitops
      net: bridge: fdb: convert added_by_external_learn to use bitops

Nishka Dasgupta (1):
      usb: dwc3: st: Add of_node_put() before return in probe function

Oliver Neukum (2):
      usbnet: modern method to get random MAC
      usbnet: ipheth: race between ipheth_close and error handling

Ondrej Zary (1):
      cx82310_eth: re-enable ethernet mode after router reboot

Pali Rohár (1):
      irqchip/armada-370-xp: Do not allow mapping IRQ 0 and 1

Pawel Dembicki (1):
      net: dsa: vsc73xx: fix possible subblocks range of CAPT block

Phillip Lougher (1):
      Squashfs: sanity check symbolic link size

Qing Wang (1):
      nilfs2: replace snprintf in show functions with sysfs_emit

Ricardo Ribalda (1):
      media: uvcvideo: Enforce alignment of frame and interval

Richard Guy Briggs (1):
      rfkill: fix spelling mistake contidion to condition

Roland Xu (1):
      rtmutex: Drop rt_mutex::wait_lock before scheduling

Ryusuke Konishi (3):
      nilfs2: fix missing cleanup on rollforward recovery error
      nilfs2: fix state management in error path of log writing function
      nilfs2: protect references to superblock parameters exposed in sysfs

Sam Protsenko (1):
      mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K

Sascha Hauer (1):
      wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()

Satya Priya Kakitapalli (1):
      clk: qcom: clk-alpha-pll: Fix the pll post div mask

Saurabh Sengar (1):
      uio_hv_generic: Fix kernel NULL pointer dereference in hv_uio_rescind

Simon Holesch (1):
      usbip: Don't submit special requests twice

Stefan Wiehler (1):
      of/irq: Prevent device address out-of-bounds read in interrupt map walk

Stephen Hemminger (1):
      sch/netem: fix use after free in netem_dequeue

Steven Rostedt (VMware) (1):
      ring-buffer: Rename ring_buffer_read() to read_buffer_iter_advance()

Sven Schnelle (1):
      uprobes: Use kzalloc to allocate xol area

Takashi Iwai (2):
      ALSA: usb-audio: Sanity checks for each pipe and EP types
      ALSA: hda: Add input value sanity checks to HDMI channel map controls

Tim Huang (3):
      drm/amdgpu: fix overflowed array index read warning
      drm/amdgpu: fix ucode out-of-bounds read warning
      drm/amdgpu: fix mc_data out-of-bounds read warning

Waiman Long (1):
      cgroup: Protect css->cgroup write under css_set_lock

Yunjian Wang (1):
      netfilter: nf_conncount: fix wrong variable type

ZHANG Yuntian (1):
      net: usb: qmi_wwan: add MeiG Smart SRM825L

Zhang Changzhong (1):
      cx82310_eth: fix error return code in cx82310_bind()

Zheng Qixing (1):
      ata: libata: Fix memory leak for error path in ata_host_alloc()

Zheng Yejian (1):
      tracing: Avoid possible softlockup in tracing_iter_reset()

Zijun Hu (1):
      devres: Initialize an uninitialized struct member

Zqiang (1):
      smp: Add missing destroy_work_on_stack() call in smp_call_on_cpu()


