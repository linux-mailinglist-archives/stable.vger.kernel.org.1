Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0207478E7
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 22:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjGDUJK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 4 Jul 2023 16:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGDUJJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 4 Jul 2023 16:09:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD0B18B
        for <stable@vger.kernel.org>; Tue,  4 Jul 2023 13:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688501348; x=1720037348;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=NNmJNtnF9pCiStFXF9MVPbEuQxx66cX165aM1uTNkV4=;
  b=CrpCnYLoZ9+4NJgckmyUvIbGEoMwebkrogO1dqYa77JrcA0sAnGU9BJW
   eSHS63LX9K3qoovJxXXCs4stsI+i63sIwktW2RQ+qjpDv8FAb+XiuL0LK
   IRhMOuyy8eT1WWj7702eSKbIi8LmsFp7/m2kQhkRQBhONHMNAy+3j+cqS
   bmwflEkFbHKf7szXHTBnqmJAO2akweq6X19v4y3nB5p+kJzZfdIP3oHHI
   UmH6LX9CbgfNct6PAhDa2aEKg0KFbhRgx/6H+sXDHIsRGcaC4TJCt63xv
   CPl3kDG5aMDTK0jU2QA31ALNEN3Jscw75NYW2PvljADmqVgdcFiaIOWh7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="360664137"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="360664137"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 13:09:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="1049480631"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="1049480631"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jul 2023 13:09:07 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGmKg-000IWB-1U;
        Tue, 04 Jul 2023 20:09:06 +0000
Date:   Wed, 5 Jul 2023 04:08:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/1] fork: lock VMAs of the parent process when forking
Message-ID: <ZKR8PtubX/atawm0@65525e8f8615>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704200656.2526715-1-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Subject: [PATCH 1/1] fork: lock VMAs of the parent process when forking
Link: https://lore.kernel.org/stable/20230704200656.2526715-1-surenb%40google.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



