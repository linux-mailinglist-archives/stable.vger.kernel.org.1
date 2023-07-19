Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A276759961
	for <lists+stable@lfdr.de>; Wed, 19 Jul 2023 17:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjGSPT7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 19 Jul 2023 11:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjGSPT4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 19 Jul 2023 11:19:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA98CC
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 08:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689779995; x=1721315995;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=KLEyJTGbljkQ49lNNTsC1Gi2wbimOnnXCv1PmewCm3g=;
  b=RHOURP9KxxWCEvU7wnCC+2nm1YPhQaaXKxFvG2F5qs33G7CzNw87vJLY
   GX2p6+oUGUf+a8OPd240eQ3O6rWHGmg+zmEVhLZUCAO1LM93x20QELDNg
   miHBv8e6/cGt5GG0XAXEKpkcbY55UmVunt6ppedX7mqGv7T0WbeDe4KPk
   NYBYHJLCKnk2+9Ci3VmgNgYzcmJhQdK5yD+qG04fzdii4xzcCmX39Fd/u
   zqrxNEz7PqJroUkqgwkQWBZ0gmtj0CDwfQ4Rq07NSuhN1AIJCz4RwZYqJ
   IgSTK9f7ZgY7uOI3ykJLn7T0LdAxmNQl2QdReyac8FtwpcZDif5vWLwtK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356451843"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="356451843"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 08:19:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="848085208"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="848085208"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 19 Jul 2023 08:19:35 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qM8xe-00053H-0s;
        Wed, 19 Jul 2023 15:19:32 +0000
Date:   Wed, 19 Jul 2023 23:18:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 1/4] fs/9p: remove unnecessary and overrestrictive
 check
Message-ID: <ZLf+wZaouYvQCGaS@c507f7d2ae6a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v3-1-769791f474fd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH v3 1/4] fs/9p: remove unnecessary and overrestrictive check
Link: https://lore.kernel.org/stable/20230716-fixes-overly-restrictive-mmap-v3-1-769791f474fd%40kernel.org

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



