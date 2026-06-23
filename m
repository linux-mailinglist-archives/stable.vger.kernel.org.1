Return-Path: <stable+bounces-268026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kRDTL63pOmrCLAgAu9opvQ
	(envelope-from <stable+bounces-268026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 22:16:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C7E6B9E95
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 22:16:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=Zpv3AvJh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268026-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268026-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 573A9301FB80
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 20:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8725E396572;
	Tue, 23 Jun 2026 20:16:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B54331EA2;
	Tue, 23 Jun 2026 20:16:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245797; cv=none; b=hJ5RA0gqKq0iW2I8hC3V/UiKV34u1K0VtzZpALKT09xOqL/4hCYjtvrd6zRKuiF6fd9+DTHI8amhoWX7RhdMz7fLGaScA/brhXrgU5vxOqEvxxGXCMwE8gffekjKYHdOHlPqHSdbKuRSK8kTeVGQl3E2MSL5r6s7kIqWt/IakzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245797; c=relaxed/simple;
	bh=8RqeGuKed0WW87dmUpG3J3VwPycQJqkB9qD1M2SnUx0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Lirc75iMOhuvt/HUdL/5XB0iQa6FJHxUZTu1SA4PxO8mzByfLic031x+VNwrMok5VPI7jJz76JCP2WA3Rj0kEIbHWQ/OlRdmwriGD7JlUG0yAibZ2VfQbjjQ727LhgQj2paNdydoLA9dPrpVVgnwr/v4zIvzqaoPqQ5Aq9NcKBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=Zpv3AvJh; arc=none smtp.client-ip=185.218.207.228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782245793;
	bh=IAfJFwEnmp1agnnfX2jU4/znEwpzF5AMDwIablcmerY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Zpv3AvJhgt1AJ+adOVBabJ3ndlVmvcsuP0v+O20iopTJZNegAtauD78JpvjX7MAnd
	 W9+1taFmIX0eC1TW6DN9IydnVTqtTDBk9eCMjFlDAw/qBRjM9//w73UxL7nuIjLEY2
	 hpb9VUQZvyb17oFkpsk4zB3S95GKuTcABZY1gJE8=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4glGYY3hh1zGpD0;
	Tue, 23 Jun 2026 20:16:33 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4glGYY1Lw3zGpCr;
	Tue, 23 Jun 2026 20:16:33 +0000 (UTC)
Date: Tue, 23 Jun 2026 21:16:33 +0100
From: Bradley Morgan <include@grrlz.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Petr Mladek <pmladek@suse.com>, Feng Tang <feng.tang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
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
In-Reply-To: <ajrpPMo3Qc_SgFkG@ashevche-desk.local>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net> <ajrob9r6cVtxqv72@ashevche-desk.local> <ajrpPMo3Qc_SgFkG@ashevche-desk.local>
Message-ID: <39C3E79F-CB10-4711-95B5-024D6750BDF6@grrlz.net>
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
	FREEMAIL_CC(0.00)[suse.com,linux.alibaba.com,linux-foundation.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,mobileye.com,chromium.org,google.com,lists.ozlabs.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268026-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:pmladek@suse.com,m:feng.tang@linux.alibaba.com,m:akpm@linux-foundation.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:mchauras@linux.ibm.com,m:wangjinchao600@gmail.com,m:kees@kernel.org,m:rioo.tsukatsukii@gmail.com,m:joel.granados@kernel.org,m:pnina.feder@mobileye.com,m:petr.pavlu@suse.com,m:senozhatsky@chromium.org,m:dianders@chromium.org,m:mrungta@google.com,m:tj@kernel.org,m:yaozhenguo1@gmail.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:riootsukatsukii@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:email,grrlz.net:dkim,grrlz.net:mid,grrlz.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6C7E6B9E95

On June 23, 2026 9:14:52 PM GMT+01:00, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>On Tue, Jun 23, 2026 at 11:11:34PM +0300, Andy Shevchenko wrote:
>> On Tue, Jun 23, 2026 at 03:34:58PM +0000, Bradley Morgan wrote:
>> > Some callers handle SYS_INFO_ALL_BT themselves before calling
>sys_info().
>> > Add a helper that strips that bit without turning an all_bt only mask
>into
>> > a kernel_sys_info fallback.
>> 
>> You also want a getter with check
>> 
>> bool sysinfo_is_all_bt_enabled(...,  *si_mask)
>> 
>> where *si_mask is the result of READ_ONCE() that you keep as
>implementation
>> detail inside this helper.
>
>Ah, sorry, I have thought that the mask is part of sysinfo implementation.
>Disregard my above comment, it can't be done without also supplying the
>pointer
>to the original one, which makes no sense.

Ah, yeah, I was gonna say that.

No worries, will disregard! :)

>

Thanks!

