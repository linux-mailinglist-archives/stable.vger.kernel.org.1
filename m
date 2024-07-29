Return-Path: <stable+bounces-62558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71C893F684
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 15:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815F11C22C59
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 13:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B43A145B3E;
	Mon, 29 Jul 2024 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RoGsswIb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D450E1E4A2
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258892; cv=none; b=BAGgTz81MA4xCbQnppGbtTAsmf7ClFW6LvTKi/yrxnoQtyalyzci6FcOIAnr6YXZFvuG8TmTLCAsTONMbnLLNclBUR5LWHL8ndWepwzWUOhW7lA02Kzd5MNpkNiHLl0Xkh6FNKKEDg+Lj2X/565LZHLpKES/jCXWTTjMDp/pkOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258892; c=relaxed/simple;
	bh=MYjN0MDmcKVoQwyflYK3YylBHDPXmNIIoOSJ6ebVHsI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=m6lC0t4NG3cx5xvPzPXMS7xkOatFPNMx2I3M2/wiLJz/zbbDdmTvqRgxvxmatpirrpaIvepVm57pwoqPE0fJIiMuVkKDHaREzQZOq3kQr9P439aoRB6BNPDmv/RRDsy91x7y6eUiHPc6HSp+kXcmhyaQwk+wUkoH5G8NGIOinRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RoGsswIb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722258890; x=1753794890;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=MYjN0MDmcKVoQwyflYK3YylBHDPXmNIIoOSJ6ebVHsI=;
  b=RoGsswIbNAvpQ2hcXlA2htuTlJ7fF5RmY4VL5nh5tQQdB+Xb/sm1ywnt
   cCb6WdJDcwcX35s/uoAHN4fGnZL9OnU4ZPiSQAlbbZZT+K5qbURTj3KQx
   Tc2/mPRcIicMMJQps0HzO3ADe4JmGRa73M/z7tHFJeY+LWp2i4JeVaumX
   wOGzWiWOR3IcG48wwprBUSyZOwsNZSjRgss9Y88TAzE8cAyL51bV/P9SP
   zE3mwt3JgSRE16zbmJqrlGehQfBf9zNbYY45eCyODVmBItIXIOnEYDiuZ
   Me44EsLRo7XtJbiyEMNXTDa7DvyEFq5c7/vW/CPBjuc3wtrmHDv0WfTHE
   A==;
X-CSE-ConnectionGUID: PEHamwsxSdCWNXjQ+bNoEQ==
X-CSE-MsgGUID: cLa5tjXaSiq75dO8kpA8VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="37482821"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="37482821"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 06:14:50 -0700
X-CSE-ConnectionGUID: bs1uldADTzyv7fIzu2HbSw==
X-CSE-MsgGUID: +uLIDL+wTcG9GsVHDcd5Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="53932017"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 29 Jul 2024 06:14:49 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYQD7-000riW-1f;
	Mon, 29 Jul 2024 13:14:45 +0000
Date: Mon, 29 Jul 2024 21:14:41 +0800
From: kernel test robot <lkp@intel.com>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/2] dt-bindings: imx335: Mention reset-gpio polarity
Message-ID: <ZqeVwapFJOsYmB8x@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729110437.199428-2-umang.jain@ideasonboard.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 1/2] dt-bindings: imx335: Mention reset-gpio polarity
Link: https://lore.kernel.org/stable/20240729110437.199428-2-umang.jain%40ideasonboard.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




