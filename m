Return-Path: <stable+bounces-269808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WG1mL2WuQmqW/gkAu9opvQ
	(envelope-from <stable+bounces-269808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 19:41:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E95D6DDD45
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 19:41:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="BIMHEG/X";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269808-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269808-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0ED8304C615
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 17:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA32B37F727;
	Mon, 29 Jun 2026 17:33:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE85D277C96;
	Mon, 29 Jun 2026 17:33:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754387; cv=none; b=ZEUSrDzjQhUrjqLXGtp9blifCdRFvJQu+J2rL2rOU771qnrotS6HEP1XDx4ob0w70V5OMyOTl/6wqaCy15f10rnxbCjeUtHkXBDEQ0hVfnQASHa12XCVWgai9W+5fT9OAqKOf2Uocm/jMzISdoaYjb4MJvxfzuzScAMg0JWqxD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754387; c=relaxed/simple;
	bh=iGG6LjmcJg7EV2b9L3OkZvJWUfrUU9Yg2AnJoMPe9ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAyNGTx3s5b5219EbIZTEB3PIfqxCvJ5RJu6SHdTcqz7gm9WnrqHqodpKdjapXjMS1Szcld/yq94P28jnQ8jL60/xuaQXdOYxYKWshnIHA0RntYfcrGI5y9CljXm6coz4fmuspjqxYXCI29tJ6i8zCC/g75NOZ7R5PR0Oee4zjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BIMHEG/X; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782754386; x=1814290386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iGG6LjmcJg7EV2b9L3OkZvJWUfrUU9Yg2AnJoMPe9ao=;
  b=BIMHEG/X7m/NWbZw3YRrWXoUdDKSU4oV7neb1jtE48Pl8GQ1VL0R5d3I
   FRXwtsfnH97BsnfNkfVUxkqloehdd4wYhdgNJwc4caRaVFMH3cbzmIPcj
   KeonfhMhKCWXib9u+mfg8ALEpuWCNVL1OJGJo7olWEXsSK4ZTgRDfAbmZ
   Bf1lrpqLo+6dzImonHbQPjlT3QUT5/WoaKmFDDJpxK/FXjQqt3YdVsMwK
   IqHWA1128ZACEeVh32jQe+93krk57ZYFfFU69nKUZqSc/xEpIHMCNxNZd
   DJNHblnE9BH1qIBHgf6wCu56dDDcDJHY6kBr28S6L8F/5e6k+92GKHEPV
   Q==;
X-CSE-ConnectionGUID: pPiLzcPvR5utpo03IHXYUw==
X-CSE-MsgGUID: GUZX1rQ9QyGogA148gGLVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83229242"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83229242"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:33:06 -0700
X-CSE-ConnectionGUID: j4AWA8VXQjajdGIeFcHQbg==
X-CSE-MsgGUID: IgwRqUTTSoyHRgKuk7x4Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="255622735"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:33:03 -0700
Date: Mon, 29 Jun 2026 20:33:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Peter Shier <pshier@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] device property: Allow secondary lookup in
 fwnode_get_next_child_node()
Message-ID: <akKsTJ83RDKyCJ_c@ashevche-desk.local>
References: <20260210135822.47335-1-andriy.shevchenko@linux.intel.com>
 <DGLVIO9YF9PK.1WM118M9OSS0N@kernel.org>
 <CACwOFJSz63A9d=EZrapJs=zKeSzWVogtz8F=9SDwVfb5i7vviw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACwOFJSz63A9d=EZrapJs=zKeSzWVogtz8F=9SDwVfb5i7vviw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269808-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pshier@google.com,m:dakr@kernel.org,m:linux-acpi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:djrscally@gmail.com,m:heikki.krogerus@linux.intel.com,m:sakari.ailus@linux.intel.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,linux.intel.com,linuxfoundation.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,vger.kernel.org:from_smtp,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E95D6DDD45

On Mon, May 18, 2026 at 06:16:05PM -0700, Peter Shier wrote:
> On Tue Feb 10, 2026 at 2:58 PM CET, Andy Shevchenko wrote:
> > When device_get_child_node_count() got split to the fwnode and device
> > respective APIs, the fwnode didn't inherit the ability to traverse over
> > the secondary fwnode. Hence any user, that switches from device to fwnode
> > API misses this feature. In particular, this was revealed by the commit
> > 1490cbb9dbfd ("device property: Split fwnode_get_child_node_count()")
> > that effectively broke the GPIO enumeration on Intel Galileo boards.
> > Fix this by moving the secondary lookup from device to fwnode API.
> 
> I am not familiar with this code at all but from a sashiko AI review I
> found the following comments.
> Does this need to be addressed?

Isn't this series about:
https://lore.kernel.org/r/20260611203537.1786399-1-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko



