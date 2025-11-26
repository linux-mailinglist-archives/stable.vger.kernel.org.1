Return-Path: <stable+bounces-197052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9880DC8C09C
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 22:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2344F35A380
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 21:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7682D9463;
	Wed, 26 Nov 2025 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJtp4nEa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E12288C25
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764192866; cv=none; b=BU8C9TIX2mVQF0Owp8vIyqc0pb7fwbq0fu9JBREarNnBlO9OzHgwIN3bXrRrHOaAkvxmlIgT5C29PDl7ibDNgqJVcA6bzqAg6c/V0lqdfszlbw2Fg5OwAo9+vQdkZcvCnUewJtniD98ekZIkPGdt+9SvPwLTW+cyV0mjCgEvYj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764192866; c=relaxed/simple;
	bh=F64OBwa5RU2WG8KkfNNwsDePPJZTGuJD5Jkc30EX+tA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a3N8EsY86V8qNvxhi/PvR8uHZB/sJa2V9kDCGNR56vQ+6+xCmM9iFWJ9jgxHxpc4G3s/16BFNVgo8NIyjedJP2hRaaexP2AA0VIUiblKkmXXSljL4IaeFWOcOlf4fZVd2+X94HMuaKd0cB9tQ0IdG/3O/NVGKhJdDfxHlOm3aQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJtp4nEa; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764192865; x=1795728865;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=F64OBwa5RU2WG8KkfNNwsDePPJZTGuJD5Jkc30EX+tA=;
  b=oJtp4nEa6mx8RYeK/sKBtOL/81FN+N5dnKTDgvIcBRvLd5MMmaehRbiO
   CJbVGDGVVYlq4fvEmkeuOUc+TGQoJkPHMlbDIHU4cxnMTUmUPj9pkWm3t
   1T1UnXUX+aYpkZL3r6d1qCokxGxfrwW0ruSuDiILH85xBSq82XbxpYDaq
   TM5f1WFqzAmlCjfRynPoZpK4fiKIRSW0SUZOHq2ith61BMewZME9oTztY
   6NDCvsAKuckJaUWmTW/jshGvVyRvCW+V1lAgeqVkWQuB/Va2uK0wjJ541
   e+fenwQzKxN35nsjFV2cDlUZcNlKEKTXuhvdl9cZJaN/iL/JHbTwgIWfr
   g==;
X-CSE-ConnectionGUID: NmYcGoH8TsCjRqfo7mLsag==
X-CSE-MsgGUID: w/rItTO4SIORY5aCg5xcyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="77603069"
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="77603069"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 13:34:24 -0800
X-CSE-ConnectionGUID: qM+bQ7BgQnqE0w6F8ZGpGA==
X-CSE-MsgGUID: PaJhUTVoSuCTZ6W0XIaOGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="192957747"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 26 Nov 2025 13:34:23 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vON9Z-000000003Np-0OxM;
	Wed, 26 Nov 2025 21:34:21 +0000
Date: Thu, 27 Nov 2025 05:34:00 +0800
From: kernel test robot <lkp@intel.com>
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] drm/msm: add PERFCTR_CNTL to ifpc_reglist
Message-ID: <aSdySKtZeIcsxaxP@c2e5bee1bcda>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126-ifpc_counters-v2-1-b798bc433eff@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] drm/msm: add PERFCTR_CNTL to ifpc_reglist
Link: https://lore.kernel.org/stable/20251126-ifpc_counters-v2-1-b798bc433eff%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




