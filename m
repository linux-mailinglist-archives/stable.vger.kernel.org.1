Return-Path: <stable+bounces-268575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CwnvG5U+PWpK0AgAu9opvQ
	(envelope-from <stable+bounces-268575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:43:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACAE6C6C54
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:43:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=cVpKmTOS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268575-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-268575-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B0BA300E019
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 14:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3E13E6386;
	Thu, 25 Jun 2026 14:43:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097653A8738;
	Thu, 25 Jun 2026 14:43:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398611; cv=none; b=NJbzVnmN06o/3W4a4SzX7+TuO+y4eqX6a31NCOcA0zMbCaB8K2HFOCpooxGnSk/BGeP2tyn9vrzg94BxzGokHK17r2TmcWprRp/DXytsBe7xkib+RVJ9FHG4rJBiA1EPZj4aF27VxXLtY6ZU5Zqap2+5wwhCyzGgPAYOqjBz4lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398611; c=relaxed/simple;
	bh=0YmjP4c35CyU6dSFGeiMYD4pUi5ZnBclTpIdMEK3Ykg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gWvus91qwGH+WAInwiQmDezqk/PZduHcTeWx0h/UE3Ru6Thter7rGLv6myT+uoQOs+k9lcRICiJQ/P0CMjA63Y/6q87k+l40TjxqMvpwZ1XzRkJw/gjOtJwbnelUGtZ9G/i9wZrk/rZcOFyROn9fUiP/ab92r7V+YW6MRoizo0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=cVpKmTOS; arc=none smtp.client-ip=185.218.207.228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782398605;
	bh=WLGg/qNr6zyTjoQ8SIyFz87JHSmJwOpxTGwb6Pye5Qs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=cVpKmTOSDKfXYRNG6q4brwY9CT/MaqUBcTVmZYtdxGIY37jJGYeCOzr/Udd69jfbR
	 RU5SzygZBVj4rRC1b3Y9XlOlEkGg74+sAobwI80SovtL0kAyr8NBNJNnpBwFIxhH9m
	 3zXzc6xL3X/lTISoyQnihcp7lUoz5V/KbE33Ckgk=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4gmM4F6v01zGpDG;
	Thu, 25 Jun 2026 14:43:25 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4gmM4F3STNzGpD3;
	Thu, 25 Jun 2026 14:43:25 +0000 (UTC)
Date: Thu, 25 Jun 2026 15:43:26 +0100
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>
CC: Feng Tang <feng.tang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jinchao Wang <wangjinchao600@gmail.com>, Kees Cook <kees@kernel.org>,
 Rio <rioo.tsukatsukii@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Pnina Feder <pnina.feder@mobileye.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Douglas Anderson <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>,
 Tejun Heo <tj@kernel.org>, Zhenguo Yao <yaozhenguo1@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/4=5D_sys=5Finfo=3A_add_he?=
 =?US-ASCII?Q?lper_for_callers_that_handle_all=5Fbt?=
In-Reply-To: <aj01RHgagZm83dFq@pathway.suse.cz>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net> <aj01RHgagZm83dFq@pathway.suse.cz>
Message-ID: <D2693750-5CA8-4F0E-B73A-2D07AD611034@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,linux-foundation.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,linux.intel.com,mobileye.com,suse.com,chromium.org,google.com,lists.ozlabs.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268575-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pmladek@suse.com,m:feng.tang@linux.alibaba.com,m:akpm@linux-foundation.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:mchauras@linux.ibm.com,m:andriy.shevchenko@linux.intel.com,m:wangjinchao600@gmail.com,m:kees@kernel.org,m:rioo.tsukatsukii@gmail.com,m:joel.granados@kernel.org,m:pnina.feder@mobileye.com,m:petr.pavlu@suse.com,m:senozhatsky@chromium.org,m:dianders@chromium.org,m:mrungta@google.com,m:tj@kernel.org,m:yaozhenguo1@gmail.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:riootsukatsukii@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[grrlz.net:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:email,sashiko.dev:url,grrlz.net:dkim,grrlz.net:email,grrlz.net:mid,grrlz.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0ACAE6C6C54

On June 25, 2026 3:03:48 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
wrote:
>On Tue 2026-06-23 15:34:58, Bradley Morgan wrote:
>> Some callers handle SYS_INFO_ALL_BT themselves before calling
>sys_info().
>> Add a helper that strips that bit without turning an all_bt only mask
>into
>> a kernel_sys_info fallback.
>> 
>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>> ---
>> Changes since v1:
>> - New patch for the shared helper suggested by Petr.
>> 
>>  include/linux/sys_info.h |  1 +
>>  lib/sys_info.c           | 15 +++++++++++++++
>>  2 files changed, 16 insertions(+)
>> 
>> diff --git a/include/linux/sys_info.h b/include/linux/sys_info.h
>> index a5bc3ea3d44b..87a841ec7b6a 100644
>> --- a/include/linux/sys_info.h
>> +++ b/include/linux/sys_info.h
>> @@ -18,6 +18,7 @@
>>  #define SYS_INFO_BLOCKED_TASKS		0x00000080
>>  
>>  void sys_info(unsigned long si_mask);
>> +void sys_info_without_all_bt(unsigned long si_mask);
>>  unsigned long sys_info_parse_param(char *str);
>>  
>>  #ifdef CONFIG_SYSCTL
>> diff --git a/lib/sys_info.c b/lib/sys_info.c
>> index f32a06ec9ed4..6afd4c697633 100644
>> --- a/lib/sys_info.c
>> +++ b/lib/sys_info.c
>> @@ -164,3 +164,18 @@ void sys_info(unsigned long si_mask)
>>  {
>>  	__sys_info(si_mask ? : kernel_si_mask);
>>  }
>> +
>> +void sys_info_without_all_bt(unsigned long si_mask)
>> +{
>> +	unsigned long dump_mask = si_mask & ~SYS_INFO_ALL_BT;
>> +
>> +	/*
>> +	 * Do not call sys_info() when the caller context required only
>> +	 * backtraces from all CPUs. Otherwise sys_info() would fall back
>> +	 * to the generic kernel_si_mask.
>> +	 */
>> +	if (si_mask && !dump_mask)
>> +		return;
>> +
>> +	sys_info(dump_mask);
>> +}
>
>Sashiko AI pointed out that this function still migth trigger printing
>duplicate backtraces when (si_mask == 0). It calls sys_info(0)
>which falls back to kernel_si_mask which might have SYS_INFO_ALL_BT
>bit set, see
>https://sashiko.dev/#/patchset/9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include%40grrlz.net
>
>=> we need to eventually disable the SYS_INFO_ALL_BT bit also
>   in kernel_si_mask.
>
>I think about creating a generic API which would allow to apply
>a filter mask, something like:
>
>From 02fc810a801adc0fc4d1fd14318415719bdfc656 Mon Sep 17 00:00:00 2001
>From: Bradley Morgan <include@grrlz.net>
>Date: Tue, 23 Jun 2026 15:34:58 +0000
>Subject: [PATCH 1/4] sys_info: add helper for callers that print some
>sys_info on their own
>
>Some callers print some sys_info on their own before calling sys_info().
>Add a helper which would allow to prevent a duplicated output.
>
>It is a bit tricky because kernel_si_mask should be used only
>when the call-specific si_mask is empty. But the duplicated
>output must be prevented there as well.
>
>Signed-off-by: Bradley Morgan <include@grrlz.net>
>Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup") ?
>Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")
>---
> include/linux/sys_info.h |  1 +
> lib/sys_info.c           | 20 ++++++++++++++++++--
> 2 files changed, 19 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/sys_info.h b/include/linux/sys_info.h
>index a5bc3ea3d44b..f1c2552ca3d1 100644
>--- a/include/linux/sys_info.h
>+++ b/include/linux/sys_info.h
>@@ -18,6 +18,7 @@
> #define SYS_INFO_BLOCKED_TASKS		0x00000080
> 
> void sys_info(unsigned long si_mask);
>+void sys_info_with_filter(unsigned long si_mask, unsigned long si_ignore_mask);
> unsigned long sys_info_parse_param(char *str);
> 
> #ifdef CONFIG_SYSCTL
>diff --git a/lib/sys_info.c b/lib/sys_info.c
>index f32a06ec9ed4..d411fee10415 100644
>--- a/lib/sys_info.c
>+++ b/lib/sys_info.c
>@@ -136,8 +136,10 @@ static int __init sys_info_sysctl_init(void)
> subsys_initcall(sys_info_sysctl_init);
> #endif
> 
>-static void __sys_info(unsigned long si_mask)
>+static void __sys_info(unsigned long si_mask, unsigned long si_ignore_mask)
> {
>+	si_mask &= ~si_ignore_mask;
>+
> 	if (si_mask & SYS_INFO_TASKS)
> 		show_state();
> 
>@@ -160,7 +162,21 @@ static void __sys_info(unsigned long si_mask)
> 		show_state_filter(TASK_UNINTERRUPTIBLE);
> }
> 
>+void sys_info_with_filter(unsigned long si_mask, unsigned long si_ignore_mask)
>+{
>+	unsigned long dump_mask = si_mask & ~si_ignore_mask;
>+
>+	/*
>+	 * Do not fall back to kernel_si_mask when the caller context
>+	 * required only the ignored information.
>+	 */
>+	if (si_mask && !dump_mask)
>+		return;
>+
>+	__sys_info(dump_mask ? : kernel_si_mask, si_ignore_mask);
>+}
>+
> void sys_info(unsigned long si_mask)
> {
>-	__sys_info(si_mask ? : kernel_si_mask);
>+	sys_info_with_filter(si_mask, 0);
> }
>
>The next patches might use sys_info_with_filter(si_mask,
>SYS_INFO_ALL_BT) instead of sys_info_without_all_bt(si_mask).
>
>Feel free to bike shed about the function name. Also I am not
>sure whether to pass the filter as bits to filter or already
>the complement (~mask).
>
>Best Regards,
>Petr
>
>

Okay petr, so, The whole V3 situation..

I have to 
- Add (or modify) your suggestion
- Add fengs reviewed by tag
- and find a more neutral fixes tag
- And also add Cc stable to patch 1

Ill work on V4 today.

Thanks!

