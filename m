Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F05177F859
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 16:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351459AbjHQOHZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 10:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351797AbjHQOHM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 10:07:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791C4E55
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692281228; x=1723817228;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=VTd7gdLwXsaWLmv1ZnaaBMBzLXZonGqE6wkQWQHOIYI=;
  b=eWrM7JCpYXvs11v5HV/tWF5rEiBpRUs7uAErjTXEkspRsrsvuEtqbx+A
   +m3sKaMursXzNLmjAFfVY0ZVz2267DtvgFMzdFuw0sQRQ+LrY6+uK0YRK
   rt2ZdVzlLSSlu5t/s3KteTvFRbWmEzS2v6Ccq1HYM7Ca4Ji7d7BOsP4QG
   HSlHi6nOVhCWL2A9oU96DqcwngZ3qRlHkAno31IuY+PVVcWPhw20m1/5E
   NeNkOk1MtMpgETErudgQ+cVl6c9Mp4GhMAR+SaIEvdSI3QaowDOyGBJf4
   MeV2tv7hqLoAwVHnwXi+uaut3sorlfivnchu5aSSDsKtnCnrK+TIxR+5j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="353132361"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="353132361"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 07:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="848893628"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="848893628"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2023 07:07:06 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWddT-0001CJ-0j;
        Thu, 17 Aug 2023 14:06:12 +0000
Date:   Thu, 17 Aug 2023 22:00:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dirk Lehmann <develop@dj-l.de>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/2] drm/edid: Fix "Analog composite sync!" for
 current eDP display panels
Message-ID: <ZN4n7pVUNbPUM/U4@78f66d62e261>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qWbpR-0007ey-0B@djlnb.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH v2 2/2] drm/edid: Fix "Analog composite sync!" for current eDP display panels
Link: https://lore.kernel.org/stable/E1qWbpR-0007ey-0B%40djlnb.local

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



