Return-Path: <stable+bounces-254450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DnoDbYdFmoPhwcAu9opvQ
	(envelope-from <stable+bounces-254450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 00:24:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8275DD2F0
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 00:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 266943031CEA
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 22:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7443C769B;
	Tue, 26 May 2026 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="MZq1bC5t"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7B33C5856
	for <stable@vger.kernel.org>; Tue, 26 May 2026 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779834287; cv=none; b=f+fykPfQSTkOIkIqy2EViQB0HWR0sYz+Jeb8wddMh1G9T3Y5Y2dsj5bGnQgJglD8/RHioWTIRMFRiLP80A7MYO3JvPZJZi6c5EfpPRRdccTlb6fQ9mfGgugRPJPPWkUpQLM5Ap51eqtMb/bYirwy88gr7kCNrRmX7ZOMO6GRW5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779834287; c=relaxed/simple;
	bh=GxbQ8NIk4mgl61gh8KFDsnH5jMKPJyjLI5wJFoJcLLE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=jzBRTu3H5ftx790VL2J4N2ccZues+enjazCQdlEDG9s1YQvqiaxumaQjr/Hk5Pii0W+8pEC4XHUuta4ixJ23mNqPrJmxrb/jr6qbnHXTpBw9L+NzQaGuCFMJGIBLLXr4xss1exB10haTmAwAXThDDjBt309wZ3i2nSSYhAJHHRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=MZq1bC5t; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8532ba6c95so1030161a12.0
        for <stable@vger.kernel.org>; Tue, 26 May 2026 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779834285; x=1780439085; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZg3/Nrp/XSikTx+0njY7ovlfnqPSA3h4CFSyjzLU5Y=;
        b=MZq1bC5tNXiGp3TbIA/cWPITDW7PrEBMxLE7q4RVQ3mjdRpAVHQtt9zxUgx2OkPsvo
         XSjeqcPHo3Qwkszs7uUPxfCEuMykpHX0hbfxP82EqAWmQJIYsBEFY4HM5c44LptDLb56
         23muriERM/yN8y9I5HfCBd8vsiev6txgivViGRntYepgXbIucmSeihpJsN7uEH/rxqHs
         Wpj3p4eSv8cvx0SFv/T10SteGyGLZVVnquZ59NKfUWuxJisW3b+WLgztZofvWLNy8OZg
         lwy+RAbU/rYgGGXBECIJ5myD1l68YgTqDJJKU6dxTMYl/pILFMNAqBhxw6TLH5zIx3nB
         0YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779834285; x=1780439085;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qZg3/Nrp/XSikTx+0njY7ovlfnqPSA3h4CFSyjzLU5Y=;
        b=gNr5ItATL4OKZFqb2+o9l1Jbg7fDKtBMwXJMI+SmNDYvRivbkUVw/856pSz4LzjFcw
         I+4Ejp7ucor4munH1pENpMgmExehoT9L5CI4m7GH4EOjWv1RjQO9wdjYKYEKq4CIiBHm
         5eRNNc4nsxg39UktQ6tN5oOPVpTJPxM/2QoniYdsYH054UDGJqTJrFG7EbxxUCQlRjpq
         4m5PLWH1Hxock7ojjhZYEO8uGWlJuTWWFEOk8zF1zaSoTCJXpSrQz/z50b/l/T3avg/p
         16bxdsODAv4S8O69wSegIeZcjjEL8N8YZ29UnpuQQC31keU5T7eI3xnXNEza8slLhDSp
         Qc4g==
X-Forwarded-Encrypted: i=1; AFNElJ8+px8Vh4liagdyMAtnSH6W75t5/VocbjtRQWopx/uIdQ68TI8KIVM9EldDEzKhTivncRjX7V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLWRBvqxvJj3MeZcPZTchQY1lJoinJf/YMRbKmGc69rPFD4Znm
	murnWs92fM8PSKsuIXLqePTJHd2GfJsdkHmErSf2FfWg2E6ozmRxMTUqDfr+tyL98Cc=
X-Gm-Gg: Acq92OEbt8cp65YKPGSlCNZulxyPeJdrjyCXDLQ9xtaaLMmAqogKLBp9FISkpbRT8hQ
	DvLkj2apxTbnulqQmm/ZJbEEivmpV1wxRdykaMYtDTVho201X2veBTJ7P3QKqQFyACb/WAkWizo
	ZbPgkXmgUkc7uXgUGWi8IhnteUMZJyMGSCsIMkz5PGj/1Tyyjv8c5nyFXk13IpGFbQFyfuauuiN
	SNP1CF8tnb04rDF+sNxoOlo0SywXpYybn8pE6AIqR+JiVLYslvi/TcqSWxFDjDoTX3qMADGYTtc
	63b31MQk383Nnt5s5i8BIvivnjG13MjeRuMsEM9miccrY/koeqfyKGEYY56OpMWgK0V6MTg5zYA
	F5QvRJJdGdtgeQpAyngzq6UETqAwqD2p+MJ1yg3BCJpp5scRWR/5dPKFd7kJ+9TzWGd9En3/5v2
	A1QRKiZJg9Zo8OrlYQ075p/xJO
X-Received: by 2002:a05:6a20:2449:b0:398:b346:b13 with SMTP id adf61e73a8af0-3b328cfe3ffmr19991485637.16.1779834285148;
        Tue, 26 May 2026 15:24:45 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852028fe99sm11268978a12.4.2026.05.26.15.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 15:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 18:24:44 -0400
Message-Id: <DISYLID6QGFY.1HTQOMHVLTRWS@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Dawei Feng" <dawei.feng@seu.edu.cn>, <martin.lau@linux.dev>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <kees@kernel.org>,
 <joel.granados@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <jianhao.xu@seu.edu.cn>, <stable@vger.kernel.org>, "Zilin Guan"
 <zilin@seu.edu.cn>
Subject: Re: [PATCH 2/2] bpf: cgroup: Use kvfree instead of kfree in
 __cgroup_bpf_run_filter_sysctl
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260526131035.1312864-1-dawei.feng@seu.edu.cn>
 <20260526131035.1312864-3-dawei.feng@seu.edu.cn>
In-Reply-To: <20260526131035.1312864-3-dawei.feng@seu.edu.cn>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254450-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[etsalapatis.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,vger.kernel.org,seu.edu.cn];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.987];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[etsalapatis-com.20251104.gappssmtp.com:dkim,seu.edu.cn:email,etsalapatis.com:mid,etsalapatis.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8E8275DD2F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 26, 2026 at 9:10 AM EDT, Dawei Feng wrote:
> proc_sys_call_handler() allocates its temporary sysctl buffer with
> kvzalloc() and passes it to __cgroup_bpf_run_filter_sysctl(). Since
> kvzalloc() may fall back to vmalloc() for large allocations, freeing
> that buffer with kfree() is wrong and can corrupt memory.
>
> Use kvfree() to safely handle both kmalloc and kvzalloc()/vmalloc
> allocations.
>
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still
> present in v7.1-rc5.
>
> Reproduced the bug based on v7.1-rc4 in a QEMU x86_64 guest booted with
> KASAN and CONFIG_FAILSLAB enabled. The reproducer confines failslab
> injections to the proc_sys_call_handler() range, uses
> stacktrace-depth=3D32, and injects fail-nth=3D1 while writing 8191 bytes =
to
> /proc/sys/kernel/domainname from a task in the target cgroup. On the
> patch1-only kernel, fail-nth=3D1 triggered the fault:
>
>   BUG: unable to handle page fault for address: ffffeb0200024d48
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: Oops: 0000  SMP KASAN NOPTI
>   CPU: 2 UID: 0 PID: 209 Comm: repro_proc_sys_ Not tainted 7.1.0-rc4-0068=
6-g97625979a5d4  PREEMPT(lazy)
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01=
/2014
>   RIP: 0010:kfree+0x6e/0x510
>   Code: 80 48 01 ef 0f 82 ae 04 00 00 48 c7 c0 00 00 00 80 48 2b 05 04 1b=
 23 04 48 01 c7 48 c1 ef 0c 48 c1 e7 06 48 03 3d e2 1a 23 04 <4c> 8b 57 08 =
4c 89 d0 83 e0 01 48 83 e8 01 49 09 c2 49 >
>   RSP: 0018:ffff888108de7ab8 EFLAGS: 00010282
>   RAX: 0000777f80000000 RBX: ffff88815af398c0 RCX: 0000000000000080
>   RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffeb0200024d40
>   RBP: ffffc90000935000 R08: 0000000000000001 R09: 0000000000000001
>   R10: ffffffff86b4b297 R11: 0000000000000000 R12: ffffffff819b71fd
>   R13: 0000000000000001 R14: ffff888108de7cc0 R15: 0000000000000000
>   FS:  00007f8988cc2b80(0000) GS:ffff8881d3256000(0000) knlGS:00000000000=
00000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: ffffeb0200024d48 CR3: 0000000101d6b000 CR4: 0000000000350ef0
>   Call Trace:
>    <TASK>
>    ? __cgroup_bpf_run_filter_sysctl+0x626/0xc30
>    __cgroup_bpf_run_filter_sysctl+0x74d/0xc30
>    ? __pfx___cgroup_bpf_run_filter_sysctl+0x10/0x10
>    ? srso_return_thunk+0x5/0x5f
>    ? __kvmalloc_node_noprof+0x345/0x870
>    ? proc_sys_call_handler+0x250/0x480
>    ? srso_return_thunk+0x5/0x5f
>    proc_sys_call_handler+0x3a2/0x480
>    ? __pfx_proc_sys_call_handler+0x10/0x10
>    ? srso_return_thunk+0x5/0x5f
>    ? selinux_file_permission+0x39f/0x500
>    ? srso_return_thunk+0x5/0x5f
>    ? lock_is_held_type+0x9e/0x120
>    vfs_write+0x98e/0x1000
>    ? srso_return_thunk+0x5/0x5f
>    ? kmem_cache_free+0x308/0x550
>    ? __pfx_vfs_write+0x10/0x10
>    ? __pfx_do_sys_openat2+0x10/0x10
>    ksys_write+0xf2/0x1d0
>    ? __pfx_ksys_write+0x10/0x10
>    ? srso_return_thunk+0x5/0x5f
>    ? trace_irq_enable.constprop.0+0x110/0x140
>    do_syscall_64+0x115/0x690
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    RIP: 0033:0x7f8988dd8907
>    Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1=
e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8  01 00 00 00 0f 05 <48> 3d 00 f=
0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 >
>    RSP: 002b:00007fff4069b878 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>    RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8988dd8907
>    RDX: 0000000000001fff RSI: 0000564f97ef46b0 RDI: 0000000000000005
>    RBP: 0000564f97ef46b0 R08: 0000000000000000 R09: 0000564f97ef46b0
>    R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
>    R13: 0000000000001fff R14: 0000000000000005 R15: 0000000000000001
>    </TASK>
> With this fix applied, rerunning the reproducer with the same
> fail-nth=3D1 setup yields no corresponding Oops reports.
>
> Fixes: 4508943794ef ("proc: use kvzalloc for our kernel buffer")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  kernel/bpf/cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 8715a014c21d..f4eefdacd453 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1936,7 +1936,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table=
_header *head,
>  	kfree(ctx.cur_val);
> =20
>  	if (!ret && ctx.new_updated) {
> -		kfree(*buf);
> +		kvfree(*buf);
>  		*buf =3D ctx.new_val;
>  		*pcount =3D ctx.new_len;
>  	} else {


