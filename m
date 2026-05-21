Return-Path: <stable+bounces-253563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGZNDJEaD2qeFwYAu9opvQ
	(envelope-from <stable+bounces-253563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:45:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 872B85A78DE
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FC923248866
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1353F65EF;
	Thu, 21 May 2026 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNOi/xyE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AEF3F54DA
	for <stable@vger.kernel.org>; Thu, 21 May 2026 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370837; cv=none; b=JY9vLc9MhS90pZDzcd1vFxQ+qiAfygKoLBSAeX5aFksw2Ub3DlL44qRvqYNFHKJ6AifAbbmCVHDfuCyOihyK5UbvvCsytIMuzKSxr7cmwiL+uzjCOZXDyrs31L8xDymTxZaDWQrtcxj3KBoNt4egYH7/CRNyarOHWKd/fgTKHOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370837; c=relaxed/simple;
	bh=lgt6bZGowrk+/hgFO04EGKXbDtatCeP4h9JOVGEXa8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVv7r+VlPkN0sgIeCVWDDTe7MFgzVsv59R/CYhrjNSgysFYFpYLGPqHWMjks64KSQCAf6Lz2zMzN3OZTc9sebIr9nGH2wplld5CLn1A1eoYhrnGxI8OIKpLlaZn2llRkPpiC6+sT54lWsLXX4gBxr5KFDkJtz4xrt4Jx0wrZqh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNOi/xyE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45e6a4d0be0so2680845f8f.1
        for <stable@vger.kernel.org>; Thu, 21 May 2026 06:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779370833; x=1779975633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6pliLjQCX38qV7kmxGlug+pl/y15gveH2ePBs5elqDA=;
        b=XNOi/xyEjMAKYE7DMZ1mULUcWDZZuOE3IazV1nasAwyFcBWwCUyE49xk+fBB2JQ/4Z
         ObiSwbZGoxfm8cVPj7Sjk3LzdGOp0dZ6a0+mwGzaDHgubVzOIA+HmQ4w44UWFxKwQVsn
         2yT/7FkZ6Hj7RKV11iBkNHKaI29r27t01r/x4bAeuue7g6DpRr3EguS/DfRzGI72kSvm
         pWMQqT8bx7+AcMnaiQbqjq765IvjEpxTVoaGuLEqtr/MjpyGbT0B1JXxm3BotpA2Ziv9
         FfyYigl6yvBnf697TwQqCyE7NNGnuKvIBGCxN0fRz5iWonFhuYUOHSb6IS9+xk8uvaj+
         ckew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779370833; x=1779975633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pliLjQCX38qV7kmxGlug+pl/y15gveH2ePBs5elqDA=;
        b=ez/4OhpCMZgJiQIsMYVYFsKYrskW19skOgBuZKMzBGXzYNxvsesz/AybjEWB+tJsdC
         kJgg7g1BPnNjooo6x7Sd2H3L5Fiya47l2qgMdgZyg8qneW63bVGIJ6nhGu5ZyDU2AHfz
         5ECTobvlYAykfEnVEszNFYdkan1L+Bmwd7Y+APJ9x4bjU7Y1Y2fs+skfPnWg16bY9ob/
         VT2Mz1v0aatGifOaYA0WAufgFAurgkG0dEN+28vrgHuqSFPVhUnYN1x6vzstuIFjpj6g
         onAXSakndjFntbBmrpvSNL8U3aMP5mt6HWpeGFZU+6NyYWxm56hWgMZc1LrjqVjtb4YH
         To2w==
X-Gm-Message-State: AOJu0YyISIhH49CSDfS9I95dRkXn9VbqMTjEHlnoj8D6fbQSOdsvofTM
	KQddvFutcuy6m6AyMrhewBb+Bqz+PZfpQCntqozU/hponETRU2Ikk1ot
X-Gm-Gg: Acq92OHzHpg7MEJSyVsGaQPPHUiXLeU9ZRRYZbiYKXTwnllNeS/28tVsSmvP/SKbsXY
	Q3YvlZgRTHnee65Zyea3QYgXqk2J41BhTK8a3oRoXIbZWMCVL5KaN01FJ4WDvqeJEGGRPxIIDG9
	QaCJboSXvNGSCeTYr5p/kVbKuoAvNdWVCamjnvCVVWCXnQ89k9i1cNdVVdmK67ItgIjv8V8A7lX
	hl1tUVBlOOkzSZydJeuO60KHS4LG5gYK5I/JhTZswao5mbY0hfKslc7Wfv46HVBz3B2QeBl6S0t
	lAX63esWu8/UNrvcmyu/zMAYgvLEfwfICiiI6yXkt9KWYUOJRjEZXg9k8qu1x73Laj7LwsLKlIs
	M18f3uxgnV5bMLV8sqm9b6jyhITdLEpYzIE5RwEkvJBSAS2MUUk8cdyZ2YpfyGlKWQofOXztE1O
	HONMKelxzoy/WWFgj2hAlnxYjN6yArcyQqaxtlep7bbn3PzW4D3X6HaPL2NhWjs8a/1KSs+0jkf
	nBYYE5F+cGCVk92yR/7RSEK4Xc+KYgTkRbNj3nPkeBXzk8hZyTMEZZdkW5C42NE6PheHU01juWC
	FMMZHi1rixQoV3Pz7b4aW6/HTXuRxrb3jj8SUxHE35QzX7beswYl
X-Received: by 2002:a05:6000:4027:b0:45b:d891:4ef1 with SMTP id ffacd0b85a97d-45ea3beccb2mr4601148f8f.34.1779370833098;
        Thu, 21 May 2026 06:40:33 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f2ad02214c8b26a8.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f2ad:221:4c8b:26a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa7cd815sm4355733f8f.6.2026.05.21.06.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:40:32 -0700 (PDT)
Date: Thu, 21 May 2026 15:40:30 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Jon Hunter <jonathanh@nvidia.com>, Chen Yu <yu.c.chen@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: Re: [PATCH 6.18 046/957] sched/topology: Fix sched_domain_span()
Message-ID: <ag8LTnOjVcrKlUs0@mail.gmail.com>
References: <20260520162134.554764788@linuxfoundation.org>
 <20260520162135.557884097@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520162135.557884097@linuxfoundation.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253563-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,intel.com:email,gnu.org:url]
