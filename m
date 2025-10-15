Return-Path: <stable+bounces-185763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97009BDD6F2
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 10:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C75A427C68
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 08:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5780426E153;
	Wed, 15 Oct 2025 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eYHV1u+A"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2B62FF144;
	Wed, 15 Oct 2025 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517111; cv=none; b=dipJ00GEbQpEPEFdPcHfr2cGAeDWqkDZsZXLiw49+UOwTN/LzFOMU00zLcOgj0nS8Sm+OV9cPHPZ76fPwcKmMOSSVmEmIi6IlsA23NgDopVJn0qBYkmq0zt0mdLH1nDgv0gQsVqS3TvPkOKtS6PjfJGYpJcxhvPvP7G2r/ndWfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517111; c=relaxed/simple;
	bh=guKDLKwMOZkIZbenBsHD/FzS0zw8aMJTh7zDKWF5km0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KaR6kY9tE86wEiiTOJbd7zPLZQYqqsGbNoeNxwX/5buKaNaNVf9+svbKjbMZiVZhsCYcYb8CkgzPgnEKAZMC0OeAKaQj/MeaWDFgllcz+A3bnrfJm8fQkjSzQpN4tlM4EVKHTTI8aR1sYexRNpdao9hcXzmgODD5+c0QD5OqOSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eYHV1u+A; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760517109; x=1792053109;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=guKDLKwMOZkIZbenBsHD/FzS0zw8aMJTh7zDKWF5km0=;
  b=eYHV1u+AfzVtCQWiDB1d71DBz+ziG5gtFx8/sEupQMhZIUjx744yAA7v
   5gzV+Am2Bis2eUgsR7n0cj4MPItre0x8ctqsI0ulGIUD9w/bDAc5ThYZU
   x9C2HLaHD63wA6tEsAyUPkkPpIguiFg+Hy52jN2Mbt9W0eDcmKr1HkmcW
   /fd7t9tF/kJnDdfLE/KeK4sWf5H1Q873+zMdDJdiI1wpFPvAthqNUHOGz
   yknvP/fhgjEy7SWBMEQERqG408AUwDPDEij6JgTVzZHyk1WjQkZMLtTfw
   8G/f1jFH3rIin1EhHDP71ToNed3+fmXGtF5hYRM8N39o41M91SBRt9qAe
   Q==;
X-CSE-ConnectionGUID: t+R2niTOTBmruY2tGxXL+A==
X-CSE-MsgGUID: A9q5uAOyQV6+nHrHUAppNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62780927"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="62780927"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:31:48 -0700
X-CSE-ConnectionGUID: 3ABDQyxlSeifXXo30MTHDw==
X-CSE-MsgGUID: lFdrMuSsTuOQBwTYBJu90Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="182895295"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:31:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, tr1x_em <admin@trix.is-a.dev>
Cc: Dell.Client.Kernel@dell.com, kuurtb@gmail.com, hansg@kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250925034010.31414-1-admin@trix.is-a.dev>
References: <20250925034010.31414-1-admin@trix.is-a.dev>
Subject: Re: [PATCH v3] platform/x86: alienware-wmi-wmax: Add AWCC support
 to Dell G15 5530
Message-Id: <176051710151.2196.15376523198051741903.b4-ty@linux.intel.com>
Date: Wed, 15 Oct 2025 11:31:41 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 25 Sep 2025 09:10:03 +0530, tr1x_em wrote:

> Makes alienware-wmi load on G15 5530 by default
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: alienware-wmi-wmax: Add AWCC support to Dell G15 5530
      commit: 34cbd6e07fddf36e186c8bf26a456fb7f50af44e

--
 i.


