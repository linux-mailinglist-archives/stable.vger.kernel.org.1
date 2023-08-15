Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CF577C86F
	for <lists+stable@lfdr.de>; Tue, 15 Aug 2023 09:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbjHOHSE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 15 Aug 2023 03:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbjHOHRc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 Aug 2023 03:17:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49A210F0
        for <stable@vger.kernel.org>; Tue, 15 Aug 2023 00:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692083851; x=1723619851;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=BO2vlgP+zJS416U1Mj3ShdC7MqfFW0Og3vvdCXCl7og=;
  b=FawbX+x75vEe8PbRAr7SXh78qq/j6tPFWCdSjUoM2JHowrwT7QUQ+IRa
   1R5og7ALgWwreaqrc+N2RDpDSaVPT+o/aBkVqJ+gwwseI7z/N5tgS3sDL
   VOzzem48SdN6HxmGzlfiHKtZkgS4xLgMFouB13yx1HNJ9cgj2M8iG5YW1
   tJk5h/FQgvhzFkSq4EOedBBJXoMKPxRg87k1bOZ/Thg4iOY/tgkdQjm1f
   4+0JM3317mUzNx5liiUzO4Ee1a95o4O/4TinfGH3KCLyBr1I7cQnmQd5i
   SHJtiwIZmV4NYyiYCD16VOODii/yKUKPZpLdQi27WMqHnsiThG2epOztm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="374991255"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="374991255"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 00:17:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="799106492"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="799106492"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2023 00:17:30 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVoIz-0000l9-1X;
        Tue, 15 Aug 2023 07:17:29 +0000
Date:   Tue, 15 Aug 2023 15:17:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] tty/sysrq: replace smp_processor_id() with get_cpu()
Message-ID: <ZNsmfV+KY97Oxi43@de6b5a1e2688>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815071316.3433114-1-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH] tty/sysrq: replace smp_processor_id() with get_cpu()
Link: https://lore.kernel.org/stable/20230815071316.3433114-1-usama.anjum%40collabora.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



