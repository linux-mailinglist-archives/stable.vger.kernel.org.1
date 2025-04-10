Return-Path: <stable+bounces-132052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F286A83A25
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 09:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627333A4417
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 07:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654D92045B0;
	Thu, 10 Apr 2025 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RuCnp06g"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D7149C64;
	Thu, 10 Apr 2025 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268519; cv=none; b=sVTCnbSgXIDdEnxeSN8XBnBXJQTwps6EquPMps7RyolKbWf9OBjdRdZjneEhLOhqjl2jhs9CCAVoq4ShX+kiHAa2bbYbQbxORpZV6MCgHrPTdEM8COwWk4oGVE0HzzR2SeNh3rvgFsC0hFfKamLfLpj7D+KJh8RDp+lVlKEQCRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268519; c=relaxed/simple;
	bh=zHlYfQlrxyymELBdT3nt68TftPQdeCqaB7PkmJdxb/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB7wYpqk1Zc/Sh2zUIoDiSsbNGqfOJAa3QoPWpvscas1z4zp7KWBkWnhVqxuwHLHA4QdffzJoqnNxcEB0fCIK901rINtUbqoMr932aglDoYSz+QPrDQfuetLwYPw+6eNxBdDlaOjh2SO4f6Fd+e0PrLEFcjTz9o1GIxZvlICvRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RuCnp06g; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744268518; x=1775804518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zHlYfQlrxyymELBdT3nt68TftPQdeCqaB7PkmJdxb/o=;
  b=RuCnp06glTRc3ZcUcLjRe7wr21t1Rwi0eSyOcqp5MklcWnhvPEzG1P4J
   4wP5JZM0/KtjbLm6Kze1dMaD9Igd8o0z3XfJEmnWX0RbofZsOnnGXWW7p
   Ydvp0o5MEIM0dG8hlVeYpxfzkk7DUPOvJzfvCatgawfhoYERKJ1RFOOAI
   PWnXH4C+V6IsQN2gLU+2UictvRY59+Zqp3nO/bEghBPGmD9A7dPH7nLmd
   ZLLxPvGc2tcHwLDlz0OttCnik5pWgB4Pyjy4qBtE1Zn1uz7uUe2EAUI42
   ngYkMpGbH0Aost5Y30lhslQS7nun8nzYYRrccn4alOxKQzBsll2tja2sA
   g==;
X-CSE-ConnectionGUID: cnch46QITg+eiFvNww3osA==
X-CSE-MsgGUID: kikJG05uSlu1SYFHYfUz6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="44909888"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="44909888"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 00:01:45 -0700
X-CSE-ConnectionGUID: 9+RHSVYzTCyZc4pdL/oUcw==
X-CSE-MsgGUID: EWWSfkBTTDOXwPNjVO6HdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="166026088"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa001.jf.intel.com with SMTP; 10 Apr 2025 00:01:40 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 10 Apr 2025 10:01:39 +0300
Date: Thu, 10 Apr 2025 10:01:39 +0300
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
Subject: Re: [PATCH 1/2] usb: typec: ucsi: displayport: Fix deadlock
Message-ID: <Z_ds09xFjwedjTam@kuha.fi.intel.com>
References: <20250409140221.654892-1-akuchynski@chromium.org>
 <20250409140221.654892-2-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409140221.654892-2-akuchynski@chromium.org>

Hi Andrei,

> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1922,6 +1922,42 @@ void ucsi_set_drvdata(struct ucsi *ucsi, void *data)
>  }
>  EXPORT_SYMBOL_GPL(ucsi_set_drvdata);
>  
> +/**
> + * ucsi_con_mutex_lock - Acquire the connector mutex
> + * @con: The connector interface to lock
> + *
> + * Returns true on success, false if the connector is disconnected
> + */
> +bool ucsi_con_mutex_lock(struct ucsi_connector *con)
> +{
> +	bool mutex_locked = false;
> +	bool connected = true;
> +
> +	while (connected && !mutex_locked) {
> +		mutex_locked = mutex_trylock(&con->lock) != 0;
> +		connected = UCSI_CONSTAT(con, CONNECTED);
> +		if (connected && !mutex_locked)
> +			msleep(20);
> +	}
> +
> +	connected = connected && con->partner;
> +	if (!connected && mutex_locked)
> +		mutex_unlock(&con->lock);
> +
> +	return connected;
> +}
> +EXPORT_SYMBOL_GPL(ucsi_con_mutex_lock);
> +
> +/**
> + * ucsi_con_mutex_unlock - Release the connector mutex
> + * @con: The connector interface to unlock
> + */
> +void ucsi_con_mutex_unlock(struct ucsi_connector *con)
> +{
> +	mutex_unlock(&con->lock);
> +}
> +EXPORT_SYMBOL_GPL(ucsi_con_mutex_unlock);

No need to export these.

thanks,

-- 
heikki

