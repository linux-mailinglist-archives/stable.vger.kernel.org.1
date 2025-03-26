Return-Path: <stable+bounces-126677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CA6A710C3
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 07:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF094170AD7
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 06:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B70335C7;
	Wed, 26 Mar 2025 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NC0ojnZ4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0701494CF
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742971856; cv=none; b=drT7oB+p1q8T2ahjYz0KBA/+UqbLtxnumhycgSMVLRExbaZGZ33AibZESu0Rg/5YN9SIn49ODSN/RO+505m/k7bBY54V1N3MnfOfFPgs3MbHXncy9tpyhxCGwCu6MsaY8Pb2TxxEuDJR3U4hsKnrP3XWZE3NMfM3+MvEgQmQ/3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742971856; c=relaxed/simple;
	bh=FIZeOZwHQRIy53PzOnKX0jk8xS8uzlQ4s4+VbId5vX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULChqRA3vuobtFp4bl/AeIk0/svHvRF6N1OHSzmTdTitWNNW0gABiePof0x9ZnBbbmuxcA2M49ZWQERr8qL6axUIXMIp3Zlzja5CvLO0hDx8En/yVLRHeag+KmTe7YiQqCRoiFKV1304zPW1PqxJFFwvk1NkrHRLh8HcW8N7W6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NC0ojnZ4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742971855; x=1774507855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FIZeOZwHQRIy53PzOnKX0jk8xS8uzlQ4s4+VbId5vX8=;
  b=NC0ojnZ4XLwUNLXfGltYBQoFWUyEKdOXqux2Tm8ibycWTjVFoZeNP+Qh
   uAVuV/SMs09wb4aI0Jw0aqmGGyIs+wSgnScefMUuQB1RO+tandun2YuA1
   /PQ31PBLz6HTQG6zdgtWPJ3HAxHMyBD9crSDP6JeeSV1zssEtOX7wkYXk
   gZU9dYsQtnDVl2djDTdHlplJYVc0DKNgLoZDukGUoHUD53G2rjtE0foXD
   MUxXq9G3VfVsQ9V2hirbAmy/J6fI1G78u1jiYAtjMfhJYdP5/cMPN1QQ8
   +KkKTRN0z3GbVLCPbm8Bwm2O1ClMNTVFqoCIP8dyflP9JLXZHOWeck00G
   A==;
X-CSE-ConnectionGUID: Auxum9yJTCCw0oCeWXr8Xw==
X-CSE-MsgGUID: JTyhqR0nQ2SQfkwHlX51tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="46982084"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="46982084"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 23:50:55 -0700
X-CSE-ConnectionGUID: 4IVh/AmzRlCk0Mo5C1sdyw==
X-CSE-MsgGUID: AFLACqhESKqr6Yh1Q3B70w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="155560524"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 25 Mar 2025 23:50:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3DAA4141; Wed, 26 Mar 2025 08:50:52 +0200 (EET)
Date: Wed, 26 Mar 2025 08:50:52 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] mm/page_alloc: fix memory accept before watermarks
 gets initialized
Message-ID: <pkwudbhxsc27frdpmtggtqylzadklhz4w6djtno2kgz7l33iok@o2irbjtmwehd>
References: <20250325121621.2011574-1-kirill.shutemov@linux.intel.com>
 <20250325124736-cc99722df0f49555@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325124736-cc99722df0f49555@stable.kernel.org>

On Tue, Mar 25, 2025 at 12:56:44PM -0400, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ⚠️ Found matching upstream commit but patch is missing proper reference to it
> 
> Found matching upstream commit: 800f1059c99e2b39899bdc67a7593a7bea6375d8
> 
> Status in newer kernel trees:
> 6.13.y | Present (different SHA1: 18c31f7ee240)
> 6.12.y | Present (different SHA1: f4bc2f91e6f5)
> 
> Note: The patch differs from the upstream commit:

That's okay. Stable tree doesn't include 59149bf8cea9 ("mm: accept to promo watermark")


-- 
  Kiryl Shutsemau / Kirill A. Shutemov

