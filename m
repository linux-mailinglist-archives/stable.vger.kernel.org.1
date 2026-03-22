Return-Path: <stable+bounces-227859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOoyL1ZiwGkHHQQAu9opvQ
	(envelope-from <stable+bounces-227859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 22:42:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F2D2EAE58
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 22:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1E103002F6E
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 21:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5880D136672;
	Sun, 22 Mar 2026 21:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0NLdGuB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A49D3B7A8;
	Sun, 22 Mar 2026 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215759; cv=none; b=SC94BXdg3E/c7AFyyzcTOy3hdiLglFmb+IpMhGeK+tNo9ick8XpnkA8Y7KMPldM2m8tDGKlrAHg+DcY0c7JHCyXrMT7dvC64vJlHwbctSefOm6lDhte1tdObxy+whj/WknQ8NMKYQrRohPcStKtz6RjJYnJlrb725RvHvjiAMuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215759; c=relaxed/simple;
	bh=ooMoZ9jh24CJIzH3d+V2rP+5LA0wTUI70qyRaaUcwfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y8VsBX+bPozJxOf/g5E3kKvVqnhER1Ckg4+NIXeyPYpuFLQYxOlBiph4Qfo6gAo0Gs9/zuYS5LKQ3PbD7ySzTa3LFgpMr6m7/5XTsZ5LzP665Gql7HMFw4Egxam8iL4uRV99P4kbBT/hs5OGwYKrMSytqXZWBadjhJSiuGlk5bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0NLdGuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3828DC19424;
	Sun, 22 Mar 2026 21:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774215758;
	bh=ooMoZ9jh24CJIzH3d+V2rP+5LA0wTUI70qyRaaUcwfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=f0NLdGuBd8WWucri/vvQc6MkkpydN2mIlO3h9Yjht+gJHhWg6ANBgi7Ah/e0ERa4s
	 cWtXLwNdd9L0B2BaYJwcFrlvQXsqoyb2EK8FqLSu5Oj5YkYcP72+VNaeQCiWXnd5os
	 LZu1WWmMmjxCVIDI0HnzwZWUi2bU+W8Tm2ucy1/dMDARnH5ho6QplDDiLFQUHo2EqQ
	 YYOwrPcpfL/LbAJVNxq/LVGMWsJnmOvLG/sbeC993jzjJl0cmPnMkz72OGd1ZaqX4+
	 Pn9jB9XXDyDL+o8b3aEVTXOfwAenqE6mulnDnwgeetuclKZ/I+PaOT7fWV2VfMaauV
	 xHghLq1/QI5rA==
From: Thomas Gleixner <tglx@kernel.org>
To: Hao-Yu Yang <naup96721@gmail.com>, security@kernel.org
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] futex: Use-after-free between futex_key_to_node_opt
 and vma_replace_policy
In-Reply-To: <ab8wX/vk3An6bFA8@naup-virtual-machine>
References: <20260313124756.52461-1-naup96721@gmail.com>
 <ab8wX/vk3An6bFA8@naup-virtual-machine>
Date: Sun, 22 Mar 2026 22:42:35 +0100
Message-ID: <87cy0vilro.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227859-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0F2D2EAE58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22 2026 at 07:57, Hao-Yu Yang wrote:

