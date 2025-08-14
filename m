Return-Path: <stable+bounces-169633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E306B270B5
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 23:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A6456302D
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 21:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B3D2741A0;
	Thu, 14 Aug 2025 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intra2net.com header.i=@intra2net.com header.b="chuH0orP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.intra2net.com (smtp.intra2net.com [193.186.7.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFEA2550D8
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.186.7.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206359; cv=none; b=ZnE3j70ztiNjhe6JwvF4KpZ/CC23SxGG5TNiSkQf5X/fWr4owLLm0FzUMRU7mQejo1dvnNQdYZ0NdLaIB0Q9YucLSv4R3+w6R+evzeCu0A2k3sqLbA+utZcw39qUsmrvtHjnxnho4Q3f3Rhla1umpZKinTOiGZJmUcL6smUfiXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206359; c=relaxed/simple;
	bh=xCPsJpDKPj91rotcjidTWpVxvm5Hal4jeaGObio8uoM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NVgdxM0osEoHJ54rLoArVDecWuuXPpZu4j7P5wdSOzMHyDVofsR9k88MFfegWB0SydHma6K2Y+Ph3jSHOhEQIQ8B3FncGwiSxgj0OMaV3rStk5WpJvBiEjkhDgMFSrslp1DDeJHUznj6MB47X+lLhrZ/GuvUsjqfpLe0HUcwlVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intra2net.com; spf=none smtp.mailfrom=intra2net.com; dkim=pass (2048-bit key) header.d=intra2net.com header.i=@intra2net.com header.b=chuH0orP; arc=none smtp.client-ip=193.186.7.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intra2net.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=intra2net.com
