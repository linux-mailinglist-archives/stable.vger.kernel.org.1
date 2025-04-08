Return-Path: <stable+bounces-131323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D4FA809EB
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA5A8C03A3
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318082698BE;
	Tue,  8 Apr 2025 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hz30NVzy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AEF1AAA32;
	Tue,  8 Apr 2025 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116086; cv=none; b=KRVbEbInrPQrkAAlKXssfAPdu/fdxqJ+eO9HAvAk6kU09gxNcV1Dmi/UsbWZJ6JeBimVG3b+VV7JJkzjUWO2eg2RIZHiWzk2Qsdt7oFzFV2VQHcdLQFKlT7PQuFEanYwQuvR8AGAYEMLthwWV6Xk7GaY4+mcYuGSUoeUZA9NMbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116086; c=relaxed/simple;
	bh=+OmzimHilNXcJYkR0LDVqNwrXOHc+uh8LUS+JpvGIog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g/DRzCBPcHT1Q1zptLF5J+mcNSvlQNWggy+29nqYEBVpCsrJ0fgw2obzPrnKV5/gDE87rbGWnsfwvvtxlBM4XQN87dwqe4XMvKHfPmGR65/qMaZcMHAxKQeWIfUTrIXjlmE8RxtbUkKkEEcNXkb7hPjLKj0IQagXgnWm1/eGU24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hz30NVzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0221C4CEE5;
	Tue,  8 Apr 2025 12:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116086;
	bh=+OmzimHilNXcJYkR0LDVqNwrXOHc+uh8LUS+JpvGIog=;
	h=From:To:Cc:Subject:Date:From;
	b=hz30NVzyj9p0UocmAczCM6V9g7tnvBgOw3V23n1r5rPzowhWIVydAcNHj67UTbRR4
	 u1UtRdGrZgMjCDB7ZJMM/z8w1Q4e71/MLert4/Cj/r4dsoxgEKtLTe/xzOJsm3ex8e
	 sQzQPGWni2kSy4RivU1mOqSbcSsgAF/p4t8sgyj4=
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
Subject: [PATCH 6.12 000/423] 6.12.23-rc1 review
Date: Tue,  8 Apr 2025 12:45:26 +0200
Message-ID: <20250408104845.675475678@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.23-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.12.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.12.23-rc1
X-KernelTest-Deadline: 2025-04-10T10:48+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.12.23 release.
There are 423 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 10 Apr 2025 10:47:53 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.23-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.12.23-rc1

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Skip sending CB_RECALL_ANY when the backchannel isn't up

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Never return NFS4ERR_FILE_OPEN when removing a directory

Chuck Lever <chuck.lever@oracle.com>
    NFSD: nfsd_unlink() clobbers non-zero status returned from fh_fill_pre_attrs()

Olga Kornievskaia <okorniev@redhat.com>
    nfsd: fix management of listener transports

Li Lingfeng <lilingfeng3@huawei.com>
    nfsd: put dl_stid if fail to queue dl_recall

Jeff Layton <jlayton@kernel.org>
    nfsd: allow SC_STATUS_FREEABLE when searching via nfs4_lookup_stateid()

Murad Masimov <m.masimov@mt-integration.ru>
    media: streamzap: fix race between device disconnection and urb callback

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    media: vimc: skip .s_stream() for stopped entities

Oleg Nesterov <oleg@redhat.com>
    exec: fix the racy usage of fs_struct->in_exec

Yosry Ahmed <yosry.ahmed@linux.dev>
    mm: zswap: fix crypto_free_acomp() deadlock in zswap_cpu_comp_dead()

Roman Smirnov <r.smirnov@omp.ru>
    jfs: add index corruption check to DT_GETPAGE()

Qasim Ijaz <qasdev00@gmail.com>
    jfs: fix slab-out-of-bounds read in ea_get()

Acs, Jakub <acsjakub@amazon.de>
    ext4: fix OOB read when checking dotdot dir

Theodore Ts'o <tytso@mit.edu>
    ext4: don't over-report free space or inodes in statvfs

Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
    wifi: mt76: mt7921: fix kernel panic due to null pointer dereference

Angelos Oikonomopoulos <angelos@igalia.com>
    arm64: Don't call NULL in do_compat_alignment_fixup()

David Hildenbrand <david@redhat.com>
    mm/gup: reject FOLL_SPLIT_PMD with hugetlb VMAs

Ran Xiaokai <ran.xiaokai@zte.com.cn>
    tracing/osnoise: Fix possible recursive locking for cpus_read_lock()

Douglas Raillard <douglas.raillard@arm.com>
    tracing: Fix synth event printk format for str fields

Douglas Raillard <douglas.raillard@arm.com>
    tracing: Ensure module defining synth event cannot be unloaded while tracing

Tengda Wu <wutengda@huaweicloud.com>
    tracing: Fix use-after-free in print_graph_function_flags during tracer switching

Sungjong Seo <sj1557.seo@samsung.com>
    exfat: fix potential wrong error return from get_block

Sungjong Seo <sj1557.seo@samsung.com>
    exfat: fix random stack corruption after get_block

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix null pointer dereference in alloc_preauth_hash()

Norbert Szetei <norbert@doyensec.com>
    ksmbd: validate zero num_subauth before sub_auth is accessed

Norbert Szetei <norbert@doyensec.com>
    ksmbd: fix overflow in dacloffset bounds check

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix session use-after-free in multichannel connection

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix use-after-free in ksmbd_sessions_deregister()

Norbert Szetei <norbert@doyensec.com>
    ksmbd: add bounds check for create lease context

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: add bounds check for durable handle context

Sean Christopherson <seanjc@google.com>
    KVM: SVM: Don't change target vCPU state on AP Creation VMGEXIT error

Ulf Hansson <ulf.hansson@linaro.org>
    mmc: sdhci-omap: Disable MMC_CAP_AGGRESSIVE_PM for eMMC/SD

Karel Balej <balejk@matfyz.cz>
    mmc: sdhci-pxav3: set NEED_RSP_BUSY capability

Miaoqian Lin <linmq006@gmail.com>
    mmc: omap: Fix memory leak in mmc_omap_new_slot

Candice Li <candice.li@amd.com>
    Remove unnecessary firmware version check for gc v9_4_2

Robin Murphy <robin.murphy@arm.com>
    media: omap3isp: Handle ARM dma_iommu_mapping

Christian Eggers <ceggers@arri.de>
    ARM: 9444/1: add KEEP() keyword to ARM_VECTORS

Paul Menzel <pmenzel@molgen.mpg.de>
    ACPI: resource: Skip IRQ override on ASUS Vivobook 14 X1404VAP

Murad Masimov <m.masimov@mt-integration.ru>
    acpi: nfit: fix narrowing conversion in acpi_nfit_ctl

Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
    wifi: mt76: mt7925: remove unused acpi function for clc

Jann Horn <jannh@google.com>
    x86/mm: Fix flush_tlb_range() when used for zapping normal PMDs

Guilherme G. Piccoli <gpiccoli@igalia.com>
    x86/tsc: Always save/restore TSC sched_clock() on suspend/resume

Arnd Bergmann <arnd@arndb.de>
    x86/Kconfig: Add cmpxchg8b support back to Geode CPUs

Joe Damato <jdamato@fastly.com>
    idpf: Don't hard code napi_struct size

Jiri Olsa <jolsa@kernel.org>
    uprobes/x86: Harden uretprobe syscall trampoline check

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel: Avoid disable PMU if !cpuc->enabled in sample read

Peter Zijlstra (Intel) <peterz@infradead.org>
    perf/x86/intel: Apply static call for drain_pebs

Markus Elfring <elfring@users.sourceforge.net>
    ntb_perf: Delete duplicate dmaengine_unmap_put() call in perf_copy_chunk()

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    platform/x86: ISST: Correct command storage data length

Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>
    platform/x86: thinkpad_acpi: disable ACPI fan access for T495* and E560

Hans de Goede <hdegoede@redhat.com>
    ACPI: x86: Extend Lenovo Yoga Tab 3 quirk with skip GPIO event-handlers

Vishal Annapurve <vannapurve@google.com>
    x86/tdx: Fix arch_safe_halt() execution for TDX VMs

Shuai Xue <xueshuai@linux.alibaba.com>
    x86/mce: use is_copy_from_user() to determine copy-from-user context

Boris Ostrovsky <boris.ostrovsky@oracle.com>
    x86/microcode/AMD: Fix __apply_microcode_amd()'s return value

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86: block KVM_CAP_SYNC_REGS if guest state is protected

Tianyu Lan <tiala@microsoft.com>
    x86/hyperv: Fix check of return value from snp_set_vmsa()

Hengqi Chen <hengqi.chen@gmail.com>
    LoongArch: BPF: Use move_addr() for BPF_PSEUDO_FUNC

Hengqi Chen <hengqi.chen@gmail.com>
    LoongArch: BPF: Don't override subprog's return value

Hengqi Chen <hengqi.chen@gmail.com>
    LoongArch: BPF: Fix off-by-one error in build_prologue()

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: Increase MAX_IO_PICS up to 8

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: Increase ARCH_DMA_MINALIGN up to 16

WANG Rui <wangrui@loongson.cn>
    rust: Fix enabling Rust and building with GCC for LoongArch

Ying Lu <luying1@xiaomi.com>
    usbnet:fix NPE during rx_complete

