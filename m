Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8554A79C457
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 05:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbjILDqc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 23:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbjILDq1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 23:46:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4955D10EB
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 20:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694487733; x=1726023733;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=b+7vQ3gcDrvCYXFKtOaJZHg6kU6GvLosAhUKznK801o=;
  b=lA4C4a1cUAvqTeiTVkvs77OBvu7GaLeqPctUYmsLEt0pQqKh2O8o57/5
   FS7IH+VITnIM9mm/D8HC6pigVxrpmaaJwRFPbvq0hsL8LbnJzhoBtFRhj
   TmVpPyA82L1WRcSaWQ2wfjFQ/YNhsOtsnEFxVVfr7O1QJjQ4i7ji1EV5Y
   GNdB5IiJnxWqKHASLNpKD30GxVNbubINe58pDI0ZnqGYQmvjorYJu+AjW
   oLTE3eqyU41mixLF53ekU0RWmNMRldlt9bC4ng5yuKg5aelffY6126xNv
   F6aVDVGlT4lOuQdC009xoDdglEpABTr9eEWByN+IwUgW5HudOfPgkLurb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="382075843"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="382075843"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 20:02:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858606801"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="858606801"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 11 Sep 2023 20:02:11 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qftfF-0007Ba-1H;
        Tue, 12 Sep 2023 03:02:09 +0000
Date:   Tue, 12 Sep 2023 11:01:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cindy Lu <lulu@redhat.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [RFC v2 1/4] vduse: Add function to get/free the pages for
 reconnection
Message-ID: <ZP/Ugy0vLvmomlWG@0091dd92274c>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912030008.3599514-2-lulu@redhat.com>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html/#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [RFC v2 1/4] vduse: Add function to get/free the pages for reconnection
Link: https://lore.kernel.org/stable/20230912030008.3599514-2-lulu%40redhat.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



