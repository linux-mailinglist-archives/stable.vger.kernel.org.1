Return-Path: <stable+bounces-133029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BE1A91A7E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5996E46219F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A2F23A99F;
	Thu, 17 Apr 2025 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1vn59Zq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F4F23958E;
	Thu, 17 Apr 2025 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888724; cv=none; b=rXnZg2c77m3rOgOIQYMbQQPkkXZAJRgQoifdLbJeWkoq3ikkDFNFjyZtIFRAwnpLzzD4fDWiZu3Y2lnQQMgdUaFrmO+j3QqGdrLhBsz+1FPC/oLygUdF64tQVRig8ng3V9w/4rRtsiQweBCVjuIJsdqLTsT99owtwxHTj9lTPGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888724; c=relaxed/simple;
	bh=7DcjQ1DXZHJuotHGzYuDvwCSxpaG9C9yPkh4AHK8f/4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nzRiPsLR4zN4TREfzz+kVSRV34najHgJoohS3VP8ADIkmzKt54SmsgReD6bsZlF0NDw2ywLMrTVGflRBkBErXzMq5wf6w8hEUvlcMYzAYW9VeS0MuXdDoBC1m6yYrZ5a4rEi24lPoK/uX3UYGi0jTh4LmYAkOvST7g7vtDED85g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1vn59Zq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744888724; x=1776424724;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=7DcjQ1DXZHJuotHGzYuDvwCSxpaG9C9yPkh4AHK8f/4=;
  b=a1vn59ZqUDbBnNLz8lAlOvPPawZ1FSE5ADY0r9qGpKhSyGWGlchZjuf4
   lDV2hVamklGv8sWaNVN4sMNHb8ATBbxGr1o1yb/prVnlqfpb10kjqxDr4
   ltT+tnvTe2y4em1C29kxcxsBTfWrN9VM/HZmlWQOSSxXEazBMgzLg0kRH
   X/kNg+U54A2TRSPfWlF+cDGqkCYLfQ776Ou1aTfhHOSz9131oHLtBAQgv
   rArv3EwX5l0U04JRodpFCh4JV0JjN3loEzVRspx27wW7IFWWlWuqJttua
   E4sqRj7jRozCui30/PFU57Op5L4FBSW68Z5BbD6V5CB5zIyQdrRz+uzLN
   g==;
X-CSE-ConnectionGUID: W71sshEeQsSCTCQ7R8ghXw==
X-CSE-MsgGUID: LUB+JUVRQW6M26KWSBG2pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46366558"
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="46366558"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 04:18:43 -0700
X-CSE-ConnectionGUID: w4ZSW/hEREe5FLKsI9cMmQ==
X-CSE-MsgGUID: +yDStAT+R/WzNPUDrzRnfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="131677643"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 04:18:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com, hdegoede@redhat.com, 
 shouyeliu <shouyeliu@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Shouye Liu <shouyeliu@tencent.com>
In-Reply-To: <20250417032321.75580-1-shouyeliu@gmail.com>
References: <20250417032321.75580-1-shouyeliu@gmail.com>
Subject: Re: [PATCH v3] platform/x86/intel-uncore-freq: Fix missing uncore
 sysfs during CPU hotplug
Message-Id: <174488871345.2548.2694845839583512280.b4-ty@linux.intel.com>
Date: Thu, 17 Apr 2025 14:18:33 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 17 Apr 2025 11:23:21 +0800, shouyeliu wrote:

> In certain situations, the sysfs for uncore may not be present when all
> CPUs in a package are offlined and then brought back online after boot.
> 
> This issue can occur if there is an error in adding the sysfs entry due
> to a memory allocation failure. Retrying to bring the CPUs online will
> not resolve the issue, as the uncore_cpu_mask is already set for the
> package before the failure condition occurs.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel-uncore-freq: Fix missing uncore sysfs during CPU hotplug
      commit: 8d6955ed76e8a47115f2ea1d9c263ee6f505d737

--
 i.


