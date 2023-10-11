Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585097C48E7
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 06:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjJKEwE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 00:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjJKEwD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 00:52:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265C694
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 21:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696999921; x=1728535921;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=js7pF/+qKAwfI2zBJAjM2YED0nSvmfq4gb6xk5KIdYQ=;
  b=YQvs+3AB3r4SD82rIod1JzzVrwugHaW0VKQR/K+sHQ15Zl6Piv7jszSP
   8MwePMwNqOYiVxSHfTQL5o1IRIzKsyk9NXlnrWvMia8+YYBmkSXgAUP1D
   DrMdhtDAuygXtLTvNDQfqcISGkmPjTyXLgBtlXvHQBeGNTPlD24iSU4mq
   biBedDOTRIdJHhNGEhFwe1LmyGityCd9LB3OMY1IZaT7e0qgFe+EUJLJN
   0ZfGjb4IwZbLID/6Zb5FyabMhqhotwqk2yn2fUCfJd8JQ5M9ah8zqVOkc
   kt0yo+QQCe/OtZD93IEUhzPc4MChXSibJM2BCwQysFB+sF78Ek3WFNROJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="374921375"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="374921375"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 21:52:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="877525059"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="877525059"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2023 21:52:00 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqRCP-0001kP-2q;
        Wed, 11 Oct 2023 04:51:57 +0000
Date:   Wed, 11 Oct 2023 12:51:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [RESEND PATCH v2] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
Message-ID: <ZSYp6Xw+y9i+/0pe@7e1dc97a21a5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011031740.982735-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Subject: [RESEND PATCH v2] media: mtk-jpeg: Fix use after free bug due to uncanceled work
Link: https://lore.kernel.org/stable/20231011031740.982735-1-zyytlz.wz%40163.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



