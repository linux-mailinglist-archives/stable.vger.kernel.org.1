Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB807C8B0D
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 18:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjJMQUY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 12:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjJMQUJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 12:20:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EBC6180
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 09:15:55 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-406553f6976so6675125e9.1
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1697213753; x=1697818553; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rY/OAKvNly9Rc3a/BDlQPzJe+rG6fOysad2AjRxUknI=;
        b=Fpp6sJexnm/XOKZrCx68D8hxBbf17r+L02/7HmCAHVhKiPRZxZjUM9Z+9ab29CKAJq
         iJy//swa6/58IhNmHrmbPIb+1l0+83rrRRJ9j69WleDM8SBc8UZdlbpNK3HP2TyJH72F
         r8yrJXCyq4aDb1PzdDfFak+NU1zwfG7GDQFV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697213753; x=1697818553;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rY/OAKvNly9Rc3a/BDlQPzJe+rG6fOysad2AjRxUknI=;
        b=EOLeTiK9q0EI+92jHMD6m90iGQjF7soWiIMToydGtpIDch2TDsyKCc6HCeSrWHe1QX
         v6liaOekhzzl6sYyKo7uqrMZ6pH0QXHBn8Ug/ExZA6hq2Y4O3E2p2YPeM/CfuNmbCfJK
         FUyH0YExJKFmHP8l9tFBeoTgbKZpCdfJ7/HGqkNzLMLdhVmu58msMD5sd/lNUc3WLiF0
         K9DulWEx0P5FBt3Zzn2XWoC7wqawAuC2yAHPzBxdRyWVKXmiEBNKYHqetv81ngJcLlIX
         Xs7NMMdihGToh3wMaQZoL3vdk/Js4ceKFEFEGy5OhgL9WyjCqV5FvjFj5aUWJ89yEQk1
         xsQA==
X-Gm-Message-State: AOJu0YyOuPzDRWk5VvjlcgltyPS3FwhRr8/5c+85mAXj91+mhoYJH79m
        /xia65VKjCwpGZ1yOOH6dq/YMA==
X-Google-Smtp-Source: AGHT+IGz4C19ELIeF2uxBTPB3+HBMoQ09FU8pZtUTNt8/nauK8H/ephzp814j2ZmFxsUyVqavQuJWQ==
X-Received: by 2002:a05:600c:1d03:b0:404:7606:a871 with SMTP id l3-20020a05600c1d0300b004047606a871mr24038108wms.2.1697213752664;
        Fri, 13 Oct 2023 09:15:52 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c500c00b0040773c69fc0sm536868wmr.11.2023.10.13.09.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 09:15:51 -0700 (PDT)
Date:   Fri, 13 Oct 2023 18:15:49 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Nirmoy Das <nirmoy.das@intel.com>
Cc:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        John Harrison <john.c.harrison@intel.com>
Subject: Re: [PATCH] drm/i915: Flush WC GGTT only on required platforms
Message-ID: <ZSltNRk0vaPdSxI2@phenom.ffwll.local>
References: <20231013103140.12192-1-nirmoy.das@intel.com>
 <ZSkg47slZ25rSQK4@intel.com>
 <ae8d62c9-ddfb-8913-6b67-681d9cf70978@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae8d62c9-ddfb-8913-6b67-681d9cf70978@intel.com>
X-Operating-System: Linux phenom 6.5.0-1-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 13, 2023 at 02:28:21PM +0200, Nirmoy Das wrote:
> Hi Ville,
> 
> On 10/13/2023 12:50 PM, Ville Syrjälä wrote:
> > On Fri, Oct 13, 2023 at 12:31:40PM +0200, Nirmoy Das wrote:
> > > gen8_ggtt_invalidate() is only needed for limitted set of platforms
> > > where GGTT is mapped as WC
> > I know there is supposed to be some kind hw snooping of the ggtt
> > pte writes to invalidate the tlb, but are we sure GFX_FLSH_CNTL
> > has no other side effects we depend on?
> 
> I spent some time searching through the gfxspec. This GFX_FLSH_CNTL register
> only seems to be for
> 
> invalidating TLB for GUnit  and (from git log ) we started to do that to
> enable WC based GGTT updates.

Might be good to cite the relevant git commits in the commit message to
make this clear.
-Sima

> 
> 
> So if I am not missing anything obvious then this should be safe.
> 
> 
> Regards,
> 
> Nirmoy
> 
> > 
> > > otherwise this can cause unwanted
> > > side-effects on XE_HP platforms where GFX_FLSH_CNTL_GEN6 is not
> > > valid.
> > > 
> > > Fixes: d2eae8e98d59 ("drm/i915/dg2: Drop force_probe requirement")
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> > > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > > Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > > Cc: John Harrison <john.c.harrison@intel.com>
> > > Cc: Andi Shyti <andi.shyti@linux.intel.com>
> > > Cc: <stable@vger.kernel.org> # v6.2+
> > > Suggested-by: Matt Roper <matthew.d.roper@intel.com>
> > > Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
> > > ---
> > >   drivers/gpu/drm/i915/gt/intel_ggtt.c | 6 +++++-
> > >   1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
> > > index 4d7d88b92632..c2858d434bce 100644
> > > --- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
> > > +++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
> > > @@ -197,13 +197,17 @@ void gen6_ggtt_invalidate(struct i915_ggtt *ggtt)
> > >   static void gen8_ggtt_invalidate(struct i915_ggtt *ggtt)
> > >   {
> > > +	struct drm_i915_private *i915 = ggtt->vm.i915;
> > >   	struct intel_uncore *uncore = ggtt->vm.gt->uncore;
> > >   	/*
> > >   	 * Note that as an uncached mmio write, this will flush the
> > >   	 * WCB of the writes into the GGTT before it triggers the invalidate.
> > > +	 *
> > > +	 * Only perform this when GGTT is mapped as WC, see ggtt_probe_common().
> > >   	 */
> > > -	intel_uncore_write_fw(uncore, GFX_FLSH_CNTL_GEN6, GFX_FLSH_CNTL_EN);
> > > +	if (!IS_GEN9_LP(i915) && GRAPHICS_VER(i915) < 11)
> > > +		intel_uncore_write_fw(uncore, GFX_FLSH_CNTL_GEN6, GFX_FLSH_CNTL_EN);
> > >   }
> > >   static void guc_ggtt_invalidate(struct i915_ggtt *ggtt)
> > > -- 
> > > 2.41.0

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
