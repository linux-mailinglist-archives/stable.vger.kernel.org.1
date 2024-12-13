Return-Path: <stable+bounces-104041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C16F09F0C92
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 13:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA13287D6D
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B1F18E023;
	Fri, 13 Dec 2024 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUn/rxEK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBB21DF256
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093641; cv=none; b=tsgeZj2Luljiy7CzYwU56pV62mF2a55jEoypwHerQYtX1Tvs5xqaHPhoKndQlwRyX6n39LOmqU8Lg7xNhk6aKwrp4ajTXOVctxl0a3CYkXAej4+kfhe+IgzVGa8jf+y+mN9PJ0BRkkWRQQmTbUU+G551z93Jf6g2iGVCgenEqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093641; c=relaxed/simple;
	bh=rrIjNbL+EuiI32F+cFB0afFC4Znuwcif6Cj3AcWFxXU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Coo2qMJrZ7gCduz527GDq22H2DJDmA0SFLlloYUHK9ECcGrUMBq573mL1BmULzP7hmASauxYjc2gcJwIu+iApaVt5lTkD6fwxs/GIuj4gDFOK5lTfxBZ9WK8As8decnJ/OAUbZ3QRlq7voiEVf04msAO8gbLOxgW0OyWdrZ0t9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUn/rxEK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734093639; x=1765629639;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=rrIjNbL+EuiI32F+cFB0afFC4Znuwcif6Cj3AcWFxXU=;
  b=RUn/rxEKSOoTqDPZtitA1sSR+bp3KVg1Rjln0znPN81432kpAWVUlls1
   NWfEh8l5Ix6Z0AUBJWLfCpRX7S6Wehfp66b5T68IQ+zluYht8xBuMwSar
   Ue2+Z2PyTv5koFlxWRusYEkPmelyYJDKDuZ6fIf0CkA0/Hj9y5337nOzC
   2famRVuL15YZ2BfXJBtWEUIFJ7bj/DN6Hj3KaH4xtrWsIipg35/JxT3+x
   emAEqfYBShGl4yLnVasf5qk48AjLnUuZRTzEHNhDmnVhkqD1PPUNWxjiK
   oUtFDVGRj7vd59GJp8jPMXJFVF+ZGM31R0iTn5SzdtzQbbmrRYrqwVQrP
   w==;
X-CSE-ConnectionGUID: ztwHcQUQTF6vEWptil9C9w==
X-CSE-MsgGUID: Ydyje8tcTFOftVFv8CKUmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="34683064"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="34683064"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 04:40:38 -0800
X-CSE-ConnectionGUID: 3xEzPjrLRs6tEVJdjLj+Iw==
X-CSE-MsgGUID: 8MKbkX/6Tkicqauw1zktDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96386633"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 Dec 2024 04:40:38 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tM4yA-000C1Z-2b;
	Fri, 13 Dec 2024 12:40:34 +0000
Date: Fri, 13 Dec 2024 20:40:17 +0800
From: kernel test robot <lkp@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6 2/6] phy: core: Fix that API
 devm_of_phy_provider_unregister() fails to unregister the phy provider
Message-ID: <Z1wrMQXh70Yg8AOl@39f568f0a533>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-phy_core_fix-v6-2-40ae28f5015a@quicinc.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v6 2/6] phy: core: Fix that API devm_of_phy_provider_unregister() fails to unregister the phy provider
Link: https://lore.kernel.org/stable/20241213-phy_core_fix-v6-2-40ae28f5015a%40quicinc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




