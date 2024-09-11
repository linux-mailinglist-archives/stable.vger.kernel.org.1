Return-Path: <stable+bounces-75837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5B9975337
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 15:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10221C20BE8
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 13:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3AB1885A8;
	Wed, 11 Sep 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mpHGpWja"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88473185606;
	Wed, 11 Sep 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060024; cv=none; b=NJpaG3y+4wBXVGoYtorskjKvmbFQ1YroKbaIrm/A1YK0JWmUr4TYR5CH877BZ484kGfT3oF+DgGdc9aiDGR/quIDg0gXO93e/C4oSoVPYttSKoMfggr9G6VbF5r99yXBd3XCDoteuEl+SrgGhP6vh8X2I0WpdwiOgY7yGzRS2bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060024; c=relaxed/simple;
	bh=d7/B2Vdc69ST+LHPZFaUnOsZxoulYpQZl2W3Nm8zegM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EgetLcfnO9O8cQFTYlyEFMg2+QdgkV5dg1sDRlrLTW3ruWZHnIkQ8lsPuR+ZHY5l93qZd3Sy68t6uI+Bihlwq4/TxuY/vr+VUbaR2S401gstBvO0D7Y7vS4kY+JRDdPcMh0sdAP3UOCZcFeXdCVW5vSXEkP9FPQGgwOqePpHCTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mpHGpWja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C16EC4CEC5;
	Wed, 11 Sep 2024 13:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726060024;
	bh=d7/B2Vdc69ST+LHPZFaUnOsZxoulYpQZl2W3Nm8zegM=;
	h=From:To:Cc:Subject:Date:From;
	b=mpHGpWja7Ch4+sEN80Yu3Y7YZGWmG7BgqtnkppD6O93z5Bcd2jxtqQChz1p/yX/gY
	 +2KD8UUNVDVJNTKB58K4dlBBshTj1C2hS/U+d7eSElTnOL2wG+qAg0CHjzAN/ClReJ
	 jGTt+G1X88vxAVK6WxkSQhp8/gmB7uhdpMyR410g=
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
Subject: [PATCH 5.10 000/185] 5.10.226-rc2 review
Date: Wed, 11 Sep 2024 15:07:00 +0200
Message-ID: <20240911130529.320360981@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.226-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.226-rc2
X-KernelTest-Deadline: 2024-09-13T13:05+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.10.226 release.
There are 185 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 13 Sep 2024 13:05:03 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.226-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.226-rc2

Shakeel Butt <shakeel.butt@linux.dev>
    memcg: protect concurrent access to mem_cgroup_idr

Daniel Borkmann <daniel@iogearbox.net>
    net, sunrpc: Remap EPERM in case of connection failure in xs_tcp_setup_socket

Thomas Gleixner <tglx@linutronix.de>
    x86/mm: Fix PTI for i386 some more

Roland Xu <mu001999@outlook.com>
    rtmutex: Drop rt_mutex::wait_lock before scheduling

Seunghwan Baek <sh8267.baek@samsung.com>
    mmc: cqhci: Fix checking of CQHCI_HALT state

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    drm/i915/fence: Mark debug_fence_free() with __maybe_unused

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    drm/i915/fence: Mark debug_fence_init_onstack() with __maybe_unused

Maurizio Lombardi <mlombard@redhat.com>
    nvmet-tcp: fix kernel crash if commands allocation fails

Jonathan Cameron <Jonathan.Cameron@huawei.com>
    arm64: acpi: Harden get_cpu_for_acpi_id() against missing CPU entry

James Morse <james.morse@arm.com>
    arm64: acpi: Move get_cpu_for_acpi_id() to a header

Jonathan Cameron <Jonathan.Cameron@huawei.com>
    ACPI: processor: Fix memory leaks in error paths of processor_add()

Jonathan Cameron <Jonathan.Cameron@huawei.com>
    ACPI: processor: Return an error if acpi_processor_get_info() fails in processor_add()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: protect references to superblock parameters exposed in sysfs

