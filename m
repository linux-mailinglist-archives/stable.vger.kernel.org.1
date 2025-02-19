Return-Path: <stable+bounces-117278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A64EA3B601
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4124B1763EB
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95241F55FF;
	Wed, 19 Feb 2025 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EZGuw4al"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9531F4178;
	Wed, 19 Feb 2025 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954770; cv=none; b=crfne+KpWVaxoUqRTEgmGYQcbfm42qq1r9tdQcczp/wu/6yfRjhC6YtSsZnn2k+oqbCxe8clCxKKlfFIOeK9OV4zYrhUnozz2XE2Jy7W2xgiCMldhWuZy7pWPH4BswKed7WpF8TXiu4S+w+A+LsXekypiY2fUzyvOZTTHvcSsFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954770; c=relaxed/simple;
	bh=6hHaUbxVSsSveCxS3gTgIdQRVEekVbby7bCmoOBuG78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z6qTvPe6eWZJvotKyv/sBCyCAA6F5ossmiUZv4hdoYZh5DOlvl8KZ7sJMpVkR+ZwAGsPbej7m2pHTt59LjCIuOkpRreSS3YOM1Jl0kdTmyXXuvT+EO9XyvLQW6ZlwIXeuQABAccecNBfx/kb5Hv7TPrLYHNmKcNO5i9EWznKoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EZGuw4al; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DD7C4CED1;
	Wed, 19 Feb 2025 08:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739954770;
	bh=6hHaUbxVSsSveCxS3gTgIdQRVEekVbby7bCmoOBuG78=;
	h=From:To:Cc:Subject:Date:From;
	b=EZGuw4altdML8Y+U6dZY5JWBvvHHEPT6/iXvbYhz5kOBPFz80uhvLOLNswjjjAZ/w
	 gj007S9MhUlVitdEXxAmZ400GCaiWMpzDqoI/0w3OdnwuHYwutobuQPCEmoYcOJKkQ
	 N0zO7fHZkogmZh4e5KToeUARYE5JSgPu7tZoAY0k=
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
	hargar@microsoft.com,
	broonie@kernel.org
Subject: [PATCH 6.12 000/230] 6.12.16-rc1 review
Date: Wed, 19 Feb 2025 09:25:17 +0100
Message-ID: <20250219082601.683263930@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.16-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.12.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.12.16-rc1
X-KernelTest-Deadline: 2025-02-21T08:26+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.12.16 release.
There are 230 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 21 Feb 2025 08:25:11 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.16-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.12.16-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "vfio/platform: check the bounds of read/write syscalls"

Michal Luczaj <mhal@rbox.co>
    vsock: Orphan socket after transport release

Michal Luczaj <mhal@rbox.co>
    vsock: Keep the binding until socket destruction

Pavel Begunkov <asml.silence@gmail.com>
    io_uring/kbuf: reallocate buf lists on upgrade

Avri Altman <avri.altman@wdc.com>
    scsi: ufs: core: Ensure clk_gating.lock is used only after initialization

Jakub Kicinski <kuba@kernel.org>
    net: ipv6: fix dst refleaks in rpl, seg6 and ioam6 lwtunnels

Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
    cpufreq/amd-pstate: Remove the goto label in amd_pstate_update_limits

Ping-Ke Shih <pkshih@realtek.com>
    wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit

Jiri Olsa <jolsa@kernel.org>
    selftests/bpf: Fix uprobe consumer test

Jason Xing <kernelxing@tencent.com>
    bpf: handle implicit declaration of function gettid in bpf_iter.c

Andrew Cooper <andrew.cooper3@citrix.com>
    x86/static-call: Remove early_boot_irqs_disabled check to fix Xen PVH dom0

Juri Lelli <juri.lelli@redhat.com>
    sched/deadline: Check bandwidth overflow earlier for hotplug

Juri Lelli <juri.lelli@redhat.com>
    sched/deadline: Correctly account for allocated bandwidth during hotplug

Juri Lelli <juri.lelli@redhat.com>
    sched/deadline: Restore dl_server bandwidth on non-destructive root domain changes

Hangbin Liu <liuhangbin@gmail.com>
    selftests: rtnetlink: update netdevsim ipsec output format

Hangbin Liu <liuhangbin@gmail.com>
    netdevsim: print human readable IP address

Chris Brandt <chris.brandt@renesas.com>
    drm: renesas: rz-du: Increase supported resolutions

Thomas Hellström <thomas.hellstrom@linux.intel.com>
    drm/xe/tracing: Fix a potential TP_printk UAF

Christian Gmeiner <cgmeiner@igalia.com>
    drm/v3d: Stop active perfmon if it is being destroyed

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu1: don't choke on disabling the writeback connector

Stephan Gerhold <stephan.gerhold@linaro.org>
    drm/msm/dpu: fix x1e80100 intf_6 underrun/vsync interrupt

Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
    drm/rcar-du: dsi: Fix PHY lock bit check

Dan Carpenter <dan.carpenter@linaro.org>
    drm/msm/gem: prevent integer overflow in msm_ioctl_gem_submit()

Devarsh Thakkar <devarsht@ti.com>
    drm/tidss: Clear the interrupt status for interrupts being disabled

Devarsh Thakkar <devarsht@ti.com>
    drm/tidss: Fix race condition while handling interrupt registers

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/tidss: Fix issue in irq handling causing irq-flood issue

Eric Dumazet <edumazet@google.com>
    ipv6: mcast: add RCU protection to mld_newpack()

