Return-Path: <stable+bounces-145181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F00ACABDA68
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0115D1B66B2F
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A53242D7D;
	Tue, 20 May 2025 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MfkgzWaY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029CE1922ED;
	Tue, 20 May 2025 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749403; cv=none; b=DEDbJ3dFqKunpPN4bR3oWCUAHPev2oAKqovJmbKLfle/HZv5faAau/CI/HdTHVn8frHrD2TzftvhZocfNDM12f+rgiHtw1NJYGJqvmrjW2+blR9MXsrNbeC/oEcHTb8tVhAF4z8OhActrFrV5E7VhjX3PG4Yj/pGr1UeSbkWKeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749403; c=relaxed/simple;
	bh=gBzSrTmyBbrwAD2HJMQ2qnKOrGQQYtMwU3CErWP48lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qSr06GqD93J3gIHXjwSkQWafqBm+PZhFGYu/WSwD1ofYroc8WzCdfcpgHSzBOkyHXEoEMa8USflsfnQnE6+KPNZdc3S1axjUPTWZhCZSapLNZtYYL11wPSsvvncDx7vTCEkWNomVg5AoVJhYzWfdkV/V6kUB66vqmVM2Bl30LoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MfkgzWaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3D5C4CEE9;
	Tue, 20 May 2025 13:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749402;
	bh=gBzSrTmyBbrwAD2HJMQ2qnKOrGQQYtMwU3CErWP48lo=;
	h=From:To:Cc:Subject:Date:From;
	b=MfkgzWaYpsYXFg5hsI1ZFd1NBZrtntGyKQFWY47kYWe5qK90ptEOdeP28NTses/b1
	 jb/raO0BIsWHwEn5UUZcu49iVz+XeWU8ihkJNn2P3k3acaAZ2C0wHek0Q6P0aqTelS
	 qQbzEz9i/oQ4ubyWDeY+OBqjwvezVUWm/w6mSvFI=
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
Subject: [PATCH 6.1 00/97] 6.1.140-rc1 review
Date: Tue, 20 May 2025 15:49:25 +0200
Message-ID: <20250520125800.653047540@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.140-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.140-rc1
X-KernelTest-Deadline: 2025-05-22T12:58+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.140 release.
There are 97 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.140-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.140-rc1

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: fix pm notifier handling

Théo Lebrun <theo.lebrun@bootlin.com>
    spi: cadence-qspi: fix pointer reference in runtime PM hooks

Shigeru Yoshida <syoshida@redhat.com>
    ipv4: Fix uninit-value access in __ip_make_skb()

Shigeru Yoshida <syoshida@redhat.com>
    ipv6: Fix potential uninit-value access in __ip6_make_skb()

Shravya KN <shravya.k-n@broadcom.com>
    bnxt_en: Fix receive ring space parameters when XDP is active

Maciej S. Szmigiero <mail@maciej.szmigiero.name>
    platform/x86/amd/pmc: Only disable IRQ1 wakeup where i8042 actually enabled it

Mark Brown <broonie@kernel.org>
    arm64/sme: Always exit sme_alloc() early with existing storage

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: do not defer rule destruction via call_rcu

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: wait for rcu grace period on net_device removal

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: pass nft_chain to destroy function, not nft_ctx

Filipe Manana <fdmanana@suse.com>
    btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()

Eric Dumazet <edumazet@google.com>
    sctp: add mutual exclusion in proc_sctp_do_udp_port()

Ma Wupeng <mawupeng1@huawei.com>
    hwpoison, memory_hotplug: lock folio before unmap hwpoisoned folio

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: Explicitly specify code model in Makefile

Peter Collingbourne <pcc@google.com>
    bpf, arm64: Fix address emission with tag-based KASAN enabled

Puranjay Mohan <puranjay@kernel.org>
    bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG

Xu Lu <luxu.kernel@bytedance.com>
    riscv: mm: Fix the out of bound issue of vmemmap address

Byungchul Park <byungchul@sk.com>
    mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone index

Feng Tang <feng.tang@linux.alibaba.com>
    selftests/mm: compaction_test: support platform with huge mount of memory

GONG Ruiqi <gongruiqi1@huawei.com>
    usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()

Dan Carpenter <dan.carpenter@linaro.org>
    usb: typec: fix potential array underflow in ucsi_ccg_sync_control()

RD Babiera <rdbabiera@google.com>
    usb: typec: altmodes/displayport: create sysfs nodes as driver's default device attribute group

Andrei Kuchynski <akuchynski@chromium.org>
    usb: typec: ucsi: displayport: Fix deadlock

Shuai Xue <xueshuai@linux.alibaba.com>
    dmaengine: idxd: fix memory leak in error handling path of idxd_pci_probe

