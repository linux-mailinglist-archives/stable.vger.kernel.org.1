Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D046F1477
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 11:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345580AbjD1Jqc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 05:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345456AbjD1Jqb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 05:46:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF2F4497
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 02:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682675191; x=1714211191;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=oHJdyOrCtT3mzRkEZpoGLM8Jwoj85B2bl5oHZ8Bc1vc=;
  b=lAqnzElsoS+auwvqtDKneFu8hAihHK61F5L/e3cL9jii+fun02wgUd1i
   vWT4RxpVnNSIzbiQXxY3rxMLRirOmWue3cwwsTBQzxURLs+lsOhgBdtJF
   lhhFJhrZhBV9CS1oLV+1rt8gYzMTrGjif+Fj6AuWGhIbtRNXqleqs/D+u
   wCNxo+IT7QDG5VM37jGJhj3SaSalcjx30Bs6/FwCf/FYhoLaVywkzqN8H
   qOl3SREu4Ss1W2pN7GijFEXrTH3ysn3M2fC7Yc/rbPvKyff/rru0HzbGq
   /X9HP6GbUhoNpaBPL6db+97EKV5kcravX3Le5AdYZEvh3wBy93f1qkqXx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="375695069"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="375695069"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 02:46:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="725294120"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="725294120"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 28 Apr 2023 02:46:29 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psKgO-0000L3-33;
        Fri, 28 Apr 2023 09:46:28 +0000
Date:   Fri, 28 Apr 2023 17:46:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.15] selftests: mptcp: join: fix "invalid address,
 ADD_ADDR timeout"
Message-ID: <ZEuV586CQyHtECVB@afc780e125e2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428-upstream-stable-20230428-mptcp-addaddrdropmib-v1-1-51bca8b26c22@tessares.net>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
Subject: [PATCH 5.15] selftests: mptcp: join: fix "invalid address, ADD_ADDR timeout"
Link: https://lore.kernel.org/stable/20230428-upstream-stable-20230428-mptcp-addaddrdropmib-v1-1-51bca8b26c22%40tessares.net

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



