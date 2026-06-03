Return-Path: <stable+bounces-259926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lqoBI6N1H2qUmAAAu9opvQ
	(envelope-from <stable+bounces-259926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 02:30:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DBA633353
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 02:30:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=epq4LTTw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259926-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-259926-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75402301588F
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 00:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28AD23C516;
	Wed,  3 Jun 2026 00:30:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C041F4611;
	Wed,  3 Jun 2026 00:30:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780446619; cv=none; b=bRjzJJ3HMijVwfGuN2Lm5MevK+Irt5I9Ck9WbibZ2UKRhAAXh8ykzpaNRFTe1nsSfyw2E7415r6QFe7gFj2iXTCb7lQhzHlvvLAgOXZsZxzkGIxfeyywpKkq9OW0iUZ90VTN3M+3HbN5TxI7JiH9JYX5SbHVtk1K+PLCHMLDFSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780446619; c=relaxed/simple;
	bh=FKgMLgLLd/0PNaMUChniI9zKgfQfR++e80a+w+L4SWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXsCEUHHl4YkxyJdLPUwa0of0ncdXO1UO9Q8K+W/SAV4wOrRUvYP2BLnuSXytb+QpKE4ajyiHuKR///ay++U23+sHycZ3pjXHTfvjtVYabwvVdsAdiQ8TbfUhfV7QhNNbo69EqNs11+CVEJthYLnzoCWi4KVvSQxJCSWDejbZDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=epq4LTTw; arc=none smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780446618; x=1811982618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FKgMLgLLd/0PNaMUChniI9zKgfQfR++e80a+w+L4SWM=;
  b=epq4LTTweTuo3BevPyG8VKAUYvDibqUgaXPAWnlVP4rnnp2b3EHOvdCg
   TkFQUXkRiAmTTyKt1MGWI1Erl3xpy+vLu5pHCzZjc0dzbL8DDgg/I4I+a
   rQdyr01N276ytYSmZPdncf1C8OTBbFUGt6aFnJt/zBS7V0z3k6AldeurX
   nAOb8c+9w5pQN5D287WdhKZ0iO+Xwahy9co16MhelnWGId9wt8sHPsfsR
   jaz1j67X5bOwKsEoGDPIZDXBv7b/z/qaiDer6WJyHu47iyf4g/eGGIeUG
   ktv2IsElCZOvnSbhMxRBnA3pkoawu334e7few8DJ3ZuLou/dJcwRhBYsZ
   A==;
X-CSE-ConnectionGUID: y8HALrreTkqlLGjWIt5fhg==
X-CSE-MsgGUID: aRIOheUhQVS9jEMR8QlObA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="92729258"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="92729258"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 17:30:18 -0700
X-CSE-ConnectionGUID: dEKq9ur5QUKz4G06Y8DxSg==
X-CSE-MsgGUID: Nr5vR1cCRRm7lKJ8dFJEpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="248370724"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 17:30:15 -0700
Date: Wed, 3 Jun 2026 03:30:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] device property: fix infinite loop in
 fwnode_for_each_child_node()
Message-ID: <ah91lJp-PNkyB11n@ashevche-desk.local>
References: <20260525-fixes_fwnode_iteration-v1-0-a12903fb2919@nxp.com>
 <20260525-fixes_fwnode_iteration-v1-2-a12903fb2919@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525-fixes_fwnode_iteration-v1-2-a12903fb2919@nxp.com>
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
	TAGGED_FROM(0.00)[bounces-259926-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xu.yang_2@nxp.com,m:djrscally@gmail.com,m:heikki.krogerus@linux.intel.com,m:sakari.ailus@linux.intel.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:mchehab+huawei@kernel.org,m:laurent.pinchart@ideasonboard.com,m:linux-acpi@vger.kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:mchehab@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,linuxfoundation.org,kernel.org,ideasonboard.com,vger.kernel.org,lists.linux.dev];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ashevche-desk.local:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0DBA633353

On Mon, May 25, 2026 at 02:09:20PM +0800, Xu Yang wrote:
> When iterate over children of a fwnode that has a secondary fwnode,
> fwnode_get_next_child_node() can enter an infinite loop if the secondary
> fwnode has more than one child.
> 
>                        Parent        Child
>       (Primary fwnode)   FWa:   {FWa1, FWa2, FWa3}
>     (Secondary fwnode)   FWb:   {FWb1, FWb2}
> 
> In this case:
> 
>  ┌─> fwnode_get_next_child_node(FWa, FWa1)
>  │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa1) returns FWa2
>  │
>  │   ...
>  │
>  │   fwnode_get_next_child_node(FWa, FWa3)
>  │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa3) returns NULL
>  │    - fwnode_call_ptr_op(FWb, get_next_child_node, FWa3) returns FWb1
>  │
>  │   fwnode_get_next_child_node(FWa, FWb1)
>  │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWb1) returns FWa1
>  └────┘
> 
> This cause fwnode_for_each_child_node() to loop indefinitely, reapeatedly
> output {FWa1, FWa2, FWa3, FWb1, FWa1, ...}.
> 
> The root cause is that when the current child (FWb1) belongs to the
> secondary fwnode, calling get_next_child_node() on the parimary fwnode
> incorrectly returns the first child (FWa1) again instead of NULL.
> 
> Fix this by dynamically checking the parent fwnode of the current child
> before calling get_next_child_node(). This approach follows the pattern
> established in commit b5b41ab6b0c1 ("device property: Check
> fwnode->secondary in fwnode_graph_get_next_endpoint()").

...

Can we utilise __free() instead?

-- 
With Best Regards,
Andy Shevchenko



