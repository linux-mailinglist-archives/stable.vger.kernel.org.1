Return-Path: <stable+bounces-114732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCA6A2FD36
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 23:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FD3188A061
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 22:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F291F253345;
	Mon, 10 Feb 2025 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2ClydDX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121E2253325
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739226933; cv=none; b=KdwoRqzliy35UF8zjFq56uc/umY5iCJ3UQY+TJm+3thA25nbgHzOfH+Yd3dfTrDSPNvy8r22NhYGDEFBub0Jc9RaTQodcBaxfOGrCQMrBoB7hy2vGf7jGL+dptE+z4tfZvgB0EF94ekmx+RiZhJu15VE+gWG57TBdiGLUOx2LqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739226933; c=relaxed/simple;
	bh=PLcjKXUMN7FBVlLiCT72DI2fToGTsKQQBXr0qRmaD3U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FULi2HzzYBvS/ex9djqZJrjfdaX2FrOyq5eACZAmgCMRqcgCD36kwTKLbpWYAG4L43BKlB9CtygkyQFAzbBZt0ZCJpoDRE2vwuPsVHdRu9Ih8wB6K7tO44uo8RofwI84dafRxFjgbhBB1zOrlK37rJJVPFq4nSHmndT7Wo7uE5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2ClydDX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739226932; x=1770762932;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=PLcjKXUMN7FBVlLiCT72DI2fToGTsKQQBXr0qRmaD3U=;
  b=C2ClydDXBIOXmhH+XnWs692PLPFVdluLdwqZAYP25u/2nYWWo7C7r/rr
   87StqckVKB4rPdriCPCcyR8wuwj8qoVRzP24hdpJzgu7MP5McstXiYjPh
   oI8t5iRNIpcwp1g/RfXvc3d2jVfY1d1+Mnerh/4o7/fHtV/Stc7HpBpIi
   mn/cqIOgmReCe/kv8FbuIGrPZVjGjWz/14K1RRxe3QU3f1CpHxKSd+/o3
   4vLawc18m8qeGw3pnQ8aSWupiGgeW+pe0Y1F2M0ysXFI1F7v0n+eti6Ku
   M+Q7/kpZKFizeefGeZXQBwWk0KtLAM5actC5kyyFydKamiaBYxiDpsulL
   A==;
X-CSE-ConnectionGUID: q8QphguRQVe3dtqy0epbXw==
X-CSE-MsgGUID: YMhQ4Fr6SDaVwUtHhflpew==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39718255"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="39718255"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 14:35:31 -0800
X-CSE-ConnectionGUID: ep9YahtXTXGhcXmlXkZh2w==
X-CSE-MsgGUID: uXUdpgkySl+nxdr8ZVdbMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113208589"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Feb 2025 14:35:31 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thcND-0013Tf-0L;
	Mon, 10 Feb 2025 22:35:27 +0000
Date: Tue, 11 Feb 2025 06:34:38 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6.13] fs/netfs/read_pgpriv2: skip folio queues without
 `marks3`
Message-ID: <Z6p-_nyO8KxgQL3Z@6555c142462c>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210223144.3481766-1-max.kellermann@ionos.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH v6.13] fs/netfs/read_pgpriv2: skip folio queues without `marks3`
Link: https://lore.kernel.org/stable/20250210223144.3481766-1-max.kellermann%40ionos.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