Shuai Xue <xueshuai@linux.alibaba.com>
    dmaengine: idxd: fix memory leak in error handling path of idxd_alloc

Shuai Xue <xueshuai@linux.alibaba.com>
    dmaengine: idxd: Add missing idxd cleanup to fix memory leak in remove call

Shuai Xue <xueshuai@linux.alibaba.com>
    dmaengine: idxd: Add missing cleanups in cleanup internals

Shuai Xue <xueshuai@linux.alibaba.com>
    dmaengine: idxd: Add missing cleanup for early error out in idxd_setup_internals

Shuai Xue <xueshuai@linux.alibaba.com>
    dmaengine: idxd: fix memory leak in error handling path of idxd_setup_groups

Shuai Xue <xueshuai@linux.alibaba.com>
    dmaengine: idxd: fix memory leak in error handling path of idxd_setup_engines

Shuai Xue <xueshuai@linux.alibaba.com>
    dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs

Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
    dmaengine: ti: k3-udma: Use cap_mask directly from dma_device structure instead of a local copy

Ronald Wahl <ronald.wahl@legrand.com>
    dmaengine: ti: k3-udma: Add missing locking

Nathan Chancellor <nathan@kernel.org>
    net: qede: Initialize qede_ll_ops with designated initializer

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: mt76: disable napi on driver removal

Jethro Donaldson <devel@jro.nz>
    smb: client: fix memory leak during error handling for POSIX mkdir

Steve Siwinski <ssiwinski@atto.com>
    scsi: sd_zbc: block: Respect bio vector limits for REPORT ZONES buffer

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    phy: renesas: rcar-gen3-usb2: Set timing registers only once

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    phy: renesas: rcar-gen3-usb2: Fix role detection on unbind/bind

Ma Ke <make24@iscas.ac.cn>
    phy: Fix error handling in tegra_xusb_port_init

Steven Rostedt <rostedt@goodmis.org>
    tracing: samples: Initialize trace_array_printk() with the correct function

pengdonglin <pengdonglin@xiaomi.com>
    ftrace: Fix preemption accounting for stacktrace filter command

pengdonglin <pengdonglin@xiaomi.com>
    ftrace: Fix preemption accounting for stacktrace trigger command

Michael Kelley <mhklinux@outlook.com>
    Drivers: hv: vmbus: Remove vmbus_sendpacket_pagebuffer()

Michael Kelley <mhklinux@outlook.com>
    Drivers: hv: Allow vmbus_sendpacket_mpb_desc() to create multiple ranges

Michael Kelley <mhklinux@outlook.com>
    hv_netvsc: Remove rmsg_pgcnt

Michael Kelley <mhklinux@outlook.com>
    hv_netvsc: Preserve contiguous PFN grouping in the page buffer array

Michael Kelley <mhklinux@outlook.com>
    hv_netvsc: Use vmbus_sendpacket_mpb_desc() to send VMBus messages

Hyejeong Choi <hjeong.choi@samsung.com>
    dma-buf: insert memory barrier before updating num_fences

Nicolas Chauvet <kwizart@gmail.com>
    ALSA: usb-audio: Add sample rate quirk for Microdia JP001 USB Camera

Christian Heusel <christian@heusel.eu>
    ALSA: usb-audio: Add sample rate quirk for Audioengine D1

Wentao Liang <vulab@iscas.ac.cn>
    ALSA: es1968: Add error handling for snd_pcm_hw_constraint_pow2()

Jeremy Linton <jeremy.linton@arm.com>
    ACPI: PPTT: Fix processor subtable walk

Wayne Lin <Wayne.Lin@amd.com>
    drm/amd/display: Avoid flooding unnecessary info messages

Wayne Lin <Wayne.Lin@amd.com>
    drm/amd/display: Correct the reply value when AUX write incomplete

Filipe Manana <fdmanana@suse.com>
    btrfs: fix discard worker infinite loop after disabling discard

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: Fix MAX_REG_OFFSET calculation

Nathan Lynch <nathan.lynch@amd.com>
    dmaengine: Revert "dmaengine: dmatest: Fix dmatest waiting less when interrupted"

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4/pnfs: Reset the layout state after a layoutreturn

Pengtao He <hept.hept.hept@gmail.com>
    net/tls: fix kernel panic when alloc_page failed

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-pf: macsec: Fix incorrect max transmit size in TX secy

Cosmin Tanislav <demonsingur@gmail.com>
    regulator: max20086: fix invalid memory access

Abdun Nihaal <abdun.nihaal@gmail.com>
    qlcnic: fix memory leak in qlcnic_sriov_channel_cfg_cmd()

Carolina Jubran <cjubran@nvidia.com>
    net/mlx5e: Disable MACsec offload for uplink representor profile

Geert Uytterhoeven <geert+renesas@glider.be>
    ALSA: sh: SND_AICA should depend on SH_DMA_API

