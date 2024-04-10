Return-Path: <stable+bounces-38027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 397C28A0424
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 01:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB316B251E7
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 23:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1973F8C7;
	Wed, 10 Apr 2024 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJJJL426"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3042C695
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 23:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712792457; cv=none; b=TQFjVncJW/3V8V70d9rTu9bev9gtoqkwmHlXNmJdhQyJ+w1LmOjkynGZVN6uvyTPZLKxDR1eB04k1cpi6FllM4CkCYiJrUbC474GQ7Qc1rwxGiFeqh3GkAqHYXDapNl9CXyA0nf/kDiCVllCUjCRIX06+guPAmT2NVTufxbnjMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712792457; c=relaxed/simple;
	bh=87ZQceCAjd/xjDJE6i37wZhK+s+y88c+97wzBCNa1ts=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Z0CLnFtkQaYu2y8dksWbhX2nBDytFxeBOB/oBY/5mfQyaVfblJo/fEId1bC5ngIdUhYJhemym5df1kY7t8g1Fs9FpqEZx/LUEoW9UdNS5QShYetPmMVJVdaVtby+5e9lZ/M2ZkzWbCdzieytwgSoZzYfzZ+RWbyVw4iZ/Fno3Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJJJL426; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712792456; x=1744328456;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=87ZQceCAjd/xjDJE6i37wZhK+s+y88c+97wzBCNa1ts=;
  b=VJJJL426zKsn3TppNcvhgeM7iaW2PAuxeBv0croKuCS4U7FL1VnZBqTI
   zmy8Hoi1YO/Yd5xEbequkJjgtn+wGgDRfCBPDmlrmlk1Hszz1hQ9rZ4Ln
   4WasUXxl4gs7evCCLDA8BmbTvpbfrgztQsz9HQLs+qc7twlmcoEmI6/ry
   jEvPNt9xDo/+AZyJ/vF//6xYGLXJlkZbJEdnwTa6/jp604S1ewoMJVS3M
   KT4CY3LqGSaviFnvCrkwHIF0DI1bNSY4lrxdFcHBDQY0lvQ+G58Q97mN9
   3WtEWKk6bKezD96avFJawWToH9y3bGTv2Von9XvGiNp1dmDrkHOaMPP+p
   A==;
X-CSE-ConnectionGUID: eoZ6t3sMTsiMusCqqmvYwg==
X-CSE-MsgGUID: j8WtwXKXQ0u5Z5dKBMENjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11976194"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="11976194"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 16:40:55 -0700
X-CSE-ConnectionGUID: 7YvmraeXRWy64A4DwL82qA==
X-CSE-MsgGUID: lqk8oGDfRoOv6/SuLcd1wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="51920125"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Apr 2024 16:40:54 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruhYh-0007xq-1O;
	Wed, 10 Apr 2024 23:40:51 +0000
Date: Thu, 11 Apr 2024 07:40:10 +0800
From: kernel test robot <lkp@intel.com>
To: Saranya Muruganandam <saranyamohan@google.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] block: Fix BLKRRPART regression
Message-ID: <ZhcjWhxZpbgLzme1@92629a18465e>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410233932.256871-1-saranyamohan@google.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] block: Fix BLKRRPART regression
Link: https://lore.kernel.org/stable/20240410233932.256871-1-saranyamohan%40google.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




