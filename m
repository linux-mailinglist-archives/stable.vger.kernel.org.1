Return-Path: <stable+bounces-47963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5618FC035
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 01:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8E51F24837
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 23:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F6A14B061;
	Tue,  4 Jun 2024 23:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dVWDW2gq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E2713E88B
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 23:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717545090; cv=none; b=dxwD0a2MJXnxIanE1gnfd9DChKU77xYw12eWknbQXLenfR1FJvU1KDeyIDV5SdaCWlEV0sjsCMuv5JrLPwFkP6LnhirqmBK2ONKJnm59UXYAjkBTypt3g2MsjXjjbfUE9KqLa/4WUKtL6unAtQf3UzCs3du3mR02kqc1m+j1lMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717545090; c=relaxed/simple;
	bh=kjVP8JIN1peBmY7UNjoqzzTQ6sDkaGFiCGFe2SYry4U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rEiBlxERr4P8IYSPKt9/K2AnCdHDnL/idAiwmYfbj6jnmT6S+3kNbiYfzJfm5OIWZ+vCVpcC7RDjVndS6enJ3hhtO0xobwzUTG5I7gi5JXAJ84qVcfmtnco9qp+pymyWytRNNdyKEaAJzyCsMRpfI/WbmKPZSWN66pyfjSVl+X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dVWDW2gq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717545088; x=1749081088;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=kjVP8JIN1peBmY7UNjoqzzTQ6sDkaGFiCGFe2SYry4U=;
  b=dVWDW2gqXyTIuOBd6yw43IHbdpGB18JWCTkMSr2CcpmFV3tLklLhtpPX
   RezfImM/hECD2fWHunq6BQVGo+F3S6wAEGT7PMqyW/GU5OejO2SIYf9Ca
   AGVLjO9R7JbCIiQ3Bf1nVKVtqsdJf6ap/0MX7ATl9dITZpnlQXv5INq/A
   74ycGsCSTVBGMvYZt7iM4NoGmuAREZI158Z+RLzI3+1P46fC1B/Jzw6br
   mORkNe8g0mFpS9fWr7YUUX7f6CFj6Cr3kXdX9Yh2MV8Hu1FoccCoP5WWw
   muvKJg6sW3//0A9mmp8GWx5qDTDXilW+tS16PE+TGn5fKzouZ8Zi8uqNJ
   Q==;
X-CSE-ConnectionGUID: kDcBECRAR1e1lA3eJGC4BA==
X-CSE-MsgGUID: mx2EV7VBTzeUTpDq4h0bbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="17062814"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="17062814"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 16:51:28 -0700
X-CSE-ConnectionGUID: tBTcGwnFTc2AEJxlHEWa6g==
X-CSE-MsgGUID: 2D2QbaU9QM+ZT0WSBbHnEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37845860"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 04 Jun 2024 16:51:28 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEdw4-0000gh-30;
	Tue, 04 Jun 2024 23:51:24 +0000
Date: Wed, 5 Jun 2024 07:50:25 +0800
From: kernel test robot <lkp@intel.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] mm: gup: do not call try_grab_folio() in slow path
Message-ID: <Zl-oQQSX6faygMRX@242c30a86391>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604234858.948986-2-yang@os.amperecomputing.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 2/2] mm: gup: do not call try_grab_folio() in slow path
Link: https://lore.kernel.org/stable/20240604234858.948986-2-yang%40os.amperecomputing.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




