Return-Path: <stable+bounces-12290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC5A832D71
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 17:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355852849A4
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A2D55760;
	Fri, 19 Jan 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDJ6ymhd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F76655761
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705682712; cv=none; b=smZgQ2jE2Lyp13IcumqPxjz3FxoEwlAAngYAP5bm4fayYMC+mjH9Xh2LujTlomsEoKiBoxb6FZN8udG60bZJG4y20omPpB7AuEsuWUAaGS5Yw60h53c+FvZs4bAryqvGBcMrJ3NyU6GcqsN/ZhaFq8vTf5EfTG6rYn7/sfiVXjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705682712; c=relaxed/simple;
	bh=kiRZ/O4Wwrk1VZ7h0YeAWN9ZmE1sqEfzjM0bFC5j2Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OiPlQD3Kx8FYfvFZCr4FTczOUZcIxfg8vcdMBcB+pYFM72QCNlo9KdxW7hxOLxzSxYBYnM7ukz0hT3YMSs2keUJLDwm5qPddFF3IU9mJQLx/Gq132ZX0L6AJys4haizoQiOIVSbiZoESkmRLSt/yutuMNGBmsImJM2ad/10/h+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDJ6ymhd; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705682711; x=1737218711;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=kiRZ/O4Wwrk1VZ7h0YeAWN9ZmE1sqEfzjM0bFC5j2Kk=;
  b=kDJ6ymhdZ2jOvwTXrIzzXSQ8LhW8QuwXVI+3inVvDdJaZXajxJjTpls2
   n5B3OEDCt+yEpGRJUrCEt1smC97wmiqJEz3IlzBKWByf4YIXjuYJOdXj1
   Gs08U51gqEusd1r+2K3JtcCECkFwTlZzLL4E481clhmFTy0SRNYuqrQUJ
   PnERK0qfMs0jSU0oQ+qEBvBZJLxmj9nTvGHaPllzeIJg6NP1gdY2gTdOu
   wBEfZGzYN0DfQIol6BxJKq+sBmzjr7Z67rmqBlrylnrct2V7PuYa92ZTd
   8KFCUWHDv5Oi+J226IupqDt00yLhahSfEp3Lrf8X4LpIVUEg4oxb9dQK9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="400442288"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="400442288"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 08:45:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="788396511"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="788396511"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jan 2024 08:45:09 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQrzP-0004Gi-1m;
	Fri, 19 Jan 2024 16:45:07 +0000
Date: Sat, 20 Jan 2024 00:44:07 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] mips/smp: Call rcu_cpu_starting() earlier
Message-ID: <Zaqm12Nfvj5souqU@d42765ab1e58>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119163811.3884999-1-stefan.wiehler@nokia.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] mips/smp: Call rcu_cpu_starting() earlier
Link: https://lore.kernel.org/stable/20240119163811.3884999-1-stefan.wiehler%40nokia.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




