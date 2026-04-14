Return-Path: <stable+bounces-237776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPapC7MS3mkomwkAu9opvQ
	(envelope-from <stable+bounces-237776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:10:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8425E3F8799
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAB22305DF23
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B3039768E;
	Tue, 14 Apr 2026 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="J3baarwV"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44813B583D;
	Tue, 14 Apr 2026 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161228; cv=none; b=mEWsS4aQAkJBMLrqnXvB4t2GSM+cFNe4d5Dcn2GoPsfmW2v2JzpELT5PgcQVUSEzFlxE279WIAyvEGM6L1R8boB6IIJ9BcjgyTDOZHhaLk42hyD2uYJkG4X/DxYBpquI73P9AtGsxwHgvqvhfYc2wMwvQA4KeJ+B3uyGry0WOf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161228; c=relaxed/simple;
	bh=U7B3hY316QCp8VRZPEC0bI58dj4yGY1dZwbddcBFGx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOHS69ROluQUYx9itNNMDK0Jes8i8H7FFX9VM3ak/Rq0g+y90/zrLuWj5dip0RAhwwpJoXrad9cTNgMg5f7Jy7iffxEaC4NbUoa6BnBeO8V2OoM+mgswPPv3gz/qBhK7MtLVAc9GXetZ/VZ4ZdZMpbqwrGbz0AdW4fW6+QjbORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=J3baarwV; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EC2010CE86;
	Tue, 14 Apr 2026 12:07:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776161224;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=nDSQ1qVAQDKVPu+EdG4A07GNZkzB7xDnGkIuGtvgKU4=;
	b=J3baarwVurbP1YVzghseAT6rMJMudngQIBweegx/JTJmBHZWfLV71D6xr+DoiDZIiqZqUv
	1l2JCdzxdbdk3aU754Zh8/ek0ZshytkJnBjnFHXvu/lsI+1Z5Y4SAyvZ8teH18VG97AAq2
	m2xhe//rcd8hCUiUG9ZnTKcaKpCKEJj1B7tKb80vWtQJJoF9DZGk9O4NSbsjpTkiyp/fTE
	T8ErdEdNML+flLwpph1HdjbWp8yU8Hm5iid3YfuvtALAPvKQR0CQ02fyTS5mje5HcDOKVj
	5iY5BatTvP35UfyGurPx41QyDgJ2p8aYXw62E7mYEEZ8tIvyIE/5TQVMFlei0w==
Message-ID: <e2956a79-8f26-45f4-84e2-16932b4542cd@nabladev.com>
Date: Tue, 14 Apr 2026 12:07:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,PATCH v2] net: ks8851: Reinstate disabling of BHs around IRQ
 handler
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Nicolai Buchwitz <nb@tipi-net.de>, Paolo Abeni <pabeni@redhat.com>,
 Ronald Wahl <ronald.wahl@raritan.com>, Yicong Hui <yiconghui@gmail.com>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>
References: <20260408162535.98108-1-marex@nabladev.com>
 <20260412090141.21bf1534@kernel.org>
 <2558832d-c821-436d-898d-b708c5e0a228@nabladev.com>
 <20260412105125.48f0c58f@kernel.org> <20260413125744.TVKkZcEK@linutronix.de>
 <20260413084445.59fe28d6@kernel.org> <20260413161000.P_SLxmZl@linutronix.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260413161000.P_SLxmZl@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237776-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,google.com,tipi-net.de,redhat.com,raritan.com,gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8425E3F8799
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 6:10 PM, Sebastian Andrzej Siewior wrote:

>> TBH changing the driver feels like a workaround / invitation for a
>> whack-a-mole game. I'd prefer to fix the skb allocation.
> 
> The problem is that _irq() implicitly disables bh processing but this
> does not happen. Forcing this is possible but expensive.
> However, I did remove lock from bh_disable() on RT.
> 
> Marek: from which kernel version was this backtrace?
That was v6.12.79-rt17-rebase where it was easy to trigger , here is a 
fresh one from next-20260413 with b44596ffe1b4 ("ARM: Allow to enable 
RT") from stable-rt added on top:

"
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-1): P127/5:b..l
rcu:     (detected by 1, t=2102 jiffies, g=-503, q=1 ncpus=2)
task:irq/68-eth1     state:D stack:0     pid:127   tgid:127   ppid:2 
  task_flags:0x4208040 flags:0x00000000
Call trace:
  __schedule from schedule_rtlock+0x1c/0x34
  schedule_rtlock from rtlock_slowlock_locked+0x548/0x904
  rtlock_slowlock_locked from rt_spin_lock+0x60/0x9c
  rt_spin_lock from ks8851_start_xmit_par+0x74/0x1a8
  ks8851_start_xmit_par from netdev_start_xmit+0x20/0x44
  netdev_start_xmit from dev_hard_start_xmit+0xd0/0x188
  dev_hard_start_xmit from sch_direct_xmit+0xb8/0x25c
  sch_direct_xmit from __qdisc_run+0x1f8/0x4ec
  __qdisc_run from qdisc_run+0x1c/0x28
  qdisc_run from net_tx_action+0x1f0/0x268
  net_tx_action from handle_softirqs+0x1a4/0x270
  handle_softirqs from __local_bh_enable_ip+0xcc/0xe0
  __local_bh_enable_ip from __alloc_skb+0xd8/0x128
  __alloc_skb from __netdev_alloc_skb+0x3c/0x19c
  __netdev_alloc_skb from ks8851_irq+0x388/0x4d4
  ks8851_irq from irq_thread_fn+0x24/0x64
  irq_thread_fn from irq_thread+0x178/0x28c
  irq_thread from kthread+0x12c/0x138
  kthread from ret_from_fork+0x14/0x28
Exception stack(0xf4c99fb0 to 0xf4c99ff8)
9fa0:                                     00000000 00000000 00000000 
00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
"


