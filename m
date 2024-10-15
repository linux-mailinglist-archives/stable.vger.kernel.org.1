Return-Path: <stable+bounces-85134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D4699E5CB
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EBAE1F242F9
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2DE1EBA12;
	Tue, 15 Oct 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W7I8thsk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5801EB9EC;
	Tue, 15 Oct 2024 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992089; cv=none; b=Hac5fydEY/7x2pAoi43T+PL+Ws5MwSR59nSN5jEMT0Hd2ikv4cCRAsCIZt28vA/ZEj/iggUFFVnEclpCNe8Y80NIiTL8pDK2VZxFvmji0g8ho+aAmt471xqYmeO4QfvJqV+J9cH5e+3SLHdwX+FVsBMV5Nf+7xEaiftDg0MCe38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992089; c=relaxed/simple;
	bh=AGW6hFDHIICtPnJSTTK1wsxLNlNSHb86zv8HkLK7ChE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S5iY5QVSkP7prjh1LCfcLv0C5aZbNa+jmrcVsfL41FbcnT6cK6ZtHpe6Th7IvBvxLbQv7YSm+yt0NiHf+j12ozJnuDpeMRuLnTCtwf9QWm/0r9JTPdBJJ1+HpCbPqX9STERnA2EX828UMfJOU6N2bWpBR7/g09kT0UgplWw32F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W7I8thsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99153C4CECE;
	Tue, 15 Oct 2024 11:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728992088;
	bh=AGW6hFDHIICtPnJSTTK1wsxLNlNSHb86zv8HkLK7ChE=;
	h=From:To:Cc:Subject:Date:From;
	b=W7I8thskZDif2VjRbwu+f2n65xlPk3vi7ASoPRqbivF2DjaL+qCGNre6WFFctQkJ+
	 Ka9y43j4be8LY5AGb0Gk6w8MyCU6fbcMHbG3meHBMbGBS+/37msJoR1SbBD7hNu5su
	 GjQqJsoTuXw/F7SbF/DjeMLtp7AwpzYF0sO7GUTI=
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
Subject: [PATCH 5.15 000/691] 5.15.168-rc1 review
Date: Tue, 15 Oct 2024 13:19:08 +0200
Message-ID: <20241015112440.309539031@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.168-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.168-rc1
X-KernelTest-Deadline: 2024-10-17T11:25+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.15.168 release.
There are 691 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.168-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.168-rc1

Sean Anderson <sean.anderson@linux.dev>
    net: xilinx: axienet: Schedule NAPI in two steps

Paolo Abeni <pabeni@redhat.com>
    selftests: net: more strict check in net_helper

Andy Chiu <andy.chiu@sifive.com>
    net: axienet: start napi before enabling Rx/Tx

Jan Kara <jack@suse.cz>
    ext4: fix warning in ext4_dio_write_end_io()

Phil Sutter <phil@nwl.cc>
    netfilter: ip6t_rpfilter: Fix regression with VRF interfaces

Antoine Tenart <atenart@kernel.org>
    net: vrf: determine the dst using the original ifindex for multicast

Andrea Mayer <andrea.mayer@uniroma2.it>
    net: seg6: fix seg6_lookup_any_nexthop() to handle VRFs using flowi_l3mdev

David Ahern <dsahern@kernel.org>
    net: Handle l3mdev in ip_tunnel_init_flow

David Ahern <dsahern@kernel.org>
    xfrm: Pass flowi_oif or l3mdev as oif to xfrm_dst_lookup

Eyal Birger <eyal.birger@gmail.com>
    net: geneve: add missing netlink policy and size for IFLA_GENEVE_INNER_PROTO_INHERIT

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    i2c: smbus: Check for parent device before dereference

Thomas Richter <tmricht@linux.ibm.com>
    perf test sample-parsing: Fix branch_stack entry endianness check

Yu Kuai <yukuai3@huawei.com>
    block, bfq: fix uaf for accessing waker_bfqq after splitting

Frederic Weisbecker <frederic@kernel.org>
    kthread: unpark only parked kthread

Yonatan Maman <Ymaman@Nvidia.com>
    nouveau/dmem: Fix vulnerability in migrate_to_ram upon copy error

Matthieu Baerts (NGI0) <matttbe@kernel.org>
    mptcp: pm: do not remove closing subflows

Anatolij Gustschin <agust@denx.de>
    net: dsa: lan9303: ensure chip reset and wait for READY status

Anastasia Kovaleva <a.kovaleva@yadro.com>
    net: Fix an unsafe loop on the list

Ignat Korchagin <ignat@cloudflare.com>
    net: explicitly clear the sk pointer, when pf->create fails

Maíra Canal <mcanal@igalia.com>
    drm/v3d: Stop the active perfmon before being destroyed

SurajSonawane2415 <surajsonawane0215@gmail.com>
    hid: intel-ish-hid: Fix uninitialized variable 'rv' in ish_fw_xfer_direct_dma

Icenowy Zheng <uwu@icenowy.me>
    usb: storage: ignore bogus device raised by JieLi BR21 USB sound chip

Jose Alberto Reguero <jose.alberto.reguero@gmail.com>
    usb: xhci: Fix problem with xhci resume from suspend

Selvarasu Ganesan <selvarasu.g@samsung.com>
    usb: dwc3: core: Stop processing of pending events if controller is halted

Oliver Neukum <oneukum@suse.com>
    Revert "usb: yurex: Replace snprintf() with the safer scnprintf() variant"

Wade Wang <wade.wang@hp.com>
    HID: plantronics: Workaround for an unexcepted opposite volume key

Huang Ying <ying.huang@intel.com>
    resource: fix region_intersects() vs add_memory_driver_managed()

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    HID: amd_sfh: Switch to device-managed dmam_alloc_coherent()

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    hwmon: (adt7470) Add missing dependency on REGMAP_I2C

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    hwmon: (adm9240) Add missing dependency on REGMAP_I2C

Guenter Roeck <linux@roeck-us.net>
    hwmon: (tmp513) Add missing dependency on REGMAP_I2C

Mitchell Levy <levymitchell0@gmail.com>
    x86/fpu: Avoid writing LBR bit to IA32_XSS unless supported

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix UAF for cq async event

Eric Dumazet <edumazet@google.com>
    slip: make slhc_remember() more robust against malicious packets

Eric Dumazet <edumazet@google.com>
    ppp: fix ppp_async_encode() illegal access

Kuniyuki Iwashima <kuniyu@amazon.com>
    mctp: Handle error of rtnl_register_module().

Kuniyuki Iwashima <kuniyu@amazon.com>
    rtnetlink: Add bulk registration helpers for rtnetlink message handlers.

Nikolay Aleksandrov <razor@blackwall.org>
    net: rtnetlink: add msg kind names

Florian Westphal <fw@strlen.de>
    netfilter: fib: check correct rtable in vrf setups

Guillaume Nault <gnault@redhat.com>
    netfilter: rpfilter/fib: Set ->flowic_uid correctly for user namespaces.

Phil Sutter <phil@nwl.cc>
    netfilter: rpfilter/fib: Populate flowic_l3mdev field

David Ahern <dsahern@kernel.org>
    net: Add l3mdev index to flow struct and avoid oif reset for port devices

Florian Westphal <fw@strlen.de>
    netfilter: xtables: avoid NFPROTO_UNSPEC where needed

Xin Long <lucien.xin@gmail.com>
    sctp: ensure sk_state is set to CLOSED if hashing fails in sctp_listen_start

Rosen Penev <rosenp@gmail.com>
    net: ibm: emac: mal: fix wrong goto

Eric Dumazet <edumazet@google.com>
    net/sched: accept TCA_STAB only for root qdisc

Mohamed Khalfella <mkhalfella@purestorage.com>
    igb: Do not bring the device up after non-fatal error

Aleksandr Loktionov <aleksandr.loktionov@intel.com>
    i40e: Fix macvlan leak by synchronizing access to mac_filter_hash

Marcin Szycik <marcin.szycik@linux.intel.com>
    ice: Fix netif_is_ice() in Safe Mode

Billy Tsai <billy_tsai@aspeedtech.com>
    gpio: aspeed: Use devm_clk api to manage clock source

Billy Tsai <billy_tsai@aspeedtech.com>
    gpio: aspeed: Add the flush write to ensure the write complete.

Jonas Gorski <jonas.gorski@gmail.com>
    net: dsa: b53: fix jumbo frames on 10/100 ports

Jonas Gorski <jonas.gorski@gmail.com>
    net: dsa: b53: allow lower MTUs on BCM5325/5365

Jonas Gorski <jonas.gorski@gmail.com>
    net: dsa: b53: fix max MTU for BCM5325/BCM5365

Jonas Gorski <jonas.gorski@gmail.com>
    net: dsa: b53: fix max MTU for 1g switches

Jonas Gorski <jonas.gorski@gmail.com>
    net: dsa: b53: fix jumbo frame mtu check

Zhang Rui <rui.zhang@intel.com>
    thermal: intel: int340x: processor: Fix warning during module unload

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    thermal: int340x: processor_thermal: Set feature mask before proc_thermal_add

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    net: phy: bcm84881: Fix some error handling paths

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change

Andy Roulin <aroulin@nvidia.com>
    netfilter: br_netfilter: fix panic with metadata_dst skb

Neal Cardwell <ncardwell@google.com>
    tcp: fix tcp_enter_recovery() to zero retrans_stamp when it's safe

Neal Cardwell <ncardwell@google.com>
    tcp: fix to allow timestamp undo if no retransmits were sent

Ingo van Lil <inguin@gmx.de>
    net: phy: dp83869: fix memory corruption when enabling fiber

Yanjun Zhang <zhangyanjun@cestc.cn>
    NFSv4: Prevent NULL-pointer dereference in nfs42_complete_copies()

Dan Carpenter <dan.carpenter@linaro.org>
    SUNRPC: Fix integer overflow in decode_rc_list()

Dave Ertman <david.m.ertman@intel.com>
    ice: fix VLAN replay after reset

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Mark filecache "down" if init fails

Bob Pearson <rpearsonhpe@gmail.com>
    RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt

Andrey Shumilin <shum.sdl@nppct.ru>
    fbdev: sisfb: Fix strbuf array overflow

Alex Hung <alex.hung@amd.com>
    drm/amd/display: Check null pointer before dereferencing se

Zijun Hu <quic_zijuhu@quicinc.com>
    driver core: bus: Return -EIO instead of 0 when show/store invalid bus attribute

Zhu Jun <zhujun2@cmss.chinamobile.com>
    tools/iio: Add memory allocation failure check for trigger_name

Philip Chen <philipchen@chromium.org>
    virtio_pmem: Check device status before requesting flush

Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
    comedi: ni_routing: tools: Check when the file could not be opened

Shawn Shao <shawn.shao@jaguarmicro.com>
    usb: dwc2: Adjust the timing of USB Driver Interrupt Registration in the Crashkernel Scenario

Xu Yang <xu.yang_2@nxp.com>
    usb: chipidea: udc: enable suspend interrupt after usb reset

Peng Fan <peng.fan@nxp.com>
    clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux for i.MX7D

Peng Fan <peng.fan@nxp.com>
    remoteproc: imx_rproc: Use imx specific hook for find_loaded_rsc_table

Yunke Cao <yunkec@chromium.org>
    media: videobuf2-core: clear memory related fields in __vb2_plane_dmabuf_put()

Kaixin Wang <kxwang23@m.fudan.edu.cn>
    ntb: ntb_hw_switchtec: Fix use after free vulnerability in switchtec_ntb_remove due to race condition

Alex Williamson <alex.williamson@redhat.com>
    PCI: Mark Creative Labs EMU20k2 INTx masking as broken

Hans de Goede <hdegoede@redhat.com>
    i2c: i801: Use a different adapter-name for IDF adapters

Subramanian Ananthanarayanan <quic_skananth@quicinc.com>
    PCI: Add ACS quirk for Qualcomm SA8775P

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    clk: bcm: bcm53573: fix OF node leak in init

Md Haris Iqbal <haris.iqbal@ionos.com>
    RDMA/rtrs-srv: Avoid null pointer deref during path establishment

WangYuli <wangyuli@uniontech.com>
    PCI: Add function 0 DMA alias quirk for Glenfly Arise chip

Saravanan Vajravel <saravanan.vajravel@broadcom.com>
    RDMA/mad: Improve handling of timed out WRs of mad agent

Daniel Jordan <daniel.m.jordan@oracle.com>
    ktest.pl: Avoid false positives with grub2 skip regex

Thomas Richter <tmricht@linux.ibm.com>
    s390/cpum_sf: Remove WARN_ON_ONCE statements

Wojciech Gładysz <wojciech.gladysz@infogain.com>
    ext4: nested locking for xattr inode

Jan Kara <jack@suse.cz>
    ext4: don't set SB_RDONLY after filesystem errors

Yonghong Song <yonghong.song@linux.dev>
    bpf, x64: Fix a jit convergence issue

Gerald Schaefer <gerald.schaefer@linux.ibm.com>
    s390/mm: Add cond_resched() to cmm_alloc/free_pages()

Heiko Carstens <hca@linux.ibm.com>
    s390/facility: Disable compile time optimization for decompressor code

Tao Chen <chen.dylane@gmail.com>
    bpf: Check percpu map value size first

Mathias Krause <minipli@grsecurity.net>
    Input: synaptics-rmi4 - fix UAF of IRQ domain on driver removal

Michael S. Tsirkin <mst@redhat.com>
    virtio_console: fix misc probe bugs

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Refactor enum_rstbl to suppress static checker

Benjamin Poirier <bpoirier@nvidia.com>
    selftests: net: Remove executable bits from library scripts

Lucas Karpinski <lkarpins@redhat.com>
    selftests/net: synchronize udpgro tests' tx and rx connection

Adrien Thierry <athierry@redhat.com>
    selftests/net: give more time to udpgro bg processes to complete startup

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Have saved_cmdlines arrays all in one allocation

Rob Clark <robdclark@chromium.org>
    drm/crtc: fix uninitialized variable use even harder

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Remove precision vsnprintf() check from print event

Linus Walleij <linus.walleij@linaro.org>
    net: ethernet: cortina: Drop TSO support

Gabriel Krisman Bertazi <krisman@suse.de>
    unicode: Don't special case ignorable code points

Jaroslav Kysela <perex@perex.cz>
    ALSA: usb-audio: Fix possible NULL pointer dereference in snd_usb_pcm_has_fixed_rate()

