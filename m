Return-Path: <stable+bounces-171975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B78B2F778
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEA9A07838
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DE730F531;
	Thu, 21 Aug 2025 12:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YugAfNME"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A36036CDFD
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777731; cv=none; b=eHUQ2q+jfOwgOS1TrHmXEXuzWUny5VzQFeBaDs7JnbkxeTj5oe+kfVxm1G3mrLkLW14eo40zOX08yZA7j3fA9ZWU+IPuAz6EKFb4Xg942DDnCbea/dAFDcsUuFO7IGS+nNUErcSopHYqCVXxeqgvtwwKqfhd5YmgijYJBJYMEkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777731; c=relaxed/simple;
	bh=UouF0ShtIJgZP83mYSRAqaZbDzYFAE2Uz1qWnnAfXIE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Mm0jeJHmhiOqhAserBODz8Gj7iXffvw8i9wR3970+fQL7bxp/yMprMPpktiwTGZ//m7iqI7lWNL2YPJxEM7jGCnnNN1OLYdAdff5CDts6rerDVkHmAbFctp/7YasNOTg78vW9eJEx7jpw3QmJX5SwDMoqxUWCVpvRJurVwTlSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YugAfNME; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755777730; x=1787313730;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=UouF0ShtIJgZP83mYSRAqaZbDzYFAE2Uz1qWnnAfXIE=;
  b=YugAfNME13IpoHG4nhJiD+zC72CWtxTteSV11cHpXBtV68gWvjcul5Ue
   i+Wn70Wl+45UuVA6MU9RVxKWJieLZ24Xe+WONW22HQz5afRMidqW7PLoa
   WGxGZV09xrqLj7dQ/yADdQirDq3AqJL2rqAaxD9wWd0DYInyXX8FVjbZz
   sGh/hPaAktnNJYTiA7gYSAvtTlEL4dToJCzD3Qf1uUZ7WO9cAdDzyLUKd
   vTPEHK+0e7UFYfwVYbOt+yEpI4oGkB/wNzLOcN3bQXfHSbbQQuBRAwyyd
   wjFi0ikG0k+J1V8dylIOxFfGR77Q647GmJ3cUPwGKbUK9mPCCQS+Z4bdy
   w==;
X-CSE-ConnectionGUID: IuRkrChfSuueTr/yf0uaOA==
X-CSE-MsgGUID: uBm4KdhIQHOa6fkxo/ufhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69502918"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="69502918"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:02:09 -0700
X-CSE-ConnectionGUID: JLa5TFBsRXyFJkDDZ8RsAw==
X-CSE-MsgGUID: CqjzcpFgQXavI3qbV6QB/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="173736405"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 21 Aug 2025 05:02:08 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1up3yB-000KFD-0q;
	Thu, 21 Aug 2025 12:01:04 +0000
Date: Thu, 21 Aug 2025 20:00:00 +0800
From: kernel test robot <lkp@intel.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] mm: fix KASAN build error due to p*d_populate_kernel()
Message-ID: <aKcKQGNduY6a0LuR@85d67d3e4d56>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821115731.137284-1-harry.yoo@oracle.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] mm: fix KASAN build error due to p*d_populate_kernel()
Link: https://lore.kernel.org/stable/20250821115731.137284-1-harry.yoo%40oracle.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




