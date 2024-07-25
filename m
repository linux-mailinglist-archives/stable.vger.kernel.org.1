Return-Path: <stable+bounces-61429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6137293C2E5
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 15:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E861F2209D
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 13:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF14225CE;
	Thu, 25 Jul 2024 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJen+aId"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F1FC8DF
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721914089; cv=none; b=dZPEFi6v11XdcV0t9NSp/cgpeXUGn+QiRWd/xSUydzOlY9UciuS4cXc/4E0C5AmG/gqPyNnh8ZK2FFt+qG32TspC2M5qPBAYtLTZiJx0tGMfHYqyAZciddGlS6f4o9VFEdz7sHPjq76WIwuzcors5SI6ipR4ynEh+7/0CSVpoqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721914089; c=relaxed/simple;
	bh=n+mGaGr142AZpSb3Abu1f//0+G2igZyMiOCYw1wXYtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=izOrC7rRkOukLKdDNepvZkaeW3hcOJ+Y4iJ7eJnCw3BYFk4uUInflT/SaEcuoDZ3b77XcGag7/cEMzA2nG9S+Zn6VBT7+ohcNq268ddQXv6jpdfRamu1R2HJzo0nvmTwjjpO7RuQZg2zyTmCi5BH/eJSTOlBqbihARmfDsOBYGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJen+aId; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721914088; x=1753450088;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=n+mGaGr142AZpSb3Abu1f//0+G2igZyMiOCYw1wXYtQ=;
  b=fJen+aId9cowm4z6W23rcL+TCAnrqR1s42WnVvE6mqWjXM5Nxyuk5C3C
   WWP681c/3leAIC7WGOfuwFH7KiOyq39d5fNeZgd22trXAsWo60VuvxokQ
   ZxbZa1vCwRln6h1yNG2DwTl/uzOMfyQ/rcA4Gf8EVAzG2/Fv6pQIvIfjg
   zuMhh6TUJeHWVXEdzd0FZ6wKZb0ZsYFUpedhF0QG8saMeL3mfh2jPwVUW
   7sZTFPafRJIz9qhnbY110+0KCTJ2M14x1FKA/zTvwdKW6Ci4oQluxIgKw
   aQBrqz5u8proo54HtNpAnb4nSTigb6dju3UspyXiu/mQXJ8nNbPE8GetK
   w==;
X-CSE-ConnectionGUID: 2I31ea/ORjCzz67E8Vb5aw==
X-CSE-MsgGUID: hJRd9SLRSVatOcORxllyaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19262698"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="19262698"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 06:28:08 -0700
X-CSE-ConnectionGUID: BGI8WnSgSaSMpea+j3HSKQ==
X-CSE-MsgGUID: VQ3Flv4HTAKca4BiQoVGgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="52617680"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 25 Jul 2024 06:28:07 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWyVp-000o8q-02;
	Thu, 25 Jul 2024 13:28:05 +0000
Date: Thu, 25 Jul 2024 21:28:03 +0800
From: kernel test robot <lkp@intel.com>
To: max.oss.09@gmail.com
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] tty: vt: conmakehash: cope with abs_srctree no longer in
 env
Message-ID: <ZqJS48PRjwVkaJ0o@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725132056.9151-1-max.oss.09@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] tty: vt: conmakehash: cope with abs_srctree no longer in env
Link: https://lore.kernel.org/stable/20240725132056.9151-1-max.oss.09%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




