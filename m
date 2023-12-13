Return-Path: <stable+bounces-6542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E968106C6
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 01:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE6EB20EE8
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 00:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720D7A41;
	Wed, 13 Dec 2023 00:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuzlRARs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202F092
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 16:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702427897; x=1733963897;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=YcJt9IXIkiNyi/hImJF2SZNtZU9rFDUD8sh9hZRpYNk=;
  b=TuzlRARsT4ydSj6RlewkiDTXVMClx6YWqni2YaqjTBPaK/naNhCMNRVr
   DuPwIZnlg0BlLYQHmnPu0MMxmMHFHVH3cS+Bj1rXpozpPXDGzdmgJ9FU8
   q3DhcbsT+UbzIbFm9iHa3KCwYIgMB2wG6Wfb3ws9rsnMT22pCOW0jbyUi
   ErIRnQBAVZQ/Zp+xdQsH0qKYHjs2ZBY5vMWRJ7Os8qKeaMsX5CEsreoNI
   jV2OdSL31YgyPJzTUK2+2zBs0kr+jmCAy00BWn30F8V3GIHPDNuDqm8dc
   IjGPH7Cj3Wb0icNZsSsCwEleEroahEBiZvLEAhXGhXBsAWsmBaJ7BMm5k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392069294"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="392069294"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 16:38:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="749899227"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="749899227"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Dec 2023 16:38:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDDGP-000Jul-0h;
	Wed, 13 Dec 2023 00:38:13 +0000
Date: Wed, 13 Dec 2023 08:37:20 +0800
From: kernel test robot <lkp@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [RFC 1/2] PCI: acpiphp: enable slot only if it hasn't been
 enabled already
Message-ID: <ZXj8wESEjwBQk9At@171f04e7aea4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213003614.1648343-2-imammedo@redhat.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [RFC 1/2] PCI: acpiphp: enable slot only if it hasn't been enabled already
Link: https://lore.kernel.org/stable/20231213003614.1648343-2-imammedo%40redhat.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




