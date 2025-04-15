Return-Path: <stable+bounces-132749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B732A8A0B6
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 16:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9E017A96A
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 14:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272D21F3BB4;
	Tue, 15 Apr 2025 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHgBPy63"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3262413AA53;
	Tue, 15 Apr 2025 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744726375; cv=none; b=OBviH2To+vAfzdyiOrKawCP2Ian1A6/9xKRCOzeAGIswf0nYGp6q+VkzXA/u94ORBFtp0xQ/DoRjfG2ciqtUMK6ZzjRRDOp/FEoZ5XdC05r1EchH3zQFSoF+7RzEoUSBGlPdYEviEtGFcB1OYAwIf8sj7eAK219yrdVZUscQB/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744726375; c=relaxed/simple;
	bh=tPsF5KmvU8YLuirrBM+XJ6P5LFS3RlhTuzc6LYXAh6E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VprsxCiZGzYMERyj3eUb6v/i4bGP4P4xi+mvrmX1T9shAGPXs4O7O/LPP4OOIscpY0PTAZeYXbjj8jIDGodSGYhAY5eRc4AWDsJVy5B4SPLikCPL/0kXvRQnWXwdSSu7EMFQoBgZeL7SfruSKiRBhm8kpLfauy+Xhb/LFT8uppY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHgBPy63; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744726374; x=1776262374;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=tPsF5KmvU8YLuirrBM+XJ6P5LFS3RlhTuzc6LYXAh6E=;
  b=eHgBPy63c6YkOMaX2GCamIgVBOFDiKfLPuqOCnrZKfup+0BDUQSA4NDI
   CWReIpvD6+Vi8xXxDdKFW/u6s9FRMyWf7/8H9v8vKgLiOzOqQKkSZGl3p
   9TNyetljXa6ppsFVQn4ZmEa0YYdUUcMGXrvNJNFC1+EF3aBM6AiKPFpiW
   yBxGjTLhCWUFBwUiNhfu8n0hTl76pQuVuxCbf4aUkbEY7x6STMeqT4P7b
   IeSCEtanjJF0sPeargjVx+QX8yrGlzSgT0fWHJT5DX4+m3X9id+VCmEoB
   xuURaTGr8iW8wsdkW+e/z4VpByvQ4yffEfA9BXXnFcH04AFhNvN2dhVJS
   A==;
X-CSE-ConnectionGUID: 1YFjE3jXSGygYEMFtaVi/A==
X-CSE-MsgGUID: BHvqSi3aT92LAAVLcc1xkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="45950321"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="45950321"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 07:08:49 -0700
X-CSE-ConnectionGUID: GMRC9y8OTLW/T6cjFAE8dQ==
X-CSE-MsgGUID: 87LF8UZRRJOt69b1SMku4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130156434"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.140])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 07:08:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, Armin Wolf <W_Armin@gmx.de>, 
 Kurt Borja <kuurtb@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250411-awcc-support-v1-0-09a130ec4560@gmail.com>
References: <20250411-awcc-support-v1-0-09a130ec4560@gmail.com>
Subject: Re: [PATCH 0/2] platform/x86: alienware-wmi-wmax: Extend support
 to more laptops
Message-Id: <174472612155.1885.731492109641946522.b4-ty@linux.intel.com>
Date: Tue, 15 Apr 2025 17:08:41 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Fri, 11 Apr 2025 11:14:34 -0300, Kurt Borja wrote:

> This two patches are based on the pdx86/fixes branch.
> 
> To: Hans de Goede <hdegoede@redhat.com>
> To: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> To: Armin Wolf <W_Armin@gmx.de>
> Cc: platform-driver-x86@vger.kernel.org
> Cc: Dell.Client.Kernel@dell.com
> Cc: linux-kernel@vger.kernel.org
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86: alienware-wmi-wmax: Add G-Mode support to Alienware m16 R1
      commit: 5ff79cabb23a2f14d2ed29e9596aec908905a0e6
[2/2] platform/x86: alienware-wmi-wmax: Extend support to more laptops
      commit: 202a861205905629c5f10ce0a8358623485e1ae9

--
 i.


