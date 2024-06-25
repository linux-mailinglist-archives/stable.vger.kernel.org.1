Return-Path: <stable+bounces-55745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F74916584
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 12:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974851C210CB
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 10:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E76145B32;
	Tue, 25 Jun 2024 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKdeUY46"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7DF1311A3
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312531; cv=none; b=gUrImCNHjgMotOy8P8lldN3BRrodv+7m1wTC9K5jrbVAVvIwRbba/SKtQOpuxPuZ2xEry7I8HTh9OPtY1r/1wyn+XSZAqyopfYBZVFan8gr5GyWbYqz4eqNuXJtLqvnCzzJ+fOUfDBQcT7xv50akwRm2bvpzu6t/UakB48wvrKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312531; c=relaxed/simple;
	bh=6+87AlOCUxqcXvkLHSQLAwa0vDVyTFlS7+ugy3LfWwU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q2TOTFe8axxLnEIm6lxSuDDS6z2n8G3Z/ANkW6KFF4IgcdptOE8NBtpgu0cBKJcv3SSHeTR3BKrq0AyjiB9OIWGjT8ZV6L0VqfIyrPFzLxTj8QItAkHfo490Ne/zQhzwGkGz0GoEcaUewQNI/vPe2h+KE3VV0X6sTvtwA4yQUq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fKdeUY46; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719312530; x=1750848530;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=6+87AlOCUxqcXvkLHSQLAwa0vDVyTFlS7+ugy3LfWwU=;
  b=fKdeUY46cMoYFeQFGwryp1006T4yI0MJv3dLCfZ63sd2Ef4r0W6O/ilF
   llFl+xRnGhcJZqMMcIK0wpXqopeYQ+GK7rwIWhaLluFohZ6PZ/OqNhfCi
   kDSV3ENdye1aeBCwUmPnu9a+4irr49jMDcurwUftNkJLnIV2UkmbhNgcX
   wNvNNuvRvVtuAP/4QfLEtNm7JtNLkbFBZFnYg97etcAsfqcxGYA598JAJ
   maGFvKJ2LVeKsewHgHsjNn9MzSXEvHdOd0XjTwW+/llOKkW3dONMUXspZ
   /LiaRpXnTu5aAoODIqDKjGRlJT9+FbCEG6ttxBpoQQAUs3arGIbUGc9+x
   Q==;
X-CSE-ConnectionGUID: zxBbbk28TIy4J5XR56ZT0g==
X-CSE-MsgGUID: rXPm3DNFRoeRUYjoSLVmVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16146906"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16146906"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 03:48:49 -0700
X-CSE-ConnectionGUID: m0szAnaTRHacB0V0VAH9uQ==
X-CSE-MsgGUID: h42/IneDTUyd3YcebZeIvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43416360"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 25 Jun 2024 03:48:47 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sM3jB-000EKv-2R;
	Tue, 25 Jun 2024 10:48:45 +0000
Date: Tue, 25 Jun 2024 18:48:45 +0800
From: kernel test robot <lkp@intel.com>
To: Chun-Yi Lee <joeyli.kernel@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <ZnqgjecCOeiE671O@6715f18d4702>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624064418.27043-1-jlee@suse.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] aoe: fix the potential use-after-free problem in more places
Link: https://lore.kernel.org/stable/20240624064418.27043-1-jlee%40suse.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




