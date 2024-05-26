Return-Path: <stable+bounces-46188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374E38CF2E9
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 10:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B456B2164A
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 08:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7818C09;
	Sun, 26 May 2024 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMTk+WaS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B626BA20;
	Sun, 26 May 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716713801; cv=none; b=pHm3LPV9AwuoOaIkgTT4tug5S645y4OhDJc+wMPEaLMS5CAD+tW5RQkNgTDroCgPIEgHtmI9ADOpMELS7hHlkKtnsUUEnrBWcVB5cte5OnlL39Szrd5LARfCDzVCHpfDWbxFGJWPbh4IvyYOM97SsgeCtkSNMZ4+N8ibl1CWJ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716713801; c=relaxed/simple;
	bh=a3Z2lIyQHv6RVR13FbDdXSavIt5v6Q8PcXicKfBLD54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETrlg6v7nQxA/5GCIpBt/7Vsjh50I1Lto0YmL6tpvUuvQqGIq+q0cCjCk2S4oJnT5Dz3zexw3Pps9WgonROdZ9cJGV8LfLMKUxq9MVGTjSsRenr7oBY9kqyvPnXtcbpgZ0XGq3tyfE962LXOvxWvPFMwncHQfusWDSyWyLQtUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMTk+WaS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716713800; x=1748249800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a3Z2lIyQHv6RVR13FbDdXSavIt5v6Q8PcXicKfBLD54=;
  b=AMTk+WaS+lx52NOG2he2wZy2WO/8HsDlPQA3hNZOMLHU2nk8NrNwLkd+
   cNV/4B6ClBFNPDYe55dwg6WqHmdiwQ0RZ3omphSD+KGCDpRWfWFjcYV3m
   l9tNntBCLA8+1pWZSoqCEiwADyiLVGP3eEqrQmXLn8ZTweL+CulfOU1SM
   40Mos+fWCqn1+ELDgtq+pi7WwjDJ7G6Vl+ZPbAYAyiKPxGaDj9L5pZPO5
   Mw7nO+UbIHHDZdso8gfXgIDaZSspPt57bquN+iUPVPQ9KoDwhLCyp7Sng
   nBc1Il1GM7Y6nPqXj6lyj3p3Ruobp+NjMyXDLN3Q5IHdTVMCn5BhOjyYA
   g==;
X-CSE-ConnectionGUID: UE3hiTIcSJKIDWm2qUnuhg==
X-CSE-MsgGUID: GcCzBpFDTm6paf5KyW9lgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11083"; a="12820566"
X-IronPort-AV: E=Sophos;i="6.08,190,1712646000"; 
   d="scan'208";a="12820566"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 01:56:39 -0700
X-CSE-ConnectionGUID: y4bDb+1VT5+gMyZdUzGv2w==
X-CSE-MsgGUID: LwOk/7U5T9aptSILfyuosw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,190,1712646000"; 
   d="scan'208";a="34534036"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 26 May 2024 01:56:37 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sB9g9-0007vt-1A;
	Sun, 26 May 2024 08:56:33 +0000
Date: Sun, 26 May 2024 16:55:42 +0800
From: kernel test robot <lkp@intel.com>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Hannes Reinecke <hare@suse.de>,
	IDE/ATA development list <linux-ide@vger.kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ata: libata: restore visibility of important messages
Message-ID: <202405261642.ya8nqExt-lkp@intel.com>
References: <a116c331-530e-4d45-a32c-37c57542724a@ans.pl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a116c331-530e-4d45-a32c-37c57542724a@ans.pl>

