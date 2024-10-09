Return-Path: <stable+bounces-83185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9369A996886
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 13:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31648288F5A
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 11:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD17192B8F;
	Wed,  9 Oct 2024 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORXEJmJU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF82C192D6B
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472852; cv=none; b=m+kgyCaM8QWhZMwykkLQYjqqrCB7owCGpqQzln8y/H2ePFoH7YsNbzmN2uvQ5qNvsnButrC71INqNFxZzICjj7kIN+OryTfQTOgYguucBYM/6xLm0jNYZcP6QfYhlgnRmm6KKQU2HBri4orQ+SiQHiZARPqWCCK/kf7mX4RU4X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472852; c=relaxed/simple;
	bh=bdKW+wJ2Xs6wHjimpo3dwpvKP0Xa+5etg7sRqDqdwQo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FbESAl3oqtiJsIhaskUhiNYNrSMs44dD6EjAQ62PXQnSMgz0tvaRDAtyw2IPYyEx8diRfDNZQpMUMyA3GdCA9SMDgTeyriI5a8CEvM7ZhpbEZ/CPRKPZPjlUEgDdy+9A9CPzHYZVnCO4LkpCF/2LSuuvqPOQDRFv2BkAYlm7xw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORXEJmJU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728472851; x=1760008851;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=bdKW+wJ2Xs6wHjimpo3dwpvKP0Xa+5etg7sRqDqdwQo=;
  b=ORXEJmJUYaDOoupXK1+xVKj4HU49NT3UpvzTaE8hLe6oduOsRb4l4AW/
   q1bwCXIrRjZT7noprrZL4CbySrSEvBUDVCXyBK7IkMP37Tfm9GifZqGjZ
   5fE25BQjkl9XkLTY3Jdgs+04c1ZtcL1pZCL4tBnN4ju65v5JhiiEoQ349
   gH7BLX4cH3g7cvNPiSIGp+Y6syf7Sg810IlJOSkpYsHzlWXlaP3rkd3Dd
   Btl0bVFGLbP/7N5OBrcex76/r9t+OmstQGeumItswmnJPt2HLemLuZBcd
   OB6qDUpJ3RaD+6adJxXkUYaO44qrsyuUChWYgpZeJjHSS1aFwN59KBxSh
   g==;
X-CSE-ConnectionGUID: EKWzkhrzRQGLWP68+aQ5dg==
X-CSE-MsgGUID: FyN6LDZPSaSc8pQCriy7Gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="50301195"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="50301195"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 04:20:51 -0700
X-CSE-ConnectionGUID: 2mVtzWthR36fBajhH7Sx7Q==
X-CSE-MsgGUID: zJiAzHbAQmKmy90phmU2xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="81058899"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 Oct 2024 04:20:49 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syUkI-000990-2r;
	Wed, 09 Oct 2024 11:20:46 +0000
Date: Wed, 9 Oct 2024 19:20:30 +0800
From: kernel test robot <lkp@intel.com>
To: Anastasia Kovaleva <a.kovaleva@yadro.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/3] scsi: qla2xxx: Make target send correct LOGO
Message-ID: <ZwZm_js_eFfSNzok@d65bb508a7d8>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009111654.4697-3-a.kovaleva@yadro.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 2/3] scsi: qla2xxx: Make target send correct LOGO
Link: https://lore.kernel.org/stable/20241009111654.4697-3-a.kovaleva%40yadro.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




