Return-Path: <stable+bounces-120096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F16A4C66D
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DE0164A2D
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CF122DFA0;
	Mon,  3 Mar 2025 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E7xBYlF4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B422DF83
	for <stable@vger.kernel.org>; Mon,  3 Mar 2025 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018110; cv=none; b=bzU+3HMtgKR5OhZAU4kAwPw4iJ3xrlkyZzfAEcvNesXNqbIn2V7RpGRs+jxzvs9KM05mx054tEeBLS0h5ybAev3gy5KRjTmLA2Ttw8NNzjxZnAoqtaDXGVtGWNbcV5GS2BPrGKhBHI/uCHQFdZhT+77JywN//4UXhE0eqLHgC64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018110; c=relaxed/simple;
	bh=kc4cED8BkpIe6+ORUtgVH1zeDWEgNJCwiCF9QSupIgI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AYgbs1iK2Nqgtb7l/9osT13U0Q2o+3Vz5xxp4516oPJb+oEKbClaztiDYE70jSdB4UHrZqgCCNNoWeqMT1EVop/vZyzbqkcjHrTRUplfXhRTib2wvK5WTKfZGTslEca6JIkGj3U8DmmEiu6hfRKrp93rLPI+ju15SjbFnxLlHy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E7xBYlF4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741018108; x=1772554108;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=kc4cED8BkpIe6+ORUtgVH1zeDWEgNJCwiCF9QSupIgI=;
  b=E7xBYlF4NbH3hZ+vLKq0Vnv6l252a3XFm/BTA32Qc8YIXeohnLu6BJgo
   Bx4fgeMuAYgMiFcGVL+dbvYJIeF4e16kIkbjLQ56t07XHcHu7Yw+s1aG0
   1UjMjfAMx+1UML+sqU8s8xJZxeQz1RlV3sgy27kMVIp69iHSDHXOG8kn3
   HebVslWAcmX5jVQgjHToSbgxGjxwKdVAU2fHeiEQUVZUi7aHPLTP5KjGO
   MdwOeRutalEoKWl7E8KlM4oohajTF9pcTIoDt4X+P+gYpLYBW3hLisdHU
   grdryH7Lv/2c+i6ZlC0ZFfzmdyrwtUtn79YtH4Fxf1ScliNU1dlA1k1tM
   w==;
X-CSE-ConnectionGUID: L8muzBgUQy+LvLj9vkN7Og==
X-CSE-MsgGUID: Z/JP1ackT3SHO5WpLmHgCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52106641"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="52106641"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:08:27 -0800
X-CSE-ConnectionGUID: +fGqiv2xSSS3jadHWaUzIQ==
X-CSE-MsgGUID: 2KET8S0ITiCVLocNvDJ8NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="148884876"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 03 Mar 2025 08:08:27 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tp8L0-000IgR-0y;
	Mon, 03 Mar 2025 16:08:20 +0000
Date: Tue, 4 Mar 2025 00:08:13 +0800
From: kernel test robot <lkp@intel.com>
To: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 01/19] media: i2c: ds90ub953: Fix error prints
Message-ID: <Z8XT7d3Q0dc4ygN9@aca137f0053c>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-b4-ub9xx-err-handling-v3-1-7d178796a2b9@ideasonboard.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v3 01/19] media: i2c: ds90ub953: Fix error prints
Link: https://lore.kernel.org/stable/20250303-b4-ub9xx-err-handling-v3-1-7d178796a2b9%40ideasonboard.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




