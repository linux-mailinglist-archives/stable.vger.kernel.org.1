Return-Path: <stable+bounces-260688-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id igs0L03IImqYdgEAu9opvQ
	(envelope-from <stable+bounces-260688-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 14:59:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C28966485BC
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 14:59:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Iz6+vK5R;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260688-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260688-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 992733026063
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 12:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA9B3ECBC3;
	Fri,  5 Jun 2026 12:52:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486773264C1;
	Fri,  5 Jun 2026 12:52:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663957; cv=none; b=etzRToyv5M6Txk4raaqkXeO11rZ+BEpqVNQ1TFdVItN61h0Mgj1x9F5IL0fy5IrUVfZ8jKn5qfix6L3CqslRwP+pqefIEJGjR6Sh30oXtQzWdv3VTyBWliWXcsUT8ZM3bYtubvFPz1+0qyr6RA2/bE/B3xNkeQodWW+Wm2gFMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663957; c=relaxed/simple;
	bh=Os2xsMSG22/MJ+CwFPDdbvHrle1PicUKv/MPhzf0CPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpLC/cQQXH9OEPINh5NBIL5tM+JdGeu99jOTuyOC0UgqTyX3iTA3yJSPtCzUhgEVsbFRugMf4qgxt/goi8k5g2xTEzk761eN8rvYI2ZsXG9aQUHhueBFD1fBKXycLhaly1nEf1X5SUTJju5OA+fIc1phNCmQumzby1E2494IZ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iz6+vK5R; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780663956; x=1812199956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Os2xsMSG22/MJ+CwFPDdbvHrle1PicUKv/MPhzf0CPQ=;
  b=Iz6+vK5RgnajvdvrsMO0EqBkkENBC9GGi7pdIuFepASCu4KVo6QQdygZ
   PLLLsZeTButbJTTYc2/wFYiweSMjAvO8NOvFzLMjrEq5o8J4fnMZg++67
   Y9e9gkWcborQQh4KqFJ7dOiZXb2ZHx6TRBNh9016QgmNu0qeX3+GkIkQd
   IS7bmGFSkTrhgGdj6dVw0mi8kfOiX110c2K9FZg86dr2unbCc/X2ixSnd
   m6cLUpnbAsaY+bVcz+OEh5YhqZGMTiHn+AgtHqZVgDrRyDCZ9m21HHHT7
   gSvSBxE/vLRIKG3rBq+EXs+e1gvq2HhXXMCAkUz4FRO/ks+vmSuXMzcCB
   A==;
X-CSE-ConnectionGUID: v7E2ApQPSHm+VFjUJZY8Jg==
X-CSE-MsgGUID: 7hsl339lTTm1e4uEQVsWyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81528405"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81528405"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 05:52:35 -0700
X-CSE-ConnectionGUID: iwvJFwzFShGxwaQEVj8XDA==
X-CSE-MsgGUID: NufUAVvgQemBUfeJUvBWVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="246666506"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 05 Jun 2026 05:52:33 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 4FE5F95; Fri, 05 Jun 2026 14:52:32 +0200 (CEST)
Date: Fri, 5 Jun 2026 15:52:28 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Invert DisplayPort role assignment
Message-ID: <aiLGjHK-kdETm7u-@kuha>
References: <20260601142837.3240207-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601142837.3240207-1-akuchynski@chromium.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260688-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:akuchynski@chromium.org,m:gregkh@linuxfoundation.org,m:pooja.katiyar@intel.com,m:johan@kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:email,intel.com:dkim,kuha:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C28966485BC

On Mon, Jun 01, 2026 at 02:28:37PM +0000, Andrei Kuchynski wrote:
> The existing implementation assigned these flags backwards, configuring
> the partner's DisplayPort role to match the port's role instead of
> complementing it.
> This prevents proper configuration during DP altmode activation, often
> causing `pin_assignment` to remain 0 in `dp_altmode_configure()` and
> resulting in VDM negotiation failures:
> 
>     [  583.328246] typec port1.1: VDM 0xff01a150 failed
> 
> Additionally, the fix ensures that the `pin_assignment` sysfs attribute 
> displays the correct values.
> 
> Cc: stable@vger.kernel.org
> Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/displayport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
> index 8aae80b457d74..669f08013c7ab 100644
> --- a/drivers/usb/typec/ucsi/displayport.c
> +++ b/drivers/usb/typec/ucsi/displayport.c
> @@ -166,12 +166,12 @@ static int ucsi_displayport_status_update(struct ucsi_dp *dp)
>  	 * that Multi-function is preferred.
>  	 */
>  	if (DP_CAP_CAPABILITY(cap) & DP_CAP_UFP_D) {
> -		dp->data.status |= DP_STATUS_CON_UFP_D;
> +		dp->data.status |= DP_STATUS_CON_DFP_D;
>  
>  		if (DP_CAP_UFP_D_PIN_ASSIGN(cap) & BIT(DP_PIN_ASSIGN_D))
>  			dp->data.status |= DP_STATUS_PREFER_MULTI_FUNC;
>  	} else {
> -		dp->data.status |= DP_STATUS_CON_DFP_D;
> +		dp->data.status |= DP_STATUS_CON_UFP_D;
>  
>  		if (DP_CAP_DFP_D_PIN_ASSIGN(cap) & BIT(DP_PIN_ASSIGN_D))
>  			dp->data.status |= DP_STATUS_PREFER_MULTI_FUNC;
> -- 
> 2.54.0.823.g6e5bcc1fc9-goog

-- 
heikki

