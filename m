Return-Path: <stable+bounces-132054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A19BA83A3C
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 09:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF4D3B9065
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 07:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEC22045B0;
	Thu, 10 Apr 2025 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D96wDNDD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B35013C695;
	Thu, 10 Apr 2025 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268610; cv=none; b=VmbXjWpEH1FF9QvE4BqRtd66lQqPn1FHbMHqfyL7FitsEUbuUW80sjOc+xGleuChoaYE2FNbIm9xhiuSaV+fD95tSXD1Z7UPvM+k0Nuq+e8dt4vXjXaxbvN1V2b2WrMcsqY2n5hNFdOwk41Gsberj2pOaZMKgmPpurnJ/fyYXZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268610; c=relaxed/simple;
	bh=FVby0+BSV/HJscXR64y9WYo8HylnPf4XR+uLKGaVPnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAVe28n5Z4CJ4JO7t+HTIrSE85X7opxFwSBzXHZc/YvtnFnGZhAXHLbL2ptawXGJmWasZLgHfgnJrqAvS0bcjdk+fC69oJMrklmTDZrTOujrMvDKhb/uIx6+yn2BQwf1ECH5fcByzLhvVH/QJzqSljTsdMfNiOXsKX5wwEZOuAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D96wDNDD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744268608; x=1775804608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FVby0+BSV/HJscXR64y9WYo8HylnPf4XR+uLKGaVPnw=;
  b=D96wDNDDYAOCOACjZYszoHvBwZeL1DQsDdKchmkgvLSIwVkjyA7qzSmz
   yx8GuNoIHWeGNfIAsLdfUsKJSa6c95ju3zku6slcGAXcDon71SDbYjS24
   MhnmSTPPS0fD37EbWzIQVogOFe4WVu9sXHX7Rvl1HuSVnRSTp/HlJz7b+
   O2JOHfMCPVHY3wsz3jcyBnJaJ/4g03kBDricef/wsXeaXqkZZqbzT1G+v
   xzXX6R3yUHo0/9R7h549wbSlkbSwtecxO8w9nJ2AP0NhIgVRKp/G7HFMS
   kxt45b/0FXnzaoaX+KRkKq6eZrd7MuR4zb/7jChv/NKWErnX+uoMywipl
   Q==;
X-CSE-ConnectionGUID: 40BINLxoTLq8htQ3uGazUA==
X-CSE-MsgGUID: ngHBJuJ+RqiZMtmcVd+Ybw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45012248"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="45012248"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 00:03:27 -0700
X-CSE-ConnectionGUID: b/X7YN5qTi6ENUZFHt1/xQ==
X-CSE-MsgGUID: htCv+A0lTeKYqT6ow3V3Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="128674393"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa006.fm.intel.com with SMTP; 10 Apr 2025 00:03:23 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 10 Apr 2025 10:03:22 +0300
Date: Thu, 10 Apr 2025 10:03:22 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Madhu M <madhu.m@intel.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: ucsi: displayport: Fix NULL pointer
 access
Message-ID: <Z_dtOnM0wCOeXxZC@kuha.fi.intel.com>
References: <20250409140221.654892-1-akuchynski@chromium.org>
 <20250409140221.654892-3-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409140221.654892-3-akuchynski@chromium.org>

On Wed, Apr 09, 2025 at 02:02:21PM +0000, Andrei Kuchynski wrote:
> This patch ensures that the UCSI driver waits for all pending tasks in the
> ucsi_displayport_work workqueue to finish executing before proceeding with
> the partner removal.
> 
> Cc: stable@vger.kernel.org
> Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/displayport.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
> index acd053d4e38c..8aae80b457d7 100644
> --- a/drivers/usb/typec/ucsi/displayport.c
> +++ b/drivers/usb/typec/ucsi/displayport.c
> @@ -299,6 +299,8 @@ void ucsi_displayport_remove_partner(struct typec_altmode *alt)
>  	if (!dp)
>  		return;
>  
> +	cancel_work_sync(&dp->work);
> +
>  	dp->data.conf = 0;
>  	dp->data.status = 0;
>  	dp->initialized = false;
> -- 
> 2.49.0.504.g3bcea36a83-goog

-- 
heikki