Qing Wang <wangqing@vivo.com>
    nilfs2: replace snprintf in show functions with sysfs_emit

Peter Zijlstra <peterz@infradead.org>
    perf/aux: Fix AUX buffer serialization

Sven Schnelle <svens@linux.ibm.com>
    uprobes: Use kzalloc to allocate xol area

Daniel Lezcano <daniel.lezcano@linaro.org>
    clocksource/drivers/timer-of: Remove percpu irq related code

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

Carlos Llamas <cmllamas@google.com>
    binder: fix UAF caused by offsets overwrite

Dumitru Ceclan <mitrutzceclan@gmail.com>
    iio: adc: ad7124: fix chip ID mismatch

Matteo Martelli <matteomartelli3@gmail.com>
    iio: fix scale application in iio_convert_raw_to_processed_unlocked

David Lechner <dlechner@baylibre.com>
    iio: buffer-dmaengine: fix releasing dma channel on error

Aleksandr Mishin <amishin@t-argos.ru>
    staging: iio: frequency: ad9834: Validate frequency parameter value

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4: Add missing rescheduling points in nfs_client_return_marked_delegations

Michael Ellerman <mpe@ellerman.id.au>
    ata: pata_macio: Use WARN instead of BUG

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: cevt-r4k: Don't call get_c0_compare_int if timer irq is installed

Kent Overstreet <kent.overstreet@linux.dev>
    lib/generic-radix-tree.c: Fix rare race in __genradix_ptr_alloc()

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

Heiko Carstens <hca@linux.ibm.com>
    s390/vmlinux.lds.S: Move ro_after_init section behind rodata section

David Sterba <dsterba@suse.com>
    btrfs: initialize location to fix -Wmaybe-uninitialized in btrfs_lookup_dentry()

Zenghui Yu <yuzenghui@huawei.com>
    kselftests: dmabuf-heaps: Ensure the driver name is null-terminated

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dpaa: avoid on-stack arrays of NR_CPUS elements

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

Andreas Ziegler <ziegler.andreas@siemens.com>
    libbpf: Add NULL checks to bpf_object__{prev_map,next_map}

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

Benjamin Marzinski <bmarzins@redhat.com>
    dm init: Handle minors larger than 255

Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
    ASoC: topology: Properly initialize soc_enum values

Pawel Dembicki <paweldembicki@gmail.com>
    net: dsa: vsc73xx: fix possible subblocks range of CAPT block

Jonas Gorski <jonas.gorski@bisdn.de>
    net: bridge: br_fdb_external_learn_add(): always set EXT_LEARN

Kuniyuki Iwashima <kuniyu@amazon.com>
    fou: Fix null-ptr-deref in GRO.

Eric Dumazet <edumazet@google.com>
    gro: remove rcu_read_lock/rcu_read_unlock from gro_complete handlers

Eric Dumazet <edumazet@google.com>
    gro: remove rcu_read_lock/rcu_read_unlock from gro_receive handlers

Eric Dumazet <edumazet@google.com>
    fou: remove sparse errors

Guillaume Nault <gnault@redhat.com>
    bareudp: Fix device stats updates.

Oliver Neukum <oneukum@suse.com>
    usbnet: modern method to get random MAC

Jakub Kicinski <kuba@kernel.org>
    net: usb: don't write directly to netdev->dev_addr

Len Baker <len.baker@gmx.com>
    drivers/net/usb: Remove all strcpy() uses

Dan Carpenter <dan.carpenter@linaro.org>
    igc: Unlock on error in igc_io_resume()

Cong Wang <cong.wang@bytedance.com>
    tcp_bpf: fix return value of tcp_bpf_sendmsg()

Aleksandr Mishin <amishin@t-argos.ru>
    platform/x86: dell-smbios: Fix error path in dell_smbios_init()

Chuck Lever <chuck.lever@oracle.com>
    svcrdma: Catch another Reply chunk overflow case

