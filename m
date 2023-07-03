Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0F07461B4
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 19:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjGCR7g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 13:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjGCR7f (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 13:59:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F7910C1
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 10:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688407166; x=1719943166;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=0KQh8hPclyt8Tpuaarfnp7DVoSBirK/DCKhrf3brP8s=;
  b=lvda7WiQRaFa/NvYk8uD4qOPbXpjwdATbWRJ0J4fpfzlg+V+7UV/uKdi
   lS2JNdqhO/+hHP1dHeASNaadz+EBe7blOr+UXt8uz3d7hRUrG+O30A5JT
   zJPZqYswDFXCcH/9dDEqXk2wLexqULocsayLJgknJdlf2G8xKRE0GrycE
   vcqWlTjtKkhUGIarD8/mAsEhN64oysqjnWR4Q610qWAE0VcmL+vb3ciBe
   I9JQGSFeDEF0HEU7T4PCtpXTJh52/eAA5ZLfwMfGZMkq0i96nfk2MWPUB
   uYBivPqUZ6ph19uQNqIlDawO0kl3/irmIyRxe8e6MizPur9sqdlgr6qPz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="343271023"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="343271023"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 10:59:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="695877320"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="695877320"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2023 10:59:19 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGNpW-000HYj-11;
        Mon, 03 Jul 2023 17:59:18 +0000
Date:   Tue, 4 Jul 2023 01:58:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V2] PCI: qcom: Use PARF_SLV_ADDR_SPACE_SIZE for ops_2_3_3
Message-ID: <ZKMMSz3zJvoSsLnp@65525e8f8615>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703175757.2425540-1-quic_srichara@quicinc.com>
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
Subject: [PATCH V2] PCI: qcom: Use PARF_SLV_ADDR_SPACE_SIZE for ops_2_3_3
Link: https://lore.kernel.org/stable/20230703175757.2425540-1-quic_srichara%40quicinc.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



