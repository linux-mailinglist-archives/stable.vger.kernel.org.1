Return-Path: <stable+bounces-164735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DF3B11E8F
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 14:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6251899879
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 12:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E19283FDD;
	Fri, 25 Jul 2025 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ukk25p1V"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4F923FC66
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446692; cv=none; b=G3p35TcfyIM4QF9v9AwzvRGktQS+b9qDucNXY2Rl8YZEV9NRS2HRd2dJUqxj6YcMufCriaN9wehCRHAZrIOjXFFCvNAzLVuZWTrO2hZ2IXmCVQjpFqjS3vobktFpPsiGi1K42sDkKDH9iXcB7cG2G03uRIh8p5wLKa1+NYDvHdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446692; c=relaxed/simple;
	bh=QuhtXEF558ISpH8qAP+o4qrzE6+/pt/sBl9bxWrr+fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fVNBDceZYnWlJGgHL0h79FpbIpJmSqoo9ltEEyw1AZ24qukWsqByNiA1dJbSS5iWPTvWbdx9jg9FV8f7m+MfJZ4Smc49JDbSvezXMDITmCUibCkH50zkt6IBo/1ddXn1z/a6WQfgaTl4fW16cZ0RS3pFt0yb23C/fGc7OoyQgE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ukk25p1V; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753446691; x=1784982691;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=QuhtXEF558ISpH8qAP+o4qrzE6+/pt/sBl9bxWrr+fQ=;
  b=Ukk25p1VpaL7h7lGbVjblI4m0RbYoj3ocl9VuogNjW/ozPH5B0vURcBX
   3EPVIN64x00P6ox7Wh0ReZBMeLsPGKhpIBB1VsoHdMvUyWJaYyQWDqapj
   cKolfJ9LM8JIuOEkopMtgfC2aoqkxsb57AALVWrgE3Cge6oXOSQe0E1CR
   NjP+o5BCWHurusGVwM4ni0nlSAWDUcrOORZaTCR/rTGRaSoVWxbmUdaKn
   MoOvH2P0+cDjQeSqWzwvD/7/N7fOHHv8mXfbYZU13M49iVME30gPse7KX
   u/hGXvAmhMPNpe4IHnZX9VeUSkKAwcONKRNRPUiwkBCrGkTo1qxQDWw+0
   g==;
X-CSE-ConnectionGUID: IBpjiZVLRfC+FiK+/rHjAA==
X-CSE-MsgGUID: J1/YNOnXT42ItUG46CE0rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="78329819"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="78329819"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 05:31:27 -0700
X-CSE-ConnectionGUID: 5gekBHuPS0eaAhaNPfp+qA==
X-CSE-MsgGUID: uATsL25sQ9iS/IC6ZRVaKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166310356"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jul 2025 05:31:25 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufHa7-000LJf-1i;
	Fri, 25 Jul 2025 12:31:23 +0000
Date: Fri, 25 Jul 2025 20:30:35 +0800
From: kernel test robot <lkp@intel.com>
To: Petr Vaganov <p.vaganov@ideco.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] scsi: fill in DMA padding bytes in scsi_alloc_sgtables
Message-ID: <aIN466I95rNVIhIj@eafdfd67401a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725122202.77199-1-p.vaganov@ideco.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] scsi: fill in DMA padding bytes in scsi_alloc_sgtables
Link: https://lore.kernel.org/stable/20250725122202.77199-1-p.vaganov%40ideco.ru

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




