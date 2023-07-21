Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D738C75C8E6
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjGUODP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjGUODG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:03:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB5A30CF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689948178; x=1721484178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ClOcl+VTB21mVAMFKz7g4AEK+zUooi66bWyE1gA6T24=;
  b=FGSHo6yYhtjBg9f1wV0l3rRE37c24hNYQIAmnhOlNBrVCMzTozytYqnX
   12vdGNs9bwxMERyx+blG7sQlXlwWwsRgfaJ94WYXbQw/qk11rfnJdBgif
   Sll9FSsMTfe4OgQKw5cjfeIpfediL3cBZWpjA6P8i68duY24J1w9cfryu
   c1DbbiUcsfFPXqLZ3lpMZytsTsOBDy9bHDP2meoyhpWPXBI01cm4GbedT
   55qAxOZqji2A9fjJjfs1NrEcXx55qiKPBkxQhE9H/PQw5W3yOpXz2psya
   XMSg/2EFbFNDmdJxsE+jUVPm5qttBriqumhx44/u4p7SNmrrqtmCOWZKp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="453404352"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="453404352"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 07:02:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="1055573907"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="1055573907"
Received: from hbockhor-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.54.104])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 07:02:52 -0700
Date:   Fri, 21 Jul 2023 16:02:50 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     "Krzysztofik, Janusz" <janusz.krzysztofik@intel.com>
Cc:     "Cavitt, Jonathan" <jonathan.cavitt@intel.com>,
        "Roper, Matthew D" <matthew.d.roper@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        "Das, Nirmoy" <nirmoy.das@intel.com>,
        "Hajda, Andrzej" <andrzej.hajda@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        linux-stable <stable@vger.kernel.org>,
        dri-evel <dri-devel@lists.freedesktop.org>
Subject: Re: [v7,9/9] drm/i915/gt: Support aux invalidation on all engines
Message-ID: <ZLqQCq5eDId4zRFa@ashyti-mobl2.lan>
References: <20230720210737.761400-10-andi.shyti@linux.intel.com>
 <3494477.V25eIC5XRa@jkrzyszt-mobl2.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3494477.V25eIC5XRa@jkrzyszt-mobl2.ger.corp.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Janusz,

> > diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> > index 3ded597f002a2..30fb4e0af6134 100644
> > --- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> > +++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> > @@ -165,9 +165,36 @@ static u32 preparser_disable(bool state)
> >  	return MI_ARB_CHECK | 1 << 8 | state;
> >  }
> >  
> > -u32 *gen12_emit_aux_table_inv(struct intel_gt *gt, u32 *cs, const i915_reg_t inv_reg)
> > +static i915_reg_t gen12_get_aux_inv_reg(struct intel_engine_cs *engine)
> >  {
> > -	u32 gsi_offset = gt->uncore->gsi_offset;
> > +	if (!HAS_AUX_CCS(engine->i915))
> > +		return INVALID_MMIO_REG;
> > +
> > +	switch (engine->id) {
> > +	case RCS0:
> > +		return GEN12_CCS_AUX_INV;
> > +	case BCS0:
> > +		return GEN12_BCS0_AUX_INV;
> > +	case VCS0:
> > +		return GEN12_VD0_AUX_INV;
> > +	case VCS2:
> > +		return GEN12_VD2_AUX_INV;
> > +	case VECS0:
> > +		return GEN12_VE0_AUX_INV;
> > +	case CCS0:
> > +		return GEN12_CCS0_AUX_INV;
> > +	default:
> > +		return INVALID_MMIO_REG;
> > +	}
> > +}
> > +
> > +u32 *gen12_emit_aux_table_inv(struct intel_engine_cs *engine, u32 *cs)
> > +{
> > +	i915_reg_t inv_reg = gen12_get_aux_inv_reg(engine);
> > +	u32 gsi_offset = engine->gt->uncore->gsi_offset;
> > +
> > +	if (i915_mmio_reg_valid(inv_reg))
> > +		return cs;
> 
> Is that correct?  Now the original body of gen12_emit_aux_table_inv() will be 
> executed only if either (!HAS_AUX_CCS(engine->i915) or the engine is not one 
> of (RCS0, BCS0, VCS0, VCS2 or CCS0), ...
> 
> >  
> >  	*cs++ = MI_LOAD_REGISTER_IMM(1) | MI_LRI_MMIO_REMAP_EN;
> >  	*cs++ = i915_mmio_reg_offset(inv_reg) + gsi_offset;
> > @@ -201,6 +228,11 @@ static u32 *intel_emit_pipe_control_cs(struct i915_request *rq, u32 bit_group_0,
> >  	return cs;
> >  }
> >  
> > +static bool gen12_engine_has_aux_inv(struct intel_engine_cs *engine)
> > +{
> > +	return i915_mmio_reg_valid(gen12_get_aux_inv_reg(engine));
> > +}
> > +
> >  static int mtl_dummy_pipe_control(struct i915_request *rq)
> >  {
> >  	/* Wa_14016712196 */
> > @@ -307,11 +339,7 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
> >  
> >  		cs = gen8_emit_pipe_control(cs, flags, LRC_PPHWSP_SCRATCH_ADDR);
> >  
> > -		if (!HAS_FLAT_CCS(rq->engine->i915)) {
> 
> ... while before it was executed only if (!HAS_FLAT_CCS(rq->engine->i915)), 
> which, according to commit description of PATCH 2/9, rather had the opposite 
> meaning.  Am I missing something?

flat_ccs and aux_ccs are not mutually exclusive, so far the can
both miss like in PVC. So that the !HAS_FLAT_CCS() is an
approximation and that's why we need a better evaluation.

Aux invalidation is needed only on platforms from TGL and beyond
excluding PVC. The above engines  are the only engines where AUX
invalidation happens, but there are no cases when we reach the
default condition, as the emit_flush_rcs is already called within
that set of engines. The default is there just for completeness.

Does this answer?

Thanks,
Andi
