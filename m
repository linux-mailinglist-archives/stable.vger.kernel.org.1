Return-Path: <stable+bounces-227446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHrjKg73vGkt5AIAu9opvQ
	(envelope-from <stable+bounces-227446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:28:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 355162D69EC
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E872F304FA6C
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 07:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7B435E956;
	Fri, 20 Mar 2026 07:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EgcsTS+B"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A935DA7C;
	Fri, 20 Mar 2026 07:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991642; cv=none; b=Wq4aT3rZ/v056WvJkH5amLn63M2kHksXATpqZTWHa1JyJH683G3R2/6ZupL8oL5PuII9dNE7rqb1pfsdHeArgcRdw7hw0y2iopJ4s6IpTVFRLlZJtmx2AQxLt/4VUDxzRa+S79tYNzFvbslC0Oe4/ArvGdBMaIVCuzQycnX7Hug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991642; c=relaxed/simple;
	bh=v2ueppRZhgGBBJgxqshadTQ4Qg0qsu+2KG1AFV3N02A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxFGdgAk65kydQ/B+Hov3YSlQZ+o37z6msQTYMvoDkvf5csSMh6Rwl3gIPhkHnbfgTNcurW5AQaeL+nPkNW0FAz7KnRrYt41v5oWtXzVPCSOjeQC4XypZ/F25qY7S4t+oVOY8MEH6+8O0G5q6CL1k9yQ/wHz2fPZE9qFQLXCyx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EgcsTS+B; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773991641; x=1805527641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=v2ueppRZhgGBBJgxqshadTQ4Qg0qsu+2KG1AFV3N02A=;
  b=EgcsTS+Bo6Gwke1ygWoGnyRWUOTMMJAbZr+xNQ7yp2aE6UhsWqO83k5k
   +hk7JP2LOHRhpY6rxLXypT2Fg/vMrgllNevAjXLHgwBPnwPoGiahl9Rjo
   FSb7FuoMmq/RZRCMtnAHmPfEs3zCbaj7sSJogchIkyiyxWxwpnaKvkw4u
   jYfMy5PlKsKsx4Cs3wJQ0gZa7K8g2jzbkZt4KWpQHNNStltk2wjk5XUOv
   +NkhvlpO6pHrHwvK0HHHrYbv2xWysvuEqZeQZR23ECurUZtCdpwoiDy4t
   k6ZydkoZVi9WwEXljTnjs9/RmMgn/Anml82w7rL3ob2/+DX8jz+aKJBmt
   w==;
X-CSE-ConnectionGUID: YxfzX8+OS7ystrRObA9Rgw==
X-CSE-MsgGUID: tWl9Jyd6RVuGW5UKFaBIbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="77680718"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="77680718"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 00:27:20 -0700
X-CSE-ConnectionGUID: vqIb96FlTFeCm0/BF0yiEg==
X-CSE-MsgGUID: TSZma3MYQ5aO0fka3UkAtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="219042268"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 00:27:19 -0700
Date: Fri, 20 Mar 2026 09:27:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Brian Mak <makb@juniper.net>, Herve Codina <herve.codina@bootlin.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mfd: core: Preserve OF node when ACPI handle is
 present
Message-ID: <abz21ANNVYP3-pb2@ashevche-desk.local>
References: <20260311190225.22426-1-makb@juniper.net>
 <20260319181231.GC2902881@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319181231.GC2902881@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227446-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ashevche-desk.local:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 355162D69EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 06:12:31PM +0000, Lee Jones wrote:
> On Wed, 11 Mar 2026, Brian Mak wrote:

...

> > +	if (adev)
> > +		set_primary_fwnode(&pdev->dev, acpi_fwnode_handle(adev));
> > +	else
> > +		set_primary_fwnode(&pdev->dev, acpi_fwnode_handle(parent));
> 
> Sorry to mess you around again, but how do you feel about:
> 
>   set_primary_fwnode(&pdev->dev, acpi_fwnode_handle(adev ?: parent));

If you think it's better, no objections from me.

Some maintainers prefer avoiding ternary, and specifically Elvis, some not —
hard to remember everybody's preferences :-)

-- 
With Best Regards,
Andy Shevchenko



