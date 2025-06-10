Return-Path: <stable+bounces-152275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E80CCAD34D1
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 13:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0CF3A45DB
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 11:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B213B223DC4;
	Tue, 10 Jun 2025 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQvk4hM3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2142224896
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749554344; cv=none; b=NBFgrkDxboEZVJJyRpCZrD/qsTGrorX5H+MUmHZL6YhPRoOUwnvANgzrhLgzrvWJtWEHraGhHYjz/f6x6uJV4aPcV4mDmo4LqQzZAFFqtdhRWkxQIjA+G+8ZVdW6eBHvqvNXfVIqryrsZA/XZwP0njcGEPH5SDgfCvcta7tPQ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749554344; c=relaxed/simple;
	bh=GHG+qHyPYM48pCVxWREHC3Tl7CwyTq0F7lp2EkNZzjA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HFplLNTAj4HPm9Wt/fPugr/P9q0R1DeObbENGpAcW2wv7M+SRlrQNJEtTdk/vnp5EJipXfG71pJ0u6/cHP9m8hg+siulLvftL4N+oJyt9xpH+OPhmf2UrRqIvj/vQ4SLT4YTQdRcv0/IqaaVag/2ogPaLWYABFlBemUkQCaNK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQvk4hM3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749554343; x=1781090343;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=GHG+qHyPYM48pCVxWREHC3Tl7CwyTq0F7lp2EkNZzjA=;
  b=DQvk4hM3WRFia9MyQd9t9VWbM03IZPM1nC5B5zhivCdEtlJflF4qk8uV
   Fp5kjvyCIPZxeKzDGS2qdQY0QeqrloEu4ncigYb4pAswMsMV8KkiNA7vG
   C7u7sGNw2/x5TZw0nt8FI9GbSG2ZykvuTo0UnLw4NjyTT1tktJMc3NBZb
   uBErb/kbPX1Jti+GRsICaOPHMB3VGEGca6C23IQmzQeP8TDLrLY0CGryo
   7NFHuuSb6oFGeEcwMSjPx1fo6x+mYrWJw9z57I3ofuU8jzMdRymS5U2Mr
   9v8kUG23I71FWB24gm3yPWu/pOY7P806otGsK3NaIhbpCZtlpBEgYCogC
   w==;
X-CSE-ConnectionGUID: i6gN4O3ERaKLY5Awxgsz4g==
X-CSE-MsgGUID: AlQ8IqHpSsKWY9aLXrsqCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="63009439"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="63009439"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 04:19:02 -0700
X-CSE-ConnectionGUID: znjvTX5CR9+jdOyH2YUfNw==
X-CSE-MsgGUID: 57xcdhzTSaCbmEpwUmZMoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="152062489"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 Jun 2025 04:19:00 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uOx0M-000889-0t;
	Tue, 10 Jun 2025 11:18:58 +0000
Date: Tue, 10 Jun 2025 19:18:47 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1] xhci: dbctty: disable ECHO flag by default
Message-ID: <aEgUl--oB5IHZ7aE@f0aa6ae54308>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610111802.18742-1-ukaszb@chromium.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v1] xhci: dbctty: disable ECHO flag by default
Link: https://lore.kernel.org/stable/20250610111802.18742-1-ukaszb%40chromium.org

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