Keith Busch <kbusch@kernel.org>
    nvme-pci: acquire cq_poll_lock in nvme_poll_irqdisable

Kees Cook <kees@kernel.org>
    nvme-pci: make nvme_pci_npages_prp() __always_inline

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: sja1105: discard incoming frames in BR_STATE_LISTENING

Mathieu Othacehe <othacehe@gnu.org>
    net: cadence: macb: Fix a possible deadlock in macb_halt_tx.

Andrew Jeffery <andrew@codeconstruct.com.au>
    net: mctp: Ensure keys maintain only one ref to corresponding dev

Cong Wang <xiyou.wangcong@gmail.com>
    net_sched: Flush gso_skb list too during ->change()

Geert Uytterhoeven <geert+renesas@glider.be>
    spi: loopback-test: Do not split 1024-byte hexdumps

Li Lingfeng <lilingfeng3@huawei.com>
    nfs: handle failure of nfs_get_lock_context in unlock path

Henry Martin <bsdhenrymartin@gmail.com>
    HID: uclogic: Add NULL check in uclogic_input_configured()

Qasim Ijaz <qasdev00@gmail.com>
    HID: thrustmaster: fix memory leak in thrustmaster_interrupts()

Zhu Yanjun <yanjun.zhu@linux.dev>
    RDMA/rxe: Fix slab-use-after-free Read in rxe_queue_cleanup bug

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    clocksource/i8253: Use raw_spinlock_irqsave() in clockevent_i8253_disable()

David Lechner <dlechner@baylibre.com>
    iio: chemical: sps30: use aligned_s64 for timestamp

Jonathan Cameron <Jonathan.Cameron@huawei.com>
    iio: adc: ad7768-1: Fix insufficient alignment of timestamp.

Alex Deucher <alexander.deucher@amd.com>
    Revert "drm/amd: Stop evicting resources on APUs in suspend"

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Add Suspend/Hibernate notification callback support

Zhigang Luo <Zhigang.Luo@amd.com>
    drm/amdgpu: trigger flr_work if reading pf2vf data failed

Ma Jun <Jun.Ma2@amd.com>
    drm/amdgpu: Fix the runtime resume failure issue

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Stop evicting resources on APUs in suspend

Jonathan Cameron <Jonathan.Cameron@huawei.com>
    iio: adc: ad7266: Fix potential timestamp alignment issue.

Michal Suchanek <msuchanek@suse.de>
    tpm: tis: Double the timeout B to 4s

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing: probes: Fix a possible race in trace_probe_log APIs

Hans de Goede <hdegoede@redhat.com>
    platform/x86: asus-wmi: Fix wlan_ctrl_by_user detection

Kees Cook <kees@kernel.org>
    binfmt_elf: Move brk for static PIE even if ASLR disabled

Kees Cook <kees@kernel.org>
    binfmt_elf: Honor PT_LOAD alignment for static PIE

Kees Cook <kees@kernel.org>
    binfmt_elf: Calculate total_size earlier

Kees Cook <kees@kernel.org>
    selftests/exec: Build both static and non-static load_address tests

Kees Cook <keescook@chromium.org>
    binfmt_elf: Leave a gap between .bss and brk

Muhammad Usama Anjum <usama.anjum@collabora.com>
    selftests/exec: load_address: conform test to TAP format output

Kees Cook <keescook@chromium.org>
    binfmt_elf: elf_bss no longer used by load_elf_binary()

Eric W. Biederman <ebiederm@xmission.com>
    binfmt_elf: Support segments with 0 filesz and misaligned starts

