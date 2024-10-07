Return-Path: <stable+bounces-81482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0722993867
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 22:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BCB01F22D80
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 20:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB1F1DE4F6;
	Mon,  7 Oct 2024 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl8Cm7p8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D371DE4C9
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333488; cv=none; b=dZSwdqCv7bx96JiSyxTafOnRqOFEnkZse5ZpomZ6lZVwiyK0Qcds38VuOxaux+4B5a8WSPUk/bfOJokhZXQBa7Mcoe5E+PO9RVoFlCH9TOFEk/kTIfvTNaT8wK7jAOldcdIvmU6b84uawM5E6OwH4DPKix6OdJz5SSc0xi+tHeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333488; c=relaxed/simple;
	bh=+vaw7NnPKy7C066jwLSdY8mlS1f0W7g9767BntV5JOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuTpN/ZEcxNOze40TW+906i8f7Noz1IRMMkT/EGdMHYC8QeXZy8Og2sa0TFqcg+7BKHXTVlnhY0PYU1svVPTB00FkGeCn03XjblA/tuUIzUi71Z7ydmS++mepskoL8oR25O1z7vjdfCXh/COR1IVNhJxsbaapWMvyqxxkZ6hP8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hl8Cm7p8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CD4C4CEC6;
	Mon,  7 Oct 2024 20:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728333488;
	bh=+vaw7NnPKy7C066jwLSdY8mlS1f0W7g9767BntV5JOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hl8Cm7p85zG1Kb3xSGcWgswVy/Qv2Uu9lM1wIakAdMYXLVDsEiCz1novSVNE4U3wq
	 Z3df2hQm/9VAHOU9NEsM+AJm/FSMCECZE3rBGdrHMtrWCfINXNukpAa3VsQ0+661Rk
	 kZ99ptNU72t7N31GohcplvOKNynfjsMHzXk9KHJGuAhbIF9btk/FiZlJZhj+z1v4j4
	 U+w3l76oWNpjhffiuAaSxaDkrX0mvyVLfN/a1vFFuxGgD8nWRUDSHPVJC02tNA1qby
	 SH9baB4AG8KrInrcDupi6bL9gRy2P0biQ436mNLX8/djzp0TGaiJ4BSuHfd0QjRVw0
	 qwHEAW0k1OphQ==
Date: Mon, 7 Oct 2024 16:38:06 -0400
From: Sasha Levin <sashal@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-stable <stable@vger.kernel.org>
Subject: Re: queue-5.10 panic on shutdown
Message-ID: <ZwRGrj7wteHsLIxQ@sashalap>
References: <9D3ADFBD-00AE-479E-8BFD-E9F5E56D6A26@oracle.com>
 <ZwRCA4RWiow4zTjV@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwRCA4RWiow4zTjV@tissot.1015granger.net>

