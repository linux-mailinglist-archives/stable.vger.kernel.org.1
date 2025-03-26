Return-Path: <stable+bounces-126674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E672A71092
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 07:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9EB13B9102
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 06:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907CA188734;
	Wed, 26 Mar 2025 06:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bm4jkbKP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0EF18B47C
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742970693; cv=none; b=dttL/FtPBl0SkFCxu4d4vdfECfHYym8AQoz0z6a9pveH2CEyMJAzHPRD2TMpdH2FUvkZ0vIJ2I5T9GeQCZlyXlL+qBdl4AJIKC8DaogGGfF5sMGqNR94pyVdIREZkh8FhY78iX5tDY+I86a7hoiymCR+wsw3l7HtI8vsF/KbuXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742970693; c=relaxed/simple;
	bh=roWBtRa5o/fsslyXy3qsTGigKgIFZfGCG03PRJ3DNPk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jsJZRZCtXX7kEaKLix5fbQrxoJXrPRMy+wufMhXA9rxyyaz25mo8Rqzm5rpkzNXbnLUE6L6cJppxGQwe9RGAVBPIFaUnz6rZr/qgWtfk3GP4InHX7c+1mclGPgy8VTCwokqoxZ59nGfs/BOHZQBMlSghFLM4X6VNYAks23PMzbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bm4jkbKP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742970692; x=1774506692;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=roWBtRa5o/fsslyXy3qsTGigKgIFZfGCG03PRJ3DNPk=;
  b=Bm4jkbKP9PYxcQDQgGWOUu9cjKp+tqQ9LBoxrNqwXmJufPzA5tTYpO89
   pi3Kz7pIQVW7V892pGgOe+4CeHjs4LZw43zX0GnOaFdjN3nm3kwmbCrt9
   wv2CGazS+/tvjIVwk3COzYcKyka2YPTX1MKa+bxL0YeDSAYuUNZJI1ZvX
   RnsPW81aZ2ksy+U/BcL1J9mSChmhi1acBGu1rYS/3v2mehNYuEdLblD2X
   O6IxdSq2L8jdQud6em7GtpyHdjIXqNw0b5KuaX9Gcmei9HbTk2hKVd3FQ
   mka7Ab6mVh+yFMlh96lVU6YGH199X3kw6xC1n9FCyakXOO9hNVjbgp/X8
   g==;
X-CSE-ConnectionGUID: UiEPD52BQM6TYF5gI5umjg==
X-CSE-MsgGUID: HvRbRGIbSFOIqyjlb/3hsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="54445408"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="54445408"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 23:31:32 -0700
X-CSE-ConnectionGUID: OJA5iKULSj2OTE8VH1UV5g==
X-CSE-MsgGUID: WTDZqWFUTNCYPblnUTKFSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="129320658"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 25 Mar 2025 23:31:30 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txKIS-0005VW-06;
	Wed, 26 Mar 2025 06:31:28 +0000
Date: Wed, 26 Mar 2025 14:30:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 1/1] x86/fred: Fix system hang during S4 resume with
 FRED enabled
Message-ID: <Z-OfGoPRG2m_ZW97@06395982a548>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326062540.820556-1-xin@zytor.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v1 1/1] x86/fred: Fix system hang during S4 resume with FRED enabled
Link: https://lore.kernel.org/stable/20250326062540.820556-1-xin%40zytor.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




