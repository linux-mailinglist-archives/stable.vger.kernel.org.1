Return-Path: <stable+bounces-61980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF2993E158
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 00:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A501C20C44
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 22:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC903B7AC;
	Sat, 27 Jul 2024 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmPBRJUN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6D134CD8
	for <stable@vger.kernel.org>; Sat, 27 Jul 2024 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722119601; cv=none; b=JXLwWH5JUX0HJLoUiNrehx4cAuPMcdzc+8a0c0A3OUhEzJcAzt6Aq4dvLPd+cispk8HOuS0uowEpNYVESDHcgHiYJnbjmkSlS53mvuijJ/3Csel2gsOnrgy9OM9fq6nqJQ7fy9IfVtEIudIbYyT7eLWdZG5b6vZtmJgra7cARwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722119601; c=relaxed/simple;
	bh=CdQs4sBzNFNu9TC9hM2KprDFmWZ7FeCwIIPbGvjfCqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKsU8EdIpEAa1IDeK+ueYN0M9syVBMPhdmDTlJMtgjpx+h2gHzxm9cLkTnJj3ooZTOyaHhoPkhcVftoH4SfSNMcUXUDMymcxL6vMheskmstyYYqcAXaGix+I4SnaNnwE6HoU/TrG10oBW/zIZy3QoCdr9mBHQmqMzSMOBpv9hGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmPBRJUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75426C4AF10
	for <stable@vger.kernel.org>; Sat, 27 Jul 2024 22:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722119601;
	bh=CdQs4sBzNFNu9TC9hM2KprDFmWZ7FeCwIIPbGvjfCqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cmPBRJUNI8jqnr2Q/B4DP37lGipIF3XugjgWALWxAq6SqmBsTmymxMavLxkDMNr3h
	 S7NWCZAlmrBD+pYqOgYr88mXizPKh2rxSAMWZHD6RytXIM0WxDAx5wrncT3zjuc1TL
	 6WYXANgrd5dTsGGWOCQ4wGgdA+6oOay2SEpPhvm8B9ikefQmHbl/Ly9PY5ZPYGG2Dq
	 DpQ+R1J5N668JGHdkBcmJZrhr/7W8a+qYwCkoNZ+9ejgn2mveYfJP/MpNMeuRnXCPw
	 +9D0B12pq3XZTOTbd+AgtR3wXzjOnfdg8D5RqZvIo1vwBWSmc2U8U0xZUtllS76E5Z
	 P8h+13rzmuqHg==
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-396675b83afso14506625ab.0
        for <stable@vger.kernel.org>; Sat, 27 Jul 2024 15:33:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlF8F0bIO2mJqyDFOKmibt2jU4u8u5oL+jYSrdQP6esbx+yPsSNkZD7MFfDV8bi1qnPv7qS5/22HDU47r/jyQe5sbwW8CB
X-Gm-Message-State: AOJu0Yx23iAaeblt8st+b2/4ncQ1rKojZ8KdI6I5FpvLKTa+5qL1rt/W
	llIxtGkapFygoIlcYi/SP4fCURA6YNrRReRz2FYT1vV7qVinrWpuq8mibMx9pk5b5Rd3YRIj4BI
	QgbeuRc5AO821X8tYROqP/i1QHkzHpDldQweU
X-Google-Smtp-Source: AGHT+IFlK8tO5CjL/1b28riuIeoodIXSl0X7x4FNqHJldEnhRYV61J3Qcy38Wv3feog2LZksgFuSdjN9vmrGyRdeiYg=
X-Received: by 2002:a05:6e02:17c7:b0:376:410b:ae69 with SMTP id
 e9e14a558f8ab-39aec2ea68cmr41229735ab.15.1722119600570; Sat, 27 Jul 2024
 15:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1719038884-1903-1-git-send-email-yangge1116@126.com>
