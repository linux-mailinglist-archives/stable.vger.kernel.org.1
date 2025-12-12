Return-Path: <stable+bounces-200876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52069CB8323
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 09:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0884F300BECC
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F113A25B30D;
	Fri, 12 Dec 2025 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/O6ZY9S"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B06125783A
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765526439; cv=none; b=R9ybNVMLk5CKauBPaYOdyj15jMhYWcVBrSk47GxP4+kySH7cSt29ne/FujIRXAGnJWxPPAdYAzZijBmkryFikL3obICvMQjyPIuVwOdWKJkCTTVIaZ65Vee7SxPMowM1yoTlpeDcpBWh405fGEBWLa8Xbe0trIuAvF6hG/6W2IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765526439; c=relaxed/simple;
	bh=bAml6IxBfHyqK1mGi+ADapGUFFsfdzcU/lzHzJ/vd+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mB+WpnImfXbg4YIv+HsK95DNTT/85a55uht4UhLdzMJBHm2x60fnzOyI/jZlaikBeZpmA4oPcrW0Z68gQDl7iRkbSNVsN/909UBVuTgUe+YCKVQHnu5/Ri2hVpMyprZIFLLvq9NZx/Wf0mGIQTBmT0kLBtykFaiXm5FVxPVbdoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/O6ZY9S; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765526438; x=1797062438;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=bAml6IxBfHyqK1mGi+ADapGUFFsfdzcU/lzHzJ/vd+Q=;
  b=M/O6ZY9S7DaiE7MJgrQAv2nWITFYy5e44VgaALbAFdZnGWRXlGuvaxAv
   2rEPcFDlFj5hj4LKAxcMnnWU8BumLbGMOt/WETU32dvwTu+FXN2Q+JmmK
   IWYem1klh7AG2JepHbvdtMwmZ70k9mQ+mSr51AoT2kL8C4phd0UcL21Ty
   /ZwneBQxFxOjHO3gC8Dhc7ydOtX1jMGNfH+GVc7eHfQsCZQ9dnUbGcGTX
   XUdhvRWWs3yMJ7Ocz9hygqu6n3afgEK0ms/ukDQA50sWcBTWNPVamaX6x
   3nIViZVNz17NYoOndqt8BNWv0ObQlWP/buGQgOfqiThksEkDAiLIRMtmJ
   g==;
X-CSE-ConnectionGUID: 32AMwoeKQVKTqIHc6YT7Lg==
X-CSE-MsgGUID: yYX2FVCtTF2xeTphKCoEcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="90166056"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="90166056"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 00:00:38 -0800
X-CSE-ConnectionGUID: aO56LnOxQjKT0pBlhKn19A==
X-CSE-MsgGUID: qiGho+XxQsSEJJosbGnMtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="201495046"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 12 Dec 2025 00:00:38 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vTy4o-000000005l3-3F5Y;
	Fri, 12 Dec 2025 08:00:34 +0000
Date: Fri, 12 Dec 2025 15:59:36 +0800
From: kernel test robot <lkp@intel.com>
To: Frode Nordahl <fnordahl@ubuntu.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] erspan: Initialize options_len before referencing
 options.
Message-ID: <aTvLaG2K2qvmVhbS@7da092942895>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212073202.13153-1-fnordahl@ubuntu.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] erspan: Initialize options_len before referencing options.
Link: https://lore.kernel.org/stable/20251212073202.13153-1-fnordahl%40ubuntu.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




