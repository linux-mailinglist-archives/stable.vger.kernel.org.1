Return-Path: <stable+bounces-85081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4302D99DBE1
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 03:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744D81C20A90
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 01:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28A7155308;
	Tue, 15 Oct 2024 01:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNJZZo1d"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE291E4A9
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956963; cv=none; b=eeE7KmZVNL8dNXOWwtXoIr/8NBQcFtJFUdN+WpOn/S2czjhJgVUH8xPMom2cPaNz0gc2w2N9uRlrHGSiixqXG1KEGto4Go+a4G8aFYVm2E+4VSCf+LSLfiz5g2HOc7nBg5gcbkTbLKogKHW0lFuQ5OLXbb/Ro1Qjob7Wys9gyIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956963; c=relaxed/simple;
	bh=RhNyz76qPI6+n5RwAes9G5wRNWu5JEbCcb3TYxHs6ys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Dx40/cvTGoRQ8Sa+ddwchzdK5T2j8nJInZ0TOgDjqWiMev/cu0I7ynURsZ1BrxZn99Ln2YDAywNUHfYzTuihZjNyoza2I9+DlZrBXMR1Z2CNqybfWPSNJVbKITVjW4tb3+Z6U5mdAsMp5uy7t9yf8HOtVPXR3xcOp1S30NM2E/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNJZZo1d; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728956961; x=1760492961;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=RhNyz76qPI6+n5RwAes9G5wRNWu5JEbCcb3TYxHs6ys=;
  b=LNJZZo1dqZf/94pulKep2Em/JBjuM+ifGP4EAkSguBAwI08+aBAoojpP
   fSaKKnSeQzWgNCj10N4L6jc/YSxTSgRf7AjI1KdW7ODuKCPt2/VJdODvU
   0HbUdPe/JN2UgmxwG2zrbV2pTMQeSy3ZrMCKryfzAkVzwToM/r/Z7Rccz
   ZofWALgcpQcn7vXSPFzxEDS98kZ0+VL5H0YBAHNdVk1cPN1Mwu18bEHmJ
   xJlAE3J3JQqXMQgGe32UNX5r14m02yqp9rrUTJrKScJ7IRSZWtZCQn8yC
   WZ9VnZhYtBy2fXSAMjHsHG7Q/fhVrfA+pDy7QmyQarK/3d8T5xqvEQGuc
   A==;
X-CSE-ConnectionGUID: 7AstA3LPQ7OIGX5ckq9SvA==
X-CSE-MsgGUID: UWJIjJ0XS1aB6lf1cjRCZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="15948789"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="15948789"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 18:49:20 -0700
X-CSE-ConnectionGUID: Bc3Fn8NBTr2j1Sp+CFxS9A==
X-CSE-MsgGUID: awmrzWz0TEul7DJNxZxr4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="77914741"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 14 Oct 2024 18:49:19 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0WgX-000HSX-1K;
	Tue, 15 Oct 2024 01:49:17 +0000
Date: Tue, 15 Oct 2024 09:48:32 +0800
From: kernel test robot <lkp@intel.com>
To: Liu Shixin <liushixin2@huawei.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] mm/swapfile: skip HugeTLB pages for unuse_vma
Message-ID: <Zw3J8LYEeJ-Bs-Xy@841ce2d326e3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015014521.570237-1-liushixin2@huawei.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] mm/swapfile: skip HugeTLB pages for unuse_vma
Link: https://lore.kernel.org/stable/20241015014521.570237-1-liushixin2%40huawei.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