X-Rspamd-Queue-Id: 872B85A78DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 06:08:49PM +0200, Greg Kroah-Hartman wrote:
> 6.18-stable review patch.  If anyone has any objections, please let me know.

No objection, but commit aacee214d5763 ("selftests/bpf: Remove
test_access_variable_array") will also need to be backported or the BPF
selftests fail with:

  progs/test_access_variable_array.c:14:13: error: no member named 'span' in 'struct sched_domain'
    CLNG-BPF [test_progs] test_check_mtu.bpf.o
     14 |         span = sd->span[0];
        |                ~~  ^

> 
> ------------------
> 
> From: Peter Zijlstra <peterz@infradead.org>
> 
> [ Upstream commit e379dce8af11d8d6040b4348316a499bfd174bfb ]
> 
> Commit 8e8e23dea43e ("sched/topology: Compute sd_weight considering
> cpuset partitions") ends up relying on the fact that structure
> initialization should not touch the flexible array.
> 
> However, the official GCC specification for "Arrays of Length Zero"
> [*] says:
> 
>   Although the size of a zero-length array is zero, an array member of
>   this kind may increase the size of the enclosing type as a result of
>   tail padding.
> 
> Additionally, structure initialization will zero tail padding. With
> the end result that since offsetof(*type, member) < sizeof(*type),
> array initialization will clobber the flex array.
> 
> Luckily, the way flexible array sizes are calculated is:
> 
>   sizeof(*type) + count * sizeof(*type->member)
> 
> This means we have the complete size of the flex array *outside* of
> sizeof(*type), so use that instead of relying on the broken flex array
> definition.
> 
> [*] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> 
> Fixes: 8e8e23dea43e ("sched/topology: Compute sd_weight considering cpuset partitions")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Debugged-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Chen Yu <yu.c.chen@intel.com>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://patch.msgid.link/20260323093627.GY3738010@noisy.programming.kicks-ass.net
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/linux/sched/topology.h | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 45c0022b91ced..6f8a4ae860da8 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -141,18 +141,30 @@ struct sched_domain {
>  
>  	unsigned int span_weight;
>  	/*
> -	 * Span of all CPUs in this domain.
> +	 * See sched_domain_span(), on why flex arrays are broken.
>  	 *
> -	 * NOTE: this field is variable length. (Allocated dynamically
> -	 * by attaching extra space to the end of the structure,
> -	 * depending on how many CPUs the kernel has booted up with)
> -	 */
>  	unsigned long span[];
> +	 */
>  };
>  
>  static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
>  {
> -	return to_cpumask(sd->span);
> +	/*
> +	 * Turns out that C flexible arrays are fundamentally broken since it
> +	 * is allowed for offsetof(*sd, span) < sizeof(*sd), this means that
> +	 * structure initialzation *sd = { ... }; which writes every byte
> +	 * inside sizeof(*type), will over-write the start of the flexible
> +	 * array.
> +	 *
> +	 * Luckily, the way we allocate sched_domain is by:
> +	 *
> +	 *   sizeof(*sd) + cpumask_size()
> +	 *
> +	 * this means that we have sufficient space for the whole flex array
> +	 * *outside* of sizeof(*sd). So use that, and avoid using sd->span.
> +	 */
> +	unsigned long *bitmap = (void *)sd + sizeof(*sd);
> +	return to_cpumask(bitmap);
>  }
>  
>  extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> -- 
> 2.53.0
> 
> 
> 

