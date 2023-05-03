Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DC76F57D5
	for <lists+stable@lfdr.de>; Wed,  3 May 2023 14:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjECMXW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 3 May 2023 08:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjECMXV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 3 May 2023 08:23:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D765587
        for <stable@vger.kernel.org>; Wed,  3 May 2023 05:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683116599; x=1714652599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lJyTyRILL9WaVNaArAUPZeJSllBlPMxu0RNkKC4JW4U=;
  b=TJE8tKfQqyYXLcIIMM3OCEOGrIusQP3JuRqlIqBguPpTs/SmDGJQnGiV
   kq0A8op0sXpzAKOMDJjk1komFTFG9NpoUEeV9+4eDLAkvRoV5jaVptgRd
   C6LDZuTpIuWoPjD+xKpDrbwFc0Z/W9uFeqWDJ7rq0+iYamLan3gV4Aa7j
   yK3J8PB9Zwp0oWHXvMRUnO0KS4ebJ+6SqdxDuhAMQcA6PFl1y5SHQcNcI
   PbawJqoytEEoCeJ4R03MjFw7LKgEnCseuuRJpwPwgyLj4sk1zvNltjvbv
   u8Jsi7il1YbIQ4z6qIXljOcCzPE2UtDSdQWxWUmS5/hRxjllRWeTkulWt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="333002976"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="333002976"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 05:23:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="727121504"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="727121504"
Received: from unknown (HELO intel.com) ([10.237.72.65])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 05:23:17 -0700
Date:   Wed, 3 May 2023 15:23:11 +0300
From:   "Lisovskiy, Stanislav" <stanislav.lisovskiy@intel.com>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        stable@vger.kernel.org,
        Vinod Govindapillai <vinod.govindapillai@intel.com>
Subject: Re: [PATCH 02/11] drm/i915/mst: Remove broken MST DSC support
Message-ID: <ZFJSLwVrlE8ABtei@intel.com>
References: <20230502143906.2401-1-ville.syrjala@linux.intel.com>
 <20230502143906.2401-3-ville.syrjala@linux.intel.com>
 <ZFIPCm+k9TCyfMfS@intel.com>
 <ZFJAWCGuWcLDQOfS@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFJAWCGuWcLDQOfS@intel.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 03, 2023 at 02:07:04PM +0300, Ville Syrjälä wrote:
> On Wed, May 03, 2023 at 10:36:42AM +0300, Lisovskiy, Stanislav wrote:
> > On Tue, May 02, 2023 at 05:38:57PM +0300, Ville Syrjala wrote:
> > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > 
> > > The MST DSC code has a myriad of issues:
> > > - Platform checks are wrong (MST+DSC is TGL+ only IIRC)
> > > - Return values of .mode_valid_ctx() are wrong
> > > - .mode_valid_ctx() assumes bigjoiner might be used, but ther rest
> > >   of the code doesn't agree
> > > - compressed bpp calculations don't make sense
> > > - FEC handling needs to consider the entire link as opposed to just
> > >   the single stream. Currently FEC would only get enabled if the
> > >   first enabled stream is compressed. Also I'm not seeing anything
> > >   that would account for the FEC overhead in any bandwidth calculations
> > > - PPS SDP is only handled for the first stream via the dig_port
> > >   hooks, other streams will not be transmittitng any PPS SDPs
> > > - PPS SDP readout is missing (also missing for SST!)
> > > - VDSC readout is missing (also missing for SST!)
> > > 
> > > The FEC issues is really the big one since we have no way currently
> > > to apply such link wide configuration constraints. Changing that is
> > > going to require a much bigger rework of the higher level modeset
> > > .compute_config() logic. We will also need such a rework to properly
> > > distribute the available bandwidth across all the streams on the
> > > same link (which is a must to eg. enable deep color).
> > 
> > Also all the things you mentioned are subject for discussion, for example
> > I see that FEC overhead is actually accounted for bpp calculation for instance.
> 
> AFAICS FEC is only accounted for in the data M/N calculations,
> assuming that particular stream happened to be compressed. I'm
> not sure if that actually matters since at least the link M/N
> are not even used by the MST sink. I suppose the data M/N might
> still be used for something though. For any uncompressed stream
> on the same link the data M/N values will be calculated
> incorrectly without FEC.
> 
> And as mentioned, the FEC bandwidth overhead doesn't seem to
> be accounted anywhere so no guarantee that we won't try to
> oversubcribe the link.
> 
> And FEC will only be enabled if the first stream to be enabled
> is compressed, otherwise we will enable the link without FEC
> and still try to cram other compressed streams through it
> (albeit without the PPS SDP so who knows what will happen)
> and that is illegal.
> 
> > We usually improve things by gradually fixing, because if we act same way towards
> > all wrong code in the driver, we could end up removing the whole i915.
> 
> We ususally don't merge code that has this many obvious and/or
> fundemental issues.

Well, this is arguable and subjective judgement. Fact is that, so far we had more MST hubs
working with that code than without. Also no regressions or anything like that.
Moreover we usually merge code after code review, in particular those patches
did spend lots of time in review, where you could comment also.

Regarding merging code with fundamental issues, just recently you had admitted yourself
that bigjoiner issue for instance, we had recently, was partly caused by your code, because
we don't anymore copy the pll state to slave crtc. 
I would say that words like "obvious" and "fundamental"
issues can be applied to many things, however I thought that we always fix things in constructive,
but not destructive/negative way. 
Should I call also all code completely broken and remove it, once we discover some flaws 
there? Oh, we had many regressions, where I could say the same.

And once again I'm completely okay, if you did introduce better functionality instead
AND I know you have some valid points there, but now we are just removing everything completely,
without providing anything better.

But okay, I've mentioned what I think about this and from side this is nak. 
And once the guys to whom those patches helped will pop up from gitlab,
asking why their MST hubs stopped working - I will just refer them here.

> 
> Now, most of the issues I listed above are probably fixable
> in a way that could be backported to stable kernels, but
> unfortunately the FEC issue is not one of those. That one
> will likely need massive amounts of work all over the driver
> modeset code, making a backport impossible.
> 
> > So from my side I would nack it, at least until you have a code which handles
> > all of this better - I have no doubt you probably have some ideas in your mind, so lets be constructive at least and propose something better first.
> > This code doesn't cause any regressions, but still provides "some" support to DP MST DSC to say the least and even if that would be removed, if some of those users 
> > refer to me, I would probably then just point to this mail discussion everytime.
> 
> It seems very likely that it will cause regressions at some point,
> it just needs a specific multi-display MST setup. The resulting
> problems will be very confusing to debug since the order in which
> you enable/disable the outputs will have an impact on what actually
> goes wrong on account of the FEC and PPS SDP issues. The longer
> we wait disabling this the harder it will be to deal with those
> regressions since we the probably can't revert anymore (a straight
> revert was already not possible) but also can't fix it in a way
> that can be backported (due to the FEC issues in particular).
> 
> -- 
> Ville Syrjälä
> Intel
