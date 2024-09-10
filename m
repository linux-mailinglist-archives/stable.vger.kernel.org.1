Return-Path: <stable+bounces-74154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6367972DCA
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4C71C244A3
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D792C189B9C;
	Tue, 10 Sep 2024 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s2VFv6/K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9BB14F12C;
	Tue, 10 Sep 2024 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960971; cv=none; b=DzbvfQ44EuEJSPINnlzmHhwsUSpk8mWXdEvU+8KWmsFnzK3PzhjO2KFstXxDbXAyM+8YcQJqWeB7mktf3W3K859L8HhMjblUse6JMWg/74w8vQjLUMHZ0Trg2q2CgJ44sJA5mYr014Bk9qr9UtjmU0eFQxmTj62wBqIirs+HtgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960971; c=relaxed/simple;
	bh=pbjzJhBCiJbqy7HEfJjTgDkZV5mlB8NYhJnq4e6jF6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HOyxvKc9aKMY9h1PV48lEJZwTq2822Nw8ptTePjvZI/5q0WoudZJIDwnpp4TEwgXzA2sBsZJz9SL5fBSArg62Z3owOMxV8o260KQsOCCnfAvDX0kR2NgPi3AvV9GmYDlaLWHemTehvtkyvCM+CcBK9H7gNEnZXWd46wQR8E92wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s2VFv6/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72445C4CEC3;
	Tue, 10 Sep 2024 09:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725960971;
	bh=pbjzJhBCiJbqy7HEfJjTgDkZV5mlB8NYhJnq4e6jF6w=;
	h=From:To:Cc:Subject:Date:From;
	b=s2VFv6/K+tTXT/b3TN0/ZPBSXvQL4MdjkodxPTlUSeEx0Twm2FJVRR3nzmfrFsYqU
	 C6ZTxyqBgNtZJ6wSvk+DPLU31HSgVQP+5VEqRzbWZ2HvxTeg2D92fus9O7vCanuhID
	 QSJ1bbfO7/1Hz9olM45HzRvFu5xAj8Y73BtoRTcQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com,
	broonie@kernel.org
Subject: [PATCH 4.19 00/96] 4.19.322-rc1 review
Date: Tue, 10 Sep 2024 11:31:02 +0200
Message-ID: <20240910092541.383432924@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.322-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.322-rc1
X-KernelTest-Deadline: 2024-09-12T09:25+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 4.19.322 release.
There are 96 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.322-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.322-rc1

Li RongQing <lirongqing@baidu.com>
    netns: restore ops before calling ops_exit_list

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: explicitly zero is_sticky in fdb_create

Zhang Changzhong <zhangchangzhong@huawei.com>
    cx82310_eth: fix error return code in cx82310_bind()

Daniel Borkmann <daniel@iogearbox.net>
    net, sunrpc: Remap EPERM in case of connection failure in xs_tcp_setup_socket

Roland Xu <mu001999@outlook.com>
    rtmutex: Drop rt_mutex::wait_lock before scheduling

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    drm/i915/fence: Mark debug_fence_free() with __maybe_unused

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    drm/i915/fence: Mark debug_fence_init_onstack() with __maybe_unused

Jonathan Cameron <Jonathan.Cameron@huawei.com>
    ACPI: processor: Fix memory leaks in error paths of processor_add()

Jonathan Cameron <Jonathan.Cameron@huawei.com>
    ACPI: processor: Return an error if acpi_processor_get_info() fails in processor_add()

Eric Dumazet <edumazet@google.com>
    ila: call nf_unregister_net_hooks() sooner

Eric Dumazet <edumazet@google.com>
    netns: add pre_exit method to struct pernet_operations

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: protect references to superblock parameters exposed in sysfs

Qing Wang <wangqing@vivo.com>
    nilfs2: replace snprintf in show functions with sysfs_emit

Zheng Yejian <zhengyejian@huaweicloud.com>
    tracing: Avoid possible softlockup in tracing_iter_reset()

Steven Rostedt (VMware) <rostedt@goodmis.org>
    ring-buffer: Rename ring_buffer_read() to read_buffer_iter_advance()

Sven Schnelle <svens@linux.ibm.com>
    uprobes: Use kzalloc to allocate xol area

Jacky Bai <ping.bai@nxp.com>
    clocksource/drivers/imx-tpm: Fix next event not taking effect sometime

Jacky Bai <ping.bai@nxp.com>
    clocksource/drivers/imx-tpm: Fix return -ETIME when delta exceeds INT_MAX

David Fernandez Gonzalez <david.fernandez.gonzalez@oracle.com>
    VMCI: Fix use-after-free when removing resource in vmci_resource_remove()

