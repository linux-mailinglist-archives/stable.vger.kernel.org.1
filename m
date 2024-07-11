Return-Path: <stable+bounces-59074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B90D292E32B
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 11:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CA71C20503
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1539E1553BC;
	Thu, 11 Jul 2024 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J59/7RFR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40DC2D02E;
	Thu, 11 Jul 2024 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720689067; cv=none; b=RdnwPXZAMsb4ERjioWvswpEBUKBgXxmPaOfircDAbOjh+b6xlF1XFP7mSNoNML/A0pJlVAtaER5OHftkOfYVH6AChFO7SutNj2ahutFUJXa//keYkZaVSSJRN2qLwRe5Z1F8A3JHIXLPdwOrULQEDpy+TpdKzV2xujvCkiDLEKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720689067; c=relaxed/simple;
	bh=lU52QN1X9hVLPojFSpMw4bCVi/xWByOs4/ORUfKfEzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nwwwwzt69WNF/UNGG+FPLYXY9PHvWo3x5AhTEwHc8umwwHVj9AKJ27cfa2rCYWDXtWR2oxYiLWU7G1sOIy7hGTYX8ymcFl8R8MZUE3QKPGOjsLg3rlr9v5w1Kvvs96eoMMH2G49szHGANlSz1A5lre+eQPEvn6p+h8rFpCL85Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J59/7RFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CFAC116B1;
	Thu, 11 Jul 2024 09:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720689067;
	bh=lU52QN1X9hVLPojFSpMw4bCVi/xWByOs4/ORUfKfEzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J59/7RFR7+qiMKd5FUNxDu5QPX4hfCuEmyTudQKIXEzE1RYQNTpAicvUSdJbLIZeU
	 sqU6r4q+6xtJzrCjhiYXY1quPfdsS2D3PtUSZlDzbntfLSzEP/WJdBMIlBV6eF+Oy7
	 nTDf5slYxJWzGcuW2uPKL7D4GOP7QqN9c09gLZa8=
Date: Thu, 11 Jul 2024 11:11:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	Anders Roxell <anders.roxell@linaro.org>,
	Mike Christie <michael.christie@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
	gnstark@salutedevices.com, linux-mm <linux-mm@kvack.org>,
	Jinliang Zheng <alexjlzheng@tencent.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Brendan Higgins <brendanhiggins@google.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 6.9 000/197] 6.9.9-rc1 review
Message-ID: <2024071118-iguana-pureblood-03be@gregkh>
References: <20240709110708.903245467@linuxfoundation.org>
 <CA+G9fYsqkB4=pVZyELyj3YqUc9jXFfgNULsPk9t8q-+P1w_G6A@mail.gmail.com>
 <CA+G9fYu=_8vT95Q0MQzzTcCr+RTdMi=6MdSN7Cwo=C215VE1fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYu=_8vT95Q0MQzzTcCr+RTdMi=6MdSN7Cwo=C215VE1fQ@mail.gmail.com>

