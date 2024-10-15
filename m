Return-Path: <stable+bounces-85824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C38299EA41
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD5B289136
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1831C07CD;
	Tue, 15 Oct 2024 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHSL7JM5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40651C07EC
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996494; cv=none; b=JOtex4K7KhMOLWzmiCok4ppN6/SEr+yNEMPvkBYpJX41nH33RKoazRpJc1he1WFNk8OUAKqUj+/ONswS7sH0A7q854ksBehnFjpKc9Zwbu+kJloP8kMhdS+7yyGrxY8TLDI4mAds8KLO1mrgBc13ECZqvppE/tgij0teLpOqpjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996494; c=relaxed/simple;
	bh=Yj6T3HYU4dgVmjX5AdHX1JjKWVa0/Xr0X028o5r2lvU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bMFZbzw/lzlYcwBty76Yf6pmlWqSI+AM0YX1U+h6xa0tw+s0dSG607rj0T56XrVh6Mrg6WcdUQeU5DcHB8ABL+ij7I+wvJXbFJ9UCzIQEdEgEsYhNDsQrmOJUEOHyxsYu7H8+z/T64NcyBdW22Hq+BL440cRAy86pg0pnjtcYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHSL7JM5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728996492; x=1760532492;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Yj6T3HYU4dgVmjX5AdHX1JjKWVa0/Xr0X028o5r2lvU=;
  b=KHSL7JM5V4aHJAGgEPYGWxor9XQs149KYy5td2xaPZaIs5hUcIx3iX4C
   q+CKY9l8X3cMhVNJPfgSoINALk5zh8Q+DE993Fcsv9H+uhl3RVMN21q0+
   vIU9nBeR+LY3KLu7nax/hV/Wb6G5/U+GS/Q6vIoCNPhYgxwlqksaIVtHg
   kTwXvUHUelwe/uIjfTMpsVh5LTtLLAPoVZ9bA/oQBQbAGUCQiINTnp/sC
   oY0yFna6GPn/c45mL2ySG1fssP/m3gC4O3eRn/2VUr4GNbXcwbWVeZ576
   RJecVOZNTvLRoZktMrioK38MafZWJJg8LMR5Eo/g1Rn4qBtJph5hyNIF1
   w==;
X-CSE-ConnectionGUID: JSQeV51uQoKKZG0mbX7hCA==
X-CSE-MsgGUID: fZW1X5PYRFiuN4A/4tnSmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="39776245"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="39776245"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 05:48:12 -0700
X-CSE-ConnectionGUID: HWSUkD1FTNOf32oMfv4UiQ==
X-CSE-MsgGUID: AWrXfEowTYWbU6zEkS5JKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="77761496"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 15 Oct 2024 05:48:11 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0gy9-000Ip7-0f;
	Tue, 15 Oct 2024 12:48:09 +0000
Date: Tue, 15 Oct 2024 20:47:11 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [char-misc-next v3] mei: use kvmalloc for read buffer
Message-ID: <Zw5kT4LZq4K-hWR6@86e5a9022298>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015123157.2337026-1-alexander.usyskin@intel.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [char-misc-next v3] mei: use kvmalloc for read buffer
Link: https://lore.kernel.org/stable/20241015123157.2337026-1-alexander.usyskin%40intel.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




