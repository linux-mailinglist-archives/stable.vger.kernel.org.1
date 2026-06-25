Return-Path: <stable+bounces-268274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wEGLKeXJPGqVsAgAu9opvQ
	(envelope-from <stable+bounces-268274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 08:25:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F006C303B
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 08:25:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=khlGueke;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268274-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268274-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E854303676D
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 06:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EE63C09E2;
	Thu, 25 Jun 2026 06:25:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD351C84DC;
	Thu, 25 Jun 2026 06:25:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368729; cv=none; b=Nzbaip6RgDvrtq9O9TYC96BJpqQs4nwtxNGzb06BL9QQiuor96Unk6tlibyUsYRMgMYfnkghMhNGe/KUG5cRMEw4SmDPB11daQ1eeypB/oynF6REAzDdMGbet4xI0KmYGnhp26ASXo2bjps6AP72dCDM84YZsdqMXXi1jBcZLq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368729; c=relaxed/simple;
	bh=qN6rxeLPrWEPmxFGStMS4jQk+7YyeMkk+HD//Wyqj8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnZ3f+DhzE/EfVfAPd/xtHXCo40BmNrcx9hf8Oe/lXcN2fV2NqdLA3AqhQ9JnKQqTpBNp3RNzh6oKzbjS29piYLaIHwlZBXuLm0quP7LG8ZrzK0JL7nVYhwVoXkoxqMRhs4h0GwnOQo+CtUrvWaKDz6UmJ6fP63aV+WZc6b7bp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khlGueke; arc=none smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782368727; x=1813904727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qN6rxeLPrWEPmxFGStMS4jQk+7YyeMkk+HD//Wyqj8g=;
  b=khlGuekehxIYGRsaXyCDnpMbCaFnB4iiP3JmMAjfTeM070vUTXPopv/w
   Q/In1v1NA84v+G1II+xtnJFUvXGhueGUURkJlq6bNTIvWHh8tWHmxtz32
   WMxmm9UWUe74LSrEMRmn59TFUyPQcKKGWf9BkPs2wBoqcMDK1VNC+Gdv1
   Xikk7uozr19FSoC/A5xSouFJX5h1B9QHfiWND+2VoDMoOWk2DHbwc7Jr8
   7HP9RIHVDUIrTFfDzNTbGaqrs7gB7UnfT38MwBs0QQbmSsJc7mlutjEqp
   qMzBnJisDzQcb8s9LNZh+MNJYB1neFHwGYJLu+GZa+s4Fxu5ry8hczHDK
   w==;
X-CSE-ConnectionGUID: vTfxrjgKSvqalvJ9Bd+q/g==
X-CSE-MsgGUID: y4Bph3PHRt6c7Jm2oAU//w==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="100566504"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="100566504"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:25:26 -0700
X-CSE-ConnectionGUID: mgpo7onQQoGmj/svgy/OYA==
X-CSE-MsgGUID: 38zIrkM8TsC/DcZrYr1OfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="255127244"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:25:21 -0700
Date: Thu, 25 Jun 2026 09:25:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
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
Message-ID: <ajzJz_YgpTRLiJxX@ashevche-desk.local>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
 <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org>
 <EB858B12-203D-4173-A44B-4926129983F4@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EB858B12-203D-4173-A44B-4926129983F4@grrlz.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268274-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:include@grrlz.net,m:akpm@linux-foundation.org,m:pmladek@suse.com,m:feng.tang@linux.alibaba.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:mchauras@linux.ibm.com,m:wangjinchao600@gmail.com,m:kees@kernel.org,m:rioo.tsukatsukii@gmail.com,m:joel.granados@kernel.org,m:pnina.feder@mobileye.com,m:petr.pavlu@suse.com,m:senozhatsky@chromium.org,m:dianders@chromium.org,m:mrungta@google.com,m:tj@kernel.org,m:yaozhenguo1@gmail.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:riootsukatsukii@gmail.com,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,suse.com,linux.alibaba.com,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,mobileye.com,chromium.org,google.com,lists.ozlabs.org,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,vger.kernel.org:from_smtp,linux.intel.com:from_mime,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02F006C303B

On Wed, Jun 24, 2026 at 09:44:37PM +0100, Bradley Morgan wrote:
> On June 24, 2026 9:34:19 PM GMT+01:00, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan <include@grrlz.net>
> >wrote:

...

> > It would be nice to have the conventional [0/N] cover letter to tell
> > readers what this is all about.
> 
> I added a what I changed? I'm iffy on cover letters, if you want I'll do
> it...

FWIW, always do cover-letter when you have 2+ patches in the series.
And do not add it (there are rare exceptions, though) when it's a single patch.

-- 
With Best Regards,
Andy Shevchenko



