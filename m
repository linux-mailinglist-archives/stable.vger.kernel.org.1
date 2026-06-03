Return-Path: <stable+bounces-260015-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jcvJIKP2H2pRtQAAu9opvQ
	(envelope-from <stable+bounces-260015-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 11:40:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE21F6363D5
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 11:40:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="dv/KjxJF";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260015-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260015-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 786D3302C80A
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 09:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7FE3D5C26;
	Wed,  3 Jun 2026 09:40:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EECF43CEC2;
	Wed,  3 Jun 2026 09:40:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479635; cv=none; b=N26f8gsMsvDdfEmrO2Vq0rkAveeBFVS1hVU3CW7cE0Kzq/6QhERY6UKxJJP53H7E/dLPOwKWRdjZEYN9uIUG/kt9NYKceYAONyRMsSrhxuxFfBo+vD5hzf6U4RTXT/xrCJ+6wVoW8limUDxlOiqXnGlADtSfnSde6EffD0hQul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479635; c=relaxed/simple;
	bh=bUYlZkjlMr0bVuzjmSFMsxuNhDvzS3u23upXLdjV/PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgfMnwc7OlHsXafhzmO5jhYWMAGKpJeZG/T9t+zLQCOZkdKKgvulALWNTEiI1dJ8duNRBkyVzFoTLv3sPc1raW3I8INceXf/5q2+ephvX0wkuSCt6oBTXDqahR3wl/4Ml6UZeQNZPEa6sMQrRUx7mB7+Uy8iwAPO8LpG/ztwzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dv/KjxJF; arc=none smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780479635; x=1812015635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bUYlZkjlMr0bVuzjmSFMsxuNhDvzS3u23upXLdjV/PQ=;
  b=dv/KjxJFNRKcQFLJNlkuxyl6aPXeTxzSrbVmBfzR1hqKvU2DqTONacp0
   qkhy6S2njDrYNY0Rge9y4Q8iWhrgc/Ey1Jej2xOfDie4xQi8DjGXDgyHV
   vK6cdcxfOYX/bGLiojf5kAGv+KIDlCebaPpZJEGtKtviEFX6brYrqnhuz
   kiCKWwukiWtwZJ2a9poYMxNDEDgc7KL7ER0B0T55WTYTKLs0Mx3OiYpE1
   UI+/URFlbgSO3BpbSPQvbNC/n7BhULn2FY8/Th9285lHUUmeJX2Bc0be9
   fgPWjzoPzXP/a3evZqrjW58ro+utnynX2aLn+jD5YwHvPya/GqeeUEA7b
   A==;
X-CSE-ConnectionGUID: kOJwZ1f1RGqVtkqqlOSyIQ==
X-CSE-MsgGUID: EZcWbjMdTT2LZ1pww59TPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="92763850"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="92763850"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 02:40:34 -0700
X-CSE-ConnectionGUID: gVfxXH9+R3OUacu+Rg1cdg==
X-CSE-MsgGUID: rfpr492KQY2s2wszCJ9WIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="243121318"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 02:40:30 -0700
Date: Wed, 3 Jun 2026 12:40:27 +0300
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
	linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] software node: fix refcount leak in
 software_node_get_next_child()
Message-ID: <ah_2i-jWq2kBRJpe@ashevche-desk.local>
References: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
 <20260603-fixes_fwnode_iteration-v2-1-0ae381f8b7b9@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-fixes_fwnode_iteration-v2-1-0ae381f8b7b9@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260015-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xu.yang_2@oss.nxp.com,m:djrscally@gmail.com,m:heikki.krogerus@linux.intel.com,m:sakari.ailus@linux.intel.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:mchehab+huawei@kernel.org,m:laurent.pinchart@ideasonboard.com,m:linux-acpi@vger.kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:xu.yang_2@nxp.com,m:stable@vger.kernel.org,m:mchehab@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,intel.com:dkim,linux.intel.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE21F6363D5

On Wed, Jun 03, 2026 at 04:44:31PM +0800, Xu Yang wrote:

> When a swnode acts as a secondary fwnode and is participates in child
> iteration, a refcount leak occurs for the last child of the primary
> fwnode's children.
> 
>                    Parent      Child
>   (Primary fwnode)   FW:   {FW1, FW2, FW3}
> (Secondary fwnode)   SW:   {}
> 
> In this case, FW3's refcount is decremented twice during iteration:
> 
>  fwnode_get_next_child_node(FW, FW3)
>   1. fwnode_call_ptr_op(FW, get_next_child_node, FW3) returns NULL and
>      decrements FW3's refcount
>   2. fwnode_call_ptr_op(SW, get_next_child_node, FW3) returns NULL and
>      decrements FW3's refcount again
> 
> The same double-decrement issue occurs when SW has children.
> 
> The kernel dump as below:
> 
> [   25.435805] OF: ERROR: of_node_release() detected bad of_node_put() on /soc/usb@4c010010/usb@4c100000
> [   25.445072] CPU: 0 UID: 0 PID: 617 Comm: sh Not tainted 7.1.0-rc4-next-20260522-00011-g7376b330abca #210 PREEMPT
> [   25.445080] Hardware name: NXP i.MX95 19X19 board (DT)
> [   25.445083] Call trace:
> [   25.445086]  show_stack+0x18/0x30 (C)
> [   25.445101]  dump_stack_lvl+0x60/0x80
> [   25.445108]  dump_stack+0x18/0x24
> [   25.445113]  of_node_release+0x158/0x194
> [   25.445122]  kobject_put+0xa0/0x120
> [   25.445129]  of_node_put+0x18/0x28
> [   25.445134]  of_fwnode_put+0x38/0x58
> [   25.445141]  software_node_get_next_child+0x54/0x15c
> [   25.445150]  fwnode_get_next_child_node+0x70/0x94
> [   25.445156]  fwnode_get_next_available_child_node+0x34/0x88
> [   25.445162]  device_links_driver_bound+0x2f4/0x334
> [   25.445168]  driver_bound+0x68/0xb0
>                 ...
> [   25.445258] OF: ERROR: next of_node_put() on this node will result in a kobject warning 'refcount_t: underflow; use-after-free.'
> 
> Fix this by ensuring software_node_get_next_child() does not decrement
> the child's refcount when:
> - The parent has no children, OR
> - The parent has children but the input child is not a swnode
> 
> This prevents the refcount from being incorrectly decremented for
> fwnodes that don't belong to the software node hierarchy.

...

>  	struct swnode *p = to_swnode(fwnode);
>  	struct swnode *c = to_swnode(child);
>  
> -	if (!p || list_empty(&p->children) ||
> -	    (c && list_is_last(&c->entry, &p->children))) {
> -		fwnode_handle_put(child);

Wouldn't be better to use swnode_get() / swnode_put() instead?
*Yes, we might need to add some NULL checks there.

> +	if (!p || list_empty(&p->children))
>  		return NULL;
> -	}

-- 
With Best Regards,
Andy Shevchenko



