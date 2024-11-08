Return-Path: <stable+bounces-91930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2FC9C1EA0
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 14:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6B11C22F7E
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 13:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16841F471E;
	Fri,  8 Nov 2024 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+ovC44P"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2881F12FD
	for <stable@vger.kernel.org>; Fri,  8 Nov 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074048; cv=none; b=sAZxk0hGNxn3t9dXxDOr61E5WMROHlQpT902sDEHPxls6utGsZcg7h6qV4ILDotKNRF0fBQDmIqzdF7TT9BVXY8OQUmla336U39ui7LFZMLFaoT7l39QCUCIzjBb/T58LQlEyq8W/kUtpSPvU7UUVdsTLyFtOf8WtYbBADm3Jow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074048; c=relaxed/simple;
	bh=6eEa6nyTkvaI7/a61DkMH9sCFgvryV+VVqov9MLAgDo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=evEhzRHu4G70uU6wfexXDPDX7GtXvCJyi4l7jD4oSMtg+1JOdKsuMMFazNYDovWXNkNKwfXXdaRNbgo1LRoY4KCYSYW2x8oMWiXlDBxVUwyFrLC7mCp9GahGUKvY7dg6S70wslNw5W84RaT19zM3MVbm/vvpVYS5h9O6pKQPGTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+ovC44P; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731074047; x=1762610047;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=6eEa6nyTkvaI7/a61DkMH9sCFgvryV+VVqov9MLAgDo=;
  b=a+ovC44PiTXEhISZXHiYgiC0G5P6hSMCXMnLr5kEWhsI1W5uu5MISUyl
   i1lvNQVAb2DDSpog6Ul8pmBG+3kSDt4ArQ+FbFayYriuJcSPFZBwsBNIU
   zHUCXGdtyb3nJCysn0QFgv2t1+874kSer/n0jA6J4ceZeQWGkA+6wVWd5
   7LDPEwSKedpOhMPwFEwbKQK3LOFJzwHKBZqHhds4L8pWaNXf7rrQXsYTH
   jrFQvKCmKdluv5fiRIw4m7Q+oq3A/Dy9zaQE28oNdCjfnaSuf374LWVlb
   wy0tr46Y204C8vof36zg/ghFl/Be6sqn5W/M+dLCnf45m26wMIVd7PQ4o
   g==;
X-CSE-ConnectionGUID: hyHjbTFtSfixFxU/376Vdg==
X-CSE-MsgGUID: g5/VkHPeSxWY3KGs2B92Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="33816360"
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="33816360"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 05:54:07 -0800
X-CSE-ConnectionGUID: CAWLwFc5Sq2VTuaWWhc7nw==
X-CSE-MsgGUID: B+2jvhXcRXShzRt18gY4lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="90110903"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Nov 2024 05:54:05 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9PR5-000rTi-2V;
	Fri, 08 Nov 2024 13:54:03 +0000
Date: Fri, 8 Nov 2024 21:53:54 +0800
From: kernel test robot <lkp@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH backport to 6.10] x86/cpu: Add INTEL_FAM6_LUNARLAKE_M to
 X86_BUG_MONITOR
Message-ID: <Zy4X8lbLTKZlxOkH@0408e98e3aed>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108135206.435793-2-lenb@kernel.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH backport to 6.10] x86/cpu: Add INTEL_FAM6_LUNARLAKE_M to X86_BUG_MONITOR
Link: https://lore.kernel.org/stable/20241108135206.435793-2-lenb%40kernel.org

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




