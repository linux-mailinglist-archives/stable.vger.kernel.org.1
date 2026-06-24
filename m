Return-Path: <stable+bounces-268222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T814JMhBPGoWlwgAu9opvQ
	(envelope-from <stable+bounces-268222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 22:44:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 860C46C13EE
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 22:44:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b="JSG/Ctd2";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268222-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268222-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB12D300CF23
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AE13CB2DA;
	Wed, 24 Jun 2026 20:44:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953813CC7F8;
	Wed, 24 Jun 2026 20:44:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782333888; cv=none; b=BSncqrdkuAejOd54FAs7YYVFU1J4Z6kMf2AoTd1yh3W6oK6lNOoMvVNCOf56cK7cuOZ6AxznZHRsucPDkaHsa/Y/ORdZnT6GMHy4YvLwXuKGPmf45gR2EqQGvCMMx+AK88uloT1SyuWq/30mYuwQvXy40FxqDKf9IoLkTZHvZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782333888; c=relaxed/simple;
	bh=/nF1XXN/eXkQFxd1HcJEou56qTf9cFgnye7zkTTqs0E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=K0C+KTf/L6N31G+8mbeWGAOtQzKqaEmMXeL7BPj5I1xIQR6n2nRHpmW8JQWdrjwynHcIgYLHlegdnv9wSx+Tg8i8FFb65ziINmsJg50yEfRSOoIlT4P6HOWprevkZYsx3RuhXnm5k6hxzuZEaqZbUuOym0X3n2nXPd35Jun6K9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=JSG/Ctd2; arc=none smtp.client-ip=198.167.222.108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782333878;
	bh=msQPwdVONZeSYGE9jE2dmPBtZAtGxjXbxerzmKa/UWM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=JSG/Ctd2Md6Q+xRTMF28fasvwDclbHM8QOk8NEF3F3N4ZRC+sC8XAJG0A0953LXyV
	 xocsWCAFCUtjaA11haOGtLlLFxVfktCvnvbiSL7KW0sm7z+hmgDA5i2Eb9KVsm79dT
	 UZgamLEMLDbi2dyDVI48q7e2G3g95Icr2d2JzlQ0=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4glv7V21j2z6vLR;
	Wed, 24 Jun 2026 20:44:38 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4glv7T6C6sz4y2q;
	Wed, 24 Jun 2026 20:44:37 +0000 (UTC)
Date: Wed, 24 Jun 2026 21:44:37 +0100
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Petr Mladek <pmladek@suse.com>, Feng Tang <feng.tang@linux.alibaba.com>,
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
In-Reply-To: <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net> <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org>
Message-ID: <EB858B12-203D-4173-A44B-4926129983F4@grrlz.net>
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
	FREEMAIL_CC(0.00)[suse.com,linux.alibaba.com,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,linux.intel.com,mobileye.com,chromium.org,google.com,lists.ozlabs.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268222-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:pmladek@suse.com,m:feng.tang@linux.alibaba.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:mchauras@linux.ibm.com,m:andriy.shevchenko@linux.intel.com,m:wangjinchao600@gmail.com,m:kees@kernel.org,m:rioo.tsukatsukii@gmail.com,m:joel.granados@kernel.org,m:pnina.feder@mobileye.com,m:petr.pavlu@suse.com,m:senozhatsky@chromium.org,m:dianders@chromium.org,m:mrungta@google.com,m:tj@kernel.org,m:yaozhenguo1@gmail.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:riootsukatsukii@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[grrlz.net:dkim,grrlz.net:email,grrlz.net:mid,grrlz.net:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 860C46C13EE

On June 24, 2026 9:34:19 PM GMT+01:00, Andrew Morton
<akpm@linux-foundation.org> wrote:
>On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan <include@grrlz.net>
>wrote:
>
>> Some callers handle SYS_INFO_ALL_BT themselves before calling
>sys_info().
>> Add a helper that strips that bit without turning an all_bt only mask
>into
>> a kernel_sys_info fallback.
>
>I assume this patch wants a Fixes: and a cc:stable also.

Fixes, perhaps 
Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup") ?

>It would be nice to have the conventional [0/N] cover letter to tell
>readers what this is all about.

I added a what I changed? I'm iffy on cover letters, if you want I'll do
it...

>The patches all have different Fixes: targets.  This risks inviting the
>-stable maintainers to merge only some of the patches into some
>kernels, resulting in an untested combination and which might break
>things.

In merge-time, could we do 


Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")


>It would be cleaner to make all patches have the same Fixes: target if
>possible.

Ditto.

Thanks!

