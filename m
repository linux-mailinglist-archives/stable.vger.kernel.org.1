Return-Path: <stable+bounces-238268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBw2JEmV4Gn/jwAAu9opvQ
	(envelope-from <stable+bounces-238268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:52:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D8E40B35E
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACEE43009824
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 07:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410EF37C105;
	Thu, 16 Apr 2026 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTEOAkJq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF8D25A2DD;
	Thu, 16 Apr 2026 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776325953; cv=none; b=STDPCOlkLfZONDJ6AgK1ja42hQkoCHfiV7UhEJCbujbgasjhtSMIGqOozCBM8r9HGAUcaBN9grCx/VmeRbBOi2Hu044S66WSVaCEuRmosTa3X3Z66F+Mo9TqdGxemkPxpn8umy8U9Lt2iIPnLSqrAlFA5jbLdCfKqyA+IU+w/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776325953; c=relaxed/simple;
	bh=HcS8lf+M3rwcI4146kwayNG08ANcxdMIejJM/hKblxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auWXEwN/zqRBkekaxoWNEPQx7kCmshnJm6kWdDyS5oZS2q4bL20SxLxXkhKbvhc6I3WxQX71WRk78TprQYEt2bxP9rTCbxgxvtqERYD46RSInld+DcaB5cHQ61BbmPU49btxccKr1uzAkLslB70/FpFNGnbzgpZ7a3GpgOyGmbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTEOAkJq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776325951; x=1807861951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HcS8lf+M3rwcI4146kwayNG08ANcxdMIejJM/hKblxA=;
  b=NTEOAkJqrDOhs4M2C56HjUSW9/mNDMVaa//+91S6atRq6P6nsPlJyXaE
   +LvNAz2Cim77y2m1Txhy6z3kvxIYxZOP0tA+pB/MFXxkJ2MNWQx2j3iNd
   cb/t4aZyC+MFmj8+VSdvyk+PZ+q/ixfWu//ETt4toGvj0rfy/Z/72aMba
   xQGlgkZXNw2yn+gKkuXhZoyoWG6SpPvLBWVOaI8u6IjLSwgMpoYinbwAC
   h+IptErCugdhluWNrYCBFxY2JXhl1uH+qhK5H0DKQvhAWSu/u0/FDo/el
   oPhLV/sNlwXI5jf6j+L3SLpOcUVUtBuGSPpIwx3ZM8wDSMQyhBrT81Ndc
   Q==;
X-CSE-ConnectionGUID: QiEd1H7eRHOtziYS4qW5JA==
X-CSE-MsgGUID: sD24WMdiQjiYc4SP2EEBxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77391287"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77391287"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 00:52:31 -0700
X-CSE-ConnectionGUID: zCz9GQOoSPyXIuu4TZruvA==
X-CSE-MsgGUID: 0V0cyxXWS22q4BBm+TbG2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="230506454"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.173])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 00:52:27 -0700
Date: Thu, 16 Apr 2026 10:52:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] eeprom: digsy_mtc: fix reference leak on failed device
 registration
Message-ID: <aeCVOuLGrcm0L5rP@ashevche-desk.local>
References: <20260415165203.3584869-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415165203.3584869-1-lgs201920130244@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[4.211.64.104.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-238268-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,ashevche-desk.local:mid]
X-Rspamd-Queue-Id: 97D8E40B35E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 12:52:02AM +0800, Guangshuo Li wrote:
> When platform_device_register() fails in digsy_mtc_eeprom_devices_init(),
> the embedded struct device in digsy_mtc_eeprom has already been
> initialized by device_initialize(), but the failure path only removes
> the software node and does not drop the device reference for the current
> platform device:
> 
>   digsy_mtc_eeprom_devices_init()
>     -> platform_device_register(&digsy_mtc_eeprom)
>        -> device_initialize(&digsy_mtc_eeprom.dev)
>        -> setup_pdev_dma_masks(&digsy_mtc_eeprom)
>        -> platform_device_add(&digsy_mtc_eeprom)
> 
> This leads to a reference leak when platform_device_register() fails.
> Fix this by calling platform_device_put() after removing the software
> node.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.

Thanks for catching this up!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



