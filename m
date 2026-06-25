Return-Path: <stable+bounces-268254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 89wqH8GhPGrOpwgAu9opvQ
	(envelope-from <stable+bounces-268254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 05:34:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0C96C2970
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 05:34:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=Ap1gpSmX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268254-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268254-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29380304ED51
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 03:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA97F2C0298;
	Thu, 25 Jun 2026 03:33:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E014137923;
	Thu, 25 Jun 2026 03:33:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782358430; cv=none; b=ARk0EXdiKhevmzvtXzvKHxLQ+2CPWl36YEnNjH/RnmWkcudmmyLG/SEqJ9rf9KtKW1i5n8gTmnbki5S1Qd5Bz7bpXk0TYROciSsng5/Tp7RUt1bBpW0StrAEDD5jnq5wi9P2loPepCgAdmpgLMxLUzVOAbOSGzReTo9ho41mqxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782358430; c=relaxed/simple;
	bh=QsU0U+WQKr9miZ/DK3ZXIbamguJ9Ru8aExrjHQJgKSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F88Ozp6qVac/CGhXtskm+JV1rP/N3Qg/x9MNRdG0rNDWgEZaAXMHt+UsORfYDuVb9uimrYLE4mA72bQyeJaimDIsXzViOG1GG4zqjfjeSFPr+d1GTqEiujitLckDQpfijJJKb3+2CcMveOFyEEtYYi0OpGkfHAFJImGdL9ytc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ap1gpSmX; arc=none smtp.client-ip=115.124.30.101
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782358419; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=QK/WgekjtjSCmNGa+5JxIa5FygQOjUBbLChzAd+upEE=;
	b=Ap1gpSmXeO8nEU8qqcpht2qRb34oHEok9ft9xWN5WYG3T9vMbh5GtulnAOEp6nE3f4ygaeuupR4m2SMZn6GzHuMaAGRhOvgvfkzBppvfcpqn50cVUAvvczM1B6WDEaYBbnjTlqWDXw+lkenDLFlEGJ+e3vzQwrKbZfZm9yVhdqo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X5a-j0z_1782358416;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X5a-j0z_1782358416 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Jun 2026 11:33:37 +0800
Date: Thu, 25 Jun 2026 11:33:36 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>, Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>, Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] panic: avoid duplicate all CPU backtraces from
 sys_info
Message-ID: <ajyhkJjVw3s_phsT@U-2FWC9VHC-2323.local>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
 <2199a8b4da8700b9f27e61486293e9c26ab107ef.1782228656.git.include@grrlz.net>
 <ajtF8xCGBNH3wzzo@U-2FWC9VHC-2323.local>
 <F8A80465-2EE6-457C-A580-5CC325A5A226@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F8A80465-2EE6-457C-A580-5CC325A5A226@grrlz.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:include@grrlz.net,m:pmladek@suse.com,m:akpm@linux-foundation.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:mchauras@linux.ibm.com,m:andriy.shevchenko@linux.intel.com,m:wangjinchao600@gmail.com,m:kees@kernel.org,m:rioo.tsukatsukii@gmail.com,m:joel.granados@kernel.org,m:pnina.feder@mobileye.com,m:petr.pavlu@suse.com,m:senozhatsky@chromium.org,m:dianders@chromium.org,m:mrungta@google.com,m:tj@kernel.org,m:yaozhenguo1@gmail.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:riootsukatsukii@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[feng.tang@linux.alibaba.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268254-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[feng.tang@linux.alibaba.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[suse.com,linux-foundation.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,linux.intel.com,mobileye.com,chromium.org,google.com,lists.ozlabs.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E0C96C2970

On Wed, Jun 24, 2026 at 05:12:28PM +0100, Bradley Morgan wrote:
> On June 24, 2026 3:50:27 AM GMT+01:00, Feng Tang
> <feng.tang@linux.alibaba.com> wrote:
> >On Tue, Jun 23, 2026 at 03:35:01PM +0000, Bradley Morgan wrote:
> >> panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping the
> >> other CPUs. Do not ask sys_info() to handle that bit again later in the
> >> panic path.
> >> 
> >> Use sys_info_without_all_bt() so panic_print=all_bt does not request
> >more
> >> output after the CPUs are stopped.
> >
> >Good catch! Thanks!
> >
> >Later in panic_other_cpus_shutdown(), it sends IPIs to stop other CPUs,
> >and
> >this patch does avoid dumping local call trace again!
> >
> >For the whole serie, feel free to add:
> >
> >Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
> >
> >Thanks,
> >Feng
> 
> Thanks a lot Feng!
> 
> All 4 patches, right?

Yes.

> 
> I'll let the maintainer (whomever will merge it) merge it, and add 
> your tag!
> 
> If you would like, Feng, if you CC me on any watchdog, etc etc patch,
> I'm sure I'll help review! :)
> 
> Thanks for your tag.
 
No problem. Thanks for fixing the bug I introduced! :)

- Feng

