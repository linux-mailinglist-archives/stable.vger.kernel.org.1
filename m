Return-Path: <stable+bounces-195757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CCBC79541
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D9E3E2DAE0
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE2831578E;
	Fri, 21 Nov 2025 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXxwiBEn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F85275B18
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763731578; cv=none; b=G6LdJ74nLWaI4k2aFt+TpBUzfAGSydH4eATujXy0ZpRHbIcFVX7GAqNzQbh9szbSF/9vLBu5EJMzoeAx/Urlcg9N72XnOWEfHPAOBAVK2n9f6Y9h/j/2KgqYNZE4hlyW2e+Ej70PgbGuXDDayIvnltW/+FQNwEci6hVf5hE3WtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763731578; c=relaxed/simple;
	bh=4BL+lKf7ULGebWHu3izPJ1NnzwRrx6HGgPG7CrdLv00=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sYSHStm7hcz339o5CvCTRv3UcGpS6PlAqFgMP/SyWOYp83GFOHrtBknRU8yS2CIM5Gj57dZkir0hZprk/e3MVlGg8PXV/x0dwL8n7K5vLFezcgrouhshLX4XxNZUfimwUSJZaz6iQZMLzrliEs3wLHJSr7VweOM0JXVagf7kGG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXxwiBEn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763731577; x=1795267577;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=4BL+lKf7ULGebWHu3izPJ1NnzwRrx6HGgPG7CrdLv00=;
  b=IXxwiBEnBtE3LEc9Q/8/dVMMUis+aJ3/RhqUfRxwalQWgCHAwp8MfNXM
   EaV3xfWjhgtBw4Zb4eAYi/+72gxhJ2945p6MbLn30QskUFNYdLXFaQWAH
   6sqrIXZruRnl6FnRjwpe77bW2K/uOhTaoi3G8ofQcfHPR/HNriEmdwbEA
   N4kl1s12dXG+mGOaQCpq52q1sRVso5RYxRpPE+iu9ODBVb4k5+JlnoM0B
   luQc1NZZguxEy4Mc5IiTzNAl7e8n9P0yq5KdaldLsOzJlUimui0oxrjvB
   0lmdWQYOW0dgy2EHEMJ/YgFdhWmmr6TEcguYq7btU99ET7fwqng94V/AX
   g==;
X-CSE-ConnectionGUID: FwFe0Om6Ryad4FLW8AWLxQ==
X-CSE-MsgGUID: yafik0YuRwa79K0lNcQFDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="65716131"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="65716131"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 05:26:13 -0800
X-CSE-ConnectionGUID: GC9AI9hZRtOmEHZJVj90ag==
X-CSE-MsgGUID: LS6lJiVxTBOi8s/sImZNhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="191943745"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 21 Nov 2025 05:26:12 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMR9N-0005Sl-1V;
	Fri, 21 Nov 2025 13:26:09 +0000
Date: Fri, 21 Nov 2025 21:25:49 +0800
From: kernel test robot <lkp@intel.com>
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH REGRESSION] drm/panel: simple: restore connector_type
 fallback
Message-ID: <aSBoXXd1ScfCb-k_@068db44eb137>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-lcd_panel_connector_type_fix-v1-1-fdbbef34a1a4@microchip.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH REGRESSION] drm/panel: simple: restore connector_type fallback
Link: https://lore.kernel.org/stable/20251121-lcd_panel_connector_type_fix-v1-1-fdbbef34a1a4%40microchip.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