Alexander Wetzel <Alexander@wetzel-home.de>
    wifi: mac80211: Fix sparse warning for monitor_sdata

Sherry Sun <sherry.sun@nxp.com>
    tty: serial: lpuart: only disable CTS instead of overwriting the whole UARTMODIR register

Sherry Sun <sherry.sun@nxp.com>
    tty: serial: fsl_lpuart: use port struct directly to simply code

Sherry Sun <sherry.sun@nxp.com>
    tty: serial: fsl_lpuart: Use u32 and u8 for register variables

Abel Wu <wuyun.abel@bytedance.com>
    cgroup/rstat: Fix forceidle time in cpu.stat

Joshua Hahn <joshua.hahn6@gmail.com>
    cgroup/rstat: Tracking cgroup-level niced CPU time

Dragan Simic <dsimic@manjaro.org>
    arm64: dts: rockchip: Add missing PCIe supplies to RockPro64 board dtsi

Tengda Wu <wutengda@huaweicloud.com>
    tracing: Correct the refcount if the hist/hist_debug file fails to open

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/hist: Support POLLPRI event for poll on histogram

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/hist: Add poll(POLLIN) support on hist file

Steven Rostedt <rostedt@goodmis.org>
    tracing: Switch trace_events_hist.c code over to use guard()

Len Brown <len.brown@intel.com>
    tools/power turbostat: report CoreThr per measurement interval

Yeoreum Yun <yeoreum.yun@arm.com>
    perf/core: Fix child_total_time_enabled accounting bug at task exit

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/gfx12: fix num_mec

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/gfx11: fix num_mec

Alexandru Gagniuc <alexandru.gagniuc@hp.com>
    kbuild: deb-pkg: don't set KBUILD_BUILD_VERSION unconditionally

Dave Marquardt <davemarq@linux.ibm.com>
    net: ibmveth: make veth_pool_store stop hanging

Henry Martin <bsdhenrymartin@gmail.com>
    arcnet: Add NULL check in com20020pci_probe()

Ido Schimmel <idosch@nvidia.com>
    ipv6: Do not consider link down nexthops in path selection

Ido Schimmel <idosch@nvidia.com>
    ipv6: Start path selection from the first nexthop

Lin Ma <linma@zju.edu.cn>
    net: fix geneve_opt length integer overflow

David Oberhollenzer <david.oberhollenzer@sigma-star.at>
    net: dsa: mv88e6xxx: propperly shutdown PPU re-enable timer on destroy

Fernando Fernandez Mancera <ffmancera@riseup.net>
    ipv6: fix omitted netlink attributes when using RTEXT_FILTER_SKIP_STATS

Lin Ma <linma@zju.edu.cn>
    netfilter: nft_tunnel: fix geneve_opt type confusion addition

Antoine Tenart <atenart@kernel.org>
    net: decrease cached dst counters in dst_release

Guillaume Nault <gnault@redhat.com>
    tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu().

Stefano Garzarella <sgarzare@redhat.com>
    vsock: avoid timeout during connect() if the socket is closing

Kuniyuki Iwashima <kuniyu@amazon.com>
    udp: Fix memory accounting leak.

Kuniyuki Iwashima <kuniyu@amazon.com>
    udp: Fix multiple wraparounds of sk->sk_rmem_alloc.

Tobias Waldekranz <tobias@waldekranz.com>
    net: mvpp2: Prevent parser TCAM memory corruption

Eric Dumazet <edumazet@google.com>
    sctp: add mutual exclusion in proc_sctp_do_udp_port()

Cong Wang <xiyou.wangcong@gmail.com>
    net_sched: skbprio: Remove overly strict queue assertions

Debin Zhu <mowenroot@163.com>
    netlabel: Fix NULL pointer exception caused by CALIPSO on IPv4 sockets

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: don't unregister hook when table is dormant

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_hash: GC reaps elements with conncount for dynamic sets only

Emil Tantilov <emil.s.tantilov@intel.com>
    idpf: fix adapter NULL pointer dereference on reboot

Vitaly Lifshits <vitaly.lifshits@intel.com>
    e1000e: change k1 configuration on MTP and later platforms

Florian Fainelli <florian.fainelli@broadcom.com>
    spi: bcm2835: Restore native CS probing when pinctrl-bcm2835 is absent

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek: Fix built-in mic on another ASUS VivoBook model

Florian Fainelli <florian.fainelli@broadcom.com>
    spi: bcm2835: Do not call gpiod_put() on invalid descriptor

Henry Martin <bsdhenrymartin@gmail.com>
    ASoC: imx-card: Add NULL check in imx_card_probe()

Caleb Sander Mateos <csander@purestorage.com>
    nvme/ioctl: don't warn on vectorized uring_cmd with fixed buffer

Björn Töpel <bjorn@rivosinc.com>
    riscv/purgatory: 4B align purgatory_start

Yao Zi <ziyao@disroot.org>
    riscv/kexec_file: Handle R_RISCV_64 in purgatory relocator

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Fix hugetlb retrieval of number of ptes in case of !present pte

Josh Poimboeuf <jpoimboe@kernel.org>
    spi: cadence: Fix out-of-bounds array access in cdns_mrvl_xspi_setup_clock()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    ASoC: codecs: rt5665: Fix some error handling paths in rt5665_probe()

Sven Schnelle <svens@linux.ibm.com>
    s390/entry: Fix setting _CIF_MCCK_GUEST with lowcore relocation

Ming Lei <ming.lei@redhat.com>
    ublk: make sure ubq->canceling is set when queue is frozen

Herton R. Krzesinski <herton@redhat.com>
    x86/uaccess: Improve performance by aligning writes to 8 bytes in copy_user_generic(), on non-FSRM/ERMS CPUs

Palmer Dabbelt <palmer@rivosinc.com>
    RISC-V: errata: Use medany for relocatable builds

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek: Fix built-in mic breakage on ASUS VivoBook X515JA

Richard Fitzgerald <rf@opensource.cirrus.com>
    firmware: cs_dsp: Ensure cs_dsp_load[_coeff]() returns 0 on success

Nikita Shubin <n.shubin@yadro.com>
    ntb: intel: Fix using link status DB's

Yajun Deng <yajun.deng@linux.dev>
    ntb_hw_switchtec: Fix shift-out-of-bounds in switchtec_ntb_mw_set_trans

Juhan Jin <juhan.jin@foxmail.com>
    riscv: ftrace: Add parentheses in macro definitions of make_call_t0 and make_call_ra

Christian Schoenebeck <linux_oss@crudebyte.com>
    fs/9p: fix NULL pointer dereference on mkdir

Al Viro <viro@zeniv.linux.org.uk>
    spufs: fix a leak in spufs_create_context()

Al Viro <viro@zeniv.linux.org.uk>
    spufs: fix gang directory lifetimes

Al Viro <viro@zeniv.linux.org.uk>
    spufs: fix a leak on spufs_new_file() failure

David Howells <dhowells@redhat.com>
    netfs: Fix netfs_unbuffered_read() to return ssize_t rather than int

Tasos Sahanidis <tasos@tasossah.com>
    hwmon: (nct6775-core) Fix out of bounds access for NCT679{8,9}

Roger Quadros <rogerq@kernel.org>
    memory: omap-gpmc: drop no compatible check

Oliver Hartkopp <socketcan@hartkopp.net>
    can: statistics: use atomic access in hot path

Navon John Lukose <navonjohnlukose@gmail.com>
    ALSA: hda/realtek: Add mute LED quirk for HP Pavilion x360 14-dy1xxx

Florian Westphal <fw@strlen.de>
    selftests: netfilter: skip br_netfilter queue tests if kernel is tainted

Taehee Yoo <ap420073@gmail.com>
    net: devmem: do not WARN conditionally after netdev_rx_queue_restart()

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Keep display off while going into S4

Keith Busch <kbusch@kernel.org>
    nvme-pci: fix stuck reset on concurrent DPC and HP

Vladis Dronov <vdronov@redhat.com>
    x86/sgx: Warn explicitly if X86_FEATURE_SGX_LC is not enabled

Michael Kelley <mhklinux@outlook.com>
    x86/hyperv: Fix output argument to hypercall that changes page visibility

Waiman Long <longman@redhat.com>
    locking/semaphore: Use wake_q to wake up processes outside lock critical section

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: fix SA Query processing in MLO

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    wifi: mac80211: flush the station before moving it to UN-AUTHORIZED state

Bard Liao <yung-chuan.liao@linux.intel.com>
    ASoC: rt1320: set wake_capable = 0 explicitly

Alexey Klimov <alexey.klimov@linaro.org>
    ASoC: codecs: wsa884x: report temps to hwmon in millidegree of Celsius

Naman Jain <namjain@linux.microsoft.com>
    x86/hyperv/vtl: Stop kernel from probing VTL0 low memory

Shrikanth Hegde <sshegde@linux.ibm.com>
    sched/deadline: Use online cpus for validating runtime

Stefan Binding <sbinding@opensource.cirrus.com>
    ALSA: hda/realtek: Add support for ASUS Zenbook UM3406KA Laptops using CS35L41 HDA

Stefan Binding <sbinding@opensource.cirrus.com>
    ALSA: hda/realtek: Add support for ASUS B5405 and B5605 Laptops using CS35L41 HDA

