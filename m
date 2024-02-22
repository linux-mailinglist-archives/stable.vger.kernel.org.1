Return-Path: <stable+bounces-23304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A32785F32B
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 09:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA938B249F5
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 08:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B274820310;
	Thu, 22 Feb 2024 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmCoHrEh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F49653AC
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591262; cv=none; b=cDwslTcEZ43sWjjUf2GsiuWWXXEFPCtIZAgEeeJpFYzcfGdnlayC4dOIZboubzoIa0S0PHIwsTaYdxBAw90gl2kGGQPUpHV773mrN3XZyHMVI29p76NsI3c79wDq5QN6x4M3zjdeo6WlkelWR1O0lDYCT56hzom+slinhRKhKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591262; c=relaxed/simple;
	bh=l4WIYEVNHIN0cqL/plNgMxkm70NQFEHekdqMjSt+xkY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k++8xk5v5Mi/XDv7X9d+DBHVwv/P3KtH14Ry4ZiGCvi31chw7HvWFr/gjIKJv41xcY+wT0RsEXTlDZLFgI+P9YAzRtoYEFhjRDzfczkKbE7kk+UE4Rv2JTx12N9kbCrqaQxLNco45M+JE59LQN+ssXiG4hPyZDF74pRjHB2alNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmCoHrEh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708591261; x=1740127261;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=l4WIYEVNHIN0cqL/plNgMxkm70NQFEHekdqMjSt+xkY=;
  b=cmCoHrEhEkXK1woSsyd+c9GhqBVMPKbbUGqQKL1nWbhsF4xAWHjLjCM+
   2nrsxfHwRheDvj26CxORvKq5pZKa5YsW9+uZisqQS2itOJFSvE0oL3er/
   Jmk8Fg45jJh/of6VdEwTnoOgxNsWew9BePlPOXONWVxTFXcAhxpWJPHco
   VNuTG4Ha2LmUXz8p3PpkWH93cdpVSDfjLXUirvNAs/ER/bt9m86YABDvx
   Xh84CQh9kttxkA7KhoIWglXXY1vxIi1tJ3cWYzcerjmQySxdxAdMlAwZj
   sjmWeBzwCIJE9esQbIYBsbgzQHz6CbqEhS74q5QNKNCu2fgq92hNr+zKm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28244612"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="28244612"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 00:41:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936815565"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="936815565"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2024 00:40:59 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rd4c1-000683-1p;
	Thu, 22 Feb 2024 08:40:56 +0000
Date: Thu, 22 Feb 2024 16:37:56 +0800
From: kernel test robot <lkp@intel.com>
To: Shivnandan Kumar <quic_kshivnan@quicinc.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] cpufreq: Limit resolving a frequency to policy min/max
Message-ID: <ZdcH5JcksuHW755h@fdb2c0c3c270>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222083515.1065025-1-quic_kshivnan@quicinc.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] cpufreq: Limit resolving a frequency to policy min/max
Link: https://lore.kernel.org/stable/20240222083515.1065025-1-quic_kshivnan%40quicinc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




