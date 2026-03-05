Return-Path: <stable+bounces-223262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP22I9HIqWkAFAEAu9opvQ
	(envelope-from <stable+bounces-223262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 19:17:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4857216E76
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 19:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36A1A3055131
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 18:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD03366829;
	Thu,  5 Mar 2026 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="Ou/TDkrM"
X-Original-To: stable@vger.kernel.org
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B61028F935;
	Thu,  5 Mar 2026 18:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772734611; cv=none; b=b8v8OqCBH7CelrUtFGQgGyGIg20oEZFrb/Xo6goaJ8kS4C7t5sMVETWNNC711aGVqDW7fjKMbemEnVi73+XQxDm9Y8N6SaTOyRaCpLpWCFFoVYP3MG6clsteYL/ni5EbFemrP759O0kqJPdceTW7aPpaw0Fh7+7iVOTkRj4YzbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772734611; c=relaxed/simple;
	bh=GfOGwik5Opx0aeOvPuRj8bD7GHXsHERBHqkfVZ99288=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIUmyhoDCI2tvJe7GyFuQ6dn+He6PJMAISmENoS/7/r+q8cWy2aeiYDaYjw2HLpY9AhvBPnptinMECI1a8NU0Jx4w9Wg92LUZiDJ9O3qJpm1CfV2HtI5VJ6HdW98srrBuUnli6Hg3TI9Q+oKL43V2OiSfTbHY7YnhNztCWUCnsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=Ou/TDkrM; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1772734607; bh=GfOGwik5Opx0aeOvPuRj8bD7GHXsHERBHqkfVZ99288=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ou/TDkrMlLDIZNlXGXUWGaG1p9opvR95ZrZxJ8t+WLjkEKl+zTVCaWskpCV7OvYbe
	 dIIJxuB504uTHp/LHB5bygr9naJDwNEsy1mKBzmZKAljoEbFllxMiujg/wzSIdKlIx
	 d3tpWXOk1htnMMvZC2QRh1qfoaWAI6T3TSAbBNOIfrIicN6j37fAtFH1V76HR4DWzb
	 2ycXBSFb3FnAfyjgjfz2zRw1m7l5jrf+2ihu0jQluNz+MU+0y16d3Hs4y+mz9AWf85
	 EnwFgDdnfvpUon3mN1rFS0pe0ovvSmc3KOm0+xrDNO2ImHhnBkdgg3/sdBTQVk8T1M
	 xelDkicN2ncCg==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4fRd672N7BzcZ;
	Thu, 05 Mar 2026 19:16:47 +0100 (CET)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.3 at mail
Date: Thu, 5 Mar 2026 19:16:46 +0100
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Yu Kuai <yukuai@fnnas.com>
Cc: Jack Wang <jinpu.wang@ionos.com>, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: md/bitmap: fix GPF in write_page caused by resize race
Message-ID: <aanIjoMTAicc2ubf@qmqm.qmqm.pl>
References: <aamyMEUBy4Lcgecg@qmqm.qmqm.pl>
 <b18b12cb-0a26-49cf-bddf-1f053d02743f@fnnas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5JO/CjtXaWF32El6"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b18b12cb-0a26-49cf-bddf-1f053d02743f@fnnas.com>
X-Rspamd-Queue-Id: D4857216E76
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.45 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[rere.qmqm.pl,reject];
	R_DKIM_ALLOW(-0.20)[rere.qmqm.pl:s=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223262-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[rere.qmqm.pl:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mirq-linux@rere.qmqm.pl,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action


--5JO/CjtXaWF32El6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Mar 06, 2026 at 12:53:31AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2026/3/6 0:41, Michał Mirosław 写道:
> > Hi,
> >
> > Commit 5f73c8b33df9 ("md/bitmap: fix GPF in write_page caused by resize
> > race") in stable 6.19 killed my machine. I confirmed that after reverting
> > this commit the machine boots fine. The same commit was backported into
> > 6.18 stable and shows the same symptoms. I tried the revert only with 6.19,
> > though, as that revived my workflow.
> >
> > For context, I have several md devices, some with internal bitmaps and
> > dm-crypt on top.  md3 and md4 belong to a single LVM VG. In the locked
> > up state I was able to see `mdadm`, some `udev-trigger` and `mount` tasks
> > all hanging in D state.
> 
> Thanks for the report. Do you have the log of task stack of these tasks?
> This will be very helpful to locate the root cause.

Unfortunately not, I had sysrq debugging functions disabled in the
kernel. I saved the 'hung task' report from dmesg, but it seems only for
the udev-worker threads, not for the mdadm one (attached).

Best Regards
Michał Mirosław

--5JO/CjtXaWF32El6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hung-tasks.log"

[    0.000000] Linux version 6.19.6+ (mirq@qmqm) (gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #16 SMP PREEMPT Wed Mar  4 21:31:45 CET 2026
....
[  368.429309] INFO: task (udev-worker):1014 blocked for more than 122 seconds.
[  368.429417]       Tainted: G           OE       6.19.6+ #16
[  368.429525]       Blocked by coredump.
[  368.429631] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  368.429743] task:(udev-worker)   state:D stack:0     pid:1014  tgid:1014  ppid:940    task_flags:0x40054c flags:0x00080803
[  368.429862] Call Trace:
[  368.429975]  <TASK>
[  368.430095]  __schedule+0x5f9/0x1b70
[  368.430208]  ? rcu_is_watching+0xd/0x40
[  368.430321]  ? lock_acquire+0x28c/0x2f0
[  368.430431]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.430544]  ? schedule+0xec/0x120
[  368.430655]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.430767]  ? rcu_is_watching+0xd/0x40
[  368.430877]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.430988]  ? lock_release+0x22f/0x410
[  368.431099]  ? rcu_is_watching+0xd/0x40
[  368.431213]  schedule+0x39/0x120
[  368.431326]  io_schedule+0x42/0x70
[  368.431439]  folio_wait_bit_common+0x119/0x2f0
[  368.431554]  ? folio_wait_bit_common+0xe4/0x2f0
[  368.431668]  ? filemap_invalidate_unlock_two+0x40/0x40
[  368.431784]  truncate_inode_pages_range+0x3f2/0x440
[  368.431902]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.432015]  ? filemap_get_folios_tag+0x37c/0x460
[  368.432133]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.432246]  ? __filemap_fdatawait_range+0x69/0xe0
[  368.432362]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.432475]  ? rcu_is_watching+0xd/0x40
[  368.432588]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.432711]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.432823]  ? smp_call_function_many_cond+0x10d/0x750
[  368.432936]  ? ioctl_fssetxattr+0xf0/0xf0
[  368.433049]  ? buffer_exit_cpu_dead+0xa0/0xa0
[  368.433164]  ? buffer_exit_cpu_dead+0xa0/0xa0
[  368.433288]  ? ioctl_fssetxattr+0xf0/0xf0
[  368.433400]  blkdev_flush_mapping+0x54/0x100
[  368.433514]  bdev_release+0x1ef/0x200
[  368.433632]  blkdev_release+0xd/0x20
[  368.433742]  __fput+0xfe/0x2c0
[  368.433852]  task_work_run+0x58/0x90
[  368.433962]  do_exit+0x2b6/0xa90
[  368.434071]  ? get_signal+0x54e/0xbc0
[  368.434179]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.434289]  ? rcu_is_watching+0xd/0x40
[  368.434398]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.434509]  do_group_exit+0x32/0xa0
[  368.434619]  get_signal+0xb98/0xbc0
[  368.434726]  ? blkdev_read_iter+0x83/0x160
[  368.434834]  arch_do_signal_or_restart+0x29/0x210
[  368.434945]  exit_to_user_mode_loop+0x68/0x480
[  368.435051]  do_syscall_64+0x3d6/0x1180
[  368.435154]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.435254]  ? irqentry_exit+0x2a0/0x620
[  368.435356]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
[  368.435458] RIP: 0033:0x7fde77e9b687
[  368.435559] RSP: 002b:00007fff33820930 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
[  368.435666] RAX: fffffffffffffffc RBX: 00007fde77c6e980 RCX: 00007fde77e9b687
[  368.435780] RDX: 0000000000001000 RSI: 00007fde77c41000 RDI: 0000000000000025
[  368.435887] RBP: 000000aea8cdc000 R08: 0000000000000000 R09: 0000000000000000
[  368.436001] R10: 0000000000000000 R11: 0000000000000202 R12: 000055d2e8e3f120
[  368.436110] R13: 0000000000000000 R14: 000055d2e8e3f180 R15: 000055d2e8e81698
[  368.436225]  </TASK>
[  368.436331] INFO: task (udev-worker):1034 blocked for more than 122 seconds.
[  368.436443]       Tainted: G           OE       6.19.6+ #16
[  368.436555]       Blocked by coredump.
[  368.436666] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  368.436782] task:(udev-worker)   state:D stack:0     pid:1034  tgid:1034  ppid:940    task_flags:0x40054c flags:0x00080803
[  368.436905] Call Trace:
[  368.437021]  <TASK>
[  368.437137]  __schedule+0x5f9/0x1b70
[  368.437253]  ? rcu_is_watching+0xd/0x40
[  368.437370]  ? lock_acquire+0x28c/0x2f0
[  368.437485]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.437602]  ? schedule+0xec/0x120
[  368.437717]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.437833]  ? rcu_is_watching+0xd/0x40
[  368.437948]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.438065]  ? lock_release+0x22f/0x410
[  368.438181]  ? rcu_is_watching+0xd/0x40
[  368.438299]  schedule+0x39/0x120
[  368.438417]  io_schedule+0x42/0x70
[  368.438545]  folio_wait_bit_common+0x119/0x2f0
[  368.438663]  ? folio_wait_bit_common+0xe4/0x2f0
[  368.438782]  ? filemap_invalidate_unlock_two+0x40/0x40
[  368.438902]  truncate_inode_pages_range+0x3f2/0x440
[  368.439023]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.439142]  ? filemap_get_folios_tag+0x37c/0x460
[  368.439265]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.439390]  ? __filemap_fdatawait_range+0x69/0xe0
[  368.439512]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.439632]  ? rcu_is_watching+0xd/0x40
[  368.439751]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.439873]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.439991]  ? smp_call_function_many_cond+0x10d/0x750
[  368.440110]  ? ioctl_fssetxattr+0xf0/0xf0
[  368.440229]  ? buffer_exit_cpu_dead+0xa0/0xa0
[  368.440351]  ? buffer_exit_cpu_dead+0xa0/0xa0
[  368.440469]  ? ioctl_fssetxattr+0xf0/0xf0
[  368.440592]  blkdev_flush_mapping+0x54/0x100
[  368.440712]  bdev_release+0x1ef/0x200
[  368.440831]  blkdev_release+0xd/0x20
[  368.440948]  __fput+0xfe/0x2c0
[  368.441064]  task_work_run+0x58/0x90
[  368.441185]  do_exit+0x2b6/0xa90
[  368.441311]  ? get_signal+0x54e/0xbc0
[  368.441423]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.441535]  ? rcu_is_watching+0xd/0x40
[  368.441646]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.441759]  do_group_exit+0x32/0xa0
[  368.441869]  get_signal+0xb98/0xbc0
[  368.441976]  ? blkdev_read_iter+0x83/0x160
[  368.442084]  arch_do_signal_or_restart+0x29/0x210
[  368.442195]  exit_to_user_mode_loop+0x68/0x480
[  368.442302]  do_syscall_64+0x3d6/0x1180
[  368.442405]  ? rcu_preempt_deferred_qs+0xe/0x50
[  368.442506]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.442607]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.442714]  ? __ct_user_enter+0xb4/0x150
[  368.442815]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.442916]  ? do_syscall_64+0x1cc/0x1180
[  368.443018]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.443120]  ? do_syscall_64+0x1cc/0x1180
[  368.443221]  ? srso_alias_return_thunk+0x5/0xfbef5
[  368.443323]  ? irqentry_exit+0x2a0/0x620
[  368.443426]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
[  368.443528] RIP: 0033:0x7fde77e9b687
[  368.443629] RSP: 002b:00007fff33820930 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
[  368.443737] RAX: fffffffffffffffc RBX: 00007fde77c6e980 RCX: 00007fde77e9b687
[  368.443845] RDX: 0000000000001000 RSI: 00007fde77c40000 RDI: 000000000000002d
[  368.443962] RBP: 0000000000001000 R08: 0000000000000000 R09: 0000000000000000
[  368.444070] R10: 0000000000000000 R11: 0000000000000202 R12: 000055d2e8e3f120
[  368.444180] R13: 0000000000000000 R14: 000055d2e8e3f180 R15: 000055d2e8eab518
[  368.444295]  </TASK>

--5JO/CjtXaWF32El6--

