Return-Path: <stable+bounces-242961-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIGbBDRh+GlJtgIAu9opvQ
	(envelope-from <stable+bounces-242961-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 11:04:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8DF4BABAC
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 11:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2DDA3028F73
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 09:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB34E34DCFF;
	Mon,  4 May 2026 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpL7cEpj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC6F34DB4F;
	Mon,  4 May 2026 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885280; cv=none; b=KIAWk4sjc3MiAe6XATyTfzYu+Xyc47RujffTY5joDNIvUTlxYaw/K742A+LkCE4eNYk8BlPC5SecLBvgZvFwl5q82BUi3tyubg0lo7PNxwQo4Jo0vBIZjxqzfyA3VN3iuyL19BkZar1EBPSveujHZlTl+gTsayCfYjPH7o/3gzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885280; c=relaxed/simple;
	bh=HPD8OIpg97Kw7qpYamrITGpD8pXMmw6ypaUAhsB5Cz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNJsaIRQU17FZsyVnVQTuzeax707Kz+fY3JqY3lp//tJ2vEhzdKoHaDh7yylhc4tdu2myyzvjeDukrcN97PI95S0t3vEXD0ny/GK30SkYcs358XBGhNQAhp6p0d+2j0Cb49IZRTfB1ee0cvycxE4DuzNHSwSjGMaN+LQCRTbu7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpL7cEpj; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777885280; x=1809421280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HPD8OIpg97Kw7qpYamrITGpD8pXMmw6ypaUAhsB5Cz8=;
  b=GpL7cEpjMQHQpko1yAJu0IKfgzBgPGWqXnf+aCjCOqCodBsEPssrCCL5
   k83/2uEl3vEy/BIgeoP9AugdtLEpFbphy6AXTYAqnaN0QhL2TDaZdJfQy
   d+Lb2O4YapcwgufyXOkVGmD0HrcnoYgpxHZypaVErDQWLYTkpw3F+LUMz
   vbtHtDNdJAXPu+y1J3ozW+zo8UC3A3pN3TJmM6eVh1kBYjmoCmZ7mOn5H
   5hvj4iNoQ1XCxko+b2ae/JhLZLPIuFZVUjwo0hsxOpQyb+8/cHxd5iDQ1
   Ta3v6DvFka3cpq+VjpD9gQfNllJEbJ/9jQ/KUl7rlm6rcrmwm/S0RMkma
   A==;
X-CSE-ConnectionGUID: L1hrcwD5SI6VME9ccC4zEg==
X-CSE-MsgGUID: R82OL6jMQCqHlz3Xp1TyBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78839199"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78839199"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 02:01:19 -0700
X-CSE-ConnectionGUID: xXSUuNw8QRSgwEdLcEWb9w==
X-CSE-MsgGUID: yUUHWuwUTeaT+ggp89i3/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="235336644"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 02:01:16 -0700
Date: Mon, 4 May 2026 12:01:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>, linux-usb@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/4] thunderbolt: property: cap recursion depth in
 __tb_property_parse_dir()
Message-ID: <afhgWlu2qiwqSLUQ@ashevche-desk.local>
References: <20260415123221.225149-1-michael.bommarito@gmail.com>
 <cover.1777817011.git.michael.bommarito@gmail.com>
 <ce8ca06ea5f7a9aa1bf4a82a5aa764b22256f908.1777817011.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce8ca06ea5f7a9aa1bf4a82a5aa764b22256f908.1777817011.git.michael.bommarito@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: AF8DF4BABAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242961-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ashevche-desk.local:mid]

On Sun, May 03, 2026 at 10:15:07AM -0400, Michael Bommarito wrote:
> A DIRECTORY entry's value field is used as the dir_offset for a
> recursive call into __tb_property_parse_dir() with no depth counter.
> A crafted peer that chains DIRECTORY entries into a back-reference
> loop drives the parser until the kernel stack is exhausted and the
> guard page fires.  Any untrusted XDomain peer (cable, dock, in-line
> inspector, adjacent host) that reaches the PROPERTIES_REQUEST
> control-plane exchange can trigger this without authentication.
> 
> Thread a depth counter through tb_property_parse() and
> __tb_property_parse_dir(), and reject blocks that exceed
> TB_PROPERTY_MAX_DEPTH = 8.  That is comfortably larger than any
> observed legitimate XDomain layout.
> 
> Operators who do not need XDomain host-to-host discovery can disable
> the path entirely with thunderbolt.xdomain=0 on the kernel command
> line.

...

>  	for (i = 0; i < nentries; i++) {
>  		struct tb_property *property;
>  
> -		property = tb_property_parse(block, block_len, &entries[i]);
> +		property = tb_property_parse(block, block_len, &entries[i],
> +					     depth);

I would leave this on a single line (yes, slightly longer than 80 characters).

>  		if (!property) {
>  			tb_property_free_dir(dir);
>  			return NULL;

-- 
With Best Regards,
Andy Shevchenko