Filipe Manana <fdmanana@suse.com>
    btrfs: fix stale page cache after race between readahead and direct IO write

David Sterba <dsterba@suse.com>
    btrfs: rename __get_extent_map() and pass btrfs_inode

Eric Dumazet <edumazet@google.com>
    ipv6: mcast: extend RCU protection in igmp6_send()

Eric Dumazet <edumazet@google.com>
    ndisc: extend RCU protection in ndisc_send_skb()

Eric Dumazet <edumazet@google.com>
    openvswitch: use RCU protection in ovs_vport_cmd_fill_info()

Eric Dumazet <edumazet@google.com>
    arp: use RCU protection in arp_xmit()

Eric Dumazet <edumazet@google.com>
    neighbour: use RCU protection in __neigh_notify()

Eric Dumazet <edumazet@google.com>
    ndisc: use RCU protection in ndisc_alloc_skb()

Vicki Pfau <vi@endrift.com>
    HID: hid-steam: Move hidraw input (un)registering to work

Vicki Pfau <vi@endrift.com>
    HID: hid-steam: Make sure rumble work is canceled on removal

Eric Dumazet <edumazet@google.com>
    ipv6: icmp: convert to dev_net_rcu()

Eric Dumazet <edumazet@google.com>
    ipv6: use RCU protection in ip6_default_advmss()

Eric Dumazet <edumazet@google.com>
    flow_dissector: use RCU protection to fetch dev_net()

Eric Dumazet <edumazet@google.com>
    ipv4: icmp: convert to dev_net_rcu()

Eric Dumazet <edumazet@google.com>
    ipv4: use RCU protection in __ip_rt_update_pmtu()

Vladimir Vdovin <deliran@verdict.gg>
    net: ipv4: Cache pmtu for all packet paths if multipath enabled

Eric Dumazet <edumazet@google.com>
    ipv4: use RCU protection in inet_select_addr()

Eric Dumazet <edumazet@google.com>
    ipv4: use RCU protection in rt_is_expired()

Eric Dumazet <edumazet@google.com>
    ipv4: use RCU protection in ipv4_default_advmss()

Eric Dumazet <edumazet@google.com>
    net: add dev_net_rcu() helper

Eric Dumazet <edumazet@google.com>
    ipv4: use RCU protection in ip_dst_mtu_maybe_forward()

Eric Dumazet <edumazet@google.com>
    ipv4: add RCU protection to ip4_dst_hoplimit()

Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
    cpufreq/amd-pstate: Fix cpufreq_policy ref counting

Mario Limonciello <mario.limonciello@amd.com>
    cpufreq/amd-pstate: convert mutex use to guard()

Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
    cpufreq/amd-pstate: Merge amd_pstate_epp_cpu_offline() and amd_pstate_epp_offline()

Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
    cpufreq/amd-pstate: Remove the cppc_state check in offline/online functions

Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
    cpufreq/amd-pstate: Refactor amd_pstate_epp_reenable() and amd_pstate_epp_offline()

Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
    cpufreq/amd-pstate: Align offline flow of shared memory and MSR based systems

Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
    cpufreq/amd-pstate: Call cppc_set_epp_perf in the reenable function

Justin M. Forbes <jforbes@fedoraproject.org>
    rust: kbuild: add -fzero-init-padding-bits to bindgen_skip_cflags

Avri Altman <avri.altman@wdc.com>
    scsi: ufs: Fix toggling of clk_gating.state when clock gating is not allowed

Avri Altman <avri.altman@wdc.com>
    scsi: ufs: core: Introduce a new clock_gating lock

Avri Altman <avri.altman@wdc.com>
    scsi: ufs: core: Prepare to introduce a new clock_gating lock

Avri Altman <avri.altman@wdc.com>
    scsi: ufs: core: Introduce ufshcd_has_pending_tasks()

Waiman Long <longman@redhat.com>
    clocksource: Use migrate_disable() to avoid calling get_random_u32() in atomic context

Waiman Long <longman@redhat.com>
    clocksource: Use pr_info() for "Checking clocksource synchronization" message

Jakub Kicinski <kuba@kernel.org>
    net: ipv6: fix dst ref loops in rpl, seg6 and ioam6 lwtunnels

Justin Iurman <justin.iurman@uliege.be>
    net: ipv6: rpl_iptunnel: mitigate 2-realloc issue

Justin Iurman <justin.iurman@uliege.be>
    net: ipv6: seg6_iptunnel: mitigate 2-realloc issue

Justin Iurman <justin.iurman@uliege.be>
    net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue

Justin Iurman <justin.iurman@uliege.be>
    include: net: add static inline dst_dev_overhead() to dst.h

Filipe Manana <fdmanana@suse.com>
    btrfs: fix hole expansion when writing at an offset beyond EOF

Wentao Liang <vulab@iscas.ac.cn>
    mlxsw: Add return value check for mlxsw_sp_port_get_stats_raw()

Shyam Prasad N <sprasad@microsoft.com>
    cifs: pick channels for individual subrequests

Song Yoong Siang <yoong.siang.song@intel.com>
    igc: Set buffer type for empty frames in igc_init_empty_frame

Andy-ld Lu <andy-ld.lu@mediatek.com>
    mmc: mtk-sd: Fix register settings for hs400(es) mode

Nathan Chancellor <nathan@kernel.org>
    arm64: Handle .ARM.attributes section in linker scripts

