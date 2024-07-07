Return-Path: <stable+bounces-58184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C86419297F8
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 14:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850B2282712
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 12:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF8D1D545;
	Sun,  7 Jul 2024 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RwNcMlQk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0390117C91
	for <stable@vger.kernel.org>; Sun,  7 Jul 2024 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720357080; cv=none; b=iJs+0JDDnMpkALTS0DWTvViI/TuxcK9fFehbZ+YWuBtAznnOqo3n+N51l44AtO1LWnNOWIrrAp60H3k7zKUD8DPULfVabRe72dIyLQnlmfTjdnVgGTDm/n9NPSUKxtgShD7v9ye2tySpG/ji+98hubx9tXaHK0r1qCDriPyxJ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720357080; c=relaxed/simple;
	bh=tpk0utYwmJCEYzGhoj6+UdKmMb6ChTC3gdXd2HOXYuA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TvMCjwsKcbiXS2xM9i2oNwqN6uAL37tQnXVKbC3V0Fl1FYwzuXku7VxQAkiQ6ctd5rnBNfeeM0FB1h6+XyN2ymJkU/2sQenMtafeOrauYZr5STr9myL1010zozH0Ve29eYGgGTdOtiKj6oNHbAGrDCgH0kznHpJlcOlgoNh/s28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RwNcMlQk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720357079; x=1751893079;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=tpk0utYwmJCEYzGhoj6+UdKmMb6ChTC3gdXd2HOXYuA=;
  b=RwNcMlQkXbKSHO7BAOLcHh620kqvkpjaKFWPfPcYMi63NgfPFFSz7r+u
   bOeWVchZJyWiGLMN5sK1WNWDImGGelHLWOY4vWfwlSZRM1SirQqpAbIU+
   BfX2LLEZVl+ogAZWfiRhpglD+HC4asXUThtxZ1t+Lhsy+Qn1sdRibAdO3
   OYZgjxBDEIu1kXB4K/zYmJMClxw0IUYWRGsgcuRG6A2b0tmcrKtMAomda
   O5dProrvxq9ihlRIjoduwesY/zGsWbGxm8DhChvPB/HSXmVjiiVCHFOQN
   f7Hn3hJvTXAmQJB06nQ0y43s0/i74E9rlDdO//Fy/kmKD4RZyNu0UHtpn
   w==;
X-CSE-ConnectionGUID: L3X4oKeFQbSmTcIxAh7Sjg==
X-CSE-MsgGUID: DdpChBAyTMu6im7NLsdTQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="28723415"
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="28723415"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 05:57:58 -0700
X-CSE-ConnectionGUID: GchqDNyUTKaliXDVUpCf+w==
X-CSE-MsgGUID: FkZaOQfaR2OEB4UE5jW0Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="78403649"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 07 Jul 2024 05:57:56 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQRSk-000UxG-1j;
	Sun, 07 Jul 2024 12:57:54 +0000
Date: Sun, 7 Jul 2024 20:57:31 +0800
From: kernel test robot <lkp@intel.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 1/3] igc: Fix
 qbv_config_change_errors logics
Message-ID: <ZoqQu1O_b6iWo0uF@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707125318.3425097-2-faizal.abdul.rahim@linux.intel.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [Intel-wired-lan] [PATCH iwl-net v2 1/3] igc: Fix qbv_config_change_errors logics
Link: https://lore.kernel.org/stable/20240707125318.3425097-2-faizal.abdul.rahim%40linux.intel.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




