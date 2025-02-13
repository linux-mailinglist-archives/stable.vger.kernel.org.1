Return-Path: <stable+bounces-115147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9150CA34137
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527153A5067
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ECE22170A;
	Thu, 13 Feb 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2tvBoQ2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CA821D3E2;
	Thu, 13 Feb 2025 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455106; cv=none; b=pq87kIozWLIjSabLfEGRnmNvK9+qjXqLmSPF4Z6cHrMv2+RRw5BEIHK6yPvg9L1jbX7HauxUkrj2CVhoZFDU3v+4jpAN4nrlwg0m+gMthSxtoTKz0LVvBAQeiY9wGRRfAjnuCu04nUwKuI7cxMhWYq4zAPTh4PsiHQp5NW0VEXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455106; c=relaxed/simple;
	bh=cWTP3mIm51t7PN0mcXoRdd1yxkp6VaJwokjt7+D96Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjQxdeKp6Vo4J4dZJ2fkRF9GD+RMhTiwjmEFG4BZCTjfSrIUgcyELI5o7QLyHYN9S/GCFyLLMNeCKtsgt07GkZaewUWcpXiRJkp6KsPnOHOmKgoHnrb9KCbtSidCF0y4vYwwln5gKvUIoy3joAA46eeG/7vB2sSjK3PZlQJk6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2tvBoQ2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739455105; x=1770991105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cWTP3mIm51t7PN0mcXoRdd1yxkp6VaJwokjt7+D96Yw=;
  b=W2tvBoQ2uHGHcuubhSbFAxZtl6xXy7jV1euffhQiCht/95fSDz3CByWZ
   5EnRuwv6zFPhnlQNFXqaB/uQ+zfEjNdcSlGG+Qpvq2bGAjEdHViUosGru
   6ImQGheljB/VYznZ3NdJeTyKHIn0AKoRKwq6V+XMz/0J3+N4gxlOCA852
   boPkUDEr0bdUMptFbyT+Kcn3lfscBGmqjSM0I8amDMtdRAVvYZcYoxTwI
   GwZmOrZhYssE0yFnITm0o2j1zadvYhTDigM20GN/51MpB+/z2G+hLJf9E
   p3SBhXnb5EMjbLjv+1Qzy5ElY/AfUaoi5CXMaptMqZdIEnNHXZ6Qg5ToP
   g==;
X-CSE-ConnectionGUID: Ih5pRCYtRaSyaUm53nG8MQ==
X-CSE-MsgGUID: QYvM81YySBaok5eS0eT8Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="50802881"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="50802881"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:58:24 -0800
X-CSE-ConnectionGUID: gW+iue03QJSLTldzvY4IqQ==
X-CSE-MsgGUID: BwWktHwtRHymN44ATEq/uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144097026"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa001.fm.intel.com with SMTP; 13 Feb 2025 05:58:20 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 13 Feb 2025 15:58:19 +0200
Date: Thu, 13 Feb 2025 15:58:19 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Fedor Pchelkin <boddah8794@gmail.com>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Saranya Gopal <saranya.gopal@intel.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mark Pearson <mpearson@squebb.ca>,
	stable@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] usb: typec: ucsi: increase timeout for PPM reset
 operations
Message-ID: <Z636e6Vdr4FC7HbQ@kuha.fi.intel.com>
References: <20250206184327.16308-1-boddah8794@gmail.com>
 <20250206184327.16308-3-boddah8794@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206184327.16308-3-boddah8794@gmail.com>

On Thu, Feb 06, 2025 at 09:43:15PM +0300, Fedor Pchelkin wrote:
> It is observed that on some systems an initial PPM reset during the boot
> phase can trigger a timeout:
> 
> [    6.482546] ucsi_acpi USBC000:00: failed to reset PPM!
> [    6.482551] ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed
> 
> Still, increasing the timeout value, albeit being the most straightforward
> solution, eliminates the problem: the initial PPM reset may take up to
> ~8000-10000ms on some Lenovo laptops. When it is reset after the above
> period of time (or even if ucsi_reset_ppm() is not called overall), UCSI
> works as expected.
> 
> Moreover, if the ucsi_acpi module is loaded/unloaded manually after the
> system has booted, reading the CCI values and resetting the PPM works
> perfectly, without any timeout. Thus it's only a boot-time issue.
> 
> The reason for this behavior is not clear but it may be the consequence
> of some tricks that the firmware performs or be an actual firmware bug.
> As a workaround, increase the timeout to avoid failing the UCSI
> initialization prematurely.
> 
> Fixes: b1b59e16075f ("usb: typec: ucsi: Increase command completion timeout value")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <boddah8794@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 0fe1476f4c29..7a56d3f840d7 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -25,7 +25,7 @@
>   * difficult to estimate the time it takes for the system to process the command
>   * before it is actually passed to the PPM.
>   */
> -#define UCSI_TIMEOUT_MS		5000
> +#define UCSI_TIMEOUT_MS		10000
>  
>  /*
>   * UCSI_SWAP_TIMEOUT_MS - Timeout for role swap requests
> -- 
> 2.48.1

-- 
heikki

