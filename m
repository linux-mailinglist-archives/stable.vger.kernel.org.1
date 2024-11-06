Return-Path: <stable+bounces-91679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C260E9BF23B
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 16:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0914B1C26350
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 15:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F243201021;
	Wed,  6 Nov 2024 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgVfTYn4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33AE18C035
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908326; cv=none; b=m/dVue+q6qOIzu1DtO1abk394fw1xUmTZI4L7tAhluvxi3hGVeeXl6SMrLVdPk+C9D8TZeFDmpcaGD//1pqYLseRNFy2Amm0q0BIxE0i0u7AQbRLyQLL/SzQv8m/CiuiRed8apMGzX/Wi2WlXY34Zi4LzjVMJW/P81SaJkIOrFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908326; c=relaxed/simple;
	bh=sOQKraW66ddRUMKdY1tWwA4HbJHXV+S5hai7mdThO5M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lSDkAhu0BwaYJ40W8t9b7LSKk+Rn9A/OxZdEovy3GvrJKsIgPBI4jTmqVvduy6QZcmxvlnD3fNHP0b7fMRvPRuTzyZ6U+74FdYtfz67kHxRwn4cOpnWjjhvmWp2at2FKU/jIh9mClU6wghW2h1ZAvPHinpevOgRR6kGWJRdkwlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AgVfTYn4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730908324; x=1762444324;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=sOQKraW66ddRUMKdY1tWwA4HbJHXV+S5hai7mdThO5M=;
  b=AgVfTYn4lOL8ZkUTxtAY+CzDgHJJpmhoznXnsT/iQopJDC2FPOZvOcWL
   blX3WgzYmLHAZOPJhHdwm2sTvsUhbtHIQA5xhGc2Xg08C71H7saHc+HXW
   32nC0DhV9NZ9FVKxmArbgFkn1Z9wVpiPnVj0FZ+plRIuRfftxIybsXewf
   sMn3zJbELUuhvBZTP7QWu4Ny6oQlMutY2vTAzqYUz6DjYq/BbAeY4bHf8
   EsbItYHhhBQt9/xqep7DF3YmZBbwpc7cBL7RmSUgReoISvHvL/UPca6ed
   7nfmPeinFJQH/QstMkVnCE7u3xlgyRUVfPh5jvy05KfJq1TwR9ZibZ5fa
   g==;
X-CSE-ConnectionGUID: OV4snq03TAKXfgEE390dJA==
X-CSE-MsgGUID: /Bp/YVchTRG92GKMfDOWeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="42111786"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="42111786"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 07:52:04 -0800
X-CSE-ConnectionGUID: QiLs28etTdSzT79vRhPQXw==
X-CSE-MsgGUID: aCScR5mPQ3WPeMIHGVax5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="84569563"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 06 Nov 2024 07:50:21 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8iIU-000p5I-2I;
	Wed, 06 Nov 2024 15:50:18 +0000
Date: Wed, 6 Nov 2024 23:50:17 +0800
From: kernel test robot <lkp@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] wifi: rtlwifi: rtl8821ae: phy: restore removed code to
 fix infinite loop
Message-ID: <ZyuQORM_Z6ocJPd0@a6d8444ee0cf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106154642.1627886-1-colin.i.king@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] wifi: rtlwifi: rtl8821ae: phy: restore removed code to fix infinite loop
Link: https://lore.kernel.org/stable/20241106154642.1627886-1-colin.i.king%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