In-Reply-To: <1719038884-1903-1-git-send-email-yangge1116@126.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 27 Jul 2024 15:33:08 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNP5iTj2p07QgHSGOJsiUfYpJ2f4R1Q5-3BN9JiD9W_KA@mail.gmail.com>
Message-ID: <CAF8kJuNP5iTj2p07QgHSGOJsiUfYpJ2f4R1Q5-3BN9JiD9W_KA@mail.gmail.com>
Subject: Re: [PATCH V2] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: yangge1116@126.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
	Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>, baolin.wang@linux.alibaba.com, 
	liuzixing@hygon.cn, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ge Yang,

Sorry for joining this discussion late.

I recently found a regression on mm-unstable during my swap stress
test, using tmpfs to compile linux. The test hit OOM very soon after
the make spawn many cc processes.

This is preventing me from stress testing the swap allocator series on
mm-unstable and mm-stable. I finally spent some time doing a kernel
git bisect. It bisects down to this commit:

33dfe9204f29b415bbc0abb1a50642d1ba94f5e9 is the first bad commit
commit 33dfe9204f29b415bbc0abb1a50642d1ba94f5e9
Author: yangge <yangge1116@126.com>
Date:   Wed Jul 3 20:02:33 2024 +0800
    mm/gup: clear the LRU flag of a page before adding to LRU batch
 mm/swap.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)
bisect found first bad commit


Here the git bisect log:
$ git bisect log
# bad: [66ebbdfdeb093e097399b1883390079cd4c3022b] Merge tag
'irq-msi-2024-07-22' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# good: [0c3836482481200ead7b416ca80c68a29cfdaabd] Linux 6.10
git bisect start 'remotes/akpm/mm-stable' 'v6.10'
# good: [280e36f0d5b997173d014c07484c03a7f7750668] nsfs: use cleanup guard
git bisect good 280e36f0d5b997173d014c07484c03a7f7750668
# good: [07e773db19f16f4111795b658c4748da22c927bb] Merge tag
'tpmdd-next-6.11-rc1-roundtwo' of
git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd
git bisect good 07e773db19f16f4111795b658c4748da22c927bb
# good: [ef035628c326af9aa645af1b91fbb72fdfec874e] Merge tag
'i2c-for-6.11-rc1-try2' of
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
git bisect good ef035628c326af9aa645af1b91fbb72fdfec874e
# good: [2c9b3512402ed192d1f43f4531fb5da947e72bd0] Merge tag
'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect good 2c9b3512402ed192d1f43f4531fb5da947e72bd0
# bad: [30d77b7eef019fa4422980806e8b7cdc8674493e] mm/mglru: fix
ineffective protection calculation
git bisect bad 30d77b7eef019fa4422980806e8b7cdc8674493e
# good: [c02525a33969000fa7b595b743deb4d79804916b] ftrace: unpoison
ftrace_regs in ftrace_ops_list_func()
git bisect good c02525a33969000fa7b595b743deb4d79804916b
# good: [8ef6fd0e9ea83a792ba53882ddc6e0d38ce0d636] Merge branch
'mm-hotfixes-stable' into mm-stable to pick up "mm: fix crashes from
deferred split racing folio migration", needed by "mm: migrate: split
folio_migrate_mapping()".
git bisect good 8ef6fd0e9ea83a792ba53882ddc6e0d38ce0d636
# good: [a898530eea3d0ba08c17a60865995a3bb468d1bc] powerpc/64e: split
out nohash Book3E 64-bit code
git bisect good a898530eea3d0ba08c17a60865995a3bb468d1bc
# good: [00f58104202c472e487f0866fbd38832523fd4f9] mm: fix khugepaged
activation policy
git bisect good 00f58104202c472e487f0866fbd38832523fd4f9
# good: [53dabce2652fb854eae84609ce9c37429d5d87ba] mm, page_alloc: put
should_fail_alloc_page() back behing CONFIG_FAIL_PAGE_ALLOC
git bisect good 53dabce2652fb854eae84609ce9c37429d5d87ba
# good: [6ab42fe21c84d72da752923b4bd7075344f4a362] alloc_tag: fix
page_ext_get/page_ext_put sequence during page splitting
git bisect good 6ab42fe21c84d72da752923b4bd7075344f4a362
# bad: [33dfe9204f29b415bbc0abb1a50642d1ba94f5e9] mm/gup: clear the
LRU flag of a page before adding to LRU batch
git bisect bad 33dfe9204f29b415bbc0abb1a50642d1ba94f5e9
# good: [af649773fb25250cd22625af021fb6275c56a3ee] mm/numa_balancing:
teach mpol_to_str about the balancing mode
git bisect good af649773fb25250cd22625af021fb6275c56a3ee
# first bad commit: [33dfe9204f29b415bbc0abb1a50642d1ba94f5e9] mm/gup:
clear the LRU flag of a page before adding to LRU batch

