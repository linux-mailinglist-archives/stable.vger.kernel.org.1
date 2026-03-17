Return-Path: <stable+bounces-225727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAkiAsesuGkdhgEAu9opvQ
	(envelope-from <stable+bounces-225727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 02:22:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 892892A2849
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 02:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87D123008316
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 01:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C783128DF;
	Tue, 17 Mar 2026 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="rSdSzHI0"
X-Original-To: stable@vger.kernel.org
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECB230EF82
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 01:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773710530; cv=none; b=nq+ledSoJy4Et79yhdpCdHMz8QY2HwTI9umtTPjvaPUjCovf2Fdk7ClS5evHbcJNPOvm5oAIi8pbkzMBpGb/dx/9++TPCL5DM3YAPm/4lb9BJTJetIURskt3Kle5aN5GlWameHhLG+vTRlpk7TsDHE+954h185/gxJhgkNtnZF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773710530; c=relaxed/simple;
	bh=bbYazO1YJBdsl5LQeX8wJSEAgQy5xtzCt3DlybkzNZ0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVt0Ii0CduLzjqNvd+dUZdF4G+0szYCiL5oHHt3BZwggfy6o0T5MRnDm6DA5XIF2sOD/9RJ+jJ0PuZrKLFtUGuVAqi5B/pxiQiOeetwVpfiq8ifCzxHWi667p9F2w5Yjihe2UqkwVa1p1Nvj8NluUw3s8z/l79TR5kIAgYunZmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=rSdSzHI0; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1773710523; x=1773969723;
	bh=2XPh0ZVkdCRcFbJcCObzYxJgmkidck/ORjziJmZ4GiA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rSdSzHI0gJcEI2tx+pJ0pvHuowh9t9bP5JLZJfDdH3eVO0w9AAmDSGMivPEnILN3i
	 +bkwON8EbAax0EogRa7AZE5TzYmtr6qH8JNdlqfKJgTs01nwzjrnfSjCBnnFilkHwb
	 kqRX4m+QXigWcP3l+aCGS5XDJbWgfJYBF+WQ3t7rgCD7Hn9MbHQJPgJN97xLrtrA9w
	 dVMxHOIPP8tTwfeB7D7B7FYY3aAcL5Wmi9OANJ0MeVJpUNH1EQam78XXtxpjtjvVrJ
	 v02Nh3y+11HPO1uQI/T7XiyM1SA/bl7R2sZ00IwE/tXed87rhFls93YsNoDcIl/82t
	 e6RYASaTGAw5A==
Date: Tue, 17 Mar 2026 01:22:01 +0000
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>, Parav Pandit <parav@nvidia.com>
From: Paul Moses <p@1g4.org>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: Re: [PATCH] vdpa: don't free reply skb after genlmsg_reply()
Message-ID: <lPMoA-jSSWoNN42ejMYoDHQJVt5KGYsPsJez_Luu8zmwUWQectet-GVqS2EF89-I3k2PddYnY-ZD6z7yCQvK_AF8naIatQV1mD5Xq2671EY=@1g4.org>
In-Reply-To: <20260312110421.2880401-1-p@1g4.org>
References: <20260312110421.2880401-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 6abf897a47d9c69478b255d33049d5311cce72d5
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225727-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[1g4.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qemu.org:url]
X-Rspamd-Queue-Id: 892892A2849
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that I've wrapped up elsewhere, I can focus on this. Let me=20
know if there's any questions.

Thanks,
Paul

[    0.716942] ------------[ cut here ]------------
[    0.717160] refcount_t: underflow; use-after-free.
[    0.717356] WARNING: CPU: 2 PID: 138 at lib/refcount.c:28 refcount_warn_=
saturate+0x118/0x180
[    0.717661] Modules linked in:
[    0.717816] CPU: 2 UID: 1000 PID: 138 Comm: poc9 Not tainted 6.18.13 #3 =
PREEMPT(full)=20
[    0.718138] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    0.718591] RIP: 0010:refcount_warn_saturate+0x118/0x180
[    0.718805] Code: 0f b6 05 aa bf 05 02 3c 01 0f 87 d7 db 5d ff a8 01 0f =
85 39 ff ff ff 48 c7 c7 78 71 ec 82 c6 05 8c bf 05 02 01 e8 78 f0 78 ff <0f=
> 0b c9 31 c0 31 f6 31 ff e9 55 4c 45 ff 0f b6 05 73 bf 05 02 3c
[    0.719521] RSP: 0018:ffffc9000048b790 EFLAGS: 00010246
[    0.719722] RAX: 0000000000000000 RBX: ffff888006c74200 RCX: 00000000000=
00000
[    0.719985] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[poc9-vdpa] port[    0.720257] RBP: ffffc9000048b798 R08: 0000000000000000 =
R09: 0000000000000000
id=3D135 rcvbuf=3D23[    0.720580] R10: 0000000000000000 R11: 0000000000000=
000 R12: ffff8880075ea000
04 soerr=3D105 dro[    0.720869] R13: ffff888006c74200 R14: 00000000fffffff=
5 R15: ffffc9000048b920
ps=3D0 get 2/0 sen[    0.721165] FS:  000076880ed826c0(0000) GS:ffff88809a4=
60000(0000) knlGS:0000000000000000
d_eagain=3D0
[    0.721534] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.721768] CR2: 000076880ed801c8 CR3: 0000000008a61000 CR4: 00000000004=
50ef0
[    0.722055] PKRU: 55555554
[    0.722159] Call Trace:
[    0.722253]  <TASK>
[    0.722339]  sk_skb_reason_drop+0x203/0x210
[    0.722512]  ? up_read+0x22/0x30
[    0.722638]  vdpa_nl_cmd_dev_config_get_doit+0xc7/0x1d0
[    0.722832]  genl_family_rcv_msg_doit+0xcf/0x120
[    0.723018]  genl_rcv_msg+0x161/0x290
[    0.723157]  ? __pfx_vdpa_nl_cmd_dev_config_get_doit+0x10/0x10
[    0.723381]  ? __pfx_genl_rcv_msg+0x10/0x10
[    0.727944]  netlink_rcv_skb+0x41/0xf0
[    0.728136]  genl_rcv+0x28/0x50
[    0.728281]  netlink_unicast+0x1d8/0x2b0
[    0.728483]  netlink_sendmsg+0x212/0x440
[    0.728673]  __sys_sendto+0x1f3/0x200
[    0.728859]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.729076]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.729287]  ? __lock_acquire+0x831/0x2980
[    0.729491]  __x64_sys_sendto+0x24/0x40
[    0.729665]  x64_sys_call+0x1d15/0x2350
[    0.729838]  do_syscall_64+0x90/0xc60
[    0.730010]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.730226]  ? lock_acquire+0xcc/0x2e0
[    0.730391]  ? __folio_batch_add_and_move+0x24b/0x370
[    0.730623]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.730835]  ? find_held_lock+0x31/0x90
[    0.731010]  ? __folio_batch_add_and_move+0x1ab/0x370
[    0.731238]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.731465]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.731677]  ? find_held_lock+0x31/0x90
[    0.731851]  ? rcu_read_unlock+0x1f/0x80
[    0.732029]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.732247]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.732474]  ? rcu_read_unlock+0x29/0x80
[    0.732652]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.732864]  ? do_anonymous_page+0x101/0x840
[    0.733055]  ? ___pte_offset_map+0x1d2/0x290
[    0.733255]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.733482]  ? __handle_mm_fault+0xa8e/0xf40
[    0.733693]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.733904]  ? find_held_lock+0x31/0x90
[    0.734079]  ? exc_page_fault+0x98/0x2c0
[    0.734257]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.734490]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.734709]  ? do_user_addr_fault+0x37b/0x6e0
[    0.734905]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.735118]  ? irqentry_exit_to_user_mode+0xf4/0x300
[    0.735340]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.735566]  ? irqentry_exit+0x77/0xb0
[    0.735737]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.735949]  ? exc_page_fault+0xbf/0x2c0
[    0.736124]  ? srso_alias_return_thunk+0x5/0xfbef5
[    0.736340]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    0.736576] RIP: 0033:0x434e6c
[    0.736720] Code: fa 6e 03 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c3 44 8b =
54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48=
> 3d 00 f0 ff ff 77 34 89 df 48 89 44 24 08 e8 40 6f 03 00 48 8b
[    0.737513] RSP: 002b:000076880ed80190 EFLAGS: 00000293 ORIG_RAX: 000000=
000000002c
[    0.737841] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004=
34e6c
[    0.738154] RDX: 0000000000000020 RSI: 000076880ed801d0 RDI: 00000000000=
00003
[    0.738473] RBP: 0000000069b8ab57 R08: 00000000004b3cf0 R09: 00000000000=
0000c
[    0.738767] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000f7=
1e860
[    0.739075] R13: 0000000000000013 R14: 000076880ed82cdc R15: 00007fff0da=
b68e7
[    0.739415]  </TASK>
[    0.739526] irq event stamp: 785
[    0.739675] hardirqs last  enabled at (793): [<ffffffff815153f0>] __up_c=
onsole_sem+0x90/0xa0
[    0.740039] hardirqs last disabled at (800): [<ffffffff815153d5>] __up_c=
onsole_sem+0x75/0xa0
[    0.740410] softirqs last  enabled at (362): [<ffffffff81449bcd>] __irq_=
exit_rcu+0x12d/0x150
[    0.740782] softirqs last disabled at (357): [<ffffffff81449bcd>] __irq_=
exit_rcu+0x12d/0x150
[    0.741145] ---[ end trace 0000000000000000 ]---
[poc9-vdpa] portid=3D135 rcvbuf=3D2304 soerr=3D0 drops=3D0 get 98859/0 send=
_eagain=3D0
[poc9-vdpa] portid=3D135 rcvbuf=3D2304 soerr=3D0 drops=3D0 get 204383/0 sen=
d_eagain=3D0
[poc9-vdpa] portid=3D135 rcvbuf=3D2304 soerr=3D0 drops=3D0 get 319574/0 sen=
d_eagain=3D0
[    4.037387] BUG: kernel NULL pointer dereference, address: 0000000000000=
060
[    4.037612] #PF: supervisor read access in kernel mode
[    4.037761] #PF: error_code(0x0000) - not-present page
[    4.037914] PGD 994c067 P4D 994c067 PUD 994d067 PMD 0=20
[    4.038066] Oops: Oops: 0000 [#1] SMP NOPTI
[    4.038191] CPU: 4 UID: 1000 PID: 140 Comm: poc9 Tainted: G        W    =
       6.18.13 #3 PREEMPT(full)=20
[    4.038463] Tainted: [W]=3DWARN
[    4.038557] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    4.038869] RIP: 0010:sock_wfree+0x1d/0x3f0
[    4.038994] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 =
55 48 89 e5 41 57 41 56 53 48 83 ec 10 48 8b 5f 18 44 8b 97 d8 00 00 00 <48=
> 8b 43 60 f6 c4 02 74 51 44 89 d0 44 89 d2 48 8d 8b 94 02 00 00
[    4.039511] RSP: 0018:ffffc9000049b8f0 EFLAGS: 00010286
[    4.039665] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[    4.039874] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88801f8=
aa100
[    4.040076] RBP: ffffc9000049b918 R08: 0000000000000000 R09: 00000000000=
00000
[    4.040278] R10: 00000000000003c0 R11: 0000000000000000 R12: ffff8880075=
ea000
[    4.040482] R13: ffff88801f8aa100 R14: 00000000fffffff5 R15: ffffc900004=
9baf0
[    4.040685] FS:  000076880dd806c0(0000) GS:ffff88809a560000(0000) knlGS:=
0000000000000000
[    4.040908] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.041071] CR2: 0000000000000060 CR3: 0000000008a61000 CR4: 00000000004=
50ef0
[    4.041275] PKRU: 55555554
[    4.041356] Call Trace:
[    4.041434]  <TASK>
[    4.041502]  unix_destruct_scm+0x77/0x90
[    4.041620]  skb_release_head_state+0x27/0xb0
[    4.041750]  sk_skb_reason_drop+0x55/0x210
[    4.041868]  ? up_read+0x22/0x30
[    4.041976]  vdpa_nl_cmd_dev_config_get_doit+0xc7/0x1d0
[    4.042140]  genl_family_rcv_msg_doit+0xcf/0x120
[    4.042280]  genl_rcv_msg+0x161/0x290
[    4.042387]  ? __pfx_vdpa_nl_cmd_dev_config_get_doit+0x10/0x10
[    4.042558]  ? __pfx_genl_rcv_msg+0x10/0x10
[    4.042679]  netlink_rcv_skb+0x41/0xf0
[    4.042798]  genl_rcv+0x28/0x50
[    4.042892]  netlink_unicast+0x1d8/0x2b0
[    4.043009]  netlink_sendmsg+0x212/0x440
[    4.043127]  __sys_sendto+0x1f3/0x200
[    4.043238]  ? __sys_sendto+0x1aa/0x200
[    4.043351]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.043493]  ? x64_sys_call+0x1d15/0x2350
[    4.043610]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.043747]  ? do_syscall_64+0x1b5/0xc60
[    4.043867]  __x64_sys_sendto+0x24/0x40
[    4.043979]  x64_sys_call+0x1d15/0x2350
[    4.044091]  do_syscall_64+0x90/0xc60
[    4.044200]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.044337]  ? x64_sys_call+0x1d15/0x2350
[    4.044456]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.044597]  ? do_syscall_64+0x1b5/0xc60
[    4.044712]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.044851]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.044990]  ? x64_sys_call+0x1d15/0x2350
[    4.045106]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.045243]  ? do_syscall_64+0x1b5/0xc60
[    4.045358]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.045498]  ? x64_sys_call+0x1d15/0x2350
[    4.045614]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.045750]  ? do_syscall_64+0x1b5/0xc60
[    4.045863]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.046007]  ? do_syscall_64+0x1b5/0xc60
[    4.046121]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.046259]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    4.046407] RIP: 0033:0x434e6c
[    4.046500] Code: fa 6e 03 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c3 44 8b =
54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48=
> 3d 00 f0 ff ff 77 34 89 df 48 89 44 24 08 e8 40 6f 03 00 48 8b
[    4.047008] RSP: 002b:000076880dd7e190 EFLAGS: 00000293 ORIG_RAX: 000000=
000000002c
[    4.047218] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004=
34e6c
[    4.047420] RDX: 0000000000000020 RSI: 000076880dd7e1d0 RDI: 00000000000=
00003
[    4.047618] RBP: 0000000069b93bd6 R08: 00000000004b3cf0 R09: 00000000000=
0000c
[    4.047816] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000f7=
1e860
[    4.048023] R13: 0000000000000013 R14: 000076880dd80cdc R15: 00007fff0da=
b68e7
[    4.048228]  </TASK>
[    4.048295] Modules linked in:
[    4.048387] CR2: 0000000000000060
[    4.048494] ---[ end trace 0000000000000000 ]---
[    4.059378] RIP: 0010:sock_wfree+0x1d/0x3f0
[    4.059511] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 =
55 48 89 e5 41 57 41 56 53 48 83 ec 10 48 8b 5f 18 44 8b 97 d8 00 00 00 <48=
> 8b 43 60 f6 c4 02 74 51 44 89 d0 44 89 d2 48 8d 8b 94 02 00 00
[    4.060019] RSP: 0018:ffffc9000049b8f0 EFLAGS: 00010286
[    4.060168] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[    4.060367] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88801f8=
aa100
[    4.060574] RBP: ffffc9000049b918 R08: 0000000000000000 R09: 00000000000=
00000
[    4.060776] R10: 00000000000003c0 R11: 0000000000000000 R12: ffff8880075=
ea000
[    4.060978] R13: ffff88801f8aa100 R14: 00000000fffffff5 R15: ffffc900004=
9baf0
[    4.061183] FS:  000076880dd806c0(0000) GS:ffff88809a560000(0000) knlGS:=
0000000000000000
[    4.061416] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.061579] CR2: 0000000000000060 CR3: 0000000008a61000 CR4: 00000000004=
50ef0
[    4.061782] PKRU: 55555554
[    4.061863] Kernel panic - not syncing: Fatal exception
[    4.062096] Kernel Offset: disabled
[    4.062204] Rebooting in 1 seconds..


