Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B317A981D
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 19:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjIURb2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 13:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjIURbR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 13:31:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19665490F
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695316630; x=1726852630;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=VFRCODsJNfdcvJJhUcuwsfzTPniBXQCCWfGakGAFnuw=;
  b=O4mwKofJkCeAmLXjolkEal0vis/5Aj8cnf0JcgfhTVOqNT+lok+8GDPl
   Tbts2dOSyxOmdTOLE4S0hLNlSTq4r56MAip81S6yDfYj9bEMo5/LiD1bo
   67yBmjDBEJTVbALmxoFKQh6s1lD2Njb4ETYYN5i8AGgqge/VL2YckmIFT
   UbS3JVbWI/TffvGXRMMDjJIkPWADWbZhs0DwJ0GKRqucb2HccVhYmdCWi
   EgoZOR1x6jYFWHJP7CU3icHgpAmKZqXFFHd7AcanUP7UwCAf17KAWwOAR
   Dk1skN6jcOtTuzi0aJjx7aGaQVALT4nOtBCH/tVRk/315kcDxrbTB+mGs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="380476405"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="380476405"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 09:21:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="994141504"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="994141504"
Received: from lkp-server02.sh.intel.com (HELO b77866e22201) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 21 Sep 2023 09:21:08 -0700
Received: from kbuild by b77866e22201 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjMQM-00009V-1n;
        Thu, 21 Sep 2023 16:21:06 +0000
Date:   Fri, 22 Sep 2023 00:21:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 4/8] s390: hugetlb: Convert set_huge_pte_at() to take
 vma
Message-ID: <ZQxtcKDtX0sgBM1O@a36b5d0e9c41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921162007.1630149-5-ryan.roberts@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html/#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v1 4/8] s390: hugetlb: Convert set_huge_pte_at() to take vma
Link: https://lore.kernel.org/stable/20230921162007.1630149-5-ryan.roberts%40arm.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



