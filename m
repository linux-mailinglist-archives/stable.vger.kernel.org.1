Return-Path: <stable+bounces-67643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CA3951B92
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 15:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B05E1C2104D
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 13:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202861B14EF;
	Wed, 14 Aug 2024 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJz9oeYv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F901B14EA
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641129; cv=none; b=X0CabuSbMNPVKQHmTvx/qHSCrhu5WZNUbSHC9VSEy32Lf0CfDgdPGMDgo+xq+SXKx8cMZUCAJgmP6oO2sUSKI7/RyPEpiUPdABb9Z9BSNJa/QH+irXKiyp512jhN/rbuq6dpCC4TTkUGtmSevWDQ46c199aPRQZce7o4hLvzCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641129; c=relaxed/simple;
	bh=T8NZkfxMgiA00BiThOjEU5suAQFMKHoCmV9Akdc6Apc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q5RJBSMIeziAtf3MylQtSTvYmrBtGwzDnm2RGO++0UQziv1bywyg3b44c5xzHAWT1qaeXy0x6/80bgCMJQQvDOyMJrYO9qYpj3b0ii42RVpC1saKg9s+zg2oVlW0BKTyBLiTLvGGdnEhkUJoubYg48zzFkfcZW0evBvAyK3STMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJz9oeYv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723641127; x=1755177127;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=T8NZkfxMgiA00BiThOjEU5suAQFMKHoCmV9Akdc6Apc=;
  b=FJz9oeYvNgbruxpu9dva81bzio8jCSFvVo3l4MeERQbIWbGXpG2uJNkh
   3JfbCRCGmPT/DxDWM+o2iS0oeo/M8jJltpOquGSlibjtM2+/0wChJ0LWX
   PyCqKsF8bDvBkoJEpsTkOA7Lhp9Vu0s2JiE64qmEYzPlaZOyCP5JrzyOQ
   6Oa2PLTFQNWOpZnEKLDlB9DT75FwGffjmc3OEQW2JeMCUuuQRHJ5+HHPx
   Fer3bl3SithhjzBBnXPLRRwhrNExfbAefICWsCtHb7B2CAAAkVv6EDKTj
   y5PK8id3lEDNwlBEOY2InHbl3UJuhuVVmE9JOG2AtZYb7/ZBtEnGL5lnZ
   g==;
X-CSE-ConnectionGUID: lm2Jj6iCTWe4h8y0GUWNyw==
X-CSE-MsgGUID: 1TYPLQJCSj6Yze/okBeteA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="25659280"
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="25659280"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 06:12:06 -0700
X-CSE-ConnectionGUID: QsOFN6JdSRGWPaqNvRx0yQ==
X-CSE-MsgGUID: Hmg2sNswTzqzIb4dhhi6+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="63895569"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 14 Aug 2024 06:11:50 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seDn2-0001fv-0Z;
	Wed, 14 Aug 2024 13:11:48 +0000
Date: Wed, 14 Aug 2024 21:11:09 +0800
From: kernel test robot <lkp@intel.com>
To: Yihang Li <liyihang9@huawei.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3] scsi: sd: retry command SYNC CACHE if format in
 progress
Message-ID: <Zrys7W6vp_B7WhvK@6bf3af7eeac4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813011747.3643577-1-liyihang9@huawei.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v3] scsi: sd: retry command SYNC CACHE if format in progress
Link: https://lore.kernel.org/stable/20240813011747.3643577-1-liyihang9%40huawei.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




