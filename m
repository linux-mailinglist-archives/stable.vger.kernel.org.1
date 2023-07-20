Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1704575B4F6
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 18:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjGTQtL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 12:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjGTQtI (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 12:49:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58FE273D
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 09:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689871742; x=1721407742;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=7NX/AlPAGDSpnGK1rEuONyGAazZeaIxCWd5UEb1DPcg=;
  b=VT9TrzaCY8C4uEteqKNSp3jpIkUpoPpUOto5DdMI/FuqqmfpvixvlwRc
   W0fQJ7Wd4JyUjGvV3gx0pWI5v0JjRVSdugge7cvY3Gv6jpkp5GggW+xQ7
   o4VbgIaGuTzxvcVcdlOXV+ICPzOBskHy36WcOAr5nM17qmw0RXW3WNuq7
   MqKSkT5HCh4OnvOHOj6KBLt7O2REVwh+OZ9hjnEqJb3Txm/Z81rmDB5pg
   YtqlV0y/+ymfLRp9B7stVcD/YCD3sel0EzZDL2nHGgBzi08v+b+5KIezc
   qOGW6dIQkvgZnt94GZIgxTRaxQpuHTqNtlStaaITz5gv3y+qKF6OebDQ9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="430594195"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="430594195"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 09:49:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="759635124"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="759635124"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 20 Jul 2023 09:49:01 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMWpj-0006I1-0v;
        Thu, 20 Jul 2023 16:48:56 +0000
Date:   Fri, 21 Jul 2023 00:48:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6 5/9] drm/i915/gt: Refactor
 intel_emit_pipe_control_cs() in a single function
Message-ID: <ZLllTD9GhIDvh09O@c507f7d2ae6a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720164454.757075-6-andi.shyti@linux.intel.com>
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
Subject: [PATCH v6 5/9] drm/i915/gt: Refactor intel_emit_pipe_control_cs() in a single function
Link: https://lore.kernel.org/stable/20230720164454.757075-6-andi.shyti%40linux.intel.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



