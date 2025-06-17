Return-Path: <stable+bounces-154597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F76ADDFDB
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 01:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EFCF177A2F
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 23:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F1129116E;
	Tue, 17 Jun 2025 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbFhFIcV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67C62F5333;
	Tue, 17 Jun 2025 23:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750204776; cv=none; b=dtIgTYA6dsGCpLIWGNVNl2t3qIFDOFkDx1X30t2N0JuKUQz/SAR3U27YdZWettp2wVc4xCr8ymBHWGj4CNss6gaVIiFpP9CB01e/gdyBv0enmPNs4PpJAabOpJZcfmF3mtuERlwN0pQ10XJyQaKUa/07/Wvv2xHizlfyawNgxKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750204776; c=relaxed/simple;
	bh=VVGXuDbg8nDIdjZ4Ws7KPGIat3BQbQVtCtmF33fNe40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWzJNtL0LE2jDUrpdJAgX7LIge6RVog3RUf8ahUFiGe58BAM3YG25vRRw0FcIjwuExFqV5YpAskuLT8UgIB0XNctlO56DmQJlVW9TGZSKBBtqWGpjxT+MsUFXUOJc8VyrIbGd3h5RfULYRCIfbwptRKjP69eY6Un9t6K4N/pVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jbFhFIcV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750204775; x=1781740775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VVGXuDbg8nDIdjZ4Ws7KPGIat3BQbQVtCtmF33fNe40=;
  b=jbFhFIcVdiQVJcUABr9Gay8Im8o//qV/TOnL7gOHKl6p2ST37KfIPCG+
   h5bV7cgIwKGlD4DyZ1ep0zkt4a+a4UceiRzeM3/6mFkj1mQ8LtTGUj8nk
   qvlWoBYiw9eo5TprnG2rL3JZ47kT+YrjaA2VwNyWcZ/byRC8odY5dfTnh
   CitcYIoVGrSZEC4Ave8xwlbblqtqPt5CIE9thW63se31JLS+a9oRunCVJ
   sViE6cWShdjg6BTu3FS4PuTzIji8ZMIJy+ol9Ints7VVPOnLfGaM2ccTW
   BlJeB4XoeoJumtJsvQqlQ3tn6wL/Iwssf4U3WCAZAXg0zFTDZ4hD8aQVp
   w==;
X-CSE-ConnectionGUID: VAXcqv00SluG2t26Qp3ryw==
X-CSE-MsgGUID: EgNN86auS5mYeIaI93s24Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="77811719"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="77811719"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 16:59:34 -0700
X-CSE-ConnectionGUID: 3LXbQHrXTeKzJwF6/vyU7A==
X-CSE-MsgGUID: QntltK8qT5KGUt0+NiBFpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="154261780"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 17 Jun 2025 16:59:32 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRgDC-000JEM-0B;
	Tue, 17 Jun 2025 23:59:30 +0000
Date: Wed, 18 Jun 2025 07:58:51 +0800
From: kernel test robot <lkp@intel.com>
To: Pawel Laszczak <pawell@cadence.com>,
	"peter.chen@kernel.org" <peter.chen@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Pawel Laszczak <pawell@cadence.com>
Subject: Re: [PATCH] usb: cdnsp: Fix issue with CV Bad Descriptor test
Message-ID: <202506180958.aX9DgCOG-lkp@intel.com>
References: <PH7PR07MB95388A30AE3E50D42E0592CADD73A@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB95388A30AE3E50D42E0592CADD73A@PH7PR07MB9538.namprd07.prod.outlook.com>

Hi Pawel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.16-rc2 next-20250617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pawel-Laszczak/usb-cdnsp-Fix-issue-with-CV-Bad-Descriptor-test/20250617-155848
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/PH7PR07MB95388A30AE3E50D42E0592CADD73A%40PH7PR07MB9538.namprd07.prod.outlook.com
patch subject: [PATCH] usb: cdnsp: Fix issue with CV Bad Descriptor test
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250618/202506180958.aX9DgCOG-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250618/202506180958.aX9DgCOG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506180958.aX9DgCOG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/cdns3/cdnsp-ep0.c:432:6: warning: variable 'pep' is uninitialized when used here [-Wuninitialized]
     432 |         if (pep->ep_state & EP_HALTED) {
         |             ^~~
   drivers/usb/cdns3/cdnsp-ep0.c:417:22: note: initialize the variable 'pep' to silence this warning
     417 |         struct cdnsp_ep *pep;
         |                             ^
         |                              = NULL
   1 warning generated.


vim +/pep +432 drivers/usb/cdns3/cdnsp-ep0.c

   413	
   414	void cdnsp_setup_analyze(struct cdnsp_device *pdev)
   415	{
   416		struct usb_ctrlrequest *ctrl = &pdev->setup;
   417		struct cdnsp_ep *pep;
   418		int ret = -EINVAL;
   419		u16 len;
   420	
   421		trace_cdnsp_ctrl_req(ctrl);
   422	
   423		if (!pdev->gadget_driver)
   424			goto out;
   425	
   426		if (pdev->gadget.state == USB_STATE_NOTATTACHED) {
   427			dev_err(pdev->dev, "ERR: Setup detected in unattached state\n");
   428			goto out;
   429		}
   430	
   431		/* Restore the ep0 to Stopped/Running state. */
 > 432		if (pep->ep_state & EP_HALTED) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

