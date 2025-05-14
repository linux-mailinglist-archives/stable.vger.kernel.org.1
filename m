Return-Path: <stable+bounces-144306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7B2AB6227
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 07:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F6E1B440EE
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 05:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97141F4611;
	Wed, 14 May 2025 05:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHSTyjnG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA28E1F3BBB
	for <stable@vger.kernel.org>; Wed, 14 May 2025 05:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199628; cv=none; b=O16qvacIBMh+Y37lE8/pHoYP1c6ljyGspTRNLiDw49cTac3EdR39gVEA0Elx5xiHjQ2ivC67xMQu57lae2eHlK1dkH+iRW25wF9JO8WiHJEGz01BXJt6LmfrqszRrKKdb7jTwbImmhHfCbtjMbiMpkdljFY+03WgS+JFu+awQlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199628; c=relaxed/simple;
	bh=47lOjf4Nx59xY4fGA/g1In171qR64RKWgiryJ142M44=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sf6QGWHl/ns7l56BCiI3F2DFFjA2+ruUW+v/nkJ6jxP9Bc/Hfmydq/O5F9CoAdVB9XyjWaQXaZD014GWm6dyYrXIj+rbzsniMw2kd4Hpng/SJe+ad9mxKL6fSJTSjgxDn/MOvTVFzmKjzBYv4UD7N8wIXXNwjze4JNStBbbOk5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHSTyjnG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747199627; x=1778735627;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=47lOjf4Nx59xY4fGA/g1In171qR64RKWgiryJ142M44=;
  b=UHSTyjnGest1mkA9OJquREictLcN7Ddn1CgnJ6IRFVvmsMtqok17nIb3
   Yul5gZFf6JhONqpFw72LkbDXsAxjJ5IpJGDGMu481LZGsJxPoVtLCmlDJ
   FvYjYJzcodksRIsoqr/OEpthv7C6OBjpACWT9OdNhA2TVUE0HGMDfly7q
   5WxX2gGDxbLQ8fkSgzaHTfj4NRSFCTZaS028XHNmoiuRc/qAHu+oYfC22
   hL+7W6EV6YpJ3FIy+YuYLZl2xsKAA1ohrCdhpgO8qGOtdFS87ckC5WPYp
   PF6/MM421DiBAMphXVf9X1CrS2J01VVo6T27qezO8LGbu4yiv31CwuaWV
   Q==;
X-CSE-ConnectionGUID: ZPX9bIqwQI+2XCEpBReKbQ==
X-CSE-MsgGUID: 0JYiLUtUQYinUw5B2TeNjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="49056035"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="49056035"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 22:13:46 -0700
X-CSE-ConnectionGUID: q3uS2N3dStOcTMdFNY6/bw==
X-CSE-MsgGUID: oFKeLhAVQIyOV/Ksca9WSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="138418373"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 May 2025 22:13:45 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uF4R5-000GhT-0Q;
	Wed, 14 May 2025 05:13:43 +0000
Date: Wed, 14 May 2025 13:13:28 +0800
From: kernel test robot <lkp@intel.com>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/4 RESEND] crypto: octeontx2: add timeout for load_fvc
 completion poll
Message-ID: <aCQmeDeJJZ4rFYbB@75fa4dc5d8b3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514051043.3178659-2-bbhushan2@marvell.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 1/4 RESEND] crypto: octeontx2: add timeout for load_fvc completion poll
Link: https://lore.kernel.org/stable/20250514051043.3178659-2-bbhushan2%40marvell.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




