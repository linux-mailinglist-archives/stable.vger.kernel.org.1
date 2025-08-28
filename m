Return-Path: <stable+bounces-176588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F4AB39948
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 12:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C711C20D57
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 10:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11DD2F28E5;
	Thu, 28 Aug 2025 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNL/sBMc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884A2E8882
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376117; cv=none; b=bh5P2PEdfCi/JggETVJBk2yR4JO88jEVlAcGLUFpILEZ+ekXp7eYSab628N/grirfcwXHUaFPw3PRH/sw10k5vULqMREYtEZmHSxxUmUSsFnQLL+sttGH4OlJPwtYYJ3wUVuj6t2YCmsPemSp7h0G6CvA0DwDocSR/r1BN2YpTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376117; c=relaxed/simple;
	bh=c/WrnvoLHW/EzhEDFjHsQM5rytgPZkoUDa8gTiAWYsw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=i1y1xGpsE/9olJPBv9WdbNDWtVF3z6t6/ruOFLMmM5Mm8KJjS0W389VV2g2ZOOtnGRjhnifMKYypAnN08bw03mpfMqnnsGpm0schbEJ250VYydxAFdUK1eu5faGX3zds3prDcTB25nxsJuGy3eQ0F9NlvcYCgzFFcJVlNQUbDmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNL/sBMc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756376116; x=1787912116;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=c/WrnvoLHW/EzhEDFjHsQM5rytgPZkoUDa8gTiAWYsw=;
  b=jNL/sBMc0XoDZ942KRRJd/XoPUEuDsjpEdny00aeKO9tDjvwhZFb4FB6
   Q1PGrTwugsL8rpxDHzFB7UeCncAwRg2OPPhCcwVYt81MuNH2ThdETVpOB
   UveWM3rcnqoOYgBWfobMwKTk1nzdrihzWKx5GUg9c6XOdOPnh2xlZ2R7x
   zbzBPUsNQ/9CZRVBSGOXuOVrq66VixOCwGC/vfYAFF6ktcPtWqO5JkbzS
   smPad7aJFX+s22nZ5VNYMI0xifm21d0E5POKQpE7ekbNCUCB2x81tIsPg
   mnCZqN1jZWzMRNi6Sw6QdQC1McH6QPRwfLTwKrvNyWxsnxQeN+s10/QUm
   w==;
X-CSE-ConnectionGUID: yETmxEH8RxWgY4z6AGQMgA==
X-CSE-MsgGUID: ut4MmFOoT82ZI9bb3/e4YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58741198"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58741198"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 03:15:15 -0700
X-CSE-ConnectionGUID: vzLL0gx+TKeU6FDHH7WPXQ==
X-CSE-MsgGUID: Ye7AG7nCTGieQIi8tJubNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="175370754"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 28 Aug 2025 03:15:14 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urZe8-000Td5-2l;
	Thu, 28 Aug 2025 10:14:34 +0000
Date: Thu, 28 Aug 2025 18:12:06 +0800
From: kernel test robot <lkp@intel.com>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH iwl-net v1 2/4] ixgbe: handle IXGBE_VF_GET_PF_LINK_STATE
 mailbox operation
Message-ID: <aLArdkpnBnD3yyOR@5fc77bca29d8>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828095227.1857066-3-jedrzej.jagielski@intel.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH iwl-net v1 2/4] ixgbe: handle IXGBE_VF_GET_PF_LINK_STATE mailbox operation
Link: https://lore.kernel.org/stable/20250828095227.1857066-3-jedrzej.jagielski%40intel.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




