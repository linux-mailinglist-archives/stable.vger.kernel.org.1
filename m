Return-Path: <stable+bounces-233236-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMjnINIj0Gmx3wYAu9opvQ
	(envelope-from <stable+bounces-233236-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 22:32:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA543982E5
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 22:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82D6F3045A86
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 20:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE1330C606;
	Fri,  3 Apr 2026 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="N/62QJNX"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454DD30C35E
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248248; cv=pass; b=THsKy3u3TXZvoZk1a2gz7D6hqzrYGGS3hcbKe+QRdASrZTMY7cQVHrKVdfFEGMzXtVi3BHn3zlLKiN8WbQZL2vrDiukLOyz4gVtofTM6chMhD9KnKC6EsY6D2MGLsatPFMdP70Za70C7uxWWhL53/gkhSY39v6b8yoQ6okl+Swo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248248; c=relaxed/simple;
	bh=D1et5RCA1jzIwpYlHIlSDZjej48Q0Lzgq2PDQgP+ZYs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mlfYBLY3w8K22MXxrukKWGwwjymTCOdxb/GysIdZvajM02PDikpl1gFTPhRHt4GI6UyYnYIK1PThVrpS/1OEzUB/XmtlKuhe8a8G66FoemwgRJSiMRaX3l8Q/jIQ0M9jCSe9fqTpiHJXPsqv+01/L6Ox5pSPe2aYtA17qdfygsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=N/62QJNX; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8d00cf835b7so291944785a.1
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 13:30:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775248246; cv=none;
        d=google.com; s=arc-20240605;
        b=bMHtY6EwmPiLbG364U1wc8JHQ6lCVnPIhfZrnC27NhCYi35JAOTUk2Q3aQI6t5QSjG
         saQE3jvQ1rB1si/HUpCdphKqRA13uKbtmRaLxbYMBdAoKib6dPT4tJNexsFQOLmcQbBY
         PO/LzkeHwC3STZWfXNRNdQwfbZUl2tUKkRAmoK8ffEve3Te5p4gIyHiIcG8Rpu88FbBh
         BQvdvXc6P43LBCJaaLSb9HS8TD2C2bW2+EWeiMfPL8mHBS2LdCQGVS964vs28TXH7yaU
         Wj9h85Gpj893stAyhU+8Mpk1h7qrroEFwLKpSiHkVln330fo62tGr+KWOW61cPctY/yB
         ERmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ST0zzOSohWjTo3p+FB67/kv4Uz65dzp2k3hj3xp/M+g=;
        fh=n9+LHgxUML/iwfnzYVR1BtM8PDHFYAbfF7gJQuyyGzE=;
        b=CKBTNzbqhO28A6vxlS1Y/UDYk2kr/TkoAxMAX7r206IvL90rCYvNdqdOejRdbE3xYK
         4sDbE3cjp5jzFX9AwWfJlzbT9IlzsK/QedDwRuXUDQprlnLZEwfXs7Fxyei+nc9ym3qH
         9PwT0TiUCM3v9igI331Fc16hXWMjEzKULNhM7k6pegxeZACCljD1wngEPYORMCSzdb+F
         ybaGPiyo4m8Tkq6CW2e/zOii4nEZ3n0uYTN78cGGQvKaCfOgKnd+Ce10e3TLK5tkHM8L
         70gemsla89eOgKrpfzkF6smVLXVzKB1riTEKSA3kMnh4hC0SSZZD8xDbn94PvT7JABjQ
         NBhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1775248246; x=1775853046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ST0zzOSohWjTo3p+FB67/kv4Uz65dzp2k3hj3xp/M+g=;
        b=N/62QJNXNfyOuHubmlaf0wHG3J1ziecqkYaWCptqM6vz3Ur8MLKsFFzQf5FEhV+r6c
         Xj0vobzhMfNXOsGAdrWjs38gcG8v+Dq0GT87fdtts1oCGcO1kwc5lhf1tk8hwzAt141S
         ykeNPHhlDMOCkgmlW74gq2WIBxoEdIDQX7X4qpXheQbr7wKb+0/GYOwEv9NitXnLOieY
         lYGNh+ejvARmdIy7yn1h3VsLOsju8Bk8ktKDOTIo+IoJHBp/zKK5ojYIRyCw4bh0mCzZ
         OMnYyBHyy+/AioqkCXampgnxB0Alxr7TqTcGhcEfPp+GsqQTQsVHH9pJeVdI4hqxyexQ
         EnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248246; x=1775853046;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ST0zzOSohWjTo3p+FB67/kv4Uz65dzp2k3hj3xp/M+g=;
        b=ep05Lg5mf+wwePthl63mG+hIqQvL6rjsFy0DZN2NaAOJ23/3QYP+zHi5kxqq9VLTaj
         3RGQ8aS2Pzbnt/fKQMhJD2At/rzUKuYzkA8tCP8lnxtMQemEjKpyfQrkZ2kVwcXO63zE
         qu8POULy3IFj/A+peLbpJx0mJN1acXnTyqNWqoRgU/BNy4Cm/SKeqkTVIGG9LCHWRUpk
         /JumNs1ny3ZL/H40X/Bwd/BpG6Qhm8BfSXSwUJexOJCzxTIY4FIwuouNxOWp32phPFyN
         d3uc5mX2IcWKUqcpiTEi5G01jtg5eXtIgIeMe57cVYv0fbKsSkZV6wY+nWdfj10LsHyp
         U8mg==
X-Gm-Message-State: AOJu0YwEQKjyv/1VRA7JAQPsT6P3vt4Wg6HjCpbvqiHpm55Rg+oswsbF
	zvDih6C/XI9WZTrIHIEuDSWlxW1JgUmma8zzcwG9xgs5AvG1MP86HlXQiS14s0yJZTKeuOZPEX9
	kdDMgmXf+ZPhZ5vh7ki9u67tkEylUrQ1neuf1J6mwL/hevsbEnq4UzMs=
X-Gm-Gg: ATEYQzwr2UDi5YapQ/gAnVM93bwGFAqvlV0AQ3MOmOjRWPrYFmPEDhAKky/WcY3a86b
	yN3TudBTlf6SsTt0JOOEkDtDRhhiSQo7uJRsokyq2N3syQvJNvlL+M8WSDdClvK2nM6U+Dmo5Cu
	UuhCe6HdP/skjxnUeMJ4AsaXZGXXpcwMOdVmJzdbVzRq0/ikycif4c75ATULYjxknTWo+AATmW2
	qmmmdw5alcfQuueRA2OGYu5c3Fs4Lv3Y+yikRiF/GdJZqBw7JTZtYvnLjGABe/yZXUc808KVcAD
	Ck5nm8Pe
X-Received: by 2002:a05:620a:408e:b0:8cf:c5c3:adfb with SMTP id
 af79cd13be357-8d41eefafc9mr538703085a.70.1775248246010; Fri, 03 Apr 2026
 13:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Fri, 3 Apr 2026 16:30:35 -0400
X-Gm-Features: AQROBzAECtiy-_PaWREyswuNl7w8YRkU1vt3vr5RGKMRXD4DhCH-Zti37JvkDPg
Message-ID: <CAOBMUvhG4DQDiEarc_P132=a+zGN4hySrNPYigUf6qC2Kh9iqg@mail.gmail.com>
Subject: Backport request for fda024fb64769e9d6b3916d013c78d6b189129f8 to stable/6.18.y
To: stable@vger.kernel.org
Cc: pmladek@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ciq.com,reject];
	R_DKIM_ALLOW(-0.20)[ciq.com:s=s1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233236-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ciq.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmastbergen@ciq.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ciq.com:dkim]
