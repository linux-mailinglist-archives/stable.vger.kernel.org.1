Return-Path: <stable+bounces-233587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPiqFBr51GmfzQcAu9opvQ
	(envelope-from <stable+bounces-233587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 14:31:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE2B3AE6AE
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 14:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D97AB3038D0C
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 12:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1643B3C0A;
	Tue,  7 Apr 2026 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Al53X9J4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37EC3A6EFB;
	Tue,  7 Apr 2026 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564828; cv=none; b=A6lxcT5TMZptr9NBnRxO2U1OEQxC9wNS4RG5yhtjAFmS98MHDc8okgl76zcZMM5ts0ADv0ofAgg2wb2hPLqF2SN2TxsOT3qHXa+vcqbbFAAw3emEg2wA4SleObS4erPaoiGMCEfh7VjUqnDMj0Z+8o1PRxKRMNkw9qxj29bDfZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564828; c=relaxed/simple;
	bh=b0ufC1/n5RipNi7gNB1dDRMT7R4+i/QPzr+HBvbCiHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKJUSNRJkCcWZ7lYCt1kGLZJL/HEKmDTJI17VetC2TlKxbz1D9m2koA/YL+ejewO6vLKa96qXEnLo0me+oCcgv/W1HkLeHSzbA1hxkv6ndeiELygeO6iIfrxUL2oqdyt65OCALilGMo1Omzq8JKIC4hX0xt52iX3HPgJmhCLpZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Al53X9J4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775564827; x=1807100827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b0ufC1/n5RipNi7gNB1dDRMT7R4+i/QPzr+HBvbCiHw=;
  b=Al53X9J4s8w6FuPx/EoClYf3MiwJXIXvpmUajqD+BUrCnoPw0km5iD4o
   pZrtprPqHh/exMiKTRfrZtAfyJ5mNrfi0wpDTf4GRDMNJZXSPdr2KMTYE
   8inekimgc6eJpNIHDxHWqTGJCGGKltgLKLxcJDniRUEfnonetO9EIzRoT
   b9EE8ptHH+EBP6pdAnte9jyHbCue7lNLyCZar6LpM4/AUbOr9Zn0dE53k
   GwkhLjBwl7mPhz6/55doCz7QQk2xN9hMkYCLIYrWRoIsH/qpn6npSV/ke
   4A15aOgUo4tB7ji3dzAQinvrWOTmLedO/ghdJF7z67k4L8zl+4ehtWhW5
   A==;
X-CSE-ConnectionGUID: Uu/MmmrkTb6XXIJhoGrUFw==
X-CSE-MsgGUID: U+0ar1N8TyiENJMiGKoMEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76422327"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="76422327"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 05:27:07 -0700
X-CSE-ConnectionGUID: j5hw7THKSwiggZo79hHREQ==
X-CSE-MsgGUID: MGSpMxtaSEmm+STcfEhtzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="233027315"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 07 Apr 2026 05:27:04 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id A593A95; Tue, 07 Apr 2026 14:27:03 +0200 (CEST)
Date: Tue, 7 Apr 2026 15:26:14 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Nathan Rebello <nathan.c.rebello@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, tiwai@suse.de, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: skip connector validation before init
Message-ID: <adT35i9LIZDettvC@kuha>
References: <20260407063958.863-1-nathan.c.rebello@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407063958.863-1-nathan.c.rebello@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233587-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: BEE2B3AE6AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 02:39:58AM -0400, Nathan Rebello wrote:
> Notifications can arrive before ucsi_init() has populated
> ucsi->cap.num_connectors via GET_CAPABILITY. At that point
> num_connectors is still 0, causing all valid connector numbers to be
> incorrectly rejected as bogus.
> 
> Skip the bounds check when num_connectors is 0 (not yet initialized).
> Pre-init notifications are already handled safely by the early-event
> guard in ucsi_connector_change().
> 
> Reported-by: Takashi Iwai <tiwai@suse.de>
> Fixes: d2d8c17ac01a ("usb: typec: ucsi: validate connector number in ucsi_notify_common()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index b77910152399..7df3a7b94a40 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -43,7 +43,8 @@ void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
>  		return;
>  
>  	if (UCSI_CCI_CONNECTOR(cci)) {
> -		if (UCSI_CCI_CONNECTOR(cci) <= ucsi->cap.num_connectors)
> +		if (!ucsi->cap.num_connectors ||
> +		    UCSI_CCI_CONNECTOR(cci) <= ucsi->cap.num_connectors)
>  			ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
>  		else
>  			dev_err(ucsi->dev, "bogus connector number in CCI: %lu\n",
> -- 
> 2.43.0.windows.1

-- 
heikki

