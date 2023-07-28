Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF6F766E94
	for <lists+stable@lfdr.de>; Fri, 28 Jul 2023 15:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbjG1NkQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Jul 2023 09:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbjG1NkP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Jul 2023 09:40:15 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC6EFC
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 06:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690551614; x=1722087614;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=3tjnsgmfUMH9FUviQhsXvpNDxJRRTmls36zy4yA0BaU=;
  b=YxqZYfuieEmWapFuZV5FLzi5m4vso9PszjuYUuADx7XjbchFfhR5GpPD
   R3yMkhbeXHvsf6DWdi1eqI7WedDQtFrDqYuLcmS/Tp3nyee8HqdXMAVs/
   5A30eUHZ11lQeGhhLQby3PlFdvdTWQpN+q1yJri4YoqPxyLWnB4t8kYnw
   R7o1R5girgecvSxdDNalPZ8aBPGdZA9Nzg2PW213F1amiMwZ+AVlDaOO9
   CY/pbg0PTeIwk80+j7uji+wA9Bf8RqRtdfXn3ZRAWKxgmi8NkOYYJmTV8
   dctqy3yfSCQQXrQhYkXnS0+3CK6QgR//gxZRKMO0YBZSxI+i3ALtX1eRe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="368607844"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="368607844"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 06:40:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="677542473"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="677542473"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2023 06:40:12 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPNhB-0003Fn-2u;
        Fri, 28 Jul 2023 13:39:59 +0000
Date:   Fri, 28 Jul 2023 21:39:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net] batman-adv: Do not get eth header before
 batadv_check_management_packet
Message-ID: <ZMPFKLFOqbnJOdDW@c507f7d2ae6a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728133850.5974-1-repk@triplefau.lt>
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
Subject: [PATCH net] batman-adv: Do not get eth header before batadv_check_management_packet
Link: https://lore.kernel.org/stable/20230728133850.5974-1-repk%40triplefau.lt

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



