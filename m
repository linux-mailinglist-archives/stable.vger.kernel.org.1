Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650FE75F9F9
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 16:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjGXOfq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 10:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjGXOfp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 10:35:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19808E
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 07:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690209344; x=1721745344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZkxaMWwZVIw+LW0WgBwy1SdhMTK4GEQ3AEQu3X0icZY=;
  b=RuGxJ/R9gpEwgK+Y8Gy/Uw5bBWzIkBUIZaVhsq4QSzzWY2mX950WIR+z
   ktHtG51BfYSIiEDk0DdXRR83Damp+lHjdCplS8++D3lbH/3pj7OD+IlE3
   iDWFVPaTAsW4AwXcipRuAitI/3M3MDBg/C/kM+PqbPVf45kWv7m6HP8ur
   dzyNDuZz4hmwfx/oj9QVyRGVByQWo2LD6G9kTwAZu2PGtUfw+5f1bxAD3
   7a37BQAyTPj7NeXSKecpoz8LYOwN3wavbcnnXxY6635tSH/KsBkaJp4nf
   kI32v0nm/1Okov/TIacpx/y5gAYUNRp33BnLNGWzpiIZaNS4QXcT9La7a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="347060114"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347060114"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 07:35:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="702913913"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="702913913"
Received: from avmoskal-mobl1.ger.corp.intel.com (HELO intel.com) ([10.252.57.166])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 07:35:14 -0700
Date:   Mon, 24 Jul 2023 16:35:11 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        linux-stable <stable@vger.kernel.org>,
        dri-evel <dri-devel@lists.freedesktop.org>
Subject: Re: [Intel-gfx] [PATCH v8 9/9] drm/i915/gt: Support aux invalidation
 on all engines
Message-ID: <ZL6MH3Hi8+Ore+w0@ashyti-mobl2.lan>
References: <20230721161514.818895-1-andi.shyti@linux.intel.com>
 <20230721161514.818895-10-andi.shyti@linux.intel.com>
 <5f846260-8416-fb19-bd46-ced39153a92a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f846260-8416-fb19-bd46-ced39153a92a@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Andrzej,

On Mon, Jul 24, 2023 at 11:42:16AM +0200, Andrzej Hajda wrote:
> On 21.07.2023 18:15, Andi Shyti wrote:
> > Perform some refactoring with the purpose of keeping in one
> > single place all the operations around the aux table
> > invalidation.
> > 
> > With this refactoring add more engines where the invalidation
> > should be performed.
> > 
> > Fixes: 972282c4cf24 ("drm/i915/gen12: Add aux table invalidate for all engines")
> > Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> > Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > Cc: Matt Roper <matthew.d.roper@intel.com>
> > Cc: <stable@vger.kernel.org> # v5.8+
> > ---
> >   drivers/gpu/drm/i915/gt/gen8_engine_cs.c | 53 ++++++++++++++----------
> >   drivers/gpu/drm/i915/gt/gen8_engine_cs.h |  3 +-
> >   drivers/gpu/drm/i915/gt/intel_lrc.c      | 17 +-------
> >   3 files changed, 36 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> > index 6daf7d99700e0..d33462387d1c6 100644
> > --- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> > +++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> > @@ -178,9 +178,36 @@ static bool gen12_needs_ccs_aux_inv(struct intel_engine_cs *engine)
> >   	return !HAS_FLAT_CCS(engine->i915);
> >   }
> > -u32 *gen12_emit_aux_table_inv(struct intel_gt *gt, u32 *cs, const i915_reg_t inv_reg)
> > +static i915_reg_t gen12_get_aux_inv_reg(struct intel_engine_cs *engine)
> > +{
> > +	if (!gen12_needs_ccs_aux_inv(engine))
> > +		return INVALID_MMIO_REG;
> > +
> > +	switch (engine->id) {
> > +	case RCS0:
> > +		return GEN12_CCS_AUX_INV;
> > +	case BCS0:
> > +		return GEN12_BCS0_AUX_INV;
> 
> Shouldn't be MTL only?
> With that explained/fixed:

this is actually difficult to be called by the wrong engine, so
that the MTL check is a bit pedantic... I can still add it
though.

> Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Thanks,
Andi
