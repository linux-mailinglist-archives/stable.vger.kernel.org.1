Return-Path: <stable+bounces-61244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA32C93ACDA
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 08:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78CF1C2130B
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 06:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347CB52F74;
	Wed, 24 Jul 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D18+VHMn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A4CD29E
	for <stable@vger.kernel.org>; Wed, 24 Jul 2024 06:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721804113; cv=none; b=k5YjVwmkiJdQRp4CX5MnQ72KxVhpAqaJEqz7jOtEk5Qw1iAnl9VE/b/c3I2u2ewRYCpekvZfZFvjkdUzUrb+7ZdoC7LGHoRfaYC3n6NSPWPxkptB9ZmX/2kEQF3Sdm83ppOhJX+PBxMD+AsGYv1ZXIpMevGfZyUCR4ioigMdKEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721804113; c=relaxed/simple;
	bh=/j8WLVC+Hoyz2DiZZ7A/ceTNgo4eVuT/HmTsRXvyZP4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bxEIen1gk2k0sFFE/Ldd6dK1mc3lwhgrKwI7T5rVEWKLLJEA9SoCvmewt8rXZaRCdhjeyAQgyhsnKfq/ahS6QWFmW8eyr9Su8zK041Z72KwVSC4a9W9m/C+jCygOobsDFrrtkZrEPRnztQtcT1HejebDkNg23bsLBMHT+ChpikE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D18+VHMn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721804111; x=1753340111;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=/j8WLVC+Hoyz2DiZZ7A/ceTNgo4eVuT/HmTsRXvyZP4=;
  b=D18+VHMnH0PwpEmGyi4y761Mgb/QV1t/cJ1ErLbChA8TAUwDzYEPw0Aa
   A0puSdRMarGQx22G5iCTRR1GzPazQFCUmXt9RzBV1fvG3ckeQLmNpF0Uz
   g8XGfJ9WhtIN8yjlJwYhjhHynIzfJu9smzNcdrYti8BKmxbbnIB1VxACe
   TABEtp60mPmor3dQLcu2/LoI/HDzO4VjcTd8dzCmqO8Qder6rXpAtT4+I
   szQCWy5lPOGTHVDkl4v1+5Nz4ajMbIaG+p/KStgwvmMjBl5FCpOKVABz/
   53pgY1nxkJbNp6O7asY+FV7GmOST6unekbLAoSvV4onBsMGg9hDIjSYLl
   w==;
X-CSE-ConnectionGUID: 2eqoJXwiROO+0rog78l8/Q==
X-CSE-MsgGUID: cpGw7Nq7QRyGzcBWp0YBsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="30845415"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="30845415"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 23:55:10 -0700
X-CSE-ConnectionGUID: BzjCCc/NRVOBttQs3DVCnQ==
X-CSE-MsgGUID: 7/Kx0Mr6Rxu9/q3nXQBiIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="89953707"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 Jul 2024 23:55:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWVtz-000ml2-0Q;
	Wed, 24 Jul 2024 06:55:07 +0000
Date: Wed, 24 Jul 2024 14:54:30 +0800
From: kernel test robot <lkp@intel.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <ZqClJsyeG8EuFQfU@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724065048.285838-1-s-vadapalli@ti.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Link: https://lore.kernel.org/stable/20240724065048.285838-1-s-vadapalli%40ti.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