Namhyung Kim <namhyung@kernel.org>
    perf report: Fix segfault when 'sym' sort key is not used

Haoran Zhang <wh1sper@zju.edu.cn>
    vhost/scsi: null-ptr-dereference in vhost_scsi_get_req()

Dominique Martinet <asmadeus@codewreck.org>
    9p: add missing locking around taking dentry fid list

zhanchengbin <zhanchengbin1@huawei.com>
    ext4: fix inode tree inconsistency caused by ENOMEM

Sumit Semwal <sumit.semwal@linaro.org>
    Revert "arm64: dts: qcom: sm8250: switch UFS QMP PHY to new style of bindings"

Armin Wolf <W_Armin@gmx.de>
    ACPI: battery: Fix possible crash when unregistering a battery hook

Armin Wolf <W_Armin@gmx.de>
    ACPI: battery: Simplify battery hook locking

Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
    clk: qcom: gcc-sc8180x: Add GPLL9 support

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: add tally counter fields added with RTL8125

Colin Ian King <colin.i.king@gmail.com>
    r8169: Fix spelling mistake: "tx_underun" -> "tx_underrun"

Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
    dt-bindings: clock: qcom: Add GPLL9 support on gcc-sc8180x

Manivannan Sadhasivam <mani@kernel.org>
    dt-bindings: clock: qcom: Add missing UFS QREF clocks

Umang Jain <umang.jain@ideasonboard.com>
    media: imx335: Fix reset-gpio handling

Kieran Bingham <kieran.bingham@ideasonboard.com>
    media: i2c: imx335: Enable regulator supplies

Val Packett <val@packett.cool>
    drm/rockchip: vop: clear DMA stop bit on RK3066

Hugh Cole-Baker <sigmaris@gmail.com>
    drm/rockchip: support gamma control on RK3399

Hugh Cole-Baker <sigmaris@gmail.com>
    drm/rockchip: define gamma registers for RK3399

Andrii Nakryiko <andrii@kernel.org>
    lib/buildid: harden build ID parsing logic

Alexey Dobriyan <adobriyan@gmail.com>
    build-id: require program headers to be right after ELF header

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd/display: Allow backlight to go below `AMDGPU_DM_DEFAULT_MIN_BACKLIGHT`

Oleg Nesterov <oleg@redhat.com>
    uprobes: fix kernel info leak via "[uprobes]" vma

Mark Rutland <mark.rutland@arm.com>
    arm64: errata: Expand speculative SSBS workaround once more

Mark Rutland <mark.rutland@arm.com>
    arm64: cputype: Add Neoverse-N3 definitions

Anshuman Khandual <anshuman.khandual@arm.com>
    arm64: Add Cortex-715 CPU part definition

Zhihao Cheng <chengzhihao1@huawei.com>
    ext4: dax: fix overflowing extents beyond inode size when partially writing

Jan Kara <jack@suse.cz>
    ext4: properly sync file size update after O_SYNC direct IO

Jinjie Ruan <ruanjinjie@huawei.com>
    spi: bcm63xx: Fix missing pm_runtime_disable()

Jinjie Ruan <ruanjinjie@huawei.com>
    i2c: xiic: Fix pm_runtime_set_suspended() with runtime pm enabled

Andi Shyti <andi.shyti@kernel.org>
    i2c: xiic: Use devm_clk_get_enabled()

Heiner Kallweit <hkallweit1@gmail.com>
    i2c: core: Lock address during client device instantiation

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: create debugfs entry per adapter

Akhil R <akhilrajeev@nvidia.com>
    i2c: smbus: Use device_*() functions instead of of_*()

Akhil R <akhilrajeev@nvidia.com>
    device property: Add fwnode_irq_get_byname

Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
    device property: Add fwnode_iomap()

Masahiro Yamada <masahiroy@kernel.org>
    kconfig: qconf: fix buffer overflow in debug links

Tom Chung <chiahsuan.chung@amd.com>
    drm/amd/display: Fix system hang while resume with TBT monitor

Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
    drm/sched: Add locking to drm_sched_entity_modify_sched

Al Viro <viro@zeniv.linux.org.uk>
    close_range(): fix the logics in descriptor table trimming

Wei Li <liwei391@huawei.com>
    tracing/timerlat: Fix a race during cpuhp processing

Wei Li <liwei391@huawei.com>
    tracing/hwlat: Fix a race during cpuhp processing

Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
    gpio: davinci: fix lazy disable

Filipe Manana <fdmanana@suse.com>
    btrfs: wait for fixup workers before stopping cleaner kthread during umount

Qu Wenruo <wqu@suse.com>
    btrfs: fix a NULL pointer dereference when failed to start a new trasacntion

Hans de Goede <hdegoede@redhat.com>
    ACPI: resource: Add Asus ExpertBook B2502CVA to irq1_level_low_skip_override[]

Hans de Goede <hdegoede@redhat.com>
    ACPI: resource: Add Asus Vivobook X1704VAP to irq1_level_low_skip_override[]

Nuno Sa <nuno.sa@analog.com>
    Input: adp5589-keys - fix adp5589_gpio_get_value()

Nuno Sa <nuno.sa@analog.com>
    Input: adp5589-keys - fix NULL pointer dereference

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    rtc: at91sam9: fix OF node leak in probe() error path

KhaiWenTan <khai.wen.tan@linux.intel.com>
    net: stmmac: Fix zero-division error when disabling tc cbs

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    tomoyo: fallback to realpath if symlink's pathname does not exist

Barnabás Czémán <barnabas.czeman@mainlining.org>
    iio: magnetometer: ak8975: Fix reading for ak099xx sensors

Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
    clk: qcom: gcc-sc8180x: Fix the sdcc2 and sdcc4 clocks freq table

Manivannan Sadhasivam <mani@kernel.org>
    clk: qcom: gcc-sm8250: Do not turn off PCIe GDSCs during gdsc_disable()

Zheng Wang <zyytlz.wz@163.com>
    media: venus: fix use after free bug in venus_remove due to race condition

Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
    clk: qcom: gcc-sm8150: De-register gcc_cpuss_ahb_clk_src

Mike Tipton <quic_mdtipton@quicinc.com>
    clk: qcom: clk-rpmh: Fix overflow in BCM vote

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: uapi/linux/cec.h: cec_msg_set_reply_to: zero flags

Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
    media: sun4i_csi: Implement link validate for sun4i_csi subdev

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: dispcc-sm8250: use CLK_SET_RATE_PARENT for branch clocks

Sebastian Reichel <sebastian.reichel@collabora.com>
    clk: rockchip: fix error for unknown clocks

Chun-Yi Lee <joeyli.kernel@gmail.com>
    aoe: fix the potential use-after-free problem in more places

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Fix NFSv4's PUTPUBFH operation

Li Lingfeng <lilingfeng3@huawei.com>
    nfsd: map the EBADMSG to nfserr_io to avoid warning

NeilBrown <neilb@suse.de>
    nfsd: fix delegation_blocked() to block correctly for at least 30 seconds

Matt Fleming <matt@readmodwrite.com>
    perf hist: Update hist symbol when updating maps

Yuezhang Mo <Yuezhang.Mo@sony.com>
    exfat: fix memory leak in exfat_load_bitmap()

Jisheng Zhang <jszhang@kernel.org>
    riscv: define ILLEGAL_POINTER_VALUE for 64bit

Luis Henriques (SUSE) <luis.henriques@linux.dev>
    ext4: mark fc as ineligible using an handle in ext4_xattr_set()

Luis Henriques (SUSE) <luis.henriques@linux.dev>
    ext4: use handle to mark fc as ineligible in __track_dentry_update()

Luis Henriques (SUSE) <luis.henriques@linux.dev>
    ext4: fix fast commit inode enqueueing during a full journal commit

Luis Henriques (SUSE) <luis.henriques@linux.dev>
    ext4: fix incorrect tid assumption in jbd2_journal_shrink_checkpoint_list()

Luis Henriques (SUSE) <luis.henriques@linux.dev>
    ext4: fix incorrect tid assumption in ext4_wait_for_tail_page_commit()

Baokun Li <libaokun1@huawei.com>
    ext4: update orig_path in ext4_find_extent()

Baokun Li <libaokun1@huawei.com>
    ext4: fix double brelse() the buffer of the extents path

Baokun Li <libaokun1@huawei.com>
    ext4: aovid use-after-free in ext4_ext_insert_extent()

Baokun Li <libaokun1@huawei.com>
    ext4: drop ppath from ext4_ext_replay_update_ex() to avoid double-free

Luis Henriques (SUSE) <luis.henriques@linux.dev>
    ext4: fix incorrect tid assumption in __jbd2_log_wait_for_space()

Baokun Li <libaokun1@huawei.com>
    ext4: propagate errors from ext4_find_extent() in ext4_insert_range()

Baokun Li <libaokun1@huawei.com>
    ext4: fix slab-use-after-free in ext4_split_extent_at()

yao.ly <yao.ly@linux.alibaba.com>
    ext4: correct encrypted dentry name hash when not casefolded

Edward Adam Davis <eadavis@qq.com>
    ext4: no need to continue when the number of entries is 1

Ai Chao <aichao@kylinos.cn>
    ALSA: hda/realtek: Add quirk for Huawei MateBook 13 KLV-WX9

Hans P. Moller <hmoller@uc.cl>
    ALSA: line6: add hw monitor volume control to POD HD500X

Jan Lalinsky <lalinsky@c4.cz>
    ALSA: usb-audio: Add native DSD support for Luxman D-08u

Lianqin Hu <hulianqin@vivo.com>
    ALSA: usb-audio: Add delay quirk for VIVO USB-C HEADSET

Jaroslav Kysela <perex@perex.cz>
    ALSA: core: add isascii() check to card ID generator

Thomas Zimmermann <tzimmermann@suse.de>
    drm: Consistently use struct drm_mode_rect for FB_DAMAGE_CLIPS

Helge Deller <deller@gmx.de>
    parisc: Fix itlb miss handler for 64-bit programs

Luo Gengkun <luogengkun@huaweicloud.com>
    perf/core: Fix small negative period being ignored

Hans de Goede <hdegoede@redhat.com>
    power: supply: hwmon: Fix missing temp1_max_alarm attribute

Jinjie Ruan <ruanjinjie@huawei.com>
    spi: bcm63xx: Fix module autoloading

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    firmware: tegra: bpmp: Drop unused mbox_client_to_bpmp()

Robert Hancock <robert.hancock@calian.com>
    i2c: xiic: Wait for TX empty to avoid missed TX NAKs

Jinjie Ruan <ruanjinjie@huawei.com>
    i2c: qcom-geni: Use IRQF_NO_AUTOEN flag in request_irq()

Marek Vasut <marex@denx.de>
    i2c: stm32f7: Do not prepare/unprepare clock during runtime suspend/resume

Zach Wade <zachwade.k@gmail.com>
    platform/x86: ISST: Fix the KASAN report slab-out-of-bounds bug

Heiko Carstens <hca@linux.ibm.com>
    selftests: vDSO: fix vdso_config for s390

Jens Remus <jremus@linux.ibm.com>
    selftests: vDSO: fix ELF hash table entry size for s390x

David Hildenbrand <david@redhat.com>
    selftests/mm: fix charge_reserved_hugetlb.sh test

Christophe Leroy <christophe.leroy@csgroup.eu>
    selftests: vDSO: fix vDSO symbols lookup for powerpc64

Christophe Leroy <christophe.leroy@csgroup.eu>
    selftests: vDSO: fix vdso_config for powerpc

Christophe Leroy <christophe.leroy@csgroup.eu>
    selftests: vDSO: fix vDSO name for powerpc

Yifei Liu <yifei.l.liu@oracle.com>
    selftests: breakpoints: use remaining time to check if suspend succeed

Ben Dooks <ben.dooks@codethink.co.uk>
    spi: s3c64xx: fix timeout counters in flush_fifo

Jinjie Ruan <ruanjinjie@huawei.com>
    spi: spi-imx: Fix pm_runtime_set_suspended() with runtime pm enabled

Badhri Jagan Sridharan <badhri@google.com>
    usb: typec: tcpm: Check for port partner validity before consuming it

Thomas Weißschuh <linux@weissschuh.net>
    blk-integrity: register sysfs attributes on struct device

Thomas Weißschuh <linux@weissschuh.net>
    blk-integrity: convert to struct device_attribute

Thomas Weißschuh <linux@weissschuh.net>
    blk-integrity: use sysfs_emit

Artem Sadovnikov <ancowi69@gmail.com>
    ext4: fix i_data_sem unlock order in ext4_ind_migrate()

Baokun Li <libaokun1@huawei.com>
    ext4: avoid use-after-free in ext4_ext_show_leaf()

Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
    ext4: ext4_search_dir should return a proper error

Geert Uytterhoeven <geert+renesas@glider.be>
    of/irq: Refer to actual buffer size in of_irq_parse_one()

Tim Huang <tim.huang@amd.com>
    drm/amd/pm: ensure the fw_info is not null before using it

Geert Uytterhoeven <geert+renesas@glider.be>
    drm/radeon/r100: Handle unknown family in r100_cp_init_microcode()

Kees Cook <kees@kernel.org>
    scsi: aacraid: Rearrange order of struct aac_srb_unit

Matthew Brost <matthew.brost@intel.com>
    drm/printer: Allow NULL data in devcoredump printer

Alex Hung <alex.hung@amd.com>
    drm/amd/display: Initialize get_bytes_per_element's default to 1

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/display: Fix index out of bounds in DCN30 color transformation

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/display: Fix index out of bounds in degamma hardware format translation

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/display: Fix index out of bounds in DCN30 degamma hardware format translation

Alex Hung <alex.hung@amd.com>
    drm/amd/display: Check stream before comparing them

Ckath <ckath@yandex.ru>
    platform/x86: touchscreen_dmi: add nanote-next quirk

Vishnu Sankar <vishnuocv@gmail.com>
    HID: multitouch: Add support for Thinkpad X12 Gen 2 Kbd Portfolio

Peng Liu <liupeng01@kylinos.cn>
    drm/amdgpu: enable gfxoff quirk on HP 705G4

Peng Liu <liupeng01@kylinos.cn>
    drm/amdgpu: add raven1 gfxoff quirk

Zhao Mengmeng <zhaomengmeng@kylinos.cn>
    jfs: Fix uninit-value access of new_ea in ea_buffer

