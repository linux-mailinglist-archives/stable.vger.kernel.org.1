Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A807E31E2
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 01:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjKGACp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 19:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjKGACp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 19:02:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF15BBD
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 16:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699315362; x=1730851362;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=gp5r3p/XTnH6qbBi+PCSpiyOPORNXNSYNdbb/idgBt4=;
  b=oKW52hfszmvM22Mtm7dh+OZJBe1ftUB5F4b/jAmGxhLkDGoAefi2jwzO
   4yO/OdXuXoYmoVfIyRokNaFT0eoh8zfp7eJLKrIwmZO+Cco5gxID8Pett
   dHgIojwC5xVlPGOCgen3hn8V04EYWO3WiZc7fk0ZE3SeeiX8iiPNpM6nI
   LcXnzlb+FaG4BCd7cmNmBCuoam7+fUqxMREsWqZubz1R8sw07mSlME3rM
   pLK/PwUU5bs5Mi0Xu41+9k46VUQ5FgucgeRnLRz5YQ9ppQR6pFQ1ANdGE
   US9zBznRK5nG1iQkv/BcKxrWXt5l84RFOMbol8k40EMOvur9LtjtXs5d/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="10937574"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="10937574"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 16:02:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="1009691221"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="1009691221"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 06 Nov 2023 16:02:41 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r09YF-0006pX-0H;
        Tue, 07 Nov 2023 00:02:39 +0000
Date:   Tue, 7 Nov 2023 08:02:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 4/4] drm/panel-edp: Avoid adding multiple preferred
 modes
Message-ID: <ZUl+fCE187+bU4E2@dccdf558eea4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107000023.2928195-5-hsinyi@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v5 4/4] drm/panel-edp: Avoid adding multiple preferred modes
Link: https://lore.kernel.org/stable/20231107000023.2928195-5-hsinyi%40chromium.org

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