Daiwei Li <daiweili@google.com>
    igb: Fix not clearing TimeSync interrupts for 82580

Kuniyuki Iwashima <kuniyu@amazon.com>
    can: bcm: Remove proc entry when dev is unregistered.

Jules Irenge <jbi.octave@gmail.com>
    pcmcia: Use resource_size function on resource object

Chen Ni <nichen@iscas.ac.cn>
    media: qcom: camss: Add check for v4l2_fwnode_endpoint_parse

Kishon Vijay Abraham I <kishon@ti.com>
    PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: vivid: don't set HDMI TX controls if there are no HDMI outputs

Shantanu Goel <sgoel01@yahoo.com>
    usb: uas: set host status byte on data completion error

Arend van Spriel <arend.vanspriel@broadcom.com>
    wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    leds: spi-byte: Call of_node_put() on error path

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: vivid: fix wrong sizeimage value for mplane

Jan Kara <jack@suse.cz>
    udf: Avoid excessive partition lengths

Yunjian Wang <wangyunjian@huawei.com>
    netfilter: nf_conncount: fix wrong variable type

Jernej Skrabec <jernej.skrabec@gmail.com>
    iommu: sun50i: clear bypass register

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Remove put_pid()/put_cred() in copy_peercred().

Pali Rohár <pali@kernel.org>
    irqchip/armada-370-xp: Do not allow mapping IRQ 0 and 1

Konstantin Andreev <andreev@swemel.ru>
    smack: unix sockets: fix accept()ed socket label

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Add input value sanity checks to HDMI channel map controls

Josef Bacik <josef@toxicpanda.com>
    nfsd: make svc_stat per-network namespace instead of global

Josef Bacik <josef@toxicpanda.com>
    nfsd: remove nfsd_stats, make th_cnt a global counter

Josef Bacik <josef@toxicpanda.com>
    nfsd: make all of the nfsd stats per-network namespace

Josef Bacik <josef@toxicpanda.com>
    nfsd: expose /proc/net/sunrpc/nfsd in net namespaces

Josef Bacik <josef@toxicpanda.com>
    nfsd: rename NFSD_NET_* to NFSD_STATS_*

Josef Bacik <josef@toxicpanda.com>
    sunrpc: use the struct net as the svc proc private

Josef Bacik <josef@toxicpanda.com>
    sunrpc: remove ->pg_stats from svc_program

Josef Bacik <josef@toxicpanda.com>
    sunrpc: pass in the sv_stats struct through svc_create_pooled

Josef Bacik <josef@toxicpanda.com>
    nfsd: stop setting ->pg_stats for unused stats

Josef Bacik <josef@toxicpanda.com>
    sunrpc: don't change ->sv_stats if it doesn't exist

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Fix frame size warning in svc_export_parse()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Rewrite synopsis of nfsd_percpu_counters_init()

NeilBrown <neilb@suse.de>
    NFSD: simplify error paths in nfsd_svc()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Refactor the duplicate reply cache shrinker

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Replace nfsd_prune_bucket()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Rename nfsd_reply_cache_alloc()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Refactor nfsd_reply_cache_free_locked()

Jeff Layton <jlayton@kernel.org>
    nfsd: move init of percpu reply_cache_stats counters back to nfsd_init_net

Jeff Layton <jlayton@kernel.org>
    nfsd: move reply cache initialization into nfsd startup

Matthieu Baerts (NGI0) <matttbe@kernel.org>
    mptcp: pm: avoid possible UaF when selecting endp

Matthieu Baerts (NGI0) <matttbe@kernel.org>
    mptcp: pr_debug: add missing \n at the end

Filipe Manana <fdmanana@suse.com>
    btrfs: fix use-after-free after failure to create a snapshot

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix state management in error path of log writing function

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix missing cleanup on rollforward recovery error

Toke Høiland-Jørgensen <toke@redhat.com>
    sched: sch_cake: fix bulk flow accounting logic for host fairness

