Return-Path: <stable+bounces-58939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 087FC92C480
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 22:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDFE1F234F9
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 20:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AC6182A64;
	Tue,  9 Jul 2024 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIX4fc1V"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30C114F108
	for <stable@vger.kernel.org>; Tue,  9 Jul 2024 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556825; cv=none; b=kILqaWSgkcPyiGQuTEwvrtLkTRwvzNE3vRM4l8x6HbLo6vWW5el89TEaIxllIsNrQqDTDnb1AAsl6aflaYLIYf5hQETrELPlrlTH5JIZ7kMewYBCIVbNR5AyW8W1I6XswaX60/NPWRvPITul/cZY7/y41d5MQLryORFbhBAPDlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556825; c=relaxed/simple;
	bh=bP2xl15VQEjy5uCOrZgExPDFRtzdHIoMseZpre+wMuE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gXqFp40y9eapame6brV24QuygtaJvKvgifee35OP52kVslEJRC4nJ+Ox6eWLyfJ/PzkitU4axHYv4k/QrN6EHwVUjEm1a95cK5ltHgi1vuMkHQlIZKPxwDOsGN3lSeopVyTzGGOnaUJ7j7AoUvOVGndP3G23ceoZvIHWRgPVhGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIX4fc1V; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720556823; x=1752092823;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=bP2xl15VQEjy5uCOrZgExPDFRtzdHIoMseZpre+wMuE=;
  b=jIX4fc1VhOFDehaMGYH0wfin8m/gE2SPNwbThZzSTJd/3IKdYgvTXjrd
   ky4YrCDDFa2fnNxRIydvny0qaXrTqXKnx83amWZe2Bzv9tDoRs3DWdBqK
   HSfbvWGmtlOIhn8gQfIt2TEOSuztR6tKbdyZOVn6k+WKDdnc4Pd3FeFIM
   tw7OQTtMdZ4FC0Hyw9knXabDOq5fnw3H8Ahfzj2aKV3zJ7Qi1Yq423cNF
   yu6VdSpkTkOTp5z8Zh0CYmKk43CLQxui85cVOOGOPbFnEfOheUgbFWpys
   iseleDimeJ5hdSzwlv/spo3mgZO0kvdI4w/f09s4UMstfsehFTy+L6jHA
   g==;
X-CSE-ConnectionGUID: ANwPy3IuRrCV4kcr6ety2Q==
X-CSE-MsgGUID: XLO/DguDTbiYAXrRS+zWCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="21610926"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="21610926"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 13:27:02 -0700
X-CSE-ConnectionGUID: wrN5MLJyQwC1RBiuDVTehA==
X-CSE-MsgGUID: E3c0BaU2RPqrJC3+/4n/dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="85507652"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 09 Jul 2024 13:27:01 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRHQR-000X4P-0U;
	Tue, 09 Jul 2024 20:26:59 +0000
Date: Wed, 10 Jul 2024 04:26:45 +0800
From: kernel test robot <lkp@intel.com>
To: Jim Mattson <jmattson@google.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.10 RESEND] x86/retpoline: Move a NOENDBR annotation to
 the SRSO dummy return thunk
Message-ID: <Zo2dBeaurFmAn9XJ@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709132058.227930-1-jmattson@google.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 5.10 RESEND] x86/retpoline: Move a NOENDBR annotation to the SRSO dummy return thunk
Link: https://lore.kernel.org/stable/20240709132058.227930-1-jmattson%40google.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