Kees Cook <keescook@chromium.org>
    binfmt: Fix whitespace issues


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm64/kernel/fpsimd.c                         |   6 +-
 arch/arm64/net/bpf_jit_comp.c                      |  12 +-
 arch/loongarch/Makefile                            |   2 +-
 arch/loongarch/include/asm/ptrace.h                |   2 +-
 arch/riscv/include/asm/page.h                      |   1 +
 arch/riscv/include/asm/pgtable.h                   |   2 +-
 arch/riscv/mm/init.c                               |  17 +-
 block/bio.c                                        |   2 +-
 drivers/acpi/pptt.c                                |  11 +-
 drivers/char/tpm/tpm_tis_core.h                    |   2 +-
 drivers/clocksource/i8253.c                        |   4 +-
 drivers/dma-buf/dma-resv.c                         |   5 +-
 drivers/dma/dmatest.c                              |   6 +-
 drivers/dma/idxd/init.c                            | 145 +++++++---
 drivers/dma/ti/k3-udma.c                           |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  51 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |  29 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |   3 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |   2 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c              |   2 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  16 +-
 drivers/hid/hid-thrustmaster.c                     |   1 +
 drivers/hid/hid-uclogic-core.c                     |   7 +-
 drivers/hv/channel.c                               |  65 +----
 drivers/iio/adc/ad7266.c                           |   2 +-
 drivers/iio/adc/ad7768-1.c                         |   2 +-
 drivers/iio/chemical/sps30.c                       |   2 +-
 drivers/infiniband/sw/rxe/rxe_cq.c                 |   5 +-
 drivers/net/dsa/sja1105/sja1105_main.c             |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  10 +-
 drivers/net/ethernet/cadence/macb_main.c           |  19 +-
 .../ethernet/marvell/octeontx2/nic/cn10k_macsec.c  |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   4 +
 drivers/net/ethernet/qlogic/qede/qede_main.c       |   2 +-
 .../ethernet/qlogic/qlcnic/qlcnic_sriov_common.c   |   7 +-
 drivers/net/hyperv/hyperv_net.h                    |  13 +-
 drivers/net/hyperv/netvsc.c                        |  57 +++-
 drivers/net/hyperv/netvsc_drv.c                    |  62 +----
 drivers/net/hyperv/rndis_filter.c                  |  24 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |   1 +
 drivers/nvme/host/pci.c                            |   4 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |  38 ++-
 drivers/phy/tegra/xusb.c                           |   8 +-
 drivers/platform/x86/amd/pmc.c                     |   8 +-
 drivers/platform/x86/asus-wmi.c                    |   3 +-
 drivers/regulator/max20086-regulator.c             |   7 +-
 drivers/scsi/sd_zbc.c                              |   6 +-
 drivers/scsi/storvsc_drv.c                         |   1 +
 drivers/spi/spi-cadence-quadspi.c                  |   6 +-
 drivers/spi/spi-loopback-test.c                    |   2 +-
 drivers/usb/typec/altmodes/displayport.c           |  18 +-
 drivers/usb/typec/ucsi/displayport.c               |  19 +-
 drivers/usb/typec/ucsi/ucsi.c                      |  34 +++
 drivers/usb/typec/ucsi/ucsi.h                      |   3 +
 drivers/usb/typec/ucsi/ucsi_ccg.c                  |   5 +
 fs/binfmt_elf.c                                    | 293 ++++++++++++---------
 fs/binfmt_elf_fdpic.c                              |   2 +-
 fs/btrfs/discard.c                                 |  17 +-
 fs/btrfs/extent-tree.c                             |  25 +-
 fs/exec.c                                          |   2 +-
 fs/nfs/nfs4proc.c                                  |   9 +-
 fs/nfs/pnfs.c                                      |   9 +
 fs/smb/client/smb2pdu.c                            |   2 +-
 include/linux/bio.h                                |   1 +
 include/linux/hyperv.h                             |   7 -
 include/linux/tpm.h                                |   2 +-
 include/net/netfilter/nf_tables.h                  |   3 +-
 include/net/sch_generic.h                          |  15 ++
 include/uapi/linux/elf.h                           |   2 +-
 kernel/trace/trace_dynevent.c                      |  16 +-
 kernel/trace/trace_dynevent.h                      |   1 +
 kernel/trace/trace_events_trigger.c                |   2 +-
 kernel/trace/trace_functions.c                     |   6 +-
 kernel/trace/trace_kprobe.c                        |   2 +-
 kernel/trace/trace_probe.c                         |   9 +
 kernel/trace/trace_uprobe.c                        |   2 +-
 mm/memory_hotplug.c                                |   6 +-
 mm/migrate.c                                       |   8 +
 net/ipv4/ip_output.c                               |   3 +-
 net/ipv4/raw.c                                     |   3 +
 net/ipv6/ip6_output.c                              |   3 +-
 net/mctp/route.c                                   |   4 +-
 net/netfilter/nf_tables_api.c                      |  54 ++--
 net/netfilter/nft_immediate.c                      |   2 +-
 net/sched/sch_codel.c                              |   2 +-
 net/sched/sch_fq.c                                 |   2 +-
 net/sched/sch_fq_codel.c                           |   2 +-
 net/sched/sch_fq_pie.c                             |   2 +-
 net/sched/sch_hhf.c                                |   2 +-
 net/sched/sch_pie.c                                |   2 +-
 net/sctp/sysctl.c                                  |   4 +
 net/tls/tls_strp.c                                 |   3 +-
 samples/ftrace/sample-trace-array.c                |   2 +-
 sound/pci/es1968.c                                 |   6 +-
 sound/sh/Kconfig                                   |   2 +-
 sound/usb/quirks.c                                 |   4 +
 tools/testing/selftests/exec/Makefile              |  19 +-
 tools/testing/selftests/exec/load_address.c        |  83 ++++--
 tools/testing/selftests/vm/compaction_test.c       |  19 +-
 103 files changed, 937 insertions(+), 530 deletions(-)