Eric Dumazet <edumazet@google.com>
    ila: call nf_unregister_net_hooks() sooner

Zheng Yejian <zhengyejian@huaweicloud.com>
    tracing: Avoid possible softlockup in tracing_iter_reset()

Simon Arlott <simon@octiron.net>
    can: mcp251x: fix deadlock if an interrupt occurs during mcp251x_open

Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
    clk: qcom: clk-alpha-pll: Fix the trion pll postdiv set rate API

Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
    clk: qcom: clk-alpha-pll: Fix the pll post div mask

Jann Horn <jannh@google.com>
    fuse: use unsigned type for getxattr/listxattr size truncation

Joanne Koong <joannelkoong@gmail.com>
    fuse: update stats for pages in dropped aux writeback list

Liao Chen <liaochen4@huawei.com>
    mmc: sdhci-of-aspeed: fix module autoloading

Sam Protsenko <semen.protsenko@linaro.org>
    mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: MGMT: Ignore keys being loaded with invalid type

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Revert "Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE"

Ma Ke <make24@iscas.ac.cn>
    irqchip/gic-v2m: Fix refcount leak in gicv2m_of_init()

Zheng Qixing <zhengqixing@huawei.com>
    ata: libata: Fix memory leak for error path in ata_host_alloc()

Maximilien Perreault <maximilienperreault@gmail.com>
    ALSA: hda/realtek: Support mute LED on HP Laptop 14-dq2xxx

Terry Cheong <htcheong@chromium.org>
    ALSA: hda/realtek: add patch for internal mic in Lenovo V145

Christoffer Sandberg <cs@tuxedo.de>
    ALSA: hda/conexant: Add pincfg quirk to enable top speakers on Sirius devices

robelin <robelin@nvidia.com>
    ASoC: dapm: Fix UAF for snd_soc_pcm_runtime object

Stephen Hemminger <stephen@networkplumber.org>
    sch/netem: fix use after free in netem_dequeue

Connor O'Brien <connor.obrien@crowdstrike.com>
    bpf, cgroup: Assign cgroup in cgroup_sk_alloc when called from interrupt

Richard Fitzgerald <rf@opensource.cirrus.com>
    i2c: Use IS_REACHABLE() for substituting empty ACPI functions

Jan Kara <jack@suse.cz>
    ext4: handle redirtying in ext4_bio_write_page()

Jan Kara <jack@suse.cz>
    udf: Limit file size to 4TB

Nikita Kiryushin <kiryushin@ancud.ru>
    rcu-tasks: Fix show_rcu_tasks_trace_gp_kthread buffer overflow

Breno Leitao <leitao@debian.org>
    virtio_net: Fix napi_skb_cache_put warning

Stanislav Fomichev <sdf@google.com>
    net: set SOCK_RCU_FREE before inserting socket into hashtable

Connor O'Brien <connor.obrien@crowdstrike.com>
    bpf, cgroups: Fix cgroup v2 fallback on v1/v2 mixed mode

Bob Zhou <bob.zhou@amd.com>
    drm/amd/pm: Fix the null pointer dereference for vega10_hwmgr

Christoph Hellwig <hch@lst.de>
    block: initialize integrity buffer to zero before writing it to media

Ricardo Ribalda <ribalda@chromium.org>
    media: uvcvideo: Enforce alignment of frame and interval

Alex Hung <alex.hung@amd.com>
    drm/amd/display: Skip wbscl_set_scaler_filter if filter is null

Christoph Hellwig <hch@lst.de>
    block: remove the blk_flush_integrity call in blk_integrity_unregister

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: make hash table duplicates more survivable

Haoran Liu <liuhaoran14@163.com>
    drm/meson: plane: Add error handling

Casey Schaufler <casey@schaufler-ca.com>
    smack: tcp: ipv4, fix incorrect labeling

