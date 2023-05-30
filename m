Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3877157DF
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 10:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjE3ID4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 04:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjE3IDy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 04:03:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41305F0;
        Tue, 30 May 2023 01:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685433830; x=1716969830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nT129KDi/UaqAt1IK05PNRCRhF4o7QGNyAqjx0oBA74=;
  b=QuZSX8Pu3J4hctgDJwnASUSO+56di4Ze0S5nUomZp5eTZ3VoJrAds+xQ
   5lgdJJ4C58k09smAc+tXarmG13t938Kzx/C91f+AvYuDcMQc8kGBSAlTG
   97obsKOdJ8FeYlasKafw/C1ZAJotSyHc7VRLVon8/klIsrgkStJrEMX1d
   rira/gBWdjuSuNNsw9gWJR+JkrUCWXOSLZ8MoquqiM31dRwydSA0qRBgr
   b16hSqbwGI59cgEA377oHCouSkWw7r5XMmhuNmAaR7yjpEga9L3p5fRRm
   p6X4Rg8OTxFFidkbv4esju+tE7mMTbi1miAIsuQT1YtspiiGbKfO7GhJA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="335196221"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="335196221"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 01:03:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="706326247"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="706326247"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2023 01:03:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 748CD53A; Tue, 30 May 2023 11:03:28 +0300 (EEST)
Date:   Tue, 30 May 2023 11:03:28 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        beld zhang <beldzhang@gmail.com>, stable@vger.kernel.org,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: 6.1.30: thunderbolt: Clear registers properly when auto clear
 isn't in use cause call trace after resume
Message-ID: <20230530080328.GD45886@black.fi.intel.com>
References: <CAG7aomXv2KV9es2RiGwguesRnUTda-XzmeE42m0=GdpJ2qMOcg@mail.gmail.com>
 <ZHKW5NeabmfhgLbY@debian.me>
 <261a70b7-a425-faed-8cd5-7fbf807bdef7@amd.com>
 <20230529113813.GZ45886@black.fi.intel.com>
 <e37b2f7f-d204-4204-ce72-e108975c2fe0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e37b2f7f-d204-4204-ce72-e108975c2fe0@amd.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 29, 2023 at 11:12:45PM -0500, Mario Limonciello wrote:
> On 5/29/23 06:38, Mika Westerberg wrote:
> > On Sun, May 28, 2023 at 07:55:39AM -0500, Mario Limonciello wrote:
> > > On 5/27/23 18:48, Bagas Sanjaya wrote:
> > > > On Sat, May 27, 2023 at 04:15:51PM -0400, beld zhang wrote:
> > > > > Upgrade to 6.1.30, got crash message after resume, but looks still
> > > > > running normally
> > > 
> > > This is specific resuming from s2idle, doesn't happen at boot?
> > > 
> > > Does it happen with hot-plugging or hot-unplugging a TBT3 or USB4 dock too?
> > 
> > Happens also when device is connected and do
> > 
> >    # rmmod thunderbolt
> >    # modprobe thunderbolt
> > 
> > I think it is because nhi_mask_interrupt() does not mask interrupt on
> > Intel now.
> > 
> > Can you try the patch below? I'm unable to try myself because my test
> > system has some booting issues at the moment.
> > 
> > diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> > index 4c9f2811d20d..a11650da40f9 100644
> > --- a/drivers/thunderbolt/nhi.c
> > +++ b/drivers/thunderbolt/nhi.c
> > @@ -60,9 +60,12 @@ static int ring_interrupt_index(const struct tb_ring *ring)
> >   static void nhi_mask_interrupt(struct tb_nhi *nhi, int mask, int ring)
> >   {
> > -	if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
> > -		return;
> > -	iowrite32(mask, nhi->iobase + REG_RING_INTERRUPT_MASK_CLEAR_BASE + ring);
> > +	if (nhi->quirks & QUIRK_AUTO_CLEAR_INT) {
> > +		u32 val = ioread32(nhi->iobase + REG_RING_INTERRUPT_BASE + ring);
> > +		iowrite32(val & ~mask, nhi->iobase + REG_RING_INTERRUPT_BASE + ring);
> > +	} else {
> > +		iowrite32(mask, nhi->iobase + REG_RING_INTERRUPT_MASK_CLEAR_BASE + ring);
> > +	}
> >   }
> >   static void nhi_clear_interrupt(struct tb_nhi *nhi, int ring)
> 
> Mika, that looks good for the issue, thanks!
> 
> You can add:
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> When you submit it.

Thanks, submitted formal patch now here:

https://lore.kernel.org/linux-usb/20230530075555.35239-1-mika.westerberg@linux.intel.com/

beld zhang, can you try it and see if it works on your system? It should
apply on top of thunderbolt.git/fixes [1]. Thanks!

[1] git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git
