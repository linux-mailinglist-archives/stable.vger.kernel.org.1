Return-Path: <stable+bounces-61384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FF393C21E
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456FE1C20B12
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8A81741F8;
	Thu, 25 Jul 2024 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ueufmoHM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4973919938A
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910712; cv=none; b=MgxkvdcC131fWWaBVaKqSy6NnGO8uLC3v4M1yx0M6a2M+7X3tf3fFJNnD96n5KwZRgPewpylMMj3WVMpE61FyZ3O88DKm+6n1h1/Ow0WopKX+KQ7HjlScHIcZS28wrbkn7WJhgwd/epY7FSDnsk+QCyJHvySYxtWliZXkzafRJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910712; c=relaxed/simple;
	bh=q8dQ7ETyqBFWaSOlKdzpCjVoSgWBT+FwznsIPfvFIZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXhX6M9PENs2MUe/xIIAtg1dg2W39l8uej6OW+L/w9qJiZpoDTccYpj8GUKtm5i9Ri2n0MenOssaQLoUdmcbu3UPSHwLU016zgbvTmebM7sMouBHJdMMFxZq+Ug1+oDNccHCI+bCKt1doQkvv59RtAfzI1ffsgJCxIX9tBCN4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ueufmoHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03E0C116B1;
	Thu, 25 Jul 2024 12:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721910712;
	bh=q8dQ7ETyqBFWaSOlKdzpCjVoSgWBT+FwznsIPfvFIZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ueufmoHMwqyi5NazNpOnEL9M/rOxvp2l8K6SH7yqqGY+8//wDGsJOLFPYfSAznY2A
	 SwvEllFO6I1ZaMsZIxVDgaQk/16eD3xcc/8XLK42U1TebU0EniPBuHeUvaDerVpT35
	 MU/LmkpV/G20qqq7oKiHo5uAqSPL5Pk/qFo6WgwQ=
Date: Thu, 25 Jul 2024 14:31:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	Christoph Paasch <cpaasch@apple.com>,
	Eric Dumazet <edumazet@google.com>, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2 4.19 5.4 5.10 5.15] net: relax socket state check at
 accept time.
Message-ID: <2024072534-tarantula-excusably-fc15@gregkh>
References: <20240725093603.2812851-1-kniv@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725093603.2812851-1-kniv@yandex-team.ru>

On Thu, Jul 25, 2024 at 12:36:03PM +0300, Nikolay Kuratov wrote:
> [ Upstream commit 26afda78cda3da974fd4c287962c169e9462c495 ]
> 
> Christoph reported the following splat:
> 
> WARNING: CPU: 1 PID: 772 at net/ipv4/af_inet.c:761 __inet_accept+0x1f4/0x4a0
> Modules linked in:
> CPU: 1 PID: 772 Comm: syz-executor510 Not tainted 6.9.0-rc7-g7da7119fe22b #56
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
> RIP: 0010:__inet_accept+0x1f4/0x4a0 net/ipv4/af_inet.c:759
> Code: 04 38 84 c0 0f 85 87 00 00 00 41 c7 04 24 03 00 00 00 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 ec b7 da fd <0f> 0b e9 7f fe ff ff e8 e0 b7 da fd 0f 0b e9 fe fe ff ff 89 d9 80
> RSP: 0018:ffffc90000c2fc58 EFLAGS: 00010293
> RAX: ffffffff836bdd14 RBX: 0000000000000000 RCX: ffff888104668000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: dffffc0000000000 R08: ffffffff836bdb89 R09: fffff52000185f64
> R10: dffffc0000000000 R11: fffff52000185f64 R12: dffffc0000000000
> R13: 1ffff92000185f98 R14: ffff88810754d880 R15: ffff8881007b7800
> FS:  000000001c772880(0000) GS:ffff88811b280000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fb9fcf2e178 CR3: 00000001045d2002 CR4: 0000000000770ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  inet_accept+0x138/0x1d0 net/ipv4/af_inet.c:786
>  do_accept+0x435/0x620 net/socket.c:1929
>  __sys_accept4_file net/socket.c:1969 [inline]
>  __sys_accept4+0x9b/0x110 net/socket.c:1999
>  __do_sys_accept net/socket.c:2016 [inline]
>  __se_sys_accept net/socket.c:2013 [inline]
>  __x64_sys_accept+0x7d/0x90 net/socket.c:2013
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x58/0x100 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x4315f9
> Code: fd ff 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 ab b4 fd ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffdb26d9c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002b
> RAX: ffffffffffffffda RBX: 0000000000400300 RCX: 00000000004315f9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 00000000006e1018 R08: 0000000000400300 R09: 0000000000400300
> R10: 0000000000400300 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000040cdf0 R14: 000000000040ce80 R15: 0000000000000055
>  </TASK>
> 
> The reproducer invokes shutdown() before entering the listener status.
> After commit 94062790aedb ("tcp: defer shutdown(SEND_SHUTDOWN) for
> TCP_SYN_RECV sockets"), the above causes the child to reach the accept
> syscall in FIN_WAIT1 status.
> 
> Eric noted we can relax the existing assertion in __inet_accept()
> 
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/490
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Fixes: 94062790aedb ("tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets")
> Link: https://lore.kernel.org/r/23ab880a44d8cfd967e84de8b93dbf48848e3d8c.1716299669.git.pabeni@redhat.com
> Link: https://lore.kernel.org/linux-cve-announce/2024062136-CVE-2024-36484-375b@gregkh
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> ---
> Changes in v2:
> - restore Signed-off-by tag with original author Paolo Abeni <pabeni@redhat.com>

You still lost the original authorship of the commit :(

I fixed it up by hand...

greg k-h

