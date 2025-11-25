Return-Path: <stable+bounces-196931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71945C86ADB
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 19:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A083B4329
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 18:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD65333752;
	Tue, 25 Nov 2025 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knhvuw1k"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8692D73B8
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764095952; cv=none; b=cUtVClK78tYYBBakfbvdrPtkB7cYWMfvT/gdVzlKfVjyTUBdfpHrYxkgk+enz0+4d1Iw+f7D5aZdT2c491p9oJo3dIrQLTtqJOe9li3HVWgmf3x5WQX785zzrTkGn6S6HmJjnCla3kwGiBOtJOJytQ2XmdoK89ZRvhPT2ifTdT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764095952; c=relaxed/simple;
	bh=SwMh+bOv9VKkCEiXi8kk/hn8YQ6tuDRU9ra8uwee5tE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LDlWKDo6cq76PWX50WB9XQp3vmwjghALny/eY+UCrq1Uh7yntvll2zOCZaJTyKlylpu/+8VJyWFYI/G+B4s/xbFSusTH0dTZvTSg8D8rXrZijT9u2M1DjRewyLND4u9rLLYU2sjKzoT7IViJ3pVheuVFpxyrhZdOMPNWcgWArGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=knhvuw1k; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764095950; x=1795631950;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=SwMh+bOv9VKkCEiXi8kk/hn8YQ6tuDRU9ra8uwee5tE=;
  b=knhvuw1koDrtbsIgpIRsBr1fSJlqpEXm0K5LxsJF2+DS7pW6pICPNroY
   i9TOFayfVaiQmTLl5t/h6qQM8vklSaYBgaOCsgroBsh/WrWGKPn/aYLu6
   Gt4/fwBg9sOOSJp/WxbnAW1FsE+57sBlGt53h4a/bW3+snUymkiqHW0r5
   rPwBgRba+x9SSkSFYCnuA5RdZxvIDgXunyi/AahT+RrvpTttE+3SW+N6R
   DtfZ9fB7ZFkV3E4/ZGdbDnEoaQM34zc36H4h3keB02eF/vTmeICvK/Rkg
   ySOPbNUmKneWXPnEKkxOD7Nfy0CFzS7esrDVGVMviI+wYY/bJyfCOLQYj
   w==;
X-CSE-ConnectionGUID: 1EhUPYv/RI6Uf+4MG+kcBA==
X-CSE-MsgGUID: gc8JSXm+RJyk2QhjwScOIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="65833322"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="65833322"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 10:39:09 -0800
X-CSE-ConnectionGUID: hpozAfpmRNGuZ44rYeIurA==
X-CSE-MsgGUID: NNtZ3MAdSVOlWrrn6wn6tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="192719081"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 25 Nov 2025 10:39:08 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vNxwP-0000000029F-4C29;
	Tue, 25 Nov 2025 18:39:06 +0000
Date: Wed, 26 Nov 2025 02:38:10 +0800
From: kernel test robot <lkp@intel.com>
To: Alexei Safin <a.safin@rosa.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] media: ipu6: isys: csi2: guard NULL remote pad/subdev on
 enable/disable
Message-ID: <aSX3klrjsRrlyCS2@4e95d9e973af>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125183110.80525-1-a.safin@rosa.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] media: ipu6: isys: csi2: guard NULL remote pad/subdev on enable/disable
Link: https://lore.kernel.org/stable/20251125183110.80525-1-a.safin%40rosa.ru

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