Amir Goldstein <amir73il@gmail.com>
    fsnotify: clear PARENT_WATCHED flags lazily

Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
    usb: typec: ucsi: Fix null pointer dereference in trace

Simon Holesch <simon@holesch.de>
    usbip: Don't submit special requests twice

Shannon Nelson <shannon.nelson@amd.com>
    ionic: fix potential irq name truncation

Richard Maina <quic_rmaina@quicinc.com>
    hwspinlock: Introduce hwspin_lock_bust()

Aleksandr Mishin <amishin@t-argos.ru>
    PCI: al: Check IORESOURCE_BUS existence during probe

Shahar S Matityahu <shahar.s.matityahu@intel.com>
    wifi: iwlwifi: remove fw_running op

Jesse Zhang <jesse.zhang@amd.com>
    drm/amd/pm: check negtive return for table entries

Jesse Zhang <jesse.zhang@amd.com>
    drm/amdgpu: the warning dereferencing obj for nbio_v7_4

Ma Jun <Jun.Ma2@amd.com>
    drm/amdgpu/pm: Check input value for CUSTOM profile mode setting on legacy SOCs

Leesoo Ahn <lsahn@ooseel.net>
    apparmor: fix possible NULL pointer dereference

Michael Chen <michael.chen@amd.com>
    drm/amdkfd: Reconcile the definition and use of oem_id in struct kfd_topology_device

Tim Huang <Tim.Huang@amd.com>
    drm/amdgpu: fix mc_data out-of-bounds read warning

Tim Huang <Tim.Huang@amd.com>
    drm/amdgpu: fix ucode out-of-bounds read warning

Ma Jun <Jun.Ma2@amd.com>
    drm/amdgpu: Fix out-of-bounds read of df_v1_7_channel_number

Ma Jun <Jun.Ma2@amd.com>
    drm/amdgpu: Fix out-of-bounds write warning

Ma Jun <Jun.Ma2@amd.com>
    drm/amdgpu/pm: Fix uninitialized variable agc_btc_response

Hersen Wu <hersenxs.wu@amd.com>
    drm/amd/display: Fix Coverity INTEGER_OVERFLOW within dal_gpio_service_create

Alex Hung <alex.hung@amd.com>
    drm/amd/display: Check msg_id before processing transcation

Alex Hung <alex.hung@amd.com>
    drm/amd/display: Check num_valid_sets before accessing reader_wm_sets[]

Hersen Wu <hersenxs.wu@amd.com>
    drm/amd/display: Add array index check for hdcp ddc access

Hersen Wu <hersenxs.wu@amd.com>
    drm/amd/display: Stop amdgpu_dm initialize when stream nums greater than 6

Alex Hung <alex.hung@amd.com>
    drm/amd/display: Check gpio_id before used as array index

Zhigang Luo <Zhigang.Luo@amd.com>
    drm/amdgpu: avoid reading vf2pf info size from FB

Tim Huang <Tim.Huang@amd.com>
    drm/amd/pm: fix uninitialized variable warnings for vega10_hwmgr

Tim Huang <Tim.Huang@amd.com>
    drm/amdgpu: fix uninitialized scalar variable warning

Jesse Zhang <jesse.zhang@amd.com>
    drm/amd/pm: fix the Out-of-bounds read warning

Jesse Zhang <jesse.zhang@amd.com>
    drm/amd/pm: fix warning using uninitialized value of max_vid_step

Tim Huang <Tim.Huang@amd.com>
    drm/amd/pm: fix uninitialized variable warning for smu8_hwmgr

Tim Huang <Tim.Huang@amd.com>
    drm/amdgpu: fix overflowed array index read warning

Ma Jun <Jun.Ma2@amd.com>
    drm/amdgpu: Fix uninitialized variable warning in amdgpu_afmt_acr

ZHANG Yuntian <yt@radxa.com>
    net: usb: qmi_wwan: add MeiG Smart SRM825L

Rik van Riel <riel@surriel.com>
    dma-debug: avoid deadlock between dma debug vs printk and netconsole

