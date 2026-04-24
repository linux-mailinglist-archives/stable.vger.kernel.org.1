Return-Path: <stable+bounces-240580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EksHs4r62mBJgAAu9opvQ
	(envelope-from <stable+bounces-240580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:37:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF77E45B981
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB57B3004CBD
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D0432A3E5;
	Fri, 24 Apr 2026 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/QpYicz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA429ACF6;
	Fri, 24 Apr 2026 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019808; cv=none; b=lJX3E3vougbV8md4KnPwnOnSdEW3cFgCxiZD69q/vSMNqc+ToRCmE+zVefIv3mAJTr5/h3K9NdnNLWbpbQq/KT6b7cnKmznW2Wb2S1dokNt2GZsPVJR7fg9GUdvVg+cLF1JW7+jGYzIYmUYlT2TkuQ8IlukY2nPIH4jdT+QdJUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019808; c=relaxed/simple;
	bh=0ceewUDuJsreRKk1zTgCLogEwTdwY05YA5D3X0W5jSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhkFCcKRQNx6IAl/ASPTZp77az67sjcU6oxs4eaDbp0G9/mlEOtM7fP/cSiwcTYWWETD3hwQobXmZranluqnVjKOQ9Ccn9myQETpAYU6UNwQ0OAifdmJsWoQuQl+DPrH4lz4zKXH6IKE7z0hd+2iSVedjGCFQTxR2vGlzMcieY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/QpYicz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777019807; x=1808555807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0ceewUDuJsreRKk1zTgCLogEwTdwY05YA5D3X0W5jSU=;
  b=U/QpYicz+UCmRfVBybPSHMcpk7QvfmujcIE/jGC3dmozJKWEsYXlE316
   La9npd6N0AO8eIa0w9dwST5ZSNs83wjtg6f/t0fk0rDWQwRK2eEElH7fS
   bzeq1t6+A72Q6A98/yX0hWlCrywFSGzeb0xBW2Dhlz4ZIfik75Y3IQLi4
   qDj+O5LCjLwbgYR5n5fDhJLRDHheg/Aw2z06hPZDoGPF0Lm+V994px4dR
   R86BqqZ/IypbOPImVztMtW65o+5p1jawa2JpOn/9sjVzo8hLspy/+cQwd
   PgYkOvL0Boyg3MtiyO7IjEG+KxarPqpBaa170ooYaO8HQmvQK9WBPxkXx
   Q==;
X-CSE-ConnectionGUID: ZDzFUIGNS3KVsdFs2ilgww==
X-CSE-MsgGUID: VELhW0dpTxysZogSQcOU8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77701319"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="77701319"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 01:36:47 -0700
X-CSE-ConnectionGUID: +Zh59KVHS0yvAVPrKvsA0g==
X-CSE-MsgGUID: CxKDFqbLSsWxPy5ctutkhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="233201129"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 01:36:45 -0700
Date: Fri, 24 Apr 2026 11:36:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] eeprom: digsy_mtc: fix reference leak on failed device
 registration
Message-ID: <aesrmgiKC1uBxek7@ashevche-desk.local>
References: <20260415165203.3584869-1-lgs201920130244@gmail.com>
 <aeCVOuLGrcm0L5rP@ashevche-desk.local>
 <CANUHTR9-p7Cc7i=eSjaE2Wp_dEq-1Gw1LWaYDySP86u6=FmJoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANUHTR9-p7Cc7i=eSjaE2Wp_dEq-1Gw1LWaYDySP86u6=FmJoA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: CF77E45B981
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240580-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,ashevche-desk.local:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 04:21:05PM +0800, Guangshuo Li wrote:
> On Thu, 16 Apr 2026 at 15:52, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Apr 16, 2026 at 12:52:02AM +0800, Guangshuo Li wrote:

...

> After re-checking it, digsy_mtc_eeprom is a static platform_device and it
> does not provide a dev.release callback. Therefore calling
> platform_device_put() on the platform_device_register() failure path is
> not appropriate here and can trigger the missing release callback warning.
> 
> This falls into the same static platform_device pattern pointed out in
> the other reviews, so I will drop this patch.

Ah, good point! Indeed, this device is either present for the entire system
run-time or not at all. Even if it's erroneously attempted to be instantiated
it's still not a big deal.

-- 
With Best Regards,
Andy Shevchenko



