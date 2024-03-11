Return-Path: <stable+bounces-27413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60151878ACC
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 23:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E9D1F21C28
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 22:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE58482C1;
	Mon, 11 Mar 2024 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+pkEtyU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471D58113
	for <stable@vger.kernel.org>; Mon, 11 Mar 2024 22:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710196444; cv=none; b=PFTnB/ZkuzH3TkN2HJvhYkeDKNVYitm89los6EClc8NIyVFO65knGEVOIUxMsfMDFensu2amO8lSbxqd5wcBXXWDT/lhIxnFYu9BdGLyqHTGHULQI3HOJyfDiO6CQIomttjMvkMHN9lTw4CykgKbmBCsvIMVnAS9IdIjrID5eO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710196444; c=relaxed/simple;
	bh=wtRonEicjIwh44mB6DV+Ah6WfpAdtDG+jPjaSMw31m0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=as1/HgI8bwIri2tEXthysXxidASUMzo5l/25k+MdmzofeBhxT1+smKVaqYhS0q/uV83inJfoT1mIPjv1eYQYMdH4h2coneMTg2ARwGzjGtusxd4Kj3n6EzO6S0UP/+NWprfs90kUyoHmd9pv+bBU436xcG8lnoZzEhjmlbkBBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+pkEtyU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710196443; x=1741732443;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=wtRonEicjIwh44mB6DV+Ah6WfpAdtDG+jPjaSMw31m0=;
  b=O+pkEtyUlR6Z921H5TcMn7sK2SWKXXvswbwqH/qGHSRR+RFpG//mlqcJ
   aCRwZnvvyXU3uqc8ErtH+RMfORqsOWt4v0hTRmmsox7uaesHlCf6G3JTx
   uvDoHlXyCGSrOKU9eF/7DDds5Tc+TXQXxur7aOg+q4sZvQJRWUAMd5n8/
   6Od2y3HfMO0wZwudvwwQL1Tbo1BQGjzVYiOZGhqBW0WjCxBAOZMW15Vj6
   qQnLoIXy0I+h2AhXKn3tiYU1h3Mk4DnLu9SaepXus/uucyxSxLACFuvbi
   v/44mY3Aedm0p2B7kdAtVgn4fQnuK1fK2Yvhmvc2JZsEoIbkolEScw//a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="27359307"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="27359307"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 15:34:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="11382437"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Mar 2024 15:33:59 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjoDW-0009VX-39;
	Mon, 11 Mar 2024 22:33:58 +0000
Date: Tue, 12 Mar 2024 06:33:03 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Liang <mliang@purestorage.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] net/mlx5: offset comp irq index in name by one
Message-ID: <Ze-Gn1kYLBq-HCxs@28e5c5ca316a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311223018.580975-1-mliang@purestorage.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] net/mlx5: offset comp irq index in name by one
Link: https://lore.kernel.org/stable/20240311223018.580975-1-mliang%40purestorage.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




