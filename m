Return-Path: <stable+bounces-169399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1E8B24B47
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 15:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240AE1B610C7
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 13:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5652EB5C4;
	Wed, 13 Aug 2025 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAwj9hMe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCBF2EAB68;
	Wed, 13 Aug 2025 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093170; cv=none; b=QgHIHTLppQ17kxyZJzhLZbWTPzCM0hRYVJ9D+nnM5haKednXYJiQFqXbgWoGSDTD4gBUYbY/MZjRvpsRwXQ45qKohY5ESmuYoS8KRv6xlH6B8+02jEVn4sZ/RpNwmHOttdTJrI7x3f0Zk9PEkLSDshqWNNDIiysf/zW3yJMahAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093170; c=relaxed/simple;
	bh=yRzIBpcwo03V92Cu9B8zeqXJTartIC1MviVhaIBxQdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9YUhWaLzKBnG66U/zaEyxT6yN/eOt9KJWc4q5a6PGOAxp4rXQJFY7Gi8mHTuGpsZaqmXTqXadelceGFwUjRsoearY2pb9MZULTuAfLmRzOP7CNWpno9X5jhYV4rGeL4qvBiosWM3RBNKtE+7ZG/vk22Yiftb2wan/WKk05GHaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZAwj9hMe; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755093170; x=1786629170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yRzIBpcwo03V92Cu9B8zeqXJTartIC1MviVhaIBxQdM=;
  b=ZAwj9hMeBbrlCEqTO1etqD52Ib7zYRuFfbkqzsVrMfKiNpQRlEPFCXGn
   3nIOvMchcMhGBsxiAH9Kt2iX4/9H4G4RYXE434AsGeKcuAtwy3PXYGnwy
   4bgJHzoYiEp+cb2DvpmEGtkiaPy+nVyQ5hoRntie97P9KMoNSj48OlRGk
   L4CDHVaLEm2HXbZt4KZdTbdXR3E7ncapUlFhlRmJXRWTqrQKKcGDI2iTW
   Y/MCDxfioY4Ut6THrPCEElSadYsntHEeh+e+DH+B8DJaIXnXKsfxVwhSp
   bt9MNyzoC8EusmhT6ok2Sw4zXOxoSd8fgNV58Fkl3uzYTGOvPouGm+eUI
   w==;
X-CSE-ConnectionGUID: WxwWpv4/SxeMt2n2Nl4x+A==
X-CSE-MsgGUID: mwuitVOTTWymQsL1rl8Vqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57289139"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57289139"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 06:52:49 -0700
X-CSE-ConnectionGUID: a6XmckWnTmOaZ0W7wn/o/A==
X-CSE-MsgGUID: 9CE9RbIqTnCtSYCj/rZ3aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="170928900"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 06:52:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1umBuB-00000005RqB-41aP;
	Wed, 13 Aug 2025 16:52:39 +0300
Date: Wed, 13 Aug 2025 16:52:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Maximilian Bosch <maximilian@mbosch.me>,
	Ryan Lahfa <ryan@lahfa.xyz>, Christian Theune <ct@flyingcircus.io>,
	Arnout Engelen <arnout@bzzt.net>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iov_iter: iterate_folioq: fix handling of offset >=
 folio size
Message-ID: <aJyYp-3VA9kJ5YMd@smile.fi.intel.com>
References: <20250811-iot_iter_folio-v1-1-d9c223adf93c@codewreck.org>
 <202508120250.Eooq2ydr-lkp@intel.com>
 <20250813051633.GA3895812@ax162>
 <aJwj4dQ3b599qKHn@codewreck.org>
 <aJyVfWKX2eSMsfrb@black.igk.intel.com>
 <aJyW_QNI8vIdr03O@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJyW_QNI8vIdr03O@codewreck.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 13, 2025 at 10:45:33PM +0900, Dominique Martinet wrote:
> Andy Shevchenko wrote on Wed, Aug 13, 2025 at 03:39:09PM +0200:
> > > I assume Andrew will pick it up eventually?
> > 
> > I hope this to happen sooner as it broke my builds too (I always do now `make W=1`
> > and suggest all developers should follow).
> 
> I actually test with W=1 too, but somehow this warning doesn't show up
> in my build, I'm not quite sure why :/
> (even if I try clang like the test robot... But there's plenty of
> other warnings all around everywhere else, so I agree this is all way
> too manual)

Depends on your config, last few releases I was specifically targetting x86
defconfigs (32- and 64-bit) to be build with `make W=1`. There are a couple of
changes that are still pending, but otherwise it builds with GCC and clang.

-- 
With Best Regards,
Andy Shevchenko



