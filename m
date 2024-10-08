Return-Path: <stable+bounces-81594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D3A9947F6
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A721C21FD7
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9CF1D88C2;
	Tue,  8 Oct 2024 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7sP336Z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A1C1D2F58
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388984; cv=none; b=WusvGWnK8kqC7zWhnSdPTpJJAHzw7kcdb1Ykhvv0i4uU9M33pwCdILFxVdo3HZAZ8S5mla6xIv2T4qzs4n9OWbH0unEgCFdXzWbPXI+n4v0jLwVk6b/vlJYL/YN7MuqbsOp8PSNRxMqp4BEaxKHfmGDhjQJc4qT6iBTWPZq2hJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388984; c=relaxed/simple;
	bh=4BynC4xx6/iz708HSZVmW6Q2++1As3Kdu0YHuw5enZE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=H0uBkdxhNQIa/CcIFyz8yMI2JeADtzMLUbEP9g12jLnkOu0j38iyzLLZvdqef/uxUkoicF89tamCXavANPZTLLBF5sPhfbkEQH3Pwh2z0+cuXuMAOLc/9i9RqakftWq9DquCuTIyTBjY2WCHvYnA77f4HGcwPuzG3cVbYcqKvMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7sP336Z; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728388983; x=1759924983;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=4BynC4xx6/iz708HSZVmW6Q2++1As3Kdu0YHuw5enZE=;
  b=h7sP336Z4CByyXg/zxC+bD0ql5LeQMwkyg+lRJNPD9+ngpYBcQ9NM4dx
   vuQP3DtA/YFNz0A0+OHcqwUTgXizrmaD08lI3kh6XvSWcnPUWSl/wnmf3
   DPSVNzkdVt4Cydehio4BcuBwSETNLx+JdUnHVWaRrwma7R7nmmyOBhMYd
   KVoyFFDO0CEeITuHHIgVupTJAiuAwnlah3A1UJNPREKIH5wTaCM7QadMG
   v440IWQtF/pFmoD2Z6oddJkL8P/2EEFomj70p1yhEJacnDgUO8zX50bSW
   cybzm+AqVZeQn+hAWzQ80Asrghnq1DJraUGF+c1zwinpnYYdPG1EMS5LN
   A==;
X-CSE-ConnectionGUID: jduRstNOSvePxAaiAIAndQ==
X-CSE-MsgGUID: 6aynu8VkSKSrsgD6SN3r6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38232115"
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="38232115"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 05:02:56 -0700
X-CSE-ConnectionGUID: r/sX2KfcTpqA2+2Nv6FeyA==
X-CSE-MsgGUID: xpOqF85WTzul08fbL/DdGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="99151180"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Oct 2024 05:02:55 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sy8vV-0006LQ-1F;
	Tue, 08 Oct 2024 12:02:53 +0000
Date: Tue, 8 Oct 2024 20:02:37 +0800
From: kernel test robot <lkp@intel.com>
To: Yonatan Maman <ymaman@nvidia.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 1/2] nouveau/dmem: Fix privileged error in copy engine
 channel
Message-ID: <ZwUfXTlTbAk3UWSw@b1422e034610>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008115943.990286-2-ymaman@nvidia.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v4 1/2] nouveau/dmem: Fix privileged error in copy engine channel
Link: https://lore.kernel.org/stable/20241008115943.990286-2-ymaman%40nvidia.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




