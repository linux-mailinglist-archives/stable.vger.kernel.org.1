Return-Path: <stable+bounces-11848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8437A830735
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 14:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364D01F267EA
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 13:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20C31F60B;
	Wed, 17 Jan 2024 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MchJ+yVh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B9D14A87
	for <stable@vger.kernel.org>; Wed, 17 Jan 2024 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705498689; cv=none; b=mItGzzvzrnkiDJQUpAcVjCkrJZPk2ewv7PlSbhj1XA5nsOzXBTrza0R9UFS65ppga4PKalo8yWEYtFOW1PdhFetAOD3u8wAWw5wQAn3/sks9U5FzXI87hWZvwF6gj+iTdEOkEaF7NdQUDOX/XSPIlIUBveLlE8jMecgAtOSP0HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705498689; c=relaxed/simple;
	bh=fGT48Zw5xEX/HcJfmi+SxK9GweVFjsjrtkK1fkz0rAY=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=D5A0mPeAHSXeAE5koBoqqxHwSZAhZ8UhYy5D2ZjlaGW82iZcCDzX+09PsYFtghBZvQAtKISbj5vdVHJ1sW3ye0S+fDmseBJ7LhimW5L9zaTB0/MzkWhMTQ82/oYoGEyYwyUSpg+h7resbwi8mP72cjpzb4sA8TTwKfFcE70WyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MchJ+yVh; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705498686; x=1737034686;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=fGT48Zw5xEX/HcJfmi+SxK9GweVFjsjrtkK1fkz0rAY=;
  b=MchJ+yVhq3bPnLghMtMAGJeonmn+e3RwLhaxN1hD3OZ1RyVgAsrRKKGK
   JiTpsb+QmQspK4ChyDLrITEs1RxncD3Yqd5v/pxPeFnTMkOtXUbZVW1Dr
   gryiIMBtDfGNt6q5OPwYdADkA3xQBAHUqZSyysSCij57Ek0T0HQNxKVgz
   aRkY5IAJv9rkqVNmTNODs3z1rfFYR2tboSiZVr8ekUdXsdUuKMO/Sr1jG
   H9RDc/pboSNT+kDqz3EWRQM4U3vCjyeCqny2VuIoztsF+CMZWsXzRyIUV
   0HVUt9KSiclZHUrPDMPokkEZNPzWG1pJfb4ouTBMd1A/gFL5q0nfuOA9X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="397322292"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="397322292"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 05:38:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="43628"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 17 Jan 2024 05:38:04 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQ67F-00022M-0t;
	Wed, 17 Jan 2024 13:38:01 +0000
Date: Wed, 17 Jan 2024 21:37:14 +0800
From: kernel test robot <lkp@intel.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCHv2 stable 6.1 1/2] btf, scripts: Exclude Rust CUs with
 pahole
Message-ID: <ZafYCmLzkWeqI6sF@fc6e15c3a4e0>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117133520.733288-2-jolsa@kernel.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCHv2 stable 6.1 1/2] btf, scripts: Exclude Rust CUs with pahole
Link: https://lore.kernel.org/stable/20240117133520.733288-2-jolsa%40kernel.org

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




