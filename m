Return-Path: <stable+bounces-268143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fLXeM/a3O2oubwgAu9opvQ
	(envelope-from <stable+bounces-268143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 12:56:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AE46BD842
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 12:56:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=X4QAQ4eK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268143-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268143-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18C403034EE6
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8042E8DE3;
	Wed, 24 Jun 2026 10:56:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FB03A1B5;
	Wed, 24 Jun 2026 10:56:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782298610; cv=none; b=X2M2zjaEnDBTt3Qgfl4mCOnv6PdOMfPE6Qwh1ntizUUbibvQlHGJkroduzsDVvcJwZofhf61uZF59sqHCELQPl7HeE+ov2deba+PDHiPZ/imODQPQXPBhdy5zVeMT2T1xLASne4zu0V0SsH0ZXOB16RybqEcjiopfZp7FkILfoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782298610; c=relaxed/simple;
	bh=+uXVurxJXjz8Uxc6eOImWX775lbEJ14hoAiB9MZejhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6IFl0ajJacn0peCaIjA9ZD10dx4Ae/f4HP/fBIuAZ21tIj+w60kHw/UsYTfqWhElmx2GqlTmfFRJwiy/bXcLAFjP4oroOFhb/h66mnr/7TWa7UGxiLzdVkAUq5Ldy9gFqiq7nTOQizPBrv4HlKt1X7Lw++4SCLCWlNvahInO5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4QAQ4eK; arc=none smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782298610; x=1813834610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+uXVurxJXjz8Uxc6eOImWX775lbEJ14hoAiB9MZejhc=;
  b=X4QAQ4eKRFYb49qMWdsxdgZb/V1VhUSpvMwIdzuNl7N6s4WadlfMFVWM
   XS8QaetvIjVizgylFfhcViIxQ/n1XOa8p2yvsRSpLJHOit6UVPyzP2lQi
   jMb+yiL2radICQfpZITbtYN6sf7zAYtvajLttHXum2TtOLV1CW+VsTFPc
   gvADxh2G5/EIJVpz3Pf1F5fHyxishOtBWqxQvIhtMKomx41AWbHfXshBi
   MYZihg1lHi/nOv7Pj48XPh/scpPdt9yXMcz0WoA3wsHSr7inDxXnII7mN
   b88ssCfVMiJ09X0h1siilHT+geZ94zuIAP7dhQHEvf6whWKbyZ9lbjAvL
   Q==;
X-CSE-ConnectionGUID: hJSfKv8sQ1mfYa/ms7b4DA==
X-CSE-MsgGUID: kDom/GGxSkqb1buqukoxvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="94546910"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="94546910"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 03:56:49 -0700
X-CSE-ConnectionGUID: SWDYjH+oTty+lRTVGDgO9Q==
X-CSE-MsgGUID: x3ilFz9vTzmWLMaYAUq41Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="248632799"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 24 Jun 2026 03:56:46 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 5ADAC95; Wed, 24 Jun 2026 12:56:44 +0200 (CEST)
Date: Wed, 24 Jun 2026 13:56:42 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: gregkh@linuxfoundation.org, bleung@chromium.org, abelvesa@kernel.org,
	jthies@google.com, myrrhperiwinkle@qtmlabs.xyz,
	pooja.katiyar@intel.com, venkat.jayaraman@intel.com,
	yuanhsinte@chromium.org, johan@kernel.org,
	quic_linyyuan@quicinc.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: destroy work queue on
 fwnode_usb_role_switch_get() fails
Message-ID: <aju36u5fQVLIgMDh@kuha>
References: <20260624081301.2866854-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624081301.2866854-1-haoxiang_li2024@163.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:gregkh@linuxfoundation.org,m:bleung@chromium.org,m:abelvesa@kernel.org,m:jthies@google.com,m:myrrhperiwinkle@qtmlabs.xyz,m:pooja.katiyar@intel.com,m:venkat.jayaraman@intel.com,m:yuanhsinte@chromium.org,m:johan@kernel.org,m:quic_linyyuan@quicinc.com,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268143-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.intel.com:from_mime,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27AE46BD842

On Wed, Jun 24, 2026 at 04:13:01PM +0800, Haoxiang Li wrote:
> Call destroy_workqueue() if fwnode_usb_role_switch_get() fails
> to destroy the work queue con->wq.
> 
> Fixes: 3c162511530c ("usb: typec: ucsi: Wait for the USB role switches")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 61cb24ed820f..63303e26929f 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1663,9 +1663,11 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>  
>  	cap->fwnode = ucsi_find_fwnode(con);
>  	con->usb_role_sw = fwnode_usb_role_switch_get(cap->fwnode);
> -	if (IS_ERR(con->usb_role_sw))
> +	if (IS_ERR(con->usb_role_sw)) {
> +		destroy_workqueue(con->wq);
>  		return dev_err_probe(ucsi->dev, PTR_ERR(con->usb_role_sw),
>  			"con%d: failed to get usb role switch\n", con->num);
> +	}

You need to add a label err_destroy_workqueue after the
mutex_unlock(&con->lock) and then here:

	if (IS_ERR(con->usb_role_sw)) {
		ret = PTR_ERR(con->usb_role_sw);
		dev_err(ucsi->dev, "con%d: failed to get usb role switch\n", con->num);
                goto err_destroy_workqueue;
	}

thanks,

-- 
heikki

