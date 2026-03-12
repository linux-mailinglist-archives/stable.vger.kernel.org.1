Return-Path: <stable+bounces-224874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNNwJL7WsmlDQAAAu9opvQ
	(envelope-from <stable+bounces-224874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:07:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08695273ED9
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 229CF3124CFE
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 14:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8593630A3;
	Thu, 12 Mar 2026 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="lNhE+NiU"
X-Original-To: stable@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CC6397E9F;
	Thu, 12 Mar 2026 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327472; cv=none; b=ifmZv8t8XNFB3A1p10gja0CFAgSc/t/c+ciZbBTSzpzWPrk5xyGQ72xFbkyDCZ2NDciS5UYC3qSiZI+HD2uZkjJo2k+nSfBF1xdhiKH1w8jPrdup7I5uVWlLVzOxeMfi/3NRRto02KA3PQl4xixvsJ9Yw/DdmayPAvA3ZxH3qLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327472; c=relaxed/simple;
	bh=oaJ8px1us7vDPIl4ANKog81zt2uqmmbO1WvknRd56tU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPs7RhtI0SA0EIf/tOSgSrzrQ8MAlxF8c422ThZKlsmYMEeCsNHiXUPOAHtT9RynrfUaCP1/WyR0J2mc+KYqt89z+ON3oZdDqhnlZNEMP97MfEoZOq8JqEYDtK1pdwXj4//nTeB2zeEDxhiclcfEqsS/3bvrDeAzoErGoifXFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=lNhE+NiU; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1773327464; x=1773586664;
	bh=qe3o4OzSrbyVEqf5/S9g3/g0Su2BTT6Z4qth/srqWGY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lNhE+NiUzFhGW6IEy5XZyoQc/vedKhEmwsp+5lIdkMo50FM9R0Tm0/mON8nyJ/sui
	 /tyI6ds8kg8oMcQHzV9Vz3vDzLrKIkkMkT2Co4l60yuw/u4k7X3RuqToX2WLnuNvPE
	 0lQZn0yv4fddoLPfgzEAKteujMBbSj+Qp6xVtI3TfEEDxmavy180cEekmYz0XxOhjg
	 IKSi8AOwfV11G8cF7KwH+MBI1QPaIjKUMM+kAPIF+f/YGxMBDzWeiRppn3FB9FCZuf
	 c3RkWCqIX2J6Av9LJfu5h+7WEIpLkEY7JqKDpG/UoUAptivjkqVFZL5W2II5CRUdia
	 yKhOQJX7uLy3Q==
Date: Thu, 12 Mar 2026 14:57:41 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net-shapers: clear hierarchy pointer and defer flush frees with RCU
Message-ID: <lomTI0Utaqc1kK-jJZfCVdeIZ8yyBGFVIPNwUSeYJfNxVLnC8zQTuuHJb5gOaflhYXp1n8tazmFoptBqR4MsZQTl-wJ3pG53wh0-WcvNlZM=@1g4.org>
In-Reply-To: <20260312072505.3d041823@kernel.org>
References: <20260309173450.538026-1-p@1g4.org> <20260310192842.3c3b2070@kernel.org> <cjiUUrQ73CJYWcTmlHQVSJPUJlxVg4kSZAnqkHKnU1SKeWoyy4F2qtIw7wuFRP9qz6Ra9ax0v2EQKsgdiRRUQnnuMweGbv-n08lgvXSTTG4=@1g4.org> <20260311171802.2d8a4d45@kernel.org> <HsPWaZkAZhVlbA7H6W6OtjDWVtryYVaPhSvE1jztmcWN02uRKeG3Gnvh5x0WjwdmDvowQge_ZUmD8Dmm3g5tGVyT5PjgmFcgGIRy2_B4bwQ=@1g4.org> <20260312072505.3d041823@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 2c968599668d12889deed214791a340f1c6adda2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224874-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[1g4.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,1g4.org:dkim,1g4.org:mid]
X-Rspamd-Queue-Id: 08695273ED9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Thu, 12 Mar 2026 06:05:45 +0000 Paul Moses wrote:
> > I'm sorry, I'm not seeing it that way.
>
> ;-D
>
> How very post modern of you.
>

Not sure the implication of that, but refcount_t is noisy as you can see=20
from a different version. I did not hit it once over many runs for this=20
bug. I am operating solely on evidence in my possession not speculation.

[poc7-queue] start
  if=3Deth0 ifindex=3D3 family_id=3D29
  threads: get=3D1 spray=3D1 background=3D4 probe=3D1
  opts: pin=3D1 no_recv=3D1 rcvbuf=3D4096 scope=3Dqueue
[poc7-queue] if=3Deth0 idx=3D3 | get 561/0 enobufs=3D0 spray 1/0 bg 200/0 p=
robe 1/0/0
[    2.708040] ------------[ cut here ]------------
[    2.708184] WARNING: CPU: 0 PID: 87 at net/netlink/af_netlink.c:1288 net=
link_trim+0xd3/0xe0
[    2.708410] Modules linked in:
[    2.708503] CPU: 0 UID: 1000 PID: 87 Comm: poc7 Not tainted 6.18.13 #8 P=
REEMPT(full)
[    2.708714] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    2.709019] RIP: 0010:netlink_trim+0xd3/0xe0
[    2.709141] Code: 5d 31 d2 31 c9 31 f6 31 ff c3 48 83 c4 08 49 89 dc 4c =
89 e0 5b 41 5c 41 5d 41 5e 5d 31 d2 31 c9 31 f6 31 ff c3 49 89 dc eb ad <0f=
> 0b e9 4b ff ff ff 66 0f 1f 44 00 00 0f 1f 44 00 00 55 48 89 e5
[    2.709633] RSP: 0018:ffffd167401fba00 EFLAGS: 00010282
[    2.709775] RAX: 0000000000000000 RBX: ffff8a4001f9aa00 RCX: 00000000000=
00040
[    2.709972] RDX: 0000000000000055 RSI: 0000000000000cc0 RDI: ffff8a4001f=
9aa00
[    2.710169] RBP: ffffd167401fba28 R08: 0000000000000000 R09: 00000000000=
00000
[    2.710359] R10: 0000000000000000 R11: 0000000000000000 R12: ffffd167401=
fbac8
[    2.710553] R13: 0000000000000055 R14: 0000000000000cc0 R15: ffffd167401=
fbbe0
[    2.710745] FS:  00007a1bdf9626c0(0000) GS:ffff8a4090ddd000(0000) knlGS:=
0000000000000000
[    2.710970] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.711131] CR2: 00007a1bdc15ab78 CR3: 0000000001f74000 CR4: 00000000004=
50ef0
[    2.711322] PKRU: 55555554
[    2.711399] Call Trace:
[    2.711473]  <TASK>
[    2.711536]  netlink_unicast+0x44/0x390
[    2.711643]  ? net_shaper_cap_fill_one+0xce/0x140
[    2.711773]  net_shaper_nl_cap_get_doit+0xed/0x130
[    2.711916]  genl_family_rcv_msg_doit+0xc9/0x110
[    2.712043]  genl_rcv_msg+0x158/0x280
[    2.712145]  ? net_shaper_nl_post_dumpit+0x30/0x30
[    2.712276]  ? net_shaper_nl_group_doit+0x630/0x630
[    2.712409]  ? net_shaper_nl_cap_pre_doit+0x30/0x30
[    2.712545]  ? genl_family_rcv_msg_dumpit+0xe0/0xe0
[    2.712679]  netlink_rcv_skb+0x3e/0xf0
[    2.712783]  genl_rcv+0x28/0x40
[    2.712879]  netlink_unicast+0x259/0x390
[    2.712987]  netlink_sendmsg+0x1ea/0x400
[    2.713096]  __sock_sendmsg+0x46/0x80
[    2.713198]  ? move_addr_to_kernel+0x2c/0x90
[    2.713316]  __sys_sendto+0x115/0x160
[    2.713418]  ? __x64_sys_sendto+0x24/0x40
[    2.713538]  ? x64_sys_call+0xdda/0xfd0
[    2.713646]  ? do_syscall_64+0xba/0x3a0
[    2.713753]  ? do_syscall_64+0xba/0x3a0
[    2.713909]  ? x64_sys_call+0xdda/0xfd0
[    2.714045]  __x64_sys_sendto+0x24/0x40
[    2.714179]  x64_sys_call+0xdda/0xfd0
[    2.714306]  do_syscall_64+0x82/0x3a0
[    2.714432]  ? do_syscall_64+0xba/0x3a0
[    2.714572]  ? x64_sys_call+0xdda/0xfd0
[    2.714706]  ? do_syscall_64+0xba/0x3a0
[    2.714839]  ? irqentry_exit+0x3b/0x50
[    2.714970]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[    2.715141] RIP: 0033:0x42aaec
[    2.715250] Code: 9a d3 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c3 44 8b =
54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48=
> 3d 00 f0 ff ff 77 34 89 df 48 89 44 24 08 e8 e0 d3 02 00 48 8b
[    2.715869] RSP: 002b:00007a1bdf95e160 EFLAGS: 00000293 ORIG_RAX: 000000=
000000002c
[    2.716097] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004=
2aaec
[    2.716313] RDX: 0000000000000024 RSI: 00007a1bdf95e1c0 RDI: 00000000000=
00004
[    2.716531] RBP: 00007ffe7b3a95f0 R08: 0000000000499770 R09: 00000000000=
0000c
[    2.716746] R10: 0000000000000000 R11: 0000000000000293 R12: 00007a1bd40=
00b70
[    2.717037] R13: 000000000000001d R14: 00007a1bdf962cdc R15: 00007ffe7b3=
a9487
[    2.717308]  </TASK>
[    2.717398] ---[ end trace 0000000000000000 ]---
[    2.727444] ------------[ cut here ]------------
[    2.727577] refcount_t: underflow; use-after-free.
[    2.727716] WARNING: CPU: 0 PID: 87 at lib/refcount.c:28 refcount_warn_s=
aturate+0xfa/0x110
[    2.727941] Modules linked in:
[    2.728028] CPU: 0 UID: 1000 PID: 87 Comm: poc7 Tainted: G        W     =
      6.18.13 #8 PREEMPT(full)
