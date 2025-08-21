Return-Path: <stable+bounces-171950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E255B2EF1A
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 09:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41F537AA176
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 07:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A36279DC0;
	Thu, 21 Aug 2025 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5ezfTYU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA431E7C12;
	Thu, 21 Aug 2025 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760271; cv=none; b=mXCVniVZV+XhvUksrVHSYgeOxiOuh878yuGsHJyrpImzGoo2YeKIenJypSW6eLjQtZJ8BtS3haX3+RKAiyrCJPjYWob+MVkFNk1BVKb6eT/az30sDEfsOrTQ384IXLL3UqO1mvtF8aWZa+yuIEMUI2iDoY2ii2iTFAclhfOzXbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760271; c=relaxed/simple;
	bh=OUn2H5750HvrMtA7wkc7vbkYR2d2MeCJuYsZZvXJOB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQV/QE586pBB9fM3+BUplLLwVd00ORQzzits/jfD2/Fhp0p0QisfB/6iZqIglIvABHfGcJbmgjB0yfqQOasugyQVd2JB/fyAjWsmm1qpRl1dl2JLQ6r1jJiFPR5RrCJ4mADjxQu2NaWNPe5YJZoZCUz7PPuhLlyzw9vBxirg3gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5ezfTYU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755760270; x=1787296270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OUn2H5750HvrMtA7wkc7vbkYR2d2MeCJuYsZZvXJOB4=;
  b=e5ezfTYUq27U/PzS1XPEvel5waeBuv78OgCHwS7Om1lA7BG4odnCDZCa
   jgmPqtGKdtwHXb1D4SwfR3K46tgnSKecbJxx6wIkHEuDwKNYbejOD/Wzn
   WbUBq8QnVJWt/oCIStRPvtSKs7Fe9ZnHlg0vanSq8zZ7Sh8nLJl9qzP0J
   d36z9GLWhGDbGcuJgyQ5ksx8BfcC9bIj4wWUkiRjGCrEi8C69oi7rZhx0
   mT2bRwg2XPQ3tuTQqyRJupW/2HMmzACbM2q3ZSDAibIU1VOeaqbz9cabK
   cy5pbDQNVyYN+/Wkm01nxkTiGuic94HPvawbTjG+ECV9TcdbeeDsyMhYT
   A==;
X-CSE-ConnectionGUID: BNAVKzZARiWgt1d2WXZ6dg==
X-CSE-MsgGUID: BE/5ZXugRd+t4+Pei8qQQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61678741"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61678741"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 00:11:10 -0700
X-CSE-ConnectionGUID: OlO3aYLHTdOuly0hquwMZg==
X-CSE-MsgGUID: wmLH5BeDSTiVvUVSelVnwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168591804"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa008.jf.intel.com with SMTP; 21 Aug 2025 00:11:06 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 21 Aug 2025 10:11:04 +0300
Date: Thu, 21 Aug 2025 10:11:04 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: amitsd@google.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: [PATCH v2 1/2] usb: typec: maxim_contaminant: disable low power
 mode when reading comparator values
Message-ID: <aKbGiLh2FrCM4dLk@kuha.fi.intel.com>
References: <20250815-fix-upstream-contaminant-v2-0-6c8d6c3adafb@google.com>
 <20250815-fix-upstream-contaminant-v2-1-6c8d6c3adafb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-fix-upstream-contaminant-v2-1-6c8d6c3adafb@google.com>

On Fri, Aug 15, 2025 at 11:31:51AM -0700, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
> 
> Low power mode is enabled when reading CC resistance as part of
> `max_contaminant_read_resistance_kohm()` and left in that state.
> However, it's supposed to work with 1uA current source. To read CC
> comparator values current source is changed to 80uA. This causes a storm
> of CC interrupts as it (falsely) detects a potential contaminant. To
> prevent this, disable low power mode current sourcing before reading
> comparator values.
> 
> Fixes: 02b332a06397 ("usb: typec: maxim_contaminant: Implement check_contaminant callback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/maxim_contaminant.c | 5 +++++
>  drivers/usb/typec/tcpm/tcpci_maxim.h       | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
> index 0cdda06592fd3cc34e2179ccd49ef677f8ec9792..818cfe226ac7716de2fcbce205c67ea16acba592 100644
> --- a/drivers/usb/typec/tcpm/maxim_contaminant.c
> +++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
> @@ -188,6 +188,11 @@ static int max_contaminant_read_comparators(struct max_tcpci_chip *chip, u8 *ven
>  	if (ret < 0)
>  		return ret;
>  
> +	/* Disable low power mode */
> +	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL,
> +				 FIELD_PREP(CCLPMODESEL,
> +					    LOW_POWER_MODE_DISABLE));
> +
>  	/* Sleep to allow comparators settle */
>  	usleep_range(5000, 6000);
>  	ret = regmap_update_bits(regmap, TCPC_TCPC_CTRL, TCPC_TCPC_CTRL_ORIENTATION, PLUG_ORNT_CC1);
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
> index 76270d5c283880dc49b13cabe7d682f2c2bf15fe..b33540a42a953dc6d8197790ee4af3b6f52791ce 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.h
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
> @@ -21,6 +21,7 @@
>  #define CCOVPDIS                                BIT(6)
>  #define SBURPCTRL                               BIT(5)
>  #define CCLPMODESEL                             GENMASK(4, 3)
> +#define LOW_POWER_MODE_DISABLE                  0
>  #define ULTRA_LOW_POWER_MODE                    1
>  #define CCRPCTRL                                GENMASK(2, 0)
>  #define UA_1_SRC                                1
> 
> -- 
> 2.51.0.rc1.167.g924127e9c0-goog
> 

-- 
heikki

