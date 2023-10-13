Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8C7C83B0
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 12:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjJMKuT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 06:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjJMKuS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 06:50:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924FAC0
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 03:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697194216; x=1728730216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LRDq/tYbx0pKmQcqzPEGGQKnAXM5s8G9oE4j7Tq2bSs=;
  b=idpEM81z0o9N5I3gr7rTIeJpnMlnQSdszjoB4P1ZgR7NahGXxsFwBo+s
   H8mJgcqAIezjBFlVsxcGPReHa77DZdIoNji34+WiMNG1gFIEOpcdyKe1F
   g9x4eafapNx12mTgNpjrnnFFqZ3mNs9UJH/UqzjahJ63O6Bp9RQnAyYoS
   Foq5cDNe+P33l30vi3IfaDhNaIZPxbvsN76ejP8LO/HhOnIXmZgvWeOKH
   5c1r8lm+/7srVh9vNghn/jrRYrkJilCTetK3IvZktsvIOeLRVclA6MQIy
   SKg4yhH7OQ4jvmqS3AmDx8Sj/kiXxHf2jU4Jn7PERHdy4YsX4dbRdyJOn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="471388494"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="471388494"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 03:50:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="758456407"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="758456407"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmsmga007.fm.intel.com with SMTP; 13 Oct 2023 03:50:12 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 13 Oct 2023 13:50:11 +0300
Date:   Fri, 13 Oct 2023 13:50:11 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Nirmoy Das <nirmoy.das@intel.com>
Cc:     intel-gfx@lists.freedesktop.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        dri-devel@lists.freedesktop.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org,
        Matt Roper <matthew.d.roper@intel.com>,
        John Harrison <john.c.harrison@intel.com>
Subject: Re: [PATCH] drm/i915: Flush WC GGTT only on required platforms
Message-ID: <ZSkg47slZ25rSQK4@intel.com>
References: <20231013103140.12192-1-nirmoy.das@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231013103140.12192-1-nirmoy.das@intel.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 13, 2023 at 12:31:40PM +0200, Nirmoy Das wrote:
> gen8_ggtt_invalidate() is only needed for limitted set of platforms
> where GGTT is mapped as WC

I know there is supposed to be some kind hw snooping of the ggtt
pte writes to invalidate the tlb, but are we sure GFX_FLSH_CNTL
has no other side effects we depend on?

> otherwise this can cause unwanted
> side-effects on XE_HP platforms where GFX_FLSH_CNTL_GEN6 is not
> valid.
> 
> Fixes: d2eae8e98d59 ("drm/i915/dg2: Drop force_probe requirement")
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: John Harrison <john.c.harrison@intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.2+
> Suggested-by: Matt Roper <matthew.d.roper@intel.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
> ---
>  drivers/gpu/drm/i915/gt/intel_ggtt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
> index 4d7d88b92632..c2858d434bce 100644
> --- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
> +++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
> @@ -197,13 +197,17 @@ void gen6_ggtt_invalidate(struct i915_ggtt *ggtt)
>  
>  static void gen8_ggtt_invalidate(struct i915_ggtt *ggtt)
>  {
> +	struct drm_i915_private *i915 = ggtt->vm.i915;
>  	struct intel_uncore *uncore = ggtt->vm.gt->uncore;
>  
>  	/*
>  	 * Note that as an uncached mmio write, this will flush the
>  	 * WCB of the writes into the GGTT before it triggers the invalidate.
> +	 *
> +	 * Only perform this when GGTT is mapped as WC, see ggtt_probe_common().
>  	 */
> -	intel_uncore_write_fw(uncore, GFX_FLSH_CNTL_GEN6, GFX_FLSH_CNTL_EN);
> +	if (!IS_GEN9_LP(i915) && GRAPHICS_VER(i915) < 11)
> +		intel_uncore_write_fw(uncore, GFX_FLSH_CNTL_GEN6, GFX_FLSH_CNTL_EN);
>  }
>  
>  static void guc_ggtt_invalidate(struct i915_ggtt *ggtt)
> -- 
> 2.41.0

-- 
Ville Syrjälä
Intel