Naman Jain <namjain@linux.microsoft.com>
    Drivers: hv: vmbus: Fix rescind handling in uio_hv_generic

Saurabh Sengar <ssengar@linux.microsoft.com>
    uio_hv_generic: Fix kernel NULL pointer dereference in hv_uio_rescind

Geert Uytterhoeven <geert+renesas@glider.be>
    nvmem: Fix return type of devm_nvmem_device_get() in kerneldoc

Matteo Martelli <matteomartelli3@gmail.com>
    iio: fix scale application in iio_convert_raw_to_processed_unlocked

David Lechner <dlechner@baylibre.com>
    iio: buffer-dmaengine: fix releasing dma channel on error

Michael Ellerman <mpe@ellerman.id.au>
    ata: pata_macio: Use WARN instead of BUG

Stefan Wiehler <stefan.wiehler@nokia.com>
    of/irq: Prevent device address out-of-bounds read in interrupt map walk

Phillip Lougher <phillip@squashfs.org.uk>
    Squashfs: sanity check symbolic link size

Oliver Neukum <oneukum@suse.com>
    usbnet: ipheth: race between ipheth_close and error handling

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: uinput - reject requests with unreasonable number of slots

Camila Alvarez <cam.alvarez.i@gmail.com>
    HID: cougar: fix slab-out-of-bounds Read in cougar_report_fixup

David Sterba <dsterba@suse.com>
    btrfs: initialize location to fix -Wmaybe-uninitialized in btrfs_lookup_dentry()

Dan Williams <dan.j.williams@intel.com>
    PCI: Add missing bridge lock to pci_bus_lock()

Josef Bacik <josef@toxicpanda.com>
    btrfs: clean up our handling of refs == 0 in snapshot delete

Josef Bacik <josef@toxicpanda.com>
    btrfs: replace BUG_ON with ASSERT in walk_down_proc()

Zqiang <qiang.zhang1211@gmail.com>
    smp: Add missing destroy_work_on_stack() call in smp_call_on_cpu()

Sascha Hauer <s.hauer@pengutronix.de>
    wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()

Guenter Roeck <linux@roeck-us.net>
    hwmon: (w83627ehf) Fix underflows seen when writing limit attributes

Guenter Roeck <linux@roeck-us.net>
    hwmon: (nct6775-core) Fix underflows seen when writing limit attributes

Guenter Roeck <linux@roeck-us.net>
    hwmon: (lm95234) Fix underflows seen when writing limit attributes

Guenter Roeck <linux@roeck-us.net>
    hwmon: (adc128d818) Fix underflows seen when writing limit attributes

Krishna Kumar <krishnak@linux.ibm.com>
    pci/hotplug/pnv_php: Fix hotplug driver crash on Powernv

Zijun Hu <quic_zijuhu@quicinc.com>
    devres: Initialize an uninitialized struct member

Johannes Berg <johannes.berg@intel.com>
    um: line: always fill *error_out in setup_one_line()

Waiman Long <longman@redhat.com>
    cgroup: Protect css->cgroup write under css_set_lock

Jacob Pan <jacob.jun.pan@linux.intel.com>
    iommu/vt-d: Handle volatile descriptor status read

Pawel Dembicki <paweldembicki@gmail.com>
    net: dsa: vsc73xx: fix possible subblocks range of CAPT block

Jonas Gorski <jonas.gorski@bisdn.de>
    net: bridge: br_fdb_external_learn_add(): always set EXT_LEARN

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: fdb: convert added_by_external_learn to use bitops

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: fdb: convert added_by_user to bitops

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: fdb: convert is_sticky to bitops

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: fdb: convert is_static to bitops

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: fdb: convert is_local to bitops

Ido Schimmel <idosch@mellanox.com>
    bridge: switchdev: Allow clearing FDB entry offload indication

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: add support for sticky fdb entries

Richard Guy Briggs <rgb@redhat.com>
    rfkill: fix spelling mistake contidion to condition

Oliver Neukum <oneukum@suse.com>
    usbnet: modern method to get random MAC

Jakub Kicinski <kuba@kernel.org>
    net: usb: don't write directly to netdev->dev_addr

Len Baker <len.baker@gmx.com>
    drivers/net/usb: Remove all strcpy() uses

Ondrej Zary <linux@zary.sk>
    cx82310_eth: re-enable ethernet mode after router reboot

Aleksandr Mishin <amishin@t-argos.ru>
    platform/x86: dell-smbios: Fix error path in dell_smbios_init()

Daiwei Li <daiweili@google.com>
    igb: Fix not clearing TimeSync interrupts for 82580

