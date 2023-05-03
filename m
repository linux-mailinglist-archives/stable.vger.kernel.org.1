Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831FB6F56ED
	for <lists+stable@lfdr.de>; Wed,  3 May 2023 13:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjECLHK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 3 May 2023 07:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjECLHJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 3 May 2023 07:07:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2153349CC
        for <stable@vger.kernel.org>; Wed,  3 May 2023 04:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683112028; x=1714648028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=isSEaTcczQehorA2XyFTb7Qg8MalrslW5ar7lNBTlZw=;
  b=ktNfqAdZnZHrYLTAtxO1sP7jPLrk63jW8C8+lBOKHisXXVZ1K3ruyZWt
   +juNiY5GMKeWA9Wh5Bsv9ysSpi2u4MjKvkenWdURC0+7SdSRevKmm9/NI
   yTNtFqLystIHxGIViqzZvMB97VUh40otN83h/qQLU+rPCF/7KTMsAkOWg
   6ZL7Tr7K5RlqLgqreFEV6z09V8v0Eo35Y4PfDLnoQDWxaHKpAQDzF4SJw
   B2YOHghTcHHb7QP3rXrMj/A6f7x2lOUV37TW2AYcx+wlIoHVJORHt2lqq
   wEf1cCBFMoAD/rpIvqJZ5WKW+On8CjJjzi+1lk/UB07vnx0G35LJ4faKC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="411780904"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="411780904"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 04:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="699326439"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="699326439"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
  by fmsmga007.fm.intel.com with SMTP; 03 May 2023 04:07:04 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 03 May 2023 14:07:04 +0300
Date:   Wed, 3 May 2023 14:07:04 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     "Lisovskiy, Stanislav" <stanislav.lisovskiy@intel.com>
Cc:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        stable@vger.kernel.org,
        Vinod Govindapillai <vinod.govindapillai@intel.com>
Subject: Re: [PATCH 02/11] drm/i915/mst: Remove broken MST DSC support
Message-ID: <ZFJAWCGuWcLDQOfS@intel.com>
References: <20230502143906.2401-1-ville.syrjala@linux.intel.com>
 <20230502143906.2401-3-ville.syrjala@linux.intel.com>
 <ZFIPCm+k9TCyfMfS@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFIPCm+k9TCyfMfS@intel.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 03, 2023 at 10:36:42AM +0300, Lisovskiy, Stanislav wrote:
> On Tue, May 02, 2023 at 05:38:57PM +0300, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > The MST DSC code has a myriad of issues:
> > - Platform checks are wrong (MST+DSC is TGL+ only IIRC)
> > - Return values of .mode_valid_ctx() are wrong
> > - .mode_valid_ctx() assumes bigjoiner might be used, but ther rest
> >   of the code doesn't agree
> > - compressed bpp calculations don't make sense
> > - FEC handling needs to consider the entire link as opposed to just
> >   the single stream. Currently FEC would only get enabled if the
> >   first enabled stream is compressed. Also I'm not seeing anything
> >   that would account for the FEC overhead in any bandwidth calculations
> > - PPS SDP is only handled for the first stream via the dig_port
> >   hooks, other streams will not be transmittitng any PPS SDPs
> > - PPS SDP readout is missing (also missing for SST!)
> > - VDSC readout is missing (also missing for SST!)
> > 
> > The FEC issues is really the big one since we have no way currently
> > to apply such link wide configuration constraints. Changing that is
> > going to require a much bigger rework of the higher level modeset
> > .compute_config() logic. We will also need such a rework to properly
> > distribute the available bandwidth across all the streams on the
> > same link (which is a must to eg. enable deep color).
> 
> Also all the things you mentioned are subject for discussion, for example
> I see that FEC overhead is actually accounted for bpp calculation for instance.

AFAICS FEC is only accounted for in the data M/N calculations,
assuming that particular stream happened to be compressed. I'm
not sure if that actually matters since at least the link M/N
are not even used by the MST sink. I suppose the data M/N might
still be used for something though. For any uncompressed stream
on the same link the data M/N values will be calculated
incorrectly without FEC.

And as mentioned, the FEC bandwidth overhead doesn't seem to
be accounted anywhere so no guarantee that we won't try to
oversubcribe the link.

And FEC will only be enabled if the first stream to be enabled
is compressed, otherwise we will enable the link without FEC
and still try to cram other compressed streams through it
(albeit without the PPS SDP so who knows what will happen)
and that is illegal.

> We usually improve things by gradually fixing, because if we act same way towards
> all wrong code in the driver, we could end up removing the whole i915.

We ususally don't merge code that has this many obvious and/or
fundemental issues.

Now, most of the issues I listed above are probably fixable
in a way that could be backported to stable kernels, but
unfortunately the FEC issue is not one of those. That one
will likely need massive amounts of work all over the driver
modeset code, making a backport impossible.

> So from my side I would nack it, at least until you have a code which handles
> all of this better - I have no doubt you probably have some ideas in your mind, so lets be constructive at least and propose something better first.
> This code doesn't cause any regressions, but still provides "some" support to DP MST DSC to say the least and even if that would be removed, if some of those users 
> refer to me, I would probably then just point to this mail discussion everytime.

It seems very likely that it will cause regressions at some point,
it just needs a specific multi-display MST setup. The resulting
problems will be very confusing to debug since the order in which
you enable/disable the outputs will have an impact on what actually
goes wrong on account of the FEC and PPS SDP issues. The longer
we wait disabling this the harder it will be to deal with those
regressions since we the probably can't revert anymore (a straight
revert was already not possible) but also can't fix it in a way
that can be backported (due to the FEC issues in particular).

-- 
Ville Syrjälä
Intel