Jiasheng Jiang <jiashengjiangcool@gmail.com>
    regmap-irq: Add missing kfree()

Lu Baolu <baolu.lu@linux.intel.com>
    iommu: Fix potential memory leak in iopf_queue_remove_device()

Varadarajan Narayanan <quic_varada@quicinc.com>
    regulator: qcom_smd: Add l2, l5 sub-node to mp5496 regulator

Tejun Heo <tj@kernel.org>
    sched_ext: Fix incorrect autogroup migration detection

Jann Horn <jannh@google.com>
    partitions: mac: fix handling of bogus partition table

Wentao Liang <vulab@iscas.ac.cn>
    gpio: stmpe: Check return value of stmpe_reg_read in stmpe_gpio_irq_sync_unlock

Mario Limonciello <mario.limonciello@amd.com>
    gpiolib: acpi: Add a quirk for Acer Nitro ANV14

Niklas Schnelle <schnelle@linux.ibm.com>
    s390/pci: Fix handling of isolated VFs

Niklas Schnelle <schnelle@linux.ibm.com>
    s390/pci: Pull search for parent PF out of zpci_iov_setup_virtfn()

Ivan Kokshaysky <ink@unseen.parts>
    alpha: align stack for page fault and user unaligned trap handlers

Ivan Kokshaysky <ink@unseen.parts>
    alpha: replace hardcoded stack offsets with autogenerated ones

John Keeping <jkeeping@inmusicbrands.com>
    serial: 8250: Fix fifo underflow on flush

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    serial: port: Always update ->iotype in __uart_read_properties()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    serial: port: Assign ->iotype correctly when ->iobase is set

Shakeel Butt <shakeel.butt@linux.dev>
    cgroup: fix race between fork and cgroup.kill

Miguel Ojeda <ojeda@kernel.org>
    rust: rbtree: fix overindented list item

Miguel Ojeda <ojeda@kernel.org>
    objtool/rust: add one more `noreturn` Rust function

Miguel Ojeda <ojeda@kernel.org>
    arm64: rust: clean Rust 1.85.0 warning using softfloat target

Ard Biesheuvel <ardb@kernel.org>
    efi: Avoid cold plugged memory for placing the kernel

Thomas Weißschuh <thomas.weissschuh@linutronix.de>
    kbuild: userprogs: fix bitsize and target detection on clang

Bjorn Helgaas <bhelgaas@google.com>
    PCI: Avoid FLR for Mediatek MT7922 WiFi

Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
    wifi: ath12k: fix handling of 6 GHz rules

Ivan Kokshaysky <ink@unseen.parts>
    alpha: make stack 16-byte aligned (most cases)

Vincent Mailhol <mailhol.vincent@wanadoo.fr>
    can: etas_es58x: fix potential NULL pointer dereference on udev->serial

Robin van der Gracht <robin@protonic.nl>
    can: rockchip: rkcanfd_handle_rx_fifo_overflow_int(): bail out if skb cannot be allocated

Alexander Hölzl <alexander.hoelzl@gmx.net>
    can: j1939: j1939_sk_send_loop(): fix unable to send messages with data length zero

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    can: c_can: fix unbalanced runtime PM disable in error path

Fedor Pchelkin <pchelkin@ispras.ru>
    can: ctucanfd: handle skb allocation failure

Johan Hovold <johan@kernel.org>
    USB: serial: option: drop MeiG Smart defines

Fabio Porcedda <fabio.porcedda@gmail.com>
    USB: serial: option: fix Telit Cinterion FN990A name

Fabio Porcedda <fabio.porcedda@gmail.com>
    USB: serial: option: add Telit Cinterion FN990B compositions

Chester A. Unal <chester.a.unal@arinc9.com>
    USB: serial: option: add MeiG Smart SLM828

Roy Luo <royluo@google.com>
    usb: gadget: core: flush gadget workqueue after device removal

Jann Horn <jannh@google.com>
    usb: cdc-acm: Fix handling of oversized fragments

Jann Horn <jannh@google.com>
    usb: cdc-acm: Check control transfer buffer size before access

Marek Vasut <marek.vasut+renesas@mailbox.org>
    USB: cdc-acm: Fill in Renesas R-Car D3 USB Download mode quirk

Alan Stern <stern@rowland.harvard.edu>
    USB: hub: Ignore non-compliant devices with too many configs or interfaces

John Keeping <jkeeping@inmusicbrands.com>
    usb: gadget: f_midi: fix MIDI Streaming descriptor lengths

Mathias Nyman <mathias.nyman@linux.intel.com>
    USB: Add USB_QUIRK_NO_LPM quirk for sony xperia xz1 smartphone

Lei Huang <huanglei@kylinos.cn>
    USB: quirks: add USB_QUIRK_NO_LPM quirk for Teclast dist

Stefan Eichenberger <stefan.eichenberger@toradex.com>
    usb: core: fix pipe creation for get_bMaxPacketSize0

Huacai Chen <chenhuacai@kernel.org>
    USB: pci-quirks: Fix HCCPARAMS register error for LS7A EHCI

Michal Pecio <michal.pecio@gmail.com>
    usb: xhci: Restore xhci_pci support for Renesas HCs

Fabrice Gasnier <fabrice.gasnier@foss.st.com>
    usb: dwc2: gadget: remove of_node reference upon udc_stop

Guo Ren <guoren@kernel.org>
    usb: gadget: udc: renesas_usb3: Fix compiler warning

