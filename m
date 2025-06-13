Return-Path: <stable+bounces-152618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9FAAD8BBF
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 14:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0C218914AD
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B7F2DFA2F;
	Fri, 13 Jun 2025 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKfoTTo1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC9D2DFA33;
	Fri, 13 Jun 2025 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749816597; cv=none; b=kOw+aDNIBQJSH6m/drvyhOiGPpMS2EL2Y+9KIcwFDjaNLxeQgSaPxqWVYuXrCzT3hGEDjgEMHbZscyjVDB1DzozDqAw8Y/T9P/ZNZ0WuRqJBJ44ZjCDxQnJIEBohv5oWgBXB413Gz9dSLDn45crLIB0YrPkPtHZw+qqj79McpaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749816597; c=relaxed/simple;
	bh=0tu06tAr2kdXFxrJ8tihj6vbryL9Qfdx8mrPLEegIVw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iNf4DPhf91R2rg4wROW1qKNSK7zGP5DKKio609N5LFtOjXL6smn35Z74dQ4wxGDjSljgOzF145D9i+lB8kxJby+fODbeiC2AdjU153g6EqD9dmMjEXyeow5Y/i9MoqVB0o4YV6KABiC8IHSbTnbEcjQcT5HKk1xz1nCW2DsNjkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKfoTTo1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749816596; x=1781352596;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=0tu06tAr2kdXFxrJ8tihj6vbryL9Qfdx8mrPLEegIVw=;
  b=cKfoTTo18auW26Y7MsmTT9WgYcZk+wSYJ96pT+WtFUENT7iD0fhWYn6g
   MC1FN3vKnp8ySHIwE/hYrbUiWpef4L/Yic91Le5kNFpVfD/X/Q3QD/LGI
   Kw2+j5a5iDePAsyKz5KncJ69roUg49l73w5m/rTXTqyCfefqgb0ACygGM
   nIa2CmD32UleOc6zhuHjzdo0mthyTtxlvOjB1P/eHv2gvW8GHlx6Z+1bq
   DGCFZlHx6bsMG6zW2BMtokyJAKtYqTUGbaDk3Eizc0AQxrov9Hvy1R9Py
   LbDkUtyqRS90bzROJcGVFaoJ93V+65YbS1k5CIm5Ae7nmyttFzMRzuHQc
   w==;
X-CSE-ConnectionGUID: UPMDz1gyTlejUYcE2dbjcQ==
X-CSE-MsgGUID: BpzhreYkQsSMGvLHo9ySkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="63066198"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="63066198"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 05:09:55 -0700
X-CSE-ConnectionGUID: FQ31BINFSwO6SRjAqaOpZA==
X-CSE-MsgGUID: tsugnzQ4S1aUP4iOr0fMfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="170994936"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.102])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 05:09:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hansg@kernel.org>, 
 Kurt Borja <kuurtb@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Cihan Ozakca <cozakca@outlook.com>, 
 stable@vger.kernel.org
In-Reply-To: <20250611-m16-rev-v1-1-72d13bad03c9@gmail.com>
References: <20250611-m16-rev-v1-1-72d13bad03c9@gmail.com>
Subject: Re: [PATCH] Revert "platform/x86: alienware-wmi-wmax: Add G-Mode
 support to Alienware m16 R1"
Message-Id: <174981658790.27029.16646984768467792319.b4-ty@linux.intel.com>
Date: Fri, 13 Jun 2025 15:09:47 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 11 Jun 2025 18:30:40 -0300, Kurt Borja wrote:

> This reverts commit 5ff79cabb23a2f14d2ed29e9596aec908905a0e6.
> 
> Although the Alienware m16 R1 AMD model supports G-Mode, it actually has
> a lower power ceiling than plain "performance" profile, which results in
> lower performance.
> 
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] Revert "platform/x86: alienware-wmi-wmax: Add G-Mode support to Alienware m16 R1"
      commit: e2468dc700743683e1d1793bbd855e2536fd3de2

--
 i.