Mahesh Rajashekhara <mahesh.rajashekhara@microchip.com>
    scsi: smartpqi: correct stream detection

Edward Adam Davis <eadavis@qq.com>
    jfs: check if leafidx greater than num leaves per dmap tree

Edward Adam Davis <eadavis@qq.com>
    jfs: Fix uaf in dbFreeBits

Remington Brasga <rbrasga@uci.edu>
    jfs: UBSAN: shift-out-of-bounds in dbFindBits

Alex Hung <alex.hung@amd.com>
    drm/amd/display: Check null pointers before using dc->clk_mgr

Damien Le Moal <dlemoal@kernel.org>
    ata: sata_sil: Rename sil_blacklist to sil_quirks

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/display: Add null check for top_pipe_to_program in commit_planes_for_stream

Sanjay K Kumar <sanjay.k.kumar@intel.com>
    iommu/vt-d: Fix potential lockup if qi_submit_sync called with 0 count

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Always reserve a domain ID for identity setup

Andrew Davis <afd@ti.com>
    power: reset: brcmstb: Do not go into infinite loop if reset fails

Marc Gonzalez <mgonzalez@freebox.fr>
    iommu/arm-smmu-qcom: hide last LPASS SMMU context bank from linux

Paul E. McKenney <paulmck@kernel.org>
    rcuscale: Provide clear error when async specified without primitives

Kaixin Wang <kxwang23@m.fudan.edu.cn>
    fbdev: pxafb: Fix possible use after free in pxafb_task()

Kees Cook <kees@kernel.org>
    x86/syscall: Avoid memcpy() for ia32 syscall_get_arguments()

Takashi Iwai <tiwai@suse.de>
    ALSA: hdsp: Break infinite MIDI input flush loop

Takashi Iwai <tiwai@suse.de>
    ALSA: asihpi: Fix potential OOB array access

Ahmed S. Darwish <darwi@linutronix.de>
    tools/x86/kcpuid: Protect against faulty "max subleaf" values

Joshua Pius <joshuapius@chromium.org>
    ALSA: usb-audio: Add logitech Audio profile quirk

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Define macros for quirk table entries

Thomas Gleixner <tglx@linutronix.de>
    x86/ioapic: Handle allocation failures gracefully

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Add input value sanity checks for standard types

Thomas Gleixner <tglx@linutronix.de>
    signal: Replace BUG_ON()s

Jinjie Ruan <ruanjinjie@huawei.com>
    nfp: Use IRQF_NO_AUTOEN flag in request_irq()

Gustavo A. R. Silva <gustavoars@kernel.org>
    wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_cmd_802_11_scan_ext()

Felix Fietkau <nbd@nbd.name>
    wifi: mt76: mt7915: hold dev->mt76.mutex while disabling tx worker

Adrian Ratiu <adrian.ratiu@collabora.com>
    proc: add config & param to block forcing mem writes

Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
    ACPICA: iasl: handle empty connection_node

Jason Xing <kernelxing@tencent.com>
    tcp: avoid reusing FIN_WAIT2 when trying to find port in connect() process

Simon Horman <horms@kernel.org>
    net: atlantic: Avoid warning about potential string truncation

Ido Schimmel <idosch@nvidia.com>
    ipv4: Mask upper DSCP bits and ECN bits in NETLINK_FIB_LOOKUP family

Kuniyuki Iwashima <kuniyu@amazon.com>
    ipv4: Check !in_dev earlier for ioctl(SIOCSIFADDR).

Simon Horman <horms@kernel.org>
    net: mvpp2: Increase size of queue_name buffer

Simon Horman <horms@kernel.org>
    tipc: guard against string buffer overrun

Pei Xiao <xiaopei01@kylinos.cn>
    ACPICA: check null return of ACPI_ALLOCATE_ZEROED() in acpi_db_convert_to_package()

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPI: EC: Do not release locks during operation region accesses

Zong-Zhe Yang <kevin_yang@realtek.com>
    wifi: rtw88: select WANT_DEV_COREDUMP

Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
    wifi: ath11k: fix array out-of-bound access in SoC stats

Keith Busch <kbusch@kernel.org>
    nvme-pci: qdepth 1 quirk

Konstantin Ovsepian <ovs@ovs.to>
    blk_iocost: fix more out of bound shifts

Dmitry Antipov <dmantipov@yandex.ru>
    net: sched: consistently use rcu_replace_pointer() in taprio_change()

Armin Wolf <W_Armin@gmx.de>
    ACPICA: Fix memory leak if acpi_ps_get_next_field() fails

Armin Wolf <W_Armin@gmx.de>
    ACPICA: Fix memory leak if acpi_ps_get_next_namepath() fails

Seiji Nishikawa <snishika@redhat.com>
    ACPI: PAD: fix crash in exit_round_robin()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    net: hisilicon: hns_mdio: fix OF node leak in probe()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    net: hisilicon: hip04: fix OF node leak in probe()

Jeongjun Park <aha310510@gmail.com>
    net/xen-netback: prevent UAF in xenvif_flush_hash()

Aleksandr Mishin <amishin@t-argos.ru>
    ice: Adjust over allocation of memory in ice_sched_add_root_node() and ice_sched_add_node()

Toke Høiland-Jørgensen <toke@redhat.com>
    wifi: ath9k_htc: Use __skb_set_length() for resetting urb before resubmit

Dmitry Kandybka <d.kandybka@gmail.com>
    wifi: ath9k: fix possible integer overflow in ath9k_get_et_stats()

Jann Horn <jannh@google.com>
    f2fs: Require FMODE_WRITE for atomic write ioctls

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/conexant: Fix conflicting quirk for System76 Pangolin

Hui Wang <hui.wang@canonical.com>
    ASoC: imx-card: Set card.owner to avoid a warning calltrace if SND=m

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/generic: Unconditionally prefer preferred_dacs pairs

Oder Chiou <oder_chiou@realtek.com>
    ALSA: hda/realtek: Fix the push button function for the ALC257

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    ALSA: mixer_oss: Remove some incorrect kfree_const() usages

Benjamin Gaignard <benjamin.gaignard@collabora.com>
    media: usbtv: Remove useless locks in usbtv_video_free()

Robert Hancock <robert.hancock@calian.com>
    i2c: xiic: Try re-initialization on bus busy timeout

Marc Ferland <marc.ferland@sonatest.com>
    i2c: xiic: improve error message when transfer fails to start

Lars-Peter Clausen <lars@metafoo.de>
    i2c: xiic: xiic_xfer(): Fix runtime PM leak on error path

Marek Vasut <marex@denx.de>
    i2c: xiic: Fix RX IRQ busy check

Marek Vasut <marex@denx.de>
    i2c: xiic: Switch from waitqueue to completion

Marek Vasut <marex@denx.de>
    i2c: xiic: Fix broken locking on tx_msg

Xin Long <lucien.xin@gmail.com>
    sctp: set sk_state back to CLOSED if autobind fails in sctp_listen_start

Eric Dumazet <edumazet@google.com>
    ppp: do not assume bh is held in ppp_channel_bridge_input()

Anton Danilov <littlesmilingcloud@gmail.com>
    ipv4: ip_gre: Fix drops of small packets in ipgre_xmit

Shenwei Wang <shenwei.wang@nxp.com>
    net: stmmac: dwmac4: extend timeout for VLAN Tag register busy bit check

Kurt Kanzenbach <kurt@linutronix.de>
    net: stmmac: Disable automatic FCS/Pad stripping

Zekun Shen <bruceshenzk@gmail.com>
    stmmac_pci: Fix underflow size in stmmac_rx

Eric Dumazet <edumazet@google.com>
    net: add more sanity checks to qdisc_pkt_len_init()

Eric Dumazet <edumazet@google.com>
    net: avoid potential underflow in qdisc_pkt_len_init() with UFO

Aleksander Jan Bajkowski <olek2@wp.pl>
    net: ethernet: lantiq_etop: fix memory disclosure

Jinjie Ruan <ruanjinjie@huawei.com>
    Bluetooth: btmrvl: Use IRQF_NO_AUTOEN flag in request_irq()

Eric Dumazet <edumazet@google.com>
    netfilter: nf_tables: prevent nf_skb_duplicated corruption

Jinjie Ruan <ruanjinjie@huawei.com>
    net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in request_irq()

Phil Sutter <phil@nwl.cc>
    netfilter: uapi: NFTA_FLOWTABLE_HOOK is NLA_NESTED

Elena Salomatkina <esalomatkina@ispras.ru>
    net/mlx5e: Fix NULL deref in mlx5e_tir_builder_alloc()

Mohamed Khalfella <mkhalfella@purestorage.com>
    net/mlx5: Added cond_resched() to crdump collection

Gerd Bayer <gbayer@linux.ibm.com>
    net/mlx5: Fix error path in multi-packet WQE transmit

Jinjie Ruan <ruanjinjie@huawei.com>
    ieee802154: Fix build error

Xiubo Li <xiubli@redhat.com>
    ceph: remove the incorrect Fw reference check when dirtying pages

Stefan Wahren <wahrenst@gmx.net>
    mailbox: bcm2835: Fix timeout during suspend mode

Liao Chen <liaochen4@huawei.com>
    mailbox: rockchip: fix a typo in module autoloading

Thomas Gleixner <tglx@linutronix.de>
    static_call: Replace pointless WARN_ON() in static_call_module_notify()

Thomas Gleixner <tglx@linutronix.de>
    static_call: Handle module init failure correctly in static_call_del_module()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    spi: lpspi: Simplify some error message

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    usb: yurex: Fix inconsistent locking bug in yurex_read()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    i2c: isch: Add missed 'else'

Tommy Huang <tommy_huang@aspeedtech.com>
    i2c: aspeed: Update the stop sw state when the bus recovery occurs

David Gow <davidgow@google.com>
    mm: only enforce minimum stack gap size if it's sensible

Zhiguo Niu <zhiguo.niu@unisoc.com>
    lockdep: fix deadlock issue between lockdep and rcu

Song Liu <song@kernel.org>
    bpf: lsm: Set bpf_lsm_blob_sizes.lbs_task to 0

Felix Moessbauer <felix.moessbauer@siemens.com>
    io_uring/sqpoll: do not allow pinning outside of cpuset

Dmitry Vyukov <dvyukov@google.com>
    x86/entry: Remove unwanted instrumentation in common_interrupt()

Xin Li <xin3.li@intel.com>
    x86/idtentry: Incorporate definitions/declarations of the FRED entries

Ma Ke <make24@iscas.ac.cn>
    pps: add an error check in parport_attach

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    pps: remove usage of the deprecated ida_simple_xx() API

Pawel Laszczak <pawell@cadence.com>
    usb: xhci: fix loss of data on Cadence xHC

Daehwan Jung <dh10.jung@samsung.com>
    xhci: Add a quirk for writing ERST in high-low order

Lukas Wunner <lukas@wunner.de>
    xhci: Preserve RsvdP bits in ERSTBA register correctly

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Refactor interrupter code for initial multi interrupter support.

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: remove xhci_test_trb_in_td_math early development check

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: fix event ring segment table related masks and variables in header

Oliver Neukum <oneukum@suse.com>
    USB: misc: yurex: fix race between read and write

Lee Jones <lee@kernel.org>
    usb: yurex: Replace snprintf() with the safer scnprintf() variant

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soc: versatile: realview: fix soc_dev leak during device remove

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soc: versatile: realview: fix memory leak during device remove

VanGiang Nguyen <vangiang.nguyen@rohde-schwarz.com>
    padata: use integer wrap around to prevent deadlock on seq_nr overflow

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    EDAC/igen6: Fix conversion of system address to physical memory address

Li Lingfeng <lilingfeng3@huawei.com>
    nfs: fix memory leak in error path of nfs4_do_reclaim

Mickaël Salaün <mic@digikod.net>
    fs: Fix file_set_fowner LSM hook inconsistencies

Julian Sun <sunjunchao2870@gmail.com>
    vfs: fix race between evice_inodes() and find_inode()&iput()

Dragan Simic <dsimic@manjaro.org>
    arm64: dts: rockchip: Correct the Pinebook Pro battery design capacity

Dragan Simic <dsimic@manjaro.org>
    arm64: dts: rockchip: Raise Pinebook Pro's panel backlight PWM frequency

Gaosheng Cui <cuigaosheng1@huawei.com>
    hwrng: cctrng - Add missing clk_disable_unprepare in cctrng_resume

Gaosheng Cui <cuigaosheng1@huawei.com>
    hwrng: bcm2835 - Add missing clk_disable_unprepare in bcm2835_rng_init

Guoqing Jiang <guoqing.jiang@canonical.com>
    hwrng: mtk - Use devm_pm_runtime_enable

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    f2fs: avoid potential int overflow in sanity_check_area_boundary()

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    f2fs: prevent possible int overflow in dir_block_index()

Zhen Lei <thunder.leizhen@huawei.com>
    debugobjects: Fix conditions in fill_pool()

Ma Ke <make24@iscas.ac.cn>
    wifi: mt76: mt7615: check devm_kasprintf() returned value

Bitterblue Smith <rtl8821cerfe2@gmail.com>
    wifi: rtw88: 8822c: Fix reported RX band width

Adrian Hunter <adrian.hunter@intel.com>
    perf/x86/intel/pt: Fix sampling synchronization

Ard Biesheuvel <ardb@kernel.org>
    efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption

Werner Sembach <wse@tuxedocomputers.com>
    ACPI: resource: Add another DMI match for the TongFang GMxXGxx

Thomas Weißschuh <linux@weissschuh.net>
    ACPI: sysfs: validate return type of _STR method

Mikhail Lobanov <m.lobanov@rosalinux.ru>
    drbd: Add NULL check for net_conf to prevent dereference in state validation

Qiu-ji Chen <chenqiuji666@gmail.com>
    drbd: Fix atomicity violation in drbd_uuid_set_bm()

Pavan Kumar Paluri <papaluri@amd.com>
    crypto: ccp - Properly unregister /dev/sev on sev PLATFORM_STATUS failure

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Set quirky xHC PCI hosts to D3 _after_ stopping and freeing them.

Florian Fainelli <florian.fainelli@broadcom.com>
    tty: rp2: Fix reset with non forgiving PCIe host bridges

Jann Horn <jannh@google.com>
    firmware_loader: Block path traversal

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    bus: integrator-lm: fix OF node leak in probe()

