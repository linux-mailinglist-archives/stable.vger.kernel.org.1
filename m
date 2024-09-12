Return-Path: <stable+bounces-75984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 487A197681D
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 13:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8B71C21A92
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 11:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F271A0BE8;
	Thu, 12 Sep 2024 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NR3ctinA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93C61A0BEA;
	Thu, 12 Sep 2024 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141703; cv=none; b=jWjOUIXXA87AYRHZRInsyyT4LeL/WFpxqbVFjoDgrTzP/+oRbSuVUNOUhwy8F6z5gWcf1nhshYuDwnytp4P95dbFjSONw3ZQN6qwLksnqiGsZnOepdCadoWl0F/ocp7wxmDiJkZJXm8b40nqxnpB8zbGD7yiNPpVg0azcIDeT5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141703; c=relaxed/simple;
	bh=wIfRyebPi8iOaHkeOuFLuKbf9MqsAXvLUUawnIa+BLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L2koCk8IHzwKH2S5mdC0wkmS1AUuWg+c+9+ufEAyOsuflJsn7bGbBKsHrepx53wdpeZQtA5OVf2CZUry/a8D7pet2rSXd80bjFHNlqJYe28YAEkR98VMOyydTNOrrOLFxt/SzsqJl/sK5EbuaUBx21viSAB5oAnYZf7X86ltH1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NR3ctinA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46AEC4CEC3;
	Thu, 12 Sep 2024 11:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726141703;
	bh=wIfRyebPi8iOaHkeOuFLuKbf9MqsAXvLUUawnIa+BLs=;
	h=From:To:Cc:Subject:Date:From;
	b=NR3ctinAmC3d9aW2Q4o7PDMJElyq8UljtALfDBsAr29dmlDgsBDsfMxvVcksUCFe8
	 F8PL+St4NFGHVTypUv10ftTZOS8s8LhjzdKfSYeZyw+zXHLchYBpkAAilQVXiY5UHi
	 DlgEe5bMHLrdQgWsKpKmOrAKYedNUvXBCC/gjy3g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.284
