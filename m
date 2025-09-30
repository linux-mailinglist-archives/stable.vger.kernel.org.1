Return-Path: <stable+bounces-182014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E29BAB1E0
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 05:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C351C2F50
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 03:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA8A533D6;
	Tue, 30 Sep 2025 03:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BynRvaeS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4626427472
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 03:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759201368; cv=none; b=AROyKr/s9QYiGV9XTiTagwqMS5IfnUu/NeLrc46NwvCDWwpJrMiPediEw8Gg4NRLXIwM4kjuDWpXmDWIamEfAVeFYMfj9MxJyah9EePTBSRVokNOsWK6YuM9//c77h/ktcHOynK8HjT0DWNOgmkRE+eyVqPhg9alvfoiVM5hUag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759201368; c=relaxed/simple;
	bh=on5g77PuZQQkoQd3EtOngkMohMT+XU7hI06cwtN2RFE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M3LycXR+sq8H49GiuHb5QtjBWlbJXNis5XNJyWB2AmJuUOtzCeLK/+NrPbopN8VAYXU6ltnNTulM8nYLyGk5HybiYlhKZ/lxxHUm/b3/rPL0IQ31NyOmDK9Pd20wKhkIO0gcqNmvjX6efdngPJETYDQj/0vkn2kF+LPwLMbwkFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BynRvaeS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759201367; x=1790737367;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=on5g77PuZQQkoQd3EtOngkMohMT+XU7hI06cwtN2RFE=;
  b=BynRvaeSRs9RhIWQisyztfFTVudhFsLnSzokJA+LDf+zlyJt8lYPL+JS
   bNcon0zKmJAWJS86aMVE+JKlJNM/mEN9dkBUnoEToYQ2Z06blc/hk/1Nq
   l8OsxLIKM/Xy/07Qy3ySW2p9NqAA5SYHp6gznDqMPQqF/aTVIRHem3dyM
   QNrb7ngBWEt9oGRU9fgWONmeDthGvcoHFozxezi1gNDFQMy/tY8RPZbi2
   iG9KuOPdt/IbzRbuiHNyaUE2StvEQXbN0rUTUeqBtpUbh1xQOe9rCvRnN
   AUdO5mTgubojONovsD+x31XnCmR668DDogcffUpGCmjJEpBSY4tkh9S3y
   Q==;
X-CSE-ConnectionGUID: H23Dsqc5TdCuiEfflaawuw==
X-CSE-MsgGUID: Pse7VcmKSkCqh03CGfXsuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="84064305"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="84064305"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 20:02:47 -0700
X-CSE-ConnectionGUID: pDp1QkE+TrOCXp9AZYJ0Lw==
X-CSE-MsgGUID: Gu5+VIELS76A4ZxT5ggl0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="182683881"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 29 Sep 2025 20:02:46 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3QdX-0000rj-1G;
	Tue, 30 Sep 2025 03:02:43 +0000
Date: Tue, 30 Sep 2025 11:01:57 +0800
From: kernel test robot <lkp@intel.com>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] net/can/gs_usb: increase max interface to U8_MAX
Message-ID: <aNtIJSwcpQVqRO_x@d6e5159408f2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-gs-usb-max-if-v2-1-2cf9a44e6861@coelacanthus.name>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] net/can/gs_usb: increase max interface to U8_MAX
Link: https://lore.kernel.org/stable/20250930-gs-usb-max-if-v2-1-2cf9a44e6861%40coelacanthus.name

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




