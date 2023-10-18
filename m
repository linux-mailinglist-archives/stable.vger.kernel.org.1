Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C067CDC83
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 15:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjJRNAm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 09:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjJRNAl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 09:00:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628C6A3
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697634040; x=1729170040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lPc2zuJMiNVfsti6czd8IBCBiARsc41XEWOSVk+Sau0=;
  b=krd8Q//6M6Jh23eNTK/qc/89jyBuTaz3TBMFOu1BlMHP0lRFHk8nf0vF
   KrrYOWcR5zB5R006Ai8p0m8WFV8VO85DOPMGXbsuXc6eKoQ2boSDqpffj
   YlKI5PuITZc6F0QE6ftvrnTdukLWjSsy8zct9TFmrwKlnDoyIbTn0rnxw
   ymv5fwnjC9JUsEi7srqtuEgCUNF+3D0tD33cWHUmViMNqjoEAri80VJnr
   Zk+8VrnmYziiKnZbbDya1sgnJMqpw7Odpd8wBouHMbJrFUE2o/6IHLaph
   x+xqt99BbK9UvYeFoUwBOazJxI5F0AGe1NSxfp3z8fdcNNKoN0tt72zev
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="472232541"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="472232541"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 06:00:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="4369992"
Received: from nurfahan-mobl3.gar.corp.intel.com (HELO intel.com) ([10.213.159.217])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 05:59:26 -0700
Date:   Wed, 18 Oct 2023 15:00:26 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Nirmoy Das <nirmoy.das@linux.intel.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org,
        Matt Roper <matthew.d.roper@intel.com>,
        John Harrison <john.c.harrison@intel.com>
Subject: Re: [PATCH v3] drm/i915: Flush WC GGTT only on required platforms
Message-ID: <ZS/W6obrW/g8WuS4@ashyti-mobl2.lan>
References: <20231018093815.1349-1-nirmoy.das@intel.com>
 <ZS/GZ0U7rOuuD0Kw@ashyti-mobl2.lan>
 <36c0e644-4013-f2f8-a0a7-9b9c3d8423c9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36c0e644-4013-f2f8-a0a7-9b9c3d8423c9@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Nirmoy,

> > > gen8_ggtt_invalidate() is only needed for limited set of platforms
> > > where GGTT is mapped as WC. This was added as way to fix WC based GGTT in
> > > commit 0f9b91c754b7 ("drm/i915: flush system agent TLBs on SNB") and
> > > there are no reference in HW docs that forces us to use this on non-WC
> > > backed GGTT.
> > > 
> > > This can also cause unwanted side-effects on XE_HP platforms where
> > > GFX_FLSH_CNTL_GEN6 is not valid anymore.
> > > 
> > > v2: Add a func to detect wc ggtt detection (Ville)
> > > v3: Improve commit log and add reference commit (Daniel)
> > > 
> > > Fixes: d2eae8e98d59 ("drm/i915/dg2: Drop force_probe requirement")
> > I'm wondering if this is the right Fixes, though. Should this
> > rather be:
> > 
> > Fixes: 6266992cf105 ("drm/i915/gt: remove GRAPHICS_VER == 10")
> 
> Hard to find a real Fixes for this. I just want to backport this to dg2
> where we can have unwanted side-effects.

yes, this piece of code has moved around enough so to make it
diffuclt to track its origin.

I think the one I found should be the correct one, but the dg2
force probe removeal can also become a placeholder for DG2 fixes.

I won't complain.

Andi
