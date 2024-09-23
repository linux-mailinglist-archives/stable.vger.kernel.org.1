Return-Path: <stable+bounces-76886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BF797E7E4
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 10:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861FC281C62
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 08:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EAE19343E;
	Mon, 23 Sep 2024 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cD1t5cr6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2260619409E
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081442; cv=none; b=QILM1p58kRxi5Fkbx+Tmxk1dtJa9u6vuvMqyexn1knziHTBiOK1Hp/QkCnmnt0Sf9Jq7M0447Y2C6/m2RE+FRzmqph+t/fDyt1sMHqmCXC9sO0P7ToPnyan6E9JN60HPjrgbqm+6l5XgHRa3eCNWpsLjLswWcLYcbZujAnrMXXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081442; c=relaxed/simple;
	bh=XbiJTxstb2TKquC/befwcMAMjPw/EN8TCmrYDdvf5fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqGhdYfuBu4eMwvlqd/kpTbxCBaqukomb7n1l+mFVq3VADtsFF2c3OGEaKsEaZhg8DacLc/29xGePEIkcIAMjfX1tdAUbRVgj6qXalW5qGc7pqwqQomhSxmttvQ0yxBKWQxUzNtxb0udNVjf92yYS1NQv/WzJnxei2hkbbpSFWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cD1t5cr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71954C4CEC4;
	Mon, 23 Sep 2024 08:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727081441;
	bh=XbiJTxstb2TKquC/befwcMAMjPw/EN8TCmrYDdvf5fQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cD1t5cr6MuHSh35ccGjV9ZCD8kLd1mFCKrON89IMnItxepo9H3rV7cTu7uxKYbm/6
	 thp2pHhV8n1ZSD3N7cpeVQFFx3cEj82lXDaQpX0Ajfqkd0lYNeF8AlYQ6UV+VNMk95
	 5Rsb4M3Id15d3flDnqIJDm+qAwR3xnVFq1jtsXKL165Q3oad9pogTKEEaUOEKr3iGs
	 NLrvv7zSAeYlS6vr2WoEOz6UtvEkXKFdDEGhwC7QgeyBucrVwNpsBt1XIwmFwp8gTO
	 wwKmNHPQzZIJSEVmmbSDefR4tH83ulSxtLciVtDj2Ja+DrXbDKsgtMnl48+Gz6ps5a
	 PggYQloroHVXQ==
Date: Mon, 23 Sep 2024 04:50:40 -0400
From: Sasha Levin <sashal@kernel.org>
To: Greg Thelen <gthelen@google.com>
Cc: Chen Ridong <chenridong@huawei.com>, Tejun Heo <tj@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: Re: 5.10.225 stable kernel cgroup_mutex not held assertion failure
Message-ID: <ZvEr4IGyZ2x9FRU1@sashalap>
References: <xr93ikus2nd1.fsf@gthelen-cloudtop.c.googlers.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xr93ikus2nd1.fsf@gthelen-cloudtop.c.googlers.com>

On Wed, Sep 18, 2024 at 11:01:30PM -0700, Greg Thelen wrote:
>Linux stable v5.10.226 suffers a lockdep warning when accessing
>/proc/PID/cpuset. cset_cgroup_from_root() is called without cgroup_mutex
>is held, which causes assertion failure.
>
>Bisect blames 5.10.225 commit 688325078a8b ("cgroup/cpuset: Prevent UAF
>in proc_cpuset_show()"). I've have not easily reproduced the problem
>that this change fixes, so I'm not sure if it's best to revert the fix
>or adapt it to meet the 5.10 locking expectations.
>
>The lockdep complaint:
>
>$ cat /proc/1/cpuset
>$ dmesg
>[  198.744891] ------------[ cut here ]------------
>[  198.744918] WARNING: CPU: 4 PID: 9301 at 
>kernel/cgroup/cgroup.c:1395 cset_cgroup_from_root+0xb2/0xd0
>[  198.744957] RIP: 0010:cset_cgroup_from_root+0xb2/0xd0
>[  198.744960] Code: 02 00 00 74 11 48 8b 09 48 39 cb 75 eb eb 19 49 
>83 c6 10 4c 89 f0 48 85 c0 74 0d 5b 41 5e c3 48 8b 43 60 48 85 c0 75 
>f3 0f 0b <0f> 0b 83 3d 69 01 ee 01 00 0f 85 78 ff ff ff eb 8b 0f 0b eb 
>87 66
>[  198.744962] RSP: 0018:ffffb492608a7ce8 EFLAGS: 00010046
>[  198.744977] RAX: 0000000000000000 RBX: ffffffff8f4171b8 RCX: 
>cc949de848c33e00
>[  198.744979] RDX: 0000000000001000 RSI: ffffffff8f415450 RDI: 
>ffff92e5417c4dc0
>[  198.744981] RBP: ffff9303467e3f00 R08: 0000000000000008 R09: 
>ffffffff9122d568
>[  198.744983] R10: ffff92e5417c4380 R11: 0000000000000000 R12: 
>ffff92e3d9506000
>[  198.744984] R13: 0000000000000000 R14: ffff92e443a96000 R15: 
>ffff92e3d9506000
>[  198.744987] FS:  00007f15d94ed740(0000) GS:ffff9302bf500000(0000) 
>knlGS:0000000000000000
>[  198.744988] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[  198.744990] CR2: 00007f15d94ca000 CR3: 00000002816ca003 CR4: 
>00000000001706e0
>[  198.744992] Call Trace:
>[  198.744996]  ? __warn+0xcd/0x1c0
>[  198.745000]  ? cset_cgroup_from_root+0xb2/0xd0
>[  198.745008]  ? report_bug+0x87/0xf0
>[  198.745015]  ? handle_bug+0x42/0x80
>[  198.745017]  ? exc_invalid_op+0x16/0x70
>[  198.745021]  ? asm_exc_invalid_op+0x12/0x20
>[  198.745030]  ? cset_cgroup_from_root+0xb2/0xd0
>[  198.745034]  ? cset_cgroup_from_root+0x28/0xd0
>[  198.745038]  cgroup_path_ns_locked+0x23/0x50
>[  198.745044]  proc_cpuset_show+0x115/0x210
>[  198.745049]  proc_single_show+0x4a/0xa0
>[  198.745056]  seq_read_iter+0x14d/0x400
>[  198.745063]  seq_read+0x103/0x130
>[  198.745074]  vfs_read+0xea/0x320
>[  198.745078]  ? do_user_addr_fault+0x25b/0x390
>[  198.745085]  ? do_user_addr_fault+0x25b/0x390
>[  198.745090]  ksys_read+0x70/0xe0
>[  198.745096]  do_syscall_64+0x2d/0x40
>[  198.745099]  entry_SYSCALL_64_after_hwframe+0x61/0xcb

I'll queue up d23b5c577715 ("cgroup: Make operations on the cgroup
root_list RCU safe") onto 5.15/5.10. Thanks for reporting!

-- 
Thanks,
Sasha