Kuniyuki Iwashima <kuniyu@amazon.com>
    can: bcm: Remove proc entry when dev is unregistered.

Jules Irenge <jbi.octave@gmail.com>
    pcmcia: Use resource_size function on resource object

Chen Ni <nichen@iscas.ac.cn>
    media: qcom: camss: Add check for v4l2_fwnode_endpoint_parse

Arend van Spriel <arend.vanspriel@broadcom.com>
    wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3

Jan Kara <jack@suse.cz>
    udf: Avoid excessive partition lengths

Yunjian Wang <wangyunjian@huawei.com>
    netfilter: nf_conncount: fix wrong variable type

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Remove put_pid()/put_cred() in copy_peercred().

Pali Rohár <pali@kernel.org>
    irqchip/armada-370-xp: Do not allow mapping IRQ 0 and 1

Konstantin Andreev <andreev@swemel.ru>
    smack: unix sockets: fix accept()ed socket label

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Add input value sanity checks to HDMI channel map controls

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix state management in error path of log writing function

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix missing cleanup on rollforward recovery error

Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
    clk: qcom: clk-alpha-pll: Fix the pll post div mask

Jann Horn <jannh@google.com>
    fuse: use unsigned type for getxattr/listxattr size truncation

Sam Protsenko <semen.protsenko@linaro.org>
    mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K

Zheng Qixing <zhengqixing@huawei.com>
    ata: libata: Fix memory leak for error path in ata_host_alloc()

Christoffer Sandberg <cs@tuxedo.de>
    ALSA: hda/conexant: Add pincfg quirk to enable top speakers on Sirius devices

Stephen Hemminger <stephen@networkplumber.org>
    sch/netem: fix use after free in netem_dequeue

Hillf Danton <hdanton@sina.com>
    ALSA: usb-audio: Fix gpf in snd_usb_pipe_sanity_check

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Sanity checks for each pipe and EP types

Jan Kara <jack@suse.cz>
    udf: Limit file size to 4TB

Breno Leitao <leitao@debian.org>
    virtio_net: Fix napi_skb_cache_put warning

Christoph Hellwig <hch@lst.de>
    block: initialize integrity buffer to zero before writing it to media

Ricardo Ribalda <ribalda@chromium.org>
    media: uvcvideo: Enforce alignment of frame and interval

Casey Schaufler <casey@schaufler-ca.com>
    smack: tcp: ipv4, fix incorrect labeling

Simon Holesch <simon@holesch.de>
    usbip: Don't submit special requests twice

Leesoo Ahn <lsahn@ooseel.net>
    apparmor: fix possible NULL pointer dereference

Michael Chen <michael.chen@amd.com>
    drm/amdkfd: Reconcile the definition and use of oem_id in struct kfd_topology_device

Tim Huang <Tim.Huang@amd.com>
    drm/amdgpu: fix mc_data out-of-bounds read warning

Tim Huang <Tim.Huang@amd.com>
    drm/amdgpu: fix ucode out-of-bounds read warning

Tim Huang <Tim.Huang@amd.com>
    drm/amdgpu: fix overflowed array index read warning

Ma Jun <Jun.Ma2@amd.com>
    drm/amdgpu: Fix uninitialized variable warning in amdgpu_afmt_acr

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    usb: dwc3: st: add missing depopulate in probe error path

Nishka Dasgupta <nishkadg.linux@gmail.com>
    usb: dwc3: st: Add of_node_put() before return in probe function

