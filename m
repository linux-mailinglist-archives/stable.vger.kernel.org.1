Return-Path: <stable+bounces-77858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833C5987DC6
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 07:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FCC2858B2
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 05:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5878E3BBF6;
	Fri, 27 Sep 2024 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mnVyYRIj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE352F2E
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 05:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727413570; cv=none; b=juX71/MB7pHbamVkzXexpQWxTpYzarX4duqA0qiDXPz4YsED80+hSfZqOapQg/gGSDqSsvXBWfIsZVFbW4PAaBPLbkla6RK9hBAkhneHCjDty+S/Rk1xaYq+QRs6B7J6B8YRSIHo3pzJleijSIUCGyaU6M8+1BV8rMcVnuX7XDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727413570; c=relaxed/simple;
	bh=7DG9ugVVIlWqardRzBOxjz105h27Xx9e6QCKyWZpNs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijCwDtHzqLnCHW4DLdDtjfGvBNLOXGbFfL3jRuPz3K3LbKvvb56rbpI4uSsWwsU6Q+2Pj+7IA9Meg6EwnyXl5iYfaMwvis1Lr/FZnidVKifCbkd0CdQ8+62UMusOD+jW3rZf3iSf/z0zM7pIaXNy78fHu+2uYGINbm+diEQKARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mnVyYRIj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727413568; x=1758949568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7DG9ugVVIlWqardRzBOxjz105h27Xx9e6QCKyWZpNs8=;
  b=mnVyYRIj1SVma/WFkjMFtmSBSyB+QrvkwISOd0rNgWCme9QKxp6D7svi
   u/uYt5ic9BLax1SkuSen7TADTzS03G/WSNuB7Wd9AtXMh7v0my8arv+Rj
   CQDE5DP2+zoZtFRaV1xx8/qs2EYfPvuXQ/L7cfEReWkYvddD8/chCjYz+
   2mvqTOf9YfsF93AgQDJkTIAQxt+zmn2wzi7cQSHFlZoCmadG5suW68dsK
   WsC4DS+je/AGCS8Y5oz5Wwx9WzNpwzfV1oEea2n5el3GDUTDeanOOhvem
   ME2RM7kuCC/fqT2orn903MoYxwYVGRrp7TyZdGoIndjYprhvPETA4AcdI
   Q==;
X-CSE-ConnectionGUID: 0ztHByFqTNqymohBLh1MQw==
X-CSE-MsgGUID: TswV6a7OR9Cra9SKEgrxFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37925938"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="37925938"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 22:06:08 -0700
X-CSE-ConnectionGUID: uagVVc4ZTZyIZxTD88oDzw==
X-CSE-MsgGUID: Rsdr0VbZRdmzVOPAZ+NILA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="72397119"
Received: from ellisnea-mobl1.amr.corp.intel.com (HELO desk) ([10.125.147.235])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 22:06:07 -0700
Date: Thu, 26 Sep 2024 22:05:59 -0700
From: Pawan Kumar Gupta <pawan.kumar.gupta@intel.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: stable@vger.kernel.org, x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
	Thomas Lindroth <thomas.lindroth@gmail.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH 6.1.y 2/2] x86/mm: Switch to new Intel CPU model defines
Message-ID: <20240927050548.sy32uuqtfrhho6ti@desk>
References: <20240925150737.16882-1-ricardo.neri-calderon@linux.intel.com>
 <20240925150737.16882-3-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925150737.16882-3-ricardo.neri-calderon@linux.intel.com>

On Wed, Sep 25, 2024 at 08:07:37AM -0700, Ricardo Neri wrote:
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
>   instead of X86_MATCH_VFM() as in the upstream commit.
>   I also kept the ALDERLAKE_N name instead of ATOM_GRACEMONT. Both refer
>   to the same CPU model. ]
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