Elson Roy Serrao <quic_eserrao@quicinc.com>
    usb: roles: set switch registered flag early on

Selvarasu Ganesan <selvarasu.g@samsung.com>
    usb: dwc3: Fix timeout issue during controller enter/exit from halt state

Selvarasu Ganesan <selvarasu.g@samsung.com>
    usb: gadget: f_midi: Fixing wMaxPacketSize exceeded issue during MIDI bind retries

Steven Rostedt <rostedt@goodmis.org>
    ring-buffer: Update pages_touched to reflect persistent buffer content

Steven Rostedt <rostedt@goodmis.org>
    ring-buffer: Validate the persistent meta data subbuf array

Steven Rostedt <rostedt@goodmis.org>
    tracing: Do not allow mmap() of persistent ring buffer

Steven Rostedt <rostedt@goodmis.org>
    ring-buffer: Unlock resize on mmap error

Sean Christopherson <seanjc@google.com>
    perf/x86/intel: Ensure LBRs are disabled when a CPU is starting

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF

Sean Christopherson <seanjc@google.com>
    KVM: nSVM: Enter guest mode before initializing nested NPT MMU

Sean Christopherson <seanjc@google.com>
    KVM: x86: Load DR6 with guest value only before entering .vcpu_run() loop

Sean Christopherson <seanjc@google.com>
    KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if local APIC isn't in-kernel

Jiang Liu <gerry@linux.alibaba.com>
    drm/amdgpu: avoid buffer overflow attach in smu_sys_set_pp_table()

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: bump version for RV/PCO compute fix

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/gfx9: manually control gfxoff for CS on RV

Sven Eckelmann <sven@narfation.org>
    batman-adv: Drop unmanaged ELP metric worker

Sven Eckelmann <sven@narfation.org>
    batman-adv: Ignore neighbor throughput metrics in error case

Andy Strohman <andrew@andrewstrohman.com>
    batman-adv: fix panic during interface removal

Kees Cook <kees@kernel.org>
    kbuild: Use -fzero-init-padding-bits=all

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: bytcr_rt5640: Add DMI quirk for Vexia Edu Atla 10 tablet 5V

Masahiro Yamada <masahiroy@kernel.org>
    kbuild: suppress stdout from merge_config for silent builds

Mike Marshall <hubcap@omnibond.com>
    orangefs: fix a oob in orangefs_debug_write

Rik van Riel <riel@fb.com>
    x86/mm/tlb: Only trim the mm_cpumask once a second

Hans de Goede <hdegoede@redhat.com>
    ACPI: x86: Add skip i2c clients quirk for Vexia EDU ATLA 10 tablet 5V

Koichiro Den <koichiro.den@canonical.com>
    selftests: gpio: gpio-sim: Fix missing chip disablements

Maksym Planeta <maksym@exostellar.io>
    Grab mm lock before grabbing pt lock

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Unify inode corruption marking with _ntfs_bad_inode()

Ankit Agrawal <ankita@nvidia.com>
    vfio/nvgrace-gpu: Expose the blackwell device PF BAR1 to the VM

Ankit Agrawal <ankita@nvidia.com>
    vfio/nvgrace-gpu: Read dvsec register to determine need for uncached resmem

Zichen Xie <zichenxie0106@gmail.com>
    NFS: Fix potential buffer overflowin nfs_sysfs_link_rpc_client()

Ramesh Thomas <ramesh.thomas@intel.com>
    vfio/pci: Enable iowrite64 and ioread64 for vfio pci

Brian Norris <briannorris@chromium.org>
    kunit: platform: Resolve 'struct completion' warning

Rengarajan S <rengarajan.s@microchip.com>
    8250: microchip: pci1xxxx: Add workaround for RTS bit toggle

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    serial: 8250_pci: Share WCH IDs with parport_serial driver

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    serial: 8250_pci: Resolve WCH vendor ID ambiguity

Tomas Glozar <tglozar@redhat.com>
    rtla/timerlat_top: Abort event processing on second signal

Tomas Glozar <tglozar@redhat.com>
    rtla/timerlat_hist: Abort event processing on second signal

Guixin Liu <kanie@linux.alibaba.com>
    scsi: ufs: bsg: Set bsg_queue to NULL after removal

Rakesh Babu Saladi <Saladi.Rakeshbabu@microchip.com>
    PCI: switchtec: Add Microchip PCI100X device IDs

Takashi Iwai <tiwai@suse.de>
    PCI/DPC: Quirk PIO log size for Intel Raptor Lake-P

Edward Adam Davis <eadavis@qq.com>
    media: vidtv: Fix a null-ptr-deref in vidtv_mux_stop_thread

Isaac Scott <isaac.scott@ideasonboard.com>
    media: uvcvideo: Add Kurokesu C1 PRO camera

Isaac Scott <isaac.scott@ideasonboard.com>
    media: uvcvideo: Add new quirk definition for the Sonix Technology Co. 292a camera

Isaac Scott <isaac.scott@ideasonboard.com>
    media: uvcvideo: Implement dual stream quirk to fix loss of usb packets

Naushir Patuck <naush@raspberrypi.com>
    media: bcm2835-unicam: Disable trigger mode operation

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    media: i2c: ds90ub953: Add error handling for i2c reads/writes

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    media: i2c: ds90ub913: Add error handling to ub913_hw_init()

Arnd Bergmann <arnd@arndb.de>
    media: cxd2841er: fix 64-bit division on gcc-9