I double checked this commit 33dfe9204f29b415bbc0abb1a50642d1ba94f5e9
("mm/gup: clear the LRU flag of a page before adding to LRU batch")
fail the swap stress test very quickly.

The previous commit af649773fb25250cd22625af021fb6275c56a3ee
("mm/numa_balancing: teach mpol_to_str about the balancing mode") can
pass the swap stress test fine.

Please feel free to send me patches to test out the issue. As it is, I
believe it is a regression on the swapping behavior.

Here is the dmesg of the OOM kill:

[   93.326752] cc1 invoked oom-killer: gfp_mask=3D0xcc0(GFP_KERNEL),
order=3D0, oom_score_adj=3D0
[   93.327330] CPU: 3 PID: 5225 Comm: cc1 Tainted: G          I
6.10.0-rc6+ #34
[   93.328277] Hardware name: HP ProLiant DL360 G7, BIOS P68 08/16/2015
[   93.328757] Call Trace:
[   93.328977]  <TASK>
[   93.329515]  dump_stack_lvl+0x5d/0x80
[   93.329842]  dump_header+0x44/0x18d
[   93.330422]  oom_kill_process.cold+0xa/0xaa
[   93.330723]  out_of_memory+0x219/0x4b0
[   93.331037]  mem_cgroup_out_of_memory+0x12d/0x160
[   93.331755]  try_charge_memcg+0x488/0x630
[   93.332044]  __mem_cgroup_charge+0x42/0xb0
[   93.332321]  do_anonymous_page+0x32a/0x8b0
[   93.332553]  ? __pte_offset_map+0x1b/0x180
[   93.332857]  __handle_mm_fault+0xc05/0x1080
[   93.333141]  ? sched_balance_trigger+0x14c/0x3f0
[   93.333840]  ? sched_tick+0xee/0x320
[   93.334142]  handle_mm_fault+0xcd/0x2a0
[   93.334419]  do_user_addr_fault+0x217/0x620
[   93.334694]  exc_page_fault+0x7e/0x180
[   93.334960]  asm_exc_page_fault+0x26/0x30
[   93.335194] RIP: 0033:0x147a0b3
[   93.335852] Code: a0 00 48 89 fb 49 89 f4 41 89 d5 74 7a 31 d2 31
f6 b9 01 00 00 00 bf 18 00 00 00 e8 97 b6 f8 ff 66 0f ef c0 66 41 83
3c 24 2b <4c> 89 60 10 48 89 c5 49 89 c6 0f 11 00 74 7e 48 8b 43 08 80
48 02
[   93.337577] RSP: 002b:00007ffe666e3e10 EFLAGS: 00010216
[   93.337966] RAX: 00007f4dd9d0e000 RBX: 00007ffe666e3e50 RCX: 00000000000=
000a9
[   93.338896] RDX: 0000000000000018 RSI: 0000000000000006 RDI: 00000000000=
000aa
[   93.339849] RBP: 00007f4dd9d0a0e0 R08: 0000000000000040 R09: 00000000000=
00001
[   93.340801] R10: 0000000000000000 R11: 0000000004c04560 R12: 00007f4dd9d=
04fd8
[   93.341675] R13: 0000000000000004 R14: 0000000000000000 R15: 000000007ff=
ea943
[   93.342584]  </TASK>
[   93.342762] memory: usage 481280kB, limit 481280kB, failcnt 9789
[   93.343556] swap: usage 123404kB, limit 9007199254740988kB, failcnt 0
[   93.343984] Memory cgroup stats for /build-kernel-tmpfs:
[   93.344051] anon 461377536
[   93.344586] file 10264576
[   93.344795] kernel 20480000
[   93.344987] kernel_stack 2146304
[   93.345615] pagetables 9916416
[   93.346283] sec_pagetables 0
[   93.346878] percpu 54496
[   93.347080] sock 0
[   93.347607] vmalloc 0
[   93.347837] shmem 24576
[   93.347984] zswap 0
[   93.348510] zswapped 0
[   93.348661] file_mapped 9805824
[   93.349286] file_dirty 0
[   93.349484] file_writeback 0
[   93.350085] swapcached 24576
[   93.350706] anon_thp 213909504
[   93.351335] file_thp 0
[   93.351544] shmem_thp 0
[   93.351681] inactive_anon 180965376
[   93.352348] active_anon 291487744
[   93.352993] inactive_file 1298432
[   93.353632] active_file 7987200
[   93.354281] unevictable 0
[   93.354483] slab_reclaimable 943096
[   93.355085] slab_unreclaimable 6340520
[   93.355369] slab 7283616
[   93.355597] workingset_refault_anon 1138
[   93.355857] workingset_refault_file 180
[   93.356135] workingset_activate_anon 627
[   93.356410] workingset_activate_file 123
[   93.356694] workingset_restore_anon 579
[   93.357001] workingset_restore_file 115
[   93.382485] workingset_nodereclaim 0
[   93.457426] pgscan 101315
[   93.457631] pgsteal 51494
[   93.457843] pgscan_kswapd 0
[   93.458033] pgscan_direct 101315
[   93.458725] pgscan_khugepaged 0
[   93.459494] pgsteal_kswapd 0
[   93.460338] pgsteal_direct 51494
[   93.461046] pgsteal_khugepaged 0
[   93.461701] pgfault 994774
[   93.461895] pgmajfault 1839
[   93.462123] pgrefill 134581
[   93.462315] pgactivate 32506
[   93.463086] pgdeactivate 0
[   93.463314] pglazyfree 0
[   93.463527] pglazyfreed 0
[   93.463727] zswpin 0
[   93.463912] zswpout 0
[   93.464114] zswpwb 0
[   93.464321] thp_fault_alloc 485
[   93.464963] thp_collapse_alloc 0
[   93.465578] thp_swpout 4
[   93.465815] thp_swpout_fallback 0
[   93.466457] Tasks state (memory values in pages):
[   93.467153] [  pid  ]   uid  tgid total_vm      rss rss_anon
rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
[   93.467917] [   1461]  1000  1461     1795      530       53
477         0    45056        0             0 kbench
[   93.468600] [   4170]  1000  4170      636      321        0
321         0    45056        0             0 time
[   93.569307] [   4171]  1000  4171     3071      810       48
762         0    69632       48             0 make
[   93.570111] [   4172]  1000  4172     2706      827      144
683         0    65536      192             0 make
[   93.571015] [   4951]  1000  4951     2733      791      144
647         0    61440      192             0 make
[   93.571747] [   4956]  1000  4956     2560      852      144
708         0    69632        0             0 make
[   93.572478] [   4957]  1000  4957     2541      803       96
707         0    61440       96             0 make
[   93.573244] [   4958]  1000  4958     2541      750       96
654         0    53248       48             0 make
[   93.574016] [   4960]  1000  4960     2565      753       96
657         0    65536       48             0 make
[   93.674651] [   4961]  1000  4961     2538      837      144
693         0    53248        0             0 make
[   93.675446] [   4962]  1000  4962     2569      845      192
653         0    69632        0             0 make
[   93.676220] [   4963]  1000  4963     2567      852      192
660         0    57344        0             0 make
[   93.676946] [   4964]  1000  4964     2536      901      192
709         0    65536        0             0 make
[   93.677679] [   4965]  1000  4965     2540      887      192
695         0    61440        0             0 make
[   93.678377] [   4967]  1000  4967     2563      853      144
709         0    61440       48             0 make
[   93.679168] [   4969]  1000  4969     2538      836      144
692         0    57344       48             0 make
[   93.679937] [   4973]  1000  4973     2535      827      144
683         0    61440       48             0 make
[   93.680628] [   4976]  1000  4976     2571      878      192
686         0    57344        0             0 make
[   93.681397] [   4977]  1000  4977     2534      850      192
658         0    53248        0             0 make
[   93.682121] [   4978]  1000  4978     1797      766       48
718         0    49152        0             0 sh
[   93.683272] [   4980]  1000  4980     2540      839      192
647         0    65536       48             0 make
[   93.709270] [   4982]  1000  4982     2539      853      144
709         0    65536        0             0 make
[   93.784725] [   4983]  1000  4983     1798      885       96
789         0    61440        0             0 sh
[   93.785895] [   4984]  1000  4984     2539      878      192
686         0    57344        0             0 make
[   93.786661] [   4986]  1000  4986     2537      863      192
671         0    61440        0             0 make
[   93.787378] [   4988]  1000  4988     2540      824      144
680         0    61440       48             0 make
[   93.788060] [   4989]  1000  4989     2538      792      144
648         0    65536        0             0 make
[   93.788873] [   4990]  1000  4990     1282      810       48
762         0    45056        0             0 gcc

