Return-Path: <stable+bounces-77859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0897F987DCF
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 07:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C421C21EE4
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 05:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC6117107F;
	Fri, 27 Sep 2024 05:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUVN0hw3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F14971750
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 05:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727414472; cv=none; b=kBvfC5y5u5vyVzc8oEMQKaLe7On/IgbU4aJMhewfVXGeV6WGN43g84gDUtjqOsnd3KRqyO6LbRJEgJ4b+bzi4x5WMrgGUyi47cD9SpvgPRycPNKWhROvX1gmf41XkCrs0sePt+sJ9IDu2hYAJQCAmzC0LnIKUYaOTUX5Ocq7YJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727414472; c=relaxed/simple;
	bh=8/T5x5NxEfLuW+tyQ8VIMLwh4aX1YQjkYZw3kBL+eTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uksVmk4ve83sC6+xzlcvAtQ9jmgOw5Uihl0Vqv+Q90DVFk8B0JxhHZdz5mu0fTneYONjwd+noqz5M5Tem9sHQWDNPsSiaI6co3XxpAXYlZ2DN3IhDhnF9s6DExuP58hPvyOJyUoWYwD78ATpFNimJgzZdZ6ucvlNgMNrJkDhmTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUVN0hw3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727414471; x=1758950471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8/T5x5NxEfLuW+tyQ8VIMLwh4aX1YQjkYZw3kBL+eTA=;
  b=jUVN0hw3B0FTPo9V1rveoZ91BmFFCXYoJ+MLzKR1uk/0YdUUOQ5fx5/G
   56eSGqIpdYagXXgjsQbir9N6IAMB8uf1WqLN2ODTrkG7sAI69Gak6EXPD
   vAwXTTL4lyJWAWbPdI2SLqowgUcBOrzRdwHKDR9y214gcrl989oQjoC3x
   Zo9VnYU22Oq/KjsrVBbOiQdK5SC8vwT5xJThLPgmUET+TmDTcTSFXmoBG
   kZxSZmthFdCYRsXACiTj6dVgFaJHaGTuh2LF67edlopo6HNDHWFRKIWMe
   sa6Fe3tMQlOiakK9J6Ns/ulQWzIfe/20DBww8jYL4T7k4H/6pyFreQwiS
   Q==;
X-CSE-ConnectionGUID: a8QiYu0PQKWQDJJqmSkUrA==
X-CSE-MsgGUID: 2wLDC+zCRVuoV+0N1OzNPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="30260891"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="30260891"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 22:21:10 -0700
X-CSE-ConnectionGUID: iyOlb4dgQLGFnh2SBevnBg==
X-CSE-MsgGUID: iTt4mo2iRZ+Bw/q2ZNlzOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="77358285"
Received: from ellisnea-mobl1.amr.corp.intel.com (HELO desk) ([10.125.147.235])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 22:21:10 -0700
Date: Thu, 26 Sep 2024 22:21:03 -0700
From: Pawan Kumar Gupta <pawan.kumar.gupta@intel.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: stable@vger.kernel.org, x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Thomas Lindroth <thomas.lindroth@gmail.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH 6.6.y] x86/mm: Switch to new Intel CPU model defines
Message-ID: <20240927052103.7jvwfwq446wv5r2q@desk>
References: <20240925035857.15487-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925035857.15487-1-ricardo.neri-calderon@linux.intel.com>

On Tue, Sep 24, 2024 at 08:58:57PM -0700, Ricardo Neri wrote:
> From: Tony Luck <tony.luck@intel.com>
> 
> [ Upstream commit 2eda374e883ad297bd9fe575a16c1dc850346075 ]
> 
> New CPU #defines encode vendor and family as well as model.
> 
> [ dhansen: vertically align 0's in invlpg_miss_ids[] ]
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/all/20240424181518.41946-1-tony.luck%40intel.com
> [ Ricardo: I used the old match macro X86_MATCH_INTEL_FAM6_MODEL()
>   instead of X86_MATCH_VFM() as in the upstream commit. ]
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

