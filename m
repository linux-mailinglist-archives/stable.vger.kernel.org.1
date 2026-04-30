Return-Path: <stable+bounces-242053-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NSLwB4sY82nNxAEAu9opvQ
	(envelope-from <stable+bounces-242053-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:53:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A52849F772
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 696F43060AF1
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4213FFAB1;
	Thu, 30 Apr 2026 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Twr1yWIN"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8553FE66C
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538939; cv=none; b=IikfTCS/oBUooI/IfmQjXciVyTuhJjGFL4KSNIlw9OMjRPevuEsBca/tv8ehWpgilJA59XxB3eb8z6DGPVuJPtwTBB6SjS7yfODYi3bVrEdR1VBddbxT0Jq2KOTOO3iTGWLQt/eKTHKLkIBoVlc4lTshJdaxErYoaelD4NZMU34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538939; c=relaxed/simple;
	bh=qdAdKXxUlsUiaf9qb7BliKtaOtY8ru53LcgohbZBj6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlgscqRuDWsyW2/T2Ik2ugmBLmXGpIjwYCHRrf1kkz1np3Jt1QcC5oaIOZzfGC9AsTyX6MlKZvRwvknCR4b9cyT/7nwf1rADll65EqJTH8m91tVRHY94aQyde0RkhoT7PgS1/9z+7UJnnSSDtQSVdc6+SqfwOSrrDa9vkykaX/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Twr1yWIN; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38ddd8d3b7fso5354641fa.3
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 01:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777538936; x=1778143736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jb/ZGWJ/pWpZ6OwefSTqxwNybjL7BAQC3NrBy5oh+No=;
        b=Twr1yWINFh80hDImv/A2nXKqCswqYC8Ku8cXHZNQQa6FIYfB6ZeQMA66ch9+z0aNUL
         mc792PZKOfSbWajCWTdnAHFs3rGRDQVRqc+uedfqNdHL8MuyfK09jr38ul1OkYjjLakt
         HFFp9Ceall8rGmL6rceVNVC+BXIKFtGZjkC9Nt64pJ4qx83Sa70M0HmP9GCBzH4l2RYi
         MtvDYN1AfTYQf1NFKOZ1CQvPTz7Rrxdhdkf0+6HQeZQdInp25NUYYoDdwfg27J/BJKRL
         ey/jIyRJe8XKiSEpUQF4iEpRcKn9EIEt86T7GGhawGYpq+xGNLly6Hpb8c4+C+py++tn
         afWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777538936; x=1778143736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jb/ZGWJ/pWpZ6OwefSTqxwNybjL7BAQC3NrBy5oh+No=;
        b=BsWEPQvI7aYBUrPHN4gyviIKAqAXGBmOvWVtPJEsTeoHxpNs71aNZURXP+devi4aGh
         vmh8Dy6pGNUd2usiXP5mAkHbFSHkK64eb/XGfFL36V0vZCsPEoc1tY5anN+oRzxGhQYU
         b2JyAlqUYMEQ8kQ51CUnbsqj+wmoqvbnNskw0JU3jSx56gntMlll3XXcFYRN3y1eQ64k
         Ko2yDumb37DDsCF5UYW/6IfOnhEjSSl5haQQh4WSxPHQX1WnlmVpfx5zq+fX7GzQtFrR
         JhhR/8c1SzpevRsTq8Z75la9225/7TBmm1ik/zc9fOySyI4jPnBnmZ1KtM6lQD6RFQQU
         xpfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8SO4w32eMLWQAumlIc7BEf6C07xtutwqSt6RRlIlUBR9mUYoP5aUGBOJ0yY5FAlTFO1uau4d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV5p1mANSJk+hvK/8/ti/tJOUEKq8Sqi/EMVYlPrb7WvjGn3+Q
	husYt+cLWBoel4R9Mw+FxZs43SCgsZVUIZLi+HWY2/YlD0QIiEZXVwI3XHi/iA==
X-Gm-Gg: AeBDieuCNXdQojIZFSumzHJP8hn4hjnEowZ9SCDRhJmrevjEdAYXrJYqchdxUKPkkCx
	aVm3CnU2fGEm1/9RwTn2yCnuLw660BvhmC2lKAxmz4O+44sHmORG9SYnNPywkdcvOB6h//PMuvH
	5G0Q6VIlT588u0cgmHLeajebRMkR/gUL0i/y09r5WFA3PA2NsOqum4IT28593fkcy1SndOtTXSL
	kUNXtXUMc+Y/txU+V5l7TRMcaaTTQLjxQj9Bmi7d5f0VWTIkLWOTD05l8G7BJv+1U33tyRYq0BT
	HjlpX5v223zHkQP8Mi9S8TR5LWv6belbvYeSan7NEAngMf2/Wc93w5jQNkFfl4Nmaq27uZjFwUC
	BDOft0e7RLxapuG6q4ihO+gPY5s/b4ImQBfMB/lP3Oyg6NA7VmfpahThuvGpEEiIa5tkOOYyQrX
	mg3xAmOMRGMe0Tv6pMvzBEaKyVqhlwyzy1pGFe/GEAbHyu1mcBpReAZA==
X-Received: by 2002:a05:651c:50c:b0:38e:7a75:8763 with SMTP id 38308e7fff4ca-3934e1d6312mr8060611fa.18.1777538935709;
        Thu, 30 Apr 2026 01:48:55 -0700 (PDT)
Received: from foxbook (bfh75.neoplus.adsl.tpnet.pl. [83.28.45.75])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3934fc228e9sm3962301fa.42.2026.04.30.01.48.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 30 Apr 2026 01:48:55 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:48:50 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: bound wait command completion to avoid kdump
 deadlock
Message-ID: <20260430104850.352bd946.michal.pecio@gmail.com>
In-Reply-To: <20260430014817.2006885-1-desnesn@redhat.com>
References: <20260430014817.2006885-1-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5A52849F772
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242053-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, 29 Apr 2026 22:48:17 -0300, Desnes Nunes wrote:
> The following deadlock in the usb subsystem can be triggered during kdump:
> 
> systemd-udevd[402]: usb3: Worker [419] processing SEQNUM=2194 is taking a long time
> dracut-initqueue[432]: Timed out while waiting for udev queue to empty.
> systemd-udevd[402]: usb3: Worker [419] processing SEQNUM=2194 killed
> systemd-udevd[402]: usb3: Worker [419] terminated by signal 9 (KILL).
> ...
> kdump[720]: saving vmcore complete
> ...
> systemd-shutdown[1]: Rebooting.
> INFO: task kworker/0:6:76 blocked for more than 122 seconds.

That's suspiciously long indeed.

>       Not tainted 6.12.0-223.2443_2475543665.el10.x86_64 #1

Pretty old kernel, and distribution to boot.
Have you tried 7.x, does the bug still exist?

> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/0:6     state:D stack:0     pid:76    tgid:76    ppid:2      task_flags:0x4208060 flags:0x00004000
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  <TASK>
>  __schedule+0x2a5/0x630
>  schedule+0x27/0x80
>  schedule_timeout+0xbf/0x100
>  __wait_for_common+0x95/0x1b0
>  ? __pfx_schedule_timeout+0x10/0x10
>  xhci_alloc_dev+0x9e/0x290
>  usb_alloc_dev+0x77/0x3a0
>  hub_port_connect+0x293/0x9a0
>  hub_port_connect_change+0x94/0x260
>  port_event+0x4d1/0x7f0
>  hub_event+0x16f/0x480
>  process_one_work+0x174/0x330
>  worker_thread+0x256/0x3a0
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xfa/0x240
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x31/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> INFO: task systemd-shutdow:1 blocked for more than 122 seconds.
>       Not tainted 6.12.0-223.2443_2475543665.el10.x86_64 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:systemd-shutdow state:D stack:0     pid:1     tgid:1     ppid:0      task_flags:0x400100 flags:0x00000002
> Call Trace:
>  <TASK>
>  __schedule+0x2a5/0x630
>  schedule+0x27/0x80
>  schedule_preempt_disabled+0x15/0x30
>  __mutex_lock.constprop.0+0x497/0x860
>  device_shutdown+0xac/0x190
>  kernel_restart+0x3a/0x70
>  __do_sys_reboot+0x146/0x240
>  do_syscall_64+0x7d/0x160
>  ? devkmsg_write.cold+0x24/0x4a
>  ? update_load_avg+0x7f/0x730
>  ? __dequeue_entity+0x3ec/0x4a0
>  ? update_load_avg+0x7f/0x730
>  ? pick_next_task_fair+0x1e6/0x330
>  ? finish_task_switch.isra.0+0x97/0x2a0
>  ? rseq_get_rseq_cs+0x1d/0x220
>  ? rseq_ip_fixup+0x8d/0x1d0
>  ? arch_exit_to_user_mode_prepare.isra.0+0xa5/0xd0
>  ? syscall_exit_to_user_mode+0x32/0x190
>  ? do_syscall_64+0x89/0x160
>  ? handle_mm_fault+0x110/0x370
>  ? do_user_addr_fault+0x606/0x830
>  ? exc_page_fault+0x7f/0x150
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f32517d9917
> RSP: 002b:00007ffc018d4fb8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a9
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f32517d9917
> RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
> RBP: 00007ffc018d5130 R08: 0000000000000069 R09: 00000000ffffffff
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007ffc018d5258 R15: 0000000000000000
>  </TASK>
> 
> During crashkernel's boot, hub_event() takes usb_lock_device(hdev) of the
> root hub and keeps it for the whole hub processing loop, since it calls
> hub_port_connect() -> usb_alloc_dev() -> xhci_alloc_dev(). If during kdump
> another device (e.g., a mis-initialized dGPU) hogs interrupts or DMAs, the
> TRB_ENABLE_SLOT command will be blocked from completion in time, moving
> the HC to an unstable condition (e.g., HSE in USBSTS).

What specifically have you seen?

If you have actually observed HSE (how?), maybe xhci-hcd could detect
it automatically by the same means and clean up immediately.

> After vmcore gets captured, init calls device_shutdown() trying to
> shut down the hub device, by also trying to take the same lock still
> held by the hub kworker task.
> 
> Avoid the deadlock by adding a 2x timeout for command completion

nit: not a deadlock if X waits for Y and Y is just stuck by itself.

> before calling xhci_hc_died(). This gives enough time before marking
> the host un- stable, dying and calling xhci_cleanup_command_queue();
> which unblocks the hub worker into releasing the lock, allowing
> device_shutdown() to proceed.

Many functions which wait for command completion without timeouts.
Patch this one and you will get stuck in the next.

This shouldn't be happening in the first place. If a command doesn't
complete normally in time then xhci_handle_command_timeout() should
abort it, and if that times out too, then hc_died().

So not sure why this hasn't happened here.
Is it reproducible? Can you try again with debug logs?

echo 'module xhci_hcd +p' >/proc/dynamic_debug/control

Regards,
Michal