Tomas Marek <tomas.marek@elrest.cz>
    usb: dwc2: drd: fix clock gating on USB role switch

Pawel Laszczak <pawell@cadence.com>
    usb: cdnsp: Fix incorrect usb_request status

Oliver Neukum <oneukum@suse.com>
    USB: class: CDC-ACM: fix race between get_serial and set_serial

Oliver Neukum <oneukum@suse.com>
    USB: misc: cypress_cy7c63: check for short transfer

Oliver Neukum <oneukum@suse.com>
    USB: appledisplay: close race between probe and completion handler

Oliver Neukum <oneukum@suse.com>
    usbnet: fix cyclical race on disconnect with work queue

Finn Thain <fthain@linux-m68k.org>
    scsi: mac_scsi: Disallow bus errors during PDMA send

Finn Thain <fthain@linux-m68k.org>
    scsi: mac_scsi: Refactor polling loop

Finn Thain <fthain@linux-m68k.org>
    scsi: mac_scsi: Revise printk(KERN_DEBUG ...) messages

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd/display: Validate backlight caps are sane

Robin Chen <robin.chen@amd.com>
    drm/amd/display: Round calculated vtotal

Werner Sembach <wse@tuxedocomputers.com>
    Input: i8042 - add another board name for TUXEDO Stellaris Gen5 AMD line

Werner Sembach <wse@tuxedocomputers.com>
    Input: i8042 - add TUXEDO Stellaris 15 Slim Gen6 AMD to i8042 quirk table

Werner Sembach <wse@tuxedocomputers.com>
    Input: i8042 - add TUXEDO Stellaris 16 Gen5 AMD to i8042 quirk table

Roman Smirnov <r.smirnov@omp.ru>
    Revert "media: tuners: fix error return code of hybrid_tuner_request_state()"

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soc: versatile: integrator: fix OF node leak in probe() error path

Ma Ke <make24@iscas.ac.cn>
    ASoC: rt5682: Return devm_of_clk_add_hw_provider to transfer the error

Sean Anderson <sean.anderson@linux.dev>
    PCI: xilinx-nwl: Fix off-by-one in INTx IRQ handler

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    Remove *.orig pattern from .gitignore

Scott Mayhew <smayhew@redhat.com>
    selinux,smack: don't bypass permissions check in inode_setsecctx hook

Ye Bin <yebin10@huawei.com>
    vfio/pci: fix potential memory leak in vfio_intx_enable()

Tony Luck <tony.luck@intel.com>
    x86/mm: Switch to new Intel CPU model defines

Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
    powercap: RAPL: fix invalid initialization for pl4_supported field

Hans de Goede <hdegoede@redhat.com>
    Input: goodix - use the new soc_intel_is_byt() helper

Fangzhi Zuo <Jerry.Zuo@amd.com>
    drm/amd/display: Fix Synaptics Cascaded Panamera DSC Determination

Simon Horman <horms@kernel.org>
    netfilter: ctnetlink: compile ctnetlink_label_size with CONFIG_NF_CONNTRACK_EVENTS

Phil Sutter <phil@nwl.cc>
    netfilter: nf_tables: Keep deleted flowtable hooks until after RCU

Jiwon Kim <jiwonaid0@gmail.com>
    bonding: Fix unnecessary warnings and logs from bond_xdp_get_xmit_slave()

Youssef Samir <quic_yabdulra@quicinc.com>
    net: qrtr: Update packets cloning when broadcasting

Josh Hunt <johunt@akamai.com>
    tcp: check skb is non-NULL in tcp_rto_delta_us()

Thomas Weißschuh <thomas.weissschuh@linutronix.de>
    net: ipv6: select DST_CACHE from IPV6_RPL_LWTUNNEL

Kaixin Wang <kxwang23@m.fudan.edu.cn>
    net: seeq: Fix use after free vulnerability in ether3 Driver Due to Race Condition

Eric Dumazet <edumazet@google.com>
    netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_put()

Sean Anderson <sean.anderson@linux.dev>
    net: xilinx: axienet: Fix packet counting

Robert Hancock <robert.hancock@calian.com>
    net: axienet: Switch to 64-bit RX/TX statistics

Robert Hancock <robert.hancock@calian.com>
    net: axienet: Use NAPI for TX completion path

Robert Hancock <robert.hancock@calian.com>
    net: axienet: Be more careful about updating tx_bd_tail

Robert Hancock <robert.hancock@calian.com>
    net: axienet: add coalesce timer ethtool configuration

Robert Hancock <robert.hancock@calian.com>
    net: axienet: reduce default RX interrupt threshold to 1

Robert Hancock <robert.hancock@calian.com>
    net: axienet: implement NAPI and GRO receive

Robert Hancock <robert.hancock@calian.com>
    net: axienet: don't set IRQ timer when IRQ delay not used

Robert Hancock <robert.hancock@calian.com>
    net: axienet: Clean up DMA start/stop and error handling

Robert Hancock <robert.hancock@calian.com>
    net: axienet: Clean up device used for DMA calls

Mikulas Patocka <mpatocka@redhat.com>
    Revert "dm: requeue IO if mapping table not yet available"

Jason Wang <jasowang@redhat.com>
    vhost_vdpa: assign irq bypass producer token correctly

Xie Yongji <xieyongji@bytedance.com>
    vdpa: Add eventfd for the vdpa callback

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sm8250: Enable sync_state

Suzuki K Poulose <suzuki.poulose@arm.com>
    coresight: tmc: sg: Do not leak sg_table

Guillaume Stols <gstols@baylibre.com>
    iio: adc: ad7606: fix standby gpio state to match the documentation

Guillaume Stols <gstols@baylibre.com>
    iio: adc: ad7606: fix oversampling gpio array

Jinjie Ruan <ruanjinjie@huawei.com>
    spi: spi-fsl-lpspi: Undo runtime PM changes at driver exit time

Alexander Stein <alexander.stein@ew.tq-group.com>
    spi: lpspi: release requested DMA channels

Alexander Stein <alexander.stein@ew.tq-group.com>
    spi: lpspi: Silence error message upon deferred probe

Chao Yu <chao@kernel.org>
    f2fs: get rid of online repaire on corrupted directory

Chao Yu <chao@kernel.org>
    f2fs: clean up w/ dotdot_name

Chao Yu <chao@kernel.org>
    f2fs: introduce F2FS_IPU_HONOR_OPU_WRITE ipu policy

Chao Yu <chao@kernel.org>
    f2fs: fix to wait page writeback before setting gcing flag

Jack Qiu <jack.qiu@huawei.com>
    f2fs: optimize error handling in redirty_blocks

Chao Yu <chao@kernel.org>
    f2fs: reduce expensive checkpoint trigger frequency

Chao Yu <chao@kernel.org>
    f2fs: remove unneeded check condition in __f2fs_setxattr()

Chao Yu <chao@kernel.org>
    f2fs: fix to update i_ctime in __f2fs_setxattr()

Yonggil Song <yonggil.song@samsung.com>
    f2fs: fix typo

Li Lingfeng <lilingfeng3@huawei.com>
    nfsd: return -EINVAL when namelen is 0

Guoqing Jiang <guoqing.jiang@linux.dev>
    nfsd: call cache_put if xdr_reserve_space returns NULL

Max Hawking <maxahawking@sonnenkinder.org>
    ntb_perf: Fix printk format

Jinjie Ruan <ruanjinjie@huawei.com>
    ntb: intel: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()

Vitaliy Shevtsov <v.shevtsov@maxima.ru>
    RDMA/irdma: fix error message in irdma_modify_qp_roce()

Mikhail Lobanov <m.lobanov@rosalinux.ru>
    RDMA/cxgb4: Added NULL check for lookup_atid

Jinjie Ruan <ruanjinjie@huawei.com>
    riscv: Fix fp alignment bug in perf_callchain_user()

Junxian Huang <huangjunxian6@hisilicon.com>
    RDMA/hns: Optimize hem allocation performance

Junxian Huang <huangjunxian6@hisilicon.com>
    RDMA/hns: Fix VF triggering PF reset in abnormal interrupt handler

Haoyue Xu <xuhaoyue1@hisilicon.com>
    RDMA/hns: Refactor the abnormal interrupt handler function

Haoyue Xu <xuhaoyue1@hisilicon.com>
    RDMA/hns: Fix the wrong type of return value of the interrupt handler

Haoyue Xu <xuhaoyue1@hisilicon.com>
    RDMA/hns: Remove unused abnormal interrupt of type RAS

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix spin_unlock_irqrestore() called with IRQs enabled

wenglianfa <wenglianfa@huawei.com>
    RDMA/hns: Fix the overflow risk of hem_list_calc_ba_range()

Junxian Huang <huangjunxian6@hisilicon.com>
    RDMA/hns: Don't modify rq next block addr in HIP09 QPC

Jonas Blixt <jonas.blixt@actia.se>
    watchdog: imx_sc_wdt: Don't disable WDT in suspend

Patrisious Haddad <phaddad@nvidia.com>
    IB/core: Fix ib_cache_setup_one error flow cleanup

Wang Jianzheng <wangjianzheng@vivo.com>
    pinctrl: mvebu: Fix devinit_dove_pinctrl_probe function

Yangtao Li <frank.li@vivo.com>
    pinctrl: mvebu: Use devm_platform_get_and_ioremap_resource()

Jeff Layton <jlayton@kernel.org>
    nfsd: fix refcount leak when file is unhashed after being found

Jeff Layton <jlayton@kernel.org>
    nfsd: remove unneeded EEXIST error check in nfsd_do_file_acquire

David Lechner <dlechner@baylibre.com>
    clk: ti: dra7-atl: Fix leak of of_nodes

Md Haris Iqbal <haris.iqbal@ionos.com>
    RDMA/rtrs-clt: Reset cid to con_num - 1 to stay in bounds

Jack Wang <jinpu.wang@ionos.com>
    RDMA/rtrs: Reset hb_missed_cnt after receiving other traffic from peer

Yang Yingliang <yangyingliang@huawei.com>
    pinctrl: single: fix missing error code in pcs_probe()

Zhu Yanjun <yanjun.zhu@linux.dev>
    RDMA/iwcm: Fix WARNING:at_kernel/workqueue.c:#check_flush_dependency

Sean Anderson <sean.anderson@linux.dev>
    PCI: xilinx-nwl: Clean up clock on probe failure/removal

Sean Anderson <sean.anderson@linux.dev>
    PCI: xilinx-nwl: Fix register misspelling

Dan Carpenter <dan.carpenter@linaro.org>
    PCI: keystone: Fix if-statement expression in ks_pcie_quirk()

Junlin Li <make24@iscas.ac.cn>
    drivers: media: dvb-frontends/rtl2830: fix an out-of-bounds write error

Junlin Li <make24@iscas.ac.cn>
    drivers: media: dvb-frontends/rtl2832: fix an out-of-bounds write error

Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
    Input: ilitek_ts_i2c - add report id message validation

Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
    Input: ilitek_ts_i2c - avoid wrong input subsystem sync

Jonas Karlman <jonas@kwiboo.se>
    clk: rockchip: Set parent rate for DCLK_VOP clock on RK3228

Peng Fan <peng.fan@nxp.com>
    remoteproc: imx_rproc: Initialize workqueue earlier

Peng Fan <peng.fan@nxp.com>
    remoteproc: imx_rproc: Correct ddr alias for i.MX8M

Peng Fan <peng.fan@nxp.com>
    clk: imx: imx8qxp: Parent should be initialized earlier than the clock

Peng Fan <peng.fan@nxp.com>
    clk: imx: imx8qxp: Register dc0_bypass0_clk before disp clk

Zhipeng Wang <zhipeng.wang_1@nxp.com>
    clk: imx: imx8mp: fix clock tree update of TF-A managed clocks

Ian Rogers <irogers@google.com>
    perf time-utils: Fix 32-bit nsec parsing

Yang Jihong <yangjihong@bytedance.com>
    perf sched timehist: Fixed timestamp error when unable to confirm event sched_in time

Yang Jihong <yangjihong@bytedance.com>
    perf sched timehist: Fix missing free of session in perf_sched__timehist()

Ian Rogers <irogers@google.com>
    perf inject: Fix leader sampling inserting additional samples

Namhyung Kim <namhyung@kernel.org>
    perf tools: Support reading PERF_FORMAT_LOST

Ian Rogers <irogers@google.com>
    perf evsel: Rename variable cpu to index

Ian Rogers <irogers@google.com>
    perf evsel: Reduce scope of evsel__ignore_missing_thread

Madhavan Srinivasan <maddy@linux.ibm.com>
    perf test sample-parsing: Add endian test for struct branch_flags

Namhyung Kim <namhyung@kernel.org>
    perf mem: Free the allocated sort string, fixing a leak

Daniel Borkmann <daniel@iogearbox.net>
    bpf: Fix bpf_strtol and bpf_strtoul helpers for 32bit

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix potential oob read in nilfs_btree_check_delete()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: determine empty node blocks as corrupted

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix potential null-ptr-deref in nilfs_btree_insert()

Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
    ext4: avoid OOB when system.data xattr changes underneath the filesystem

Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
    ext4: return error on ext4_find_inline_entry

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: avoid negative min_clusters in find_group_orlov()

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: avoid potential buffer_head leak in __ext4_new_inode()

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: avoid buffer_head leak in ext4_mark_inode_used()

Jiawei Ye <jiawei.ye@foxmail.com>
    smackfs: Use rcu_assign_pointer() to ensure safe assignment in smk_set_cipso

yangerkun <yangerkun@huawei.com>
    ext4: clear EXT4_GROUP_INFO_WAS_TRIMMED_BIT even mount with discard

Chen Yu <yu.c.chen@intel.com>
    kthread: fix task state in kthread worker if being frozen

Lasse Collin <lasse.collin@tukaani.org>
    xz: cleanup CRC32 edits from 2018

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix C++ compile error from missing _Bool type

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix error compiling test_lru_map.c

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix errors compiling cg_storage_multi.h with musl libc

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix compiling core_reloc.c with musl-libc

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix compiling tcp_rtt.c with musl-libc

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix compiling flow_dissector.c with musl-libc

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix compiling kfree_skb.c with musl-libc

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix missing ARRAY_SIZE() definition in bench.c

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix error compiling bpf_iter_setsockopt.c with musl libc

Tony Ambardar <tony.ambardar@gmail.com>
    selftests/bpf: Fix compile error from rlim_t in sk_storage_map.c