Date: Thu, 12 Sep 2024 13:48:14 +0200
Message-ID: <2024091215-pony-strenuous-81b7@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.284 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm64/include/asm/acpi.h                                  |   12 +
 arch/arm64/kernel/acpi_numa.c                                  |   11 
 arch/parisc/kernel/irq.c                                       |    4 
 arch/um/drivers/line.c                                         |    2 
 block/bio-integrity.c                                          |   11 
 drivers/acpi/acpi_processor.c                                  |   15 -
 drivers/android/binder.c                                       |    1 
 drivers/ata/libata-core.c                                      |    4 
 drivers/ata/pata_macio.c                                       |    7 
 drivers/base/devres.c                                          |    1 
 drivers/clk/hisilicon/clk-hi6220.c                             |    3 
 drivers/clk/qcom/clk-alpha-pll.c                               |    6 
 drivers/clocksource/timer-imx-tpm.c                            |   16 +
 drivers/clocksource/timer-of.c                                 |   17 -
 drivers/clocksource/timer-of.h                                 |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c                       |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c                   |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c                        |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                       |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h                          |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                      |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h                      |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |    5 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c      |    3 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c           |    3 
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c             |   17 +
 drivers/gpu/drm/drm_panel_orientation_quirks.c                 |    6 
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
 drivers/irqchip/irq-gic-v2m.c                                  |    6 
 drivers/md/dm-init.c                                           |    4 
 drivers/media/platform/qcom/camss/camss.c                      |    5 
 drivers/media/usb/uvc/uvc_driver.c                             |   18 +
 drivers/misc/vmw_vmci/vmci_resource.c                          |    3 
 drivers/mmc/host/dw_mmc.c                                      |    4 
 drivers/mmc/host/sdhci-of-aspeed.c                             |    1 
 drivers/net/dsa/vitesse-vsc73xx-core.c                         |   10 
 drivers/net/ethernet/intel/igb/igb_main.c                      |   10 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                |    2 
 drivers/net/usb/ch9200.c                                       |    4 
 drivers/net/usb/cx82310_eth.c                                  |   56 ++++
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
 drivers/nvme/target/tcp.c                                      |    4 
 drivers/nvmem/core.c                                           |    6 
 drivers/of/irq.c                                               |   15 -
 drivers/pci/controller/dwc/pci-keystone.c                      |   44 +++
 drivers/pci/hotplug/pnv_php.c                                  |    3 
 drivers/pci/pci.c                                              |   35 +-
 drivers/pcmcia/yenta_socket.c                                  |    6 
 drivers/platform/x86/dell-smbios-base.c                        |    5 
 drivers/reset/hisilicon/hi6220_reset.c                         |   69 +++++
 drivers/staging/iio/frequency/ad9834.c                         |    2 
 drivers/uio/uio_hv_generic.c                                   |   11 
 drivers/usb/storage/uas.c                                      |    1 
 drivers/usb/typec/ucsi/ucsi.h                                  |    2 
 drivers/usb/usbip/stub_rx.c                                    |   77 ++++--
 fs/btrfs/extent-tree.c                                         |   32 ++
 fs/btrfs/inode.c                                               |    2 
 fs/fuse/file.c                                                 |    8 
 fs/fuse/xattr.c                                                |    4 
 fs/nfs/super.c                                                 |    2 
 fs/nilfs2/recovery.c                                           |   35 ++
 fs/nilfs2/segment.c                                            |   10 
 fs/nilfs2/sysfs.c                                              |  117 +++++-----
 fs/squashfs/inode.c                                            |    7 
 fs/udf/super.c                                                 |   24 +-
 include/linux/i2c.h                                            |    2 
 include/linux/ring_buffer.h                                    |    3 
 kernel/cgroup/cgroup.c                                         |    2 
 kernel/events/uprobes.c                                        |    3 
 kernel/locking/rtmutex.c                                       |    4 
 kernel/smp.c                                                   |    1 
 kernel/trace/ring_buffer.c                                     |   23 -
 kernel/trace/trace.c                                           |    6 
 kernel/trace/trace_functions_graph.c                           |    2 
 lib/generic-radix-tree.c                                       |    2 
 net/bridge/br_fdb.c                                            |  116 ++++-----
 net/bridge/br_input.c                                          |    2 
 net/bridge/br_private.h                                        |   17 -
 net/bridge/br_switchdev.c                                      |    6 
 net/can/bcm.c                                                  |    4 
 net/ipv4/inet_hashtables.c                                     |    2 
 net/ipv4/tcp_bpf.c                                             |    2 
 net/ipv6/ila/ila.h                                             |    1 
 net/ipv6/ila/ila_main.c                                        |    6 
 net/ipv6/ila/ila_xlat.c                                        |   13 -
 net/netfilter/nf_conncount.c                                   |    8 
 net/sched/sch_cake.c                                           |   11 
 net/sched/sch_netem.c                                          |    9 
 net/sunrpc/xprtsock.c                                          |    7 
 net/unix/af_unix.c                                             |    9 
 net/wireless/scan.c                                            |   46 ++-
 security/apparmor/apparmorfs.c                                 |    4 
 security/smack/smack_lsm.c                                     |   14 -
 sound/hda/hdmi_chmap.c                                         |   18 +
 sound/pci/hda/patch_conexant.c                                 |   11 
 sound/soc/soc-dapm.c                                           |    1 
 sound/soc/soc-topology.c                                       |    2 
 tools/lib/bpf/libbpf.c                                         |    4 
 120 files changed, 899 insertions(+), 396 deletions(-)

Abhishek Pandit-Subedi (1):
      usb: typec: ucsi: Fix null pointer dereference in trace

Aleksandr Mishin (2):
      platform/x86: dell-smbios: Fix error path in dell_smbios_init()
      staging: iio: frequency: ad9834: Validate frequency parameter value

Alex Hung (3):
      drm/amd/display: Check gpio_id before used as array index
      drm/amd/display: Check num_valid_sets before accessing reader_wm_sets[]
      drm/amd/display: Skip wbscl_set_scaler_filter if filter is null

Amadeusz Sławiński (1):
      ASoC: topology: Properly initialize soc_enum values

Andreas Ziegler (1):
      libbpf: Add NULL checks to bpf_object__{prev_map,next_map}

Andy Shevchenko (2):
      drm/i915/fence: Mark debug_fence_init_onstack() with __maybe_unused
      drm/i915/fence: Mark debug_fence_free() with __maybe_unused

Arend van Spriel (1):
      wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3

Benjamin Marzinski (1):
      dm init: Handle minors larger than 255

Breno Leitao (1):
      virtio_net: Fix napi_skb_cache_put warning

