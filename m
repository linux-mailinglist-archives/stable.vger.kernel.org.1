Return-Path: <stable+bounces-244382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA1PNOg9+2nUXwMAu9opvQ
	(envelope-from <stable+bounces-244382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 15:11:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 317FA4DAC1E
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 15:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DC9D300B1A2
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 13:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCF43FA5D3;
	Wed,  6 May 2026 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzb1S1gj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DE834252D;
	Wed,  6 May 2026 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073062; cv=none; b=hWJCfS1FVQ6OZTtR83GHit+hgjreRJHh5oliGiKkYZx5+b9ojalUnIYe285NrheOQJcgcnSG1jfo+RmrUMSv1bMtOrM5y6LiDCtpe+NZhLNR0wVNkNmChx1EkD4R8IKabrlHVRbOB+pp5N5Gg3LRdWWVtMEuqAvwWMR1Qgq5h9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073062; c=relaxed/simple;
	bh=24YuqCcsqTq/GIGHlCulkgKOcT0NLKKug6WMtvtUi70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifBSRRYoeDt7wmiZXcyjiN2EXW8dOjtkxV0Zw/t/DZeFTQ35sU641siXrLgdNmQLQGHGpKREYRWZhsNdl5Y3rqD/FjFvs3MYcSwKuqjjpytwBSwFlkSZXf75bbw5hZAFaja+qDCcf5TPh5G7CYDdxq/e2Mn/SLrBdMsCn/7PTRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzb1S1gj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778073062; x=1809609062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=24YuqCcsqTq/GIGHlCulkgKOcT0NLKKug6WMtvtUi70=;
  b=gzb1S1gjE7YZyukpHdSiZERA7dyF8vY7yhXc4czCKYjVVXomEKroBIPm
   zl9YpRm9hiFJ9DRmx00sPLJ0YwOHUDU9mJP77359yF6NYEbvWkWW2KNIp
   3KMmEL3ZOidwSQtGUXuUu0QTU01P2J8DImN2ZaiKkO1is9TrIDX+83N9e
   0CdJ4M8HdMJw3cvKG+4j33VtGKvaSixvzSqZ2/5bh97+kgXMuE/x80XEM
   jfyEXGsyV6Bpv9sDonq3h2Jrad+jcFETFZamsjaA88JPrJkJV1cV80/2h
   p99KnEPZnndcnjmP/Nf2cVMxAdtwle/OSkxavRbFOXeMTEaQwFCjc72MN
   Q==;
X-CSE-ConnectionGUID: XN/vVnjdR8u5AopDVhc9Ew==
X-CSE-MsgGUID: InEERcgzTPmHTF8OGCjFzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="90458540"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="90458540"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 06:11:02 -0700
X-CSE-ConnectionGUID: gAMLFi/8RG2oGotNvk8cNw==
X-CSE-MsgGUID: AnsU1tydQp+u0mkVqwg7Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="237956491"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 06:10:57 -0700
Date: Wed, 6 May 2026 16:10:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	brgl@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] device property: set fwnode->secondary to NULL in
 fwnode_init()
Message-ID: <afs93y7nW_VTc1Y5@ashevche-desk.local>
References: <20260506115701.23035-1-bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506115701.23035-1-bartosz.golaszewski@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 317FA4DAC1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244382-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ashevche-desk.local:mid]

On Wed, May 06, 2026 at 01:57:00PM +0200, Bartosz Golaszewski wrote:
> If a firmware node is allocated on the stack (for instance: temporary
> software node whose life-time we control) or on the heap - but using a
> non-zeroing allocation function - and initialized using fwnode_init(),
> its secondary pointer will contain uninitalized memory which likely will
> be neither NULL nor IS_ERR() and so may end up being dereferenced (for
> example: in dev_to_swnode()). Set fwnode->secondary to NULL on
> initialization.

Hmm... Are you going to use that outside of fw_devlink?

The patch itself looks good to me, but I'm not sure I understand how it's
related to all the work you are doing WRT fwnode core implementation.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

But Saravana is the best person to actually tell if this patch makes sense.

-- 
With Best Regards,
Andy Shevchenko