Stefan Binding <sbinding@opensource.cirrus.com>
    ALSA: hda/realtek: Add support for ASUS B3405 and B3605 Laptops using CS35L41 HDA

Stefan Binding <sbinding@opensource.cirrus.com>
    ALSA: hda/realtek: Add support for various ASUS Laptops using CS35L41 HDA

Stefan Binding <sbinding@opensource.cirrus.com>
    ALSA: hda/realtek: Add support for ASUS ROG Strix G614 Laptops using CS35L41 HDA

Stefan Binding <sbinding@opensource.cirrus.com>
    ALSA: hda/realtek: Add support for ASUS ROG Strix GA603 Laptops using CS35L41 HDA

Stefan Binding <sbinding@opensource.cirrus.com>
    ALSA: hda/realtek: Add support for ASUS ROG Strix G814 Laptop using CS35L41 HDA

Yuezhang Mo <Yuezhang.Mo@sony.com>
    exfat: add a check for invalid data size

Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
    platform/x86/amd/pmf: Update PMF Driver for Compatibility with new PMF-TA

Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
    platform/x86/amd/pmf: Propagate PMF-TA return codes

Wentao Guan <guanwentao@uniontech.com>
    HID: i2c-hid: improve i2c_hid_get_report error message

Jakub Kicinski <kuba@kernel.org>
    net: dsa: rtl8366rb: don't prompt users for LED control

David E. Box <david.e.box@linux.intel.com>
    platform/x86/intel/vsec: Add Diamond Rapids support

Dmitry Panchenko <dmitry@d-systems.ee>
    platform/x86: intel-hid: fix volume buttons on Microsoft Surface Go 4 tablet

Namjae Jeon <linkinjeon@kernel.org>
    cifs: fix incorrect validation for num_aces field of smb_acl

Namjae Jeon <linkinjeon@kernel.org>
    smb: common: change the data type of num_aces to le16

Peter Zijlstra <peterz@infradead.org>
    perf/core: Fix perf_pmu_register() vs. perf_init_event()

Daniel Bárta <daniel.barta@trustlab.cz>
    ALSA: hda: Fix speakers on ASUS EXPERTBOOK P5405CSA 1.0

Antheas Kapenekakis <lkml@antheas.dev>
    ALSA: hda/realtek: Fix Asus Z13 2025 audio

Simon Tatham <anakin@pobox.com>
    affs: don't write overlarge OFS data block size fields

Simon Tatham <anakin@pobox.com>
    affs: generate OFS sequence numbers starting at 1

Matthias Proske <email@matthias-proske.de>
    wifi: brcmfmac: keep power during suspend if board requires it

Icenowy Zheng <uwu@icenowy.me>
    nvme-pci: skip CMB blocks incompatible with PCI P2P DMA

Icenowy Zheng <uwu@icenowy.me>
    nvme-pci: clean up CMBMSC when registering CMB fails

Sagi Grimberg <sagi@grimberg.me>
    nvme-tcp: fix possible UAF in nvme_tcp_poll

Mike Lothian <mike@fireburn.co.uk>
    ntsync: Set the permissions to be 0666

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    wifi: iwlwifi: mvm: use the right version of the rate API

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: fw: allocate chained SG tables for dump

Alexander Wetzel <Alexander@wetzel-home.de>
    wifi: mac80211: remove debugfs dir for virtual monitor

Alexander Wetzel <Alexander@wetzel-home.de>
    wifi: mac80211: Cleanup sta TXQs on flush

Dan Carpenter <dan.carpenter@linaro.org>
    nfs: Add missing release on error in nfs_lock_and_join_requests()

Josh Poimboeuf <jpoimboe@kernel.org>
    objtool/loongarch: Add unwind hints in prepare_frametrace()

Josh Poimboeuf <jpoimboe@kernel.org>
    rcu-tasks: Always inline rcu_irq_work_resched()

Josh Poimboeuf <jpoimboe@kernel.org>
    context_tracking: Always inline ct_{nmi,irq}_{enter,exit}()

Josh Poimboeuf <jpoimboe@kernel.org>
    sched/smt: Always inline sched_smt_active()

David Laight <david.laight.linux@gmail.com>
    objtool: Fix verbose disassembly if CROSS_COMPILE isn't set

Geetha sowjanya <gakula@marvell.com>
    octeontx2-af: Free NIX_AF_INT_VEC_GEN irq

Geetha sowjanya <gakula@marvell.com>
    octeontx2-af: Fix mbox INTR handler when num VFs > 64

Jim Liu <jim.t90615@gmail.com>
    net: phy: broadcom: Correct BCM5221 PHY model detection

Giovanni Gherdovich <ggherdovich@suse.cz>
    ACPI: processor: idle: Return an error if both P_LVL{2,3} idle states are invalid

Yuli Wang <wangyuli@uniontech.com>
    LoongArch: Rework the arch_kgdb_breakpoint() implementation

Miaoqian Lin <linmq006@gmail.com>
    LoongArch: Fix device node refcount leak in fdt_cpu_clk_init()

谢致邦 (XIE Zhibang) <Yeking@Red54.com>
    LoongArch: Fix help text of CMDLINE_EXTEND in Kconfig

Josh Poimboeuf <jpoimboe@kernel.org>
    objtool: Fix segfault in ignore_unreachable_insn()

Feng Yang <yangfeng@kylinos.cn>
    ring-buffer: Fix bytes_dropped calculation issue

Lama Kayal <lkayal@nvidia.com>
    net/mlx5e: SHAMPO, Make reserved size independent of page size

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix r_count dec/increment mismatch

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix multichannel connection failure

Miaoqian Lin <linmq006@gmail.com>
    ksmbd: use aead_request_free to match aead_request_alloc

Lubomir Rintel <lkundrak@v3.sk>
    rndis_host: Flag RNDIS modems as WWAN devices

Mark Zhang <markzhang@nvidia.com>
    rtnetlink: Allocate vfinfo size for VF GUIDs when supported

Yuezhang Mo <Yuezhang.Mo@sony.com>
    exfat: fix missing shutdown check

Yuezhang Mo <Yuezhang.Mo@sony.com>
    exfat: fix the infinite loop in exfat_find_last_cluster()

Wang Zhaolong <wangzhaolong1@huawei.com>
    smb: client: Fix netns refcount imbalance causing leaks and use-after-free

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS: Shut down the nfs_client only after all the superblocks

Josh Poimboeuf <jpoimboe@kernel.org>
    objtool, media: dib8000: Prevent divide-by-zero in dib8000_set_dds()

Josh Poimboeuf <jpoimboe@kernel.org>
    objtool, nvmet: Fix out-of-bounds stack access in nvmet_ctrl_state_show()

xueqin Luo <luoxueqin@kylinos.cn>
    thermal: core: Remove duplicate struct declaration

Namhyung Kim <namhyung@kernel.org>
    perf bpf-filter: Fix a parsing error with comma

Marcus Meissner <meissner@suse.de>
    perf tools: annotate asm_pure_loop.S

Bart Van Assche <bvanassche@acm.org>
    fs/procfs: fix the comment above proc_pid_wchan()

Ilkka Koskinen <ilkka@os.amperecomputing.com>
    perf vendor events arm64 AmpereOneX: Fix frontend_bound calculation

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    tty: n_tty: use uint for space returned by tty_write_room()

Stefan Wahren <wahrenst@gmx.net>
    staging: vchiq_arm: Fix possible NPR of keep-alive thread

Stefan Wahren <wahrenst@gmx.net>
    staging: vchiq_arm: Register debugfs after cdev

谢致邦 (XIE Zhibang) <Yeking@Red54.com>
    staging: rtl8723bs: select CONFIG_CRYPTO_LIB_AES

James Clark <james.clark@linaro.org>
    perf: intel-tpebs: Fix incorrect usage of zfree()

Stephen Brennan <stephen.s.brennan@oracle.com>
    perf dso: fix dso__is_kallsyms() check

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf python: Check if there is space to copy all the event

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf python: Don't keep a raw_data pointer to consumed ring buffer space

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf python: Decrement the refcount of just created event on failure

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf python: Fixup description of sample.id event member

Stanley Chu <yschu@nuvoton.com>
    i3c: master: svc: Fix missing the IBI rules

Benjamin Berg <benjamin.berg@intel.com>
    um: hostfs: avoid issues on inode number reuse by host

Benjamin Berg <benjamin.berg@intel.com>
    um: remove copy_from_kernel_nofault_allowed

David Gow <davidgow@google.com>
    um: Pass the correct Rust target and options with gcc

Cyan Yang <cyan.yang@sifive.com>
    selftests/mm/cow: fix the incorrect error handling

Alistair Popple <apopple@nvidia.com>
    fuse: fix dax truncate/punch_hole fault path

NeilBrown <neilb@suse.de>
    NFS: fix open_owner_id_maxsz and related fields.

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4: Avoid unnecessary scans of filesystems for delayed delegations

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4: Avoid unnecessary scans of filesystems for expired delegations

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4: Avoid unnecessary scans of filesystems for returning delegations

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4: Don't trigger uneccessary scans for return-on-close delegations

Anshuman Khandual <anshuman.khandual@arm.com>
    arch/powerpc: drop GENERIC_PTDUMP from mpc885_ads_defconfig

Vasiliy Kovalev <kovalev@altlinux.org>
    ocfs2: validate l_tree_depth to avoid out-of-bounds access

