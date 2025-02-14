Return-Path: <stable+bounces-116366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95630A3572B
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 07:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B95D3AD6B9
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 06:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B8920103A;
	Fri, 14 Feb 2025 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WzG7C/WU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9A188713
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514870; cv=none; b=TWqfRmdZa6ZunkILmwJPrQMl0wTtYToBQK7NANeIkxKmK9zmL4fZWevqu7ikXG839k74RdnfZY4LOVDXpQ+wmS3hoJ/DjMq91DRkofrTUln4U20NQGTMi0SLOA1VqJ7S9TfCCp7jA8OVytlezwItGFoqdC/NFV69F1kUpEC0K4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514870; c=relaxed/simple;
	bh=lYydoXfZt5BT93QXs1RzbtNljKRHSMTzNWvsixTuo+I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k/B8f/omrGLXrovFglZTIgRgzA1dOUtyIkPZtLdmk7naQeSxid3bfl+YR2VnmyDzOv1mg+EJY7wHKnEWdISlXWzjuVdzwAS29djGS1hhuKBvx6e7NllxEI+Gbxac86BrnqFv54k8AwpkuXgceXj+SMRlzUSWG8637w+rnQxhTFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WzG7C/WU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739514869; x=1771050869;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=lYydoXfZt5BT93QXs1RzbtNljKRHSMTzNWvsixTuo+I=;
  b=WzG7C/WULRK4prZMcv79wINa62EBKHtAH8h4wJaTTFFEIWhCN8+/YC86
   5ysjwgk9rBZCp1xKUM58akxUcPi72Wh1zkMwBi8cjgytRnI39TwSvqxYn
   Jux5WnEu01aUGdldt8Z8Es1xryoBWfDugyhvA11almXbFjaVpO0Y8YMTv
   7qliPnbd4JbMc2r+7F8F0pMPD9JXH8lP7wPCekyrjQBHLTjTuBOeTp8nh
   OJLJpcaMTvcrzJKkQEud2aUpzAptm3hY4nUEqEeM/dd3Vs3BuPvvTMPk7
   jp8LL/fpmPKd2gkxXNZX2MyLINC1sE7cb4wTT1XFmTb5XfckcP551fzSO
   A==;
X-CSE-ConnectionGUID: HV80t/BkQRiRRn7usU34dQ==
X-CSE-MsgGUID: OpQb/l+1RrSpbf1yPizDqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="39478964"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="39478964"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 22:34:28 -0800
X-CSE-ConnectionGUID: 7R9U3R+mRkCeDKp0RqG63w==
X-CSE-MsgGUID: FS/rP9seQ3S+Za5xMqEYPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150548956"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 13 Feb 2025 22:34:27 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tipHN-00199r-0K;
	Fri, 14 Feb 2025 06:34:25 +0000
Date: Fri, 14 Feb 2025 14:33:44 +0800
From: kernel test robot <lkp@intel.com>
To: yangge1116@126.com
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] mm/hugetlb: wait for hugepage folios to be freed
Message-ID: <Z67jyCYWqKsRfhZk@4f51b8f948e0>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1739514729-21265-1-git-send-email-yangge1116@126.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] mm/hugetlb: wait for hugepage folios to be freed
Link: https://lore.kernel.org/stable/1739514729-21265-1-git-send-email-yangge1116%40126.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




