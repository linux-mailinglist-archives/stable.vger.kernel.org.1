Return-Path: <stable+bounces-133028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55003A91A80
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE155A6928
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1874F23A986;
	Thu, 17 Apr 2025 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uzrf8IgZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED06023A988;
	Thu, 17 Apr 2025 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888715; cv=none; b=B7hf7ogQL7Y0Pxg1pe/gja5VcT8mkSyf9BfScBIxqGPdI3rwduvRqur7FfrhGdJgjyFF73wQH6H9sZLvUpUjOi6kpQWQAByy18YdSKnPuZmLktnTdUy0bvu5SLg1/m54heSsKkPnMTs5d10o6MABu/Qp1kOzVLKTdFHYsblmwJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888715; c=relaxed/simple;
	bh=tBsxo/PDtpgeu7MYr3/jGImFHyNDSg/NlgywZf6lq0U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oVYNwi1RRi458e+LGBuFgEtwILeEfXjjPPm7Ydgz5MBJEknxbKZ4mPH0r3+8gN0sk5fAcEQ0dMkUk+EG8L9djOThUFDzkImk96QwTonjrKDykuv+MIth/nz7Ed7uh3T78DE4Ide19qfMEHCLt4FkwxN0ouYDoYclSbfbceqFDyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uzrf8IgZ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744888714; x=1776424714;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=tBsxo/PDtpgeu7MYr3/jGImFHyNDSg/NlgywZf6lq0U=;
  b=Uzrf8IgZf2FZBzxxkxFtkr6++L8rPtGgEJtVIiNUOD5BkCuRCmor6KCq
   vNkUxp5cXCz5jyh9Z40yU4aJTdeXer1VgzNvp8w2+GzAY7WdPh03qudFS
   rOaLvFTYcl7ktcw+hl76a8SO9jpJ8R+vlsnjQjgFVkZ+2CIpURyAh/31g
   rSAEJ0PXOYOMUDIcBwo4x2Iv199v/gyYdAR24YCKGc0+85GlitE7qPQal
   FzL1oNonPsFdXKjzdE+Vg+hT1Rmrrhe7QPk+Dmo91FdrCRVeLzzP8a9tn
   /lMwjpWui7xXEUuc+hF2GRt3ON3APoKr2ktRC6PM6hxD7I6rkknlspyqx
   Q==;
X-CSE-ConnectionGUID: jIkonNNXRsGDVjOxuk6RLg==
X-CSE-MsgGUID: G86/o+AqSRyAfyxLpnV4Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46366544"
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="46366544"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 04:18:33 -0700
X-CSE-ConnectionGUID: Mycypb18TImK2GkSbrDrjQ==
X-CSE-MsgGUID: S0m2TVWaT9SMGi/+NHUHZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="131677616"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 04:18:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: mario.limonciello@amd.com, Shyam-sundar.S-k@amd.com, 
 hdegoede@redhat.com, Mario Limonciello <superm1@kernel.org>
Cc: stable@vger.kernel.org, platform-driver-x86@vger.kernel.org
In-Reply-To: <20250414162446.3853194-1-superm1@kernel.org>
References: <20250414162446.3853194-1-superm1@kernel.org>
Subject: Re: [PATCH] platform/x86/amd: pmc: Require at least 2.5 seconds
 between HW sleep cycles
Message-Id: <174488870627.2548.9797657945749595062.b4-ty@linux.intel.com>
Date: Thu, 17 Apr 2025 14:18:26 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 14 Apr 2025 11:24:00 -0500, Mario Limonciello wrote:

> When an APU exits HW sleep with no active wake sources the Linux kernel will
> rapidly assert that the APU can enter back into HW sleep. This happens in a
> few ms. Contrasting this to Windows, Windows can take 10s of seconds to
> enter back into the resiliency phase for Modern Standby.
> 
> For some situations this can be problematic because it can cause leakage
> from VDDCR_SOC to VDD_MISC and force VDD_MISC outside of the electrical
> design guide specifications. On some designs this will trip the over
> voltage protection feature (OVP) of the voltage regulator module, but it
> could cause APU damage as well.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/amd: pmc: Require at least 2.5 seconds between HW sleep cycles
      commit: 9f5595d5f03fd4dc640607a71e89a1daa68fd19d

--
 i.


