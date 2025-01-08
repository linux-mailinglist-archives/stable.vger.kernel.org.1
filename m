Return-Path: <stable+bounces-107943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875E7A05182
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 04:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8104B167E70
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 03:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E395198E6F;
	Wed,  8 Jan 2025 03:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gnhf8NZ4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4B13FBB3
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 03:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736306373; cv=none; b=IX/o3bmKRqxuX/09bCtkdC4l+FYEPVD/OVdaqXz8nB8alETf6wN3cG8A6xaYXotSc5gv7dO0AX71CLjioEKuNV9r8zGT3r1krHKu3xLruXUaQvcsKiztwDTM5kKzhyM5PS0wVqV6nlYPpQ3xgq4c0Ow+eP/XXtsqy1niEoPAt3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736306373; c=relaxed/simple;
	bh=+LtLm1C3QjIEIABRBxsfOY9E00O0JDLEHj337gy34fc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HdXCWuHiUOGPfxzOcdwgI+Jwl327bPtU+H704IaVqr6s27rIftMdu5i27URia2xgKQ4nuLyNbqWaq8pjUkjXTt0ng6+zkPwkdHRjrCEFtYflcywWgVBGJ8VXfcyCG5o0h42odPEkQxIkR3JBwfZGrm0Pk2xnpY2QMbVGwNVNhhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gnhf8NZ4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736306370; x=1767842370;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=+LtLm1C3QjIEIABRBxsfOY9E00O0JDLEHj337gy34fc=;
  b=gnhf8NZ42dCvyzRw0SS5ZcIz8Tcwt3/aZX3knjGtcYHNGLf5/TSq7IfP
   xCfu5JcfgrGAy4duCgBGzmY6FoVNB+Ji1UHuIy8tfLhJhC1qSYTNR4W1q
   oDhRo0f4swCmuc9Z6XAf3mQnGw02Yt1NmBY1quSWwzPH5nN89gTAPI/51
   UqPq12hva3eER6gpowkxk/ta8IlHdeJwiSCd9pE0Uqf2ihyctYA7kGQ07
   2gTYKqmgkZDc6zMeKHzW2yd7aNmsw2K+fGtPaY66EuXIyNwIDda5b/K6T
   6ukNby3VmEbd2jLhn3DJvMr1uuLJmJWxLdq9LqM+RQkEqiyQQ3JqM0qJR
   Q==;
X-CSE-ConnectionGUID: ZfXWb+b1SbCEKktUvBbBQA==
X-CSE-MsgGUID: YNx6JDK3S3a0YMIOyz+Hvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="47182296"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="47182296"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 19:19:30 -0800
X-CSE-ConnectionGUID: mrNEG6oNQ/m6ZyUpyTvZNw==
X-CSE-MsgGUID: wVpKeTT8THm53+84EOkklw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103803726"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 07 Jan 2025 19:19:29 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVMbO-000FYd-1w;
	Wed, 08 Jan 2025 03:19:26 +0000
Date: Wed, 8 Jan 2025 11:18:30 +0800
From: kernel test robot <lkp@intel.com>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.4] ftrace: use preempt_enable/disable notrace macros to
 avoid double fault
Message-ID: <Z33uhjZDUe392GVL@42adc3c43980>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108031736.3318120-1-koichiro.den@canonical.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 5.4] ftrace: use preempt_enable/disable notrace macros to avoid double fault
Link: https://lore.kernel.org/stable/20250108031736.3318120-1-koichiro.den%40canonical.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




