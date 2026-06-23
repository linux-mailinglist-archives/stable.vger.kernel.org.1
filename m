Return-Path: <stable+bounces-268024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2SrhAWrpOmqFLAgAu9opvQ
	(envelope-from <stable+bounces-268024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 22:15:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AB36B9E71
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 22:15:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=U8EH9yBR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268024-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268024-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD7C23075D93
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 20:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAE439656C;
	Tue, 23 Jun 2026 20:15:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCBC395AE7;
	Tue, 23 Jun 2026 20:15:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245701; cv=none; b=P151ZDBEmjb0H32keHxJBPeYWmdk66fZiu087eMsciA55rwoOjAqaNuY59EKL90fBi5MaefZ1NfZVwrIWMYbBWSzqzSSzvpuDw4pSxgZBs8wJ1ivIuZB85zjhJG9xwomIxRWq+TZLIIyxIZaulzE4BKu0JB1Y4nQc8PPOPe7THM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245701; c=relaxed/simple;
	bh=JhveSp07tSCHgDphz8hRbsEB38K+EDMblTYhxwKyh20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMhhjDel1rD5lS8MofkCo/jGPBIpEJgyxq+mh3ZDvV9gs5abEnoTduWfUNxii2qslZjy64KwYcROLrAb8mYxAn89o96tyFhZNuUJVbJjbLStc28ql0QKHzHG5d+//hZrx0AMoWbLEt1EmExXcOU9ZbfWTL0AR4H6R5Vsevjc5i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8EH9yBR; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782245700; x=1813781700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JhveSp07tSCHgDphz8hRbsEB38K+EDMblTYhxwKyh20=;
  b=U8EH9yBRjF0jvBA8dW3Zolj2WMK+pnYE9+gdOWuCRSZTAZGUA4KaL5kL
   w5Gh7WawXBVpw1c7ubSqtjS9tXpQxwtDad2LGEt3tobVkOMrGoM3UplPG
   A8jNx9c/WQVweTr26CkwfGOcw04tHywtGzgEq/QfBz2uzQs+r50c4iXbN
   UWbnSIX5b3uyfnvmC3snM/xfD1oUeGabOY7PT+OR1eVhja3Yg5Exi7KeE
   03bppfIB01aeQaqnTKIOKgSTvUxbP7AUC+7DUT1c5qzf1r64+5aQteKOH
   Ac7auS18zJoMFZSvJZ0gNZv/DaP96V78cnDWU4NzSKKa7OjGl4OCRIu9u
   g==;
X-CSE-ConnectionGUID: RaHiDpyCR7Kue8daorGQ5A==
X-CSE-MsgGUID: ytk/Vz+UTwq70DXI9D8wyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100550543"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="100550543"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:14:59 -0700
X-CSE-ConnectionGUID: EP95sZZnQAedd38PegXbmg==
X-CSE-MsgGUID: hN6IdZ0QRASEMOsiYztC3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="249726881"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:14:55 -0700
Date: Tue, 23 Jun 2026 23:14:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Petr Mladek <pmladek@suse.com>, Feng Tang <feng.tang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
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
Subject: Re: [PATCH v2 1/4] sys_info: add helper for callers that handle
 all_bt
Message-ID: <ajrpPMo3Qc_SgFkG@ashevche-desk.local>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
 <ajrob9r6cVtxqv72@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajrob9r6cVtxqv72@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268024-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:include@grrlz.net,m:pmladek@suse.com,m:feng.tang@linux.alibaba.com,m:akpm@linux-foundation.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:mchauras@linux.ibm.com,m:wangjinchao600@gmail.com,m:kees@kernel.org,m:rioo.tsukatsukii@gmail.com,m:joel.granados@kernel.org,m:pnina.feder@mobileye.com,m:petr.pavlu@suse.com,m:senozhatsky@chromium.org,m:dianders@chromium.org,m:mrungta@google.com,m:tj@kernel.org,m:yaozhenguo1@gmail.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:riootsukatsukii@gmail.com,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[suse.com,linux.alibaba.com,linux-foundation.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,mobileye.com,chromium.org,google.com,lists.ozlabs.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,linux.intel.com:from_mime,vger.kernel.org:from_smtp,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67AB36B9E71

On Tue, Jun 23, 2026 at 11:11:34PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 23, 2026 at 03:34:58PM +0000, Bradley Morgan wrote:
> > Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
> > Add a helper that strips that bit without turning an all_bt only mask into
> > a kernel_sys_info fallback.
> 
> You also want a getter with check
> 
> bool sysinfo_is_all_bt_enabled(...,  *si_mask)
> 
> where *si_mask is the result of READ_ONCE() that you keep as implementation
> detail inside this helper.

Ah, sorry, I have thought that the mask is part of sysinfo implementation.
Disregard my above comment, it can't be done without also supplying the pointer
to the original one, which makes no sense.

-- 
With Best Regards,
Andy Shevchenko