Jarkko Nikula <jarkko.nikula@linux.intel.com>
    i3c: mipi-i3c-hci: Add support for MIPI I3C HCI on PCI bus

Jarkko Nikula <jarkko.nikula@linux.intel.com>
    i3c: mipi-i3c-hci: Add Intel specific quirk to ring resuming

Kartik Rajput <kkartik@nvidia.com>
    soc/tegra: fuse: Update Tegra234 nvmem keepout list

Aaro Koskinen <aaro.koskinen@iki.fi>
    fbdev: omap: use threaded IRQ for LCD DMA

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    firmware: qcom: scm: smc: Handle missing SCM device

Michael Margolin <mrgolin@amazon.com>
    RDMA/efa: Reset device on probe failure

Masahiro Yamada <masahiroy@kernel.org>
    tools: fix annoying "mkdir -p ..." logs when building tools in parallel

Vasant Hegde <vasant.hegde@amd.com>
    iommu/amd: Expicitly enable CNTRL.EPHEn bit in resume path

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    gpiolib: Fix crash on error in gpiochip_get_ngpios()

Chuyi Zhou <zhouchuyi@bytedance.com>
    sched_ext: Use SCX_CALL_OP_TASK in task_tick_scx

Chuyi Zhou <zhouchuyi@bytedance.com>
    sched_ext: Fix the incorrect bpf_list kfunc API in common.bpf.h.

Jens Axboe <axboe@kernel.dk>
    block: cleanup and fix batch completion adding conditions

Juergen Gross <jgross@suse.com>
    x86/xen: allow larger contiguous memory regions in PV guests

Juergen Gross <jgross@suse.com>
    xen/swiotlb: relax alignment requirements

Imre Deak <imre.deak@intel.com>
    drm: Fix DSC BPP increment decoding

Jiang Liu <gerry@linux.alibaba.com>
    drm/amdgpu: bail out when failed to load fw in psp_init_cap_microcode()

Zhu Lingshan <lingshan.zhu@amd.com>
    amdkfd: properly free gang_ctx_bo when failed to init user queue

Jens Axboe <axboe@kernel.dk>
    io_uring/uring_cmd: remove dead req_has_async_data() check

Pavel Begunkov <asml.silence@gmail.com>
    io_uring/waitid: don't abuse io_tw_state

Artur Weber <aweber.kernel@gmail.com>
    gpio: bcm-kona: Add missing newline to dev_err format string

Artur Weber <aweber.kernel@gmail.com>
    gpio: bcm-kona: Make sure GPIO bits are unlocked when requesting IRQ

Artur Weber <aweber.kernel@gmail.com>
    gpio: bcm-kona: Fix GPIO lock/unlock for banks above bank 0

Krzysztof Karas <krzysztof.karas@intel.com>
    drm/i915/selftests: avoid using uninitialized context

Tejas Upadhyay <tejas.upadhyay@intel.com>
    drm/xe/client: bo->client does not need bos_lock

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel: Clean up PEBS-via-PT on hybrid

Muhammad Adeel <Muhammad.Adeel@ibm.com>
    cgroup: Remove steal time from usage_usec

Rupinderjit Singh <rusingh@redhat.com>
    gpu: host1x: Fix a use of uninitialized mutex

Radu Rendec <rrendec@redhat.com>
    arm64: cacheinfo: Avoid out-of-bounds write to cacheinfo array

Maxime Ripard <mripard@kernel.org>
    drm/tests: hdmi: Fix WW_MUTEX_SLOWPATH failures

Andrea Righi <arighi@nvidia.com>
    sched_ext: Fix lock imbalance in dispatch_to_local_dsq()

Lai Jiangshan <jiangshan.ljs@antgroup.com>
    workqueue: Put the pwq after detaching the rescuer from the pool

Eric Dumazet <edumazet@google.com>
    team: better TEAM_OPTION_TYPE_STRING validation

Kiran K <kiran.k@intel.com>
    Bluetooth: btintel_pcie: Fix a potential race condition

Roger Quadros <rogerq@kernel.org>
    net: ethernet: ti: am65_cpsw: fix tx_cleanup for XDP case

Roger Quadros <rogerq@kernel.org>
    net: ethernet: ti: am65-cpsw: fix memleak in certain XDP cases

Bibo Mao <maobibo@loongson.cn>
    LoongArch: KVM: Fix typo issue about GCFG feature detection

Yuli Wang <wangyuli@uniontech.com>
    LoongArch: csum: Fix OoB access in IP checksum code for negative lengths

Marco Crivellari <marco.crivellari@suse.com>
    LoongArch: Fix idle VS timer enqueue

Eric Dumazet <edumazet@google.com>
    vxlan: check vxlan_vnigroup_init() return value

Zdenek Bouska <zdenek.bouska@siemens.com>
    igc: Fix HW RX timestamp when passed by ZC XDP

Joshua Hay <joshua.a.hay@intel.com>
    idpf: call set_real_num_queues in idpf_open

Sridhar Samudrala <sridhar.samudrala@intel.com>
    idpf: record rx queue in skb for RSC packets

Sridhar Samudrala <sridhar.samudrala@intel.com>
    idpf: fix handling rsc packet with a single segment

Eric Dumazet <edumazet@google.com>
    vrf: use RCU protection in l3mdev_l3_out()

Eric Dumazet <edumazet@google.com>
    ndisc: ndisc_send_redirect() must use dev_get_by_index_rcu()