Sourabh Jain <sourabhjain@linux.ibm.com>
    kexec: initialize ELF lowest address to ULONG_MAX

David Hildenbrand <david@redhat.com>
    kernel/events/uprobes: handle device-exclusive entries correctly in __replace_page()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf units: Fix insufficient array space

Ian Rogers <irogers@google.com>
    perf evlist: Add success path to evlist__create_syswide_maps

Ian Rogers <irogers@google.com>
    perf debug: Avoid stack overflow in recursive error message

Karan Sanghavi <karansanghvi98@gmail.com>
    iio: light: Add check for array bounds in veml6075_read_int_time_ms

Jonathan Santos <Jonathan.Santos@analog.com>
    iio: adc: ad7768-1: set MOSI idle state to prevent accidental reset

Uwe Kleine-König <u.kleine-koenig@baylibre.com>
    iio: adc: ad7173: Fix comparison of channel configs

Uwe Kleine-König <u.kleine-koenig@baylibre.com>
    iio: adc: ad7124: Fix comparison of channel configs

Uwe Kleine-König <u.kleine-koenig@baylibre.com>
    iio: adc: ad4130: Fix comparison of channel setups

Peng Fan <peng.fan@nxp.com>
    dmaengine: fsl-edma: free irq correctly in remove path

Peng Fan <peng.fan@nxp.com>
    dmaengine: fsl-edma: cleanup chan after dma_async_device_unregister

Dan Carpenter <dan.carpenter@linaro.org>
    fs/ntfs3: Prevent integer overflow in hdr_first_de()

Dan Carpenter <dan.carpenter@linaro.org>
    fs/ntfs3: Fix a couple integer overflows on 32bit systems

Niklas Neronin <niklas.neronin@linux.intel.com>
    usb: xhci: correct debug message page size calculation

Thomas Richter <tmricht@linux.ibm.com>
    perf bench: Fix perf bench syscall loop count

Leo Yan <leo.yan@arm.com>
    perf arm-spe: Fix load-store operation checking

Nuno Sá <nuno.sa@analog.com>
    iio: backend: make sure to NULL terminate stack buffer

Jonathan Cameron <Jonathan.Cameron@huawei.com>
    iio: accel: msa311: Fix failure to release runtime pm if direct mode claim fails.

Jonathan Cameron <Jonathan.Cameron@huawei.com>
    iio: accel: mma8452: Ensure error return on failure to matching oversampling ratio

Mario Limonciello <mario.limonciello@amd.com>
    ucsi_ccg: Don't show failed to get FW build information error

Luca Ceresoli <luca.ceresoli@bootlin.com>
    perf build: Fix in-tree build due to symbolic link

Ian Rogers <irogers@google.com>
    tools/x86: Fix linux/unaligned.h include path in lib/insn.c

James Clark <james.clark@linaro.org>
    perf pmu: Don't double count common sysfs and json events

Yuanfang Zhang <quic_yuanfang@quicinc.com>
    coresight-etm4x: add isb() before reading the TRCSTATR

Mike Christie <michael.christie@oracle.com>
    vhost-scsi: Fix handling of multiple calls to vhost_scsi_set_endpoint

Ilkka Koskinen <ilkka@os.amperecomputing.com>
    coresight: catu: Fix number of pages while using 64k pages

Wentao Liang <vulab@iscas.ac.cn>
    greybus: gb-beagleplay: Add error handling for gb_greybus_init

Namhyung Kim <namhyung@kernel.org>
    perf report: Switch data file correctly in TUI

Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
    soundwire: slave: fix an OF node reference leak in soundwire slave device

Qasim Ijaz <qasdev00@gmail.com>
    isofs: fix KMSAN uninit-value bug in do_isofs_readdir()

Heiko Stuebner <heiko.stuebner@cherry.de>
    phy: phy-rockchip-samsung-hdptx: Don't use dt aliases to determine phy-id

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Update inode->i_mapping->a_ops on compression state

Chenyuan Yang <chenyuan0y@gmail.com>
    w1: fix NULL pointer dereference in probe

James Clark <james.clark@linaro.org>
    perf: Always feature test reallocarray

Ian Rogers <irogers@google.com>
    perf stat: Fix find_stat for mixed legacy/non-legacy events

Barnabás Czémán <barnabas.czeman@mainlining.org>
    clk: qcom: mmcc-sdm660: fix stuck video_subcore0 clock

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    pinctrl: intel: Fix wrong bypass assignment in intel_pinctrl_probe_pwm()

Wenkai Lin <linwenkai6@hisilicon.com>
    crypto: hisilicon/sec2 - fix for aead auth key length

Wang Liang <wangliang74@huawei.com>
    RDMA/core: Fix use-after-free when rename device name

Jann Horn <jannh@google.com>
    x86/dumpstack: Fix inaccurate unwinding from exception stacks due to misplaced assignment

Remi Pommarel <repk@triplefau.lt>
    leds: Fix LED_OFF brightness race

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    mfd: sm501: Switch to BIT() to mitigate integer overflows

Fabrizio Castro <fabrizio.castro.jz@renesas.com>
    pinctrl: renesas: rzv2m: Fix missing of_node_put() call

Patrisious Haddad <phaddad@nvidia.com>
    RDMA/mlx5: Fix mlx5_poll_one() cur_qp update flow

Jiayuan Chen <mrpre@163.com>
    bpf: Fix array bounds error with may_goto

Neil Armstrong <neil.armstrong@linaro.org>
    clk: qcom: gcc-sm8650: Do not turn off USB GDSCs during gdsc_disable()

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: nx - Fix uninitialised hv_nxc on error

Artur Weber <aweber.kernel@gmail.com>
    power: supply: max77693: Fix wrong conversion of charge input threshold value

Jann Horn <jannh@google.com>
    x86/entry: Fix ORC unwinder for PUSH_REGS with save_ret=1

Jerome Brunet <jbrunet@baylibre.com>
    clk: amlogic: g12a: fix mmc A peripheral clock

Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
    clk: clk-imx8mp-audiomix: fix dsp/ocram_a clock parents

Bairavi Alagappan <bairavix.alagappan@intel.com>
    crypto: qat - remove access to parity register for QAT GEN4

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    pinctrl: npcm8xx: Fix incorrect struct npcm8xx_pincfg assignment

Alice Ryhl <aliceryhl@google.com>
    rust: fix signature of rust_fmt_argument

Saket Kumar Bhaskar <skb99@linux.ibm.com>
    selftests/bpf: Select NUMA_NO_NODE to create map

Jerome Brunet <jbrunet@baylibre.com>
    clk: amlogic: gxbb: drop non existing 32k clock parent

Jerome Brunet <jbrunet@baylibre.com>
    clk: amlogic: g12b: fix cluster A parent data

Prathamesh Shete <pshete@nvidia.com>
    pinctrl: tegra: Set SFIO mode to Mux Register

Maher Sanalla <msanalla@nvidia.com>
    IB/mad: Check available slots before posting receive WRs

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: api - Fix larval relookup type and mask

Sicelo A. Mhlongo <absicsz@gmail.com>
    power: supply: bq27xxx_battery: do not update cached flags prematurely

Luca Weiss <luca@lucaweiss.eu>
    remoteproc: qcom_q6v5_mss: Handle platforms with one power domain

Cheng Xu <chengyou@linux.alibaba.com>
    RDMA/erdma: Prevent use-after-free in erdma_accept_newconn()

Chiara Meiohas <cmeiohas@nvidia.com>
    RDMA/mlx5: Fix calculation of total invalidated pages

Roman Gushchin <roman.gushchin@linux.dev>
    RDMA/core: Don't expose hw_counters outside of init net namespace

Peter Geis <pgwipeout@gmail.com>
    clk: rockchip: rk3328: fix wrong clk_ref_usb3otg parent

Tengda Wu <wutengda@huaweicloud.com>
    selftests/bpf: Fix freplace_link segfault in tailcalls prog test

Michael Guralnik <michaelgur@nvidia.com>
    RDMA/mlx5: Fix MR cache initialization error flow

Fabrizio Castro <fabrizio.castro.jz@renesas.com>
    pinctrl: renesas: rzg2l: Fix missing of_node_put() call

Fabrizio Castro <fabrizio.castro.jz@renesas.com>
    pinctrl: renesas: rza2: Fix missing of_node_put() call

Tanya Agarwal <tanyaagarwal25699@gmail.com>
    lib: 842: Improve error handling in sw842_compress()

Hou Tao <houtao1@huawei.com>
    bpf: Use preempt_count() directly in bpf_send_signal_common()

Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
    clk: qcom: gcc-x1e80100: Unregister GCC_GPU_CFG_AHB_CLK/GCC_DISP_XO_CLK

Luca Weiss <luca@lucaweiss.eu>
    remoteproc: qcom_q6v5_pas: Use resource with CX PD for MSM8226

Akhil R <akhilrajeev@nvidia.com>
    crypto: tegra - Set IV to NULL explicitly for AES ECB

Kees Bakker <kees@ijzerbout.nl>
    RDMA/mana_ib: Ensure variable err is initialized

Niklas Schnelle <schnelle@linux.ibm.com>
    s390: Remove ioremap_wt() and pgprot_writethrough()

Vladimir Lypak <vladimir.lypak@gmail.com>
    clk: qcom: gcc-msm8953: fix stuck venus0_core0 clock