Received: from mail.m.i2n (mail.m.i2n [172.17.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.intra2net.com (Postfix) with ESMTPS id 27EF920073;
	Thu, 14 Aug 2025 23:13:34 +0200 (CEST)
Received: from localhost (mail.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id 19DE036C;
	Thu, 14 Aug 2025 23:13:34 +0200 (CEST)
X-Virus-Scanned: by Intra2net Mail Security (AVE=8.3.70.112,VDF=8.20.60.120)
X-Spam-Level: 0
DKIM-Signature: v=1; d=intra2net.com; s=ncc-1701; a=rsa-sha256;
	c=relaxed/relaxed; t=1755206013; x=1756070013; h=Cc:Cc:Content-Disposition:
	Content-Disposition:Content-Type:Content-Type:Date:Date:From:From:
	MIME-Version:MIME-Version:Message-ID:Message-ID:To:To; bh=B2IHiGCXGeMXOHlXmyS
	IirvVqoZ6y6uk7TO5Z7ODjOo=; b=chuH0orP3a5W068CjU3Vo2vSaQa4skwWQ8zDmd4RlnDm6+5s
	A8bcr1r631bdFzzMgRPCaHhm/bJ0C6YROXG7PzYs2GNfJIU1/DY13Bq5edqhMVG9nRcamTlwvSdCD
	pGTNwBn4M9SwUeinHLTmHYLFhz57ART5dTTTUNVMLQcnUH1KOwUexPlUpiZN/RvnrP+kyZ/r/6lmS
	g3H0mBEKBm/XVJb2h542b+mJCEBA1xnGCgJWmKjBjLclpGtyxfXfXJHXpTCR4KwN/6PWH0NN9ZFnI
	/qJJuwF6UtafG58VxzLDMyyixjGNHE3aZCr+QxgbapVCRidnBO1YUJ9cVxuX1mQ==
Received: from localhost (unknown [192.168.12.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.m.i2n (Postfix) with ESMTPS id 157D4C1;
	Thu, 14 Aug 2025 23:13:33 +0200 (CEST)
Date: Thu, 14 Aug 2025 23:13:32 +0200
From: Thomas Jarosch <thomas.jarosch@intra2net.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Lion Ackermann <nnamrec@gmail.com>,
	regressions@lists.linux.dev
Subject: [REGRESSION] 5.15.181 -> 5.15.189: kernel oops in drr_qlen_notify
Message-ID: <20250814211332.lp3ibcp5oopnov46@intra2net.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716

Hi,

I'm seeing a reproducible kernel oops on my home router updating from 5.15.181 to 5.15.189:

kernel BUG at lib/list_debug.c:50!
invalid opcode: 0000 [#1] SMP NOPTI
..
Call Trace:
 <TASK>
 drr_qlen_notify+0x11/0x50 [sch_drr]
 qdisc_tree_reduce_backlog+0x93/0xf0
 drr_graft_class+0x109/0x220 [sch_drr]
 qdisc_graft+0xdd/0x510
 ? qdisc_create+0x335/0x510
 tc_modify_qdisc+0x53f/0x9d0
 rtnetlink_rcv_msg+0x134/0x370
 ? __getblk_gfp+0x22/0x230
 ? rtnl_calcit.isra.38+0x130/0x130
 netlink_rcv_skb+0x4f/0x100
 rtnetlink_rcv+0x10/0x20
 netlink_unicast+0x1d2/0x2a0
 netlink_sendmsg+0x22a/0x480
 ? netlink_broadcast+0x20/0x20
 ____sys_sendmsg+0x25f/0x280
 ? copy_msghdr_from_user+0x5b/0x90
 ___sys_sendmsg+0x77/0xc0
 ? __sys_recvmsg+0x5a/0xb0
 ? do_filp_open+0xc3/0x120
 __sys_sendmsg+0x5d/0xb0
 __x64_sys_sendmsg+0x1a/0x20
 x64_sys_call+0x17f1/0x1c80
 do_syscall_64+0x53/0x80
 ? exit_to_user_mode_prepare+0x2c/0x140
 ? irqentry_exit_to_user_mode+0xe/0x20
 ? irqentry_exit+0x1d/0x30
 ? exc_page_fault+0x1e7/0x610
 ? do_syscall_64+0x5f/0x80
 entry_SYSCALL_64_after_hwframe+0x6c/0xd6
..
RIP: 0010:__list_del_entry_valid.cold.1+0xf/0x69


syzbot reported a similar looking thing here:

[v5.15] BUG: unable to handle kernel paging request in drr_qlen_notify
https://groups.google.com/g/syzkaller-lts-bugs/c/_QJHiMHwfRw/m/2j1nSU1hBgAJ

and here:

"[syzbot] [net?] general protection fault in drr_qlen_notify"
https://www.spinics.net/lists/netdev/msg1105420.html

syzboot bisected it to:

****************************************
commit e269f29e9395527bc00c213c6b15da04ebb35070
Refs: v5.15.186-114-ge269f29e9395
Author:     Lion Ackermann <nnamrec@gmail.com>
AuthorDate: Mon Jun 30 15:27:30 2025 +0200
Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitDate: Thu Jul 10 15:57:46 2025 +0200

    net/sched: Always pass notifications when child class becomes empty

    [ Upstream commit 103406b38c600fec1fe375a77b27d87e314aea09 ]
****************************************

The last line of the commit message mentions:

"This is not a problem after the recent patch series
that made all the classful qdiscs qlen_notify() handlers idempotent."


It looks like the "idempotent" patches are missing from the 5.15 stable series.

Like this one:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/net/sched/sch_drr.c?id=df008598b3a00be02a8051fde89ca0fbc416bd55

I've tried Ubuntu's backport for 5.15:
https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/commit/?id=7804135b4bdd82525f3ca0c4ad139ada6b7662d4

It seems to be identical to:
https://lore.kernel.org/stable/bcf9c70e9cf750363782816c21c69792f6c81cd9.1754751592.git.siddh.raman.pant@oracle.com/

While the kernel didn't oops anymore with the patch applied, the network traffic behaves erratic:
TCP traffic works, ICMP seems "stuck". tcpdump showed no icmp traffic on the ppp device.


Tomorrow I will try if I can reproduce the issue on a test VM.

Anything else I should try?

Thanks in advance,
Thomas

