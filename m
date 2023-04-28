Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1EB6F1FFB
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 23:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjD1VJu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 17:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346048AbjD1VJs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 17:09:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8CA1719
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 14:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682716187; x=1714252187;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=jl1xKxx2Fy1RbyxMCQG4rcWYLUwluCMgm9E74hiSxPI=;
  b=QoiZKEIfMHzX5m8AAWcezhsFuqfcgtKSRM4cXy24ZbkTwnttZPyugtcy
   AR7yBJiojYPvLZuUc9RoLLeXt4uSvJ5l1cEgMtcywjt9lbs4d03XsSyYX
   EIvnymoc6yz89Dqie3pbRcEM7hfSv/SOWQDGLI01AmXbp7Y5m6F8hEeIE
   WomkcG979LD19blIbjjR/nSD4WcuA9QmuHR0QmfErCtYbcJBjrubaJdAu
   Mm0Q3jTs0g371sOxtczoUNTwtWM90ySy+bVDEtyvhDkAZe6L/OReGZBqD
   huSKDW5vD1kLRyd1G2sAR20CsEXxQM/6esTTMXu+OTth9mOuk+uha9ObI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="349890005"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="349890005"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 14:09:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="725471849"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="725471849"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 28 Apr 2023 14:09:44 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psVLc-0000gz-0A;
        Fri, 28 Apr 2023 21:09:44 +0000
Date:   Sat, 29 Apr 2023 05:08:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sagar Biradar <sagar.biradar@microchip.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] aacraid: reply queue mapping to CPUs based of IRQ
 affinity
Message-ID: <ZEw14CU6rNtHz7Em@afc780e125e2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428210751.29722-1-sagar.biradar@microchip.com>
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
Subject: [PATCH v2] aacraid: reply queue mapping to CPUs based of IRQ affinity
Link: https://lore.kernel.org/stable/20230428210751.29722-1-sagar.biradar%40microchip.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



