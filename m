Return-Path: <stable+bounces-160365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE14DAFB3C2
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 15:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F851AA4354
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 13:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB3229C323;
	Mon,  7 Jul 2025 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FanFTgxl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556DA29ACD4;
	Mon,  7 Jul 2025 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893207; cv=none; b=TQsh6NU5DyrFMVQxgFFF1PIeGqvjaqklUv2lHvB618O5QF8nBzHoC5iwLbzA24DRoh5n93HGjaaW4tGDnpVuB4vsiK4v0TbZdpxW/+BBBQLPcIIeEz38rZ4jSesq3v0AdF1Lqdzwxd6Jp59SPyfO5VbeT1OZzpq44RymWOEs/Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893207; c=relaxed/simple;
	bh=OYuuq41zyZEuye2UbQAlUX3ToiLuKhLbzSgHgVRSXmY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BAm/7gfETMtWAcWEC/qDWKpEl7TWehwsG8lklnnx1s03DoAmrEkeiM1tKDS4s4S/gA9is1oNxUkuMzM8phNJ2bZQ1Q/D9Lar2eknBFUVu4wTF13X5VhlCxDWUiqmrxs7+SENgCxQjYUH+SPkj9VRNS7N6NqW3wxl0f1aRY3bJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FanFTgxl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751893206; x=1783429206;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=OYuuq41zyZEuye2UbQAlUX3ToiLuKhLbzSgHgVRSXmY=;
  b=FanFTgxlVXtOO/UtmnA6J+GL4UUs1C5Kv+g32VAvE8rKREosCeQbIidz
   2GTErg5ogiAkNbl0Jorw3CO+zUCFJS/j70absxCmRo4qsEDQobP9W78Iu
   EiJlVlRq2Dfqq5qCAiiagBkOJfWhV3Tr+G6luGr26Ls9wEYKragdC1Rgu
   GrdxC6Fy18e+WMz3EiEPuijhK31OW5M4hmF7gl8Jc7G8ZgGrrppb/IJ5O
   vBp8GmaIN3PffFNhuuCS12KHOmi7PAx6WGyXs/oLwtm2qLt8cLqaFX0vp
   xzTpDD3SOe0Oq8+j5Suxl0MJt1Jl53767kPvguknsAPyrX0+nU7GLcxw1
   Q==;
X-CSE-ConnectionGUID: Sw1rhplPTBCA83iYatpcyw==
X-CSE-MsgGUID: GZruzkpwQuCZMY2hiLvH5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53970649"
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="53970649"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 06:00:03 -0700
X-CSE-ConnectionGUID: 9D9/kXgeSCaii8wYgwAduw==
X-CSE-MsgGUID: 95eWDQAqRy2B9tzh3WdcYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="154634834"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.104])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 06:00:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Kurt Borja <kuurtb@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250707-dmi-fix-v1-1-6730835d824d@gmail.com>
References: <20250707-dmi-fix-v1-1-6730835d824d@gmail.com>
Subject: Re: [PATCH] platform/x86: alienware-wmi-wmax: Fix `dmi_system_id`
 array
Message-Id: <175189319656.2280.5627704855016194059.b4-ty@linux.intel.com>
Date: Mon, 07 Jul 2025 15:59:56 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 07 Jul 2025 03:24:05 -0300, Kurt Borja wrote:

> Add missing empty member to `awcc_dmi_table`.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: alienware-wmi-wmax: Fix `dmi_system_id` array
      commit: 8346c6af27f1c1410eb314f4be5875fdf1579a10

--
 i.


