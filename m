Return-Path: <stable+bounces-247656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KF7TMmkCB2qVqgIAu9opvQ
	(envelope-from <stable+bounces-247656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:24:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C56EC54E58D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08F3631C2093
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56350472766;
	Fri, 15 May 2026 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1q9Ccd4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D033D3490;
	Fri, 15 May 2026 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842559; cv=none; b=pX0ROhds/qjfL6+vCEOInhOaPleC1xbId3ojqvh5dz0tQne/uFd+yL53HBhMP9tL1oeKm1CqdFFdIqc0chDYKNJiG9+rjgpShYmTsElVB/3J4GU/HjngBH6kq1dpFIwsjnQ4oBN2uTS+B0LAVjZuKYF8orRhssXWkd/bmqw6mQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842559; c=relaxed/simple;
	bh=EiIFCEPpFnxGY7rw8rti+bu6oljP97APvDXgG2A0A7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utK4t2hF4+ZYDGPCXZ1OkSdlKrx4wut42mbSn/ji+d7TXcVZV3eZ891cL5sDrGZrULapANuOiB5p2KlWY3vbB209eoCVGRNWR3LhWRtsbLxo6xu2vyixiYY4ityved/UHg4HzDzMP4UvY64XUZ9yUCThrr/8lgfRJAAb08VDUiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1q9Ccd4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778842558; x=1810378558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EiIFCEPpFnxGY7rw8rti+bu6oljP97APvDXgG2A0A7Y=;
  b=J1q9Ccd4Xp6l1cFlOuqQOqOqu72uY6dz+UZVoqZksXpIzskeKJgZoqON
   cqgnLfwAxQNyxuCu9NH4vz9Zf06gIfdwVEGWpVH5m1ml7Bm8YB9Mdu0g/
   gQ5KH1fQlsjHzVD7KkYIpc2470mv3Tio2u6w45aNp0mcxeFUHSPD4Iiu5
   5AuexxFRz46CHEkKGE79CYL8h+WXC8es3FdrhImM3/fTjlOClcNAj7yE+
   Sj4vu/guGEuKPQVPKhdLyWFKX7F8grJV/T+9EB3ZV1NwVe1iu18MjKDq1
   RM/eO/HHYq9+/d6y5XLbhtiJRgXvZdiZi2WZ4bUi4/k8K0xuBGaW3YOaQ
   w==;
X-CSE-ConnectionGUID: u2pzZTcaR1ysE2Lr8L4tnw==
X-CSE-MsgGUID: H8PnB1QESmCxauFcNUElng==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79916246"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79916246"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 03:55:57 -0700
X-CSE-ConnectionGUID: aB6CS2f8QMCP45tCGOcDbQ==
X-CSE-MsgGUID: Mqu57DvIQUCRNljFSDjDOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="234228212"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.33])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 03:55:55 -0700
Date: Fri, 15 May 2026 13:55:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] serial: 8250_dw: clock-notifier cleanup
Message-ID: <agb7uAZBqylmaX37@ashevche-desk.local>
References: <20260514143746.23671-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514143746.23671-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: C56EC54E58D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-247656-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,ashevche-desk.local:mid]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 07:37:44PM +0500, Stepan Ionichev wrote:
> Two-patch series addressing Andy's review of the leak-fix on v1.
> 
> Patch 1 keeps the same single-line leak fix as v1, but with:
> - the correct "serial: 8250_dw:" prefix (underscore),
> - a Fixes: tag pointing at the original clk_notifier introduction,
> - Cc: stable@ so the fix gets picked up by stable branches that
>   still carry the notifier code.
> 
> Patch 2 drops the clock-notifier infrastructure entirely from
> mainline, as suggested by Andy. The notifier was introduced for the
> Baikal-T1 SoC (shared baudclk between UART ports) and has no other
> in-tree user; Baikal-T1 support has been removed from the kernel.
> 
> If a future platform needs the cross-device baudclk-rate notification
> pattern again, it can be reintroduced in a more general form.

Seems legit, especially the second patch.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


-- 
With Best Regards,
Andy Shevchenko



