Return-Path: <stable+bounces-115048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2972EA32643
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 13:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51D21691B9
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8051A20DD48;
	Wed, 12 Feb 2025 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xa0wG5+M"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51720DD4D
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364654; cv=none; b=bb4cXsQbeuukYjhSB837l8PP6rxOQTsGEhLEvfTGmB+BX67cVL7RVtAV+kiYzKEOcCaPR1BYzq/bPZaSWBob09C6qaTHoPoiPEQjJlGPnZujlCmtpgo6RMWvraUPH44HcMJ2/up1o7W5EGcJLyLrVQEXeL629g2UKdYMLJxAopA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364654; c=relaxed/simple;
	bh=Pgk//nDMo7FMZG8BzPQaJt0b4UJPww+RrERA2MiMrsM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V+oFOWi+dFnCsrtUgNF5IMQdpG/mChoAAY0yAu7/FXsLLj7TE+q5rnBralNEi5m4DxthkYeLh+KaGLGar2XHmWZtOYgbSimUWNSAZgVoT3ELZHWFdeCFomP9OpB6ldZuXWiFqiQoQ7JxpMyA1p28Z9ZNtS+xruFxmZcAgCbF1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xa0wG5+M; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739364652; x=1770900652;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Pgk//nDMo7FMZG8BzPQaJt0b4UJPww+RrERA2MiMrsM=;
  b=Xa0wG5+MAzyFW9r062cFHIk6csTYsqYC5GVBmn3gpZB7bU81I9nyYFzh
   JOyp3jAKY7o1EFbC2m6XfrRxOYLvVjP91H4OyqJePR4n9+t1zVeDF634I
   nXNRYC1H2Gomn1VrZEeHxkRsK1PXNUiug7EXhTfvO8G6/FYYfyCz19mbb
   RCVKZRO2z6F5/J7NTpmPejCsMUqlkVek9E1mj0tD5XX/BjQVqiwvigJmu
   bf6GOeKQdm8llBIUm8K5gDNhKK/bhaqSX3r/ZhuP9sQrNO+67MGF2JK00
   h9MKvkgya+mpMCsOH6352tBGjJO9MGrGJdqlvw44DMhTs2qrcnXIiXhgS
   g==;
X-CSE-ConnectionGUID: E7cJD5u0Tmun3dCwz8QZiw==
X-CSE-MsgGUID: sKWb1i/bTX2NDoo9eF6PGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="65374368"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="65374368"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 04:50:52 -0800
X-CSE-ConnectionGUID: 4Lj7gAQgT12VxqUPUZ/EpA==
X-CSE-MsgGUID: y7uq42PqSyq/v9SNFBu+6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113720153"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 Feb 2025 04:50:51 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiCCW-0015cF-1g;
	Wed, 12 Feb 2025 12:50:48 +0000
Date: Wed, 12 Feb 2025 20:49:52 +0800
From: kernel test robot <lkp@intel.com>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net] drop_monitor: fix incorrect initialization order
Message-ID: <Z6yY8LAeUa8s2H4G@daa8e4f1ba6f>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212124653.297647-1-Ilia.Gavrilov@infotecs.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net] drop_monitor: fix incorrect initialization order
Link: https://lore.kernel.org/stable/20250212124653.297647-1-Ilia.Gavrilov%40infotecs.ru

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