Chris

On Fri, Jun 21, 2024 at 11:48=E2=80=AFPM <yangge1116@126.com> wrote:
>
> From: yangge <yangge1116@126.com>
>
> If a large number of CMA memory are configured in system (for example, th=
e
> CMA memory accounts for 50% of the system memory), starting a virtual
> virtual machine, it will call pin_user_pages_remote(..., FOLL_LONGTERM,
> ...) to pin memory.  Normally if a page is present and in CMA area,
> pin_user_pages_remote() will migrate the page from CMA area to non-CMA
> area because of FOLL_LONGTERM flag. But the current code will cause the
> migration failure due to unexpected page refcounts, and eventually cause
> the virtual machine fail to start.
>
> If a page is added in LRU batch, its refcount increases one, remove the
> page from LRU batch decreases one. Page migration requires the page is no=
t
> referenced by others except page mapping. Before migrating a page, we
> should try to drain the page from LRU batch in case the page is in it,
> however, folio_test_lru() is not sufficient to tell whether the page is
> in LRU batch or not, if the page is in LRU batch, the migration will fail=
.
>
> To solve the problem above, we modify the logic of adding to LRU batch.
> Before adding a page to LRU batch, we clear the LRU flag of the page so
> that we can check whether the page is in LRU batch by folio_test_lru(page=
).
> Seems making the LRU flag of the page invisible a long time is no problem=
,
> because a new page is allocated from buddy and added to the lru batch,
> its LRU flag is also not visible for a long time.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: yangge <yangge1116@126.com>
> ---
>  mm/swap.c | 43 +++++++++++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/mm/swap.c b/mm/swap.c
> index dc205bd..9caf6b0 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -211,10 +211,6 @@ static void folio_batch_move_lru(struct folio_batch =
*fbatch, move_fn_t move_fn)
>         for (i =3D 0; i < folio_batch_count(fbatch); i++) {
>                 struct folio *folio =3D fbatch->folios[i];
>
> -               /* block memcg migration while the folio moves between lr=
u */
> -               if (move_fn !=3D lru_add_fn && !folio_test_clear_lru(foli=
o))
> -                       continue;
> -
>                 folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
>                 move_fn(lruvec, folio);
>
> @@ -255,11 +251,16 @@ static void lru_move_tail_fn(struct lruvec *lruvec,=
 struct folio *folio)
>  void folio_rotate_reclaimable(struct folio *folio)
>  {
>         if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
> -           !folio_test_unevictable(folio) && folio_test_lru(folio)) {
> +           !folio_test_unevictable(folio)) {
>                 struct folio_batch *fbatch;
>                 unsigned long flags;
>
>                 folio_get(folio);
> +               if (!folio_test_clear_lru(folio)) {
> +                       folio_put(folio);
> +                       return;
> +               }
> +
>                 local_lock_irqsave(&lru_rotate.lock, flags);
>                 fbatch =3D this_cpu_ptr(&lru_rotate.fbatch);
>                 folio_batch_add_and_move(fbatch, folio, lru_move_tail_fn)=
;
> @@ -352,11 +353,15 @@ static void folio_activate_drain(int cpu)
>
>  void folio_activate(struct folio *folio)
>  {
> -       if (folio_test_lru(folio) && !folio_test_active(folio) &&
> -           !folio_test_unevictable(folio)) {
> +       if (!folio_test_active(folio) && !folio_test_unevictable(folio)) =
{
>                 struct folio_batch *fbatch;
>
>                 folio_get(folio);
> +               if (!folio_test_clear_lru(folio)) {
> +                       folio_put(folio);
> +                       return;
> +               }
> +
>                 local_lock(&cpu_fbatches.lock);
>                 fbatch =3D this_cpu_ptr(&cpu_fbatches.activate);
>                 folio_batch_add_and_move(fbatch, folio, folio_activate_fn=
);
> @@ -700,6 +705,11 @@ void deactivate_file_folio(struct folio *folio)
>                 return;
>
>         folio_get(folio);
> +       if (!folio_test_clear_lru(folio)) {
> +               folio_put(folio);
> +               return;
> +       }
> +
>         local_lock(&cpu_fbatches.lock);
>         fbatch =3D this_cpu_ptr(&cpu_fbatches.lru_deactivate_file);
>         folio_batch_add_and_move(fbatch, folio, lru_deactivate_file_fn);
> @@ -716,11 +726,16 @@ void deactivate_file_folio(struct folio *folio)
>   */
>  void folio_deactivate(struct folio *folio)
>  {
> -       if (folio_test_lru(folio) && !folio_test_unevictable(folio) &&
> -           (folio_test_active(folio) || lru_gen_enabled())) {
> +       if (!folio_test_unevictable(folio) && (folio_test_active(folio) |=
|
> +           lru_gen_enabled())) {
>                 struct folio_batch *fbatch;
>
>                 folio_get(folio);
> +               if (!folio_test_clear_lru(folio)) {
> +                       folio_put(folio);
> +                       return;
> +               }
> +
>                 local_lock(&cpu_fbatches.lock);
>                 fbatch =3D this_cpu_ptr(&cpu_fbatches.lru_deactivate);
>                 folio_batch_add_and_move(fbatch, folio, lru_deactivate_fn=
);
> @@ -737,12 +752,16 @@ void folio_deactivate(struct folio *folio)
>   */
>  void folio_mark_lazyfree(struct folio *folio)
>  {
> -       if (folio_test_lru(folio) && folio_test_anon(folio) &&
> -           folio_test_swapbacked(folio) && !folio_test_swapcache(folio) =
&&
> -           !folio_test_unevictable(folio)) {
> +       if (folio_test_anon(folio) && folio_test_swapbacked(folio) &&
> +           !folio_test_swapcache(folio) && !folio_test_unevictable(folio=
)) {
>                 struct folio_batch *fbatch;
>
>                 folio_get(folio);
> +               if (!folio_test_clear_lru(folio)) {
> +                       folio_put(folio);
> +                       return;
> +               }
> +
>                 local_lock(&cpu_fbatches.lock);
>                 fbatch =3D this_cpu_ptr(&cpu_fbatches.lru_lazyfree);
>                 folio_batch_add_and_move(fbatch, folio, lru_lazyfree_fn);
> --
> 2.7.4
>
>

