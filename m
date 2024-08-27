Return-Path: <stable+bounces-70368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2904960C9E
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026681F229FB
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 13:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560021C4618;
	Tue, 27 Aug 2024 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WXOYT2+R"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD771C3F2C
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766808; cv=none; b=KySuZFWt/bQvgwKk9eCZjHkrVcjb3LDrFwcrtNBbrnuS59kbh2LccYR+huwfSiaBwDhpGokd+qgEZrEAixD2GJEfq9S67pvlZCMxugovBpFIPY5bTuXlHfHzfWrmAtkQjaqLRDk1k4xz1UA2LTe7ahNANqdPjPsFhoJyb5XCavM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766808; c=relaxed/simple;
	bh=+B6ryWA5HgMDUENMRTMg5qbbvDUwdOMS61gL2mz3TfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ggIO32HiEbAhpKn6HH15PxPqi+loW20/K8sF91d/kyMsOpRyV0pwKH6zfQ7SHiT2UjgIaqIkG+4u9yuzo+mT6+lUJ6JZcwwAFfHo0ZKT4sJs1OoR2+IjeKGGGlaJ6tQmdgOrF/JNuu5BP6eBgO6PCr6C6+20ONgOstMUafmbvHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WXOYT2+R; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724766806; x=1756302806;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=+B6ryWA5HgMDUENMRTMg5qbbvDUwdOMS61gL2mz3TfQ=;
  b=WXOYT2+R05wI876b9iqOgJLPa0Vhl6qQ2iWlQhRpvgp/2zhVwMRN4DuN
   wrPZtJXXFxrS9WZhirCMZjGPRCzbuI/K3UGEr8S++p8tqrycpGanKEY3j
   MBaBjdyWPGq7zyC7EkHwvg3jwXP9/24cu4dZsto8V9zerVwka9fMN8niO
   5WFEtfWQs4z5LxR3SJKUTnZxTXTFG7HqHEHDI0K1nP115gQv5N2ZoyNq+
   HqoYNzY9HbNWcmUvgkaQ1vWeTaO2lQAdxKcpYeX2x+fblC9CvgJgI0KBw
   BD0a5tppIS4HZNZ3J9aU4QVecZOplXEt6XJG53uUVib8HbrdkAPOlMDfN
   Q==;
X-CSE-ConnectionGUID: 4GUdiJTXQBi1LAmK4GuyxA==
X-CSE-MsgGUID: y9a0KlY6T0Om/I2idU12Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="40748510"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="40748510"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:53:24 -0700
X-CSE-ConnectionGUID: m/hG5f1IQqGOep2TUcUHQw==
X-CSE-MsgGUID: euviyDpqTqW/2YdqvPcfSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67571704"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 27 Aug 2024 06:53:23 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siwdM-000IiA-2U;
	Tue, 27 Aug 2024 13:53:20 +0000
Date: Tue, 27 Aug 2024 21:53:07 +0800
From: kernel test robot <lkp@intel.com>
To: George Kennedy <george.kennedy@oracle.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: Backport request to fix a WARNING in input_mt_init_slots
Message-ID: <Zs3aQ8UVnR4cWaTt@be42b777ae2f>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1724766547-24435-1-git-send-email-george.kennedy@oracle.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: Backport request to fix a WARNING in input_mt_init_slots
Link: https://lore.kernel.org/stable/1724766547-24435-1-git-send-email-george.kennedy%40oracle.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