[    2.728275] Tainted: [W]=3DWARN
[    2.728358] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    2.728655] RIP: 0010:refcount_warn_saturate+0xfa/0x110
[    2.728799] Code: 54 31 8d c6 05 1e 53 54 01 01 e8 b1 c8 97 ff 0f 0b 5d =
31 f6 31 ff c3 48 c7 c7 58 54 31 8d c6 05 05 53 54 01 01 e8 96 c8 97 ff <0f=
> 0b 5d 31 f6 31 ff c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00
[    2.729283] RSP: 0018:ffffd167401fb970 EFLAGS: 00010246
[    2.729423] RAX: 0000000000000000 RBX: ffff8a4002a54580 RCX: 00000000000=
00000
[    2.729615] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[    2.729806] RBP: ffffd167401fb970 R08: 0000000000000000 R09: 00000000000=
00000
[    2.729995] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a4002a=
ad300
[    2.730189] R13: ffffd167401fba48 R14: 000000008c9fed00 R15: ffff8a4002b=
33080
[    2.730379] FS:  00007a1bdf9626c0(0000) GS:ffff8a4090ddd000(0000) knlGS:=
0000000000000000
[    2.730594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.730749] CR2: 00007a1bdc15ab78 CR3: 0000000001f74000 CR4: 00000000004=
50ef0
[    2.730946] PKRU: 55555554
[    2.731023] Call Trace:
[    2.731092]  <TASK>
[    2.731153]  sock_wfree+0x1c5/0x1f0
[    2.731250]  skb_release_head_state+0x24/0xa0
[    2.731371]  sk_skb_reason_drop+0x3c/0x140
[    2.731501]  netlink_attachskb+0x288/0x2b0
[    2.731615]  ? wake_up_state+0x20/0x20
[    2.731720]  netlink_unicast+0xe2/0x390
[    2.731832]  ? net_shaper_cap_fill_one+0xce/0x140
[    2.731961]  net_shaper_nl_cap_get_doit+0xed/0x130
[    2.732091]  genl_family_rcv_msg_doit+0xc9/0x110
[    2.732218]  genl_rcv_msg+0x158/0x280
[    2.732320]  ? net_shaper_nl_post_dumpit+0x30/0x30
[    2.732453]  ? net_shaper_nl_group_doit+0x630/0x630
[    2.732586]  ? net_shaper_nl_cap_pre_doit+0x30/0x30
[    2.732718]  ? genl_family_rcv_msg_dumpit+0xe0/0xe0
[    2.732858]  netlink_rcv_skb+0x3e/0xf0
[    2.732963]  genl_rcv+0x28/0x40
[    2.733052]  netlink_unicast+0x259/0x390
[    2.733160]  netlink_sendmsg+0x1ea/0x400
[    2.733268]  __sock_sendmsg+0x46/0x80
[    2.733369]  ? move_addr_to_kernel+0x2c/0x90
[    2.733494]  __sys_sendto+0x115/0x160
[    2.733604]  ? __x64_sys_sendto+0x24/0x40
[    2.733715]  ? x64_sys_call+0xdda/0xfd0
[    2.733828]  ? do_syscall_64+0xba/0x3a0
[    2.733934]  ? do_syscall_64+0xba/0x3a0
[    2.734039]  ? x64_sys_call+0xdda/0xfd0
[    2.734145]  __x64_sys_sendto+0x24/0x40
[    2.734250]  x64_sys_call+0xdda/0xfd0
[    2.734352]  do_syscall_64+0x82/0x3a0
[    2.734457]  ? do_syscall_64+0xba/0x3a0
[    2.734563]  ? x64_sys_call+0xdda/0xfd0
[    2.734669]  ? do_syscall_64+0xba/0x3a0
[    2.734774]  ? irqentry_exit+0x3b/0x50
[    2.734887]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[    2.735024] RIP: 0033:0x42aaec
[    2.735111] Code: 9a d3 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c3 44 8b =
54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48=
> 3d 00 f0 ff ff 77 34 89 df 48 89 44 24 08 e8 e0 d3 02 00 48 8b
[    2.735601] RSP: 002b:00007a1bdf95e160 EFLAGS: 00000293 ORIG_RAX: 000000=
000000002c
[    2.735808] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004=
2aaec
[    2.735998] RDX: 0000000000000024 RSI: 00007a1bdf95e1c0 RDI: 00000000000=
00004
[    2.736189] RBP: 00007ffe7b3a95f0 R08: 0000000000499770 R09: 00000000000=
0000c
[    2.736380] R10: 0000000000000000 R11: 0000000000000293 R12: 00007a1bd40=
00b70
[    2.736573] R13: 000000000000001d R14: 00007a1bdf962cdc R15: 00007ffe7b3=
a9487
[    2.736765]  </TASK>
[    2.736841] ---[ end trace 0000000000000000 ]---
[poc7-queue] if=3Deth0 idx=3D3 | get 689745/0 enobufs=3D0 spray 3/0 bg 200/=
0 probe 924/0/0
[    3.731449] ------------[ cut here ]------------
[    3.731589] refcount_t: saturated; leaking memory.
[    3.731725] WARNING: CPU: 0 PID: 12 at lib/refcount.c:22 refcount_warn_s=
aturate+0x6f/0x110
[    3.731955] Modules linked in:
[    3.732042] CPU: 0 UID: 0 PID: 12 Comm: kworker/u4:0 Tainted: G        W=
           6.18.13 #8 PREEMPT(full)