Jonathan McDowell <noodles@meta.com>
    tpm: Clean up TPM space after command failure

Juergen Gross <jgross@suse.com>
    xen/swiotlb: add alignment check for dma buffers

Juergen Gross <jgross@suse.com>
    xen: use correct end address of kernel for conflict checking

Yuesong Li <liyuesong@vivo.com>
    drivers:drm:exynos_drm_gsc:Fix wrong assignment in gsc_bind()

Sherry Yang <sherry.yang@oracle.com>
    drm/msm: fix %s null argument error

Wolfram Sang <wsa+renesas@sang-engineering.com>
    ipmi: docs: don't advertise deprecated sysfs entries

Vladimir Lypak <vladimir.lypak@gmail.com>
    drm/msm/a5xx: workaround early ring-buffer emptiness check

Rob Clark <robdclark@chromium.org>
    drm/msm: Drop priv->lastctx

Vladimir Lypak <vladimir.lypak@gmail.com>
    drm/msm/a5xx: fix races in preemption evaluation stage

Vladimir Lypak <vladimir.lypak@gmail.com>
    drm/msm/a5xx: properly clear preemption records on resume

Vladimir Lypak <vladimir.lypak@gmail.com>
    drm/msm/a5xx: disable preemption in submits by default

Aleksandr Mishin <amishin@t-argos.ru>
    drm/msm: Fix incorrect file name output in adreno_request_fw()

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/8xx: Fix kernel vs user address comparison

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/8xx: Fix initial memory mapping

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/32: Remove 'noltlbs' kernel parameter

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/32: Remove the 'nobats' kernel parameter

Fei Shao <fshao@chromium.org>
    drm/mediatek: Use spin_lock_irqsave() for CRTC event lock

Jeongjun Park <aha310510@gmail.com>
    jfs: fix out-of-bounds in dbNextAG() and diAlloc()

Dan Carpenter <dan.carpenter@linaro.org>
    scsi: elx: libefc: Fix potential use after free in efc_nport_vport_del()

Liu Ying <victor.liu@nxp.com>
    drm/bridge: lontium-lt8912b: Validate mode in drm_bridge_funcs::mode_valid()

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    drm/radeon/evergreen_cs: fix int overflow errors in cs track offsets

Jonas Karlman <jonas@kwiboo.se>
    drm/rockchip: dw_hdmi: Fix reading EDID when using a forced mode

Alex Bee <knaerzche@gmail.com>
    drm/rockchip: vop: Allow 4096px width scaling

Finn Thain <fthain@linux-m68k.org>
    scsi: NCR5380: Check for phase match during PDMA fixup

Finn Thain <fthain@linux-m68k.org>
    scsi: NCR5380: Add SCp members to struct NCR5380_cmd

Alex Deucher <alexander.deucher@amd.com>
    drm/radeon: properly handle vbios fake edid sizing

Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
    drm/radeon: Replace one-element array with flexible-array member

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: properly handle vbios fake edid sizing

Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
    drm/amdgpu: Replace one-element array with flexible-array member

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/display: Add null check for set_output_gamma in dcn30_set_output_transfer_func

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    drm/stm: Fix an error handling path in stm_drm_platform_probe()

Geert Uytterhoeven <geert+renesas@glider.be>
    pmdomain: core: Harden inter-column space in debug summary

Charles Han <hanchunchao@inspur.com>
    mtd: powernv: Add check devm_kasprintf() returned value

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    fbdev: hpfb: Fix an error handling path in hpfb_dio_probe()

Artur Weber <aweber.kernel@gmail.com>
    power: supply: max17042_battery: Fix SOC threshold calc w/ no current sense

Chris Morgan <macromorgan@hotmail.com>
    power: supply: axp20x_battery: Remove design from min and max voltage

Yuntao Liu <liuyuntao12@huawei.com>
    hwmon: (ntc_thermistor) fix module autoloading

Mirsad Todorovac <mtodorovac69@gmail.com>
    mtd: slram: insert break after errors in parsing the map

Guenter Roeck <linux@roeck-us.net>
    hwmon: (max16065) Fix alarm attributes

Andrew Davis <afd@ti.com>
    hwmon: (max16065) Remove use of i2c_match_id()

Biju Das <biju.das.jz@bp.renesas.com>
    i2c: Add i2c_get_match_data()

Guenter Roeck <linux@roeck-us.net>
    hwmon: (max16065) Fix overflows seen when writing limits

Finn Thain <fthain@linux-m68k.org>
    m68k: Fix kernel_clone_args.flags in m68k_clone()

Ankit Agrawal <agrawal.ag.ankit@gmail.com>
    clocksource/drivers/qcom: Add missing iounmap() on errors in msm_dt_timer_init()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    reset: k210: fix OF node leak in probe() error path

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    reset: berlin: fix OF node leak in probe() error path

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: versatile: fix OF node leak in CPUs prepare

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: imx7d-zii-rmu2: fix Ethernet PHY pinctrl property

Alexander Dahl <ada@thorsis.com>
    ARM: dts: microchip: sam9x60: Fix rtc/rtt clocks

Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
    arm64: dts: renesas: r9a07g044: Correct GICD and GICR sizes

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    spi: ppc4xx: Avoid returning 0 when failed to parse and map IRQ

Ma Ke <make24@iscas.ac.cn>
    spi: ppc4xx: handle irq_of_parse_and_map() errors

Riyan Dhiman <riyandhiman14@gmail.com>
    block: fix potential invalid pointer dereference in blk_add_partition

Christian Heusel <christian@heusel.eu>
    block: print symbolic error name instead of error code

Yu Kuai <yukuai3@huawei.com>
    block, bfq: don't break merge chain in bfq_split_bfqq()

Yu Kuai <yukuai3@huawei.com>
    block, bfq: choose the last bfqq from merge chain in bfq_setup_cooperator()

Yu Kuai <yukuai3@huawei.com>
    block, bfq: fix possible UAF for bfqq->bic with merge chain

Su Hui <suhui@nfschina.com>
    net: tipc: avoid possible garbage value

Justin Iurman <justin.iurman@uliege.be>
    net: ipv6: rpl_iptunnel: Fix memory leak in rpl_input

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: disable ALDPS per default for RTL8125

Jinjie Ruan <ruanjinjie@huawei.com>
    net: enetc: Use IRQF_NO_AUTOEN flag in request_irq()

Guillaume Nault <gnault@redhat.com>
    bareudp: Pull inner IP header on xmit.

Gal Pressman <gal@nvidia.com>
    geneve: Fix incorrect inner network header offset when innerprotoinherit is set

Eyal Birger <eyal.birger@gmail.com>
    net: geneve: support IPv4/IPv6 as inner protocol

Guillaume Nault <gnault@redhat.com>
    bareudp: Pull inner IP header in bareudp_udp_encap_recv().

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: btusb: Fix not handling ZPL/short-transfer

Marc Kleine-Budde <mkl@pengutronix.de>
    can: m_can: m_can_close(): stop clocks after device has been shut down

Kuniyuki Iwashima <kuniyu@amazon.com>
    can: bcm: Clear bo->bcm_proc_read after remove_proc_entry().

Eric Dumazet <edumazet@google.com>
    sock_map: Add a cond_resched() in sock_hash_free()

Jiawei Ye <jiawei.ye@foxmail.com>
    wifi: wilc1000: fix potential RCU dereference issue in wilc_parse_join_bss_param

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mac80211: use two-phase skb reclamation in ieee80211_do_stop()

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: cfg80211: fix two more possible UBSAN-detected off-by-one errors

Howard Hsu <howard-yh.hsu@mediatek.com>
    wifi: mt76: mt7915: fix rx filter setting for bfee functionality

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: cfg80211: fix UBSAN noise in cfg80211_wext_siwscan()

Aaron Lu <aaron.lu@intel.com>
    x86/sgx: Fix deadlock in SGX NUMA node search

Nishanth Menon <nm@ti.com>
    cpufreq: ti-cpufreq: Introduce quirks to handle syscon fails appropriately

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: remove annotation to access set timeout while holding lock

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject expiration higher than timeout

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject element expiration with no timeout

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: elements with timeout below CONFIG_HZ never expire

Clément Léger <cleger@rivosinc.com>
    ACPI: CPPC: Fix MASK_VAL() usage

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPI: bus: Avoid using CPPC if not supported by firmware

Zhang Changzhong <zhangchangzhong@huawei.com>
    can: j1939: use correct function name in comment

Kamlesh Gurudasani <kamlesh@ti.com>
    padata: Honor the caller's alignment in case of chunk_size 0

Avraham Stern <avraham.stern@intel.com>
    wifi: iwlwifi: mvm: increase the time between ranging measurements

Olaf Hering <olaf@aepfle.de>
    mount: handle OOM on mnt_warn_timestamp_expiry

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    fs/namespace: fnic: Switch to use %ptTd

Anthony Iliopoulos <ailiop@suse.com>
    mount: warn only once about timestamp range expiration

Christoph Hellwig <hch@lst.de>
    fs: explicitly unregister per-superblock BDIs

Dmitry Kandybka <d.kandybka@gmail.com>
    wifi: rtw88: remove CPT execution branch never used

Yanteng Si <siyanteng@loongson.cn>
    net: stmmac: dwmac-loongson: Init ref and PTP clocks rate

Toke Høiland-Jørgensen <toke@redhat.com>
    wifi: ath9k: Remove error checks when creating debugfs entries

Minjie Du <duminjie@vivo.com>
    wifi: ath9k: fix parameter check in ath9k_init_debug()

Aleksandr Mishin <amishin@t-argos.ru>
    ACPI: PMIC: Remove unneeded check in tps68470_pmic_opregion_probe()

Helge Deller <deller@kernel.org>
    crypto: xor - fix template benchmarking

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: rtw88: always wait for both firmware loading attempts

Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
    EDAC/synopsys: Fix error injection on Zynq UltraScale+

Serge Semin <fancer.lancer@gmail.com>
    EDAC/synopsys: Fix ECC status and IRQ control race condition

Sherry Sun <sherry.sun@nxp.com>
    EDAC/synopsys: Re-enable the error interrupts on v3 hw

Sherry Sun <sherry.sun@nxp.com>
    EDAC/synopsys: Use the correct register to disable the error interrupt on v3 hw

Dinh Nguyen <dinguyen@kernel.org>
    EDAC/synopsys: Add support for version 3 of the Synopsys EDAC DDR

Edward Adam Davis <eadavis@qq.com>
    USB: usbtmc: prevent kernel-usb-infoleak

Junhao Xie <bigfoot@classfun.cn>
    USB: serial: pl2303: add device id for Macrosilicon MS3020

Waiman Long <longman@redhat.com>
    cgroup: Move rcu_head up near the top of cgroup_root

Kent Gibson <warthog618@gmail.com>
    gpiolib: cdev: Ignore reconfiguration without direction

Florian Westphal <fw@strlen.de>
    inet: inet_defrag: prevent sk release while still in use

Hagar Hemdan <hagarhem@amazon.com>
    gpio: prevent potential speculation leaks in gpio_device_get_desc()

Ping-Ke Shih <pkshih@realtek.com>
    Revert "wifi: cfg80211: check wiphy mutex is held for wdev mutex"

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: missing iterator type in lookup walk

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_pipapo: walk over current view on netlink dump

Yafang Shao <laoar.shao@gmail.com>
    cgroup: Make operations on the cgroup root_list RCU safe

Ferry Meng <mengferry@linux.alibaba.com>
    ocfs2: strict bound check before memcmp in ocfs2_xattr_find_entry()

Ferry Meng <mengferry@linux.alibaba.com>
    ocfs2: add bounds checking to ocfs2_xattr_find_entry()

Geert Uytterhoeven <geert+renesas@glider.be>
    spi: spidev: Add missing spi_device_id for jg10309-01

Michael Kelley <mhklinux@outlook.com>
    x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when Hyper-V provides frequency

Liao Chen <liaochen4@huawei.com>
    spi: bcm63xx: Enable module autoloading

hongchi.peng <hongchi.peng@siengine.com>
    drm: komeda: Fix an issue related to normalized zpos

Fabio Estevam <festevam@gmail.com>
    spi: spidev: Add an entry for elgin,jg10309-01

Liao Chen <liaochen4@huawei.com>
    ASoC: tda7419: fix module autoloading

Liao Chen <liaochen4@huawei.com>
    ASoC: intel: fix module autoloading

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    wifi: iwlwifi: clear trans->state earlier upon error

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    wifi: iwlwifi: mvm: don't wait for tx queues if firmware is dead

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    wifi: iwlwifi: mvm: pause TCM when the firmware is stopped

Daniel Gabay <daniel.gabay@intel.com>
    wifi: iwlwifi: mvm: fix iwl_mvm_scan_fits() calculation

Benjamin Berg <benjamin.berg@intel.com>
    wifi: iwlwifi: lower message level for FW buffer destination

Jacky Chou <jacky_chou@aspeedtech.com>
    net: ftgmac100: Ensure tx descriptor updates are visible

Mike Rapoport <rppt@kernel.org>
    microblaze: don't treat zero reserved memory regions as error

Thomas Blocher <thomas.blocher@ek-dev.de>
    pinctrl: at91: make it work with current gpiolib

Sherry Yang <sherry.yang@oracle.com>
    scsi: lpfc: Fix overflow build issue

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - FIxed ALC285 headphone no sound

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Fixed ALC256 headphone no sound

Hongbo Li <lihongbo22@huawei.com>
    ASoC: allow module autoloading for table db1200_pids

Arseniy Krasnov <avkrasnov@salutedevices.com>
    ASoC: meson: axg-card: fix 'use-after-free'

T.J. Mercier <tjmercier@google.com>
    dma-buf: heaps: Fix off-by-one in CMA heap fault handler

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soundwire: stream: Revert "soundwire: stream: fix programming slave ports for non-continous port maps"

Han Xu <han.xu@nxp.com>
    spi: nxp-fspi: fix the KASAN report out-of-bounds bug

Sean Anderson <sean.anderson@linux.dev>
    net: dpaa: Pad packets to ETH_ZLEN

Florian Westphal <fw@strlen.de>
    netfilter: nft_socket: fix sk refcount leaks

Jacky Chou <jacky_chou@aspeedtech.com>
    net: ftgmac100: Enable TX interrupt to avoid TX timeout

Naveen Mamindlapalli <naveenm@marvell.com>
    octeontx2-af: Modify SMQ flush sequence to drop packets

