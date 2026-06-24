Return-Path: <stable+bounces-268190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UC20J/cBPGrOiQgAu9opvQ
	(envelope-from <stable+bounces-268190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 18:12:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 974106BFEC1
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 18:12:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=YrM62DRh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268190-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268190-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A55313006912
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 16:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6A13C6A43;
	Wed, 24 Jun 2026 16:12:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB9F306775;
	Wed, 24 Jun 2026 16:12:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782317554; cv=none; b=aSilfHiOseL4ub3WXmAcIkwANvXvHOtea0gpjXLNTIJw1c2F7qs550hsFPFY937sNBp0MS/7yoyXG5ItjZiJ57l73mbk0eHGJUn+JIrJMZEW30OAPLibq2wjraL7wJacNaclwfOTrQB/R0ZYP2zivGnAqlSXn6DspM5FYAsvjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782317554; c=relaxed/simple;
	bh=MCMXBUpeLXOutfBbFK8TAU3rO6cuxbsu3V+GFPpcJc0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=iDua5gZ42gZX5nUdLCjm40zw/pLhyTbAY2VlRLtRGinlKm1OTolwZqbmnlk/6OwxZsNhDVUfdkNnDXJQvj4BO3fUJC+1ZGMZqo4XXN9diW46BXgmRca50P9WXhwUJZpTdWNPmNo5Nng6Zsh3/acSysZIANfde97+rhgDN1/uT+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=YrM62DRh; arc=none smtp.client-ip=185.218.207.228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782317551;
	bh=VnQUr85LCOui0QkTY9NjKigopViBoQ7x5EYpB8b0K74=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=YrM62DRhSFVLelbhXvWrZU2rfJ6oaoVsnB26D6/+rcUoc3Ss5Sz+tIpjVmMAARFKy
	 euhDTMnvO1Wf4e9iOlGsLUtgdY/42yZ2093VMpt26QBylka7cYdwyOu3/WtVHXnyWB
	 dk9YkvCd773tu6PrJth1qChw2NdWbYuV6HQFCaak=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4gln5W2j6JzGp8s;
	Wed, 24 Jun 2026 16:12:31 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4gln5V3s2VzGp8r;
	Wed, 24 Jun 2026 16:12:30 +0000 (UTC)
Date: Wed, 24 Jun 2026 17:12:28 +0100
From: Bradley Morgan <include@grrlz.net>
To: Feng Tang <feng.tang@linux.alibaba.com>
CC: Petr Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_4/4=5D_panic=3A_avoid_dupli?=
 =?US-ASCII?Q?cate_all_CPU_backtraces_from_sys=5Finfo?=
In-Reply-To: <ajtF8xCGBNH3wzzo@U-2FWC9VHC-2323.local>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net> <2199a8b4da8700b9f27e61486293e9c26ab107ef.1782228656.git.include@grrlz.net> <ajtF8xCGBNH3wzzo@U-2FWC9VHC-2323.local>
Message-ID: <F8A80465-2EE6-457C-A580-5CC325A5A226@grrlz.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,linux-foundation.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,linux.intel.com,mobileye.com,chromium.org,google.com,lists.ozlabs.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268190-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:feng.tang@linux.alibaba.com,m:pmladek@suse.com,m:akpm@linux-foundation.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:mchauras@linux.ibm.com,m:andriy.shevchenko@linux.intel.com,m:wangjinchao600@gmail.com,m:kees@kernel.org,m:rioo.tsukatsukii@gmail.com,m:joel.granados@kernel.org,m:pnina.feder@mobileye.com,m:petr.pavlu@suse.com,m:senozhatsky@chromium.org,m:dianders@chromium.org,m:mrungta@google.com,m:tj@kernel.org,m:yaozhenguo1@gmail.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:riootsukatsukii@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[grrlz.net:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 974106BFEC1

On June 24, 2026 3:50:27 AM GMT+01:00, Feng Tang
<feng.tang@linux.alibaba.com> wrote:
>On Tue, Jun 23, 2026 at 03:35:01PM +0000, Bradley Morgan wrote:
>> panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping the
>> other CPUs. Do not ask sys_info() to handle that bit again later in the
>> panic path.
>> 
>> Use sys_info_without_all_bt() so panic_print=all_bt does not request
>more
>> output after the CPUs are stopped.
>
>Good catch! Thanks!
>
>Later in panic_other_cpus_shutdown(), it sends IPIs to stop other CPUs,
>and
>this patch does avoid dumping local call trace again!
>
>For the whole serie, feel free to add:
>
>Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
>
>Thanks,
>Feng

Thanks a lot Feng!

All 4 patches, right?

I'll let the maintainer (whomever will merge it) merge it, and add 
your tag!

If you would like, Feng, if you CC me on any watchdog, etc etc patch,
I'm sure I'll help review! :)

Thanks for your tag.


>> 
>> Fixes: b76e89e50fc3 ("panic: generalize panic_print's function to show
>sys info")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>> ---
>> Changes since v1:
>> - New patch using the same helper for panic.
>> 
>>  kernel/panic.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/kernel/panic.c b/kernel/panic.c
>> index d030f88ad4ef..2cf229c7c0cf 100644
>> --- a/kernel/panic.c
>> +++ b/kernel/panic.c
>> @@ -683,7 +683,7 @@ void vpanic(const char *fmt, va_list args)
>>  	 */
>>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>>  
>> -	sys_info(panic_print);
>> +	sys_info_without_all_bt(panic_print);
>>  
>>  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
>>  
>> -- 
>> 2.53.0
>

Thanks!

