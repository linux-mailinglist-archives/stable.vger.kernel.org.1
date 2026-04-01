Return-Path: <stable+bounces-232770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA61FGUPzWmMZwYAu9opvQ
	(envelope-from <stable+bounces-232770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 14:28:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA2737A712
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 14:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 222383058BC4
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBDE3F23C3;
	Wed,  1 Apr 2026 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKUcCgFm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F963A16B0;
	Wed,  1 Apr 2026 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046019; cv=none; b=eykEFc92YBQVGGRpq8vakP4T2mH8nakQ3GCNIOhYtMJXh2c/xB3RUP37y9c9VKM5TUZh2cxteBwK7UxAoU15LC9QQUhJCeUUJUs0pF1gE0TQY3zj0rIuaaMZ0diel8TN4+Z7GuEoxlyO+Q6qlhXYQdr4u3uFTS35Cg6SWHau/zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046019; c=relaxed/simple;
	bh=acnQ6s1ZhIdXaU8kOcjwbAULnwWazRUTJQJ/dWj42KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qj9ge59Nkk9wrjmZQb5EtxLo4+dW1/jt0Ts8pubvO4V6B2+3OXf9p4IUOEOddZ4CD00WcDNG0Jo+MQPP5wWrQQzXCqxMVc8yQ9xKh1GNYTddQtk0+vwyit1JyCY6ZQsa4CAQq1PtyF/OYHBGJzu24JqRtlg3LSato6EBS22U+Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKUcCgFm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775046017; x=1806582017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=acnQ6s1ZhIdXaU8kOcjwbAULnwWazRUTJQJ/dWj42KQ=;
  b=oKUcCgFmxUhhRL9YLKzNBVw3ghESXJj61kogP9XMAVrx/FavN3wK/zCa
   aWnbg5BGP5QytsH85ZtW7ONPMU2Lru4OJbYVhGj695lfmeQTov1r9ByG1
   Bd6Ie9R7dvlRSVP1WbChlf+5RD+es/HSrFnRnoULe9jKzLVDTJnxpmcKU
   20UMIAaa5ItiDDoOW5WR5v2Na/94O7Oj19+AuL9l2jC3UaWepTiBikIyo
   kdOjcfEH4g6Tb4+x8bdwdeOguZNrIwRa51Zse4jE890dUkWX/yfNwnig+
   cI8BY10iuAah+S8AB22wPIGc0ucX3ta/OZ/MxTxPFm2tPNLMNfbTABT8D
   A==;
X-CSE-ConnectionGUID: Mxz7WCE2TXOX/2BYPP70nA==
X-CSE-MsgGUID: Tqk50WxwR8uRCkAtmkQBGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="63631459"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="63631459"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 05:20:16 -0700
X-CSE-ConnectionGUID: 0951rfR5TiSuzWobkpqRyQ==
X-CSE-MsgGUID: HQPIvawtQe2akqH9I2Ql+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="264589556"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 01 Apr 2026 05:20:15 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 1D8E098; Wed, 01 Apr 2026 14:20:13 +0200 (CEST)
Date: Wed, 1 Apr 2026 15:19:26 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Cohen <david.a.cohen@linux.intel.com>,
	Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: ulpi: fix double free in ulpi_register_interface()
 error path
Message-ID: <ac0NTgTPXj7vnXdV@kuha>
References: <20260401025142.1398996-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401025142.1398996-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232770-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BEA2737A712
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 10:51:42AM +0800, Guangshuo Li wrote:
> When device_register() fails, ulpi_register() calls put_device() on
> ulpi->dev.
> 
> The device release callback ulpi_dev_release() drops the OF node
> reference and frees ulpi, but the current error path in
> ulpi_register_interface() then calls kfree(ulpi) again, causing a
> double free.
> 
> Let put_device() handle the cleanup through ulpi_dev_release() and
> avoid freeing ulpi again in ulpi_register_interface().
> 
> Fixes: 289fcff4bcdb1 ("usb: add bus type for USB ULPI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/common/ulpi.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> index 4a2ee447b213..d895cf6532a2 100644
> --- a/drivers/usb/common/ulpi.c
> +++ b/drivers/usb/common/ulpi.c
> @@ -331,10 +331,9 @@ struct ulpi *ulpi_register_interface(struct device *dev,
>  	ulpi->ops = ops;
>  
>  	ret = ulpi_register(dev, ulpi);
> -	if (ret) {
> -		kfree(ulpi);
> +	if (ret)
>  		return ERR_PTR(ret);
> -	}
> +
>  
>  	return ulpi;
>  }

-- 
heikki

