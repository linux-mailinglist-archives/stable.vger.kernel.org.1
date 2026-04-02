Return-Path: <stable+bounces-233033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK3hIK95zmmMnwYAu9opvQ
	(envelope-from <stable+bounces-233033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 16:14:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F52F38A4FB
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 16:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ABBA304018E
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 14:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F5C3E51DB;
	Thu,  2 Apr 2026 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsRgnHs8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4403E4C90;
	Thu,  2 Apr 2026 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775138839; cv=none; b=V295nUovaS3D/V4IaElX3Kh1rugL/sVe5k7XsuQ1YQ4WhQliEWrDYJAx5/O+mqIdEQ5l180Y5BJM9Lnn7ExD8If9x5ny1ynF+9XucjnIHEfhcuKJl8POiR03zn9HNU17JRhj9vGwtekyUOQGnpyYBCAvx6Bqeojp51tr+IrWWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775138839; c=relaxed/simple;
	bh=gYESeRb0qPLXt+/mthA2S699t3955yDhVoyjnkXvDmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjA0XmPxaGNQhCZRR5yssIauPS2LreKLhPAIzzQUc77XTUJcVnqDssBvSEiafX6CW7KrWsxstsdASHVOUQJWoN/6y7rt+Y8p9gA9i7BX+BbjG50mwb3vWiOp33ldA3rKEioKDg9s6+C2ZOx6s9RqWJ3Y2Yc2HqVwxus5b+TJcOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UsRgnHs8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775138837; x=1806674837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gYESeRb0qPLXt+/mthA2S699t3955yDhVoyjnkXvDmo=;
  b=UsRgnHs8xAGU8xAiKDANxcRAcMItDZXCrhWGw25LQvBiYGrK6noXOW8P
   pbBqCIuTm2lZTQWxlKNsaw4oNRXV/bec0yfTVn2LOx3mqW0R+KH+XZ62L
   8+dvjzp5a+LPBvhDs5rVzTAe8QjAlm1JS9Anx0oqRzH4e0A3llRLWHpn3
   3I9CnqZVZNfcgNzX8xbcbIsaH/p0Uf9+gxjviPBi3lOXnZBKgNPWxIXFO
   oa7eZA7h89HUlQ7c9AD0QHZ3r/IPzg7K9otTZprL/wJkpPs93s6r5LGyM
   UMdHPI4J32yf/JDbGtOvdtH4MM4QNbrxnEsL6dsTa8vGwni45+V9v5LF+
   Q==;
X-CSE-ConnectionGUID: oKLg4Zc6T8yYshpTT4bZHA==
X-CSE-MsgGUID: LBW1B8thTwycGS7oGoAocQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76213287"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76213287"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 07:07:17 -0700
X-CSE-ConnectionGUID: Chzy8OXbSmyj099eo8MKOQ==
X-CSE-MsgGUID: J/RxUdt1T0i2VOC+fXZylw==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 02 Apr 2026 07:07:14 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id AC5D095; Thu, 02 Apr 2026 16:07:13 +0200 (CEST)
Date: Thu, 2 Apr 2026 17:06:27 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Vincent Cloutier <vincent.cloutier@icloud.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, sven@kernel.org,
	Vincent Cloutier <vincent@cloutier.co>, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] usb: typec: tipd: Restore generic TPS6598x
 contract interrupts
Message-ID: <ac5344ei3zZllgx9@kuha>
References: <20260402000950.715470-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402000950.715470-1-vincent.cloutier@icloud.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233033-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F52F38A4FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wed, Apr 01, 2026 at 08:09:50PM -0400, Vincent Cloutier kirjoitti:
> From: Vincent Cloutier <vincent@cloutier.co>
> 
> The generic TPS6598x interrupt handler still relies on
> PP_SWITCH_CHANGED, NEW_CONTRACT_AS_CONSUMER, HARD_RESET, and
> STATUS_UPDATE, but the irq_mask1 refactor only kept
> POWER_STATUS_UPDATE, DATA_STATUS_UPDATE, and PLUG_EVENT in
> tps6598x_data.
> 
> On the librem5 that leaves PD partners stuck at the 500 mA fallback
> because the active contract is never refreshed after attach.
> 
> Restore the missing interrupt bits so the existing handler paths are
> reachable again. This fixes USB-C charging negotiation on the librem5:
> after a replug the TPS6598x source power supply reports 3 A instead of
> 500 mA and the BQ25890 input limit follows suit.
> 
> Fixes: b3dddff502c5 ("usb: typec: tipd: Move initial irq mask to tipd_data")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vincent Cloutier <vincent@cloutier.co>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 84ee5687bb27..83f2fec6e34e 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -2395,7 +2395,11 @@ static const struct tipd_data tps6598x_data = {
>  	.irq_handler = tps6598x_interrupt,
>  	.irq_mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
>  		     TPS_REG_INT_DATA_STATUS_UPDATE |
> -		     TPS_REG_INT_PLUG_EVENT,
> +		     TPS_REG_INT_PLUG_EVENT |
> +		     TPS_REG_INT_PP_SWITCH_CHANGED |
> +		     TPS_REG_INT_NEW_CONTRACT_AS_CONSUMER |
> +		     TPS_REG_INT_HARD_RESET |
> +		     TPS_REG_INT_STATUS_UPDATE,
>  	.tps_struct_size = sizeof(struct tps6598x),
>  	.register_port = tps6598x_register_port,
>  	.unregister_port = tps6598x_unregister_port,

-- 
heikki