Naveen Mamindlapalli <naveenm@marvell.com>
    octeontx2-af: Set XOFF on other child transmit schedulers during SMQ flush

Muhammad Usama Anjum <usama.anjum@collabora.com>
    fou: fix initialization of grc

Carolina Jubran <cjubran@nvidia.com>
    net/mlx5: Add missing masks and QoS bit masks for scheduling elements

Jianbo Liu <jianbol@nvidia.com>
    net/mlx5: Add IFC bits and enums for flow meter

Maor Gottlieb <maorg@nvidia.com>
    net/mlx5: Add support to create match definer

Carolina Jubran <cjubran@nvidia.com>
    net/mlx5: Explicitly set scheduling element and TSAR type

Shahar Shitrit <shshitrit@nvidia.com>
    net/mlx5e: Add missing link modes to ptys2ethtool_map

Sriram Yagnaraman <sriram.yagnaraman@est.tech>
    igb: Always call igb_xdp_ring_update_tail() under Tx lock

Jacob Keller <jacob.e.keller@intel.com>
    ice: fix accounting for filters shared by multiple VSIs

Patryk Biel <pbiel7@gmail.com>
    hwmon: (pmbus) Conditionally clear individual status bits for pmbus rev >= 1.2

Mårten Lindahl <marten.lindahl@axis.com>
    hwmon: (pmbus) Introduce and use write_byte_data callback

Michal Luczaj <mhal@rbox.co>
    selftests/bpf: Support SOCK_STREAM in unix_inet_redir_to_connected()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    eeprom: digsy_mtc: Fix 93xx46 driver probe failure

FUKAUMI Naoki <naoki@radxa.com>
    arm64: dts: rockchip: fix PMIC interrupt pin in pinctrl for ROCK Pi E

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Use kvfree to free memory allocated by kvmalloc

Linus Torvalds <torvalds@linux-foundation.org>
    mm: avoid leaving partial pfn mappings around in error case

Willem de Bruijn <willemb@google.com>
    net: tighten bad gso csum offset check in virtio_net_hdr

Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
    minmax: reduce min/max macro expansion in atomisp driver

Quentin Schulz <quentin.schulz@cherry.de>
    arm64: dts: rockchip: override BIOS_DISABLE signal via GPIO hog on RK3399 Puma

Edward Adam Davis <eadavis@qq.com>
    mptcp: pm: Fix uaf in __timer_delete_sync

Hans de Goede <hdegoede@redhat.com>
    platform/x86: panasonic-laptop: Allocate 1 entry extra in the sinf array

Hans de Goede <hdegoede@redhat.com>
    platform/x86: panasonic-laptop: Fix SINF array out of bounds accesses

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS: Avoid unnecessary rescanning of the per-server delegation list

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4: Fix clearing of layout segments in layoutreturn

Takashi Iwai <tiwai@suse.de>
    Input: i8042 - add Fujitsu Lifebook E756 to i8042 quirk table

Rob Clark <robdclark@chromium.org>
    drm/msm/adreno: Fix error return if missing firmware-name

Maximilian Luz <luzmaximilian@gmail.com>
    platform/surface: aggregator_registry: Add support for Surface Laptop Go 3

Anders Roxell <anders.roxell@linaro.org>
    scripts: kconfig: merge_config: config files: add a trailing newline

Dmitry Savin <envelsavinds@gmail.com>
    HID: multitouch: Add support for GT7868Q

Jonathan Denose <jdenose@google.com>
    Input: synaptics - enable SMBus for HP Elitebook 840 G2

Marek Vasut <marex@denx.de>
    Input: ads7846 - ratelimit the spi_sync error message

Jeff Layton <jlayton@kernel.org>
    btrfs: update target inode's ctime on unlink

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/mm: Fix boot warning with hugepages and CONFIG_DEBUG_VIRTUAL

Pawel Dembicki <paweldembicki@gmail.com>
    net: phy: vitesse: repair vsc73xx autonegotiation

Moon Yeounsu <yyyynoom@gmail.com>
    net: ethernet: use ip_hdrlen() instead of bit shift

Foster Snowhill <forst@pen.gy>
    usbnet: ipheth: fix carrier detection in modes 1 and 4

Lizhi Xu <lizhi.xu@windriver.com>
    ocfs2: fix possible null-ptr-deref in ocfs2_set_buffer_uptodate

Julian Sun <sunjunchao2870@gmail.com>
    ocfs2: fix null-ptr-deref when journal load failed.

Lizhi Xu <lizhi.xu@windriver.com>
    ocfs2: remove unreasonable unlock in ocfs2_read_blocks

Joseph Qi <joseph.qi@linux.alibaba.com>
    ocfs2: cancel dqi_sync_work before freeing oinfo

Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
    ocfs2: reserve space for inline xattr before attaching reflink tree

Joseph Qi <joseph.qi@linux.alibaba.com>
    ocfs2: fix uninit-value in ocfs2_get_block()

Heming Zhao <heming.zhao@suse.com>
    ocfs2: fix the la space leak when unmounting an ocfs2 volume

Danilo Krummrich <dakr@kernel.org>
    mm: krealloc: consider spare memory for __GFP_ZERO

Kemeng Shi <shikemeng@huaweicloud.com>
    jbd2: correctly compare tids with tid_geq function in jbd2_fc_begin_commit

Baokun Li <libaokun1@huawei.com>
    jbd2: stop waiting for space when jbd2_cleanup_journal_tail() returns error

Ma Ke <make24@iscas.ac.cn>
    drm: omapdrm: Add missing check for alloc_ordered_workqueue

Andrew Jones <ajones@ventanamicro.com>
    of/irq: Support #msi-cells=<0> in of_msi_get_domain

Helge Deller <deller@gmx.de>
    parisc: Fix stack start for ADDR_NO_RANDOMIZE personality

Helge Deller <deller@kernel.org>
    parisc: Fix 64-bit userspace syscall path


-------------