Camila Alvarez (1):
      HID: cougar: fix slab-out-of-bounds Read in cougar_report_fixup

Carlos Llamas (1):
      binder: fix UAF caused by offsets overwrite

Casey Schaufler (1):
      smack: tcp: ipv4, fix incorrect labeling

Chen Ni (1):
      media: qcom: camss: Add check for v4l2_fwnode_endpoint_parse

Christoffer Sandberg (1):
      ALSA: hda/conexant: Add pincfg quirk to enable top speakers on Sirius devices

Christoph Hellwig (1):
      block: initialize integrity buffer to zero before writing it to media

Cong Wang (1):
      tcp_bpf: fix return value of tcp_bpf_sendmsg()

Daiwei Li (1):
      igb: Fix not clearing TimeSync interrupts for 82580

Dan Williams (1):
      PCI: Add missing bridge lock to pci_bus_lock()

Daniel Borkmann (1):
      net, sunrpc: Remap EPERM in case of connection failure in xs_tcp_setup_socket

Daniel Lezcano (1):
      clocksource/drivers/timer-of: Remove percpu irq related code

David Fernandez Gonzalez (1):
      VMCI: Fix use-after-free when removing resource in vmci_resource_remove()

David Lechner (1):
      iio: buffer-dmaengine: fix releasing dma channel on error

David Sterba (1):
      btrfs: initialize location to fix -Wmaybe-uninitialized in btrfs_lookup_dentry()

Dmitry Torokhov (1):
      Input: uinput - reject requests with unreasonable number of slots

Eric Dumazet (1):
      ila: call nf_unregister_net_hooks() sooner

Geert Uytterhoeven (1):
      nvmem: Fix return type of devm_nvmem_device_get() in kerneldoc

Greg Kroah-Hartman (2):
      Revert "parisc: Use irq_enter_rcu() to fix warning at kernel/context_tracking.c:367"
      Linux 5.4.284

Guenter Roeck (4):
      hwmon: (adc128d818) Fix underflows seen when writing limit attributes
      hwmon: (lm95234) Fix underflows seen when writing limit attributes
      hwmon: (nct6775-core) Fix underflows seen when writing limit attributes
      hwmon: (w83627ehf) Fix underflows seen when writing limit attributes

Hersen Wu (2):
      drm/amd/display: Stop amdgpu_dm initialize when stream nums greater than 6
      drm/amd/display: Fix Coverity INTEGER_OVERFLOW within dal_gpio_service_create

Jacky Bai (2):
      clocksource/drivers/imx-tpm: Fix return -ETIME when delta exceeds INT_MAX
      clocksource/drivers/imx-tpm: Fix next event not taking effect sometime

Jacob Pan (1):
      iommu/vt-d: Handle volatile descriptor status read

Jakub Kicinski (1):
      net: usb: don't write directly to netdev->dev_addr

James Morse (1):
      arm64: acpi: Move get_cpu_for_acpi_id() to a header

Jan Kara (2):
      udf: Limit file size to 4TB
      udf: Avoid excessive partition lengths

Jann Horn (1):
      fuse: use unsigned type for getxattr/listxattr size truncation

Joanne Koong (1):
      fuse: update stats for pages in dropped aux writeback list

Johannes Berg (2):
      wifi: cfg80211: make hash table duplicates more survivable
      um: line: always fill *error_out in setup_one_line()

Jonas Gorski (1):
      net: bridge: br_fdb_external_learn_add(): always set EXT_LEARN

Jonathan Cameron (3):
      ACPI: processor: Return an error if acpi_processor_get_info() fails in processor_add()
      ACPI: processor: Fix memory leaks in error paths of processor_add()
      arm64: acpi: Harden get_cpu_for_acpi_id() against missing CPU entry

Josef Bacik (2):
      btrfs: replace BUG_ON with ASSERT in walk_down_proc()
      btrfs: clean up our handling of refs == 0 in snapshot delete

Jules Irenge (1):
      pcmcia: Use resource_size function on resource object

Kent Overstreet (1):
      lib/generic-radix-tree.c: Fix rare race in __genradix_ptr_alloc()

Kishon Vijay Abraham I (1):
      PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)

Konstantin Andreev (1):
      smack: unix sockets: fix accept()ed socket label

Krishna Kumar (1):
      pci/hotplug/pnv_php: Fix hotplug driver crash on Powernv

