Return-Path: <stable+bounces-156157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9335DAE4D5B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F8217D01F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 19:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2652D3A91;
	Mon, 23 Jun 2025 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H5ORQ+Q1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3F228C867
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750705846; cv=none; b=RLwXMI/AWHiscZk06vCVQyJKo4j/jX8kS6EJsSTBvFNPTbOx8TnHIdgk8p6NJcTBBmK9lePC5U8VUUxt7FgO4t9jAdDBw7lbNtu0jBiE9y3LyTWzT9jaqHZODlAGxPyGQeIivqycI+OjetpT1IVrLvwEGDjzPSHDKajcMeApN0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750705846; c=relaxed/simple;
	bh=lSgP0TXGALiR36WmLm7DPFmlwBgRmzY90tRjw6NwBhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvGQv/AmkHbZWW9mUDyc7VBmLEdVVugMH112/sjaw2M9pKicxDRObOYxk5gWh8JLboo4e01GLuAOLcQw4ehn1YYOc5W0Kbxnt6DgRLnlB1iee+8nYW2WTvWLQfGuUGM4N9E3CiTrC+47Ad7fGon1I7lFWqPGuGPRR/Qoekouf/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H5ORQ+Q1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750705845; x=1782241845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lSgP0TXGALiR36WmLm7DPFmlwBgRmzY90tRjw6NwBhA=;
  b=H5ORQ+Q1pY7kRdIHB3omiu+hll4f6MazQiDkRqOLj1nUoeXHgTGw8JtI
   ho+4Qmz8+C3SthYRYAK+PnBKmz+WmuRbkckuYcvAXACV40lnK3YumNTv2
   GKNZoOEfwR9CiAcdbZbESyIF/NW+QnNUThaDW2jAr1biYKGBULlExeVAm
   TJL53qutTWM6qlFaUpXMpdmQ7AX8TpvsFQfCJazsWjpUqACoQvyrG1ohf
   hDK3IcKxGEkY0RusPmcuzaKCi0u7JLFcG6Rm2DaRHf8CW5YclFCALNOIO
   Rf1VwEQ8Mm6QjURcqDiynfhltLTkba1z1V8FBpr+/RRNlAURFHGo/sGez
   w==;
X-CSE-ConnectionGUID: Lmfc+HSITDO0atNNLYr5AA==
X-CSE-MsgGUID: Y8QqMRpeS5GxtHjZiBx82w==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="63987876"
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="63987876"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 12:10:45 -0700
X-CSE-ConnectionGUID: TvxcS6K2ROKQIshR6Pq62A==
X-CSE-MsgGUID: xk6qmfqcThaoOz+n0XW2NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="151107148"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 12:10:44 -0700
Date: Mon, 23 Jun 2025 12:10:39 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10 v2 07/16] x86/alternative: Optimize returns patching
Message-ID: <6nqyxulhkbxbsgf2se4q2p3lsulwtghjhndix4o7prpyc3oq3d@vzpun2i47lym>
References: <20250617-its-5-10-v2-7-3e925a1512a1@linux.intel.com>
 <20250618174213-ea78bf1980924e73@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250618174213-ea78bf1980924e73@stable.kernel.org>

On Thu, Jun 19, 2025 at 05:04:22AM -0400, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ℹ️ This is part 7/16 of a series
> ⚠️ Found follow-up fixes in mainline
> 
> The upstream commit SHA1 provided is correct: d2408e043e7296017420aa5929b3bba4d5e61013
> 
> WARNING: Author mismatch between patch and upstream commit:
> Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
> Commit author: Borislav Petkov (AMD)<bp@alien8.de>
> 
> Status in newer kernel trees:
> 6.15.y | Present (exact SHA1)
> 6.12.y | Present (exact SHA1)
> 6.6.y | Present (exact SHA1)
> 6.1.y | Present (different SHA1: 7e00c01ff80f)
> 5.15.y | Present (different SHA1: a70424c61d5e)
> 
> Found fixes commits:
> 4ba89dd6ddec x86/alternatives: Remove faulty optimization

False positive, this commit is the patch 8/16 in this series.

