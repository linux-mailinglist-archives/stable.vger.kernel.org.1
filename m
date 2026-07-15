Return-Path: <stable+bounces-274798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FpOMEp1aV2ogKQEAu9opvQ
	(envelope-from <stable+bounces-274798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 12:02:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE4275CBDE
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 12:02:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=TRVLmt5b;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274798-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274798-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B92E5304B6BF
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 10:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BC143B6C0;
	Wed, 15 Jul 2026 10:00:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E8F3A5430;
	Wed, 15 Jul 2026 10:00:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109620; cv=none; b=rr/yFh7OukY0xR94zqrKqLdiDQejsx4FoLH+ORROhRaWNPlgdjCyd4OiS2Oibb8wDyktPagvEBps+dicG2eb5s3gGZl3pZ7dVn1J5M5hWt6Bw0Rd+maNl/G1fPomLrknu6duL01iqbXQ1liT6g66Clhj2cetETUzfmhqXDtipqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109620; c=relaxed/simple;
	bh=v2/oeVbvWskqmg8+4PneDbKug9LAg3HtjSRz3sJ3AtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy2YVZjiyOPm7U4oHjt1ZT6Ejf529jai2DZR3oRMktSMJZjC0Tcpc0zKnBbq3NBQ4hdE9U7+PcchXpcAhk+wJWMnVWz+zFxHUY6MtKmQ4CynoDzjfWz9ylgdl7ycpWB3yQuTcE7rinavdZzMVrn7693o30VwcUSeS+/LctFF2O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRVLmt5b; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784109618; x=1815645618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v2/oeVbvWskqmg8+4PneDbKug9LAg3HtjSRz3sJ3AtU=;
  b=TRVLmt5bM7tyufyX1mTSroa6+MsSt8tLHfexxVi0JbH/6lzOFZPx/r34
   d16TXm1MwF6w12l79fJ17DTJf0et8MgeRNeSPisDcWYyStglzphL8LVBx
   b2tYDGhLSCHspulHPaSXCPTwaLAA+y9ZT/q/w5hATa6eCWmkDgqGj0Fd4
   u5tK/RDDZUTTBoL0RqCBqrgqj6z8Hp2YOz1M8KIyxROb+FGNFfxKRMWl1
   /f2oXn5dc2b2sgQjSGf8X6a2cLCxC8IPGtDPsLYBLnlAr624bP7trc9Si
   146xRkpdd94tdmq3tVOOXwPL2u1ux3FSc/X1UYYK/heOA8r2nw8C0cMe3
   Q==;
X-CSE-ConnectionGUID: ETAvC3g/QBiujBcWWU2gMA==
X-CSE-MsgGUID: oI6K/K+0T5iPii1oQ8yWQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84939144"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84939144"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 03:00:17 -0700
X-CSE-ConnectionGUID: pp9rFVKpTc2TN04+KzY72w==
X-CSE-MsgGUID: 6wOowi5XQW6aIG9oSLtwkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="256784352"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 15 Jul 2026 03:00:14 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id B12D795; Wed, 15 Jul 2026 12:00:13 +0200 (CEST)
Date: Wed, 15 Jul 2026 13:00:12 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Ramesh Babu B <ramesh.babu.b@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 0/3] drm/xe/i2c: alerts and controller enabling
 modifications
Message-ID: <aldaLN5xc4GCC1_k@kuha>
References: <20260713155601.711389-1-heikki.krogerus@linux.intel.com>
 <alZbqH51wJjm_CVC@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alZbqH51wJjm_CVC@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rodrigo.vivi@intel.com,m:matthew.brost@intel.com,m:thomas.hellstrom@linux.intel.com,m:raag.jadav@intel.com,m:mika.westerberg@linux.intel.com,m:andriy.shevchenko@linux.intel.com,m:andi.shyti@kernel.org,m:ramesh.babu.b@intel.com,m:michael.j.ruhl@intel.com,m:linux-kernel@vger.kernel.org,m:intel-xe@lists.freedesktop.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274798-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kuha:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDE4275CBDE

Hi Rodrigo,

On Tue, Jul 14, 2026 at 11:54:16AM -0400, Rodrigo Vivi kirjoitti:
> On Mon, Jul 13, 2026 at 05:55:58PM +0200, Heikki Krogerus wrote:
> > Hi,
> > 
> > The hardware challenges that these patches address are so severe that I'm
> > marking both of them as fixes. In both cases the GPU may silently end up in
> > unresponsive state (or worse). The second patch has been refactored so that it
> > includes the direct AMC alert handling in Xe instead of the normal alert handler
> > registration. The subject lines were also changed to highlight the fact that
> > these are fixes. Ramesh helped me with the testing and with the implementation
> > for the AMC alert handling.
> > 
> > Changed since v2:
> > - Added Fixes tag to both patches.
> > - i2c-designware is no longer supplied with an interrupt so it will be in
> >   polling mode (ACCESS_POLLING will be enabled). The IRQ path in hardware can't
> >   handle the amount of interrupts the i2c controller generates. Only the
> >   interrupts from the SMBus Alert line are left enabled.
> > - The registration of the default smbus alert handler is dropped.
> > - The AMC alerts are handled directly in Xe. All the alerts will cause the
> >   device to be declared as wedged at least for now.
> > - Cleanups proposed by Raag.
> > 
> > v2: https://lore.kernel.org/lkml/20260625125939.429078-1-heikki.krogerus@linux.intel.com/
> > 
> > Changed since v1:
> > - Global header for the DesignWare I2C registers which meant a bit of
> >   patch refactoring.
> > - Selecting CONFIG_SMBUS in CONFIG_XE and handling smbus in xe_i2c.c instead of
> >   separate file.
> > - Storing the alert device to the client array and providing enum for the
> >   clients.
> > - Allowing other fields in the IC_ENABLE register to be updated except the
> >   Enable bit.
> > - Can't sleep in xe_i2c_disable() so using udelay().
> > 
> > v1: https://lore.kernel.org/lkml/20260622114759.3464047-1-heikki.krogerus@linux.intel.com/
> > 
> > This includes support for the SMBus alerts, and special handling for the
> > IC_ENABLE register.
> > 
> > Thanks,
> 
> 
> Please take a look to Shashiko review and let us know in case of false positives:
> https://sashiko.dev/#/patchset/20260713155601.711389-1-heikki.krogerus%40linux.intel.com

The high ones are false positive.

- The SMBus interrupts are not cleared the same way as the other
  interrupts.
- i2c-designware driver does not modify the timings unless it is
  supplied a clock device (struct clk).

The rest I'll check and fix as needed together with the modifications
proposed by Raag.

Thanks,

-- 
heikki

