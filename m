Return-Path: <stable+bounces-254367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOUCGGeoFWqJXAcAu9opvQ
	(envelope-from <stable+bounces-254367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:04:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CED555D7054
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80BE53001BDE
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8865A3F9A0B;
	Tue, 26 May 2026 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpYL4+vd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158E33A7593;
	Tue, 26 May 2026 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803761; cv=none; b=CvxfbLLH/Y660V6J8fEd40tIOuVu7YfcSfpOTjxeM2E2DxzQ23dWbTfBJTdnuz60zohi0wBbgRt1g347zm2BnNJOBmqFZTgqWDWXGwoINXA/Bx5Jy/egO8FjwuZZHav1TUqrlEDhKo3z6of6H8BJSapJqDZRxNzk/EwEsqKuqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803761; c=relaxed/simple;
	bh=vnnWi8dQWB6l6Nohl4NkH7BA9KxtqRwgLLtVy1y56UE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZPxj41/k/cDOtPKhLa22bNWZlg3E/ihW8cBGgHI6QZ1nyg2a9d1USf7ZMgcX3UDoEwj772IyGQL1WJrn0V19sMIoN7JYiQ8jJ7gc6mm5D3OdN1a9ARlhYF6DDR5uMxyqIOuNPOJl4QyqMJyOCzleJNEhKXCePOnDu/+aB7Kdv3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpYL4+vd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E101F000E9;
	Tue, 26 May 2026 13:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779803759;
	bh=JrULAy9Gw7dTgt2CJtfRApgaaTOMPseygZFxD/MyYIc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hpYL4+vdLIvxzm4niRZbcwUQmOfWQKSCxGGGerPKb5a0oewhWWBG8CqeRfwdDEXbG
	 yegqQzLLyw/9J5+v9sqzryZnTCqlOADSCFq7MNoZERdQOGEjLoTJJSkrQnLtRueeVc
	 FNbvehqYXTpwDR88AlqPDoRirz6HPdGiWLWpT7//N4oPfuRTjvGYV9lf+xP5oK7B0E
	 dq2Gc4xNO8Jb03sYKC4W7EfKGYOHk29nPvx5GE+zQRLhtDEgKY3syHFCR5uiq64ChO
	 fKaqkFIxmPbuinhNTdpoCUbFufv5wV+T+yVOBxsEWiiAOEutfGVqz31YBKw2Kugw5S
	 3Dlr7Gs3flskA==
Content-Type: multipart/mixed; boundary="===============1624879100367785041=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2f53799c49f16b688b2780733a6175235b730b0edbe15747309771e5a84130a7@mail.kernel.org>
In-Reply-To: <20260526131035.1312864-2-dawei.feng@seu.edu.cn>
References: <20260526131035.1312864-2-dawei.feng@seu.edu.cn>
Subject: Re: [PATCH 1/2] bpf: cgroup: fix sysctl new value replacement
From: bot+bpf-ci@kernel.org
To: dawei.feng@seu.edu.cn,martin.lau@linux.dev
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,kees@kernel.org,joel.granados@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-fsdevel@vger.kernel.org,jianhao.xu@seu.edu.cn,dawei.feng@seu.edu.cn,stable@vger.kernel.org,zilin@seu.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 13:55:59 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,vger.kernel.org,seu.edu.cn,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-254367-lists,stable=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,seu.edu.cn:email]
X-Rspamd-Queue-Id: CED555D7054
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============1624879100367785041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 876f6a81a9b6..8715a014c21d 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c

[ ... ]

> @@ -1878,7 +1878,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
>   * to provided by user buffer, so that next BPF program in the chain
>   * can treat it as a replacement.
>   *
> - * This function will return %-EPERM if an attached program is found and
> - * returned value != 1 during execution. In all other cases 0 is returned.
> + * This function will return %-EPERM if an attached program is found and
> + * returned value != 1 during execution. In all other cases 0 is returned.
>   */

