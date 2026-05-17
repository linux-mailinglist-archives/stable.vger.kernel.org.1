Return-Path: <stable+bounces-249065-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Vnp4CQZYCWoUWAQAu9opvQ
	(envelope-from <stable+bounces-249065-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 07:54:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAFC55F5A0
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 07:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 962C63004D31
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 05:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D3030C60E;
	Sun, 17 May 2026 05:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpC/vJ/J"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3CEF9C0;
	Sun, 17 May 2026 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778997245; cv=none; b=sgT7+F8mlIbJcZX/0PO6SQO/mU1ertz30mseFoY4Y98Qq+Z321GZcddc4j65zN+wvLRiEDZLd/aUXzfCZZVRQjHG+oVe9DGRAPjq3rlAtmPvV8ZMq9pHGr69LsYZVH4xnKKZS/gVjGOyM8ykZ6lEHTRmwMWKFUM2DGzjSZLGp50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778997245; c=relaxed/simple;
	bh=t0yI2t35W6eRe10VKfaXc+7qm0DZ1XGhDhIF/nEZ+8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pA2C3WNuKVOcPpu9CkbBp3ccQjWwFAwxmo3dOx3P4jeO1qUse9liVHLGout6IyhU+hHtJ+EgDUdz/+vMd22o1mD+Ef7lf23wZZ5ZEOvky0xcNBUT+fhbZydSzwGd0I5JHXKw1toZ18oZkvrA+3eZ8tgCtfikKDh9wkQgKRAN9ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpC/vJ/J; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778997242; x=1810533242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t0yI2t35W6eRe10VKfaXc+7qm0DZ1XGhDhIF/nEZ+8E=;
  b=VpC/vJ/JULglIp9VnqaP5wNwPgPRl/yxAL9r/lcZRjkbjsdDk3yXYjfr
   Vr3ydteyXRtrL0uhD4zhR5Z8z1DpevIliGKIOqR40L1U0Nlt9iIQp0vXn
   uw8fff+QGVVGU33vHaI/zTg2TP0YteQT7f8EQWWgzG5OoXoXVwCvy5rAl
   Wl6Tk9r1O8pAPN1t3HoHz0x0SKj5haaIuFN0gBIex+PDIOaiyd88vHigS
   t9Llhw9Mse6DR0RrdjpEblUk5pAvt7EifQciU3hisemvIbgveQBUPTNwH
   zCdz2vF6FgM7xc96qrXUHI0jM0Fzh+kADwcUOaiiA8NRx136SKuLdh+Pp
   g==;
X-CSE-ConnectionGUID: npuIJPJkRX6t/g9QC+kUqw==
X-CSE-MsgGUID: SQ6yLk44TVSVcUaIDaphmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="83758305"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="83758305"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 22:54:02 -0700
X-CSE-ConnectionGUID: EInY3zT1ROCVxYvVaZaXXg==
X-CSE-MsgGUID: X6yuV4sGR6yaI/ecZybZBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="238118074"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 22:54:00 -0700
Date: Sun, 17 May 2026 08:53:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: andy@kernel.org, geert@linux-m68k.org, hcazarim@yahoo.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: line-display: fix OOB read on zero-length
 message_store()
Message-ID: <aglX9PKuBhiz7b3A@ashevche-desk.local>
References: <20260514174342.28451-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514174342.28451-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 1EAFC55F5A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-m68k.org,yahoo.com,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-249065-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ashevche-desk.local:mid,intel.com:dkim]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 10:43:42PM +0500, Stepan Ionichev wrote:
> linedisp_display() unconditionally reads msg[count - 1] before
> checking whether count is zero, so a write of zero bytes to the
> message sysfs attribute hits msg[-1]:
> 
> 	write(fd, "", 0);
> 
> 	-> message_store(..., buf, count=0)
> 	   -> linedisp_display(linedisp, buf, count=0)
> 	      -> msg[count - 1] == '\n'  ; OOB read
> 
> The kernfs write buffer for that store is a 1-byte allocation
> (kernfs_fop_write_iter() does kmalloc(len + 1) with len == 0),
> so msg[-1] is a 1-byte read before the slab object. On a
> KASAN-enabled kernel this trips an out-of-bounds report and
> panics; on stock kernels it silently reads adjacent slab data
> and, if that byte happens to be '\n', the following count--
> wraps ssize_t 0 to -1 and is then passed to kmemdup_nul().
> 
> linedisp_display() is reached from the message_store() sysfs
> callback (drivers/auxdisplay/line-display.c message attribute,
> mode 0644) and from the in-tree initial-message setup with
> count == -1, so the OOB path is only userspace-triggerable via
> zero-byte writes; vfs_write() does not short-circuit on
> count == 0 and kernfs_fop_write_iter() dispatches the store
> callback regardless.
> 
> Guard the trailing-newline trim with a count check. The
> existing if (!count) block then takes the clear-display path
> unchanged.
> 
> Affects every auxdisplay driver that registers via
> linedisp_register() / linedisp_attach(): ht16k33, max6959,
> img-ascii-lcd, seg-led-gpio.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



