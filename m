Return-Path: <stable+bounces-74143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D45972C91
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E541C24661
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 08:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38519186E21;
	Tue, 10 Sep 2024 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gT44vcUJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C8718755F
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958444; cv=none; b=nGCI065mIoFyOVPcaH90ry6YeVMfle/2JvbHe56S0M2iUS2Y6LW6c+KceFb7D1Zg/C0Z6YGGwVcO7lFz9keynpJVjgavZ3RF9gudqB+YWCxDxv0oW7H4POOfjco7WPje9IAEasdC32qAQrj5t7myWugvbOOOBHCQqEciO7jIlyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958444; c=relaxed/simple;
	bh=7hu+i1kFclsAI2CDDxwLdICUKZximXQl3rttWU7SWMM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PwMp9bj0++Agd9eT1v1+DsLrJaMl0+cG+Oejh/5NJmSTt8rbYlQaSqpYhheds6HOgi3y5YalVnnvDXOjGhkQ+MdxeD9tQwSOr8QZRiMNCtmPRn2kT1oOBbPKQuOMPEvLH0cNbGLslwB7mBH0xAUcQ0FCCcsxwrKV77L/x1EBcfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gT44vcUJ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725958443; x=1757494443;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=7hu+i1kFclsAI2CDDxwLdICUKZximXQl3rttWU7SWMM=;
  b=gT44vcUJMsOfIVHX6ogUKnwYqoc5qUFS2tfPouIVZALzc/qskHF//m1a
   o5UOgaYWxeqAt3jig9kEBrq0zniw5B9ix92Vnr2jpuKygcTvwNh9nQxHZ
   KZ5HwapubtJDdDBjOaybHiPyV0lhluWtlizVuKoxuVtBWDK+SsvzjW4CJ
   ituzToT+jeRLlwxy0CTNEgI3ZvfK0F2smzgsJ7apa9L+ZLHHAd21Qpczp
   Uckoe5EgddblwGiqT5hOCC8sgT3rdDJ1xS+WzI5MCCSkxnW7MRLIx/s1V
   do1tqg/1KW/qsqCuFWKHL7xEP/wGHxfaV3MtxSPqZdMjTdQvtY5YSlhcS
   Q==;
X-CSE-ConnectionGUID: lRWf+MRmRqimx407BjEXLQ==
X-CSE-MsgGUID: GLtDMbUTSIGCqv9lRjWp2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="13454180"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="13454180"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 01:54:02 -0700
X-CSE-ConnectionGUID: rK4g7VhOQWSSvhvMcHReRw==
X-CSE-MsgGUID: bb0FsfxUQDKm9HOPBBqqQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="66921426"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 10 Sep 2024 01:54:01 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snwdK-0000J8-2a;
	Tue, 10 Sep 2024 08:53:58 +0000
Date: Tue, 10 Sep 2024 16:53:08 +0800
From: kernel test robot <lkp@intel.com>
To: Anastasia Belova <abelova@astralinux.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] arm64: KVM: define ESR_ELx_EC_* constants as UL
Message-ID: <ZuAI9Fw0-ftS3VLH@b20ea791c01f>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910085016.32120-1-abelova@astralinux.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] arm64: KVM: define ESR_ELx_EC_* constants as UL
Link: https://lore.kernel.org/stable/20240910085016.32120-1-abelova%40astralinux.ru

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