[    3.732307] Tainted: [W]=3DWARN
[    3.732392] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    3.732691] Workqueue: ipv6_addrconf addrconf_dad_work
[    3.732838] RIP: 0010:refcount_warn_saturate+0x6f/0x110
[    3.732981] Code: 01 e8 45 c9 97 ff 0f 0b 5d 31 f6 31 ff c3 80 3d a2 53 =
54 01 00 75 cd 48 c7 c7 00 54 31 8d c6 05 92 53 54 01 01 e8 21 c9 97 ff <0f=
> 0b 5d 31 f6 31 ff c3 80 3d 7d 53 54 01 00 75 a9 48 c7 c7 28 54
[    3.733479] RSP: 0018:ffffd1674006bc00 EFLAGS: 00010246
[    3.733621] RAX: 0000000000000000 RBX: ffff8a4002a54b00 RCX: 00000000000=
00000
[    3.733853] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[    3.734092] RBP: ffffd1674006bc00 R08: 0000000000000000 R09: 00000000000=
00000
[    3.734330] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a4001f=
9aa00
[    3.734574] R13: ffff8a4002a78000 R14: 00000000000005dc R15: 00000000000=
00000
[    3.734822] FS:  0000000000000000(0000) GS:ffff8a4090ddd000(0000) knlGS:=
0000000000000000
[    3.735088] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.735281] CR2: 00007a1bdc15ab78 CR3: 0000000001f74000 CR4: 00000000004=
50ef0
[    3.735522] PKRU: 55555554
[    3.735617] Call Trace:
[    3.735704]  <TASK>
[    3.735780]  skb_set_owner_w+0xb5/0x110
[    3.735910]  mld_newpack+0xd6/0x180
[    3.736025]  add_grhead+0x96/0xb0
[    3.736130]  add_grec+0x502/0x560
[    3.736235]  ? _raw_spin_unlock_bh+0x1d/0x30
[    3.736370]  ? ip6_ins_rt+0x52/0x70
[    3.736484]  mld_send_initial_cr.part.0.isra.0+0x34/0x80
[    3.736646]  ipv6_mc_dad_complete+0x65/0x110
[    3.736780]  addrconf_dad_completed+0x387/0x3b0
[    3.736939]  addrconf_dad_work+0x225/0x4b0
[    3.737067]  ? addrconf_dad_work+0x225/0x4b0
[    3.737200]  process_one_work+0x15d/0x330
[    3.737325]  worker_thread+0x337/0x470
[    3.737446]  ? process_one_work+0x330/0x330
[    3.737575]  kthread+0xfc/0x210
[    3.737676]  ? kthreads_online_cpu+0x110/0x110
[    3.737820]  ret_from_fork+0x1e2/0x210
[    3.737936]  ? kthreads_online_cpu+0x110/0x110
[    3.738071]  ret_from_fork_asm+0x11/0x20
[    3.738192]  </TASK>
[    3.738261] ---[ end trace 0000000000000000 ]---
[    3.748450] ------------[ cut here ]------------
[    3.748588] kernel BUG at net/core/skbuff.c:2579!
[    3.748723] Oops: invalid opcode: 0000 [#1] SMP
[    3.748851] CPU: 0 UID: 0 PID: 12 Comm: kworker/u4:0 Tainted: G        W=
           6.18.13 #8 PREEMPT(full)
[    3.749112] Tainted: [W]=3DWARN
[    3.749196] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    3.749494] Workqueue: ipv6_addrconf addrconf_dad_work
[    3.749635] RIP: 0010:skb_put+0x3c/0x40
[    3.749742] Code: 01 77 70 48 89 c2 48 03 87 c8 00 00 00 01 f2 89 97 bc =
00 00 00 39 97 c0 00 00 00 0f 82 6c f1 32 ff 31 d2 31 c9 31 f6 31 ff c3 <0f=
> 0b 66 90 0f 1f 44 00 00 55 8b 47 70 48 89 e5 39 f0 72 20 29 f0
[    3.750244] RSP: 0018:ffffd1674006bbf0 EFLAGS: 00010282
[    3.750386] RAX: 00000000ffff8a40 RBX: ffff8a4001f9aa00 RCX: ffffd167400=
6bc30
[    3.750576] RDX: ffff8a4002a78000 RSI: 0000000000000028 RDI: ffff8a4001f=
9aa00
[    3.750766] RBP: ffffd1674006bc20 R08: ffffffff8d8d69b0 R09: 00000000000=
00000
[    3.750963] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a4002a=
54b00
[    3.751153] R13: 0000000000000000 R14: ffffd1674006bc30 R15: ffffffff8d8=
d69b0
[    3.751344] FS:  0000000000000000(0000) GS:ffff8a4090ddd000(0000) knlGS:=
0000000000000000
[    3.751557] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.751712] CR2: 00007a1bdc15ab78 CR3: 0000000001f74000 CR4: 00000000004=
50ef0
[    3.751912] PKRU: 55555554
[    3.751988] Call Trace:
[    3.752058]  <TASK>
[    3.752119]  ? ip6_mc_hdr.constprop.0+0x53/0xe0
[    3.752244]  mld_newpack+0x10e/0x180
[    3.752343]  add_grhead+0x96/0xb0
[    3.752436]  add_grec+0x502/0x560
[    3.752529]  ? _raw_spin_unlock_bh+0x1d/0x30
[    3.752659]  ? ip6_ins_rt+0x52/0x70
[    3.752756]  mld_send_initial_cr.part.0.isra.0+0x34/0x80
[    3.752906]  ipv6_mc_dad_complete+0x65/0x110
[    3.753024]  addrconf_dad_completed+0x387/0x3b0
[    3.753148]  addrconf_dad_work+0x225/0x4b0
[    3.753261]  ? addrconf_dad_work+0x225/0x4b0
[    3.753378]  process_one_work+0x15d/0x330
[    3.753494]  worker_thread+0x337/0x470
[    3.753598]  ? process_one_work+0x330/0x330
[    3.753711]  kthread+0xfc/0x210
[    3.753805]  ? kthreads_online_cpu+0x110/0x110
[    3.753927]  ret_from_fork+0x1e2/0x210
[    3.754031]  ? kthreads_online_cpu+0x110/0x110
[    3.754153]  ret_from_fork_asm+0x11/0x20
[    3.754261]  </TASK>
[    3.754324] Modules linked in:
[    3.754415] ---[ end trace 0000000000000000 ]---
[    3.766444] RIP: 0010:skb_put+0x3c/0x40
[    3.766564] Code: 01 77 70 48 89 c2 48 03 87 c8 00 00 00 01 f2 89 97 bc =
00 00 00 39 97 c0 00 00 00 0f 82 6c f1 32 ff 31 d2 31 c9 31 f6 31 ff c3 <0f=
> 0b 66 90 0f 1f 44 00 00 55 8b 47 70 48 89 e5 39 f0 72 20 29 f0
[    3.767065] RSP: 0018:ffffd1674006bbf0 EFLAGS: 00010282
[    3.767207] RAX: 00000000ffff8a40 RBX: ffff8a4001f9aa00 RCX: ffffd167400=
6bc30
[    3.767399] RDX: ffff8a4002a78000 RSI: 0000000000000028 RDI: ffff8a4001f=
9aa00
[    3.770444] RBP: ffffd1674006bc20 R08: ffffffff8d8d69b0 R09: 00000000000=
00000
[    3.770639] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a4002a=
54b00
[    3.770843] R13: 0000000000000000 R14: ffffd1674006bc30 R15: ffffffff8d8=
d69b0
[    3.771039] FS:  0000000000000000(0000) GS:ffff8a4090ddd000(0000) knlGS:=
0000000000000000
[    3.771261] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.771417] CR2: 00007a1bdc15ab78 CR3: 0000000001f74000 CR4: 00000000004=
50ef0
[    3.774445] PKRU: 55555554
[    3.774528] Kernel panic - not syncing: Fatal exception
[    3.774727] Kernel Offset: 0xaa00000 from 0xffffffff81000000 (relocation=
 range: 0xffffffff80000000-0xffffffffbfffffff)
[    3.775020] Rebooting in 1 seconds..


