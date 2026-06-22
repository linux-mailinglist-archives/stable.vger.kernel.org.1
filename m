Return-Path: <stable+bounces-267682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ze6MGOceOWqSnAcAu9opvQ
	(envelope-from <stable+bounces-267682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 13:39:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7386AF2A1
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 13:39:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=i-love.sakura.ne.jp (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267682-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267682-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED2EA3034DCF
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982622BEC2A;
	Mon, 22 Jun 2026 11:33:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AAB26FD97;
	Mon, 22 Jun 2026 11:33:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127994; cv=none; b=R/zkgXJIanRnLUIZjowcP5ArnQELISoovVn3AKwA6txmZmMF0qtNlt9Ucj/fwoCvdZGqm5x0rVS2EwnmIeBCkciz/XoJFAS+8kj1YMylH59Ds/MD9EC67vY7esfLVQ2gxR7RF6kkmOnIetdBN2isxPj74iNX/6mMpbwrngmJVD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127994; c=relaxed/simple;
	bh=MAIimd1XQFf9fcqbUWzDggx8Vmejw639uP7Z1RgFPFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkkRCVE9tR8IcnGHvo1MbWKNMhUQAM4lvthw5L9eqaH1jlu1EwarClAvt3sLVN5ggWPpHXDu/zIzXCe9GPkRjmsMklns5F8xuBiUEW1QRAIaZxyZG9ZMUQ7eLMECtwg16aeUugSCPkNtSazHL1oisFCpTFh6gQ5uJI10bDfXYlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 65MBWnTK047588;
	Mon, 22 Jun 2026 20:32:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 65MBWn6H047584
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 22 Jun 2026 20:32:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <fb12bd4b-58e0-4d78-a725-7e2d44b6350c@I-love.SAKURA.ne.jp>
Date: Mon, 22 Jun 2026 20:32:47 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] profiling: don't free prof_cpu_mask on init failure
To: Tristan Madani <tristmd@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Dave Hansen <dave@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>
References: <20260621192324.2062795-1-tristmd@gmail.com>
 <20260622000022.3375262-1-tristmd@gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260622000022.3375262-1-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[i-love.sakura.ne.jp : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267682-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:akpm@linux-foundation.org,m:mingo@elte.hu,m:dave@linux.vnet.ibm.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,talencesecurity.com:email,i-love.sakura.ne.jp:email,I-love.SAKURA.ne.jp:mid,I-love.SAKURA.ne.jp:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F7386AF2A1

On 2026/06/22 9:00, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> When profiling is enabled at runtime via /sys/kernel/profiling,
> profile_setup() sets prof_on and profile_init() allocates prof_cpu_mask
> then attempts to allocate prof_buffer. If all prof_buffer allocations
> fail, the error path frees prof_cpu_mask but leaves prof_on set.
> 
> Since profile_tick() runs from timer interrupt context and checks
> cpumask_available(prof_cpu_mask), it can access the freed cpumask
> between the free and the next reboot.
> 
> Remove the free_cpumask_var() call from the error path. The cpumask
> allocation already succeeded and is small; keeping it on this rare
> failure path is harmless.
> 
> Fixes: 22b8ce94708f ("profiling: dynamically enable readprofile at runtime")

Why 22b8ce94708f ? That commit did not add free_cpumask_var().
Since free_cpumask_var() was removed by 7c51f7bbf057, your patch might want
explanation about why you choose to only avoid UAF-read for stable kernels
instead of try to apply 7c51f7bbf057.

> Cc: stable@vger.kernel.org
> Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> Changes in v2:
> - Remove the free_cpumask_var() call instead of adding a prof_on
>   guard in profile_tick(), which still raced with the free (Tetsuo Handa)
>  kernel/profile.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/profile.c b/kernel/profile.c
> index 984f819b701c9..93180f9d21467 100644
> --- a/kernel/profile.c
> +++ b/kernel/profile.c
> @@ -123,7 +123,6 @@ int __ref profile_init(void)
>  	if (prof_buffer)
>  		return 0;
>  
> -	free_cpumask_var(prof_cpu_mask);
>  	return -ENOMEM;
>  }
>  


