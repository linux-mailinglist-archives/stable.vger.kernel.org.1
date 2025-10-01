Return-Path: <stable+bounces-182989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA891BB1B02
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 22:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8BB19C16D5
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 20:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5943019C7;
	Wed,  1 Oct 2025 20:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQ3RBiiN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB493019CB
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350527; cv=none; b=JB0Z7rnX2jltq3BP124IpyO5iIwxd2wUS3K0IDTFzNK3PVvVHKk3JLhT/IOxvyugSiPdOzRj5Cr5ttcXEZ4lrhEalhzOxzdfhjhGdE43uegRnjWKLrL2mGZ8smPRxL6C0RkCy+D26n/ELJDggfNLg9HtousYkxcpaXTsmUkPz38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350527; c=relaxed/simple;
	bh=IxG0dgekPvbjiN7zCcofHz1hete/KLRdMfSiFEpN8Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fE5nd6ImQcQN4TXYBp2LOf7xdEKLHsiEMm2/cgKJ5Nx9JwAGULCnqqw9iv4Kn9Knnqe6BX/puwm3XBk2OOX5xwle2cf1HMSEvDa/hAGwn1Q2n/dLRp/8PvuGJAjVCdLAZMwYNNbhTCqji7ZMx3DBlo9xOXeaYDYSKwF5s8l/Csk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQ3RBiiN; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759350527; x=1790886527;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=IxG0dgekPvbjiN7zCcofHz1hete/KLRdMfSiFEpN8Yc=;
  b=bQ3RBiiNIPwwGygkom35ecwlp3y9s39oLUwVWTLEmMWVoPPTkF7WMoet
   QHPqEk8+DeYcSrKHHAO4t66OKCuES2WpcH1axmG9urPvqTlKlD3g7gyGj
   6lrno/ZjUsXoWP7JOkGm9YYxJFiGE4e7eCl87AwYEEwO4uFR/bS0QOTMC
   viNw62XauVbwbZAFEHXXfIS2bu7348QHftDNJHhvsN3vFmMunAOM2yhXb
   5Pge/M0dvfgp3+iRjTCWHMRtNOoUbYiR76Goetht+7TGFClSJOtwQ5NZC
   KbWYjy+/LUXs2Hs3/2aXbXcrmuvln105/5ivBWCO60xzi5A6L/mxaBt1N
   A==;
X-CSE-ConnectionGUID: Gj5cCCa2SBW9PyZLxZxj7w==
X-CSE-MsgGUID: AIEScr8WR7SezUO7r89//g==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61547212"
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="61547212"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 13:28:46 -0700
X-CSE-ConnectionGUID: GBvyW1HySeWZ+PxirNwh3A==
X-CSE-MsgGUID: cRlMgAzGSz2sBiY34iKv9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="184062539"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 01 Oct 2025 13:28:44 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v43RK-0003M3-0l;
	Wed, 01 Oct 2025 20:28:42 +0000
Date: Thu, 2 Oct 2025 04:27:48 +0800
From: kernel test robot <lkp@intel.com>
To: Yifei Liu <yifei.l.liu@oracle.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH  1/1] selftest/sched: skip the test if smt is not enabled
Message-ID: <aN2OxPbSH6BneX3l@7173c95510e7>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001202501.3238278-1-yifei.l.liu@oracle.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH  1/1] selftest/sched: skip the test if smt is not enabled
Link: https://lore.kernel.org/stable/20251001202501.3238278-1-yifei.l.liu%40oracle.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




