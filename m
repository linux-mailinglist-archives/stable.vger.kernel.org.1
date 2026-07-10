Return-Path: <stable+bounces-273130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p6KcLwNnUGoZyQIAu9opvQ
	(envelope-from <stable+bounces-273130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 05:29:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B083736F53
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 05:29:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b="wve/sneo";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273130-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273130-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43B2B300E310
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 03:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A82A367F21;
	Fri, 10 Jul 2026 03:28:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB29367293
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 03:28:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654126; cv=none; b=ZzjgaQmqvqXrPvsaEAycmbGlD+GacTM2pl0NLK/xkOt08IzBWyU0xa2AMqR9Xj6873/l0r50t9enhKy7UWMuu6W1WYnW3gK2VfSFU+cIg7hwtqvrYIr3H01DIGLe1P954ZdLtJZNI+DGYPjYtkkdCQ4vUQd9ZmEtGJvoXcDfsiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654126; c=relaxed/simple;
	bh=geIH1+4Vigtz+7guPEaZ2PPndVHPryTmq1nAf/9Hxs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IxMrUJ9ZJzzEV/cjaTxOcujAM3ZkZL9yg9avRmzsy52sHUxQRYfFhyvdwSy1DbsWW6kz+XV+PEiypcasQ8ezjaCkhnm03CG0jMuOFvnXyeyWUn6wk+gUaPytuIOkc2u8mg1XJCzfyT7i1UxmXnAg/bT3zsDr4pzn0gJ9hUpzu6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wve/sneo; arc=none smtp.client-ip=113.46.200.221
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Clqub7MS4QSOrj7APIrN69CxsgWwrVk7C6I2c5+9Umw=;
	b=wve/sneohSxMB1uG8VfXx8YNujyOoIH1r2aov8MA9uoTWUzD4UlQ1A4AobAw/1QicoMa3sNmy
	UR+ILbmsxisoHGVSlrkDYqol5o0PzhZx6YEets6UqoCv2ZvcFxb1PbdMu+2kKHi+8u/shuYNS92
	lTLPg6rEWGwnwnznXOaQ1RU=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gxH9z6mzRzRhQR;
	Fri, 10 Jul 2026 11:19:19 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id C49F840538;
	Fri, 10 Jul 2026 11:28:33 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Jul 2026 11:28:32 +0800
Message-ID: <a88a1ce6-f2e0-44ff-9713-57a94c78c24e@huawei.com>
Date: Fri, 10 Jul 2026 11:28:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/36] arm64: hibernate: mask DAIF before restoring
 hibernated kernel
To: Vladimir Murzin <vladimir.murzin@arm.com>,
	<linux-arm-kernel@lists.infradead.org>
CC: <mark.rutland@arm.com>, <maz@kernel.org>, <will@kernel.org>,
	<catalin.marinas@arm.com>, Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	<stable@vger.kernel.org>
References: <20260709121333.23507-1-vladimir.murzin@arm.com>
 <20260709121333.23507-4-vladimir.murzin@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260709121333.23507-4-vladimir.murzin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273130-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[ruanjinjie@huawei.com,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vladimir.murzin@arm.com,m:linux-arm-kernel@lists.infradead.org,m:mark.rutland@arm.com,m:maz@kernel.org,m:will@kernel.org,m:catalin.marinas@arm.com,m:ada.coupriediaz@arm.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruanjinjie@huawei.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,huawei.com:from_mime,huawei.com:dkim,huawei.com:mid,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B083736F53



On 7/9/2026 8:13 PM, Vladimir Murzin wrote:
> From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> 
> The arm64 hibernate code manages the exception masking in an unsound
> way, leading to potential crashes and/or warnings during resume.
> 
> When a hibernation image is saved in `swsusp_arch_suspend()`, all DAIF
> exceptions are masked (by virtue of `local_daif_save()`), and the
> suspended image is saved assuming that all DAIF exceptions will remain
> masked when the image is restored.
> 
> When a hibernation image is resumed by `swsusp_arch_resume()`, only
> interrupts are masked (by virtue of `local_irq_save()` in
> `resume_target_kernel()`). When pseudo-NMI is enabled the DAIF.IF bits
> will be clear, and regardless of pseudo-NMI the DAIF.DA bits will be
> clear.
> 
> This means that there are two problems:
> 
> (1) It is possible to take Debug, SError, or pseudo-NMI exceptions
>     during the resume process. This is unsafe, as during the resume
>     process both the old ane new kernels will tranisently be in an
>     inconsistent state, and swsusp_arch_suspend_exit() won't retain
>     an executable mapping of any exception vectors.
> 
>     Any exception taken here will be fatal and silent.
> 
> (2) When re-entering the resumed kernel, some DAIF bits will be clear
>     unexpectedly. This permits Debug, SError, or pseudo-NMI exceptions
>     to be taken for a short period while the resumed kernel is not yet
>     in a consistent state.
> 
>     This is detected by CONFIG_ARM64_DEBUG_PRIORITY_MASKING.
> 
> Avoid these issues by masking all DAIF exceptions during resume.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm64/kernel/hibernate.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 9717568518ba..d0d9bd91e639 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -405,6 +405,7 @@ int swsusp_arch_suspend(void)
>  int __nocfi swsusp_arch_resume(void)
>  {
>  	int rc;
> +	unsigned long flags;
>  	void *zero_page;
>  	size_t exit_size;
>  	pgd_t *tmp_pg_dir;
> @@ -465,9 +466,21 @@ int __nocfi swsusp_arch_resume(void)
>  	if (el2_reset_needed())
>  		__hyp_set_vectors(el2_vectors);
>  
> +	/*
> +	 * It is necessary to mask all DAIF exceptions here as:
> +	 *
> +	 * - The copy of swsusp_arch_suspend_exit() in the hibernation
> +	 *   text cannot handle taking any exceptions.
> +	 *
> +	 * - The suspended kernel masked all DAIF exceptions in
> +	 *   swsusp_arch_resume(), and expects to be re-entered in the
> +	 *   same state : with all DAIF exceptions masked.
> +	 */
> +	flags = local_daif_save();
>  	hibernate_exit(virt_to_phys(tmp_pg_dir), resume_hdr.ttbr1_el1,
>  		       resume_hdr.reenter_kernel, restore_pblist,
>  		       resume_hdr.__hyp_stub_vectors, virt_to_phys(zero_page));
> +	local_daif_restore(flags);

I believe that the local_daif_save() here is also unnecessary because
hibernate_exit() returns from the "return 0 branch" of
__cpu_suspend_enter() in swsusp_arch_suspend(), and before that,
local_daif_save() has already been called to mask all exceptions.

swsusp_arch_suspend(void)
    -> flags = local_daif_save();
    -> if (__cpu_suspend_enter(&state)) {
           ...
        } else {                // _cpu_resume <- hibernate_exit()

           ...
           in_suspend = 0;
           ...
        }
     -> local_daif_restore(flags);

>  
>  	return 0;
>  }


