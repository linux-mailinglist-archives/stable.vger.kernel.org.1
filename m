Return-Path: <stable+bounces-260551-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id djhFGYK8IWpAMwEAu9opvQ
	(envelope-from <stable+bounces-260551-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 19:57:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C46CD642736
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 19:57:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=gBuo7xb+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260551-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260551-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8775E306472F
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 17:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDC74CA26A;
	Thu,  4 Jun 2026 17:52:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCDF4C9576;
	Thu,  4 Jun 2026 17:52:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595562; cv=none; b=uKArasixMb6obEdbW9rz9VZkAaWhHViSnY/kYkhj3S9RlNhyKoVNljly/fY65cHdIMCSehfzeMnj/ulljN8KJDTkxCvp0dd/tMr9G2MG08bL23GXmJK2BlztFgqlWBv3a/SUmvEd2/aLTCW/YSG6l1pLA/qyWfoQ8B6RXIbsV34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595562; c=relaxed/simple;
	bh=Y/av6gmS2OXWP9At5fGHGaGDyO3mTdWk+0LSpWQJtTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBBaoUgp+MM+vVUGgIu6GLzZXHeiHVMf0hVgoxuc1rJSihwD1fq8hJywLixCZrHF1Kal/zFQZJUipxrUfZlRga47BLh6DU1MSCrpwZsKmRfQSvI8uwKFE8gJSHtRPWzua4zRmR9xui7vJoALEWYa8tMPbdyEw4EvGr5pN2dZOno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBuo7xb+; arc=none smtp.client-ip=198.175.65.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780595562; x=1812131562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y/av6gmS2OXWP9At5fGHGaGDyO3mTdWk+0LSpWQJtTQ=;
  b=gBuo7xb+DYJyvJ/yfZVQ5PzszA5pZ0tgSONwMvyjCRonqSHuSK3r8zI+
   3EKkvB5oUuWimc+H1KcjI7T4FynMqPBvA/diL7Lxrl9y/oNv4hSgyzITt
   TfniJ4DRuodgWVL/r2IOXNcTqOG0247s6SBO6Vrffp0kDBFeW36GOuTaN
   /qHBcQafZongeOcDDM/N7gFfsKtoBkP7y1jrzJLT8ACm+nwXBG7FEjNVr
   9FhV9jeudj+l+BksAYPbQmZjMpxXVtuii8HYuLR4czMelwN8q50en0mNw
   kcyXx1l6fi32481FEG8wlFKPtROW9D65ebH9J3gI1wWU0MOyyFzeBy7xi
   g==;
X-CSE-ConnectionGUID: l1RHTNtuRkuNGWzDwewf/A==
X-CSE-MsgGUID: v8RjLgoORveAjTdhS+lRdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92538170"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="92538170"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 10:52:41 -0700
X-CSE-ConnectionGUID: 32OX25fCSm2quc/Xm8CTDA==
X-CSE-MsgGUID: zaPofX0WSuS5RhUapMaThg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="274858743"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 10:52:37 -0700
Date: Thu, 4 Jun 2026 20:52:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Xu Yang <xu.yang_2@oss.nxp.com>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] device property: fix child iteration issues with
 secondary fwnodes
Message-ID: <aiG7Y6XYk6uaM2uq@ashevche-desk.local>
References: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
 <ah_3KmASlE44X4Xw@ashevche-desk.local>
 <6j2yk2x23mmtr2xbwkp3ind76qyy3mu7y23psseqqvbjlqepld@n4nsvswt2euz>
 <CAMRc=Mfd6CQO8SLLzP+ggmSYzSwvsxuNUz4rwmT1JskXc_ZAYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mfd6CQO8SLLzP+ggmSYzSwvsxuNUz4rwmT1JskXc_ZAYg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260551-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brgl@kernel.org,m:xu.yang_2@oss.nxp.com,m:djrscally@gmail.com,m:heikki.krogerus@linux.intel.com,m:sakari.ailus@linux.intel.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:mchehab+huawei@kernel.org,m:laurent.pinchart@ideasonboard.com,m:linux-acpi@vger.kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:xu.yang_2@nxp.com,m:stable@vger.kernel.org,m:mchehab@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[oss.nxp.com,gmail.com,linux.intel.com,linuxfoundation.org,kernel.org,ideasonboard.com,vger.kernel.org,lists.linux.dev,nxp.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,nxp.com:email,vger.kernel.org:from_smtp,intel.com:dkim,linux.intel.com:from_mime,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C46CD642736

On Thu, Jun 04, 2026 at 06:38:50AM -0700, Bartosz Golaszewski wrote:
> On Thu, 4 Jun 2026 12:58:41 +0200, Xu Yang <xu.yang_2@oss.nxp.com> said:
> > On Wed, Jun 03, 2026 at 12:43:06PM +0300, Andy Shevchenko wrote:
> >> On Wed, Jun 03, 2026 at 04:44:30PM +0800, Xu Yang wrote:
> >> > This series fixes two issues in the fwnode child iteration logic when
> >> > a secondary fwnode is present.
> >> >
> >> > The first patch addresses a refcount imbalance in
> >> > software_node_get_next_child(). When a software node is used as a
> >> > secondary fwnode, the iteration code may incorrectly decrement the
> >> > refcount of child nodes that do not belong to the software node
> >> > hierarchy. This results in refcount underflow and possible use-after-free.
> >> >
> >> > The second patch fixes an infinite loop in
> >> > fwnode_for_each_child_node(), caused by improper handling of iteration
> >> > state across primary and secondary fwnodes. When iterating over children
> >> > from both primary and secondary fwnodes, the code may incorrectly
> >> > resume iteration from the primary fwnode even when the current child
> >> > belongs to the secondary, leading to repeated traversal and a loop.
> >> >
> >> > Both issues are triggered when mixing different fwnode types through the
> >> > secondary mechanism, and stem from incorrect assumptions about ownership
> >> > and traversal context of child nodes.
> >>
> >> Please, Cc Bart who is heavily working on software nodes these days.
> 
> Should I propose myself as reviewer? We can't demand people to Cc random
> addresses otherwise.

If you are interested, I welcome this decision, although I don't know what
maintainers and other peers (current reviewers) think of it. Send a patch
and prepare for any type of responses :-) Mine will be positive for sure.

-- 
With Best Regards,
Andy Shevchenko



