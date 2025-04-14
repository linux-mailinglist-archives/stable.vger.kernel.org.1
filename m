Return-Path: <stable+bounces-132440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A50F2A87F2E
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDF3174E72
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78882989AE;
	Mon, 14 Apr 2025 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HoyHAb/S"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECCF293462;
	Mon, 14 Apr 2025 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630625; cv=none; b=T2THi/ZCcWJTpkd0kB2sFoa7QGSXePuv6tvyjZih4byK+WPjclO6MTCFvMuisRRoHUtKv5+mZDms/Dd2ebIX9kpoC+J+M5ySF3FACvU63v27qzusBBG6KZMcnThx96V+27K3opGXJpmwY0mf+dQ+htB3UAaNrJOM8tays2piHcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630625; c=relaxed/simple;
	bh=QSDN53s7cPNrINelDD0kaD9253CXzuOFNPrkaHSFCBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlQyeUgA6t/J7WtvIWz5SIk6FthzShLQDC5TJDFGhLsY94nCDkZTZBnDQYTE1CWhvEKmYOzMBL7uKDwThj0YnJstspwFaptt1bDMFRQQaALEhAznQdu1znAXciS8KPHOjvHi9W0zT7d9wMDKcHWKjZJ3BWvt1igNbJqjSpWNdNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HoyHAb/S; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744630624; x=1776166624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QSDN53s7cPNrINelDD0kaD9253CXzuOFNPrkaHSFCBY=;
  b=HoyHAb/SUk6eFx+M7bjyDGBqw1zOdOVRdOvgChnO5T/WuYEAxen5rfpJ
   fGf7IZqsEyUqcPXwz6tfXNgzXi5ljHrcUrj2lzKqgFr8ZTReSCiSm/8Mm
   L8HuQQ2lA/9Jd1F0qeqETjYtS5+X/ynkd+m/VkwHtTmmWHjhs3AECp70R
   KcxfYJoPkCV0RDpJKpRVrkQkjYixz9HqODquyDOUYP5KnoqqMgphYo4D/
   sD/KRF8jqBFe3gkexNhXMuuF1Q6jK1qww0SfX/2cOkuswWwf+RW53zy6K
   DmRvjfJMD5rov9aFfK0nrIvxIEF9hFjv+a0+Wn8zGFzQlLSwCBbmffYsd
   Q==;
X-CSE-ConnectionGUID: tus+uwOpRU6HbOMzP052Gw==
X-CSE-MsgGUID: OexkDdQYSpm7QXUYcJh4Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="63499432"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="63499432"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 04:37:03 -0700
X-CSE-ConnectionGUID: fGZ7a5N5Rn+x6WY7ITPUYA==
X-CSE-MsgGUID: w6UCqWw6TxmdEExeygQNlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="134550648"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 14 Apr 2025 04:36:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B1E338D1; Mon, 14 Apr 2025 14:36:55 +0300 (EEST)
Date: Mon, 14 Apr 2025 14:36:55 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Patch "x86/mm/ident_map: Fix theoretical virtual address
 overflow to zero" has been added to the 6.14-stable tree
Message-ID: <nk543is45cokcdjnnovpopirhqlejfp3xgzs4wdpjyyskumw5w@fbw5bqq3x3mt>
References: <20250414103727.580274-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414103727.580274-1-sashal@kernel.org>

On Mon, Apr 14, 2025 at 06:37:27AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     x86/mm/ident_map: Fix theoretical virtual address overflow to zero
> 
> to the 6.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      x86-mm-ident_map-fix-theoretical-virtual-address-ove.patch
> and it can be found in the queue-6.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

It was explicitly called out that no backporting needed:

>     [ Backporter's note: there's no need to backport this patch. ]

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