Hi Krzysztof,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.9 next-20240523]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krzysztof-Ol-dzki/ata-libata-restore-visibility-of-important-messages/20240526-144120
base:   linus/master
patch link:    https://lore.kernel.org/r/a116c331-530e-4d45-a32c-37c57542724a%40ans.pl
patch subject: [PATCH] ata: libata: restore visibility of important messages
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20240526/202405261642.ya8nqExt-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240526/202405261642.ya8nqExt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405261642.ya8nqExt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/ata/libata-core.c: In function 'ata_dev_config_ncq.constprop':
>> drivers/ata/libata-core.c:2345:74: warning: 'NCQ (not used - known buggy ...' directive output truncated writing 48 bytes into a region of size 32 [-Wformat-truncation=]
    2345 |                 snprintf(desc, desc_sz, "NCQ (not used - known buggy device/host adapter)");
         |                                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
   drivers/ata/libata-core.c:2345:17: note: 'snprintf' output 49 bytes into a destination of size 32
    2345 |                 snprintf(desc, desc_sz, "NCQ (not used - known buggy device/host adapter)");
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/libata-core.c:2339:74: warning: 'NCQ (not used - known buggy ...' directive output truncated writing 35 bytes into a region of size 32 [-Wformat-truncation=]
    2339 |                 snprintf(desc, desc_sz, "NCQ (not used - known buggy device)");
         |                                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/ata/libata-core.c:2339:17: note: 'snprintf' output 36 bytes into a destination of size 32
    2339 |                 snprintf(desc, desc_sz, "NCQ (not used - known buggy device)");
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +2345 drivers/ata/libata-core.c

  2323	
  2324	static int ata_dev_config_ncq(struct ata_device *dev,
  2325				       char *desc, size_t desc_sz)
  2326	{
  2327		struct ata_port *ap = dev->link->ap;
  2328		int hdepth = 0, ddepth = ata_id_queue_depth(dev->id);
  2329		unsigned int err_mask;
  2330		char *aa_desc = "";
  2331	
  2332		if (!ata_id_has_ncq(dev->id)) {
  2333			desc[0] = '\0';
  2334			return 0;
  2335		}
  2336		if (!IS_ENABLED(CONFIG_SATA_HOST))
  2337			return 0;
  2338		if (dev->horkage & ATA_HORKAGE_NONCQ) {
  2339			snprintf(desc, desc_sz, "NCQ (not used - known buggy device)");
  2340			return 0;
  2341		}
  2342	
  2343		if (dev->horkage & ATA_HORKAGE_NO_NCQ_ON_ATI &&
  2344		    ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI)) {
> 2345			snprintf(desc, desc_sz, "NCQ (not used - known buggy device/host adapter)");
  2346			return 0;
  2347		}
  2348	
  2349		if (ap->flags & ATA_FLAG_NCQ) {
  2350			hdepth = min(ap->scsi_host->can_queue, ATA_MAX_QUEUE);
  2351			dev->flags |= ATA_DFLAG_NCQ;
  2352		}
  2353	
  2354		if (!(dev->horkage & ATA_HORKAGE_BROKEN_FPDMA_AA) &&
  2355			(ap->flags & ATA_FLAG_FPDMA_AA) &&
  2356			ata_id_has_fpdma_aa(dev->id)) {
  2357			err_mask = ata_dev_set_feature(dev, SETFEATURES_SATA_ENABLE,
  2358				SATA_FPDMA_AA);
  2359			if (err_mask) {
  2360				ata_dev_err(dev,
  2361					    "failed to enable AA (error_mask=0x%x)\n",
  2362					    err_mask);
  2363				if (err_mask != AC_ERR_DEV) {
  2364					dev->horkage |= ATA_HORKAGE_BROKEN_FPDMA_AA;
  2365					return -EIO;
  2366				}
  2367			} else
  2368				aa_desc = ", AA";
  2369		}
  2370	
  2371		if (hdepth >= ddepth)
  2372			snprintf(desc, desc_sz, "NCQ (depth %d)%s", ddepth, aa_desc);
  2373		else
  2374			snprintf(desc, desc_sz, "NCQ (depth %d/%d)%s", hdepth,
  2375				ddepth, aa_desc);
  2376	
  2377		if ((ap->flags & ATA_FLAG_FPDMA_AUX)) {
  2378			if (ata_id_has_ncq_send_and_recv(dev->id))
  2379				ata_dev_config_ncq_send_recv(dev);
  2380			if (ata_id_has_ncq_non_data(dev->id))
  2381				ata_dev_config_ncq_non_data(dev);
  2382			if (ata_id_has_ncq_prio(dev->id))
  2383				ata_dev_config_ncq_prio(dev);
  2384		}
  2385	
  2386		return 0;
  2387	}
  2388	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

