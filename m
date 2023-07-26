Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F9B763F0D
	for <lists+stable@lfdr.de>; Wed, 26 Jul 2023 20:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjGZSxy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Jul 2023 14:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjGZSxx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Jul 2023 14:53:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAD02685
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690397632; x=1721933632;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=DGBa6t1K1wDmdwzuiUT15889Hi1jI039tHulrHOWLgA=;
  b=ErnNTNY4aj+BLYSz6cAfnSS9JUy+++vihe2OnVmyUUIaKH+Z70YQOrpx
   PEll4ynwoW1o/r6CAPVocyYyJmyTdArcATyzc/eJj64yvXpMYVMORK+E+
   Cu+WbWYtRT+RByHGRZjzh+PP18Jt49b9XrhPeb89bmdVoixXsy0iG1RVc
   pnD9E3J0mSs8lLLZhBSRX2yEo+/h21qcdxfGUC5Y/0duX9wMcVhAmOzVf
   3B7opsqlvLgU7Sx+8oxZ63+DLWkVYPtMQ9tPQk+R7emTo35Wn22MeklTb
   0SAbYgKPVvBW8+XqbuoTYf3Vj+yzrx09OA6mShFm/yMMaMXeTwEBHKhhj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="347714652"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="347714652"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 11:53:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="676815470"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="676815470"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 26 Jul 2023 11:53:50 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOjdU-0001Ch-0f;
        Wed, 26 Jul 2023 18:53:29 +0000
Date:   Thu, 27 Jul 2023 02:53:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/2] vdpa: Complement vdpa_nl_policy for nlattr length
 check
Message-ID: <ZMFrlMTppVA/8ws9@c507f7d2ae6a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726185104.12479-2-dtatulea@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
Subject: [PATCH 1/2] vdpa: Complement vdpa_nl_policy for nlattr length check
Link: https://lore.kernel.org/stable/20230726185104.12479-2-dtatulea%40nvidia.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