Diffstat:

 .gitignore                                         |    1 -
 Documentation/ABI/testing/sysfs-fs-f2fs            |    3 +-
 Documentation/admin-guide/kernel-parameters.txt    |   16 +-
 Documentation/arm64/silicon-errata.rst             |    4 +
 Documentation/driver-api/ipmi.rst                  |    2 +-
 Makefile                                           |    4 +-
 arch/arm/boot/dts/imx7d-zii-rmu2.dts               |    2 +-
 arch/arm/boot/dts/sam9x60.dtsi                     |    4 +-
 arch/arm/mach-realview/platsmp-dt.c                |    1 +
 arch/arm64/Kconfig                                 |    2 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |   20 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi         |    4 +-
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts  |    2 +-
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts      |    4 +-
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |   23 +-
 arch/arm64/include/asm/cputype.h                   |    4 +
 arch/arm64/kernel/cpu_errata.c                     |    2 +
 arch/m68k/kernel/process.c                         |    2 +-
 arch/microblaze/mm/init.c                          |    5 -
 arch/parisc/kernel/entry.S                         |    6 +-
 arch/parisc/kernel/syscall.S                       |   14 +-
 arch/powerpc/kernel/head_8xx.S                     |    6 +-
 arch/powerpc/kernel/setup-common.c                 |    1 +
 arch/powerpc/mm/book3s32/mmu.c                     |    2 +-
 arch/powerpc/mm/init_32.c                          |   14 -
 arch/powerpc/mm/mem.c                              |    2 -
 arch/powerpc/mm/mmu_decl.h                         |    1 -
 arch/powerpc/mm/nohash/8xx.c                       |   13 +-
 arch/powerpc/platforms/83xx/misc.c                 |   14 +-
 arch/riscv/Kconfig                                 |    5 +
 arch/riscv/kernel/perf_callchain.c                 |    2 +-
 arch/s390/include/asm/facility.h                   |    6 +-
 arch/s390/kernel/perf_cpum_sf.c                    |   12 +-
 arch/s390/mm/cmm.c                                 |   18 +-
 arch/x86/events/intel/pt.c                         |   15 +-
 arch/x86/include/asm/fpu/xstate.h                  |    5 +-
 arch/x86/include/asm/hardirq.h                     |    8 +-
 arch/x86/include/asm/idtentry.h                    |   73 +-
 arch/x86/include/asm/syscall.h                     |    7 +-
 arch/x86/kernel/apic/io_apic.c                     |   46 +-
 arch/x86/kernel/cpu/mshyperv.c                     |    1 +
 arch/x86/kernel/cpu/sgx/main.c                     |   27 +-
 arch/x86/kernel/fpu/xstate.c                       |    7 +
 arch/x86/mm/init.c                                 |   16 +-
 arch/x86/net/bpf_jit_comp.c                        |   54 +-
 arch/x86/xen/setup.c                               |    2 +-
 block/bfq-iosched.c                                |   44 +-
 block/blk-integrity.c                              |  175 +-
 block/blk-iocost.c                                 |    8 +-
 block/blk.h                                        |   10 +-
 block/genhd.c                                      |   12 +-
 block/partitions/core.c                            |    8 +-
 crypto/xor.c                                       |   31 +-
 drivers/acpi/acpi_pad.c                            |    6 +-
 drivers/acpi/acpica/dbconvert.c                    |    2 +
 drivers/acpi/acpica/exprep.c                       |    3 +
 drivers/acpi/acpica/psargs.c                       |   47 +
 drivers/acpi/battery.c                             |   28 +-
 drivers/acpi/bus.c                                 |    8 +
 drivers/acpi/cppc_acpi.c                           |   46 +-
 drivers/acpi/device_sysfs.c                        |    5 +-
 drivers/acpi/ec.c                                  |   55 +-
 drivers/acpi/pmic/tps68470_pmic.c                  |    6 +-
 drivers/acpi/resource.c                            |   20 +
 drivers/ata/sata_sil.c                             |   12 +-
 drivers/base/bus.c                                 |    6 +-
 drivers/base/firmware_loader/main.c                |   30 +
 drivers/base/power/domain.c                        |    2 +-
 drivers/base/property.c                            |   45 +
 drivers/block/aoe/aoecmd.c                         |   13 +-
 drivers/block/drbd/drbd_main.c                     |    8 +-
 drivers/block/drbd/drbd_state.c                    |    2 +-
 drivers/bluetooth/btmrvl_sdio.c                    |    3 +-
 drivers/bluetooth/btusb.c                          |    5 +-
 drivers/bus/arm-integrator-lm.c                    |    1 +
 drivers/char/hw_random/bcm2835-rng.c               |    4 +-
 drivers/char/hw_random/cctrng.c                    |    1 +
 drivers/char/hw_random/mtk-rng.c                   |    2 +-
 drivers/char/tpm/tpm-dev-common.c                  |    2 +
 drivers/char/tpm/tpm2-space.c                      |    3 +
 drivers/char/virtio_console.c                      |   18 +-
 drivers/clk/bcm/clk-bcm53573-ilp.c                 |    2 +-
 drivers/clk/imx/clk-imx7d.c                        |    4 +-
 drivers/clk/imx/clk-imx8mp.c                       |    4 +-
 drivers/clk/imx/clk-imx8qxp.c                      |   10 +-
 drivers/clk/qcom/clk-rpmh.c                        |    2 +
 drivers/clk/qcom/dispcc-sm8250.c                   |    3 +
 drivers/clk/qcom/gcc-sc8180x.c                     |   88 +-
 drivers/clk/qcom/gcc-sm8250.c                      |    6 +-
 drivers/clk/rockchip/clk-rk3228.c                  |    2 +-
 drivers/clk/rockchip/clk.c                         |    3 +-
 drivers/clk/ti/clk-dra7-atl.c                      |    1 +
 drivers/clocksource/timer-qcom.c                   |    7 +-
 .../drivers/ni_routing/tools/convert_c_to_py.c     |    5 +
 drivers/cpufreq/ti-cpufreq.c                       |   10 +-
 drivers/crypto/ccp/sev-dev.c                       |    2 +
 drivers/dma-buf/heaps/cma_heap.c                   |    2 +-
 drivers/edac/igen6_edac.c                          |    2 +-
 drivers/edac/synopsys_edac.c                       |  146 +-
 drivers/firmware/efi/libstub/tpm.c                 |    2 +-
 drivers/firmware/tegra/bpmp.c                      |    6 -
 drivers/gpio/gpio-aspeed.c                         |    4 +-
 drivers/gpio/gpio-davinci.c                        |    8 +-
 drivers/gpio/gpiolib-cdev.c                        |   13 +-
 drivers/gpio/gpiolib.c                             |    3 +-
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c     |   26 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |    4 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   22 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |    2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |    8 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |    2 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c |    2 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c |    4 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |    6 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c        |    2 +-
 .../display/dc/dml/dcn21/display_rq_dlg_calc_21.c  |    2 +-
 .../drm/amd/display/modules/freesync/freesync.c    |    2 +-
 drivers/gpu/drm/amd/include/atombios.h             |    2 +-
 .../drm/amd/pm/powerplay/hwmgr/processpptables.c   |    2 +
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |   10 +-
 drivers/gpu/drm/bridge/lontium-lt8912b.c           |   35 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  |    2 +-
 drivers/gpu/drm/drm_crtc.c                         |    1 +
 drivers/gpu/drm/drm_print.c                        |   13 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |    2 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |    5 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c              |    3 +-
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |    3 +-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |    3 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   20 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h              |    2 +
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c          |   30 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |    9 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |   10 -
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |    4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c           |    2 +-
 drivers/gpu/drm/msm/msm_drv.c                      |    6 -
 drivers/gpu/drm/msm/msm_drv.h                      |    2 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |    2 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |   11 +
 drivers/gpu/drm/nouveau/nouveau_dmem.c             |    2 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |    5 +
 drivers/gpu/drm/radeon/atombios.h                  |    2 +-
 drivers/gpu/drm/radeon/evergreen_cs.c              |   62 +-
 drivers/gpu/drm/radeon/r100.c                      |   70 +-
 drivers/gpu/drm/radeon/radeon_atombios.c           |   26 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |    2 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  113 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |    3 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |   25 +-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h        |    1 +
 drivers/gpu/drm/scheduler/sched_entity.c           |    2 +
 drivers/gpu/drm/stm/drv.c                          |    4 +-
 drivers/gpu/drm/v3d/v3d_perfmon.c                  |    9 +-
 drivers/hid/amd-sfh-hid/amd_sfh_client.c           |   14 +-
 drivers/hid/hid-ids.h                              |    5 +
 drivers/hid/hid-multitouch.c                       |   39 +
 drivers/hid/hid-plantronics.c                      |   23 +
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c        |    2 +-
 drivers/hwmon/Kconfig                              |    3 +
 drivers/hwmon/max16065.c                           |   27 +-
 drivers/hwmon/ntc_thermistor.c                     |    1 +
 drivers/hwmon/pmbus/pmbus.h                        |    8 +
 drivers/hwmon/pmbus/pmbus_core.c                   |   39 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |    2 +-
 drivers/i2c/busses/i2c-aspeed.c                    |   16 +-
 drivers/i2c/busses/i2c-i801.c                      |    9 +-
 drivers/i2c/busses/i2c-isch.c                      |    3 +-
 drivers/i2c/busses/i2c-qcom-geni.c                 |    4 +-
 drivers/i2c/busses/i2c-stm32f7.c                   |    6 +-
 drivers/i2c/busses/i2c-xiic.c                      |  138 +-
 drivers/i2c/i2c-core-base.c                        |   60 +-
 drivers/i2c/i2c-core-smbus.c                       |   15 +-
 drivers/i2c/i2c-smbus.c                            |    5 +-
 drivers/iio/adc/ad7606.c                           |    8 +-
 drivers/iio/adc/ad7606_spi.c                       |    5 +-
 drivers/iio/magnetometer/ak8975.c                  |   32 +-
 drivers/infiniband/core/cache.c                    |    4 +-
 drivers/infiniband/core/iwcm.c                     |    2 +-
 drivers/infiniband/core/mad.c                      |   14 +-
 drivers/infiniband/hw/cxgb4/cm.c                   |    5 +
 drivers/infiniband/hw/hns/hns_roce_cq.c            |   25 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c           |   22 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |   93 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |    1 -
 drivers/infiniband/hw/hns/hns_roce_qp.c            |   16 +-
 drivers/infiniband/hw/irdma/verbs.c                |    2 +-
 drivers/infiniband/sw/rxe/rxe_comp.c               |    6 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |    9 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |   14 +-
 drivers/input/keyboard/adp5589-keys.c              |   22 +-
 drivers/input/mouse/synaptics.c                    |    1 +
 drivers/input/rmi4/rmi_driver.c                    |    6 +-
 drivers/input/serio/i8042-acpipnpio.h              |   46 +
 drivers/input/touchscreen/ads7846.c                |    2 +-
 drivers/input/touchscreen/goodix.c                 |   18 +-
 drivers/input/touchscreen/ilitek_ts_i2c.c          |   18 +-
 drivers/interconnect/qcom/sm8250.c                 |    1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |    7 +
 drivers/iommu/intel/dmar.c                         |   16 +-
 drivers/iommu/intel/iommu.c                        |    6 +-
 drivers/mailbox/bcm2835-mailbox.c                  |    3 +-
 drivers/mailbox/rockchip-mailbox.c                 |    2 +-
 drivers/md/dm-rq.c                                 |    4 +-
 drivers/md/dm.c                                    |   11 +-
 drivers/media/common/videobuf2/videobuf2-core.c    |    8 +-
 drivers/media/dvb-frontends/rtl2830.c              |    2 +-
 drivers/media/dvb-frontends/rtl2832.c              |    2 +-
 drivers/media/i2c/imx335.c                         |   43 +-
 drivers/media/platform/qcom/venus/core.c           |    1 +
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c |    5 +
 drivers/media/tuners/tuner-i2c.h                   |    4 +-
 drivers/media/usb/usbtv/usbtv-video.c              |    7 -
 drivers/misc/eeprom/digsy_mtc_eeprom.c             |    2 +-
 drivers/mtd/devices/powernv_flash.c                |    3 +
 drivers/mtd/devices/slram.c                        |    2 +
 drivers/net/bareudp.c                              |   26 +-
 drivers/net/bonding/bond_main.c                    |    6 +-
 drivers/net/can/m_can/m_can.c                      |    2 +-
 drivers/net/dsa/b53/b53_common.c                   |   17 +-
 drivers/net/dsa/lan9303-core.c                     |   29 +
 .../net/ethernet/aquantia/atlantic/aq_ethtool.c    |    4 +-
 drivers/net/ethernet/cortina/gemini.c              |   15 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |   26 +-
 drivers/net/ethernet/faraday/ftgmac100.h           |    2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |    9 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       |    3 +-
 drivers/net/ethernet/hisilicon/hip04_eth.c         |    1 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |    1 +
 drivers/net/ethernet/hisilicon/hns_mdio.c          |    1 +
 drivers/net/ethernet/ibm/emac/mal.c                |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |    1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |    2 +
 drivers/net/ethernet/intel/ice/ice_main.c          |    3 +-
 drivers/net/ethernet/intel/ice/ice_sched.c         |    6 +-
 drivers/net/ethernet/intel/ice/ice_switch.c        |    4 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   21 +-
 drivers/net/ethernet/jme.c                         |   10 +-
 drivers/net/ethernet/lantiq_etop.c                 |    4 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h         |    2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   15 +
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  177 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tir.c   |    3 +
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |    4 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |    1 -
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  |    7 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |   57 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h   |    4 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   46 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |    5 +
 .../net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c  |   10 +
 .../ethernet/mellanox/mlx5/core/steering/fs_dr.c   |   15 +
 .../net/ethernet/mellanox/mlxsw/spectrum_span.c    |    2 +-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |    5 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   31 +-
 drivers/net/ethernet/realtek/r8169_phy_config.c    |    2 +
 drivers/net/ethernet/seeq/ether3.c                 |    2 +
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |    3 +
 drivers/net/ethernet/stmicro/stmmac/dwmac100.h     |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h    |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |    9 -
 .../net/ethernet/stmicro/stmmac/dwmac100_core.c    |    8 -
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   19 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   33 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |    1 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h       |   78 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |  596 +-
 drivers/net/geneve.c                               |   91 +-
 drivers/net/ieee802154/Kconfig                     |    1 +
 drivers/net/ieee802154/mcr20a.c                    |    5 +-
 drivers/net/phy/bcm84881.c                         |    4 +-
 drivers/net/phy/dp83869.c                          |    1 -
 drivers/net/phy/vitesse.c                          |   14 -
 drivers/net/ppp/ppp_async.c                        |    2 +-
 drivers/net/ppp/ppp_generic.c                      |    4 +-
 drivers/net/slip/slhc.c                            |   57 +-
 drivers/net/usb/ipheth.c                           |    5 +-
 drivers/net/usb/usbnet.c                           |   37 +-
 drivers/net/vrf.c                                  |   13 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |    2 +-
 drivers/net/wireless/ath/ath9k/debug.c             |    6 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |    6 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |    2 -
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |    2 +
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   23 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |    3 +-
 drivers/net/wireless/marvell/mwifiex/fw.h          |    2 +-
 drivers/net/wireless/marvell/mwifiex/scan.c        |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |    3 +
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |    3 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |    4 +-
 drivers/net/wireless/realtek/rtw88/Kconfig         |    1 +
 drivers/net/wireless/realtek/rtw88/coex.c          |   38 +-
 drivers/net/wireless/realtek/rtw88/main.c          |    7 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |   12 +-
 drivers/net/xen-netback/hash.c                     |    5 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.c                 |    2 +-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c             |    1 +
 drivers/ntb/test/ntb_perf.c                        |    2 +-
 drivers/nvdimm/nd_virtio.c                         |    9 +
 drivers/nvme/host/nvme.h                           |    5 +
 drivers/nvme/host/pci.c                            |   18 +-
 drivers/of/irq.c                                   |   38 +-
 drivers/pci/controller/dwc/pci-keystone.c          |    2 +-
 drivers/pci/controller/pcie-xilinx-nwl.c           |   39 +-
 drivers/pci/quirks.c                               |    8 +
 drivers/pinctrl/mvebu/pinctrl-dove.c               |   45 +-
 drivers/pinctrl/pinctrl-at91.c                     |    5 +-
 drivers/pinctrl/pinctrl-single.c                   |    3 +-
 .../platform/surface/surface_aggregator_registry.c |    3 +
 .../x86/intel/speed_select_if/isst_if_common.c     |    4 +-
 drivers/platform/x86/panasonic-laptop.c            |   58 +-
 drivers/platform/x86/touchscreen_dmi.c             |   26 +
 drivers/power/reset/brcmstb-reboot.c               |    3 -
 drivers/power/supply/axp20x_battery.c              |   16 +-
 drivers/power/supply/max17042_battery.c            |    5 +-
 drivers/power/supply/power_supply_hwmon.c          |    3 +-
 drivers/powercap/intel_rapl_msr.c                  |    6 +-
 drivers/pps/clients/pps_parport.c                  |   14 +-
 drivers/remoteproc/imx_rproc.c                     |   19 +-
 drivers/reset/reset-berlin.c                       |    3 +-
 drivers/reset/reset-k210.c                         |    3 +-
 drivers/rtc/rtc-at91sam9.c                         |    1 +
 drivers/scsi/NCR5380.c                             |  170 +-
 drivers/scsi/NCR5380.h                             |   11 +
 drivers/scsi/aacraid/aacraid.h                     |    2 +-
 drivers/scsi/atari_scsi.c                          |    4 +-
 drivers/scsi/elx/libefc/efc_nport.c                |    2 +-
 drivers/scsi/g_NCR5380.c                           |    4 +-
 drivers/scsi/lpfc/lpfc_bsg.c                       |    2 +-
 drivers/scsi/mac_scsi.c                            |  173 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |    2 +-
 drivers/scsi/sun3_scsi.c                           |    2 +-
 drivers/soc/versatile/soc-integrator.c             |    1 +
 drivers/soc/versatile/soc-realview.c               |   20 +-
 drivers/soundwire/stream.c                         |    8 +-
 drivers/spi/spi-bcm63xx.c                          |   10 +-
 drivers/spi/spi-fsl-lpspi.c                        |    9 +-
 drivers/spi/spi-imx.c                              |    2 +-
 drivers/spi/spi-nxp-fspi.c                         |    5 +-
 drivers/spi/spi-ppc4xx.c                           |    7 +-
 drivers/spi/spi-s3c64xx.c                          |    4 +-
 drivers/spi/spidev.c                               |    2 +
 drivers/staging/media/atomisp/pci/sh_css_frac.h    |   26 +-
 .../int340x_thermal/processor_thermal_device_pci.c |   23 +-
 drivers/tty/serial/rp2.c                           |    2 +-
 drivers/usb/cdns3/cdnsp-ring.c                     |    6 +-
 drivers/usb/cdns3/host.c                           |    4 +-
 drivers/usb/chipidea/udc.c                         |    8 +-
 drivers/usb/class/cdc-acm.c                        |    2 +
 drivers/usb/class/usbtmc.c                         |    2 +-
 drivers/usb/dwc2/drd.c                             |    9 +
 drivers/usb/dwc2/platform.c                        |   26 +-
 drivers/usb/dwc3/core.c                            |   22 +-
 drivers/usb/dwc3/core.h                            |    4 -
 drivers/usb/dwc3/gadget.c                          |   11 -
 drivers/usb/host/xhci-debugfs.c                    |    2 +-
 drivers/usb/host/xhci-mem.c                        |  331 +-
 drivers/usb/host/xhci-pci.c                        |   22 +-
 drivers/usb/host/xhci-ring.c                       |   82 +-
 drivers/usb/host/xhci.c                            |   54 +-
 drivers/usb/host/xhci.h                            |   32 +-
 drivers/usb/misc/appledisplay.c                    |   15 +-
 drivers/usb/misc/cypress_cy7c63.c                  |    4 +
 drivers/usb/misc/yurex.c                           |    5 +-
 drivers/usb/serial/pl2303.c                        |    1 +
 drivers/usb/serial/pl2303.h                        |    4 +
 drivers/usb/storage/unusual_devs.h                 |   11 +
 drivers/usb/typec/tcpm/tcpm.c                      |   28 +-
 drivers/vfio/pci/vfio_pci_intrs.c                  |    4 +-
 drivers/vhost/scsi.c                               |   25 +-
 drivers/vhost/vdpa.c                               |   18 +-
 drivers/video/fbdev/hpfb.c                         |    1 +
 drivers/video/fbdev/pxafb.c                        |    1 +
 drivers/video/fbdev/sis/sis_main.c                 |    2 +-
 drivers/virtio/virtio_vdpa.c                       |    1 +
 drivers/watchdog/imx_sc_wdt.c                      |   24 -
 drivers/xen/swiotlb-xen.c                          |    6 +
 fs/9p/vfs_dentry.c                                 |    9 +-
 fs/btrfs/disk-io.c                                 |   11 +
 fs/btrfs/inode.c                                   |    1 +
 fs/btrfs/relocation.c                              |    2 +-
 fs/ceph/addr.c                                     |    1 -
 fs/exec.c                                          |    3 +-
 fs/exfat/balloc.c                                  |   10 +-
 fs/ext4/dir.c                                      |   14 +-
 fs/ext4/extents.c                                  |   57 +-
 fs/ext4/fast_commit.c                              |   34 +-
 fs/ext4/file.c                                     |  155 +-
 fs/ext4/ialloc.c                                   |   14 +-
 fs/ext4/inline.c                                   |   35 +-
 fs/ext4/inode.c                                    |   11 +-
 fs/ext4/mballoc.c                                  |   10 +-
 fs/ext4/migrate.c                                  |    2 +-
 fs/ext4/move_extent.c                              |    1 -
 fs/ext4/namei.c                                    |   14 +-
 fs/ext4/super.c                                    |    9 +-
 fs/ext4/xattr.c                                    |    7 +-
 fs/f2fs/data.c                                     |   18 +-
 fs/f2fs/dir.c                                      |    3 +-
 fs/f2fs/f2fs.h                                     |   18 +-
 fs/f2fs/file.c                                     |   48 +-
 fs/f2fs/namei.c                                    |   69 -
 fs/f2fs/segment.h                                  |    5 +-
 fs/f2fs/super.c                                    |    7 +-
 fs/f2fs/xattr.c                                    |   18 +-
 fs/fcntl.c                                         |   14 +-
 fs/file.c                                          |   93 +-
 fs/inode.c                                         |    4 +
 fs/jbd2/checkpoint.c                               |   21 +-
 fs/jbd2/journal.c                                  |    4 +-
 fs/jfs/jfs_discard.c                               |   11 +-
 fs/jfs/jfs_dmap.c                                  |   11 +-
 fs/jfs/jfs_imap.c                                  |    2 +-
 fs/jfs/xattr.c                                     |    2 +
 fs/namespace.c                                     |   23 +-
 fs/nfs/callback_xdr.c                              |    2 +
 fs/nfs/client.c                                    |    1 +
 fs/nfs/delegation.c                                |   15 +-
 fs/nfs/nfs42proc.c                                 |    2 +-
 fs/nfs/nfs4proc.c                                  |    9 +-
 fs/nfs/nfs4state.c                                 |    3 +-
 fs/nfs/pnfs.c                                      |    5 +-
 fs/nfsd/filecache.c                                |    7 +-
 fs/nfsd/nfs4idmap.c                                |   13 +-
 fs/nfsd/nfs4recover.c                              |    8 +
 fs/nfsd/nfs4state.c                                |    5 +-
 fs/nfsd/nfs4xdr.c                                  |   10 +-
 fs/nfsd/vfs.c                                      |    1 +
 fs/nilfs2/btree.c                                  |   12 +-
 fs/ntfs3/attrlist.c                                |    4 +-
 fs/ntfs3/bitmap.c                                  |    4 +-
 fs/ntfs3/frecord.c                                 |    4 +-
 fs/ntfs3/fslog.c                                   |   19 +-
 fs/ntfs3/super.c                                   |    2 +-
 fs/ocfs2/aops.c                                    |    5 +-
 fs/ocfs2/buffer_head_io.c                          |    4 +-
 fs/ocfs2/journal.c                                 |    7 +-
 fs/ocfs2/localalloc.c                              |   19 +
 fs/ocfs2/quota_local.c                             |    8 +-
 fs/ocfs2/refcounttree.c                            |   26 +-
 fs/ocfs2/xattr.c                                   |   38 +-
 fs/proc/base.c                                     |   61 +-
 fs/super.c                                         |    3 +
 fs/unicode/mkutf8data.c                            |   70 -
 fs/unicode/utf8data.h_shipped                      | 6703 ++++++++++----------
 include/acpi/cppc_acpi.h                           |    2 +
 include/drm/drm_print.h                            |   54 +-
 include/dt-bindings/clock/qcom,gcc-sc8180x.h       |    3 +
 include/linux/acpi.h                               |    1 +
 include/linux/cgroup-defs.h                        |    7 +-
 include/linux/f2fs_fs.h                            |    2 +-
 include/linux/fdtable.h                            |    8 +-
 include/linux/fs.h                                 |    2 +
 include/linux/genhd.h                              |    3 -
 include/linux/i2c-smbus.h                          |    6 +-
 include/linux/i2c.h                                |    7 +
 include/linux/mlx5/device.h                        |    1 +
 include/linux/mlx5/fs.h                            |    8 +
 include/linux/mlx5/mlx5_ifc.h                      |  392 +-
 include/linux/nfs_fs_sb.h                          |    1 +
 include/linux/pci_ids.h                            |    2 +
 include/linux/property.h                           |    3 +
 include/linux/skbuff.h                             |    7 +-
 include/linux/usb/usbnet.h                         |   15 +
 include/linux/vdpa.h                               |    6 +
 include/linux/virtio_net.h                         |    3 +-
 include/net/flow.h                                 |    6 +-
 include/net/ip_tunnels.h                           |   16 +-
 include/net/mctp.h                                 |    2 +-
 include/net/netfilter/nf_tables.h                  |   13 +
 include/net/rtnetlink.h                            |   24 +
 include/net/sch_generic.h                          |    1 -
 include/net/sock.h                                 |    2 +
 include/net/tcp.h                                  |   21 +-
 include/trace/events/f2fs.h                        |    3 +-
 include/uapi/linux/cec.h                           |    6 +-
 include/uapi/linux/if_link.h                       |    1 +
 include/uapi/linux/netfilter/nf_tables.h           |    2 +-
 io_uring/io_uring.c                                |    5 +-
 kernel/bpf/arraymap.c                              |    3 +
 kernel/bpf/hashtab.c                               |    3 +
 kernel/bpf/helpers.c                               |    4 +-
 kernel/cgroup/cgroup-internal.h                    |    3 +-
 kernel/cgroup/cgroup.c                             |   14 +-
 kernel/events/core.c                               |    6 +-
 kernel/events/uprobes.c                            |    2 +-
 kernel/fork.c                                      |   30 +-
 kernel/kthread.c                                   |   12 +-
 kernel/locking/lockdep.c                           |   50 +-
 kernel/padata.c                                    |    6 +-
 kernel/rcu/rcuscale.c                              |    4 +-
 kernel/resource.c                                  |   58 +-
 kernel/signal.c                                    |   11 +-
 kernel/static_call_inline.c                        |   13 +-
 kernel/trace/trace.c                               |   18 +-
 kernel/trace/trace_hwlat.c                         |    2 +
 kernel/trace/trace_osnoise.c                       |    2 +
 kernel/trace/trace_output.c                        |    6 +-
 lib/buildid.c                                      |   88 +-
 lib/debugobjects.c                                 |    5 +-
 lib/xz/xz_crc32.c                                  |    2 +-
 lib/xz/xz_private.h                                |    4 -
 mm/memory.c                                        |   27 +-
 mm/slab_common.c                                   |    7 +
 mm/util.c                                          |    2 +-
 net/bluetooth/rfcomm/sock.c                        |    2 -
 net/bridge/br_netfilter_hooks.c                    |    5 +
 net/can/bcm.c                                      |    4 +-
 net/can/j1939/transport.c                          |    8 +-
 net/core/dev.c                                     |   12 +-
 net/core/rtnetlink.c                               |   35 +-
 net/core/sock_map.c                                |    1 +
 net/ipv4/devinet.c                                 |    6 +-
 net/ipv4/fib_frontend.c                            |    9 +-
 net/ipv4/fib_semantics.c                           |    2 +-
 net/ipv4/fib_trie.c                                |    7 +-
 net/ipv4/fou.c                                     |    4 +-
 net/ipv4/inet_fragment.c                           |   70 +-
 net/ipv4/ip_fragment.c                             |    2 +-
 net/ipv4/ip_gre.c                                  |   10 +-
 net/ipv4/ip_tunnel.c                               |    9 +-
 net/ipv4/netfilter/ipt_rpfilter.c                  |    3 +-
 net/ipv4/netfilter/nf_dup_ipv4.c                   |    7 +-
 net/ipv4/netfilter/nft_fib_ipv4.c                  |    5 +-
 net/ipv4/route.c                                   |    4 +-
 net/ipv4/tcp_input.c                               |   31 +-
 net/ipv4/tcp_ipv4.c                                |    3 +
 net/ipv4/xfrm4_policy.c                            |    4 +-
 net/ipv6/Kconfig                                   |    1 +
 net/ipv6/ip6_output.c                              |    3 +-
 net/ipv6/netfilter/ip6t_rpfilter.c                 |    6 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |    2 +-
 net/ipv6/netfilter/nf_dup_ipv6.c                   |    7 +-
 net/ipv6/netfilter/nf_reject_ipv6.c                |   14 +-
 net/ipv6/netfilter/nft_fib_ipv6.c                  |    8 +-
 net/ipv6/route.c                                   |   12 -
 net/ipv6/rpl_iptunnel.c                            |   12 +-
 net/ipv6/seg6_local.c                              |    1 +
 net/ipv6/xfrm6_policy.c                            |    3 +-
 net/l3mdev/l3mdev.c                                |   43 +-
 net/mac80211/iface.c                               |   17 +-
 net/mctp/af_mctp.c                                 |    6 +-
 net/mctp/device.c                                  |   32 +-
 net/mctp/neigh.c                                   |   29 +-
 net/mctp/route.c                                   |   33 +-
 net/mptcp/pm_netlink.c                             |   16 +-
 net/netfilter/nf_conntrack_netlink.c               |    7 +-
 net/netfilter/nf_tables_api.c                      |   19 +-
 net/netfilter/nft_lookup.c                         |    1 +
 net/netfilter/nft_set_pipapo.c                     |    6 +-
 net/netfilter/nft_socket.c                         |    7 +-
 net/netfilter/xt_CHECKSUM.c                        |   33 +-
 net/netfilter/xt_CLASSIFY.c                        |   16 +-
 net/netfilter/xt_CONNSECMARK.c                     |   36 +-
 net/netfilter/xt_CT.c                              |  148 +-
 net/netfilter/xt_IDLETIMER.c                       |   59 +-
 net/netfilter/xt_LED.c                             |   39 +-
 net/netfilter/xt_NFLOG.c                           |   36 +-
 net/netfilter/xt_RATEEST.c                         |   39 +-
 net/netfilter/xt_SECMARK.c                         |   27 +-
 net/netfilter/xt_TRACE.c                           |   35 +-
 net/netfilter/xt_addrtype.c                        |   15 +-
 net/netfilter/xt_cluster.c                         |   33 +-
 net/netfilter/xt_connbytes.c                       |    4 +-
 net/netfilter/xt_connlimit.c                       |   39 +-
 net/netfilter/xt_connmark.c                        |   28 +-
 net/netfilter/xt_mark.c                            |   42 +-
 net/netlink/af_netlink.c                           |    3 +-
 net/qrtr/af_qrtr.c                                 |    2 +-
 net/sched/sch_api.c                                |    7 +-
 net/sched/sch_taprio.c                             |    4 +-
 net/sctp/socket.c                                  |   20 +-
 net/socket.c                                       |    7 +-
 net/tipc/bcast.c                                   |    2 +-
 net/tipc/bearer.c                                  |    8 +-
 net/wireless/core.h                                |    8 +-
 net/wireless/nl80211.c                             |    3 +-
 net/wireless/scan.c                                |    6 +-
 net/wireless/sme.c                                 |    3 +-
 net/xfrm/xfrm_policy.c                             |    4 +-
 scripts/kconfig/merge_config.sh                    |    2 +
 scripts/kconfig/qconf.cc                           |    2 +-
 security/Kconfig                                   |   32 +
 security/bpf/hooks.c                               |    1 -
 security/selinux/hooks.c                           |    4 +-
 security/smack/smack_lsm.c                         |    4 +-
 security/smack/smackfs.c                           |    2 +-
 security/tomoyo/domain.c                           |    9 +-
 sound/core/init.c                                  |   14 +-
 sound/core/oss/mixer_oss.c                         |    4 +-
 sound/pci/asihpi/hpimsgx.c                         |    2 +-
 sound/pci/hda/hda_generic.c                        |    4 +-
 sound/pci/hda/hda_intel.c                          |    2 +-
 sound/pci/hda/patch_conexant.c                     |   24 +-
 sound/pci/hda/patch_realtek.c                      |   78 +-
 sound/pci/rme9652/hdsp.c                           |    6 +-
 sound/pci/rme9652/hdspm.c                          |    6 +-
 sound/soc/au1x/db1200.c                            |    1 +
 sound/soc/codecs/rt5682.c                          |    4 +-
 sound/soc/codecs/tda7419.c                         |    1 +
 sound/soc/fsl/imx-card.c                           |    1 +
 sound/soc/intel/keembay/kmb_platform.c             |    1 +
 sound/soc/meson/axg-card.c                         |    3 +-
 sound/usb/card.c                                   |    6 +
 sound/usb/line6/podhd.c                            |    2 +-
 sound/usb/mixer.c                                  |   35 +-
 sound/usb/mixer.h                                  |    1 +
 sound/usb/pcm.c                                    |    3 +-
 sound/usb/quirks-table.h                           |   77 +
 sound/usb/quirks.c                                 |    4 +
 tools/arch/x86/kcpuid/kcpuid.c                     |   12 +-
 tools/iio/iio_generic_buffer.c                     |    4 +
 tools/perf/builtin-inject.c                        |    1 +
 tools/perf/builtin-mem.c                           |    1 +
 tools/perf/builtin-sched.c                         |    8 +-
 tools/perf/tests/sample-parsing.c                  |   57 +-
 tools/perf/util/event.h                            |   21 +-
 tools/perf/util/evsel.c                            |  112 +-
 tools/perf/util/evsel.h                            |   10 +-
 tools/perf/util/hist.c                             |    7 +-
 .../util/scripting-engines/trace-event-python.c    |   19 +-
 tools/perf/util/session.c                          |   38 +-
 tools/perf/util/stat.c                             |    4 +-
 tools/perf/util/stat.h                             |    2 +-
 tools/perf/util/synthetic-events.c                 |   32 +-
 tools/perf/util/time-utils.c                       |    4 +-
 tools/perf/util/tool.h                             |    1 +
 tools/testing/ktest/ktest.pl                       |    2 +-
 tools/testing/selftests/bpf/bench.c                |    1 +
 .../selftests/bpf/map_tests/sk_storage_map.c       |    2 +-
 .../selftests/bpf/prog_tests/bpf_iter_setsockopt.c |    2 +-
 .../testing/selftests/bpf/prog_tests/core_reloc.c  |    1 +
 .../selftests/bpf/prog_tests/flow_dissector.c      |    1 +
 tools/testing/selftests/bpf/prog_tests/kfree_skb.c |    1 +
 .../selftests/bpf/prog_tests/sockmap_listen.c      |    3 +-
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c   |    1 +
 .../testing/selftests/bpf/progs/cg_storage_multi.h |    2 -
 tools/testing/selftests/bpf/test_cpp.cpp           |    4 +
 tools/testing/selftests/bpf/test_lru_map.c         |    3 +-
 .../breakpoints/step_after_suspend_test.c          |    5 +-
 tools/testing/selftests/net/fcnal-test.sh          |    2 +-
 tools/testing/selftests/net/net_helper.sh          |   25 +
 tools/testing/selftests/net/setup_loopback.sh      |    0
 tools/testing/selftests/net/udpgro.sh              |   13 +-
 tools/testing/selftests/net/udpgro_bench.sh        |    5 +-
 tools/testing/selftests/vDSO/parse_vdso.c          |   17 +-
 tools/testing/selftests/vDSO/vdso_config.h         |   10 +-
 .../testing/selftests/vDSO/vdso_test_correctness.c |    6 +
 .../selftests/vm/charge_reserved_hugetlb.sh        |    2 +-
 tools/testing/selftests/vm/write_to_hugetlbfs.c    |   23 +-
 656 files changed, 10222 insertions(+), 6971 deletions(-)



