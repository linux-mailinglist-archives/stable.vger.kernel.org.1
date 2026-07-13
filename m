Return-Path: <stable+bounces-273562-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mopmFcp1VGoLmQMAu9opvQ
	(envelope-from <stable+bounces-273562-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 07:21:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BA77473C6
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 07:21:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ajj7AkiG;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273562-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273562-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7338F30046A8
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 05:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7221C35FF5B;
	Mon, 13 Jul 2026 05:21:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E878D235C01
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 05:21:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783920067; cv=none; b=AJibS2Ih80rghUDgN/H2A3JcD3NuubX+WCvjWCQjes+RzbMKgeN86TX9hM/2LCrBASSubCOVolyIyAkF3qrrqYlH78aClvxqE75WvOkipgTP2P2NT+KoNcrQAGcglkYT5tit7mYbVYn3CYdDHet7Rjb7SwOAmXjtDzbuyUejopE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783920067; c=relaxed/simple;
	bh=hQxFD7i4yXKbNXdf7zrLnrm2u0tzyOUDotsrRF+73YU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=PdlMlkVnJ0rd92nX3SUTnN8u5KijbO/CicRLXjh+GF7LAKc4ImYyb6cbnWE/7cyeXhaFNJw/5E560IZTX1D+qCsNBW5vCx7R3sDFPsA/6amrbHRnrc+wHV/Tols+lcjcoH/16eFrDLlK58n7rgmq7FMGFPEg2kFbhIZHBJiUzj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ajj7AkiG; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381018b9375so3133588a91.0
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 22:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783920065; x=1784524865; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NgrUijC43NZjO9+tarpgdkIMgwBwcs7VglIntyvaAbA=;
        b=Ajj7AkiGrhbqE8ptQn7IjU9adPXU9L9VPVfJTdqpsmbLdPm3pFOQX02DZj4j7Yg23X
         y3BuU4cELZXzY/95YKB5MxQgAwp5VkXQdwJS0oDriyJeEegLWLJQfAZv16a8GFRgZF/H
         peWGgoFo/jRdjGwjJnLA3me7axcxgWbsqPKRSdjPN8LlyYNcYabsZYaHKyQfFcqJgis4
         m1FYK4C+rMpEgD8trDgWU3eEzK6R6xOVK1GwCXkQFXlhW5EmbcPjlJVkDJhTaShbAoO2
         celHEFv2UiGCcJrcZCsQkTxBNeDyOZUFc0BZeghMnYRnYWiKYovEXdqYPnOtvHJIEggG
         5wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783920065; x=1784524865;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NgrUijC43NZjO9+tarpgdkIMgwBwcs7VglIntyvaAbA=;
        b=oAXSuKkz2N+4+CVcNNwVK4iLV9/0UmFgcHwjHiUbeCZqEkVPCugiD46xfd1gI/QA7t
         vxhlITnzTjhjMfk11nCJ2iBYdEALudH++KVLwkOOHbx+emIHOfpgn7JKJd5Lx0t0I3rW
         pTGrHLSd7aKBkd7bymIJmwYlrUS50d/iKiqNZQbT/zLkxciDNLS5FfWeOTaDndhNCSMs
         8YvwCoyaxWiAlurSyJGAeObxIw+dcd1+4ocLacRFYf96+FpS2bADL3+r390SFr5pRDzA
         v9LQiwjs/PQVrWUdhlhyE9XpxkceFquPy4LjzpZ/sxZTSuMsiAcN7fgK91I+XL2Vpe/7
         hp+g==
X-Forwarded-Encrypted: i=1; AHgh+RoPnHUmxjTxD8goXLAcMZFwtet52QEvZFQmTcrqzQlCCdVISPJFndmoaRfDJolz98t4zjQUgps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3D5io0KEbmHoUFM+XLKUJSc7p4dXgGKFU4ZU97mJzacWLKQ+2
	NTw2b074jATk1VhCa4HVAYJrqA/5UAXc291XyG8QbXtH0jUYnOobvP/M
X-Gm-Gg: AfdE7cnQ4oCg/2eI2WEih7Q0oaNHijQyEN+iTYmpIZHtXgKQel7VXJiQbduXOFm1/hq
	RMV8xqYe2pppxPN8klwvC8gwYLL06nFGjFcYFUnMx4NufiBqdNtH3Aou92RWyZQL9Kf4jJZDCrF
	UFCtlaMjpvbV9YEOtcCZi+/SEZL8eqjty/Az/Ham87CecCmpxbkvZlNvMJVw/QUk0Yc0Bnq6047
	5IpscAc7QfcEE0mlvYNZsvDq6d3Z4zDf91VA8VgPrp+tjrsLE++0yA7FCiNK5US0bNgHWbnat22
	lstMhsbp+Qqrmuk6cBurB0AL3oUO110NqUoMpiADpGThFA1lSHg/vh6t94EsxAblq6on0KAzxDJ
	9rfT2Hkb7cgcYsC4u2pjRxeVTieTy171crg6FdKVTYdDb1zoyUHqnwUoDdh+ZCnIkA1J6u8ncRi
	9cknoQjJt8u/M=
X-Received: by 2002:a17:90b:2f0f:b0:38d:f710:63f0 with SMTP id 98e67ed59e1d1-38df7106443mr2705726a91.43.1783920065185;
        Sun, 12 Jul 2026 22:21:05 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm65148262eec.18.2026.07.12.22.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 22:21:04 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com, venkat88@linux.ibm.com, stable@vger.kernel.org, Sourabh Jain <sourabhjain@linux.ibm.com>, Mahesh Kumar G <mahe657@linux.ibm.com>
Subject: Re: [PATCH v2 3/3] powerpc/crash: stop watchdogs before booting kdump kernel
In-Reply-To: <20260713035954.1559605-4-sourabhjain@linux.ibm.com>
Date: Mon, 13 Jul 2026 10:40:06 +0530
Message-ID: <o6gbv5jl.ritesh.list@gmail.com>
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com> <20260713035954.1559605-4-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273562-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.ibm.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sourabhjain@linux.ibm.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:shivangu@linux.ibm.com,m:hbathini@linux.ibm.com,m:mahesh@linux.ibm.com,m:adityag@linux.ibm.com,m:venkat88@linux.ibm.com,m:stable@vger.kernel.org,m:mahe657@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46BA77473C6

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> On pseries LPAR systems, watchdog timers configured from userspace can
> remain active after a kernel panic. When a panic triggers kdump, the
> crashing kernel jumps directly to the kdump kernel without stopping
> active watchdogs. As a result, the watchdogs remain active after the
> kdump kernel starts.
>
> If dump capture takes longer than the watchdog timeout, PHYP resets the
> LPAR before the dump is fully captured, causing dump capture to fail.
>
> Fix this by issuing the `H_WATCHDOG` hcall during the crash shutdown
> sequence to stop all active watchdogs before booting the kdump kernel.
>
> Fixes: 69472ffa6575 ("watchdog/pseries-wdt: initial support for H_WATCHDOG-based watchdog timers")
> Reported-by: Mahesh Kumar G <mahe657@linux.ibm.com>
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/papr-watchdog.h |  2 ++
>  arch/powerpc/platforms/pseries/setup.c   | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/papr-watchdog.h b/arch/powerpc/include/asm/papr-watchdog.h
> index fb3a511aa861..84bbe1ddd56f 100644
> --- a/arch/powerpc/include/asm/papr-watchdog.h
> +++ b/arch/powerpc/include/asm/papr-watchdog.h
> @@ -55,4 +55,6 @@
>  #define PSERIES_WDTQ_MIN_TIMEOUT(cap)	(((cap) >> 48) & 0xffff)
>  #define PSERIES_WDTQ_MAX_NUMBER(cap)	(((cap) >> 32) & 0xffff)
>  
> +#define PSERIES_WDT_NUM_ALL	((unsigned long)-1)
> +

minor nit:

This should be defined at the end of the H_WATCHDOG Input section.
/*
 * H_WATCHDOG Input
 *

<...>

Something like this maybe?

/*
 * R5: "watchdogNumber":
 *       PAPR says use -1 (all ones) to stop all watchdogs.
 */
#define PSERIES_WDT_NUM_ALL	((unsigned long)-1)

/*
 * H_WATCHDOG Output
 *
 * R3: Return code
 *
 <...> 

>  #endif /* _ASM_POWERPC_CRASHDUMP_PPC64_H */
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index bbb2813f8ede..2e40a9dba637 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -77,6 +77,7 @@
>  #include <asm/dtl.h>
>  #include <asm/hvconsole.h>
>  #include <asm/setup.h>
> +#include <asm/papr-watchdog.h>
>  
>  #include "pseries.h"
>  
> @@ -185,6 +186,18 @@ static void __init fwnmi_init(void)
>  #endif
>  }
>  
> +#ifdef CONFIG_CRASH_DUMP
> +static void pseries_crash_stop_watchdogs(void)
> +{
> +	long rc;
> +
> +	rc = plpar_hcall_norets_notrace(H_WATCHDOG, PSERIES_WDTF_OP_STOP,
> +					PSERIES_WDT_NUM_ALL);
> +	if (rc != H_SUCCESS && rc != H_NOOP)
> +		pr_warn("Could not stop watchdogs before kdump rc=%ld\n", rc);
> +}
> +#endif /* CONFIG_CRASH_DUMP */
> +
>  /*
>   * Affix a device for the first timer to the platform bus if
>   * we have firmware support for the H_WATCHDOG hypercall.
> @@ -203,6 +216,11 @@ static __init int pseries_wdt_init(void)
>  		return PTR_ERR(pseries_wdt_dev);
>  	}
>  
> +#ifdef CONFIG_CRASH_DUMP
> +	if (crash_shutdown_register(pseries_crash_stop_watchdogs))
> +		pr_warn("Could not register watchdog crash shutdown handler\n");
> +#endif
> +

minor nit:
I don't think we need any of the #ifdef. All definitions used inside
pseries_crash_stop_watchdogs are already available and
crash_shutdown_register() already exists for !CONFIG_CRASH_DUMP, so we
may as well drop all of the ifdefs.


Otherwise LGTM, so feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


