Return-Path: <stable+bounces-158347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB0FAE5FB9
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 10:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9102A3B1F01
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 08:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF1626B0BC;
	Tue, 24 Jun 2025 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHVl1BJw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C50D1C84DF;
	Tue, 24 Jun 2025 08:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754637; cv=none; b=fxNSuk8b4xixRh4JgtKsBF1BasOsjfAy+qj/POrrjaA9ks/jbhwoM/pT8hhKeikJKbOb2PjhdtO6raJA9oXN2bXw6Kf2IswtboRVExBP7eAgYyBdGWDMPh7Gu39qREXNOiCIfZKts5cBnwI3RY/7jbOdgnr6gEo1iqZhvEfkHKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754637; c=relaxed/simple;
	bh=L45NXoZ+NSjgNfFv1Uc2lmPuDY4v3Gli3c8yBbV7E7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh/UQfgq51SPSYM+Yk+o84rGWZdwEI9mQPAHVZxRHdc5eClEN2go+tZF+SKb4Q5OAcF7Jfr6oiqeoAWZ+yCa6vUb0uAC1aGiBxpykWqO+hfJsbMKVnQ/zqUmrtvh7Il971A0y8rNp3KUu1Vq2+5d/eDHPf9PbYJgK5aiZbO1Z0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHVl1BJw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750754636; x=1782290636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L45NXoZ+NSjgNfFv1Uc2lmPuDY4v3Gli3c8yBbV7E7w=;
  b=XHVl1BJwW5fEfgTbW2fjpBy7RTiwWYDE//WvYkQo7Ljhxv83Ib83MQs/
   Ol98vf60KqIfIR5ZEKJs/iSSqN8Lahf7ZSoFYFb3oVCl20eljDtZdT7Fx
   ncNxKIrqNvANmDpklC1n07ATLhX+MqX7+Z94xVYwY+9LLaZBo4lCXl42w
   f04vQ3F7hU28rPOPz/TbaVuXlMI7elCaaiUr7iPtj7B8Es4g8XviAKkyC
   DQSZmjV070ah/N/dO4YlKMcZKwXWG4gpoTvOJsam2fCc9QE+dm8w784AW
   dadPDuy5p10IxZk1l5rhQFl6Soqwe6eKpBDhRMF9hjT3QK1LeoT2ZcgTL
   g==;
X-CSE-ConnectionGUID: tldknDeiRs21TRzIeNvquA==
X-CSE-MsgGUID: AF+S4X9aTN2CQrIyUCGxrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52214092"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="52214092"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:43:56 -0700
X-CSE-ConnectionGUID: 2vYRGkSnQs618htWM63nfA==
X-CSE-MsgGUID: OmmttEKCRhOgi6grzXo9MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="152023769"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa007.jf.intel.com with SMTP; 24 Jun 2025 01:43:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 24 Jun 2025 11:43:51 +0300
Date: Tue, 24 Jun 2025 11:43:50 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: badhri@google.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: altmodes/displayport: do not index
 invalid pin_assignments
Message-ID: <aFplRgD8nju9ShAO@kuha.fi.intel.com>
References: <20250618224943.3263103-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618224943.3263103-2-rdbabiera@google.com>

On Wed, Jun 18, 2025 at 10:49:42PM +0000, RD Babiera wrote:
> A poorly implemented DisplayPort Alt Mode port partner can indicate
> that its pin assignment capabilities are greater than the maximum
> value, DP_PIN_ASSIGN_F. In this case, calls to pin_assignment_show
> will cause a BRK exception due to an out of bounds array access.
> 
> Prevent for loop in pin_assignment_show from accessing
> invalid values in pin_assignments by adding DP_PIN_ASSIGN_MAX
> value in typec_dp.h and using i < DP_PIN_ASSIGN_MAX as a loop
> condition.
> 
> Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/altmodes/displayport.c | 2 +-
>  include/linux/usb/typec_dp.h             | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index b09b58d7311d..773786129dfb 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -677,7 +677,7 @@ static ssize_t pin_assignment_show(struct device *dev,
>  
>  	assignments = get_current_pin_assignments(dp);
>  
> -	for (i = 0; assignments; assignments >>= 1, i++) {
> +	for (i = 0; assignments && i < DP_PIN_ASSIGN_MAX; assignments >>= 1, i++) {
>  		if (assignments & 1) {
>  			if (i == cur)
>  				len += sprintf(buf + len, "[%s] ",
> diff --git a/include/linux/usb/typec_dp.h b/include/linux/usb/typec_dp.h
> index f2da264d9c14..acb0ad03bdac 100644
> --- a/include/linux/usb/typec_dp.h
> +++ b/include/linux/usb/typec_dp.h
> @@ -57,6 +57,7 @@ enum {
>  	DP_PIN_ASSIGN_D,
>  	DP_PIN_ASSIGN_E,
>  	DP_PIN_ASSIGN_F, /* Not supported after v1.0b */
> +	DP_PIN_ASSIGN_MAX,
>  };
>  
>  /* DisplayPort alt mode specific commands */
> 
> base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
> -- 
> 2.50.0.rc2.701.gf1e915cc24-goog

-- 
heikki

