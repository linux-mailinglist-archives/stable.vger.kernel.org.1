Return-Path: <stable+bounces-181512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8620B966B1
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 16:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A2657A67E9
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BA21F5846;
	Tue, 23 Sep 2025 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYJu/YvU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A12045B5
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639074; cv=none; b=pkYCU5jpKoSUKvltE3m3Yp2QNFCtHij6DDOXwk0FbmjHJtovJ0BDOeyKZNVTOXCFqEvDClX+cDlzqhW3OAdmZlOkMOpwBYFTL6eK9q+YEGn+XDo3NOhnhgUk47AvKGhLSTQfjJagZH1404lAw3lR88Jtctadi7Wg5AveZ0lJNFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639074; c=relaxed/simple;
	bh=5KbQpeReOQh2dXObwe29N0T/Sd+95cxOk93zvLMruTc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XMULR0N+UWULLj5sTKzfTE+o3YtOOnntXH1tjd2lDKUqpVMzYfYsUGFN/pT3KmAVOdqrgeG81bb8ryNPAbDU8NYhICuPIjaCkd3OF09LfiGhNazGa/xNOZj3eKObsHqXCwEbZOPOw0+MciACOAQiEHS1RLjohfwrpXhAQAM66Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYJu/YvU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758639073; x=1790175073;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=5KbQpeReOQh2dXObwe29N0T/Sd+95cxOk93zvLMruTc=;
  b=aYJu/YvUc9bXUzflouGQTR2Vz/LAFf8db7EZYaVSw9BNEIIZkXXfIm59
   eBTQdIJfmh8sO+zwyjJxmvk9kgMKnkAChPEMPm6d+IVwR4n2k4gwMf2vx
   tcHFfjD9eIeP/MivqIUuk+qo3SS9cFLaddrGI1awJ0xER/GrSS9rdZBcc
   HLKAXGUPjnfYhWW4G06f5a39brtEFbD3nlF4QaporiJVTAYPehIobKQBW
   BuV1HkOYAMAWBLOVlj0ckOx5PnhOEfHul3tLTGleaCirV0hohlMku4bVK
   UNqyUMwBrygWNJmjluDv+tht6ZGkcOtmeSBuR6ysMsKkwWASq2Jn+JT5p
   w==;
X-CSE-ConnectionGUID: 5ZNAsywXS/y9ZufGU/bwiQ==
X-CSE-MsgGUID: h1t2GS0BTBaiFspwTJPw3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="78527373"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="78527373"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 07:51:12 -0700
X-CSE-ConnectionGUID: 25WPdY3NSnODegY+E8MNSQ==
X-CSE-MsgGUID: r8UzGHRcRJi+nffW06u1JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="207711549"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 23 Sep 2025 07:51:11 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v14MH-0003D3-16;
	Tue, 23 Sep 2025 14:51:09 +0000
Date: Tue, 23 Sep 2025 22:50:23 +0800
From: kernel test robot <lkp@intel.com>
To: Lucas Zampieri <lzampier@redhat.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] irqchip/sifive-plic: avoid interrupt ID 0 handling
 during suspend/resume
Message-ID: <aNKzr4B2VN1VaQmX@3514630e72f8>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923144319.955868-1-lzampier@redhat.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] irqchip/sifive-plic: avoid interrupt ID 0 handling during suspend/resume
Link: https://lore.kernel.org/stable/20250923144319.955868-1-lzampier%40redhat.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




