Return-Path: <stable+bounces-52252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1047909587
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 04:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DDBC284065
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 02:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E245F1FB4;
	Sat, 15 Jun 2024 02:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvfuSe0p"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F819D8AF
	for <stable@vger.kernel.org>; Sat, 15 Jun 2024 02:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417137; cv=none; b=HbH7xMXKk7N9XVR0RptYwlYAxbMYPbdFb3Ev1ON7IgUMITnbDA/+oK8ruV7TEF5BgbWoasa6jdqtZQNy7FELKpUmRpHmdSx1gtIWs7TNcx3PQ4Vu8VS9vOmPNLhIyFCgo+wmU9Z0DWPmVMvtd0sIJcdpgyj1NYX13YtJxvLkmR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417137; c=relaxed/simple;
	bh=39ZDLvSCKAmm2UObLH1cnd04garr8pX7gWJN9k9+WJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nNj2L2SU00TqD6vzzW2yGoI4cKgeMp7CRuGd06eJB+onFy30+3RQJjQnEYlglUjkKAwpgju2CFZiDi1rk58SukuyG3198N5b7wQ+seKrGz7gqzaBt7J9/y2vAYLSwpZoAg/jfmEirW/HugSfsCEReT4S7GCJUkUuYw8vA7huZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvfuSe0p; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718417136; x=1749953136;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=39ZDLvSCKAmm2UObLH1cnd04garr8pX7gWJN9k9+WJQ=;
  b=nvfuSe0pS5dJgrNcWOm3ToHTPoONlb9Ek+stmcEp/MzgcOHu1y0kOTRb
   6I2Rst855znQuD7/IJd6uu21uhY9zj637nWar41K8fg4pJt2hvcin366+
   vzaNQ7r19hhQaJFKM/XWbrQnR+WLBQMchZ/GcZT3pANDf0WNaaH+jLF8I
   clc94vQwZa725nTa9UW8Slvsq3b8p+eb/r4DJkr7HAzleCxISWs78JrbK
   4uYoq4NcwfUDuzAb1dquhgvZ5a9B5Ezl0XAbz3yAmPjHVt9XNiIsxK4OO
   /1N5sGSuzmnT3UHliAepyotow3h9u4CG/1eO2mipXP1E/w4q0tZZMdh18
   w==;
X-CSE-ConnectionGUID: DQ97WQhRQb+Yz5FbUVGkzg==
X-CSE-MsgGUID: kZ/TMPLdRq6MA0ddHVxd5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15105616"
X-IronPort-AV: E=Sophos;i="6.08,239,1712646000"; 
   d="scan'208";a="15105616"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 19:05:35 -0700
X-CSE-ConnectionGUID: mrz4p4p+QWePeC+BL7cEmg==
X-CSE-MsgGUID: LkViU/yQQeKuUJoAB41PJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,239,1712646000"; 
   d="scan'208";a="45619272"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 14 Jun 2024 19:05:33 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIInL-00020B-0e;
	Sat, 15 Jun 2024 02:05:31 +0000
Date: Sat, 15 Jun 2024 10:05:28 +0800
From: kernel test robot <lkp@intel.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/2] docs: stable-kernel-rules: provide example of
 specifing target series
Message-ID: <Zmz26OcJUkBqZdV5@6715f18d4702>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240615020356.5595-1-shung-hsi.yu@suse.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 1/2] docs: stable-kernel-rules: provide example of specifing target series
Link: https://lore.kernel.org/stable/20240615020356.5595-1-shung-hsi.yu%40suse.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




