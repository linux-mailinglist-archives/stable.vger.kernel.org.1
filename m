Return-Path: <stable+bounces-267088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 99nKFrHKM2ppGQYAu9opvQ
	(envelope-from <stable+bounces-267088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 12:38:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC6369F669
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 12:38:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=XqOMpXo8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267088-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267088-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 343C8301FB33
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 10:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26203ECBD9;
	Thu, 18 Jun 2026 10:36:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A703EFD2D;
	Thu, 18 Jun 2026 10:36:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779018; cv=none; b=um0Gobvz7MgzgXno/il3YNwKwtM1iP3OoT7sWQ6Vo8lksA9ocfEVwwFNrtM8jlfeEA2zhO6yuVYLQq/VhbWK9Jc1fvJXz2FjFFt92x76Xg5J5dzHSYlCh6jfj4uWmYbOIGCrI4kI7MauwYcAT20sr2hOo0xjQ4VZWecw5lwqntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779018; c=relaxed/simple;
	bh=7Nzbpjv7n37f4sbGVDcMQ7ne6oZ93Z4YkgglX3MKqUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q31rPs7CyJQrRSihAurb9p+1TQApDtKo/TZTMCcQDlLhcFTv28XCk/st/v1RSIo4evcaWONnM6j+QN4H4hYkVs7t662Cze6eliPONJdd+ktMSnZmDWbsDCf+S6Y0kKduma6cQd0eSJcJmlwwNULm94s4qquEo/QPxbNkMX2kVdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XqOMpXo8; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781779017; x=1813315017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Nzbpjv7n37f4sbGVDcMQ7ne6oZ93Z4YkgglX3MKqUk=;
  b=XqOMpXo8sDmI4gdiOlGStlcIdKWt8i8qsemLmYOehLbErPS7BneYbSND
   xKbvX5/FimTCM2xyMAUXUe1MF9ZCuEmWWuKillNkM7NsNw4SN9XNukuiA
   ORmy0aZ06vydL0vvWiUoWRImcGYrA7muGDiAJH/zVTve1eUQWXoFEz+mW
   pqRJGzdCsCyjvfvx3eZqe6QMyBx7e7V7f8ESCgS8Wkv1uuXzNXDSmwr5d
   h7w94mBMKpZq41G3ZAX8sTYYxmvtpyAQYwFbqAmoPSnBHeAmm+9Inqfgy
   FfCtMv3Fp/znftzEmuHjUIMtIeFqcMmWCRNe9aEXQggHY0YMClePS4sR+
   g==;
X-CSE-ConnectionGUID: EjHPzUYZReGofZ9gUnRomQ==
X-CSE-MsgGUID: Eb/DhaFxTpucKfDZ98K1Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82809107"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="82809107"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 03:36:55 -0700
X-CSE-ConnectionGUID: UD73svXlT8+CLuyW2NIlsQ==
X-CSE-MsgGUID: c7sLMmdpT6+AATQhlFdaCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="247188126"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 18 Jun 2026 03:36:52 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id C781198; Thu, 18 Jun 2026 12:36:50 +0200 (CEST)
Date: Thu, 18 Jun 2026 13:36:49 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: ccg: Fix use-after-free of ucsi on
 remove
Message-ID: <ajPKQduMwyVn_X48@kuha>
References: <20260616132011.103279-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616132011.103279-1-fanwu01@zju.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267088-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:fanwu01@zju.edu.cn,m:gregkh@linuxfoundation.org,m:johan@kernel.org,m:pooja.katiyar@intel.com,m:dmitry.baryshkov@oss.qualcomm.com,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDC6369F669

On Tue, Jun 16, 2026 at 01:20:11PM +0000, Fan Wu wrote:
> The threaded IRQ handler ccg_irq_handler() calls ucsi_notify_common(),
> which on a connector-change event calls ucsi_connector_change() and
> schedules connector work.  In ucsi_ccg_remove(), ucsi_destroy() frees
> uc->ucsi (kfree) before free_irq() is called, so a handler invocation
> already in flight may access the freed object after ucsi_destroy().
> 
>   CPU 0 (remove)            | CPU 1 (threaded IRQ)
>     ucsi_destroy(uc->ucsi)  |   ccg_irq_handler()
>       kfree(ucsi) // FREE   |     ucsi_notify_common(uc->ucsi) // USE
> 
> Move free_irq() before ucsi_destroy() in the remove path.  It is kept
> after ucsi_unregister(): ucsi_unregister() cancels connector work whose
> handler issues GET_CONNECTOR_STATUS through ucsi_send_command_common(),
> which waits for a completion that is signalled from the IRQ handler, so
> the IRQ must stay active until that work has been cancelled.
> 
> The probe error path already orders free_irq() before ucsi_destroy().
> 
> This bug was found by static analysis.
> 
> Fixes: e32fd989ac1c ("usb: typec: ucsi: ccg: Move to the new API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index d83a0051c737..c089000bd448 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -1513,8 +1513,8 @@ static void ucsi_ccg_remove(struct i2c_client *client)
>  	cancel_work_sync(&uc->work);
>  	pm_runtime_disable(uc->dev);
>  	ucsi_unregister(uc->ucsi);
> -	ucsi_destroy(uc->ucsi);
>  	free_irq(uc->irq, uc);
> +	ucsi_destroy(uc->ucsi);
>  }
> 
>  static const struct of_device_id ucsi_ccg_of_match_table[] = {
> --
> 2.45.2

-- 
heikki