ZHANG Yuntian <yt@radxa.com>
    net: usb: qmi_wwan: add MeiG Smart SRM825L


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/um/drivers/line.c                             |   2 +
 block/bio-integrity.c                              |  11 +-
 drivers/acpi/acpi_processor.c                      |  15 +--
 drivers/ata/libata-core.c                          |   4 +-
 drivers/ata/pata_macio.c                           |   7 +-
 drivers/base/devres.c                              |   1 +
 drivers/clk/qcom/clk-alpha-pll.c                   |   2 +-
 drivers/clocksource/timer-imx-tpm.c                |  16 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c            |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h              |   2 -
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |   5 +-
 drivers/gpu/drm/i915/i915_sw_fence.c               |   8 +-
 drivers/hid/hid-cougar.c                           |   2 +-
 drivers/hv/vmbus_drv.c                             |   1 +
 drivers/hwmon/adc128d818.c                         |   4 +-
 drivers/hwmon/lm95234.c                            |   9 +-
 drivers/hwmon/nct6775.c                            |   2 +-
 drivers/hwmon/w83627ehf.c                          |   4 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   4 +-
 drivers/iio/inkern.c                               |   8 +-
 drivers/input/misc/uinput.c                        |  14 +++
 drivers/iommu/dmar.c                               |   2 +-
 drivers/irqchip/irq-armada-370-xp.c                |   4 +
 drivers/media/platform/qcom/camss/camss.c          |   5 +-
 drivers/media/usb/uvc/uvc_driver.c                 |  18 ++-
 drivers/misc/vmw_vmci/vmci_resource.c              |   3 +-
 drivers/mmc/host/dw_mmc.c                          |   4 +-
 drivers/net/dsa/vitesse-vsc73xx.c                  |  10 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |  10 ++
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |   9 +-
 drivers/net/ethernet/rocker/rocker_main.c          |   1 +
 drivers/net/usb/ch9200.c                           |   4 +-
 drivers/net/usb/cx82310_eth.c                      |  56 +++++++--
 drivers/net/usb/ipheth.c                           |   4 +-
 drivers/net/usb/kaweth.c                           |   3 +-
 drivers/net/usb/mcs7830.c                          |   4 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/usb/sierra_net.c                       |   6 +-
 drivers/net/usb/sr9700.c                           |   4 +-
 drivers/net/usb/sr9800.c                           |   5 +-
 drivers/net/usb/usbnet.c                           |  23 ++--
 drivers/net/virtio_net.c                           |   8 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |   1 +
 drivers/net/wireless/marvell/mwifiex/main.h        |   3 +
 drivers/nvmem/core.c                               |   6 +-
 drivers/of/irq.c                                   |  15 ++-
 drivers/pci/hotplug/pnv_php.c                      |   3 +-
 drivers/pci/pci.c                                  |  35 +++---
 drivers/pcmcia/yenta_socket.c                      |   6 +-
 drivers/platform/x86/dell-smbios-base.c            |   5 +-
 drivers/uio/uio_hv_generic.c                       |  11 +-
 drivers/usb/dwc3/dwc3-st.c                         |  12 +-
 drivers/usb/usbip/stub_rx.c                        |  77 +++++++-----
 fs/btrfs/extent-tree.c                             |  32 +++--
 fs/btrfs/inode.c                                   |   2 +-
 fs/fuse/xattr.c                                    |   4 +-
 fs/nilfs2/recovery.c                               |  35 +++++-
 fs/nilfs2/segment.c                                |  10 +-
 fs/nilfs2/sysfs.c                                  | 117 +++++++++++--------
 fs/squashfs/inode.c                                |   7 +-
 fs/udf/super.c                                     |  24 +++-
 include/linux/ring_buffer.h                        |   3 +-
 include/net/net_namespace.h                        |   5 +
 include/net/switchdev.h                            |   3 +-
 include/uapi/linux/neighbour.h                     |   1 +
 kernel/cgroup/cgroup.c                             |   2 +-
 kernel/events/uprobes.c                            |   3 +-
 kernel/locking/rtmutex.c                           |   4 +-
 kernel/smp.c                                       |   1 +
 kernel/trace/ring_buffer.c                         |  23 +---
 kernel/trace/trace.c                               |   6 +-
 kernel/trace/trace_functions_graph.c               |   2 +-
 net/bridge/br.c                                    |   4 +-
 net/bridge/br_fdb.c                                | 129 ++++++++++++---------
 net/bridge/br_input.c                              |   2 +-
 net/bridge/br_private.h                            |  18 ++-
 net/bridge/br_switchdev.c                          |  11 +-
 net/can/bcm.c                                      |   4 +
 net/core/net_namespace.c                           |  28 +++++
 net/dsa/slave.c                                    |   1 +
 net/ipv6/ila/ila.h                                 |   1 +
 net/ipv6/ila/ila_main.c                            |   6 +
 net/ipv6/ila/ila_xlat.c                            |  13 ++-
 net/netfilter/nf_conncount.c                       |   8 +-
 net/rfkill/core.c                                  |   4 +-
 net/sched/sch_netem.c                              |   9 +-
 net/sunrpc/xprtsock.c                              |   7 ++
 net/unix/af_unix.c                                 |   9 +-
 security/apparmor/apparmorfs.c                     |   4 +
 security/smack/smack_lsm.c                         |  14 ++-
 sound/hda/hdmi_chmap.c                             |  18 +++
 sound/pci/hda/patch_conexant.c                     |  11 ++
 sound/usb/helper.c                                 |  17 +++
 sound/usb/helper.h                                 |   1 +
 sound/usb/quirks.c                                 |  14 ++-
 100 files changed, 768 insertions(+), 344 deletions(-)



