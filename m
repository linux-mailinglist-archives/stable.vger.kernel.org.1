Return-Path: <stable+bounces-112029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F14FA25D48
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 15:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69A818860CA
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628C520B1ED;
	Mon,  3 Feb 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8UWC+OS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9E820AF86;
	Mon,  3 Feb 2025 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593612; cv=none; b=NtQuEzYK7TKR8dutAm80HDI5Rk3uMuqQF9OWfO6ZbCPf1WZABbdSpf0wMcQ4B15yiSo6u1hZcWMEMXC1xDs7WrJoXx4jDcBT2BaMV11U4+4PVM9UxHLtVyFKHLB4FTpM2ruVpd1tuPI9iPV7fqBT/q0fgKXx5AA7YC+ZtQcYh/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593612; c=relaxed/simple;
	bh=sKH1aXnuxEee7MJVvCT5D3JVKBFIsXQD/A+depRFcNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3SpKxcX6Xb+wU8sAfc+6+rQX2wCpRKe/cDZb3xb4+fvWg7INxm1fOYuhcGxl5ESOyDE8rcIYVGCBs/TN9I+FFV+BTzsRLmPxSuQNMVlkwHTyiWiQIzmrtpiniIRADpPRy9FzbbDpEe9rnRYfrmJV8/YV0kbyNcsD2VdwEc1pSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8UWC+OS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738593611; x=1770129611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sKH1aXnuxEee7MJVvCT5D3JVKBFIsXQD/A+depRFcNQ=;
  b=c8UWC+OSSpMlmvxpbswY3PAGjBScSWR9m+tmUoIJEtWyiGz1KMh7BlgD
   9Qxll5zkhsBXr4IGXEZAbucHHJhg1DTsivYeG7LRhjzNl5V5JV8A0a+3C
   5nWigJb31KIFFnh63PQbQVnAUDRLUPHTK4rthzuJxKaOVYQ4bTFw+3L5f
   JTXLLu00H8hv9Py/SwBtBVDTdns8LYD/FJ95TaPDbLHoCwMLStHL3okAI
   T3R3XBE9tnXJO+HpGEXKeZ80+oPnkQOTIbl/dGiDAAmo3THtjKKFJUzCI
   4IRPznCuFD2et3smuh1wiuB/NtoHO/hBXHgVY1wYST58oEG8BXYhOUV8J
   Q==;
X-CSE-ConnectionGUID: QxluUkdhS+6NN2LX1fdnzw==
X-CSE-MsgGUID: RAVX1RunR1KYC/IM2fZFfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="38975367"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="38975367"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 06:40:09 -0800
X-CSE-ConnectionGUID: mg8IU7pXTkag/HqWfpmahw==
X-CSE-MsgGUID: zSJ92AH8RA2NhIW4rUAh3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133549091"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa002.fm.intel.com with SMTP; 03 Feb 2025 06:40:06 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 03 Feb 2025 16:40:05 +0200
Date: Mon, 3 Feb 2025 16:40:05 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Elson Roy Serrao <quic_eserrao@quicinc.com>
Cc: gregkh@linuxfoundation.org, xu.yang_2@nxp.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: roles: cache usb roles received during switch
 registration
Message-ID: <Z6DVRbmwB859RlCt@kuha.fi.intel.com>
References: <20250127230715.6142-1-quic_eserrao@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127230715.6142-1-quic_eserrao@quicinc.com>

On Mon, Jan 27, 2025 at 03:07:15PM -0800, Elson Roy Serrao wrote:
> The role switch registration and set_role() can happen in parallel as they
> are invoked independent of each other. There is a possibility that a driver
> might spend significant amount of time in usb_role_switch_register() API
> due to the presence of time intensive operations like component_add()
> which operate under common mutex. This leads to a time window after
> allocating the switch and before setting the registered flag where the set
> role notifications are dropped. Below timeline summarizes this behavior
> 
> Thread1				|	Thread2
> usb_role_switch_register()	|
> 	|			|
> 	---> allocate switch	|
> 	|			|
> 	---> component_add()	|	usb_role_switch_set_role()
> 	|			|	|
> 	|			|	--> Drop role notifications
> 	|			|	    since sw->registered
> 	|			|	    flag is not set.
> 	|			|
> 	--->Set registered flag.|
> 
> To avoid this, cache the last role received and set it once the switch
> registration is complete. Since we are now caching the roles based on
> registered flag, protect this flag with the switch mutex.

Instead, why not just mark the switch registered from the get-go?

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index c58a12c147f4..cf38be82d397 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -387,6 +387,8 @@ usb_role_switch_register(struct device *parent,
        dev_set_name(&sw->dev, "%s-role-switch",
                     desc->name ? desc->name : dev_name(parent));
 
+       sw->registered = true;
+
        ret = device_register(&sw->dev);
        if (ret) {
                put_device(&sw->dev);
@@ -399,8 +401,6 @@ usb_role_switch_register(struct device *parent,
                        dev_warn(&sw->dev, "failed to add component\n");
        }
 
-       sw->registered = true;
-
        /* TODO: Symlinks for the host port and the device controller. */
 
        return sw;


thanks,

-- 
heikki

