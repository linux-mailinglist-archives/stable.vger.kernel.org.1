Return-Path: <stable+bounces-201076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8455ECBF3CB
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 18:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EE143021064
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 17:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8C3330B05;
	Mon, 15 Dec 2025 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XX3CeuNd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455FF273F9;
	Mon, 15 Dec 2025 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765819417; cv=none; b=D0Ii9Tp/59IgkwMXpMKtWllpDzdR7BQwOfG/D0pRilMHForNwiQs6E3pJR2/dKAoqRwwB4aemm6E97NRzlzrUC6Giixpx3nSX8PKk6QQlQl857GTWSrFGOsuylMu+xgkTB/UNlONDdILSq5IXh9nLUnrUOG8pRutKN05F/rrCEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765819417; c=relaxed/simple;
	bh=jxlZosFUVEwEuB/NIYCPgtssyQQOaTpx3TY7btnRMkE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TsxU36Xh5/Sw4evTVt6gbWW+543zNak52ItTvhI7jsAh81kiqibwRuQqNWzrqc1dlNlb4e/5vlmWTbRyE7QPfYsgQoQVDZlE+gLWjcUVDkK5qbBcjjC7wN/62ocm0uYiz1+ERoodQ93bOPFllPCR91p+kQ2C6sYO2mSw5YcKCxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XX3CeuNd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765819416; x=1797355416;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=jxlZosFUVEwEuB/NIYCPgtssyQQOaTpx3TY7btnRMkE=;
  b=XX3CeuNd2AONHt/jQakxtrbU60DG1bfm0+LY/Fk88JMnlMh+C93U/W5x
   M9dJhfH0H6qJuqHqtmAOQ2L8CSUxjpl973u7FB04gibgVOcd3+d/VQYb4
   9P27Dw929CMb1IExfNE7rbizuAcDz+IpsxlHvkljKI2qgXZdW3dt1zegp
   lpfTw4GCkvaJt8gTz/FekO2SkEOPa1PIuQyPcLdAe8HWSZqjq9tTd9XE8
   xUsBGWGYbxiF2GnJiJwsYW+6wTIvToQWmBvbbULdbrYQrMdaCRI907EPG
   LJfxDkL1KcKMfODDo40FdAS/V4Jbc+MA1W6N255wTNmGYzVaQj4JASsRl
   w==;
X-CSE-ConnectionGUID: eW/eWLq9Qh+gyzajhhc5lQ==
X-CSE-MsgGUID: SntSfdG7S5CpGI9k+ARxig==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67667853"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67667853"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 09:23:35 -0800
X-CSE-ConnectionGUID: o91/V3WNSt6oUcB+YDOWcw==
X-CSE-MsgGUID: +BEEihGyQZe1SQF+lDNSfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="196872627"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 09:23:32 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, Kurt Borja <kuurtb@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20251205-area-51-v1-0-d2cb13530851@gmail.com>
References: <20251205-area-51-v1-0-d2cb13530851@gmail.com>
Subject: Re: [PATCH 0/3] platform/x86: alienware-wmi-wmax: Add support for
 some newly released models
Message-Id: <176581940685.2916.5971774044371323417.b4-ty@linux.intel.com>
Date: Mon, 15 Dec 2025 19:23:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 05 Dec 2025 13:50:09 -0500, Kurt Borja wrote:

> I managed to get my hands on acpidumps for these models so this is
> verified against those.
> 
> Thanks for all your latest reviews!
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/3] platform/x86: alienware-wmi-wmax: Add support for new Area-51 laptops
      commit: 433f7744cb302ac22800dc0cd50494319ce64ba0
[2/3] platform/x86: alienware-wmi-wmax: Add AWCC support for Alienware x16
      commit: a584644a490d276907e56817694859eaac2a4199
[3/3] platform/x86: alienware-wmi-wmax: Add support for Alienware 16X Aurora
      commit: 7f3c2499da24551968640528fee9aed3bb4f0c3f

--
 i.


