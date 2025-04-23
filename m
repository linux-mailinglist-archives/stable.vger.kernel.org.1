Return-Path: <stable+bounces-136459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5370AA99688
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 19:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CAFC464D13
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDAE28A40F;
	Wed, 23 Apr 2025 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGGEQKFx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430E9289370
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429075; cv=none; b=j2JNIQ4OGfmLnVqFAmW3K15XORa52PxOh06INO1ONRWRnOhK4ytzE7rwWR9KfUH/5CeiZeqiGBv+a+wKH6I141E/yf54abCzKfrVoSdlXW1hCDhpBCau+8LJf36YW5HKS5s8n71bsZirqE+MiTY8f1UlGwkkgOh51jbnY2Gwtyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429075; c=relaxed/simple;
	bh=C/ItQMBGQpaIKTis4fRY7CCBXO1s/q/CifYA91HgoP4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GY5ST5KjXcHpFuXBtRwvrXLNphEUIOVLb2mH6KYYl6H1GXvrsap4lGkv25Sfq1SSRNtcjQ6a/1mP6NDUtBcCJKYMBjErlQYaDIcOiT1PF724T5lvzNWdcCWErq3fG8gXJZ9M6oPpTyBGvX/t3yfDu4waxJYrNyCK57Lfumvl0eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGGEQKFx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745429072; x=1776965072;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=C/ItQMBGQpaIKTis4fRY7CCBXO1s/q/CifYA91HgoP4=;
  b=nGGEQKFxo6g5llXz4dYdqBBQRWVnVCw3SdfnAlR2Zr2DTlGuNCKF9rNA
   fYchqTAB7WnWF4iQ9LFQ8tVMoiNUoOXyLL7WsWlOzxMxH6mmApiP7IZ3v
   HtbWIGhX/hAmZgRezmr3fBQYKO4ZZxVNqUy6Ien6K2RZV5TE78CFKBOSI
   NOOAtnehFYNOqo9OsZTnOHQPRBS4pz2eAbCaBlTSNhhyq/hHRHctjRci/
   wyYkpZxn7B1rIpOUTrEhxwTnAEpy7jooUBilnnfFyl/EiErOv4yUMThSy
   ivoVm0v3JlAaycppKw79mMHHNfrM0cHflgg+qXXjsBFQOQF03v0Q9CPlN
   w==;
X-CSE-ConnectionGUID: nYWk9tdUSgGNVkQyjt8pWQ==
X-CSE-MsgGUID: UVPMTCvtSz6aoH5Q+rWJxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="64561822"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="64561822"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 10:24:31 -0700
X-CSE-ConnectionGUID: SrJgpfbESeqgCUtwmDF8NA==
X-CSE-MsgGUID: dBPTBENqQeS5z5winuISNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="169581926"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 Apr 2025 10:24:30 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7dpj-0003Ud-2O;
	Wed, 23 Apr 2025 17:24:27 +0000
Date: Thu, 24 Apr 2025 01:24:09 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] rpmsg: qcom_smd: Fix uninitialized return variable in
 __qcom_smd_send()
Message-ID: <aAkiOYKT35Sda1uJ@5d75f5d2dfb3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAkhvV0nSbrsef1P@stanley.mountain>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] rpmsg: qcom_smd: Fix uninitialized return variable in __qcom_smd_send()
Link: https://lore.kernel.org/stable/aAkhvV0nSbrsef1P%40stanley.mountain

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