Akhil R <akhilrajeev@nvidia.com>
    crypto: tegra - Fix CMAC intermediate result handling

Yue Haibing <yuehaibing@huawei.com>
    pinctrl: nuvoton: npcm8xx: Fix error handling in npcm8xx_gpio_fw()

Will McVicker <willmcvicker@google.com>
    clk: samsung: Fix UBSAN panic in samsung_clk_init()

Luca Weiss <luca.weiss@fairphone.com>
    remoteproc: qcom: pas: add minidump_id to SC7280 WPSS

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    clk: renesas: r8a08g045: Check the source of the CPU PLL settings

David Hildenbrand <david@redhat.com>
    x86/mm/pat: Fix VM_PAT handling when fork() fails in copy_page_range()

Viktor Malik <vmalik@redhat.com>
    selftests/bpf: Fix string read in strncmp benchmark

Andrii Nakryiko <andrii@kernel.org>
    libbpf: Fix hypothetical STT_SECTION extern NULL deref case

Luca Weiss <luca@lucaweiss.eu>
    remoteproc: qcom_q6v5_pas: Make single-PD handling more robust

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    pinctrl: renesas: rzg2l: Suppress binding attributes

Zijun Hu <quic_zijuhu@quicinc.com>
    of: property: Increase NR_FWNODE_REFERENCE_ARGS

Peng Fan <peng.fan@nxp.com>
    remoteproc: core: Clear table_sz when rproc_shutdown

Michael Guralnik <michaelgur@nvidia.com>
    RDMA/mlx5: Fix page_size variable overflow

Wenkai Lin <linwenkai6@hisilicon.com>
    crypto: hisilicon/sec2 - fix for sec spec check

Wenkai Lin <linwenkai6@hisilicon.com>
    crypto: hisilicon/sec2 - fix for aead authsize alignment

Jerome Brunet <jbrunet@baylibre.com>
    clk: amlogic: gxbb: drop incorrect flag on 32k clock

Akhil R <akhilrajeev@nvidia.com>
    crypto: tegra - Use HMAC fallback when keyslots are full

Arnd Bergmann <arnd@arndb.de>
    crypto: bpf - Add MODULE_DESCRIPTION for skcipher

Akhil R <akhilrajeev@nvidia.com>
    crypto: tegra - check return value for hash do_one_req

Akhil R <akhilrajeev@nvidia.com>
    crypto: tegra - Use separate buffer for setkey

Bairavi Alagappan <bairavix.alagappan@intel.com>
    crypto: qat - set parity error mask for qat_420xx

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: iaa - Test the correct request flag

Danila Chernetsov <listdansp@mail.ru>
    fbdev: sm501fb: Add some geometry checks.

Arnd Bergmann <arnd@arndb.de>
    mdacon: rework dependency list

Arnd Bergmann <arnd@arndb.de>
    dummycon: fix default rows/cols

Markus Elfring <elfring@users.sourceforge.net>
    fbdev: au1100fb: Move a variable assignment behind a null pointer check

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: pciehp: Don't enable HPIE when resuming in poll mode

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: Fix BAR resizing when VF BARs are assigned

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    PCI: histb: Fix an error handling path in histb_pcie_probe()

Dan Carpenter <dan.carpenter@linaro.org>
    PCI: dwc: ep: Return -ENOMEM for allocation failures

Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
    drm/amd/display: avoid NPD when ASIC does not support DMUB

Dan Carpenter <dan.carpenter@linaro.org>
    drm/mediatek: dsi: fix error codes in mtk_dsi_host_transfer()

Douglas Anderson <dianders@chromium.org>
    drm/mediatek: dp: drm_err => dev_err in HPD path to avoid NULL ptr

Jason-JH Lin <jason-jh.lin@mediatek.com>
    drm/mediatek: Fix config_updating flag never false when no mbox channel

Thippeswamy Havalige <thippeswamy.havalige@amd.com>
    PCI: xilinx-cpm: Fix IRQ domain leak in error path of probe

Dan Carpenter <dan.carpenter@linaro.org>
    PCI: Remove stray put_device() in pci_register_host_bridge()

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/kexec: fix physical address calculation in clear_utlb_entry()

Christophe Leroy <christophe.leroy@csgroup.eu>
    crypto: powerpc: Mark ghashp8-ppc.o as an OBJECT_FILES_NON_STANDARD

Rob Clark <robdclark@chromium.org>
    drm/msm/a6xx: Fix a6xx indexed-regs in devcoreduump

Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
    drm/amd/display: fix type mismatch in CalculateDynamicMetadataParameters()

Ashley Smith <ashley.smith@collabora.com>
    drm/panthor: Update CS_STATUS_ defines to correct values

Nishanth Aravamudan <naravamudan@nvidia.com>
    PCI: Avoid reset when disabled via sysfs

Feng Tang <feng.tang@linux.alibaba.com>
    PCI/portdrv: Only disable pciehp interrupts early when needed

Jim Quinlan <james.quinlan@broadcom.com>
    PCI: brcmstb: Fix potential premature regulator disabling

Jim Quinlan <james.quinlan@broadcom.com>
    PCI: brcmstb: Fix error path after a call to regulator_bulk_get()

Jim Quinlan <james.quinlan@broadcom.com>
    PCI: brcmstb: Use internal register to change link capability

Jim Quinlan <james.quinlan@broadcom.com>
    PCI: brcmstb: Set generation limit before PCIe link up

Hans Zhang <18255117159@163.com>
    PCI: cadence-ep: Fix the driver to send MSG TLP for INTx without data payload

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdkfd: Fix Circular Locking Dependency in 'svm_range_cpu_invalidate_pagetables'

Marijn Suijten <marijn.suijten@somainline.org>
    drm/msm/dsi: Set PHY usescase (and mode) before registering DSI host

Marijn Suijten <marijn.suijten@somainline.org>
    drm/msm/dsi: Use existing per-interface slice count in DSC timing

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    drm/msm/dsi/phy: Program clock inverters in correct register

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: don't use active in atomic_check()

Aurabindo Pillai <aurabindo.pillai@amd.com>
    drm/amd/display: fix an indent issue in DML21

Tushar Dave <tdave@nvidia.com>
    PCI/ACS: Fix 'pci=config_acs=' parameter

John Keeping <jkeeping@inmusicbrands.com>
    drm/panel: ilitek-ili9882t: fix GPIO name in error message

Daniel Stodden <daniel.stodden@gmail.com>
    PCI/ASPM: Fix link state exit during switch upstream function removal

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    drm/mediatek: mtk_hdmi: Fix typo for aud_sampe_size member

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    drm/mediatek: mtk_hdmi: Unregister audio platform device on failure

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: Remove add_align overwrite unrelated to size0

Kai-Heng Feng <kaihengf@nvidia.com>
    PCI: Use downstream bridges for distributing resources

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/umsch: fix ucode check

Yang Wang <kevinyang.wang@amd.com>
    drm/amdgpu: refine smu send msg debug log format

Vitalii Mordan <mordan@ispras.ru>
    gpu: cdns-mhdp8546: fix call balance of mhdp->clk handling routines

José Expósito <jose.exposito89@gmail.com>
    drm/vkms: Fix use after free and double free on init error

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm: xlnx: zynqmp: Fix max dma segment size

Hermes Wu <Hermes.wu@ite.com.tw>
    drm/bridge: it6505: fix HDCP V match check is not performed correctly

Wayne Lin <Wayne.Lin@amd.com>
    drm/dp_mst: Fix drm RAD print

John Keeping <jkeeping@inmusicbrands.com>
    drm/ssd130x: ensure ssd132x pitch is correct

John Keeping <jkeeping@inmusicbrands.com>
    drm/ssd130x: fix ssd132x encoding

Javier Martinez Canillas <javierm@redhat.com>
    drm/ssd130x: Set SPI .id_table to prevent an SPI core warning

Geert Uytterhoeven <geert+renesas@glider.be>
    drm/bridge: ti-sn65dsi86: Fix multiple instances

Takashi Iwai <tiwai@suse.de>
    ALSA: timer: Don't take register_mutex with copy_from/to_user()

Jayesh Choudhary <j-choudhary@ti.com>
    ASoC: ti: j721e-evm: Fix clock configuration for ti,j7200-cpb-audio compatible

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek: Always honor no_shutup_pins

Maud Spierings <maudspierings@gocontroll.com>
    dt-bindings: vendor-prefixes: add GOcontroll

Jiri Kosina <jikos@kernel.org>
    HID: remove superfluous (and wrong) Makefile entry for CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER

Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
    ASoC: amd: acp: Fix for enabling DMIC on acp platforms via _DSD entry

Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
    ASoC: cs35l41: check the return value from spi_setup()

Armin Wolf <W_Armin@gmx.de>
    platform/x86: dell-ddv: Fix temperature calculation

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    platform/x86: dell-uart-backlight: Make dell_uart_bl_serdev_driver static

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: Make symbol static

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    auxdisplay: panel: Fix an API misuse in panel.c

Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
    media: platform: allgro-dvt: unregister v4l2_device on the error path

Benjamin Gaignard <benjamin.gaignard@collabora.com>
    media: verisilicon: HEVC: Initialize start_bit field

Geert Uytterhoeven <geert@linux-m68k.org>
    auxdisplay: MAX6959 should select BITREVERSE

