Return-Path: <stable+bounces-244521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDH8D2w+/GnfNQAAu9opvQ
	(envelope-from <stable+bounces-244521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 09:25:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 010794E404F
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 09:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A4D2302292A
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 07:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68B2358391;
	Thu,  7 May 2026 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gAsTnxA7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CE5348463;
	Thu,  7 May 2026 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778138726; cv=none; b=PNMpvNqDyhszNmCdK+dIlkXWhszyC2Nv14ai56WWmTiZIljHzI1oBU1fYldVh1HhUL3bHchlZ/j8Vx1BO0baQgxFRYisXd3u3rjpYp2TcyqPYTniFIpDfwXeigT1gTNKqYxpa2KMy1ZJSzDqt4T9DjYV0ACDyzHPS84IWQni/rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778138726; c=relaxed/simple;
	bh=pL59kLZ0TSRXYpk6p6E3c7Sc5FErfiqpx3+I4G0LGnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjhEckd6fLlXik9DRsM81Coq+iIbbEgj0qFQSnCDcZVg+m/5aZbuHRPrCV4BQJf+fwjTUcJ1uoG5V/eIMZKuL3P24roiLXSEXkMAK1eSBrcuOl8P8B5UEQj7yST+EO9gDvcTEOL5Y6cJfB5NqzcH9fFkdqr9PhmUWYzkQs3fL5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gAsTnxA7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778138720; x=1809674720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pL59kLZ0TSRXYpk6p6E3c7Sc5FErfiqpx3+I4G0LGnI=;
  b=gAsTnxA7bK/6EYCfwmGs+P0+qP3k6j32niGEZE7glrfGrKiwos3TKl9D
   u3jL0YZL3M5Hhx/lo44S/cxq5ITEeGUVGqKQTUFj4AIFZ9u03K0hAgvun
   X74FAs0QnWe7nTdxPMduz+5tj4RxKxgNbeoIEKugxYicRtYLfF37+VDkG
   SAoSAaKnBbLy/Qu1Tg8JK0BYLsDa9UiraagTC7f8SL8uOrhifxtTJlKpG
   RVXv0Z0ruwtoAiMOjIMER7j3jg7QSI25ieE4tSo4EKin8nfh+ZU1A3LDL
   7xg9ZoegXQTD3MUCOuh3KM+bBLEYpF1FsVpnIuqZg1ZGX4QjU3sQ2D1zN
   w==;
X-CSE-ConnectionGUID: XnvElsFARyWHAFjT9Jin4g==
X-CSE-MsgGUID: UFO4kQigTRusgKMc2RSAIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="82925999"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="82925999"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 00:25:19 -0700
X-CSE-ConnectionGUID: Ob8Pgo+sSH6yhS8/poQHgg==
X-CSE-MsgGUID: M4OUYidHTWKCr8w03KSK/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="229995422"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.99])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 00:25:16 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 8949711F8DF;
	Thu, 07 May 2026 10:25:14 +0300 (EEST)
Date: Thu, 7 May 2026 10:25:14 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	brgl@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] device property: set fwnode->secondary to NULL in
 fwnode_init()
Message-ID: <afw-Wtz-yOWqLUl1@kekkonen.localdomain>
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
X-Rspamd-Queue-Id: 010794E404F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,linux.intel.com,gmail.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244521-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sakari.ailus@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 01:57:00PM +0200, Bartosz Golaszewski wrote:
> If a firmware node is allocated on the stack (for instance: temporary
> software node whose life-time we control) or on the heap - but using a
> non-zeroing allocation function - and initialized using fwnode_init(),
> its secondary pointer will contain uninitalized memory which likely will
> be neither NULL nor IS_ERR() and so may end up being dereferenced (for
> example: in dev_to_swnode()). Set fwnode->secondary to NULL on
> initialization.
> 
> Cc: stable@vger.kernel.org
> Fixes: 01bb86b380a3 ("driver core: Add fwnode_init()")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