Reyders Morales <reyders1@gmail.com>
    Documentation/networking: fix basic node example document ISO 15765-2

Eric Dumazet <edumazet@google.com>
    net: fib_rules: annotate data-races around rule->[io]ifindex

Murad Masimov <m.masimov@mt-integration.ru>
    ax25: Fix refcount leak caused by setting SO_BINDTODEVICE sockopt

Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
    spi: sn-f-ospi: Fix division by zero

Vicki Pfau <vi@endrift.com>
    HID: hid-steam: Don't use cancel_delayed_work_sync in IRQ context

Tulio Fernandes <tuliomf09@gmail.com>
    HID: hid-thrustmaster: fix stack-out-of-bounds read in usb_check_int_endpoints()

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    pinctrl: pinconf-generic: Print unsigned value if a format is registered

Nathan Chancellor <nathan@kernel.org>
    scripts/Makefile.extrawarn: Do not show clang's non-kprintf warnings at W=1

Charles Han <hanchunchao@inspur.com>
    HID: multitouch: Add NULL check in mt_input_configured

Charles Han <hanchunchao@inspur.com>
    HID: winwing: Add NULL check in winwing_init_led()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    pinctrl: cy8c95x0: Respect IRQ trigger settings from firmware

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    pinctrl: cy8c95x0: Rename PWMSEL to SELPWM

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    pinctrl: cy8c95x0: Enable regmap locking for debug

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    pinctrl: cy8c95x0: Avoid accessing reserved registers

Patrick Bellasi <derkling@google.com>
    x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit

Jeff Layton <jlayton@kernel.org>
    nfsd: validate the nfsd_serv pointer before calling svc_wake_up

Dai Ngo <dai.ngo@oracle.com>
    NFSD: fix hang in nfsd4_shutdown_callback

Li Lingfeng <lilingfeng3@huawei.com>
    nfsd: clear acl_access/acl_default after releasing them


-------------

