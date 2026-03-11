Return-Path: <stable+bounces-224695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0D5AGgR3sWk2vgIAu9opvQ
	(envelope-from <stable+bounces-224695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 15:07:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B133265143
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 15:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87638301F48B
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 14:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E37364029;
	Wed, 11 Mar 2026 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="L20ILv19"
X-Original-To: stable@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C42279DCA;
	Wed, 11 Mar 2026 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237908; cv=none; b=uV++HsPtFGvS+snbvhhJhgdEfstg5cPL/3LPP5wbDYZvQIgyLcw5CbqHd1OEZ+T3bw/bu3+a0nMlHggJZFBA5iOb4MlaAldLjx2fJDiQdzQ0kihm6qPU81zWQwHFYv2fPoXCtGJDhlsqqEVxVllQzV42w9dyO1h1ALQj11oSqNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237908; c=relaxed/simple;
	bh=METKl9O+g2rYCR6yXomMBW77UPt4p8e3I7+mrNJYisQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DB/8ljMfl+wa/W1SegL3tpdBtsR+zxne8VT89q7mdZtaXYcnxuf+SECMFxvVa3YzUzbTMT5OpBWaARM3TqcgYFgkgYFnhY2nan9wpF4rfm6jJ4K5Aq1bFs6WbzL+RVovlZE7nyr3UDa+qidsa0+FjDI7RsXpNymWLBJ9OfmLhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=L20ILv19; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1773237897; x=1773497097;
	bh=U/Kv4Sn6NWBO9Vy9sZJUOVhYH69CPNBNs8qjyrr5T+k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=L20ILv19MHiJNVc2WgqJXJ/tPfy73yovZVsmvU+biP+jcIdJH4u1EmnoMTB+++Obb
	 56fSxcQ0621/rmdk/2uuxqLWWMgRA9z9fr/OQ4dL8lQ4znJuvViZoquS/28oDpmtek
	 M3y8BY1DpMc8RNaVVmTEOpNEuyp6sOJE2KzmBiAoiZs6SeQ0tAKUhlmFni1K3o+9h/
	 rQ4CqFrugLYGwJJLG4xMNWcDTHaRsySxUEtko+U/IulDaYaeyZlFcAGhiHo9SvhfNs
	 slO2Uk1xCqpDNWegV8RhkxD3KjsxL+u2z1JA1OEyrjh3M5Nz+1yNbFVBUg7Y9hbB4l
	 peFiSXRXALLTA==
Date: Wed, 11 Mar 2026 14:04:54 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net-shapers: clear hierarchy pointer and defer flush frees with RCU
Message-ID: <cjiUUrQ73CJYWcTmlHQVSJPUJlxVg4kSZAnqkHKnU1SKeWoyy4F2qtIw7wuFRP9qz6Ra9ax0v2EQKsgdiRRUQnnuMweGbv-n08lgvXSTTG4=@1g4.org>
In-Reply-To: <20260310192842.3c3b2070@kernel.org>
References: <20260309173450.538026-1-p@1g4.org> <20260310192842.3c3b2070@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 8144b063a6dca35d23f648dac5130d5e87bce951
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0B133265143
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224695-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[1g4.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The reported UAF was in the GET doit reader path.

GET doit enters rcu_read_lock(), then net_shaper_lookup() performs
READ_ONCE(netdev->net_shaper_hierarchy) and walks the xarray locklessly.

GET dump reads the hierarchy pointer first, then enters rcu_read_lock()
and uses xa_find() to walk the xarray.

Both paths rely on RCU to keep the hierarchy and its shapers valid during
the lockless walk.

So that might be another issue, but that's not what I reproduced.

Thanks,
Paul

[    9.142939] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    9.143220] BUG: KASAN: slab-use-after-free in xas_start+0x513/0x610
[    9.143441] Read of size 8 at addr ffff88810612a748 by task poc4/156
[    9.143693]
[    9.143755] CPU: 5 UID: 0 PID: 156 Comm: poc4 Not tainted 6.18.13 #4 PRE=
EMPT(voluntary)
[    9.143760] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    9.143763] Call Trace:
[    9.143765]  <TASK>
[    9.143768]  dump_stack_lvl+0x84/0xd0
[    9.143775]  print_report+0x171/0x4dc
[    9.143781]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.143785]  ? __virt_addr_valid+0x26b/0x510
[    9.143791]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.143794]  ? kasan_complete_mode_report_info+0x80/0x220
[    9.143800]  ? xas_start+0x513/0x610
[    9.143803]  kasan_report+0xd4/0x1a0
[    9.143809]  ? xas_start+0x513/0x610
[    9.143817]  __asan_report_load8_noabort+0x14/0x30
[    9.143820]  xas_start+0x513/0x610
[    9.143825]  xa_get_mark+0xd9/0x500
[    9.143829]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.143834]  ? __pfx_xa_get_mark+0x10/0x10
[    9.143844]  net_shaper_lookup+0x107/0x1b0
[    9.143849]  net_shaper_nl_get_doit+0x14c/0x560
[    9.143854]  ? __pfx_net_shaper_nl_get_doit+0x10/0x10
[    9.143857]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.143863]  genl_family_rcv_msg_doit+0x1db/0x2e0
[    9.143870]  ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
[    9.143873]  ? netlink_sendmsg+0x56c/0xc80
[    9.143876]  ? __sys_sendto+0x427/0x520
[    9.143879]  ? __x64_sys_sendto+0xe4/0x1f0
[    9.143891]  genl_rcv_msg+0x3ec/0x660
[    9.143897]  ? __pfx_genl_rcv_msg+0x10/0x10
[    9.143901]  ? __pfx_net_shaper_nl_pre_doit+0x10/0x10
[    9.143904]  ? __pfx_net_shaper_nl_get_doit+0x10/0x10
[    9.143907]  ? __pfx_net_shaper_nl_post_doit+0x10/0x10
[    9.143911]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.143918]  netlink_rcv_skb+0x127/0x3b0
[    9.143922]  ? __pfx_genl_rcv_msg+0x10/0x10
[    9.143926]  ? __pfx_netlink_rcv_skb+0x10/0x10
[    9.143939]  genl_rcv+0x28/0x50
[    9.143943]  netlink_unicast+0x60f/0xa50
[    9.143949]  ? __pfx_netlink_unicast+0x10/0x10
[    9.143957]  netlink_sendmsg+0x751/0xc80
[    9.143964]  ? __pfx_netlink_sendmsg+0x10/0x10
[    9.143969]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.143972]  ? apparmor_socket_sendmsg+0x6a/0xa0
[    9.143979]  __sys_sendto+0x427/0x520
[    9.143984]  ? __pfx___sys_sendto+0x10/0x10
[    9.143992]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.143995]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.143999]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.144002]  ? __kasan_check_read+0x11/0x20
[    9.144007]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.144010]  ? trace_hardirqs_on_prepare+0x2b/0x50
[    9.144015]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.144018]  ? do_syscall_64+0x1b5/0x1210
[    9.144023]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.144026]  ? __kasan_check_read+0x11/0x20
[    9.144029]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.144032]  ? trace_irq_enable+0xd5/0x120
[    9.144038]  __x64_sys_sendto+0xe4/0x1f0
[    9.144041]  ? __kasan_check_read+0x11/0x20
[    9.144044]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.144047]  ? trace_irq_enable+0xd5/0x120
[    9.144049]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.144054]  x64_sys_call+0x1d15/0x2350
[    9.144058]  do_syscall_64+0x90/0x1210
[    9.144063]  ? trace_hardirqs_on_prepare+0x2b/0x50
[    9.144066]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.144069]  ? do_syscall_64+0x1b5/0x1210
[    9.144072]  ? trace_hardirqs_on_prepare+0x2b/0x50
[    9.144076]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.144079]  ? __kasan_check_read+0x11/0x20
[    9.144082]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.144085]  ? trace_irq_enable+0xd5/0x120
[    9.144089]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.144092]  ? trace_hardirqs_on_prepare+0x2b/0x50
[    9.144095]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.144098]  ? do_syscall_64+0x1b5/0x1210
[    9.144101]  ? srso_alias_return_thunk+0x5/0xfbef5
[    9.144106]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    9.144109] RIP: 0033:0x42fc6c
[    9.144113] Code: 5a 3a 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c3 44 8b =
54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48=
> 3d 00 f0 ff ff 77 34 89 df 48 89 44 24 08 e8 a0 3a 02 00 48 8b
[    9.144115] RSP: 002b:000074a97f7fd1c0 EFLAGS: 00000293 ORIG_RAX: 000000=
000000002c
[    9.144120] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004=
2fc6c
[    9.144122] RDX: 0000000000000030 RSI: 000074a97f7fd200 RDI: 00000000000=
00009
[    9.144124] RBP: 000074a97f7fe230 R08: 00000000004a36b8 R09: 00000000000=
0000c
[    9.144127] R10: 0000000000000000 R11: 0000000000000293 R12: 000074a96c0=
00b70
[    9.144129] R13: 0000000000001000 R14: 000074a97f7fe200 R15: 000074a97f7=
fd21c
[    9.144139]  </TASK>
[    9.144141]
[    9.156968] Freed by task 160:
[    9.157068]  kasan_save_stack+0x26/0x60
[    9.157190]  kasan_save_track+0x14/0x40
[    9.157311]  __kasan_save_free_info+0x3b/0x60
[    9.157447]  __kasan_slab_free+0x7a/0xb0
[    9.157573]  kfree+0x133/0x5c0
[    9.157675]  net_shaper_flush_netdev+0x10c/0x150
[    9.157822]  unregister_netdevice_many_notify+0x15b2/0x25e0
[    9.157994]  unregister_netdevice_queue+0x28d/0x380
[    9.158145]  nsim_destroy+0x170/0x6e0
[    9.158263]  __nsim_dev_port_del+0x160/0x280
[    9.158397]  nsim_dev_reload_destroy+0x145/0x500
[    9.158544]  nsim_drv_remove+0x4e/0x1e0
[    9.158666]  nsim_bus_remove+0xe/0x20
[    9.158783]  device_remove+0xc5/0x190
[    9.158901]  device_release_driver_internal+0x3db/0x590
[    9.159062]  device_release_driver+0x12/0x20
[    9.159197]  bus_remove_device+0x1f5/0x3f0
[    9.159325]  device_del+0x3b0/0x980
[    9.159438]  device_unregister+0x17/0xb0
[    9.159567]  del_device_store+0x2bd/0x470
[    9.159694]  bus_attr_store+0x67/0xf0
[    9.159812]  sysfs_kf_write+0xe5/0x150
[    9.159932]  kernfs_fop_write_iter+0x3d9/0x5e0
[    9.160072]  vfs_write+0x4e5/0x10e0
[    9.160185]  ksys_write+0xdf/0x1d0
[    9.160294]  __x64_sys_write+0x72/0xd0
[    9.160413]  x64_sys_call+0x79/0x2350
[    9.160536]  do_syscall_64+0x90/0x1210
[    9.160655]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    9.160810]
[    9.160865] The buggy address belongs to the object at ffff88810612a700
[    9.160865]  which belongs to the cache kmalloc-rnd-03-96 of size 96
[    9.161246] The buggy address is located 72 bytes inside of
[    9.161246]  freed 96-byte region [ffff88810612a700, ffff88810612a760)
[    9.161606]
[    9.161661] The buggy address belongs to the physical page:
[    9.161831] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0=
x0 pfn:0x10612a
[    9.162070] ksm flags: 0x17ffffc0000000(node=3D0|zone=3D2|lastcpupid=3D0=
x1fffff)
[    9.162278] page_type: f5(slab)
[    9.162382] raw: 0017ffffc0000000 ffff888100049400 ffffea00041ca640 dead=
000000000007
[    9.162616] raw: 0000000000000000 0000000000200020 00000000f5000000 0000=
000000000000
[    9.162846] page dumped because: kasan: bad access detected
[    9.163015]
[    9.163070] Memory state around the buggy address:
[    9.163218]  ffff88810612a600: fa fb fb fb fb fb fb fb fb fb fb fb fc fc=
 fc fc
[    9.163434]  ffff88810612a680: fa fb fb fb fb fb fb fb fb fb fb fb fc fc=
 fc fc
[    9.163656] >ffff88810612a700: fa fb fb fb fb fb fb fb fb fb fb fb fc fc=
 fc fc
[    9.163870]                                               ^
[    9.164039]  ffff88810612a780: fa fb fb fb fb fb fb fb fb fb fb fb fc fc=
 fc fc
[    9.164254]  ffff88810612a800: fa fb fb fb fb fb fb fb fb fb fb fb fc fc=
 fc fc
[    9.164474] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    9.164716] Disabling lock debugging due to kernel taint



