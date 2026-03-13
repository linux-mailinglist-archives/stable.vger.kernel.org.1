Return-Path: <stable+bounces-225267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KFANKfQs2ncbAAAu9opvQ
	(envelope-from <stable+bounces-225267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 09:53:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CA127FFD6
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 09:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFA19301FE7F
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 08:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938E336AB5A;
	Fri, 13 Mar 2026 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEMXdfVy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF81B2E54D3;
	Fri, 13 Mar 2026 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773392034; cv=none; b=a67jsbS8lWkFMcnqkoe0TlduxWdtxvuaNjVsod6Yt4BVx9nYpUmN8ac2ZOu9MlrL5cAkuOfgouRH2eQNYczoMIC1LD9Vs8oA8zqqg5rnF5cDxAWbal6V07T9Dkl/Lm3Zy0Yis4i5SWFWnXOpr4nb2Vlz0xNetilmA3Ip2ql9xyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773392034; c=relaxed/simple;
	bh=03rhZ3rnTWDziCs20a8l62amlt5ld61X2Tb6E/l08NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1weyPzYVv8HNks4gsnppg1+cGy+DKASYKhq0RW1oUD/Y6xOHF6zH4I4beldpEjhAQZghTNVLl5TIgaHGmAVM7weigf1HRc1iJAaHUvlcCYIchke4DXZmE+rm9lxUfW5VKRu8oq6RncdbXCKRVff9d/oeCWW11hBODZBMphnTlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEMXdfVy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773392032; x=1804928032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=03rhZ3rnTWDziCs20a8l62amlt5ld61X2Tb6E/l08NM=;
  b=TEMXdfVym+2VLbmETcexXS2viURugDVl0CIeN1dPjpwTz69+orZlfWzf
   E8hpF0mo2mrfh2PYGu68Y+jp9PaKp/bDjrWvbOugtTnNkjPYjeuDK50AU
   gJx5RktsCy7XW0KDKLNmkk8qkCxQVlSKa6mPeIPJI/J+qPtCRBdNBc8o1
   tGEH+km29B5IV/GuQZm1/mNuxBIjPIBxx0NSUU/b0OSI9AEB82CcAgbp6
   3A2cM2+LeaeVGB9kZdmOtf97KzMaB2Mgx3tLyg4V7vBqMADIDnrUIGC/a
   s4/GNpu0XGiFBeyICwzcrhA3MY9qkNl4j6proRs6ZT+6Z1cpy7/LINPk2
   A==;
X-CSE-ConnectionGUID: r8STaKKST7mKAfIe5FKDgw==
X-CSE-MsgGUID: 9Q+A4V3rREOUsF3lJ1FTnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="91878618"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="91878618"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 01:53:51 -0700
X-CSE-ConnectionGUID: +Kwt4LJvRqmQhsVVjwSzwA==
X-CSE-MsgGUID: wvhfM72fQ7S9VTXA7WNnyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="221312814"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 13 Mar 2026 01:53:50 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id E4DBA95; Fri, 13 Mar 2026 09:53:48 +0100 (CET)
Date: Fri, 13 Mar 2026 10:53:04 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Nathan Rebello <nathan.c.rebello@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	kyungtae.kim@dartmouth.edu, stable@vger.kernel.org
Subject: Re: [PATCH v4] usb: typec: ucsi: validate connector number in
 ucsi_notify_common()
Message-ID: <abPQcFxlSntTv-1t@kuha>
References: <20260312211503.1915-1-nathan.c.rebello@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312211503.1915-1-nathan.c.rebello@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225267-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6CA127FFD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thu, Mar 12, 2026 at 05:15:03PM -0400, Nathan Rebello wrote:
> The connector number extracted from CCI via UCSI_CCI_CONNECTOR() is a
> 7-bit field (0-127) that is used to index into the connector array in
> ucsi_connector_change(). However, the array is only allocated for the
> number of connectors reported by the device (typically 2-4 entries).
> 
> A malicious or malfunctioning device could report an out-of-range
> connector number in the CCI, causing an out-of-bounds array access in
> ucsi_connector_change().
> 
> Add a bounds check in ucsi_notify_common(), the central point where CCI
> is parsed after arriving from hardware, so that bogus connector numbers
> are rejected before they propagate further.
> 
> Fixes: bdc62f2bae8f ("usb: typec: ucsi: Simplified registration and I/O API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>

Did you see this happening on an actual device?

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v4:
>  - Moved bounds check to ucsi_notify_common(), the single point where
>    CCI is parsed after read_cci(), so bogus connector numbers never
>    propagate to ucsi_connector_change() (Greg KH)
>  - Changed dev_warn to dev_err
> v3:
>  - Added changelog (Greg's bot)
> v2:
>  - Kept bounds check in ucsi_connector_change() rather than moving it
>    to ucsi_notify_common() (Greg KH)
> 
>  drivers/usb/typec/ucsi/ucsi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index a7b388dc7fa0..10261992f020 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -42,8 +42,13 @@ void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
>  	if (cci & UCSI_CCI_BUSY)
>  		return;
>  
> -	if (UCSI_CCI_CONNECTOR(cci))
> -		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
> +	if (UCSI_CCI_CONNECTOR(cci)) {
> +		if (UCSI_CCI_CONNECTOR(cci) <= ucsi->cap.num_connectors)
> +			ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
> +		else
> +			dev_err(ucsi->dev, "bogus connector number in CCI: %u\n",
> +				UCSI_CCI_CONNECTOR(cci));
> +	}
>  
>  	if (cci & UCSI_CCI_ACK_COMPLETE &&
>  	    test_and_clear_bit(ACK_PENDING, &ucsi->flags))
> -- 
> 2.43.0.windows.1

-- 
heikki