> On Fri, Mar 13, 2026 at 08:47:56PM +0800, Hao-Yu Yang wrote:
>> During futex_key_to_node_opt() execution, vma->vm_policy is read under
>> speculative mmap lock and RCU. Concurrently, mbind() may call
>> vma_replace_policy() which frees the old mempolicy immediately via
>> kmem_cache_free().
>>=20
>> This creates a race where __futex_key_to_node() dereferences a freed
>> mempolicy pointer, causing a use-after-free read of mpol->mode.
>>=20
>> [  151.412631] BUG: KASAN: slab-use-after-free in __futex_key_to_node (k=
ernel/futex/core.c:349)
>> [  151.414046] Read of size 2 at addr ffff888001c49634 by task e/87
>> [  151.414476]
>> [  151.415431] CPU: 1 UID: 1000 PID: 87 Comm: e Not tainted 7.0.0-rc3-g0=
257f64bdac7 #1 PREEMPT(lazy)
>> [  151.415758] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS 1.15.0-1 04/01/2014
>> [  151.415969] Call Trace:
>> [  151.416059]  <TASK>
>> [  151.416161]  dump_stack_lvl (lib/dump_stack.c:123)
>> [  151.416299]  print_report (mm/kasan/report.c:379 mm/kasan/report.c:48=
2)
>> [  151.416359]  ? __virt_addr_valid (./include/linux/mmzone.h:2046 ./inc=
lude/linux/mmzone.h:2198 arch/x86/mm/physaddr.c:54)
>> [  151.416412]  ? __futex_key_to_node (kernel/futex/core.c:349)
>> [  151.416517]  ? kasan_complete_mode_report_info (mm/kasan/report_gener=
ic.c:182)
>> [  151.416583]  ? __futex_key_to_node (kernel/futex/core.c:349)
>> [  151.416631]  kasan_report (mm/kasan/report.c:597)
>> [  151.416677]  ? __futex_key_to_node (kernel/futex/core.c:349)
>> [  151.416732]  __asan_load2 (mm/kasan/generic.c:271)
>> [  151.416777]  __futex_key_to_node (kernel/futex/core.c:349)
>> [  151.416822]  get_futex_key (kernel/futex/core.c:374 kernel/futex/core=
.c:386 kernel/futex/core.c:593)
>> [  151.416871]  ? __pfx_get_futex_key (kernel/futex/core.c:550)
>> [  151.416927]  futex_wake (kernel/futex/waitwake.c:165)
>> [  151.416976]  ? __pfx_futex_wake (kernel/futex/waitwake.c:156)
>> [  151.417022]  ? __pfx___x64_sys_futex_wait (kernel/futex/syscalls.c:39=
8)
>> [  151.417081]  __x64_sys_futex_wake (kernel/futex/syscalls.c:382 kernel=
/futex/syscalls.c:366 kernel/futex/syscalls.c:366)
>> [  151.417129]  x64_sys_call (arch/x86/entry/syscall_64.c:41)
>> [  151.417236]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/e=
ntry/syscall_64.c:94)
>> [  151.417342]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.=
S:130)
>> [  151.418312]  </TASK>
>>=20
>> Fix by adding rcu to __mpol_put().
>>=20
>> change-log:
>>  v2-v1: add rcu to __mpol_put
>>=20
>> Fixes: c042c505210d ("futex: Implement FUTEX2_MPOL")
>> Reported-by: Hao-Yu Yang <naup96721@gmail.com>
>> Signed-off-by: Hao-Yu Yang <naup96721@gmail.com>
>> ---
>>  include/linux/mempolicy.h | 1 +
>>  mm/mempolicy.c            | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
>> index 0fe96f3ab3ef..65c732d440d2 100644
>> --- a/include/linux/mempolicy.h
>> +++ b/include/linux/mempolicy.h
>> @@ -55,6 +55,7 @@ struct mempolicy {
>>  		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
>>  		nodemask_t user_nodemask;	/* nodemask passed by user */
>>  	} w;
>> +	struct rcu_head rcu;
>>  };
>>=20=20
>>  /*
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index 0e5175f1c767..6dc61a3d4a32 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -487,7 +487,7 @@ void __mpol_put(struct mempolicy *pol)
>>  {
>>  	if (!atomic_dec_and_test(&pol->refcnt))
>>  		return;
>> -	kmem_cache_free(policy_cache, pol);
>> +	kfree_rcu(pol, rcu);
>>  }
>>  EXPORT_SYMBOL_FOR_MODULES(__mpol_put, "kvm");
>>=20=20
>> --=20
>> 2.34.1
>>=20
>
> Hi, I=E2=80=99d like to kindly ask if there=E2=80=99s an update on when t=
his patch might be merged.

Thanks for the reminder. I'll take care of it tomorrow

Thanks,

        tglx

