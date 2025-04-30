Return-Path: <stable+bounces-139174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B31EAA4E01
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 16:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C743A75EB
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 14:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DFD254848;
	Wed, 30 Apr 2025 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqzK/326"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC23A41;
	Wed, 30 Apr 2025 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746021666; cv=none; b=RUurbtsoJMETDNrcc7D2HqExtYFopM0TAf2bDdvVEADOBA7cFqUdkmrOtHGzei3cNuxDO7EXGTTQECNuUIM+DXPs1JDV483rBNrHyBwRtPAXrIaHV/nz2Xp357RKxRUPOWHfjngfXBWt+fCl9JFIfpCL8an22GOBkZ+489sLN68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746021666; c=relaxed/simple;
	bh=g3mqcDp20GVHB/q8qmntjxUMyBRxr3Pf8u1Ph+O76LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUi5TQktOJgAy2VilPquAt3ZQGDk10dErCoQ5nZDA1Vanp8a5cMs1YhcY3FCRm1o6yLwPwUqBAvz2WN7dBO2ESEFZC29HMzWEAtjnPISWmRXz5+Hn8vAo0uO96sW/+dxWMajy8BZjK4gBC/RoInHj3aegh07HclVIHDmNsFWGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqzK/326; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746021665; x=1777557665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g3mqcDp20GVHB/q8qmntjxUMyBRxr3Pf8u1Ph+O76LE=;
  b=bqzK/3268ZFGtYFzuwoi9cXdO/EytWMah1S/yClKvgk721WV8+3EnZpp
   NEUZlaicR/Rqiic5Zh80KoFdwQ/LcxP6YZPjRJA2EFlEwAYQRPpU0VTTq
   eMeuNTDnupNuzV7/jDBRFMLHhgoD41o9RmZ4n3phuXsaGiAXRx/oLedc5
   r7rqWRXvHiFAq12RnJ2o8vpDJFPvoaW/GwZnG0vCZLq0tQh6dsim4d7wm
   ajfhuhoMxghA0s+2/usbEB6BhYsEuO0w/ajDj2AlDIBP2O4uxZjF1/b52
   R/emDIN4SjYTF7e0LxKsQyLVaGpMOigMrO2FHYDevr4IVCZbdh5RU7JII
   w==;
X-CSE-ConnectionGUID: C2429F9BQIWDcnEJVkT5Yg==
X-CSE-MsgGUID: lra6iO4HRfqbCVsWyJRy+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="47819016"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47819016"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 07:00:55 -0700
X-CSE-ConnectionGUID: 48bfJdwQSDq2dVZ3BtnmQQ==
X-CSE-MsgGUID: glWlL4EiREC8ohwKqQlOFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="157360740"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa002.fm.intel.com with SMTP; 30 Apr 2025 07:00:51 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 30 Apr 2025 17:00:50 +0300
Date: Wed, 30 Apr 2025 17:00:50 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: badhri@google.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: delay SNK_TRY_WAIT_DEBOUNCE to
 SRC_TRYWAIT transition
Message-ID: <aBItEvvt3Pz-FLfD@kuha.fi.intel.com>
References: <20250429234703.3748506-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429234703.3748506-2-rdbabiera@google.com>

On Tue, Apr 29, 2025 at 11:47:01PM +0000, RD Babiera wrote:
> This patch fixes Type-C Compliance Test TD 4.7.6 - Try.SNK DRP Connect
> SNKAS.
> 
> The compliance tester moves into SNK_UNATTACHED during toggling and
> expects the PUT to apply Rp after tPDDebounce of detection. If the port
> is in SNK_TRY_WAIT_DEBOUNCE, it will move into SRC_TRYWAIT immediately
> and apply Rp. This violates TD 4.7.5.V.3, where the tester confirms that
> the PUT attaches Rp after the transitions to Unattached.SNK for
> tPDDebounce.
> 
> Change the tcpm_set_state delay between SNK_TRY_WAIT_DEBOUNCE and
> SRC_TRYWAIT to tPDDebounce.
> 
> Fixes: a0a3e04e6b2c ("staging: typec: tcpm: Check for Rp for tPDDebounce")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 784fa23102f9..87d56ac4565d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -6003,7 +6003,7 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
>  	case SNK_TRY_WAIT_DEBOUNCE:
>  		if (!tcpm_port_is_sink(port)) {
>  			port->max_wait = 0;
> -			tcpm_set_state(port, SRC_TRYWAIT, 0);
> +			tcpm_set_state(port, SRC_TRYWAIT, PD_T_PD_DEBOUNCE);
>  		}
>  		break;
>  	case SRC_TRY_WAIT:
> 
> base-commit: 615dca38c2eae55aff80050275931c87a812b48c
> -- 
> 2.49.0.967.g6a0df3ecc3-goog

-- 
heikki

