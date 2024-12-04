Return-Path: <stable+bounces-98201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7669E3173
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 03:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A438A2825AE
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 02:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A868347C7;
	Wed,  4 Dec 2024 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuxjR4fi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B384A1A
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 02:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733279760; cv=none; b=DKeSSMocVlhSSFph9nujAgWsnEIyY/iw6Hzlhmkv3Mo7WVMk+EUH3NUcMGvW71/w1PtVYxRkpJCviMXTkbAizLMey1yFzpVr8s3b1ofqLEb2tuybeGbkz5vmWIrMn5KcfVmHAitsdDRGtluYF9lMT4vI5Ai3C8oVMxXm6AtQwJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733279760; c=relaxed/simple;
	bh=EMxVVaiTZDUpskoyKOjfeNr4D6EYM/zt49lKZepsXiM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UCsgT6kmDOAcpovHYCltqH7jto4nsNFK8Xg1OeDhUMlZnhqFRnqzNoAgFpD53tF00ZtYdGJVYF4SeTliAIFbnS5gWLsjmBRK+2/gOIaEBYvpAc+1Ag9VAAT6IkP9aoKP8s95k9DSt3tnWTCtQPBwj8yXfDt94hF/EzImcERY5AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OuxjR4fi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733279759; x=1764815759;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=EMxVVaiTZDUpskoyKOjfeNr4D6EYM/zt49lKZepsXiM=;
  b=OuxjR4fiy7ggxWOV33BYNsyc/gtTH0S9myGcgYy0NvRv7rt7u7Tz2rZf
   EWJ1xaWb43OoN/HwGZWv6FhyYieC29df5CvkYUkMmlG4nkblRnlE13gDV
   N6ZHYPWSGrjud0w819cPXC+GHoZ08WCMetA4TuTpBanqXktHaJ3DBuyLV
   Zsheum8u5KOH0yazQrzo5WnDcg0xLGyxwpT1X47aUCvie3N82efSfXNE1
   EjZ+lMUfDJMVSW0k1imk7twfQ3Tiefl7iP2DbyJ099eCJlHHvWX9R/2gF
   +xkhD3uH5ULJVV/ltXau2vKSU8aR50T/VMI1lRIuUckJfeHnGVhrXRA8q
   g==;
X-CSE-ConnectionGUID: SaWT11O6TTqZetzRf4aKMg==
X-CSE-MsgGUID: TBWkAMbDSjut+3tudGsUxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44188444"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="44188444"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 18:35:58 -0800
X-CSE-ConnectionGUID: 8STPW4WZRim4D+41/WdgRg==
X-CSE-MsgGUID: mHEpWgxyTEyFeWa0Ge+HKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="93487670"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 03 Dec 2024 18:35:57 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIfF4-0000Tx-2E;
	Wed, 04 Dec 2024 02:35:54 +0000
Date: Wed, 4 Dec 2024 10:35:20 +0800
From: kernel test robot <lkp@intel.com>
To: Haoyu Li <lihaoyu499@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] drivers: gpio: gpio-ljca: Initialize num before
 accessing item in ljca_gpio_config
Message-ID: <Z0-_6IozdnJjOAER@24ad928833eb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203141451.342316-1-lihaoyu499@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] drivers: gpio: gpio-ljca: Initialize num before accessing item in ljca_gpio_config
Link: https://lore.kernel.org/stable/20241203141451.342316-1-lihaoyu499%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




