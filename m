Return-Path: <stable+bounces-242959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OyaDbdg+GnKtgIAu9opvQ
	(envelope-from <stable+bounces-242959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 11:02:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1164BAB60
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 11:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FFA73017381
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FA934A3B1;
	Mon,  4 May 2026 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgHh/0jK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5931EE7D5;
	Mon,  4 May 2026 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885148; cv=none; b=fRjC7a8HddjcpE7bTpHMGUALZubV6JnCsVOXq/56hqqpte4Rycvoh6c90smuVqksCY83ODz6mEcGya8Mpy7/fiBDJibo/HHq1ONpGyHWtGm8u7XOg3/IW8C07MFwyXiZZdjxypQ5lb0kFSGtdyRJct43ZmCfVj21D8hkQw4hnzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885148; c=relaxed/simple;
	bh=md8M+y7PGErVo3Oqco55fYhFLtk9XUgZsiTX4Vt/Q+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWKP+cwr3upy9lNiKd910/wehpThxGbgCpQeZXmeYNs14KTRAndeJ4TwRl2tQsuyXnd0Ww6cMhXRYfO32H+rYIIHJBUF86NwbXhBqnJVbrf9mxRgu6qs3G1KQvF65SKhXX63NU7Fgd0OMkr0IMt+0CSgdjiKM9uBopJjbwhPDVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgHh/0jK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777885147; x=1809421147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=md8M+y7PGErVo3Oqco55fYhFLtk9XUgZsiTX4Vt/Q+c=;
  b=PgHh/0jKeqTGgeISpjHHw0soOTKl3WIWbbqQ8/ZDEiZm9DGT2nHNbwAY
   oo15u3SBz0cRcgw4JMUPgVdkFreNf91+fsJ5OIuIbN9ai5YlXVL2t0Kas
   ZWAGWCzMDK7o7WzIdMh9WIX5uRo9IcmuLc5kOv5PWoX2X9K23Ks5V/eqB
   hQeyCc0mxMB31JByl0P+DmsOMb1QPlBY1k0mvCtLw/x1GRrBKieumNGsj
   R4gUVr2CverSrnWhU3wgkuSm42VgjyiCFAG6r6GycFZbyc2/cGdYJ/u2r
   VJAl+EMttDKWCafCm01Mbg3SSFs5503BmwTk7/X0giKMWbh86NXzjAUL/
   w==;
X-CSE-ConnectionGUID: XG8qySCNQfmq4oCYyzZ0Sw==
X-CSE-MsgGUID: o8blUSFBRYqs6EvaxrVxDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78789545"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78789545"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:59:07 -0700
X-CSE-ConnectionGUID: QHAyp3NLS4SISMntM2/IlA==
X-CSE-MsgGUID: S7VqsK6iQ8+CKh8nSVRrrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="232815003"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:59:04 -0700
Date: Mon, 4 May 2026 11:59:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>, linux-usb@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/4] thunderbolt: property: reject dir_len < 4 to
 prevent size_t underflow
Message-ID: <afhf1nyYlzy4Xm6q@ashevche-desk.local>
References: <20260415123221.225149-1-michael.bommarito@gmail.com>
 <cover.1777817011.git.michael.bommarito@gmail.com>
 <e3c84da6e0c1defbb07e712939df0db1b2019fff.1777817011.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3c84da6e0c1defbb07e712939df0db1b2019fff.1777817011.git.michael.bommarito@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 9D1164BAB60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242959-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,intel.com,linuxfoundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,ashevche-desk.local:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Sun, May 03, 2026 at 10:15:06AM -0400, Michael Bommarito wrote:
> On the non-root path, __tb_property_parse_dir() takes dir_len from
> entry->length (u16 widened to size_t).  Two distinct OOB conditions
> follow when entry->length < 4:
> 
> 1. The non-root path begins with kmemdup(&block[dir_offset],
>    sizeof(*dir->uuid), ...) which always reads 4 dwords from
>    dir_offset.  tb_property_entry_valid() only enforces
>    dir_offset + entry->length <= block_len, so a crafted entry
>    with dir_offset close to the end of the property block and
>    entry->length in 0..3 passes that gate but lets the UUID copy
>    run off the block (e.g. dir_offset = 497, dir_len = 3 in a
>    500-dword block reads block[497..501]).
> 
> 2. After the kmemdup, content_len = dir_len - 4 underflows size_t
>    to ~SIZE_MAX, nentries becomes SIZE_MAX / 4, and the entry
>    walk runs OOB on each iteration until an entry fails
>    validation or the kernel oopses on an unmapped page.
> 
> Reject dir_len < 4 on the non-root path *before* the UUID kmemdup,
> which closes both holes.
> 
> Also move INIT_LIST_HEAD(&dir->properties) up to immediately after
> the dir allocation so the new error-return path (and the existing
> uuid-alloc failure path) calling tb_property_free_dir() sees a
> walkable list rather than the zero-initialized NULL next/prev that
> list_for_each_entry_safe() would oops on.

...

>  	dir = kzalloc_obj(*dir);
>  	if (!dir)
>  		return NULL;

+ blank line.

> +	INIT_LIST_HEAD(&dir->properties);
>  

-- 
With Best Regards,
Andy Shevchenko