On Mon, Oct 07, 2024 at 04:18:11PM -0400, Chuck Lever wrote:
>On Mon, Oct 07, 2024 at 10:06:04AM -0400, Chuck Lever wrote:
>> Hi-
>>
>> I've seen the following panic on shutdown for about
>> a week. I've been fighting a stomach bug, so I
>> haven't been able to drill into it until now. I'm
>> bisecting, but thought I should report the issue
>> now.
>>
>>
>> [52704.952919] BUG: unable to handle page fault for address: ffffffffffffffe8
>> [52704.954545] #PF: supervisor read access in kernel mode
>> [52704.955755] #PF: error_code(0x0000) - not-present page
>> [52704.956952] PGD 1c4415067 P4D 1c4415067 PUD 1c4417067 PMD 0  [52704.958291] Oops: 0000 [#1] SMP PTI
>> [52704.959136] CPU: 3 PID: 1 Comm: systemd-shutdow Not tainted 5.10.226-g9ee79287d0d8 #1
>> [52704.960950] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
>> [52704.962902] RIP: 0010:platform_shutdown+0x9/0x50
>> [52704.964010] Code: 02 00 00 ff 75 dd 31 c0 48 83 05 19 c9 b6 02 01 5d c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 47 68 <48> 8b 40 e8 48 85 c0 74 23 55 48 83 ef 10 48 83 05 01 ca b6 02 01
>> [52704.968215] RSP: 0018:ffffaaf780013d88 EFLAGS: 00010246
>> [52704.969426] RAX: 0000000000000000 RBX: ffff8f91478b6018 RCX: 0000000000000000
>> [52704.971095] RDX: 0000000000000001 RSI: ffff8f91478b6018 RDI: ffff8f91478b6010
>> [52704.972758] RBP: ffffaaf780013db8 R08: ffff8f91478b4408 R09: 0000000000000000
>> [52704.974433] R10: 000000000000000f R11: ffffffffa654d2e0 R12: ffffffffa6ba0440
>> [52704.976083] R13: ffff8f91478b6010 R14: ffff8f91478b6090 R15: 0000000000000000
>> [52704.977765] FS:  00007f0f126e6b80(0000) GS:ffff8f92b7d80000(0000) knlGS:0000000000000000
>> [52704.979653] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [52704.981008] CR2: ffffffffffffffe8 CR3: 00000001501be006 CR4: 0000000000170ee0
>> [52704.982697] Call Trace:
>> [52704.983309]  ? show_regs.cold+0x22/0x2f
>> [52704.984223]  ? __die_body+0x28/0xb0
>> [52704.985076]  ? __die+0x39/0x4c
>> [52704.985827]  ? no_context.constprop.0+0x190/0x480
>> [52704.986940]  ? __bad_area_nosemaphore+0x51/0x290
>> [52704.988050]  ? bad_area_nosemaphore+0x1e/0x30
>> [52704.989082]  ? do_kern_addr_fault+0x9a/0xf0
>> [52704.990098]  ? exc_page_fault+0x1d3/0x350
>> [52704.991047]  ? asm_exc_page_fault+0x1e/0x30
>> [52704.992041]  ? platform_shutdown+0x9/0x50
>> [52704.992997]  ? platform_dev_attrs_visible+0x50/0x50
>> [52704.994152]  ? device_shutdown+0x260/0x3d0
>> [52704.995132]  kernel_restart_prepare+0x4e/0x60
>> [52704.996180]  kernel_restart+0x1b/0x50
>> [52704.997070]  __do_sys_reboot+0x24d/0x330
>> [52704.998026]  ? finish_task_switch+0xf6/0x620
>> [52704.999049]  ? __schedule+0x486/0xf50
>> [52704.999926]  ? exit_to_user_mode_prepare+0xc3/0x390
>> [52705.000840]  __x64_sys_reboot+0x26/0x40
>> [52705.001542]  do_syscall_64+0x50/0x90
>> [52705.002218]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
>> [52705.003356] RIP: 0033:0x7f0f1369def7
>> [52705.004216] Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 51 af 0c 00 f7 d8 64 89 02 b8
>> [52705.008496] RSP: 002b:00007fffcbc9eb48 EFLAGS: 00000206 ORIG_RAX: 00000000000000a9
>> [52705.010235] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0f1369def7
>> [52705.011915] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
>> [52705.013593] RBP: 00007fffcbc9eda0 R08: 0000000000000000 R09: 00007fffcbc9df40
>> [52705.015272] R10: 00007fffcbc9e100 R11: 0000000000000206 R12: 00007fffcbc9ebd8
>> [52705.016928] R13: 0000000000000000 R14: 0000000000000000 R15: 000055a7848b1968
>> [52705.018585] Modules linked in: sunrpc nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill nf_tables nfnetlink iTCO_wdt intel_rapl_msr intel_rapl_common intel_pmc_bxt kvm_intel iTCO_vendor_support kvm virtio_net irqbypass rapl joydev net_failover i2c_i801 lpc_ich failover i2c_smbus virtio_balloon fuse zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel serio_raw ghash_clmulni_intel virtio_blk virtio_console qemu_fw_cfg [last unloaded: nft_fib]
>> [52705.029015] CR2: ffffffffffffffe8
>> [52705.029832] ---[ end trace 40dfe466fd371faa ]---
>> [52705.030908] RIP: 0010:platform_shutdown+0x9/0x50
>> [52705.031972] Code: 02 00 00 ff 75 dd 31 c0 48 83 05 19 c9 b6 02 01 5d c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 47 68 <48> 8b 40 e8 48 85 c0 74 23 55 48 83 ef 10 48 83 05 01 ca b6 02 01
>> [52705.036245] RSP: 0018:ffffaaf780013d88 EFLAGS: 00010246
>> [52705.037474] RAX: 0000000000000000 RBX: ffff8f91478b6018 RCX: 0000000000000000
>> [52705.039143] RDX: 0000000000000001 RSI: ffff8f91478b6018 RDI: ffff8f91478b6010
>> [52705.040827] RBP: ffffaaf780013db8 R08: ffff8f91478b4408 R09: 0000000000000000
>> [52705.042463] R10: 000000000000000f R11: ffffffffa654d2e0 R12: ffffffffa6ba0440
>> [52705.044135] R13: ffff8f91478b6010 R14: ffff8f91478b6090 R15: 0000000000000000
>> [52705.045784] FS:  00007f0f126e6b80(0000) GS:ffff8f92b7d80000(0000) knlGS:0000000000000000
>> [52705.047637] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [52705.048992] CR2: ffffffffffffffe8 CR3: 00000001501be006 CR4: 0000000000170ee0
>> [52705.050655] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
>> [52705.053432] Kernel Offset: 0x23000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>> [52705.055871] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---
>
>The bisect result is:
>
>7f4c4e6312179ddc5a730185dd963d9ff4af010e is the first bad commit
>commit 7f4c4e6312179ddc5a730185dd963d9ff4af010e (refs/bisect/bad)
>Author:     Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>AuthorDate: Thu Nov 19 13:46:11 2020 +0100
>Commit:     Sasha Levin <sashal@kernel.org>
>CommitDate: Fri Oct 4 19:11:25 2024 -0400
>
>    driver core: platform: use bus_type functions
>
>    [ Upstream commit 9c30921fe7994907e0b3e0637b2c8c0fc4b5171f ]
>
>    This works towards the goal mentioned in 2006 in commit 594c8281f905
>    ("[PATCH] Add bus_type probe, remove, shutdown methods.").
>
>    The functions are moved to where the other bus_type functions are
>    defined and renamed to match the already established naming scheme.
>
>    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>    Link: https://lore.kernel.org/r/20201119124611.2573057-3-u.kleine-koenig@pengutronix.de
>    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>    Stable-dep-of: cfd67903977b ("PCI: xilinx-nwl: Clean up clock on probe failure/removal")
>    Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> drivers/base/platform.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------
> 1 file changed, 65 insertions(+), 67 deletions(-)
>
>
>which even seems plausible.

Ugh... It was a larger backport on 5.10, I'll drop all of that. Thats
for looking into it!

-- 
Thanks,
Sasha