Should the function documentation be updated to reflect the actual return
value convention?

After commit 4e63acdff864, bpf_prog_run_array_cg() returns 0 on success,
not 1. The comment still states "returned value != 1 during execution" but
the code now checks for '!ret' (i.e., ret == 0). The documentation should
say "returned value != 0" to match the actual behavior.

> @@ -1935,7 +1935,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
>
>  	kfree(ctx.cur_val);
>
> -	if (ret == 1 && ctx.new_updated) {
> +	if (!ret && ctx.new_updated) {
>  		kfree(*buf);
>  		*buf = ctx.new_val;
>  		*pcount = ctx.new_len;

Can this cause memory corruption?

The caller proc_sys_call_handler() allocates the buffer with kvzalloc():

fs/proc/proc_sysctl.c:proc_sys_call_handler() {
    ...
    kbuf = kvzalloc(count + 1, GFP_KERNEL);
    ...
}

kvzalloc() may fall back to vmalloc() for large allocations, but this
code uses kfree() instead of kvfree() to free *buf. Using kfree() on
vmalloc memory corrupts memory.

This is fixed in a later commit 155dfbd42ab8 ("bpf: cgroup: Use kvfree
instead of kfree in __cgroup_bpf_run_filter_sysctl") which includes a
KASAN crash report demonstrating the bug.

Should this patch use kvfree() instead of kfree()?


Also, Martin KaFai Lau raised a concern about the null terminator handling
during the May 2024 review of a similar fix.

In the discussion at:
https://lore.kernel.org/bpf/ca8136e0-5d2a-402b-ad03-cc8a218affd4@linux.dev/

Martin requested that the patch adjust *pcount to exclude the null
terminator if present. The concern is that proc_sys_call_handler may reject
the value with EINVAL if the null terminator is included in the count.

The suggested fix from that discussion was:

    if (!(*buf)[ctx.new_len])
        *pcount = ctx.new_len - 1;
    else
        *pcount = ctx.new_len;

Should this patch include the null terminator handling improvement?


> commit f089fd0540601290c72ecfd2ff3f0c817952970a
> Author: Dawei Feng <dawei.feng@seu.edu.cn>
>
>     bpf: cgroup: fix sysctl new value replacement
>
>     Commit 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value
>     helpers") changed the success return value to 0, but failed to update the
>     corresponding check in __cgroup_bpf_run_filter_sysctl(). Since
>     bpf_prog_run_array_cg() now returns 0 on success, the legacy ret == 1
>     condition is never satisfied. As a result, the modified value is ignored,
>     and bpf_sysctl_set_new_value() fails to replace the write buffer.
>
>     Fix this by checking for a return value of 0 instead, so cgroup/sysctl
>     programs can correctly replace the pending sysctl buffer.
>
>     This bug was discovered during a manual code review. Tested via a
>     cgroup/sysctl BPF reproducer overriding writes to a target sysctl.
>     Pre-fix, bpf_sysctl_set_new_value("foo") was silently ignored: the write
>     returned 8192 and the value remained "600". Post-fix, the BPF replacement
>     buffer properly propagates: the write returns 3 and the value updates to
>     "foo".
>
>     Fixes: 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value helpers")

Is the Fixes: tag pointing to the correct commit?

Commit 4e63acdff864 (2019) originally used 'ret == 1' correctly, as
BPF_PROG_RUN_ARRAY_CG returned 1 on success at that time.

However, commit f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -err
instead of allow boolean") from 2022 changed BPF_PROG_RUN_ARRAY_CG to
return 0 on success instead of 1. That commit updated the final return
statement from 'return ret == 1 ? 0 : -EPERM;' to 'return ret;', but
forgot to update the 'if (ret == 1 && ctx.new_updated)' check.

Should the Fixes: tag be:

  Fixes: f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -err instead of allow boolean")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26451027650
--===============1624879100367785041==--