Frieder Schrempf <frieder.schrempf@kontron.de>
    regulator: pca9450: Fix enable register for LDO5

Vitaly Kuznetsov <vkuznets@redhat.com>
    x86/entry: Add __init to ia32_emulation_override_cmdline()

Chao Gao <chao.gao@intel.com>
    x86/fpu/xstate: Fix inconsistencies in guest FPU xfeatures

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/traps: Make exc_double_fault() consistently noreturn

Tao Chen <chen.dylane@linux.dev>
    perf/ring_buffer: Allow the EPOLLRDNORM flag for poll

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    lockdep: Don't disable interrupts on RT in disable_irq_nosync_lockdep.*()

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PM: sleep: Fix handling devices with direct_complete set on errors

Chenyuan Yang <chenyuan0y@gmail.com>
    thermal: int340x: Add NULL check for adev

James Morse <james.morse@arm.com>
    x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no monitors

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    EDAC/ie31200: Fix the error path order of ie31200_init()

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    EDAC/ie31200: Fix the DIMM size mask for several SoCs

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    EDAC/ie31200: Fix the size of EDAC_MC_LAYER_CHIP_SELECT layer

Tim Schumacher <tim.schumacher1@huawei.com>
    selinux: Chain up tool resolving errors in install_policy.sh

Li Huafei <lihuafei1@huawei.com>
    watchdog/hardlockup/perf: Fix perf_event memory leak

Kees Cook <kees@kernel.org>
    kunit/stackinit: Use fill byte different from Clang i386 pattern

Atish Patra <atishp@rivosinc.com>
    RISC-V: KVM: Disable the kernel perf counter during configure

Aaron Kling <webgeek1234@gmail.com>
    cpufreq: tegra194: Allow building for Tegra234

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PM: sleep: Adjust check before setting power.must_resume

Peter Zijlstra <peterz@infradead.org>
    lockdep/mm: Fix might_fault() lockdep check of current->mm->mmap_lock

Kevin Loughlin <kevinloughlin@google.com>
    x86/sev: Add missing RIP_REL_REF() invocations during sme_enable()

Arnd Bergmann <arnd@arndb.de>
    x86/platform: Only allow CONFIG_EISA for 32-bit

Benjamin Berg <benjamin.berg@intel.com>
    x86/fpu: Avoid copying dynamic FP state from init_task in arch_dup_task_struct()

Stanislav Spassov <stanspas@amazon.de>
    x86/fpu: Fix guest FPU state buffer allocation size

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    EDAC/{skx_common,i10nm}: Fix some missing error reports on Emerald Rapids

Jie Zhan <zhanjie9@hisilicon.com>
    cpufreq: governor: Fix negative 'idle_time' handling in dbs_update()

Tianchen Ding <dtcccc@linux.alibaba.com>
    sched/eevdf: Force propagating min_slice of cfs_rq when {en,de}queue tasks

zihan zhou <15645113830zzh@gmail.com>
    sched: Cancel the slice protection of the idle entity

Konstantin Andreev <andreev@swemel.ru>
    smack: ipv4/ipv6: tcp/dccp/sctp: fix incorrect child socket label

Konstantin Andreev <andreev@swemel.ru>
    smack: dont compile ipv6 code unless ipv6 is configured

zuoqian <zuoqian113@gmail.com>
    cpufreq: scpi: compare kHz instead of Hz

Mike Rapoport (Microsoft) <rppt@kernel.org>
    x86/mm/pat: cpa-test: fix length for CPA_ARRAY test

Eric Sandeen <sandeen@redhat.com>
    watch_queue: fix pipe accounting mismatch


-------------

