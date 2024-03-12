Return-Path: <stable+bounces-27448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0378791FE
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 11:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD36B21F9C
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 10:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D115D79951;
	Tue, 12 Mar 2024 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfY1nhLE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE42A7866E;
	Tue, 12 Mar 2024 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239153; cv=none; b=Sv03bagob6qO1mELs/AhF6X+0Yc5lq8nQDxz1nM7kQ7QFcbb8c/ZY+k3DUKg99UpJqH/j6nawG5a5FUZsiUdbs+bXtyr/K6Xjn9X9qXmo55wSHOT7YxAH/++l6J2yUeh2FBZ/I0CufjYwJlT1dB66oXHyJsinMkUcdasNM7OjiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239153; c=relaxed/simple;
	bh=yVbtnGd7cVpE1zYrduNyO3abprCLSPjTD1pz5lqvkYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5G5/MGVuQ6wBdGlcYSjq1myxQdd04fLFUYzmvz+W3f4LLeE3+P0ifRT26+DlcpowuYWCG0zGZXZC1Mp5f2pypOlS4uhRbBYIYY1EuESYm0mQvM+2QKryQiA3/1TU43GXf3yaqFCSJ5VbAzSv7eg4Mglryt9rsLVR2rANTU/ruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfY1nhLE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710239152; x=1741775152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yVbtnGd7cVpE1zYrduNyO3abprCLSPjTD1pz5lqvkYU=;
  b=JfY1nhLEkk40LcwZ8i+ACmiySoJ+Jex/w3RmsLVRWwFoR58o45Q45kSP
   pgskEKA9nLyXXbNIim58AnvbabkBV/U5T0ImhTELUBYHv+UstNnhupUH8
   DoMQY8BooV6D1qYWU8hrgmE7ocil14AlkWouUW7feATpIedScRVVs0slv
   pWNDOEM+vVJT1dyWqh1UpDVnGhaQqG9H1IcQEwxCKUJRh5DuxRczZA/Zd
   53OxfQ1lgbTWOyUQ0ieJjjjrbxxWXCfAfDrM/UiG03fmJ6MRkBoRQq2h6
   Vg5iuL6+EamqD3z/RkKd1OeDTJiA9a45WOoLkPsBMXVq93N44XCZkBrvb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4795372"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4795372"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 03:25:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="937051640"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="937051640"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Mar 2024 03:25:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Mar 2024 12:25:47 +0200
Date: Tue, 12 Mar 2024 12:25:47 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Kyle Tso <kyletso@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Update PD of Type-C port upon pd_set
Message-ID: <ZfAtq5TS5Ykqscej@kuha.fi.intel.com>
References: <20240311172306.3911309-1-kyletso@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311172306.3911309-1-kyletso@google.com>

On Tue, Mar 12, 2024 at 01:23:06AM +0800, Kyle Tso wrote:
> The PD of Type-C port needs to be updated in pd_set. Unlink the Type-C
> port device to the old PD before linking it to a new one.
> 
> Fixes: cd099cde4ed2 ("usb: typec: tcpm: Support multiple capabilities")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Tso <kyletso@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3d505614bff1..896f594b9328 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -6907,7 +6907,9 @@ static int tcpm_pd_set(struct typec_port *p, struct usb_power_delivery *pd)
>  
>  	port->port_source_caps = data->source_cap;
>  	port->port_sink_caps = data->sink_cap;
> +	typec_port_set_usb_power_delivery(p, NULL);
>  	port->selected_pd = pd;
> +	typec_port_set_usb_power_delivery(p, port->selected_pd);
>  unlock:
>  	mutex_unlock(&port->lock);
>  	return ret;
> -- 
> 2.44.0.278.ge034bb2e1d-goog

-- 
heikki

