Return-Path: <stable+bounces-76733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF0397C62D
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 10:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8B4281FC8
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 08:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DB9199243;
	Thu, 19 Sep 2024 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="V8K3sKK6"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FBEFC0E
	for <stable@vger.kernel.org>; Thu, 19 Sep 2024 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735668; cv=none; b=T0GtRIacZ5yhICIrAid8LzJSZYazpzBr9mFxluaQoaWqRz0xIYRr2dVvRWixjYmN+ZnThKR77+YRNij6NYYNJPTSYScb5YjdaAYXoZADoPgZf1rRZPahu6u5YxZl+tL/gssaTAB0jyPaUsck+62+o7aV4G6w3tiv9hH3DDBnDdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735668; c=relaxed/simple;
	bh=oUpxxtUV3Ftv+ypTgLvU88End0w9Jjkb6DhB98wYzYw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kas9dt89aM962SkB4TBVTjelu0UxQ8GnSfXOifrCfgTxEtit7REPWriAbDuxKdapSxZldllBPAoUc96q5YKsUaglX6IbvlbPbFSPo4wiXR4i0FeW6jrSr7gkAKRIR8sk0fwysR1I+6zo+27A21A8nP2SkyYz7nZlWlIsPspuKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=V8K3sKK6; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [10.10.165.11])
	by mail.ispras.ru (Postfix) with ESMTPSA id B85F040B278B;
	Thu, 19 Sep 2024 08:47:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B85F040B278B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1726735661;
	bh=LHKpVziHOMxXCUDZFv5y7nePzbU+Q5qnBd7yll61uQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=V8K3sKK67XQQva+GPyIYurfLkOPL9yu4erDa6pndUE9Rny+x4uope7TIDg8xM/Hv5
	 d3LK2AV6lIC1cIhiZflKUlWaWiZs/Cc6J2UP4jvOlFPKujQFwl76DeUfOG4eynl41S
	 wJw2L9eYT2pQGTGPP8SCVDUGWCVMOX2Yw3tSJ8e8=
Date: Thu, 19 Sep 2024 11:47:34 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Greg Thelen <gthelen@google.com>
Cc: Chen Ridong <chenridong@huawei.com>, Tejun Heo <tj@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, lvc-project@linuxtesting.org,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Subject: Re: 5.10.225 stable kernel cgroup_mutex not held assertion failure
Message-ID: <20240919-5e2d9ccca61f5022e0b574af-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xr93ikus2nd1.fsf@gthelen-cloudtop.c.googlers.com>

Greg Thelen wrote:
> Linux stable v5.10.226 suffers a lockdep warning when accessing
> /proc/PID/cpuset. cset_cgroup_from_root() is called without cgroup_mutex
> is held, which causes assertion failure.
> 
> Bisect blames 5.10.225 commit 688325078a8b ("cgroup/cpuset: Prevent UAF
> in proc_cpuset_show()"). I've have not easily reproduced the problem
> that this change fixes, so I'm not sure if it's best to revert the fix
> or adapt it to meet the 5.10 locking expectations.
> 
> The lockdep complaint:
> 
> $ cat /proc/1/cpuset
> $ dmesg
> [  198.744891] ------------[ cut here ]------------
> [  198.744918] WARNING: CPU: 4 PID: 9301 at kernel/cgroup/cgroup.c:1395  
> cset_cgroup_from_root+0xb2/0xd0
> [  198.744957] RIP: 0010:cset_cgroup_from_root+0xb2/0xd0
> [  198.744960] Code: 02 00 00 74 11 48 8b 09 48 39 cb 75 eb eb 19 49 83 c6  
> 10 4c 89 f0 48 85 c0 74 0d 5b 41 5e c3 48 8b 43 60 48 85 c0 75 f3 0f 0b  
> <0f> 0b 83 3d 69 01 ee 01 00 0f 85 78 ff ff ff eb 8b 0f 0b eb 87 66
> [  198.744962] RSP: 0018:ffffb492608a7ce8 EFLAGS: 00010046
> [  198.744977] RAX: 0000000000000000 RBX: ffffffff8f4171b8 RCX:  
> cc949de848c33e00
> [  198.744979] RDX: 0000000000001000 RSI: ffffffff8f415450 RDI:  
> ffff92e5417c4dc0
> [  198.744981] RBP: ffff9303467e3f00 R08: 0000000000000008 R09:  
> ffffffff9122d568
> [  198.744983] R10: ffff92e5417c4380 R11: 0000000000000000 R12:  
> ffff92e3d9506000
> [  198.744984] R13: 0000000000000000 R14: ffff92e443a96000 R15:  
> ffff92e3d9506000
> [  198.744987] FS:  00007f15d94ed740(0000) GS:ffff9302bf500000(0000)  
> knlGS:0000000000000000
> [  198.744988] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  198.744990] CR2: 00007f15d94ca000 CR3: 00000002816ca003 CR4:  
> 00000000001706e0
> [  198.744992] Call Trace:
> [  198.744996]  ? __warn+0xcd/0x1c0
> [  198.745000]  ? cset_cgroup_from_root+0xb2/0xd0
> [  198.745008]  ? report_bug+0x87/0xf0
> [  198.745015]  ? handle_bug+0x42/0x80
> [  198.745017]  ? exc_invalid_op+0x16/0x70
> [  198.745021]  ? asm_exc_invalid_op+0x12/0x20
> [  198.745030]  ? cset_cgroup_from_root+0xb2/0xd0
> [  198.745034]  ? cset_cgroup_from_root+0x28/0xd0
> [  198.745038]  cgroup_path_ns_locked+0x23/0x50
> [  198.745044]  proc_cpuset_show+0x115/0x210
> [  198.745049]  proc_single_show+0x4a/0xa0
> [  198.745056]  seq_read_iter+0x14d/0x400
> [  198.745063]  seq_read+0x103/0x130
> [  198.745074]  vfs_read+0xea/0x320
> [  198.745078]  ? do_user_addr_fault+0x25b/0x390
> [  198.745085]  ? do_user_addr_fault+0x25b/0x390
> [  198.745090]  ksys_read+0x70/0xe0
> [  198.745096]  do_syscall_64+0x2d/0x40
> [  198.745099]  entry_SYSCALL_64_after_hwframe+0x61/0xcb

Hello,

we've also encountered this problem. The thing is that commit 688325078a8b
("cgroup/cpuset: Prevent UAF in proc_cpuset_show()") relies on the RCU
synchronization changes introduced by commit d23b5c577715 ("cgroup: Make
operations on the cgroup root_list RCU safe") which wasn't backported to
5.10 as it couldn't be cleanly applied there. That commit converted access
to the root_list synchronization from depending on cgroup mutex to be
RCU-safe.

5.15 also has this problem, while 6.1 and later stables have the backport
of this RCU-changing commit so they are not affected. As mentioned by
Michal here:
https://lore.kernel.org/stable/xrc6s5oyf3b5hflsffklogluuvd75h2khanrke2laes3en5js2@6kvpkcxs7ufj/

In the next email I'll send the adapted to 5.10/5.15 commit along with its
upstream-fix to avoid build failure in some situations. Would be nice if
you give them a try. Thanks!

