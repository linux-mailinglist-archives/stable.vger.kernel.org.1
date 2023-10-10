Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33147BF660
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 10:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjJJIrj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 04:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjJJIri (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 04:47:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FC797
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 01:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696927656; x=1728463656;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=ymKPyXX+MMt0rsb9c5uaVXqZCv5g6sfDzydyxvk28dg=;
  b=Reh5TxoO2y/E2w/IRXldsGr0KSlCd5LWbJahlXMKbW77kTHOtwR9+F0L
   CDQOhLHGr4RBLwPwsBzak84jYLibINFgwVZ2+GsjqjUt0J8/MRs1l8wGy
   T20Mhjfi1k5PUDeOPzuAjWjqsCVRXZNwWbHP39Q9h3e2zZ0cMRqqw5vpt
   6NvF1xjM38Dz4gNOOrffzRMV8/txEuYdfNC6y+EPk8am17WLnZatQY3V9
   8KnuSzkifjNcZLgXFV1Y650BfbQ1tqmAbn+nUTgNsgEe2L/fHnaMyYpCl
   /cenX2xcpbLhgKbrlYzdNim7SWkUQcHmJPW2dmTK2eOTCUrYrrRd5vN6s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="387179403"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="387179403"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 01:47:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="788506097"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="788506097"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2023 01:47:35 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qq8Op-0000Cy-0s;
        Tue, 10 Oct 2023 08:47:31 +0000
Date:   Tue, 10 Oct 2023 16:47:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] i2c: stm32f7: Fix PEC handling in case of SMBUS
 transfers
Message-ID: <ZSUPmZI4T8E8a/JF@7e1dc97a21a5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010084455.1718830-1-alain.volmat@foss.st.com>
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

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] i2c: stm32f7: Fix PEC handling in case of SMBUS transfers
Link: https://lore.kernel.org/stable/20231010084455.1718830-1-alain.volmat%40foss.st.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