Diffstat:

 .../bindings/regulator/qcom,smd-rpm-regulator.yaml |   2 +-
 Documentation/networking/iso15765-2.rst            |   4 +-
 Makefile                                           |  17 +--
 arch/alpha/include/uapi/asm/ptrace.h               |   2 +
 arch/alpha/kernel/asm-offsets.c                    |   4 +
 arch/alpha/kernel/entry.S                          |  24 ++--
 arch/alpha/kernel/traps.c                          |   2 +-
 arch/alpha/mm/fault.c                              |   4 +-
 arch/arm64/Makefile                                |   4 +
 arch/arm64/kernel/cacheinfo.c                      |  12 +-
 arch/arm64/kernel/vdso/vdso.lds.S                  |   1 +
 arch/arm64/kernel/vmlinux.lds.S                    |   1 +
 arch/loongarch/kernel/genex.S                      |  28 ++--
 arch/loongarch/kernel/idle.c                       |   3 +-
 arch/loongarch/kernel/reset.c                      |   6 +-
 arch/loongarch/kvm/main.c                          |   4 +-
 arch/loongarch/lib/csum.c                          |   2 +-
 arch/s390/pci/pci_bus.c                            |  20 +++
 arch/s390/pci/pci_iov.c                            |  56 ++++++--
 arch/s390/pci/pci_iov.h                            |   7 +
 arch/x86/Kconfig                                   |   3 +-
 arch/x86/events/intel/core.c                       |  33 ++---
 arch/x86/events/intel/ds.c                         |  10 +-
 arch/x86/include/asm/kvm-x86-ops.h                 |   1 +
 arch/x86/include/asm/kvm_host.h                    |   1 +
 arch/x86/include/asm/mmu.h                         |   2 +
 arch/x86/include/asm/mmu_context.h                 |   1 +
 arch/x86/include/asm/msr-index.h                   |   3 +-
 arch/x86/include/asm/perf_event.h                  |  28 +++-
 arch/x86/include/asm/tlbflush.h                    |   1 +
 arch/x86/kernel/cpu/bugs.c                         |  21 ++-
 arch/x86/kernel/static_call.c                      |   1 -
 arch/x86/kvm/hyperv.c                              |   6 +-
 arch/x86/kvm/mmu/mmu.c                             |   2 +-
 arch/x86/kvm/svm/nested.c                          |  10 +-
 arch/x86/kvm/svm/svm.c                             |  13 +-
 arch/x86/kvm/vmx/main.c                            |   1 +
 arch/x86/kvm/vmx/vmx.c                             |  10 +-
 arch/x86/kvm/vmx/x86_ops.h                         |   1 +
 arch/x86/kvm/x86.c                                 |   3 +
 arch/x86/mm/tlb.c                                  |  35 ++++-
 arch/x86/xen/mmu_pv.c                              |  75 +++++++++--
 block/partitions/mac.c                             |  18 ++-
 drivers/acpi/x86/utils.c                           |  13 ++
 drivers/base/regmap/regmap-irq.c                   |   2 +
 drivers/bluetooth/btintel_pcie.c                   |   5 +-
 drivers/cpufreq/amd-pstate.c                       | 104 +++++----------
 drivers/firmware/efi/efi.c                         |   6 +-
 drivers/firmware/efi/libstub/randomalloc.c         |   3 +
 drivers/firmware/efi/libstub/relocate.c            |   3 +
 drivers/firmware/qcom/qcom_scm-smc.c               |   3 +
 drivers/gpio/gpio-bcm-kona.c                       |  71 ++++++++--
 drivers/gpio/gpio-stmpe.c                          |  15 ++-
 drivers/gpio/gpiolib-acpi.c                        |  14 ++
 drivers/gpio/gpiolib.c                             |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  36 ++++-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   3 +-
 drivers/gpu/drm/display/drm_dp_helper.c            |   2 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |   4 +-
 .../drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h   |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |   3 -
 drivers/gpu/drm/msm/msm_gem_submit.c               |   3 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c    |   2 +-
 .../gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h   |   1 -
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c       |   6 +-
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |   7 +
 drivers/gpu/drm/tidss/tidss_dispc.c                |  26 ++--
 drivers/gpu/drm/tidss/tidss_irq.c                  |   2 +
 drivers/gpu/drm/v3d/v3d_perfmon.c                  |   5 +
 drivers/gpu/drm/xe/xe_drm_client.c                 |   2 +-
 drivers/gpu/drm/xe/xe_trace_bo.h                   |  12 +-
 drivers/gpu/host1x/dev.c                           |   2 +
 drivers/gpu/host1x/intr.c                          |   2 -
 drivers/hid/hid-multitouch.c                       |   5 +-
 drivers/hid/hid-steam.c                            |  41 ++++--
 drivers/hid/hid-thrustmaster.c                     |   2 +-
 drivers/hid/hid-winwing.c                          |   2 +
 drivers/i3c/master/Kconfig                         |  11 ++
 drivers/i3c/master/mipi-i3c-hci/Makefile           |   1 +
 drivers/i3c/master/mipi-i3c-hci/dma.c              |  17 +++
 drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c | 148 +++++++++++++++++++++
 drivers/infiniband/hw/efa/efa_main.c               |   9 +-
 drivers/iommu/amd/amd_iommu_types.h                |   1 +
 drivers/iommu/amd/init.c                           |   4 +
 drivers/iommu/io-pgfault.c                         |   1 +
 drivers/media/dvb-frontends/cxd2841er.c            |   8 +-
 drivers/media/i2c/ds90ub913.c                      |  25 +++-
 drivers/media/i2c/ds90ub953.c                      |  46 +++++--
 drivers/media/platform/broadcom/bcm2835-unicam.c   |   8 +-
 drivers/media/test-drivers/vidtv/vidtv_bridge.c    |   8 +-
 drivers/media/usb/uvc/uvc_driver.c                 |  18 +++
 drivers/media/usb/uvc/uvc_video.c                  |  27 +++-
 drivers/media/usb/uvc/uvcvideo.h                   |   1 +
 drivers/mmc/host/mtk-sd.c                          |  31 +++--
 drivers/net/can/c_can/c_can_platform.c             |   5 +-
 drivers/net/can/ctucanfd/ctucanfd_base.c           |  10 +-
 drivers/net/can/rockchip/rockchip_canfd-core.c     |   2 +-
 drivers/net/can/usb/etas_es58x/es58x_devlink.c     |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |   5 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |   5 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |  22 +--
 .../net/ethernet/mellanox/mlxsw/spectrum_ethtool.c |   4 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  40 +++---
 drivers/net/netdevsim/ipsec.c                      |  12 +-
 drivers/net/team/team_core.c                       |   4 +-
 drivers/net/vxlan/vxlan_core.c                     |   7 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  61 ++++++---
 drivers/net/wireless/ath/ath12k/wmi.h              |   1 -
 drivers/net/wireless/realtek/rtw89/pci.c           |  17 ++-
 drivers/net/wireless/realtek/rtw89/pci.h           |  11 ++
 drivers/net/wireless/realtek/rtw89/pci_be.c        |   2 +
 drivers/parport/parport_serial.c                   |  12 +-
 drivers/pci/quirks.c                               |  15 ++-
 drivers/pci/switch/switchtec.c                     |  26 ++++
 drivers/pinctrl/pinconf-generic.c                  |   8 +-
 drivers/pinctrl/pinctrl-cy8c95x0.c                 |  36 +++--
 drivers/soc/tegra/fuse/fuse-tegra30.c              |  17 ++-
 drivers/spi/spi-sn-f-ospi.c                        |   3 +
 drivers/tty/serial/8250/8250.h                     |   2 +
 drivers/tty/serial/8250/8250_dma.c                 |  16 +++
 drivers/tty/serial/8250/8250_pci.c                 |  76 +++++------
 drivers/tty/serial/8250/8250_pci1xxxx.c            |  60 ++++++++-
 drivers/tty/serial/8250/8250_port.c                |   9 ++
 drivers/tty/serial/serial_port.c                   |   5 +-
 drivers/ufs/core/ufs_bsg.c                         |   1 +
 drivers/ufs/core/ufshcd.c                          | 127 +++++++++---------
 drivers/usb/class/cdc-acm.c                        |  28 +++-
 drivers/usb/core/hub.c                             |  14 +-
 drivers/usb/core/quirks.c                          |   6 +
 drivers/usb/dwc2/gadget.c                          |   1 +
 drivers/usb/dwc3/gadget.c                          |  34 +++++
 drivers/usb/gadget/function/f_midi.c               |  17 ++-
 drivers/usb/gadget/udc/core.c                      |   2 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |   2 +-
 drivers/usb/host/pci-quirks.c                      |   9 ++
 drivers/usb/host/xhci-pci.c                        |   7 +-
 drivers/usb/roles/class.c                          |   5 +-
 drivers/usb/serial/option.c                        |  49 ++++---
 drivers/vfio/pci/nvgrace-gpu/main.c                |  95 ++++++++++---
 drivers/vfio/pci/vfio_pci_rdwr.c                   |   1 +
 drivers/vfio/platform/vfio_platform_common.c       |  10 --
 drivers/video/fbdev/omap/lcd_dma.c                 |   4 +-
 drivers/xen/swiotlb-xen.c                          |  20 +--
 fs/btrfs/extent_io.c                               |  29 ++--
 fs/btrfs/file.c                                    |   4 +-
 fs/nfs/sysfs.c                                     |   6 +-
 fs/nfsd/filecache.c                                |  11 +-
 fs/nfsd/nfs2acl.c                                  |   2 +
 fs/nfsd/nfs3acl.c                                  |   2 +
 fs/nfsd/nfs4callback.c                             |   7 +-
 fs/ntfs3/attrib.c                                  |   4 +-
 fs/ntfs3/dir.c                                     |   2 +-
 fs/ntfs3/frecord.c                                 |  12 +-
 fs/ntfs3/fsntfs.c                                  |   6 +-
 fs/ntfs3/index.c                                   |   6 +-
 fs/ntfs3/inode.c                                   |   3 +
 fs/orangefs/orangefs-debugfs.c                     |   4 +-
 fs/smb/client/cifsglob.h                           |   1 -
 fs/smb/client/file.c                               |   7 +-
 include/drm/display/drm_dp.h                       |   1 +
 include/kunit/platform_device.h                    |   1 +
 include/linux/blk-mq.h                             |  18 ++-
 include/linux/cgroup-defs.h                        |   6 +-
 include/linux/efi.h                                |   1 +
 include/linux/netdevice.h                          |   6 +
 include/linux/pci_ids.h                            |  11 ++
 include/linux/sched/task.h                         |   1 +
 include/net/dst.h                                  |   9 ++
 include/net/ip.h                                   |  13 +-
 include/net/l3mdev.h                               |   2 +
 include/net/net_namespace.h                        |   2 +-
 include/net/route.h                                |   9 +-
 include/ufs/ufshcd.h                               |   9 +-
 io_uring/kbuf.c                                    |  15 ++-
 io_uring/uring_cmd.c                               |   3 -
 io_uring/waitid.c                                  |   4 +-
 kernel/cgroup/cgroup.c                             |  20 +--
 kernel/cgroup/rstat.c                              |   1 -
 kernel/sched/autogroup.c                           |   4 +-
 kernel/sched/core.c                                |  29 ++--
 kernel/sched/deadline.c                            |  73 ++++++++--
 kernel/sched/ext.c                                 |  35 ++---
 kernel/sched/ext.h                                 |   4 +-
 kernel/sched/sched.h                               |   4 +-
 kernel/sched/topology.c                            |   8 +-
 kernel/time/clocksource.c                          |   9 +-
 kernel/trace/ring_buffer.c                         |  28 +++-
 kernel/trace/trace.c                               |   4 +
 kernel/workqueue.c                                 |  12 +-
 net/ax25/af_ax25.c                                 |  11 ++
 net/batman-adv/bat_v.c                             |   2 -
 net/batman-adv/bat_v_elp.c                         | 122 ++++++++++++-----
 net/batman-adv/bat_v_elp.h                         |   2 -
 net/batman-adv/types.h                             |   3 -
 net/can/j1939/socket.c                             |   4 +-
 net/can/j1939/transport.c                          |   5 +-
 net/core/fib_rules.c                               |  24 ++--
 net/core/flow_dissector.c                          |  21 +--
 net/core/neighbour.c                               |   8 +-
 net/ipv4/arp.c                                     |   4 +-
 net/ipv4/devinet.c                                 |   3 +-
 net/ipv4/icmp.c                                    |  31 +++--
 net/ipv4/route.c                                   |  39 +++++-
 net/ipv6/icmp.c                                    |  42 +++---
 net/ipv6/ioam6_iptunnel.c                          |  73 +++++-----
 net/ipv6/mcast.c                                   |  45 ++++---
 net/ipv6/ndisc.c                                   |  28 ++--
 net/ipv6/route.c                                   |   7 +-
 net/ipv6/rpl_iptunnel.c                            |  59 ++++----
 net/ipv6/seg6_iptunnel.c                           |  98 ++++++++------
 net/openvswitch/datapath.c                         |  12 +-
 net/vmw_vsock/af_vsock.c                           |  12 +-
 rust/Makefile                                      |   1 +
 rust/kernel/rbtree.rs                              |   2 +-
 scripts/Makefile.defconf                           |  13 +-
 scripts/Makefile.extrawarn                         |  13 +-
 scripts/kconfig/Makefile                           |   4 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |  17 ++-
 tools/objtool/check.c                              |   1 +
 tools/sched_ext/include/scx/common.bpf.h           |  12 +-
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c  |   6 +-
 .../selftests/bpf/prog_tests/uprobe_multi_test.c   |   9 +-
 tools/testing/selftests/gpio/gpio-sim.sh           |  31 ++++-
 tools/testing/selftests/net/pmtu.sh                | 112 +++++++++++++---
 tools/testing/selftests/net/rtnetlink.sh           |   4 +-
 tools/tracing/rtla/src/timerlat_hist.c             |   8 ++
 tools/tracing/rtla/src/timerlat_top.c              |   8 ++
 230 files changed, 2499 insertions(+), 1049 deletions(-)



