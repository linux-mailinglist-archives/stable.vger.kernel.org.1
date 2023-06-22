Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8D373A849
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 20:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjFVSav (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 14:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjFVS3v (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 14:29:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBFB2100
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687458588; x=1718994588;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=sAMtdJGFOrPNGvo+P+jzCmggQReY0RKjVQsxVZA/FRM=;
  b=Zmdi1fSNrJRWJpZ9dxL3FQ5piS0NRv7LTVMOha0dCiOj71nqQKbJkMyC
   FkYombLl+nno7128CEOsc4ublXnjgQC09mgdtS8yFIr32PE7jbjH6Ere4
   X+otmKXTE2zUZEQ+gcSHMfwn1joVu8JSmK5Yg8lzNuNXnEk5t/CJbnhpq
   R17OAG57sfgpmUQPyl17Y2M6oFhg+j1VggVMJwxan+cUHRsZynWaWQaXi
   JP9pAg1NDR4TajFKeGJI5HhHSFmN5j8qCxqkoX1pptkRkFvZyCC2HA+2D
   ++qGaNWf5FSpQEbcGc7qXrY4zl9bQuM7iywjxCBBdkrpXLj29+ttYUde+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359438453"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="359438453"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:29:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="785026514"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="785026514"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jun 2023 11:29:46 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCP3x-0007jv-14;
        Thu, 22 Jun 2023 18:29:45 +0000
Date:   Fri, 23 Jun 2023 02:29:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/3] drm/i915/gt: Drop read from GEN8_L3CNTLREG in ICL
 workaround
Message-ID: <ZJSS+Ca2GSIazO9T@65525e8f8615>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622182731.3765039-3-lucas.demarchi@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Subject: [PATCH 3/3] drm/i915/gt: Drop read from GEN8_L3CNTLREG in ICL workaround
Link: https://lore.kernel.org/stable/20230622182731.3765039-3-lucas.demarchi%40intel.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