Richard Fitzgerald <rf@opensource.cirrus.com>
    i2c: Fix conditional for substituting empty ACPI functions

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/conexant: Mute speakers at suspend / shutdown

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/generic: Add a helper to mute speakers at suspend/shutdown

Philip Mueller <philm@manjaro.org>
    drm: panel-orientation-quirks: Add quirk for OrangePi Neo


-------------

Diffstat:

 Documentation/locking/hwspinlock.rst               |  11 ++
 Makefile                                           |   4 +-
 arch/arm64/include/asm/acpi.h                      |  12 ++
 arch/arm64/kernel/acpi_numa.c                      |  11 --
 arch/mips/kernel/cevt-r4k.c                        |  15 +-
 arch/s390/kernel/vmlinux.lds.S                     |   9 +
 arch/um/drivers/line.c                             |   2 +
 arch/x86/mm/pti.c                                  |  45 +++--
 block/bio-integrity.c                              |  11 +-
 block/blk-integrity.c                              |   2 -
 drivers/acpi/acpi_processor.c                      |  15 +-
 drivers/android/binder.c                           |   1 +
 drivers/ata/libata-core.c                          |   4 +-
 drivers/ata/pata_macio.c                           |   7 +-
 drivers/base/devres.c                              |   1 +
 drivers/clk/qcom/clk-alpha-pll.c                   |   6 +-
 drivers/clocksource/timer-imx-tpm.c                |  16 +-
 drivers/clocksource/timer-of.c                     |  17 +-
 drivers/clocksource/timer-of.h                     |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c            |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |   4 +-
 drivers/gpu/drm/amd/amdgpu/df_v1_7.c               |   2 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h              |   2 -
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |   5 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   5 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |   3 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c   |   3 +
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c |  17 +-
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c     |  17 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c    |  28 ++-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c    |  13 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c    |   5 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |   2 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    |  15 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |  90 +++++++--
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |   8 +-
 .../drm/amd/pm/powerplay/smumgr/vega10_smumgr.c    |   6 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |   6 +
 drivers/gpu/drm/i915/i915_sw_fence.c               |   8 +-
 drivers/gpu/drm/meson/meson_plane.c                |  17 +-
 drivers/hid/hid-cougar.c                           |   2 +-
 drivers/hv/vmbus_drv.c                             |   1 +
 drivers/hwmon/adc128d818.c                         |   4 +-
 drivers/hwmon/lm95234.c                            |   9 +-
 drivers/hwmon/nct6775.c                            |   2 +-
 drivers/hwmon/w83627ehf.c                          |   4 +-
 drivers/hwspinlock/hwspinlock_core.c               |  28 +++
 drivers/hwspinlock/hwspinlock_internal.h           |   3 +
 drivers/iio/adc/ad7124.c                           |   1 +
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   4 +-
 drivers/iio/inkern.c                               |   8 +-
 drivers/input/misc/uinput.c                        |  14 ++
 drivers/iommu/intel/dmar.c                         |   2 +-
 drivers/iommu/sun50i-iommu.c                       |   1 +
 drivers/irqchip/irq-armada-370-xp.c                |   4 +
 drivers/irqchip/irq-gic-v2m.c                      |   6 +-
 drivers/leds/leds-spi-byte.c                       |   6 +-
 drivers/md/dm-init.c                               |   4 +-
 drivers/media/platform/qcom/camss/camss.c          |   5 +-
 drivers/media/test-drivers/vivid/vivid-vid-cap.c   |  17 +-
 drivers/media/test-drivers/vivid/vivid-vid-out.c   |  16 +-
 drivers/media/usb/uvc/uvc_driver.c                 |  18 +-
 drivers/misc/vmw_vmci/vmci_resource.c              |   3 +-
 drivers/mmc/host/cqhci.c                           |   2 +-
 drivers/mmc/host/dw_mmc.c                          |   4 +-
 drivers/mmc/host/sdhci-of-aspeed.c                 |   1 +
 drivers/net/bareudp.c                              |  22 +--
 drivers/net/can/spi/mcp251x.c                      |   2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |  10 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |  20 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |  10 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |  10 +
 drivers/net/ethernet/intel/igc/igc_main.c          |   1 +
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   2 +-
 drivers/net/geneve.c                               |   8 +-
 drivers/net/usb/ch9200.c                           |   4 +-
 drivers/net/usb/cx82310_eth.c                      |   5 +-
 drivers/net/usb/ipheth.c                           |   4 +-
 drivers/net/usb/kaweth.c                           |   3 +-
 drivers/net/usb/mcs7830.c                          |   4 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/usb/sierra_net.c                       |   6 +-
 drivers/net/usb/sr9700.c                           |   4 +-
 drivers/net/usb/sr9800.c                           |   5 +-
 drivers/net/usb/usbnet.c                           |  23 +--
 drivers/net/virtio_net.c                           |   8 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |   3 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |   1 -
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   6 -
 drivers/net/wireless/marvell/mwifiex/main.h        |   3 +
 drivers/nvme/target/tcp.c                          |   4 +-
 drivers/nvmem/core.c                               |   6 +-
 drivers/of/irq.c                                   |  15 +-
 drivers/pci/controller/dwc/pci-keystone.c          |  44 ++++-
 drivers/pci/controller/dwc/pcie-al.c               |  16 +-
 drivers/pci/hotplug/pnv_php.c                      |   3 +-
 drivers/pci/pci.c                                  |  35 ++--
 drivers/pcmcia/yenta_socket.c                      |   6 +-
 drivers/platform/x86/dell-smbios-base.c            |   5 +-
 drivers/staging/iio/frequency/ad9834.c             |   2 +-
 drivers/uio/uio_hv_generic.c                       |  11 +-
 drivers/usb/storage/uas.c                          |   1 +
 drivers/usb/typec/ucsi/ucsi.h                      |   2 +-
 drivers/usb/usbip/stub_rx.c                        |  77 +++++---
 fs/btrfs/extent-tree.c                             |  32 +++-
 fs/btrfs/inode.c                                   |   2 +-
 fs/btrfs/ioctl.c                                   |   5 +-
 fs/btrfs/transaction.c                             |  24 +++
 fs/btrfs/transaction.h                             |   2 +
 fs/ext4/page-io.c                                  |  14 +-
 fs/fuse/file.c                                     |   8 +-
 fs/fuse/xattr.c                                    |   4 +-
 fs/lockd/svc.c                                     |   3 -
 fs/nfs/callback.c                                  |   3 -
 fs/nfs/super.c                                     |   2 +
 fs/nfsd/export.c                                   |  32 +++-
 fs/nfsd/export.h                                   |   4 +-
 fs/nfsd/netns.h                                    |  25 ++-
 fs/nfsd/nfs4proc.c                                 |   6 +-
 fs/nfsd/nfscache.c                                 | 202 ++++++++++++---------
 fs/nfsd/nfsctl.c                                   |  24 ++-
 fs/nfsd/nfsd.h                                     |   1 +
 fs/nfsd/nfsfh.c                                    |   3 +-
 fs/nfsd/nfssvc.c                                   |  38 ++--
 fs/nfsd/stats.c                                    |  52 +++---
 fs/nfsd/stats.h                                    |  83 ++++-----
 fs/nfsd/trace.h                                    |  22 +++
 fs/nfsd/vfs.c                                      |   6 +-
 fs/nilfs2/recovery.c                               |  35 +++-
 fs/nilfs2/segment.c                                |  10 +-
 fs/nilfs2/sysfs.c                                  | 117 +++++++-----
 fs/notify/fsnotify.c                               |  31 +++-
 fs/notify/fsnotify.h                               |   2 +-
 fs/notify/mark.c                                   |  32 +++-
 fs/squashfs/inode.c                                |   7 +-
 fs/udf/super.c                                     |  24 ++-
 include/linux/cgroup-defs.h                        | 107 +++--------
 include/linux/cgroup.h                             |  22 +--
 include/linux/fsnotify_backend.h                   |   8 +-
 include/linux/hwspinlock.h                         |   6 +
 include/linux/i2c.h                                |   2 +-
 include/linux/sunrpc/svc.h                         |   5 +-
 include/net/bluetooth/hci_core.h                   |   5 -
 kernel/cgroup/cgroup.c                             |  65 +++----
 kernel/dma/debug.c                                 |   5 +-
 kernel/events/core.c                               |  18 +-
 kernel/events/internal.h                           |   1 +
 kernel/events/ring_buffer.c                        |   2 +
 kernel/events/uprobes.c                            |   3 +-
 kernel/locking/rtmutex.c                           |   4 +-
 kernel/rcu/tasks.h                                 |   2 +-
 kernel/smp.c                                       |   1 +
 kernel/trace/trace.c                               |   2 +
 lib/generic-radix-tree.c                           |   2 +
 mm/memcontrol.c                                    |  23 ++-
 net/8021q/vlan_core.c                              |   7 +-
 net/bluetooth/mgmt.c                               |  60 +++---
 net/bluetooth/smp.c                                |   7 -
 net/bridge/br_fdb.c                                |   6 +-
 net/can/bcm.c                                      |   4 +
 net/core/netclassid_cgroup.c                       |   7 +-
 net/core/netprio_cgroup.c                          |  10 +-
 net/ethernet/eth.c                                 |   7 +-
 net/ipv4/af_inet.c                                 |  19 +-
 net/ipv4/fou.c                                     |  62 ++++---
 net/ipv4/gre_offload.c                             |  12 +-
 net/ipv4/inet_hashtables.c                         |   2 +-
 net/ipv4/tcp_bpf.c                                 |   2 +-
 net/ipv4/udp_offload.c                             |   6 +-
 net/ipv6/ila/ila.h                                 |   1 +
 net/ipv6/ila/ila_main.c                            |   6 +
 net/ipv6/ila/ila_xlat.c                            |  13 +-
 net/ipv6/ip6_offload.c                             |  14 +-
 net/ipv6/udp_offload.c                             |   2 -
 net/mptcp/options.c                                |  34 ++--
 net/mptcp/pm.c                                     |  24 +--
 net/mptcp/pm_netlink.c                             |  59 +++---
 net/mptcp/protocol.c                               |  54 +++---
 net/mptcp/protocol.h                               |   4 +-
 net/mptcp/subflow.c                                |  50 ++---
 net/netfilter/nf_conncount.c                       |   8 +-
 net/sched/sch_cake.c                               |  11 +-
 net/sched/sch_netem.c                              |   9 +-
 net/sunrpc/stats.c                                 |   2 +-
 net/sunrpc/svc.c                                   |  36 ++--
 net/sunrpc/xprtrdma/svc_rdma_rw.c                  |   2 +
 net/sunrpc/xprtsock.c                              |   7 +
 net/unix/af_unix.c                                 |   9 +-
 net/wireless/scan.c                                |  46 +++--
 security/apparmor/apparmorfs.c                     |   4 +
 security/smack/smack_lsm.c                         |  14 +-
 sound/hda/hdmi_chmap.c                             |  18 ++
 sound/pci/hda/hda_generic.c                        |  63 +++++++
 sound/pci/hda/hda_generic.h                        |   1 +
 sound/pci/hda/patch_conexant.c                     |  13 ++
 sound/pci/hda/patch_realtek.c                      |  10 +
 sound/soc/soc-dapm.c                               |   1 +
 sound/soc/soc-topology.c                           |   2 +
 tools/lib/bpf/libbpf.c                             |   4 +-
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c |   4 +-
 206 files changed, 1800 insertions(+), 1098 deletions(-)



