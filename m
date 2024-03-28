Return-Path: <stable+bounces-33095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D548904AD
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 17:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72951C22B33
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 16:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A935481AC8;
	Thu, 28 Mar 2024 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+q/biXp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B849E8004E
	for <stable@vger.kernel.org>; Thu, 28 Mar 2024 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642352; cv=none; b=Ha+WOqp7Hob8DdF/HBb+0A32S6kk1lTGO378yqi1m0CigMcAGznVLO3e4XcTCHWDWMOgAUlCvZCnTMIQ9sYP77gTP8Sda00RuXPxv06g2hleCXDQNm249bzHnTGyxN9LfPRLXJ9uX12ne7a7hru/W0oNtu87nXnzOt8HUGtXx34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642352; c=relaxed/simple;
	bh=/8GP8z5umjlvZRYL/u0lQ5WKvxrXJn0bO0Gwl6xJAiU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cCx1MS+qpghgQpGB3BnjA9f84pUVVlTWGnq5+qXgPSeZGGuxHqSV6O6YBW/HGu/LonSolSa5fxxLcoQHkwtQD8GT4p/Gi6ps/QNKtTZBhXvzHtDO05+VWa4LLPC+M+FWAsr1/ynnNgVy4xeVILBKXlWwyUhxlVY5QtTWMxLEbkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+q/biXp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711642351; x=1743178351;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=/8GP8z5umjlvZRYL/u0lQ5WKvxrXJn0bO0Gwl6xJAiU=;
  b=i+q/biXp9p9GO2VnU5zCtrjJweF1r7VPurAor4eaD321PZ49i5NXKS+E
   tY8x5+GgnJp6q1m6am8T2+CoXbfet4ORCH0ctv6QDUTpeecAoiJNK1QSN
   tjzfEPyYdyj438cRg1w3tJhNd+Y0bh80tss3ZLmtmzNT2ofnDBeU6Y4Su
   /wx9qb+v4Ah3Nnl9FZt4q7N/LCDTx5U6NA99Jqo+pdnu8V3w6hx1s+grK
   MedsmJOe2nsdpbwaaBMFHD4yAQ0ZmP0hyJsDGnoCq6EbaoneZH4ur+wdK
   f4qXWjBz25Nx8GyVixq1hoo1Hg/UpQZIpBdxYdTMf02NJ9GBO9/tA4iPg
   A==;
X-CSE-ConnectionGUID: O92FgNLpSHONJ1S7Ad5vLw==
X-CSE-MsgGUID: /0NMZy+DT9CxhlA70GQppQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6921831"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6921831"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 09:11:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="21367075"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 28 Mar 2024 09:11:14 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpsLP-0002JE-0S;
	Thu, 28 Mar 2024 16:11:11 +0000
Date: Fri, 29 Mar 2024 00:10:48 +0800
From: kernel test robot <lkp@intel.com>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4] x86/mm/ident_map: On UV systems, use gbpages only
 where full GB page should be mapped.
Message-ID: <ZgWWiBzhrvHMPjZd@f34f6e606ddc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328160614.1838496-1-steve.wahl@hpe.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v4] x86/mm/ident_map: On UV systems, use gbpages only where full GB page should be mapped.
Link: https://lore.kernel.org/stable/20240328160614.1838496-1-steve.wahl%40hpe.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




