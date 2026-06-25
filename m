Return-Path: <stable+bounces-268605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BVRkAOBNPWoq1AgAu9opvQ
	(envelope-from <stable+bounces-268605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:48:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 483696C72B8
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:48:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=YI4Lvsii;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268605-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268605-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BFA7305B120
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2FD26F2BE;
	Thu, 25 Jun 2026 15:48:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0B7192B75;
	Thu, 25 Jun 2026 15:48:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402487; cv=none; b=qzlYYZIwbvfI29u61Cc7iHPQRxEs1h1OMEME/H65JOxjmT2/71+8hVskSJguZJvpol2U3zgjH6f49WsY1G+fuMkJND5eGwgDpLz1fpfmKeHguILksHnL6Ft4Zjjjh3cNa8ZSnlSwI/DN4z18LLP/tLr7Lm5Q1UqEaF/TnSHMi7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402487; c=relaxed/simple;
	bh=clKvRw3PDBeqFIL5Zp3bT9qnSYhoVfjT9OOcuMYl1a4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=dXzAHPcF6Cf3IfvoWkM/fmNRuNp7ZbBdq3zbn2j5rblcJbTcPvfXk2ckNr5Gc6YbJ5UfR5n0CXfXIkqeCFbRGAt3jpeXMjIef2ZO/9QO+Sb/F7bsAyYN/KDHQPuW6zkEu3ED373/2Ux9Vy7Kpv/4QpNEIq/0Zzd3i4ZGy3uSGjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=YI4Lvsii; arc=none smtp.client-ip=185.218.207.228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782402484;
	bh=eA8msFe4nCREb1EQHy7RNtgoYqKSimrXWAQli+HDGwo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=YI4LvsiifIK0LLippDYvNlYIvgt46NgpzhuMRJeQ/R/l/XxXC6L2S0OnpclJDOrIq
	 8xRDVBmklPDeSReseuN2Qf1WTUGYUlf7JdxfksuURDVPjhBH2MjJKanEYE3lPddook
	 wh/aUaEdeuZ/Hgld+aW8Uckly1XRqK2AGni7zQ4I=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4gmNVr5lSMzGpDl;
	Thu, 25 Jun 2026 15:48:04 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4gmNVr2X9JzGpDM;
	Thu, 25 Jun 2026 15:48:04 +0000 (UTC)
Date: Thu, 25 Jun 2026 16:48:04 +0100
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
 Feng Tang <feng.tang@linux.alibaba.com>,
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
 stable@vger.kernel.org, Michal Hocko <mhocko@suse.cz>,
 Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jkosina@suse.cz>
Subject: =?US-ASCII?Q?Re=3A_Fixed_tag_magic=3A_was=3A_Re=3A_=5BPATCH_v2_1/4=5D_sys?=
 =?US-ASCII?Q?=5Finfo=3A_add_helper_for_callers_that_handle_all=5Fbt?=
In-Reply-To: <A9C69766-159B-4A79-B409-AD56B2856F8F@grrlz.net>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net> <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org> <aj1Jh57McGH94gGY@pathway.suse.cz> <EEB33A51-758A-4A67-8AC5-7200B53F8C1D@grrlz.net> <aj1MdKcXP3uIW7AX@pathway.suse.cz> <A9C69766-159B-4A79-B409-AD56B2856F8F@grrlz.net>
Message-ID: <13CAC0EF-D0DC-4106-AF0E-B7BF4B51FC12@grrlz.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.alibaba.com,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,linux.intel.com,mobileye.com,suse.com,chromium.org,google.com,lists.ozlabs.org,vger.kernel.org,suse.cz];
	TAGGED_FROM(0.00)[bounces-268605-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pmladek@suse.com,m:akpm@linux-foundation.org,m:feng.tang@linux.alibaba.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:mchauras@linux.ibm.com,m:andriy.shevchenko@linux.intel.com,m:wangjinchao600@gmail.com,m:kees@kernel.org,m:rioo.tsukatsukii@gmail.com,m:joel.granados@kernel.org,m:pnina.feder@mobileye.com,m:petr.pavlu@suse.com,m:senozhatsky@chromium.org,m:dianders@chromium.org,m:mrungta@google.com,m:tj@kernel.org,m:yaozhenguo1@gmail.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:mhocko@suse.cz,m:mbenes@suse.cz,m:jkosina@suse.cz,m:riootsukatsukii@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[grrlz.net:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 483696C72B8

On June 25, 2026 4:46:11 PM GMT+01:00, Bradley Morgan <include@grrlz.net>
wrote:
>On June 25, 2026 4:42:44 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
>wrote:
>>On Thu 2026-06-25 16:31:47, Bradley Morgan wrote:
>>> On June 25, 2026 4:30:15 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
>>> wrote:
>>> >On Wed 2026-06-24 13:34:19, Andrew Morton wrote:
>>> >> On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan
><include@grrlz.net>
>>> >wrote:
>>> >> 
>>> >> > Some callers handle SYS_INFO_ALL_BT themselves before calling
>>> >sys_info().
>>> >> > Add a helper that strips that bit without turning an all_bt only
>>mask
>>> >into
>>> >> > a kernel_sys_info fallback.
>>> >> 
>>> >> I assume this patch wants a Fixes: and a cc:stable also.
>>> >> 
>>> >> It would be nice to have the conventional [0/N] cover letter to tell
>>> >> readers what this is all about.
>>> >> 
>>> >> The patches all have different Fixes: targets.  This risks inviting
>>the
>>> >> -stable maintainers to merge only some of the patches into some
>>> >> kernels, resulting in an untested combination and which might break
>>> >> things.
>>> >
>>> >I do not agree here. The Fixes tag should should point to a commit
>>> >which introduced the regression into the given code. And finding
>>> >some magic common point beause there is some magic undocumented
>>> >process for maintaining stable kernels sounds like a way to hell
>>> >to me.
>>> >
>>> >Best Regards,
>>> >Petr
>>> 
>>> 
>>> oh no.
>>> I added the generic tag to V4, no worries, it is the earliest possible
>>> fixes tag. But I really don't wanna be doing a V5 just to revert my
>>> fixes tags.
>>
>>This is the risk when sending 4 versions of a fix within 5 days.

Oops, I was wrong, 3 versions.


>>A good practice is to wait at least one week before sending another
>>version. It gives people chance to react and helps the discussion
>>to settle.
>>
>>That said, I am not going to block this because of the fixes tags.
>>But I suggest to wait longer next time.
>>
>>Best Regards,
>>Petr
>>
>
>The whole fixes tag thing is unfortunate.
>
>because it should be Fixes: then whatever commit ADDS the regression.
>
>Not a common fixes tag for all! 
>
>Maybe when it's merged, Andrew or someone else could do 
>
>
>Cc: stable@vger.kernel.org [5.10] for instance, for it to be backported to that version.
>
>That should fix the whole fiasco
>
>Thanks!

Thanks!

