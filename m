Return-Path: <stable+bounces-92864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8239C6588
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 00:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8E3285546
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 23:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B5B21CF85;
	Tue, 12 Nov 2024 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4QZFO/t"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0453521A6EE
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 23:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731455617; cv=none; b=t9U/x7bqVhn8bc4WZi5IgexDKJYR9biZ8Cw+OiryoT+nJuYnEo8L7PQfVTfB3/rF0rl5/0rA6+QeBYFcLV21Lt8hBrra5nhiL1qcUzw9EVn8yx5LpSQizZrC645F9oEuIsxQK94nHAUkhDikPBT6JcXhF9OBgZfETGeU5GP5sEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731455617; c=relaxed/simple;
	bh=1iGzqigt47bXsGjFo4BNZ+3OU9eCj9hR6h9/qZTH5/8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rrn6E2pgYhTtkXXsYhf7mS02htBEFa+pIgOgf3HK4L2CM6n9DyxgzdpkREu0e1z555ZYikGnigro01EfxIF2IJLfr21FvDh8IzMJz/FWqDzxzqBh8X7gw2uw5oOl/hDBpGDhfPzRJCYnVAXr1zYv3Kto9vL2J+j0oYpXbVwJK0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4QZFO/t; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731455615; x=1762991615;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=1iGzqigt47bXsGjFo4BNZ+3OU9eCj9hR6h9/qZTH5/8=;
  b=a4QZFO/t84vEKhCgkZpVtUa7n9wEQ29IT/p3/+jfAOY6h+010AZS5PoT
   DBuW8uqLvlbQoQ0XanQPy5WeNCLRwUg34qbgAZpXGv4BEsOpMEQXflaXJ
   wH76kD/KX7RSvPd7sceuIL/p1ObRw7l56Cw86KvqkpoQGvTE500HF+4Pe
   Q5g7hjadmgPElbhS6EKa6A3jaxS8COIbAc6L7xZKoeD2kiyMax3Zl/Wet
   m0kXORt4H/QrqaFMvutvjPOHCj6A5YlU8VjrQwA0mOlnr3vcE5ag+rIPb
   UzD+LH0AzaZGep6cQDRpOJciY7Ff8rSZpCBtn1PaKchtRSkkLozwIIF5y
   Q==;
X-CSE-ConnectionGUID: UM8gU+kgTiiOOnI0+tx8sg==
X-CSE-MsgGUID: XvzhDnxEQ9uDWeGSa1R7AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="48831691"
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="48831691"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 15:53:34 -0800
X-CSE-ConnectionGUID: bpbye+LeTNC55BtAFdUg2w==
X-CSE-MsgGUID: dzdiTPWTSJyTNXFclb2A+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="88104711"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 Nov 2024 15:53:31 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tB0hN-0001qT-08;
	Tue, 12 Nov 2024 23:53:29 +0000
Date: Wed, 13 Nov 2024 07:52:58 +0800
From: kernel test robot <lkp@intel.com>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: update Alexey Makhalov's email address
Message-ID: <ZzPqWm-YO9lFYcfU@541d46c0cbaf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112235013.331902-1-alexey.makhalov@broadcom.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] MAINTAINERS: update Alexey Makhalov's email address
Link: https://lore.kernel.org/stable/20241112235013.331902-1-alexey.makhalov%40broadcom.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