X-Rspamd-Queue-Id: CBA543982E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Please consider applying the following mainline commit to the 6.18.y
stable tree:

 commit fda024fb64769e9d6b3916d013c78d6b189129f8
 kallsyms: clean up modname and modbuildid initialization in
kallsyms_lookup_buildid()

The patch applies cleanly to 6.18.21

kallsyms_lookup_buildid() only initializes *modname and *modbuildid
inside the is_ksym_addr() branch, leaving them uninitialized for the
BPF/module/ftrace path.  When a backtrace entry resolves through the
BPF path, __sprint_symbol() passes the uninitialized modname pointer
to sprintf(" [%s", modname).  This consistently causes a kernel panic
on aarch64 when running the sched_ext:select_cpu_dispatch_dbl_dsp
kselftest.  Presumably any sched_ext workload that triggers a scheduler
error could hit this.

Reproducible by running:

    make -C tools/testing/selftests/sched_ext run_tests

on aarch64 (tested on QEMU running 6.18.19).

CCing the original commit author in case they have any
thoughts

Thanks,
Brett

[panic log follows]

[  7225.950942] sched_ext: select_cpu_dispatch_dbl_dsp:
kdamond.0[7189] already direct-dispatched
[  7225.951029]    scx_dsq_insert_commit+0x128/0x138
[  7225.951086]    scx_bpf_dsq_insert+0x74/0xc8
[  7225.951466] Unable to handle kernel paging request at virtual
address 007265736e695f71
[  7225.951493] Mem abort info:
[  7225.951506]   ESR = 0x0000000096000004
[  7225.951533]   EC = 0x25: DABT (current EL), IL = 32 bits
[  7225.951550]   SET = 0, FnV = 0
[  7225.951562]   EA = 0, S1PTW = 0
[  7225.951579]   FSC = 0x04: level 0 translation fault
[  7225.951613]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  7225.951645]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  7225.951662]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  7225.951700] [007265736e695f71] address between user and kernel
address ranges
[  7225.951871] Internal error: Oops: 0000000096000004 [#1] SMP
[  7225.953839] Modules linked in: nft_tproxy nf_tproxy_ipv6
nf_tproxy_ipv4 nf_defrag_ipv6
nf_defrag_ipv4 nft_socket nf_socket_ipv4 nf_socket_ipv6 nf_tables
nfnetlink sch_netem
hsr can_raw can vcan can_dev xfs uhid gpio_sim dev_sync_probe loop
dummy cls_matchall
8021q garp mrp ipvlan macvlan esp4_offload esp4 nlmon act_gact
cls_flower sch_ingress
bridge stp llc bonding tls veth netconsole snd_timer snd soundcore virtio_net
net_failover failover fuse ext4 crc16 mbcache jbd2 ghash_ce virtio_blk
[last unloaded: ptp_mock]
[  7225.955788] CPU: 0 UID: 0 PID: 167908 Comm: sched_ext_helpe Not
tainted 6.18.19-_brett__ciq-6.18.y-cbbf63788+ #1
PREEMPT(voluntary)
[  7225.956092] Hardware name: QEMU QEMU Virtual Machine, BIOS
edk2-20250221-8.fc42 02/21/2025
[  7225.956481] Sched_ext: select_cpu_dispatch_dbl_dsp (disabling)
[  7225.956563] pstate: 004000c5 (nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  7225.956908] pc : string+0x5c/0x118
[  7225.957055] lr : vsnprintf+0x1b0/0x5a8
[  7225.957198] sp : ffff80008dd0b460
[  7225.957299] x29: ffff80008dd0b460 x28: ffff80008177db6c x27:
0000000000000405
[  7225.957610] x26: ffff80008dd0b66a x25: ffff80008177db6c x24:
00000000ffffffd8
[  7225.957866] x23: ffff80008147a560 x22: ffff80008dd0b590 x21:
0000000000000004
[  7225.958143] x20: ffff80010dd0b667 x19: 0000000000000005 x18:
00000000ffffffff
[  7225.958336] x17: 2079646165726c61 x16: 205d393831375b30 x15:
ffff80010dd0b65d
[  7225.958580] x14: 0000000000000001 x13: ffff80008dd0b666 x12:
0101010101010101
[  7225.958783] x11: 7f7f7f7f7f7f7f7f x10: 000000000000005b x9 :
0000000000000002
[  7225.958947] x8 : 00000000ffffffff x7 : ffffffffffffffff x6 :
ffff80010dd0b667
[  7225.959148] x5 : 00000000ffffffff x4 : 0000000000000000 x3 :
ffffffffffff0a00
[  7225.959344] x2 : 747265736e695f71 x1 : 0000000000000000 x0 :
ffff80008dd0b66a
[  7225.959612] Call trace:
[  7225.959772]  string+0x5c/0x118 (P)
[  7225.959933]  vsnprintf+0x1b0/0x5a8
[  7225.960058]  sprintf+0x64/0x90
[  7225.960238]  __sprint_symbol.constprop.0+0x90/0x120
[  7225.960378]  sprint_symbol+0x20/0x38
[  7225.960998]  symbol_string+0x60/0x150
[  7225.961186]  pointer+0x84/0x4f8
[  7225.961319]  vsnprintf+0x2cc/0x5a8
[  7225.961443]  vprintk_store+0x180/0x4f0
[  7225.961575]  vprintk_emit+0xd8/0x3a8
[  7225.961697]  vprintk_default+0x40/0x58
[  7225.961869]  vprintk+0x3c/0x80
[  7225.961990]  _printk+0x68/0xa0
[  7225.962114]  stack_trace_print+0x54/0x88
[  7225.962280]  scx_disable_workfn+0x458/0x5d0
[  7225.962414]  kthread_worker_fn+0x100/0x2d0
[  7225.962534]  kthread+0x128/0x138
[  7225.962693]  ret_from_fork+0x10/0x20
[  7225.962905] Code: 91000400 110004e1 eb08009f 540000c0 (38646845)
[  7225.963431] ---[ end trace 0000000000000000 ]---
[  7225.963815] Kernel panic - not syncing: Oops: Fatal exception
[  7225.964126] SMP: stopping secondary CPUs
[  7225.964578] Kernel Offset: 0x140000 from 0xffff800080000000
[  7225.964724] PHYS_OFFSET: 0x40000000
[  7225.964822] CPU features: 0x100000,0000e000,40046280,0401720b
[  7225.964967] Memory Limit: none
[  7225.965217] Rebooting in 180 seconds..

