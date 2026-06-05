Return-Path: <stable+bounces-260732-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wv4jCd3yImptfgEAu9opvQ
	(envelope-from <stable+bounces-260732-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 18:01:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 294336498C4
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 18:01:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=e3+i9vJT;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260732-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260732-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64C6E3031127
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 15:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA9630EF9B;
	Fri,  5 Jun 2026 15:52:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94E6309EE7;
	Fri,  5 Jun 2026 15:52:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674777; cv=none; b=OHWOD6bJE40CyZQw03jYrD4S4D5zFgPwL4nmSOYrEjREMVbW/6XNcczhzmISzPU9+ZAvWL6YGyxDa2CtuauerdPhoq3j2iZAFFXM0/o9Gipaf43ty5Nw+bcrANGaXUUH2NMVmJZQzeVDj8QqVsyxIj7ptl6h0BuUOdeYk1EsG6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674777; c=relaxed/simple;
	bh=thFB88a5EjxfRiZWlfk8/wFgFQBM/JRMmyAgUCwxUAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWRjBw4JIic8l4NvMemx1f3fEXBrCXzR9+583R6DtJn6JvJuc3Hbqa5m4eFcMFFwqXJddWb/fUjA27Qim4r2YWTGV3DguxF1WOxFuhAP37UrDmpue9w8zza89WW8o6DT2HWIPOYXKQmnyGF9i4SCY/jEbeDxCfLY47xBRbFAkW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3+i9vJT; arc=none smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780674776; x=1812210776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=thFB88a5EjxfRiZWlfk8/wFgFQBM/JRMmyAgUCwxUAM=;
  b=e3+i9vJT1jW/ykDf94SwnSyZ60qiL1X0OL9u95McOFBcX1/psJtyXfcj
   IhFLStLDwZgSJ8/NWHbjbU96Kskw1KdyYUdmtggP9ZE1sG/PLmjWyd24Q
   FJNGnWKpNdBUXNS9frs/inT+OKV+2ILBOl4KItz6XrHC/dkpgXJopwXkb
   +VPdpVKgvEsHP+Tege7X6uB4PQeCj6CN4dfvJRrWrDyYfcbwGth5sBqjZ
   c6w19TC3SA9d8nK6ij4TeIVUPzDvfjaV+4siVmoJ4UTEbhSuzKdALTByU
   X8mvILoRJmV5wC0Wxp7h1FZKjcwdZAT1cKUiGwyaK7/gaO2+vfOkpalpl
   g==;
X-CSE-ConnectionGUID: tb/hrUSeTQuE4oYLdGAF6g==
X-CSE-MsgGUID: feQhlKBCR4yYU1ZIRbpgqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="81631667"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="81631667"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:52:55 -0700
X-CSE-ConnectionGUID: Y3I5ci5AQx2uc60L6vpzuQ==
X-CSE-MsgGUID: JuD5TRcPQeiJzio3tvfKIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="240420491"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:52:52 -0700
Date: Fri, 5 Jun 2026 18:52:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Xu Yang <xu.yang_2@oss.nxp.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 0/2] device property: fix child iteration issues with
 secondary fwnodes
Message-ID: <aiLw0bLKiipMCZC5@ashevche-desk.local>
References: <20260605-fixes_fwnode_iteration-v3-0-44c18472e1d1@nxp.com>
 <aiLmN2yUsqLadbSo@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiLmN2yUsqLadbSo@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260732-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xu.yang_2@oss.nxp.com,m:djrscally@gmail.com,m:heikki.krogerus@linux.intel.com,m:sakari.ailus@linux.intel.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:mchehab+huawei@kernel.org,m:laurent.pinchart@ideasonboard.com,m:linux-acpi@vger.kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:brgl@kernel.org,m:xu.yang_2@nxp.com,m:stable@vger.kernel.org,m:mchehab@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,linuxfoundation.org,kernel.org,ideasonboard.com,vger.kernel.org,lists.linux.dev,nxp.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:from_mime,intel.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 294336498C4

On Fri, Jun 05, 2026 at 06:07:41PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 05, 2026 at 06:31:16PM +0800, Xu Yang wrote:
> > This series fixes two issues in the fwnode child iteration logic when
> > a secondary fwnode is present.
> > 
> > The first issue is  a refcount imbalance in software_node_get_next_child().
> > When a software node is used as a secondary fwnode, the iteration code may
> > incorrectly decrement the refcount of child nodes that do not belong to the
> > software node hierarchy. This results in refcount underflow and possible
> > use-after-free.
> > 
> > The second issue is an infinite loop in fwnode_for_each_child_node(), caused
> > by improper handling of iteration state across primary and secondary fwnodes.
> > When iterating over children from both primary and secondary fwnodes, the code
> > may incorrectly resume iteration from the primary fwnode even when the current
> > child belongs to the secondary, leading to repeated traversal and a loop.
> > 
> > Both issues are triggered when mixing different fwnode types through the
> > secondary mechanism, and stem from incorrect assumptions about ownership
> > and traversal context of child nodes.
> 
> > ---
> > Changes in v3:
> > - remove software node patch 
> 
> Hmm... Maybe I was unclear. My question was to investigate the way to actually
> move software node to use the swnode APIs (and not fwnode ones) and be on par
> with what OF code does. This series does the opposite and adds a hack to the
> next_child implementation.
> 
> > - add a kunit test case suggested by Andy Shevchenko
> 
> But thanks for the test case!

I'm preparing another patch (just a clean up) and I see that your test cases
indeed fail without any other patch being applied. Also noticed that the test
cases are not fully compliant with the requirement of the "primary"/"secondary"
fwnode flavours. But this doesn't affect the execution.

I will play more with this to understand the problem better.

-- 
With Best Regards,
Andy Shevchenko



