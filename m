Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90277CDAF9
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 13:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjJRLul (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 07:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjJRLuk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 07:50:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DADB113
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697629839; x=1729165839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c0T0784LHoIAqHXgdsl2Rw+iriwcWCmFOJzkyPyWkAM=;
  b=G7LQnFepRYws1lon8CfpVLiYseS8c9yWF00XfZOS3H9msv8XO4/+nxSr
   4u8vaqXd/oRSDdrDL//XYGKWXxjckR8yvOwY/jd/eElT3EgQwybcD8fMK
   3qVDCcee3jQfcu9NnnEshaHEEHS4L0BmnCLQq9AEpN62cekPwOifuPBV6
   squ5AozDGOk0Xsy1K/mEvz7bRaY/Ka1OISz2qFwctf6pJE9XzgnDfFrbP
   O2quG+1NDYux2ZwvwTQ3YiEwsZSyled6WCzF//sibDvZWv4bhzlYo2AK3
   WjJXAbqveyXkO8yHHtx+eyFADba5+jUe3fpBkaUkew8EbZcSZPZvoujVb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="417111310"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="417111310"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:50:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="756566650"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="756566650"
Received: from nurfahan-mobl3.gar.corp.intel.com (HELO intel.com) ([10.213.159.217])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:50:08 -0700
Date:   Wed, 18 Oct 2023 13:49:59 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Nirmoy Das <nirmoy.das@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        John Harrison <john.c.harrison@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Ville =?iso-8859-15?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        stable@vger.kernel.org, Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [PATCH v3] drm/i915: Flush WC GGTT only on required platforms
Message-ID: <ZS/GZ0U7rOuuD0Kw@ashyti-mobl2.lan>
References: <20231018093815.1349-1-nirmoy.das@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018093815.1349-1-nirmoy.das@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Nirmoy,

On Wed, Oct 18, 2023 at 11:38:15AM +0200, Nirmoy Das wrote:
> gen8_ggtt_invalidate() is only needed for limited set of platforms
> where GGTT is mapped as WC. This was added as way to fix WC based GGTT in
> commit 0f9b91c754b7 ("drm/i915: flush system agent TLBs on SNB") and
> there are no reference in HW docs that forces us to use this on non-WC
> backed GGTT.
> 
> This can also cause unwanted side-effects on XE_HP platforms where
> GFX_FLSH_CNTL_GEN6 is not valid anymore.
> 
> v2: Add a func to detect wc ggtt detection (Ville)
> v3: Improve commit log and add reference commit (Daniel)
> 
> Fixes: d2eae8e98d59 ("drm/i915/dg2: Drop force_probe requirement")

I'm wondering if this is the right Fixes, though. Should this
rather be:

Fixes: 6266992cf105 ("drm/i915/gt: remove GRAPHICS_VER == 10")

?

Andi
