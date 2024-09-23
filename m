Return-Path: <stable+bounces-76904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D19197EC55
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 15:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B069CB219AF
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 13:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64051991B0;
	Mon, 23 Sep 2024 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ab/TTFh+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CF082866
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098349; cv=none; b=VVn9RM08Bro++Cg2tNEP3MicQQZknycmiS6c17SFghxFNTrTttBt5XPqb6CWM2qW2nFID1V/tyU8wQPcmfnVAhbXKX+atHlc1eZ2Aj/qbW9N2EFl6oGbmp6SCmCOElP2pjya+YpqS3b8Bc+xxNgwvjX3xasqEw8otMWhnnsB+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098349; c=relaxed/simple;
	bh=XWITp/fCzbCKojKSeH6yhMy88P1a/1om4wLqVQVQjdw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lH1GCN4jMyVpEX4u8sWgQRNfLjDF7hSwFVz9LvKTp6maZftAeaUXJ8vY1oJdTrSS96Ip4H/po3sfDDxvvQa4uUV0TELSLzzoS8UF37IQcKP/07tMR0lYrC6CDBchj0zZGZX9xaHVd2vilRnKk25R5pe0jMRLneizuWsiP5IavpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ab/TTFh+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727098347; x=1758634347;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=XWITp/fCzbCKojKSeH6yhMy88P1a/1om4wLqVQVQjdw=;
  b=ab/TTFh+0dWEVTvZTy/jdCQ8nkpcMQftOeKDLbztrFuiQ4/dRPmbxhZA
   TK4fhIICASeBA9VxqZhcUtiAA2Ug80vqxdhG4MF/6ohpxU6rPWJZP5I44
   KpqakOrl2MSWKF17wLf6inF/g5qtB7oU705WpmBqMtRFI11nds03cGA+R
   fWTF0UOwviqBWj9uVk4JKKts5KwHYnZjS93MUOSTbx0B7G05ILQuAGozb
   JUV3plvHIVeSjy/oA+1/hevoJwrEVg+dOQfSpAUBGDR5Ttxh0wBOoflgJ
   G237rki/jB6RBgJUB3OYSyUXgl83PaLTP6h9aqNjZ5cyWaNEIlHCT4tMO
   g==;
X-CSE-ConnectionGUID: kapuG06/RVmECvDUGcS1jQ==
X-CSE-MsgGUID: XxCflZByRumIM5vSnqzcZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="43517548"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="43517548"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 06:32:26 -0700
X-CSE-ConnectionGUID: DllLAKL6SCu1Y6uakOmH/g==
X-CSE-MsgGUID: 2Ouv1CYGR2en9hOvZJmrGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71340228"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 23 Sep 2024 06:32:25 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssjAt-000HEK-1h;
	Mon, 23 Sep 2024 13:32:23 +0000
Date: Mon, 23 Sep 2024 21:32:02 +0800
From: kernel test robot <lkp@intel.com>
To: Danny Tsen <dtsen@linux.ibm.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/3] crypto: Re-write AES/GCM stitched implementation for
 ppcle64.
Message-ID: <ZvFt0lAQ8ucFk1Pt@483fc80b4b15>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923133040.4630-2-dtsen@linux.ibm.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 1/3] crypto: Re-write AES/GCM stitched implementation for ppcle64.
Link: https://lore.kernel.org/stable/20240923133040.4630-2-dtsen%40linux.ibm.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