Diffstat:

 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 Makefile                                           |   4 +-
 arch/arm/include/asm/vmlinux.lds.h                 |   6 +-
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi |   2 +
 arch/arm64/kernel/compat_alignment.c               |   2 +
 arch/loongarch/Kconfig                             |   4 +-
 arch/loongarch/include/asm/cache.h                 |   2 +
 arch/loongarch/include/asm/irq.h                   |   2 +-
 arch/loongarch/include/asm/stacktrace.h            |   3 +
 arch/loongarch/include/asm/unwind_hints.h          |  10 +-
 arch/loongarch/kernel/env.c                        |   2 +
 arch/loongarch/kernel/kgdb.c                       |   5 +-
 arch/loongarch/net/bpf_jit.c                       |  12 +-
 arch/loongarch/net/bpf_jit.h                       |   5 +
 arch/powerpc/configs/mpc885_ads_defconfig          |   2 +-
 arch/powerpc/crypto/Makefile                       |   1 +
 arch/powerpc/kexec/relocate_32.S                   |   7 +-
 arch/powerpc/platforms/cell/spufs/gang.c           |   1 +
 arch/powerpc/platforms/cell/spufs/inode.c          |  63 ++++-
 arch/powerpc/platforms/cell/spufs/spufs.h          |   2 +
 arch/riscv/errata/Makefile                         |   6 +-
 arch/riscv/include/asm/ftrace.h                    |   4 +-
 arch/riscv/kernel/elf_kexec.c                      |   3 +
 arch/riscv/kvm/vcpu_pmu.c                          |   1 +
 arch/riscv/mm/hugetlbpage.c                        |  74 +++--
 arch/riscv/purgatory/entry.S                       |   1 +
 arch/s390/include/asm/io.h                         |   2 -
 arch/s390/include/asm/pgtable.h                    |   3 -
 arch/s390/kernel/entry.S                           |   2 +-
 arch/s390/mm/pgtable.c                             |  10 -
 arch/um/include/shared/os.h                        |   1 -
 arch/um/kernel/Makefile                            |   2 +-
 arch/um/kernel/maccess.c                           |  19 --
 arch/um/os-Linux/process.c                         |  51 ----
 arch/x86/Kconfig                                   |   3 +-
 arch/x86/Kconfig.cpu                               |   2 +-
 arch/x86/Makefile.um                               |   7 +-
 arch/x86/coco/tdx/tdx.c                            |  26 +-
 arch/x86/entry/calling.h                           |   2 +
 arch/x86/entry/common.c                            |   2 +-
 arch/x86/events/intel/core.c                       |  47 ++--
 arch/x86/events/intel/ds.c                         |  13 +-
 arch/x86/events/perf_event.h                       |   3 +-
 arch/x86/hyperv/hv_vtl.c                           |   1 +
 arch/x86/hyperv/ivm.c                              |   5 +-
 arch/x86/include/asm/tdx.h                         |   4 +-
 arch/x86/include/asm/tlbflush.h                    |   2 +-
 arch/x86/kernel/cpu/mce/severity.c                 |  11 +-
 arch/x86/kernel/cpu/microcode/amd.c                |   2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c             |   3 +-
 arch/x86/kernel/cpu/sgx/driver.c                   |  10 +-
 arch/x86/kernel/dumpstack.c                        |   5 +-
 arch/x86/kernel/fpu/core.c                         |   6 +-
 arch/x86/kernel/process.c                          |   9 +-
 arch/x86/kernel/traps.c                            |  18 +-
 arch/x86/kernel/tsc.c                              |   4 +-
 arch/x86/kernel/uprobes.c                          |  14 +-
 arch/x86/kvm/svm/sev.c                             |  13 +-
 arch/x86/kvm/x86.c                                 |  15 +-
 arch/x86/lib/copy_user_64.S                        |  18 ++
 arch/x86/mm/mem_encrypt_identity.c                 |   4 +-
 arch/x86/mm/pat/cpa-test.c                         |   2 +-
 arch/x86/mm/pat/memtype.c                          |  52 ++--
 crypto/api.c                                       |  17 +-
 crypto/bpf_crypto_skcipher.c                       |   1 +
 drivers/acpi/nfit/core.c                           |   2 +-
 drivers/acpi/processor_idle.c                      |   4 +
 drivers/acpi/resource.c                            |   7 +
 drivers/acpi/x86/utils.c                           |   3 +-
 drivers/auxdisplay/Kconfig                         |   1 +
 drivers/auxdisplay/panel.c                         |   4 +-
 drivers/base/power/main.c                          |  21 +-
 drivers/base/power/runtime.c                       |   2 +-
 drivers/block/ublk_drv.c                           |  41 ++-
 drivers/clk/imx/clk-imx8mp-audiomix.c              |   6 +-
 drivers/clk/meson/g12a.c                           |  38 ++-
 drivers/clk/meson/gxbb.c                           |  14 +-
 drivers/clk/qcom/gcc-msm8953.c                     |   2 +-
 drivers/clk/qcom/gcc-sm8650.c                      |   4 +-
 drivers/clk/qcom/gcc-x1e80100.c                    |  30 --
 drivers/clk/qcom/mmcc-sdm660.c                     |   2 +-
 drivers/clk/renesas/r9a08g045-cpg.c                |   5 +-
 drivers/clk/renesas/rzg2l-cpg.c                    |  13 +-
 drivers/clk/renesas/rzg2l-cpg.h                    |  10 +-
 drivers/clk/rockchip/clk-rk3328.c                  |   2 +-
 drivers/clk/samsung/clk.c                          |   2 +-
 drivers/cpufreq/Kconfig.arm                        |   2 +-
 drivers/cpufreq/cpufreq_governor.c                 |  45 +--
 drivers/cpufreq/scpi-cpufreq.c                     |   5 +-
 drivers/crypto/hisilicon/sec2/sec.h                |   1 -
 drivers/crypto/hisilicon/sec2/sec_crypto.c         | 125 ++++-----
 drivers/crypto/intel/iaa/iaa_crypto_main.c         |   4 +-
 .../crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c |   1 +
 drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c |  59 +---
 drivers/crypto/nx/nx-common-pseries.c              |  37 ++-
 drivers/crypto/tegra/tegra-se-aes.c                |  47 ++--
 drivers/crypto/tegra/tegra-se-hash.c               |  27 +-
 drivers/crypto/tegra/tegra-se-key.c                |  10 +-
 drivers/crypto/tegra/tegra-se-main.c               |  16 +-
 drivers/crypto/tegra/tegra-se.h                    |   3 +-
 drivers/dma/fsl-edma-main.c                        |  14 +-
 drivers/edac/i10nm_base.c                          |   2 +
 drivers/edac/ie31200_edac.c                        |  19 +-
 drivers/edac/skx_common.c                          |  33 +++
 drivers/edac/skx_common.h                          |  11 +
 drivers/firmware/cirrus/cs_dsp.c                   |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   1 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  15 -
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  16 ++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   5 +
 .../gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c  |   4 +
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |  12 +-
 .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c   |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |   3 +-
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |  12 +-
 drivers/gpu/drm/bridge/ite-it6505.c                |   7 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |   2 +
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |   8 +-
 drivers/gpu/drm/mediatek/mtk_crtc.c                |   7 +-
 drivers/gpu/drm/mediatek/mtk_dp.c                  |   6 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |   6 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |  33 ++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |   4 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   3 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |   8 +-
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |  32 ++-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          |   2 +-
 drivers/gpu/drm/msm/msm_dsc_helper.h               |  11 -
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c      |   2 +-
 drivers/gpu/drm/panthor/panthor_fw.h               |   6 +-
 drivers/gpu/drm/solomon/ssd130x-spi.c              |   7 +-
 drivers/gpu/drm/solomon/ssd130x.c                  |   6 +-
 drivers/gpu/drm/vkms/vkms_drv.c                    |  15 +-
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c                |   2 +
 drivers/greybus/gb-beagleplay.c                    |   4 +-
 drivers/hid/Makefile                               |   1 -
 drivers/hid/i2c-hid/i2c-hid-core.c                 |   2 +-
 drivers/hwmon/nct6775-core.c                       |   4 +-
 drivers/hwtracing/coresight/coresight-catu.c       |   2 +-
 drivers/hwtracing/coresight/coresight-core.c       |  20 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  48 +++-
 drivers/i3c/master/svc-i3c-master.c                |   2 +-
 drivers/iio/accel/mma8452.c                        |  10 +-
 drivers/iio/accel/msa311.c                         |  28 +-
 drivers/iio/adc/ad4130.c                           |  41 ++-
 drivers/iio/adc/ad7124.c                           |  35 ++-
 drivers/iio/adc/ad7173.c                           |  25 +-
 drivers/iio/adc/ad7768-1.c                         |  15 +
 drivers/iio/industrialio-backend.c                 |   4 +-
 drivers/iio/light/veml6075.c                       |   8 +-
 drivers/infiniband/core/device.c                   |  18 +-
 drivers/infiniband/core/mad.c                      |  38 +--
 drivers/infiniband/core/sysfs.c                    |   1 +
 drivers/infiniband/hw/erdma/erdma_cm.c             |   1 -
 drivers/infiniband/hw/mana/main.c                  |   2 +-
 drivers/infiniband/hw/mlx5/cq.c                    |   2 +-
 drivers/infiniband/hw/mlx5/mr.c                    |  41 ++-
 drivers/infiniband/hw/mlx5/odp.c                   |  10 +-
 drivers/leds/led-core.c                            |  22 +-
 drivers/media/dvb-frontends/dib8000.c              |   5 +-
 drivers/media/platform/allegro-dvt/allegro-core.c  |   1 +
 drivers/media/platform/ti/omap3isp/isp.c           |   7 +
 .../platform/verisilicon/hantro_g2_hevc_dec.c      |   1 +
 drivers/media/rc/streamzap.c                       |   2 +-
 drivers/media/test-drivers/vimc/vimc-streamer.c    |   6 +
 drivers/memory/omap-gpmc.c                         |  20 --
 drivers/mfd/sm501.c                                |   6 +-
 drivers/misc/ntsync.c                              |   1 +
 drivers/mmc/host/omap.c                            |  19 +-
 drivers/mmc/host/sdhci-omap.c                      |   4 +-
 drivers/mmc/host/sdhci-pxav3.c                     |   1 +
 drivers/net/arcnet/com20020-pci.c                  |  17 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |  11 +-
 drivers/net/dsa/mv88e6xxx/phy.c                    |   3 +
 drivers/net/dsa/realtek/Kconfig                    |   2 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |  39 ++-
 drivers/net/ethernet/intel/e1000e/defines.h        |   3 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |  80 +++++-
 drivers/net/ethernet/intel/e1000e/ich8lan.h        |   4 +
 drivers/net/ethernet/intel/idpf/idpf_main.c        |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |   3 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h         |   3 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   3 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c     | 201 ++++++++-----
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |   2 +-
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |   8 +-
 drivers/net/phy/broadcom.c                         |   6 +-
 drivers/net/usb/rndis_host.c                       |  16 +-
 drivers/net/usb/usbnet.c                           |   6 +-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |  20 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  86 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |   1 -
 drivers/ntb/hw/intel/ntb_hw_gen3.c                 |   3 +
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c             |   2 +-
 drivers/ntb/test/ntb_perf.c                        |   4 +-
 drivers/nvme/host/ioctl.c                          |   2 +-
 drivers/nvme/host/pci.c                            |  34 ++-
 drivers/nvme/host/tcp.c                            |   5 +-
 drivers/nvme/target/debugfs.c                      |   2 +-
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |   3 +-
 drivers/pci/controller/cadence/pcie-cadence.h      |   2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   1 +
 drivers/pci/controller/dwc/pcie-histb.c            |  12 +-
 drivers/pci/controller/pcie-brcmstb.c              |  16 +-
 drivers/pci/controller/pcie-xilinx-cpm.c           |  10 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |   4 +-
 drivers/pci/pci-sysfs.c                            |   4 +-
 drivers/pci/pci.c                                  |  22 +-
 drivers/pci/pcie/aspm.c                            |  17 +-
 drivers/pci/pcie/portdrv.c                         |   8 +-
 drivers/pci/probe.c                                |   5 +-
 drivers/pci/setup-bus.c                            |   4 +-
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c  |  50 +++-
 drivers/pinctrl/intel/pinctrl-intel.c              |   1 -
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c          |  10 +-
 drivers/pinctrl/renesas/pinctrl-rza2.c             |   2 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            |   3 +
 drivers/pinctrl/renesas/pinctrl-rzv2m.c            |   2 +
 drivers/pinctrl/tegra/pinctrl-tegra.c              |   3 +
 drivers/platform/x86/amd/pmf/pmf.h                 |   5 +-
 drivers/platform/x86/amd/pmf/tee-if.c              |  52 +++-
 drivers/platform/x86/dell/dell-uart-backlight.c    |   2 +-
 drivers/platform/x86/dell/dell-wmi-ddv.c           |   6 +-
 drivers/platform/x86/intel/hid.c                   |   7 +
 .../x86/intel/speed_select_if/isst_if_common.c     |   2 +-
 drivers/platform/x86/intel/vsec.c                  |   7 +
 .../x86/lenovo-yoga-tab2-pro-1380-fastcharger.c    |   2 +-
 drivers/platform/x86/thinkpad_acpi.c               |  11 +
 drivers/power/supply/bq27xxx_battery.c             |   1 -
 drivers/power/supply/max77693_charger.c            |   2 +-
 drivers/regulator/pca9450-regulator.c              |   6 +-
 drivers/remoteproc/qcom_q6v5_mss.c                 |  21 +-
 drivers/remoteproc/qcom_q6v5_pas.c                 |  13 +-
 drivers/remoteproc/remoteproc_core.c               |   1 +
 drivers/soundwire/slave.c                          |   1 +
 drivers/spi/spi-bcm2835.c                          |  18 +-
 drivers/spi/spi-cadence-xspi.c                     |   2 +-
 drivers/staging/rtl8723bs/Kconfig                  |   1 +
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |   7 +-
 .../intel/int340x_thermal/int3402_thermal.c        |   3 +
 drivers/tty/n_tty.c                                |  13 +-
 drivers/tty/serial/fsl_lpuart.c                    | 312 ++++++++++-----------
 drivers/usb/host/xhci-mem.c                        |   6 +-
 drivers/usb/typec/ucsi/ucsi_ccg.c                  |   5 +-
 drivers/vhost/scsi.c                               |  25 +-
 drivers/video/console/Kconfig                      |   6 +-
 drivers/video/fbdev/au1100fb.c                     |   4 +-
 drivers/video/fbdev/sm501fb.c                      |   7 +
 drivers/w1/masters/w1-uart.c                       |   4 +-
 fs/9p/vfs_inode_dotl.c                             |   2 +-
 fs/affs/file.c                                     |   9 +-
 fs/exec.c                                          |  15 +-
 fs/exfat/fatent.c                                  |   2 +-
 fs/exfat/file.c                                    |  29 +-
 fs/exfat/inode.c                                   |  41 ++-
 fs/exfat/namei.c                                   |   5 +
 fs/ext4/dir.c                                      |   3 +
 fs/ext4/super.c                                    |  27 +-
 fs/fuse/dax.c                                      |   1 -
 fs/fuse/dir.c                                      |   2 +-
 fs/fuse/file.c                                     |   4 +-
 fs/hostfs/hostfs.h                                 |   2 +-
 fs/hostfs/hostfs_kern.c                            |   7 +-
 fs/hostfs/hostfs_user.c                            |  59 ++--
 fs/isofs/dir.c                                     |   3 +-
 fs/jfs/jfs_dtree.c                                 |   3 +-
 fs/jfs/xattr.c                                     |  13 +-
 fs/netfs/direct_read.c                             |   6 +-
 fs/nfs/delegation.c                                |  63 +++--
 fs/nfs/nfs4xdr.c                                   |  18 +-
 fs/nfs/sysfs.c                                     |  22 +-
 fs/nfs/write.c                                     |   4 +-
 fs/nfsd/nfs4state.c                                |  37 ++-
 fs/nfsd/nfsctl.c                                   |  44 ++-
 fs/nfsd/vfs.c                                      |  28 +-
 fs/ntfs3/attrib.c                                  |   3 +-
 fs/ntfs3/file.c                                    |  22 +-
 fs/ntfs3/frecord.c                                 |   6 +-
 fs/ntfs3/index.c                                   |   4 +-
 fs/ntfs3/ntfs.h                                    |   2 +-
 fs/ocfs2/alloc.c                                   |   8 +
 fs/proc/base.c                                     |   2 +-
 fs/smb/client/cifsacl.c                            |  34 ++-
 fs/smb/client/connect.c                            |  16 +-
 fs/smb/common/smbacl.h                             |   3 +-
 fs/smb/server/auth.c                               |   6 +-
 fs/smb/server/connection.h                         |  11 +
 fs/smb/server/mgmt/user_session.c                  |  37 ++-
 fs/smb/server/mgmt/user_session.h                  |   2 +
 fs/smb/server/oplock.c                             |  12 +-
 fs/smb/server/smb2pdu.c                            |  54 +++-
 fs/smb/server/smbacl.c                             |  50 ++--
 fs/smb/server/smbacl.h                             |   2 +-
 include/drm/display/drm_dp_mst_helper.h            |   7 +
 include/linux/cgroup-defs.h                        |   1 +
 include/linux/context_tracking_irq.h               |   8 +-
 include/linux/coresight.h                          |   4 +
 include/linux/fwnode.h                             |   2 +-
 include/linux/interrupt.h                          |   8 +-
 include/linux/nfs_fs_sb.h                          |   4 +
 include/linux/nmi.h                                |   4 -
 include/linux/pgtable.h                            |  28 +-
 include/linux/pm_runtime.h                         |   2 +
 include/linux/rcupdate.h                           |   2 +-
 include/linux/sched/smt.h                          |   2 +-
 include/linux/thermal.h                            |   2 -
 include/linux/trace_events.h                       |  14 +
 include/linux/uprobes.h                            |   2 +
 include/rdma/ib_verbs.h                            |   1 +
 kernel/bpf/core.c                                  |  19 +-
 kernel/bpf/verifier.c                              |   7 +
 kernel/cgroup/rstat.c                              |  38 +--
 kernel/cpu.c                                       |   5 -
 kernel/events/core.c                               |  46 ++-
 kernel/events/ring_buffer.c                        |   2 +-
 kernel/events/uprobes.c                            |  15 +-
 kernel/fork.c                                      |   4 +
 kernel/kexec_elf.c                                 |   2 +-
 kernel/locking/semaphore.c                         |  13 +-
 kernel/sched/deadline.c                            |   2 +-
 kernel/sched/fair.c                                |  50 +++-
 kernel/trace/bpf_trace.c                           |   2 +-
 kernel/trace/ring_buffer.c                         |   4 +-
 kernel/trace/trace_events.c                        |  14 +
 kernel/trace/trace_events_hist.c                   | 133 +++++++--
 kernel/trace/trace_events_synth.c                  |  32 ++-
 kernel/trace/trace_functions_graph.c               |   1 +
 kernel/trace/trace_irqsoff.c                       |   2 -
 kernel/trace/trace_osnoise.c                       |   1 -
 kernel/trace/trace_sched_wakeup.c                  |   2 -
 kernel/watch_queue.c                               |   9 +
 kernel/watchdog.c                                  |  25 --
 kernel/watchdog_perf.c                             |  28 +-
 lib/842/842_compress.c                             |   2 +
 lib/stackinit_kunit.c                              |  30 +-
 lib/vsprintf.c                                     |   2 +-
 mm/gup.c                                           |   3 +
 mm/memory.c                                        |  13 +-
 mm/zswap.c                                         |  30 +-
 net/can/af_can.c                                   |  12 +-
 net/can/af_can.h                                   |  12 +-
 net/can/proc.c                                     |  46 +--
 net/core/devmem.c                                  |   4 +-
 net/core/dst.c                                     |   8 +
 net/core/rtnetlink.c                               |   3 +
 net/ipv4/ip_tunnel_core.c                          |   4 +-
 net/ipv4/udp.c                                     |  42 +--
 net/ipv6/addrconf.c                                |  37 ++-
 net/ipv6/calipso.c                                 |  21 +-
 net/ipv6/route.c                                   |  42 ++-
 net/mac80211/driver-ops.c                          |  10 +-
 net/mac80211/iface.c                               |  11 +-
 net/mac80211/rx.c                                  |  10 +-
 net/mac80211/sta_info.c                            |  20 +-
 net/mac80211/util.c                                |   5 +-
 net/netfilter/nf_tables_api.c                      |   4 +-
 net/netfilter/nft_set_hash.c                       |   3 +-
 net/netfilter/nft_tunnel.c                         |   6 +-
 net/openvswitch/actions.c                          |   6 -
 net/sched/act_tunnel_key.c                         |   2 +-
 net/sched/cls_flower.c                             |   2 +-
 net/sched/sch_skbprio.c                            |   3 -
 net/sctp/sysctl.c                                  |   4 +
 net/vmw_vsock/af_vsock.c                           |   6 +-
 rust/Makefile                                      |   4 +-
 rust/kernel/print.rs                               |   7 +-
 scripts/package/debian/rules                       |   6 +-
 scripts/selinux/install_policy.sh                  |  15 +-
 security/smack/smack.h                             |   6 +
 security/smack/smack_lsm.c                         |  34 +--
 sound/core/timer.c                                 | 147 +++++-----
 sound/pci/hda/patch_realtek.c                      |  50 +++-
 sound/soc/amd/acp/acp-legacy-common.c              |  10 +-
 sound/soc/codecs/cs35l41-spi.c                     |   5 +-
 sound/soc/codecs/rt1320-sdw.c                      |   3 +
 sound/soc/codecs/rt5665.c                          |  24 +-
 sound/soc/codecs/wsa884x.c                         |   4 +-
 sound/soc/fsl/imx-card.c                           |   4 +
 sound/soc/ti/j721e-evm.c                           |   2 +
 tools/arch/x86/lib/insn.c                          |   2 +-
 tools/lib/bpf/linker.c                             |   2 +-
 tools/objtool/check.c                              |  35 +--
 tools/perf/Makefile.config                         |  10 +-
 tools/perf/Makefile.perf                           |   2 +-
 tools/perf/bench/syscall.c                         |  22 +-
 tools/perf/builtin-report.c                        |   2 +-
 .../arch/arm64/ampere/ampereonex/metrics.json      |  10 +-
 .../shell/coresight/asm_pure_loop/asm_pure_loop.S  |   2 +
 tools/perf/tests/shell/record_bpf_filter.sh        |   4 +-
 tools/perf/util/arm-spe.c                          |   8 +-
 tools/perf/util/bpf-filter.l                       |   2 +-
 tools/perf/util/comm.c                             |   2 +
 tools/perf/util/debug.c                            |   2 +-
 tools/perf/util/dso.h                              |   4 +-
 tools/perf/util/evlist.c                           |  13 +-
 tools/perf/util/intel-tpebs.c                      |   2 +-
 tools/perf/util/pmu.c                              |   7 +-
 tools/perf/util/pmu.h                              |   5 +
 tools/perf/util/pmus.c                             |  20 +-
 tools/perf/util/python.c                           |  17 +-
 tools/perf/util/stat-shadow.c                      |   3 +-
 tools/perf/util/units.c                            |   2 +-
 tools/power/x86/turbostat/turbostat.8              |   2 +
 tools/power/x86/turbostat/turbostat.c              |   2 +-
 .../selftests/bpf/prog_tests/bloom_filter_map.c    |   5 +
 tools/testing/selftests/bpf/prog_tests/tailcalls.c |   1 +
 tools/testing/selftests/bpf/progs/strncmp_bench.c  |   5 +-
 tools/testing/selftests/mm/cow.c                   |   2 +-
 .../selftests/net/netfilter/br_netfilter.sh        |   7 +
 .../selftests/net/netfilter/br_netfilter_queue.sh  |   7 +
 tools/testing/selftests/net/netfilter/nft_queue.sh |   1 +
 419 files changed, 3525 insertions(+), 2020 deletions(-)



