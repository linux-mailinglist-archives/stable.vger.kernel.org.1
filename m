Return-Path: <stable+bounces-183696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DC2BC90A5
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 14:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1D53BFF6F
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 12:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8E023E334;
	Thu,  9 Oct 2025 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8wZ04/M"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EA319E967
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013166; cv=none; b=KoGvO4zWmQa1CTzsllQmp/M1SSauApLnYQ8P1yYCGbxNH+zCA/LOkopLOBMP+pjgiSx6LsVxqV1JrMmO2XOsepSJzNY2RPs33351wu1JzWk+mUCnB4gs86TTCh7Dn7ixmgbRCI39uqpg23g2ZYuoU8G0Qxwf/Bh/CMaazH76XTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013166; c=relaxed/simple;
	bh=668Z3MlV85j12M7E4iYG5aHUTUwErdII4XWxAOFpOZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J5WnxdijbmiKBXh3KGYStb+tWvEeeXuSij+aWAj386/WcArt5PT1WqBPF8WCwtSPfG/+6JT3+X5YaTZrKJAUA7txQYFPwv5xA+3VxAUkOhWgD4Q5Q2NTCjRRa4xPruKIU2hVjIdost7ZpW7ll2kHEfR7WuqrWRmNRlhLw0ynsNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8wZ04/M; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760013165; x=1791549165;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=668Z3MlV85j12M7E4iYG5aHUTUwErdII4XWxAOFpOZ8=;
  b=X8wZ04/MgOmk7o95nrG1NkYNC0HKFi1tZ0UXvZCWYqvUjI9iKKwGvrJy
   ayIjmm1ypHipjgksN4IwKQAKlQlPqzCmPMzY85OcK5EluPuxoGhXbgdAu
   zHXQJmY9pl8iftHIRVumoRgKClUQM8wFeowRpO6DJICgRPEEN0/IyeR1h
   d2i2yULMu7FVBKRD+4i2qni6Qh47e4S3kG7MtR7et0Dz8hrbYY84xI9jc
   cBtTOzxFW1Wy4wUdfzGfviGYQ/xf97KmzD2pgqOwjaYRTw/qkU1i+wvDd
   HTkDd1hECvsj54ulPhBuW97PagUK+oeAKnMmil2t07UwSQjtHm0D2bAIu
   g==;
X-CSE-ConnectionGUID: 5pHTE+TgQkigDptcXAwLiw==
X-CSE-MsgGUID: RoNW8k+lSHugB2VNC9O2Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66047883"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66047883"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 05:32:28 -0700
X-CSE-ConnectionGUID: r1Q4jEQ5TWycCWDyvKMAag==
X-CSE-MsgGUID: Fkst9ZhtTjSj8ln3k5ji6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="180278769"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Oct 2025 05:32:27 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6pom-0000hD-2z;
	Thu, 09 Oct 2025 12:32:24 +0000
Date: Thu, 9 Oct 2025 20:31:53 +0800
From: kernel test robot <lkp@intel.com>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/6] drm/panic: Fix overlap between qr code and logo
Message-ID: <aOerOTyCvH_S8kc-@a686f2e3b087>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009122955.562888-3-jfalempe@redhat.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 2/6] drm/panic: Fix overlap between qr code and logo
Link: https://lore.kernel.org/stable/20251009122955.562888-3-jfalempe%40redhat.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




