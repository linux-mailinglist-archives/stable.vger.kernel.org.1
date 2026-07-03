Return-Path: <stable+bounces-271778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yA6HO0W7R2pveQAAu9opvQ
	(envelope-from <stable+bounces-271778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 15:38:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23011702F25
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 15:38:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="T3/G5KrL";
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271778-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271778-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E56B030E529F
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 13:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9191E3E2742;
	Fri,  3 Jul 2026 13:31:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9853DE427;
	Fri,  3 Jul 2026 13:30:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085462; cv=none; b=uMdk2CiArBFgxaa0rRw4HW35Fmw/MAO2KNBGo22tC/wJn8DOhtowlWc1A5hqNXxgO33gFuxvalRTLeUd9VvSlBxKLgqdQOCkgwU5/aHMHdPrN1/DH2s9QU8kVKPoraA85iJiWW3rzyZ/CNCMZ3liMqGJSavBb/wjcGIJu89XbyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085462; c=relaxed/simple;
	bh=gKe6hk6lBjYOJ6jL6ZoKAesazuaoRsI2yH9UamlZy+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ez0VT5xA4UhSJRbua+w0GQdfhMbH/ao5T3K13JTwx5IcXxpG8WaA4BuMkOQWwrs5tTBnEF9GKOL5XOsLQcLBUQ1typ7I+Tn1MQOdtlC4b0vqksYke9UyHYwSiIb8rOL1crv5uhAm+6GbGlrgjWXwsIayZTGXgbPCh9zAJ41ljyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3/G5KrL; arc=none smtp.client-ip=192.198.163.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783085460; x=1814621460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gKe6hk6lBjYOJ6jL6ZoKAesazuaoRsI2yH9UamlZy+I=;
  b=T3/G5KrLXGZGY5knDZOde4SAJG3IHfHZ8U6qCd13pSZD9bwdkBb2fsM5
   FWd+o+akq5bJPeNRW/+Er4onlvu2w9XRtzH4WlbwUyvrv0Iq9jsuRQbr+
   TSeDXXo4XRvuKHqCvFK4HRh1L0iq0GJSCD27xfs+6JnS7scIkD/ocOjle
   YkrJsLQbACiDiw/vkhQflcgt6mS5zY9QBUxlxi/7kSHF7DQU02h6+jmWh
   eAeUGWC6JR/8F6+7ig0MusIVcymJrxenoDeCa565a8PL/eIKIfbe5hqtw
   wPWSyQJIX2PYM7OQN1rdr+3BlkuKzak5/u7hUSJkzTy7yyPidEmxZqpM8
   w==;
X-CSE-ConnectionGUID: 8wRXe/KVROeO++6XXAEuhA==
X-CSE-MsgGUID: 2sd7ntkbRJCCwIyEMbsBxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="82826617"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="82826617"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:30:59 -0700
X-CSE-ConnectionGUID: AVTweVgOQTOFwyNb1VEiIQ==
X-CSE-MsgGUID: ZkhNDscaTZayckMaH6NG3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="251395198"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 03 Jul 2026 06:30:58 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 58CF395; Fri, 03 Jul 2026 15:30:56 +0200 (CEST)
Date: Fri, 3 Jul 2026 16:30:54 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] usb: typec: anx7411: use devm_pm_runtime_enable()
Message-ID: <ake5jtHU9ob6zA5C@kuha>
References: <20260701114006.75738-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701114006.75738-1-mhun512@gmail.com>
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
	FORGED_RECIPIENTS(0.00)[m:mhun512@gmail.com,m:gregkh@linuxfoundation.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:ae878000@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-271778-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.intel.com:from_mime,intel.com:email,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23011702F25

On Wed, Jul 01, 2026 at 08:40:06PM +0900, Myeonghun Pak wrote:
> anx7411_i2c_probe() enables runtime PM before returning successfully, but
> anx7411_i2c_remove() tears down the Type-C partner state, workqueue, dummy
> I2C device, mux, switch and port without disabling runtime PM.
> 
> Use devm_pm_runtime_enable() so runtime PM is disabled automatically on
> driver detach. Since devres action registration can fail, route that
> failure through the existing probe unwind path.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/anx7411.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> index 604868ebf422..41df115912b9 100644
> --- a/drivers/usb/typec/anx7411.c
> +++ b/drivers/usb/typec/anx7411.c
> @@ -1537,7 +1537,9 @@ static int anx7411_i2c_probe(struct i2c_client *client)
>  	if (anx7411_typec_check_connection(plat))
>  		dev_err(dev, "check status\n");
>  
> -	pm_runtime_enable(dev);
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		goto free_wq;
>  
>  	return 0;
>  
> -- 
> 2.47.1

-- 
heikki

