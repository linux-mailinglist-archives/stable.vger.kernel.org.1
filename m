Return-Path: <stable+bounces-27338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDFD878564
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 17:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04EE1C21AD0
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 16:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFF952F72;
	Mon, 11 Mar 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRLgYYyY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E49E53E13
	for <stable@vger.kernel.org>; Mon, 11 Mar 2024 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174199; cv=none; b=GYFCWTsukcSPMlXSjZqoOBDcY2jWdwvJ5tapLnUNLOty+xNJ13KuqjPKWnoqOPnYQrgVy9MwrjwbMjowCdJh1lRrFipNcl86WFcfuOJwIks13ME/fILwEb6XIuKs5oEJxwoUCaH2wzufQx2G1INKePQgRq+7T32vZnj7dVz5au8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174199; c=relaxed/simple;
	bh=Kah76cTaW2IU+EreLgWAExquwnDIyQpSWwsIWH/rPjM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OQOU+wuG/+ehZ70ogdKSHNYHUS2J8OnXcgjYjhcKEazC3hnQ5j+izuqEMW66lKw5Z9oL9bAGWw/Wnhu/jgPYvEm+6811gVKX1uFev9nW5p33uUAcwgoVpjNyCKHV8JyqtaSEia7BzhasgCdHflRrUpbzVw8Nfod+Wl9/KwfM9gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRLgYYyY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710174197; x=1741710197;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Kah76cTaW2IU+EreLgWAExquwnDIyQpSWwsIWH/rPjM=;
  b=PRLgYYyYUT9S7dG/SpzP7PvAQux1b3XxQG37sypV3HYnm2yFaly41mtz
   B6UEwVSW3hzwwHE7zU+9ByX0JkVNvkYBnq6KGkAat/lpNFoKX6dn+veah
   ozB/E02q/GLX0wC75KYUUOKbVeRxmLQ0bDHhq1CdKfgZLgj2hiC9m34iC
   kIG5weIG4nbmZISpV3Wcj58qScjHGrFz3UQeg/M50r9vLSuLWwuWb/QDK
   Hhv6TemP5PUZK9y2ViKflWfYrd4BK5NsCsmyHwkamFZlUx7pOXHAJ94/L
   2KJhTjeYVQkrWGKPO7Cf1zFVtr3HkvUwfPRL9mI1/J6PDZFhyWaN4Ol3W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="5028658"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="5028658"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 09:21:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="11659842"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 11 Mar 2024 09:21:48 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjiPK-0009F9-0L;
	Mon, 11 Mar 2024 16:21:46 +0000
Date: Tue, 12 Mar 2024 00:21:04 +0800
From: kernel test robot <lkp@intel.com>
To: Vasant Karasulli <vsntk18@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 2/9] x86/sev: Save and print negotiated GHCB protocol
 version
Message-ID: <Ze8vcPlNLoyo6SQm@28e5c5ca316a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311161727.14916-3-vsntk18@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v4 2/9] x86/sev: Save and print negotiated GHCB protocol version
Link: https://lore.kernel.org/stable/20240311161727.14916-3-vsntk18%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




