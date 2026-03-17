Return-Path: <stable+bounces-225754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNqFJIP+uGnGmwEAu9opvQ
	(envelope-from <stable+bounces-225754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 08:10:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A6C2A49E8
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 08:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8653301D311
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 07:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A93E388361;
	Tue, 17 Mar 2026 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5k/VtwJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FC6347FDF;
	Tue, 17 Mar 2026 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773731439; cv=none; b=TgSIx9LrUr8TWXFsRVNnwtGfA8e+5u7SLjzRhk6QEjKyGh7CgjyULmTeePNdPkb2G91DKVtSABqeieKAgkF9Shx1PGNWLv9Rkjh5EX1dF26C0qVJ06d8QRby5ltSiZoktMXOuC7yOCG8UaYrTK0e1vDqPeXGLYuRjDMqhRCXYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773731439; c=relaxed/simple;
	bh=R7+uigS6RvsoYyWW802Gylu1VZG5usDe19K1H9gY0l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDlQiNUxNESZaX4xpxJ38UVDOWxk08eyc8pTFDdm/DJLmOslgOIgfDSyqT0CU/4Jyy0aFU33uQ+ANkO4BoOMatEvNquT2coR5rM3Qa89fNDQFiesL162jq54PQHdTZ05a0Ajqs/SSw1v6oBL2CTelabXmkhEKlRa3M4J/81agV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5k/VtwJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773731437; x=1805267437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R7+uigS6RvsoYyWW802Gylu1VZG5usDe19K1H9gY0l4=;
  b=F5k/VtwJow7BqbYDH9rlY9sD/s4T6YmSZTtFsG0wC+59HMZUYkzAVvl/
   yQD7XuspMSWPCd103AbvQ8zJkyNFQmZI8OImquvQJK9EK7y+8J77+C/RW
   nEjZM4jB4i4fsYkMBVrc0TmyoW5Ib6xwrLWjQeIGAoHp3GSENCyMEPfW6
   hiYsTv/Z9aAnNzDGwNsETtZCSUu47kY0lfbpyXpCZLEsAZ6ciClYBcq1O
   hmSVv2xKcvq/ik6legiTR41L8nOn0wAU/NuqayHEyNh3mhIlJLWoIA0SJ
   hksD9L1urCxwDbKKkheKZnOMCU+nscKGbwxYhrkGkITPiM4QoHE3abpfw
   g==;
X-CSE-ConnectionGUID: DBJQgS/5QeqlwvDt2RqFtA==
X-CSE-MsgGUID: MKjtUPFuS7q0OAPbNo1p3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="92138491"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="92138491"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 00:10:37 -0700
X-CSE-ConnectionGUID: 8SCEUEfxRtmk1tqABg3+qA==
X-CSE-MsgGUID: nY7xou3+QbiCy45uqFfElw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221200793"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 00:10:28 -0700
Date: Tue, 17 Mar 2026 09:10:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Daniel Scally <djrscally@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
	Mark Brown <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	devicetree@vger.kernel.org, driver-core@lists.linux.dev,
	imx@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] device property: Make modifications of fwnode "flags"
 thread safe
Message-ID: <abj-YqUP97dcSwEf@ashevche-desk.local>
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,nxp.com,linux.intel.com,redhat.com,pengutronix.de,armlinux.org.uk,sang-engineering.com,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-225754-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ashevche-desk.local:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 34A6C2A49E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 03:42:06PM -0700, Douglas Anderson wrote:
> In various places in the kernel, we modify the fwnode "flags" member
> by doing either:
>   fwnode->flags |= SOME_FLAG;
>   fwnode->flags &= ~SOME_FLAG;
> 
> This type of modification is not thread-safe. If two threads are both
> mucking with the flags at the same time then one can clobber the
> other.
> 
> While flags are often modified while under the "fwnode_link_lock",
> this is not universally true.
> 
> Create some accessor functions for setting, clearing, and testing the
> FWNODE flags and move all users to these accessor functions. New
> accessor functions use set_bit() and clear_bit(), which are
> thread-safe.

In general I like the idea (independently on the treewide patch or a series).
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

See one nit-pick below, though.

...

> While this patch is not known for sure to fix any specific issues, it
> seems possible that it could fix some rare problems. I'm currently
> trying to track down a hard-to-reproduce heisenbug and one (currently
> unproven) theory I had was that the fwnode flags could be getting
> messed up like this. Even if turns out not to fix my heisenbug,
> though, this seems like a worthwhile change to take.

Totally agree. This makes code more OOP like and robust against subtle
modifications.

...

> +static inline void fwnode_set_flag(struct fwnode_handle *fwnode,
> +				   unsigned int bit)
> +{
> +	set_bit(bit, &fwnode->flags);
> +}
> +
> +static inline void fwnode_clear_flag(struct fwnode_handle *fwnode,
> +				   unsigned int bit)
> +{
> +	clear_bit(bit, &fwnode->flags);
> +}

Perhaps you also want to have fwnode_assign_flag() (assign_bit() underneath)
as...

> +static inline bool fwnode_test_flag(struct fwnode_handle *fwnode,
> +				    unsigned int bit)
> +{
> +	return test_bit(bit, &fwnode->flags);
> +}

>  	if (initialized)
> -		fwnode->flags |= FWNODE_FLAG_INITIALIZED;
> +		fwnode_set_flag(fwnode, FWNODE_FLAG_INITIALIZED);
>  	else
> -		fwnode->flags &= ~FWNODE_FLAG_INITIALIZED;
> +		fwnode_clear_flag(fwnode, FWNODE_FLAG_INITIALIZED);

...at least one immediate user here.

-- 
With Best Regards,
Andy Shevchenko



