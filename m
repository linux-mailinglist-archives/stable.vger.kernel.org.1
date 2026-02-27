Return-Path: <stable+bounces-219907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDG2EmckoWkyqgQAu9opvQ
	(envelope-from <stable+bounces-219907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 05:58:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A396D1B2C42
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 05:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2210E30DD56C
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 04:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681E1362123;
	Fri, 27 Feb 2026 04:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="IBzyUY7x";
	dkim=permerror (0-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="l7fYdS6Q"
X-Original-To: stable@vger.kernel.org
Received: from hua.moonlit-rail.com (hua.moonlit-rail.com [45.79.167.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A013290B5;
	Fri, 27 Feb 2026 04:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.167.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772168291; cv=none; b=PvK3tKpuMNTxcZy7iXY/26QxDRMCQLzmOt4iJ2ZZviEfPInQLMqOz31p3I8aD2g64GY0lkZZKJ81IAKE/O0u+CJU5KAHlkBtxx8xyHA5J0E0ryNXuHZp9tjUaEumeEbOl8dlfU2n7PNU5AWRJRVlrYSJB2m59sHBC2sGdIoe8hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772168291; c=relaxed/simple;
	bh=7WTEYsfKRK+FAjDteikPL4IN19BC+NWZFx/2o8xFHiM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SrZxnKh2XwYlXxMzJotHu+mXDkTpTs8u1IP3PBzmzWiLCWiCjccZUz8CJTosvdTIC6rsdIt9n3acQVVHyJIdr7xStnPfzudT4ynyq7kxSOm6ROD+4G97/vpWc+FaKElNjJz7w5zMIawlFmHct+kjq1m5zOzsgNKfVoX1+p4/qn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonlit-rail.com; spf=pass smtp.mailfrom=moonlit-rail.com; dkim=pass (2048-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b=IBzyUY7x; dkim=permerror (0-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b=l7fYdS6Q; arc=none smtp.client-ip=45.79.167.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonlit-rail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonlit-rail.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=rsa2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:Subject:References:Cc:To:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+NYI3sC2Rh8Ca1+y95noCqHR8Z4CPLuvLt0BLd+Eomg=; t=1772167562; x=1774759562; 
	b=IBzyUY7xUmltV/I+SOKbFz5OJOdi/Ml88OIP4mkFEWYRadgdRSNj2LbiaYN+NHWDZcTXltMkmCv
	U9adlPjQV/3VVSiyGQl17E5IqBLdSIEvuRzLibes/ejlbkH6nrZqb3gDexJG9udEVXQ1Tz+MmwbHU
	yp53DaaIp1Hi+rUw7FEUZn4/9pW4y6I0lE4ejWWZvlHBHjCFmC5lFJ2YbDJ/Uu8FqAmHaiqXkdIo5
	wEyAN/872MmiNbOTJfgmkq7BloYDy8Uz5EXBb2WQMMNYbpZL9yeYvMY+vWTh48k3Ba2Tf7L8zKz01
	e6i6FarNKqN6WmHwqFYV6eS1yJ3yfsKi7IHw==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=edd2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:Subject:References:Cc:To:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+NYI3sC2Rh8Ca1+y95noCqHR8Z4CPLuvLt0BLd+Eomg=; t=1772167562; x=1774759562; 
	b=l7fYdS6Qj2vj3mwoaH8OyS4EuEIgidNHyd6u1EVAZoCAjH3C5HxzxI7I/YlrdvRiyynxIhpIV4L
	mTwWYzgAFAA==;
Message-ID: <eb2d1da9-0b4b-4887-83a4-0e2a65e703aa@moonlit-rail.com>
Date: Thu, 26 Feb 2026 23:46:02 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org,
 lwn@lwn.net, stable@vger.kernel.org, torvalds@linux-foundation.org
References: <2026022657-clambake-mountable-8175@gregkh>
Subject: Re: Linux 6.19.4 - Oops, regression
From: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
Content-Language: en-US, en-GB
In-Reply-To: <2026022657-clambake-mountable-8175@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[moonlit-rail.com:s=rsa2021a,moonlit-rail.com:s=edd2021a];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[moonlit-rail.com : SPF not aligned (strict),none];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[moonlit-rail.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219907-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[bugs-a21@moonlit-rail.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[moonlit-rail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A396D1B2C42
X-Rspamd-Action: no action

GregKH wrote:
> I'm announcing the release of the 6.19.4 kernel.
> All users of the 6.19 kernel series must upgrade.

Just tried 6.19.4 (and 6.18.14) and am getting a repeatable Oops right 
when networking is initialized, likely when nft is loading its ruleset 
from /etc/nftables/*.conf

Once the nft Oops triggers, other processes start to throw errors with 
memory allocate/free, resulting very quickly in an unusable system. I 
have several systems that run iptables, which are unaffected, notably my 
border router with 400+ rules. I have three systems running nftables, 
one of which is affected, the affected one having the more sophisticated 
nft ruleset (bridging, 802.1Q, etc).

Kris

---------- Snip ----------

Here's the output from dmesg:
> 8021q: adding VLAN 0 to HW filter on device eth0
> ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade 
> rev:0 func:0 (0x1001)
> igb 0000:0a:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, 
> Flow Control: RX
> BUG: unable to handle page fault for address: 000000010000001d
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 126bd2067 P4D 126bd2067 PUD 0
> Oops: Oops: 0000 [#1] SMP
> CPU: 12 UID: 0 PID: 1184 Comm: nft Not tainted 6.19.4 #1 PREEMPTLAZY
> Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X470 
> Taichi, BIOS P10.41 04/14/2025
> RIP: 0010:__kmalloc_noprof+0x1d0/0x3c0
> Code: 2e 85 5b 01 48 8b 50 08 48 83 78 10 00 48 8b 38 0f 84 b7 01 00 
> 00 48 85 ff 0f 84 ae 01 00 00 41 8b 41 30 49 8b 31 48 8d 4a 20 <48> 8b 
> 1c 07 48 89 f8 65 48 0f c7 0e 75 c1 41 8b 41 30 0f 0d 0c 03
> RSP: 0018:ffffc9000111f5e0 EFLAGS: 00010202
> RAX: 0000000000000020 RBX: ffff88810592e200 RCX: 0000000000042a4c
> RDX: 0000000000042a2c RSI: ffffffff82af08e0 RDI: 00000000fffffffd
> RBP: ffffc9000111f620 R08: 0000000000000030 R09: ffff888100044300
> R10: 0000000000400dc0 R11: 0000000000000030 R12: 0000000000000000
> R13: ffffc9000111f70e R14: ffffffffa06737f4 R15: ffffc9000111f7b8
> FS:  00007fc46c393740(0000) GS:ffff88907c036000(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000010000001d CR3: 0000000126bd5000 CR4: 0000000000350ef0
> Call Trace:
> <TASK>
> ? nla_memcpy+0x29/0x60
> nft_set_elem_init+0x44/0x140 [nf_tables]
> nft_add_set_elem+0xa77/0x14e0 [nf_tables]
> ? vsnprintf+0x3ac/0x5a0
> ? __nft_trans_set_add+0xb6/0x120 [nf_tables]
> ? nla_strcmp+0x10/0x60
> nf_tables_newsetelem+0x19e/0x270 [nf_tables]
> nfnetlink_rcv_batch+0x582/0x8e0
> ? netlink_alloc_large_skb+0x3a/0xa0
> ? __alloc_frozen_pages_noprof+0x148/0x280
> nfnetlink_rcv+0x172/0x190
> netlink_unicast+0x1d4/0x2b0
> netlink_sendmsg+0x1ed/0x410
> __sock_sendmsg+0x2b/0x40
> ____sys_sendmsg+0x1fb/0x220
> ? copy_msghdr_from_user+0xe5/0x170
> ___sys_sendmsg+0x78/0xc0
> ? security_capable+0x25/0x50
> ? release_sock+0x14/0x80
> ? sk_setsockopt+0x36c/0x1590
> ? __handle_mm_fault+0x975/0x1660
> ? do_sock_getsockopt+0x1a2/0x1d0
> __sys_sendmsg+0x66/0xc0
> do_syscall_64+0x4e/0xe30
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7fc46c0981f7
> Code: 08 74 44 b8 04 00 00 00 48 8b 15 ec 6b 16 00 64 89 02 48 c7 c2 
> ff ff ff ff 48 83 c4 10 48 89 d0 5b c3 90 48 8b 44 24 20 0f 05 <48> 63 
> d0 3d 00 f0 ff ff 77 0f 48 83 c4 10 48 89 d0 5b c3 66 0f 1f
> RSP: 002b:00007ffec97ae5f0 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000009146b20 RCX: 00007fc46c0981f7
> RDX: 0000000000000000 RSI: 00007ffec97bf6d0 RDI: 0000000000000003
> RBP: 00007ffec97bf7c0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffec97bf810
> R13: 0000000000013800 R14: 0000000000000003 R15: 00007ffec97ae640
> </TASK>
> Modules linked in: nft_meta_bridge nf_conntrack_bridge nft_log 
> nft_limit nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_ct tap 
> nf_tables ip_set ip6table_security iptable_security ip6table_raw 
> iptable_raw ip6table_mangle iptabl
> e_mangle ip6table_nat iptable_nat ip6table_filter ip6_tables 
> iptable_filter ip_tables btusb btrtl btintel btbcm btmtk bluetooth 
> sd_mod iwlmvm uas usb_storage mac80211 iwlwifi ahci 
> snd_hda_codec_alc882 libahci snd_hda_codec_realtek
> _lib cfg80211 igb libata rfkill snd_hda_codec_generic i2c_algo_bit 
> snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep 
> snd_pcm snd_timer snd soundcore ee1004 acpi_cpufreq gpio_amdpt 
> gpio_generic processor joydev bi
> nfmt_misc
> CR2: 000000010000001d
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__kmalloc_noprof+0x1d0/0x3c0
> Code: 2e 85 5b 01 48 8b 50 08 48 83 78 10 00 48 8b 38 0f 84 b7 01 00 
> 00 48 85 ff 0f 84 ae 01 00 00 41 8b 41 30 49 8b 31 48 8d 4a 20 <48> 8b 
> 1c 07 48 89 f8 65 48 0f c7 0e 75 c1 41 8b 41 30 0f 0d 0c 03
> RSP: 0018:ffffc9000111f5e0 EFLAGS: 00010202
> RAX: 0000000000000020 RBX: ffff88810592e200 RCX: 0000000000042a4c
> RDX: 0000000000042a2c RSI: ffffffff82af08e0 RDI: 00000000fffffffd
> RBP: ffffc9000111f620 R08: 0000000000000030 R09: ffff888100044300
> R10: 0000000000400dc0 R11: 0000000000000030 R12: 0000000000000000
> R13: ffffc9000111f70e R14: ffffffffa06737f4 R15: ffffc9000111f7b8
> FS:  00007fc46c393740(0000) GS:ffff88907c036000(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000010000001d CR3: 0000000126bd5000 CR4: 0000000000350ef0
> note: nft[1184] exited with irqs disabled 



