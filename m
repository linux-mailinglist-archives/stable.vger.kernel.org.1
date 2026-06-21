Return-Path: <stable+bounces-267587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LED2IIdqOGpLcAcAu9opvQ
	(envelope-from <stable+bounces-267587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 00:49:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 874326ABC7B
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 00:49:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=i-love.sakura.ne.jp (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267587-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267587-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 414233014BD2
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 22:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AB1379C57;
	Sun, 21 Jun 2026 22:49:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976C222A80D;
	Sun, 21 Jun 2026 22:49:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782082176; cv=none; b=f6aUke5432MNWsl/pBp7/61lP4eaJTnWJ190DZVWr/78zrm38YKTDWEzTwCBWKGaNq7/lSuRiWUVer/htHoJxPrgHmyaP6od0z1JIFxmJ52qWoZOddqqxUQYzNRtK0HO8Jwi//nkcbQF1iJqQuBuOxRsawhnJ/PYBKIKTriuGrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782082176; c=relaxed/simple;
	bh=XEmvvVr5SPeD2fMpaAzwkvvl+m+p4cjFFyHFFJBrEmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aN9zl59Z6rUcmJTJpNtXfLBG210GZWVKwFKXbtoJ+fDWtdQupLiCRd3TwRQ/v1N+j8Fi/ETbCnsczeCUH2KZOmJvkI6ehT79UFWiAMxTXK0WHWklM6FYd3glGGB/f6rjWL+iSGmAKghJ7kosnzflb+4VkwKgMc8ppARYxRxuu94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 65LMn62s092099;
	Mon, 22 Jun 2026 07:49:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 65LMn6KE092093
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 22 Jun 2026 07:49:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <be257038-78f3-4a6c-8a57-237f5e2676bc@I-love.SAKURA.ne.jp>
Date: Mon, 22 Jun 2026 07:49:03 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] profiling: prevent stale prof_cpu_mask access on init
 failure
To: Tristan Madani <tristmd@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Dave Hansen <dave@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>
References: <20260621192324.2062795-1-tristmd@gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260621192324.2062795-1-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav104.rs.sakura.ne.jp
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
	TAGGED_FROM(0.00)[bounces-267587-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 874326ABC7B

On 2026/06/22 4:23, Tristan Madani wrote:
> diff --git a/kernel/profile.c b/kernel/profile.c
> index 984f819b701c9..a166ad9512714 100644
> --- a/kernel/profile.c
> +++ b/kernel/profile.c
> @@ -123,6 +123,7 @@ int __ref profile_init(void)
>  	if (prof_buffer)
>  		return 0;
>  
> +	prof_on = 0;
>  	free_cpumask_var(prof_cpu_mask);

Which tree are you talking about?

>  	return -ENOMEM;
>  }
> @@ -325,7 +326,7 @@ void profile_tick(int type)
>  {
>  	struct pt_regs *regs = get_irq_regs();
>  
> -	if (!user_mode(regs) && cpumask_available(prof_cpu_mask) &&
> +	if (!user_mode(regs) && prof_on && cpumask_available(prof_cpu_mask) &&
>  	    cpumask_test_cpu(smp_processor_id(), prof_cpu_mask))

NAK. This is a use-after-free read bug.

  CPU0                            CPU1
  
                                  if (!user_mode(regs) && prof_on && cpumask_available(prof_cpu_mask) &&
  prof_on = 0;
  free_cpumask_var(prof_cpu_mask);
                                      cpumask_test_cpu(smp_processor_id(), prof_cpu_mask)) // <= prof_cpu_mask was already freed.

Correct fix is to remove a commit which adds "free_cpumask_var(prof_cpu_mask);".

>  		profile_hit(type, (void *)profile_pc(regs));
>  }