Kuniyuki Iwashima (2):
      af_unix: Remove put_pid()/put_cred() in copy_peercred().
      can: bcm: Remove proc entry when dev is unregistered.

Leesoo Ahn (1):
      apparmor: fix possible NULL pointer dereference

Len Baker (1):
      drivers/net/usb: Remove all strcpy() uses

Liao Chen (1):
      mmc: sdhci-of-aspeed: fix module autoloading

Ma Jun (1):
      drm/amdgpu: Fix uninitialized variable warning in amdgpu_afmt_acr

Ma Ke (1):
      irqchip/gic-v2m: Fix refcount leak in gicv2m_of_init()

Matteo Martelli (1):
      iio: fix scale application in iio_convert_raw_to_processed_unlocked

Maurizio Lombardi (1):
      nvmet-tcp: fix kernel crash if commands allocation fails

Michael Chen (1):
      drm/amdkfd: Reconcile the definition and use of oem_id in struct kfd_topology_device

Michael Ellerman (1):
      ata: pata_macio: Use WARN instead of BUG

Naman Jain (1):
      Drivers: hv: vmbus: Fix rescind handling in uio_hv_generic

Nikolay Aleksandrov (5):
      net: bridge: fdb: convert is_local to bitops
      net: bridge: fdb: convert is_static to bitops
      net: bridge: fdb: convert is_sticky to bitops
      net: bridge: fdb: convert added_by_user to bitops
      net: bridge: fdb: convert added_by_external_learn to use bitops

Oliver Neukum (2):
      usbnet: modern method to get random MAC
      usbnet: ipheth: race between ipheth_close and error handling

Ondrej Zary (1):
      cx82310_eth: re-enable ethernet mode after router reboot

Pali Rohár (1):
      irqchip/armada-370-xp: Do not allow mapping IRQ 0 and 1

Pawel Dembicki (1):
      net: dsa: vsc73xx: fix possible subblocks range of CAPT block

Peter Griffin (2):
      reset: hi6220: Add support for AO reset controller
      clk: hi6220: use CLK_OF_DECLARE_DRIVER

Philip Mueller (1):
      drm: panel-orientation-quirks: Add quirk for OrangePi Neo

Phillip Lougher (1):
      Squashfs: sanity check symbolic link size

Qing Wang (1):
      nilfs2: replace snprintf in show functions with sysfs_emit

Ricardo Ribalda (1):
      media: uvcvideo: Enforce alignment of frame and interval

Richard Fitzgerald (2):
      i2c: Fix conditional for substituting empty ACPI functions
      i2c: Use IS_REACHABLE() for substituting empty ACPI functions

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

Satya Priya Kakitapalli (2):
      clk: qcom: clk-alpha-pll: Fix the pll post div mask
      clk: qcom: clk-alpha-pll: Fix the trion pll postdiv set rate API

Saurabh Sengar (1):
      uio_hv_generic: Fix kernel NULL pointer dereference in hv_uio_rescind

Shannon Nelson (1):
      ionic: fix potential irq name truncation

Shantanu Goel (1):
      usb: uas: set host status byte on data completion error

Simon Holesch (1):
      usbip: Don't submit special requests twice

Stanislav Fomichev (1):
      net: set SOCK_RCU_FREE before inserting socket into hashtable

Stefan Wiehler (1):
      of/irq: Prevent device address out-of-bounds read in interrupt map walk

Stephen Hemminger (1):
      sch/netem: fix use after free in netem_dequeue

Steven Rostedt (VMware) (1):
      ring-buffer: Rename ring_buffer_read() to read_buffer_iter_advance()

Sven Schnelle (1):
      uprobes: Use kzalloc to allocate xol area

Takashi Iwai (1):
      ALSA: hda: Add input value sanity checks to HDMI channel map controls

Tim Huang (3):
      drm/amdgpu: fix overflowed array index read warning
      drm/amdgpu: fix ucode out-of-bounds read warning
      drm/amdgpu: fix mc_data out-of-bounds read warning

Toke Høiland-Jørgensen (1):
      sched: sch_cake: fix bulk flow accounting logic for host fairness

Trond Myklebust (1):
      NFSv4: Add missing rescheduling points in nfs_client_return_marked_delegations

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

robelin (1):
      ASoC: dapm: Fix UAF for snd_soc_pcm_runtime object


