Return-Path: <stable+bounces-243000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB6pGjyH+GkZwQIAu9opvQ
	(envelope-from <stable+bounces-243000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 13:47:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F5A4BC98D
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 13:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7C3F30134B9
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 11:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DF83A7835;
	Mon,  4 May 2026 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRw5nyIR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782963AD51F;
	Mon,  4 May 2026 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777895111; cv=none; b=X/3IPEwkx90OwkFhpUAqZSD5lJQHrkgTM04LZfZYmuuCcJF0Jv+Kp4YeyRRkPBIITH+QhAbdcXb1oU7FoAdybjBnqR/5Zi4TarBHCAJhIYrv23KuHV7cyOZHfyX8oNUrZ13Gq9rYaWS5DIhFr09x2LTPwIRrZZPqA1hwveXX0qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777895111; c=relaxed/simple;
	bh=olwXHbfEbacoWdoc6oHZgsZsjUjwZfEgiObbHNmIaNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m903ISbXwmfwJkr2SWAtKBGo/hl8J5WCTgNw+fbYOBeVB27RoCGLmV4NncTmXDXFncbBKwlGJ6mdttC9ei9zNF4gKyEGp2KdXtftpK3UmGvCTb0nbPerIpM6NItTeQbpwfFEwTlGhGEZPYRXzN2k9YvUeSoHq3bG49rnDkOvwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRw5nyIR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777895111; x=1809431111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=olwXHbfEbacoWdoc6oHZgsZsjUjwZfEgiObbHNmIaNg=;
  b=SRw5nyIR0UHHoY9y/NRzST9lwRbtAciAo9xzDw1vNdckhHYGOmEGX5RG
   2Az1SPRhKVSdR9v7ocgmogTHT5+Xep3DSOgUcV3vQt6MALT3t6wAlXiDa
   1GtNbrW5slo6+ABOVJnB4ikf2I9StzZX3JYEJ90D/BNjdoauRDkrrPmqT
   G0nhhGHbY+rvYZgXKZDeGucW8lVIynsN76S9lu1X7WTUIphTbfGHz8gO4
   ZU0xs6kE6vCuA4pT2pczgry8Zz4sjER61KHqFxn0KineI1iqBTLN7iCt4
   IPs9DiPRblpSxm7rkPNjEnIsNrxjzrIu3duD6Fh98h+/PIjmrA1dFQT1E
   w==;
X-CSE-ConnectionGUID: xAEh+9vhSmSY0E7xHNscVA==
X-CSE-MsgGUID: 6MHq7riKRhS5kkkTtFDu6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="81316031"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="81316031"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 04:45:10 -0700
X-CSE-ConnectionGUID: AgJc38odTbWSU+gUiV9RtQ==
X-CSE-MsgGUID: PoUynkPXSnCjbnmKnH/IbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="240480177"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 04 May 2026 04:45:08 -0700
Date: Mon, 4 May 2026 19:22:20 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fpga: region: fix use-after-free in
 child_regions_with_firmware()
Message-ID: <afiBbC46CFauotNt@yilunxu-OptiPlex-7050>
References: <20260408154534.404327-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408154534.404327-1-vulab@iscas.ac.cn>
X-Rspamd-Queue-Id: D0F5A4BC98D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243000-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yilun.xu@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

On Wed, Apr 08, 2026 at 03:45:34PM +0000, Wentao Liang wrote:
> Move of_node_put(child_region) after the error print to avoid accessing
> freed memory when pr_err() references child_region.
> 
> Fixes: ef3acdd82075 ("fpga: region: move device tree support to of-fpga-region.c")

The Fixes tag should identify the commit that introduced the problem, so
it should be:

  Fixes: 0fa20cdfcc1f ("fpga: fpga-region: device tree control for FPGA")

I fixed it in place.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next