On Thu, Jul 11, 2024 at 02:00:17PM +0530, Naresh Kamboju wrote:
> On Wed, 10 Jul 2024 at 08:41, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Tue, 9 Jul 2024 at 16:49, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.9.9 release.
> > > There are 197 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Thu, 11 Jul 2024 11:06:25 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.9-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Results from Linaro’s test farm.
> > The following kernel panic was noticed while running kunit tests.
> >
> > First seen on
> > git commit id: 2471237b27c681c22e5f2b7175584aa7d5c89bfc
> > date: on July 9th 2024.
> >
> >   GOOD: v6.9.7-223-g03247eed042d
> >   BAD: v6.9.8-198-g2471237b27c6
> >
> > Always reproduce: yes.
> >
> > * qemu-arm64, Juno-r2, rk3399-rock-pi-4b and qemu-x86_64 the kunit-boot failed.
> >   - gcc-13-defconfig-kunit
> >   - clang-18-defconfig-kunit
> >   - clang-nightly-defconfig-kunit
> >   - gcc-8-defconfig-kunit
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Crash log [1]:
> > ---------
> > <4>[ 63.601683] kernel_init_freeable (init/main.c:1559)
> > <4>[ 63.602335] kernel_init (init/main.c:1446)
> > <4>[ 63.602980] ret_from_fork (arch/arm64/kernel/entry.S:861)
> > <3>[   63.603703]
> > <3>[   63.604057] The buggy address belongs to the object at fff00000c07582e8
> > <3>[   63.604057]  which belongs to the cache inode_cache of size 616
> > <3>[   63.605281] The buggy address is located 80 bytes to the right of
> > <3>[   63.605281]  allocated 616-byte region [fff00000c07582e8,
> > fff00000c0758550)
> > <3>[   63.606592]
> > <3>[   63.607294] The buggy address belongs to the physical page:
> > <4>[   63.607948] page: refcount:1 mapcount:0 mapping:0000000000000000
> > index:0x0 pfn:0x100758
> > <4>[   63.608830] head: order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > <4>[   63.609593] flags:
> > 0xbfffe0000000840(slab|head|node=0|zone=2|lastcpupid=0x1ffff)
> > <4>[   63.610449] page_type: 0xffffffff()
> > <4>[   63.611934] raw: 0bfffe0000000840 fff00000c08d2dc0
> > dead000000000122 0000000000000000
> > <4>[   63.612810] raw: 0000000000000000 0000000080160016
> > 00000001ffffffff 0000000000000000
> > <4>[   63.613668] head: 0bfffe0000000840 fff00000c08d2dc0
> > dead000000000122 0000000000000000
> > <4>[   63.614525] head: 0000000000000000 0000000080160016
> > 00000001ffffffff 0000000000000000
> > <4>[   63.615694] head: 0bfffe0000000002 ffffc1ffc301d601
> > ffffc1ffc301d648 00000000ffffffff
> > <4>[   63.616583] head: 0000000400000000 0000000000000000
> > 00000000ffffffff 0000000000000000
> > <4>[   63.617391] page dumped because: kasan: bad access detected
> > <3>[   63.618034]
> > <3>[   63.618354] Memory state around the buggy address:
> > <3>[   63.619281]  fff00000c0758480: 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00
> > <3>[   63.620086]  fff00000c0758500: 00 00 00 00 00 00 00 00 00 00 fc
> > fc fc fc fc fc
> > <3>[   63.620886] >fff00000c0758580: fc fc fc fc fc fc fc fc fc fc 00
> > 00 00 00 00 00
> > <3>[   63.621664]                                ^
> > <3>[   63.622235]  fff00000c0758600: 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00
> > <3>[   63.623362]  fff00000c0758680: 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00
> > <3>[   63.624138]
> > ==================================================================
> > <6>[   63.645148]         not ok 1 block_bits=10 cluster_bits=3
> > blocks_per_group=8192 group_count=4 desc_size=64
> > <6>[   63.658504]         ok 2 block_bits=12 cluster_bits=3
> > blocks_per_group=8192 group_count=4 desc_size=64
> > <1>[   63.674531] Unable to handle kernel NULL pointer dereference at
> > virtual address 0000000000000008
> > <1>[   63.675691] Mem abort info:
> > <1>[   63.676527]   ESR = 0x000000009600006b
> > <1>[   63.677658]   EC = 0x25: DABT (current EL), IL = 32 bits
> > <1>[   63.678274]   SET = 0, FnV = 0
> > <1>[   63.678906]   EA = 0, S1PTW = 0
> > <1>[   63.679880]   FSC = 0x2b: level -1 translation fault
> > <1>[   63.680879] Data abort info:
> > <1>[   63.681606]   ISV = 0, ISS = 0x0000006b, ISS2 = 0x00000000
> > <1>[   63.682544]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> > <1>[   63.683493]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > <1>[   63.684732] [0000000000000008] user address but active_mm is swapper
> > <0>[   63.686080] Internal error: Oops: 000000009600006b [#1] PREEMPT SMP
> > <4>[   63.688843] Modules linked in:
> > <4>[   63.689662] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B
> >     N 6.9.9-rc1 #1
> > <4>[   63.690522] Hardware name: linux,dummy-virt (DT)
> > <4>[   63.691532] pstate: 224000c9 (nzCv daIF +PAN -UAO +TCO -DIT
> > -SSBS BTYPE=--)
> > <4>[ 63.692423] pc : _raw_spin_lock_irq
> > (arch/arm64/include/asm/atomic_lse.h:271
> > arch/arm64/include/asm/cmpxchg.h:120
> > arch/arm64/include/asm/cmpxchg.h:169
> > include/linux/atomic/atomic-arch-fallback.h:2055
> > include/linux/atomic/atomic-arch-fallback.h:2173
> > include/linux/atomic/atomic-instrumented.h:1302
> > include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187
> > include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170)
> > <4>[ 63.693097] lr : _raw_spin_lock_irq
> > (include/linux/atomic/atomic-arch-fallback.h:2172 (discriminator 1)
> > include/linux/atomic/atomic-instrumented.h:1302 (discriminator 1)
> > include/asm-generic/qspinlock.h:111 (discriminator 1)
> > include/linux/spinlock.h:187 (discriminator 1)
> > include/linux/spinlock_api_smp.h:120 (discriminator 1)
> > kernel/locking/spinlock.c:170 (discriminator 1))
> > <4>[   63.693714] sp : ffff800080087620
> > <4>[   63.694519] x29: ffff800080087680 x28: 1ffff00010010f45 x27:
> > ffff800080087a20
> > <4>[   63.696315] x26: 1ffff00010010f47 x25: ffff800080087a00 x24:
> > fff00000c99f0028
> > <4>[   63.697334] x23: 0000000000000000 x22: dfff800000000000 x21:
> > ffff800080087640
> > <4>[   63.698333] x20: 1ffff00010010ec4 x19: 0000000000000008 x18:
> > 000000004b9fd0a9
> > <4>[   63.699711] x17: 0000000000000000 x16: fff00000da13e180 x15:
> > ffffaa8e3330c4c4
> > <4>[   63.700732] x14: ffffaa8e33312508 x13: ffffaa8e3583b0ec x12:
> > ffff700010010ec9
> > <4>[   63.701734] x11: 1ffff00010010ec8 x10: ffff700010010ec8 x9 :
> > dfff800000000000
> > <4>[   63.702792] x8 : 0000000000000003 x7 : 0000000000000001 x6 :
> > ffff700010010ec8
> > <4>[   63.704539] x5 : ffff800080087640 x4 : ffff700010010ec8 x3 :
> > ffffaa8e3585c520
> > <4>[   63.705529] x2 : 0000000000000001 x1 : 0000000000000000 x0 :
> > 0000000000000000
> > <4>[   63.706625] Call trace:
> > <4>[ 63.707408] _raw_spin_lock_irq
> > (arch/arm64/include/asm/atomic_lse.h:271
> > arch/arm64/include/asm/cmpxchg.h:120
> > arch/arm64/include/asm/cmpxchg.h:169
> > include/linux/atomic/atomic-arch-fallback.h:2055
> > include/linux/atomic/atomic-arch-fallback.h:2173
> > include/linux/atomic/atomic-instrumented.h:1302
> > include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187
> > include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170)
> > <4>[ 63.708130] wait_for_completion_timeout
> > (kernel/sched/completion.c:84 kernel/sched/completion.c:116
> > kernel/sched/completion.c:127 kernel/sched/completion.c:167)
> > <4>[ 63.708902] kunit_try_catch_run (lib/kunit/try-catch.c:85)
> > <4>[ 63.709710] kunit_run_case_catch_errors (lib/kunit/test.c:544)
> > <4>[ 63.710558] kunit_run_tests (lib/kunit/test.c:649)
> > <4>[ 63.711555] __kunit_test_suites_init (lib/kunit/test.c:732
> > (discriminator 1))
> > <4>[ 63.712489] kunit_run_all_tests (lib/kunit/executor.c:276
> > lib/kunit/executor.c:392)
> > <4>[ 63.713317] kernel_init_freeable (init/main.c:1559)
> > <4>[ 63.713971] kernel_init (init/main.c:1446)
> > <4>[ 63.714503] ret_from_fork (arch/arm64/kernel/entry.S:861)
> > <0>[ 63.716154] Code: 93407c02 d503201f 2a0003e1 52800022 (88e17e62)
> > All code
> > ========
> >    0: 93407c02 sxtw x2, w0
> >    4: d503201f nop
> >    8: 2a0003e1 mov w1, w0
> >    c: 52800022 mov w2, #0x1                    // #1
> >   10:* 88e17e62 casa w1, w2, [x19] <-- trapping instruction
> >
> > Code starting with the faulting instruction
> > ===========================================
> >    0: 88e17e62 casa w1, w2, [x19]
> > <4>[   63.717705] ---[ end trace 0000000000000000 ]---
> > <6>[   63.718649] note: swapper/0[1] exited with irqs disabled
> > <6>[   63.720758] note: swapper/0[1] exited with preempt_count 1
> > <0>[   63.722091] Kernel panic - not syncing: Attempted to kill init!
> > exitcode=0x0000000b
> > <2>[   63.724608] SMP: stopping secondary CPUs
> > <0>[   63.725877] Kernel Offset: 0x2a8db2200000 from 0xffff800080000000
> > <0>[   63.726534] PHYS_OFFSET: 0x40000000
> > <0>[   63.727664] CPU features: 0x0,00000006,8f17bd7c,6766773f
> > <0>[   63.729291] Memory Limit: none
> > <0>[   63.731074] ---[ end Kernel panic - not syncing: Attempted to
> > kill init! exitcode=0x0000000b ]---
> >
> > Steps to reproduce on qemu-arm64 link provided [2].
> > Build artifacts arm64 link provided [3].
> > The Kconfig is built with defconfig+Kunit and the config link provided [4].
> > This occurred on following Toolchain builds gcc-13, clang-18,
> > clang-nightly and gcc-8.
> >
> > Reproducible always on following devices and emulators,
> >  * rk3399-rock-pi-4b
> >  * qemu-arm64
> >  * qemu-x86_64
> >
> > I am bisecting this reported issue.
> 
> Anders, bisected this issue and found this as the first bad commit and after
> reverting this patch the boot pass and kernel panic were not found.
> 
> # first bad commit: [6b91f756f49a16223085b38cedb7e297d134d64d]
>     kunit: Handle test faults
>     [ Upstream commit 3a35c13007dea132a65f07de05c26b87837fadc2 ]
> 
> 
> > Please let me know if you need more information.
> >
> > Links:
> > [1] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.8-198-g2471237b27c6/testrun/24552495/suite/boot/test/gcc-13-lkftconfig-kunit/log
> > [2] https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2j0YCwfoW0D9nrPUAeDspHG0iFE/reproducer
> > [3] https://storage.tuxsuite.com/public/linaro/lkft/builds/2j0Y8lX6zRNGTiGTZmteMwzwHj2/
> > [4] https://storage.tuxsuite.com/public/linaro/lkft/builds/2j0Y8lX6zRNGTiGTZmteMwzwHj2/config
> 
> 
> Bisection log:
> ------
> $ git bisect log
> # bad: [6ced42af8b2d3a7dfca7121f6f01b19aa818eeab] Linux 6.9.9-rc1
> # good: [2106717b5214895a29c038b37f15d78a3202aa2b] Linux 6.9.8
> git bisect start 'stable-rc/linux-6.9.y' 'v6.9.8'
> # bad: [30dbb09f028b3de9e304e3ab0bbf123613d6b61f] KVM: s390: fix LPSWEY handling
> git bisect bad 30dbb09f028b3de9e304e3ab0bbf123613d6b61f
> # good: [81d79946a4623d2d2ce21e68ccd1e9997119e8ff]
> thermal/drivers/mediatek/lvts_thermal: Check NULL ptr on lvts_data
> git bisect good 81d79946a4623d2d2ce21e68ccd1e9997119e8ff
> # bad: [9a2f3e9cd7906c3dc5eebcc1d981c3403c742ea7] s390/pkey: Wipe
> sensitive data on failure
> git bisect bad 9a2f3e9cd7906c3dc5eebcc1d981c3403c742ea7
> # good: [1b4c766b624614df4deaf51d20dc596859ec8254] orangefs: fix
> out-of-bounds fsid access
> git bisect good 1b4c766b624614df4deaf51d20dc596859ec8254
> # bad: [867bfb350f89b328fe30537afda02fe4c4ae23f5] bpf: Avoid
> uninitialized value in BPF_CORE_READ_BITFIELD
> git bisect bad 867bfb350f89b328fe30537afda02fe4c4ae23f5
> # bad: [18363e5c5cbf3c51d0d857e4b9706674cbfd5a96] powerpc/xmon: Check
> cpu id in commands "c#", "dp#" and "dx#"
> git bisect bad 18363e5c5cbf3c51d0d857e4b9706674cbfd5a96
> # bad: [6b91f756f49a16223085b38cedb7e297d134d64d] kunit: Handle test faults
> git bisect bad 6b91f756f49a16223085b38cedb7e297d134d64d
> # good: [3bbd81663033fa72cac3a867e5284b925b445ad6] kunit: Fix timeout message
> git bisect good 3bbd81663033fa72cac3a867e5284b925b445ad6
> # first bad commit: [6b91f756f49a16223085b38cedb7e297d134d64d] kunit:
> Handle test faults

So the code to do testing is the thing that is crashing {sigh}

I'll go drop this from all stable branches, but odds are this is also
happening in Linus's tree so you might want to report it to the people
who submitted it there as well.  The thread is here:
	https://lore.kernel.org/r/20240408074625.65017-5-mic@digikod.net

thanks for the bisection!

greg k-h

