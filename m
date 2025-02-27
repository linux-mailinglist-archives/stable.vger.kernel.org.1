Return-Path: <stable+bounces-119808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D894A4775C
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 09:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A1D164826
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 08:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4E22222AC;
	Thu, 27 Feb 2025 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egKs6a1z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD621E832D;
	Thu, 27 Feb 2025 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643895; cv=none; b=VxL+lq8vnkRAlO9HRxUUSWLemFDDhmfWuYhcQjqKd9fsUYJRH1dFWuhh+EDjI8c1bMS9tdgwrsLgv5+bsbR0JWuHHzlWtPN9ndjoHIpOqWUXAUZZZVWupNb8ig/ujTJX1rHC7xQNOT0Hbjo9IgvIvtBbsN7Y1e25JMMwhmjEpM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643895; c=relaxed/simple;
	bh=IdCm04ZJ5+6kP/DdU6oVxNDhEQ69k1U/iHKNasH+QxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHECf1HDjrGF3RnuXdnuVhUIOPMZbB8ln5eFE3pkOa1wEsYnTJlm5J2WizzwKEvAYPvfDOvR47JoCj/cxNfDtuN3vVB+2ryrJqd2Ajh8QhQ3795+efAvsAP6F5sM5kH5UM2XbUO8sX9wrOVQ2cLcK74732Yri4G/jOEM0GTvaQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egKs6a1z; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740643894; x=1772179894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IdCm04ZJ5+6kP/DdU6oVxNDhEQ69k1U/iHKNasH+QxI=;
  b=egKs6a1zj0UxWAiy1d3NYG9gPRNHNKAMWt595clTRECfaYOQznyA7zbm
   YQdUZt9ncsUWMX3kNuzMf7oT0F8D6Mz9wWn1u1sswAWbJI6qDkjssCQJh
   TdnHqmw4TzahmxJNDztXRl3OVxq8J+HJjDXKf1XavG9wgN9ABK3AZgK4n
   j2PqSnwFDuyJkvCrkNomYUKfxV29a9KwvmCFU7wk6OiRWfoFWNu15aBVW
   pq6oQ0yknt5LmEhrG/KPIc6G+mal4ZugL3aXdw/l7FeALBOLNxnqvarvm
   5xo8RFas2U8MRg+0jNdEm00538jkeQ9ct7SSmHsi/J/fu9FaUE6nrGfsK
   Q==;
X-CSE-ConnectionGUID: ApxikBYHSRq8lRUFOUpq5w==
X-CSE-MsgGUID: m6nf0hPJTwaeG6Lf2ZlSUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="63989828"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="63989828"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 00:11:33 -0800
X-CSE-ConnectionGUID: KtBs/9o6T2u55FQRHBb1vg==
X-CSE-MsgGUID: lMWsWV+kTYSd39whBQRkhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117864502"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 27 Feb 2025 00:11:30 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnYzP-000D4E-22;
	Thu, 27 Feb 2025 08:11:27 +0000
Date: Thu, 27 Feb 2025 16:10:52 +0800
From: kernel test robot <lkp@intel.com>
To: Pawel Laszczak <pawell@cadence.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
	"javier.carrasco@wolfvision.net" <javier.carrasco@wolfvision.net>,
	"make_ruc2021@163.com" <make_ruc2021@163.com>,
	"peter.chen@nxp.com" <peter.chen@nxp.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pawel Eichler <peichler@cadence.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: xhci: lack of clearing xHC resources
Message-ID: <202502271523.jt3l4VVu-lkp@intel.com>
References: <PH7PR07MB95385E2766D01F3741D418ABDDC22@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB95385E2766D01F3741D418ABDDC22@PH7PR07MB9538.namprd07.prod.outlook.com>

Hi Pawel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.14-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pawel-Laszczak/usb-xhci-lack-of-clearing-xHC-resources/20250226-153837
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/PH7PR07MB95385E2766D01F3741D418ABDDC22%40PH7PR07MB9538.namprd07.prod.outlook.com
patch subject: [PATCH v2] usb: xhci: lack of clearing xHC resources
config: i386-buildonly-randconfig-001-20250227 (https://download.01.org/0day-ci/archive/20250227/202502271523.jt3l4VVu-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502271523.jt3l4VVu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502271523.jt3l4VVu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/core/hub.c:6084: warning: Function parameter or struct member 'udev' not described in 'hub_hc_release_resources'
>> drivers/usb/core/hub.c:6084: warning: Excess function parameter 'pdev' description in 'hub_hc_release_resources'


vim +6084 drivers/usb/core/hub.c

  6067	
  6068	/**
  6069	 * hub_hc_release_resources - clear resources used by host controller
  6070	 * @pdev: pointer to device being released
  6071	 *
  6072	 * Context: task context, might sleep
  6073	 *
  6074	 * Function releases the host controller resources in correct order before
  6075	 * making any operation on resuming usb device. The host controller resources
  6076	 * allocated for devices in tree should be released starting from the last
  6077	 * usb device in tree toward the root hub. This function is used only during
  6078	 * resuming device when usb device require reinitialization - that is, when
  6079	 * flag udev->reset_resume is set.
  6080	 *
  6081	 * This call is synchronous, and may not be used in an interrupt context.
  6082	 */
  6083	static void hub_hc_release_resources(struct usb_device *udev)
> 6084	{
  6085		struct usb_hub *hub = usb_hub_to_struct_hub(udev);
  6086		struct usb_hcd *hcd = bus_to_hcd(udev->bus);
  6087		int i;
  6088	
  6089		/* Release up resources for all children before this device */
  6090		for (i = 0; i < udev->maxchild; i++)
  6091			if (hub->ports[i]->child)
  6092				hub_hc_release_resources(hub->ports[i]->child);
  6093	
  6094		if (hcd->driver->reset_device)
  6095			hcd->driver->reset_device(hcd, udev);
  6096	}
  6097	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

