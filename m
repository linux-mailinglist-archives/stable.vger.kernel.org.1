Return-Path: <stable+bounces-53656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6089390D7E0
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 17:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCBD2818D8
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A61D299;
	Tue, 18 Jun 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXUf5W8v"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C52F47781;
	Tue, 18 Jun 2024 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726103; cv=none; b=R+WvVP9ZXpPqziv0wHw0FOcZTgfhbC5pKzRNaUkIjqtioCm9SKtHHL4kOR1fSNjfoJ7IRzNezfP/gGjAEGlW7nPM4sSBOO15kR+6nIBrmqP/S/zvDFY+h5NxVrtScgb4yBNZ5SzdIEwDxINSyB8iFMPXRlAX4HSLuJQUTEdZP1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726103; c=relaxed/simple;
	bh=AbYngC2y3FeyfIkgLIgqUDEVOaOEJS0txRykSm0DvXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6gXXhtjv0ljq8WbZ/3G5iAIpv8qiWcpU7D9NjwKd9ugVkY5ILW/9EMH1Qhgo0RiTzmZ9p9N84cwo/IVgnh1pLWVEcgXjUR/WHwZhqEB32fjDkYzb7ahowAPLXKtML1GzYdpvgB+3ppIh0hMKxMC2Y6rgmUkSCHG4w8vVSWu56E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXUf5W8v; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718726101; x=1750262101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AbYngC2y3FeyfIkgLIgqUDEVOaOEJS0txRykSm0DvXo=;
  b=IXUf5W8vpuly1Z8z8HQ6IohV7eDFx4aPjeVDO/DE7Of4QKPGSQTiSbn/
   MJq68M7P7FB/oLm/tynMMqmio9uvaVczBn9XN0b7jgUBb8kzz/T/soZ4o
   gWKN6GzpekBflJ8yqvrE5xza6JCi9rAfcskjNWdRwFGA6TRh7D2tjg5yY
   K6xEBQe30J8S5LXydUpj307kv79P9xop+EFQhNCxTCpiMzGBbjgLQc76G
   8ImNiNySJBLDVGOSoQ0/oplGFP/yszIcLmK+5fmv4pawbJtRWXukU+B8n
   jzh6YRqYBeyAAk9SNJzW4PdCFCwRVQzywplQPMbDDlwEhsXoc0sObWEi5
   Q==;
X-CSE-ConnectionGUID: azf4dOl6SiqmdYsrI6qxzw==
X-CSE-MsgGUID: FsfUOhLKRZS6mBQSbYQ1Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15451351"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15451351"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 08:55:01 -0700
X-CSE-ConnectionGUID: SNHLFOWRS2qBgu6SCAFesQ==
X-CSE-MsgGUID: Ai0kH9RxRWaI53DyAszH2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41699325"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2024 08:54:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 8A7701CB; Tue, 18 Jun 2024 18:54:57 +0300 (EEST)
Date: Tue, 18 Jun 2024 18:54:57 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jian-Hong Pan <jhp@endlessos.org>, stable@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ata: ahci: Do not enable LPM if no LPM states are
 supported by the HBA
Message-ID: <20240618155457.GD1532424@black.fi.intel.com>
References: <20240618152828.2686771-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240618152828.2686771-2-cassel@kernel.org>

On Tue, Jun 18, 2024 at 05:28:29PM +0200, Niklas Cassel wrote:
> LPM consists of HIPM (host initiated power management) and DIPM
> (device initiated power management).
> 
> ata_eh_set_lpm() will only enable HIPM if both the HBA and the device
> supports it.
> 
> However, DIPM will be enabled as long as the device supports it.
> The HBA will later reject the device's request to enter a power state
> that it does not support (Slumber/Partial/DevSleep) (DevSleep is never
> initiated by the device).
> 
> For a HBA that doesn't support any LPM states, simply don't set a LPM
> policy such that all the HIPM/DIPM probing/enabling will be skipped.
> 
> Not enabling HIPM or DIPM in the first place is safer than relying on
> the device following the AHCI specification and respecting the NAK.
> (There are comments in the code that some devices misbehave when
> receiving a NAK.)
> 
> Performing this check in ahci_update_initial_lpm_policy() also has the
> advantage that a HBA that doesn't support any LPM states will take the
> exact same code paths as a port that is external/hot plug capable.
> 
> Side note: the port in ata_port_dbg() has not been given a unique id yet,
> but this is not overly important as the debug print is disabled unless
> explicitly enabled using dynamic debug. A follow-up series will make sure
> that the unique id assignment will be done earlier. For now, the important
> thing is that the function returns before setting the LPM policy.
> 
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

