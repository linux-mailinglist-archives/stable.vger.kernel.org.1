Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926C97ABED6
	for <lists+stable@lfdr.de>; Sat, 23 Sep 2023 10:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjIWIYB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 23 Sep 2023 04:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjIWIYB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 23 Sep 2023 04:24:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B1C199
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 01:23:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E7CC433C7;
        Sat, 23 Sep 2023 08:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695457434;
        bh=tKf5MrZ+vs5fo77wMdIqWLSSEgSHaTrAwrohXJzWzww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bc1oR6NXmYpYltCOqIBaToy1DvSeAQfQtsfqTHR+Ug3jbAi5YL98G6zBH8vzantg2
         jVz70RmiNOjLl/LtXOxAqnJcM3AKAqmg1/jKXBhOLVa+T/4iTurw3f5B/8bNUqZrQK
         2Jbe2u6djGguSXBsgL6qWwyG4gqJC5NqAvrBU2Jc=
Date:   Sat, 23 Sep 2023 10:23:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Jairaj Arava <jairaj.arava@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 27/83] ASoC: Intel: sof_sdw: Update BT offload
 config for soundwire config
Message-ID: <2023092346-gutless-skillful-f830@gregkh>
References: <20230920112826.634178162@linuxfoundation.org>
 <20230920112827.751203739@linuxfoundation.org>
 <ZQtSWm3ycmA1W7Ry@eldamar.lan>
 <ZQ0alCnaXpqWRuuQ@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQ0alCnaXpqWRuuQ@eldamar.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 22, 2023 at 06:39:48AM +0200, Salvatore Bonaccorso wrote:
> Hi Greg,
> 
> On Wed, Sep 20, 2023 at 10:13:14PM +0200, Salvatore Bonaccorso wrote:
> > Hi Greg,
> > 
> > On Wed, Sep 20, 2023 at 01:31:17PM +0200, Greg Kroah-Hartman wrote:
> > > 5.10-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Uday M Bhat <uday.m.bhat@intel.com>
> > > 
> > > [ Upstream commit a14aded9299187bb17ef90700eb2cf1120ef5885 ]
> > > 
> > > For soundwire config, SSP1 is used for BT offload. This is enabled
> > > in sof_sdw_quirk_table
> > > 
> > > Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> > > Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > > Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > Signed-off-by: Uday M Bhat <uday.m.bhat@intel.com>
> > > Signed-off-by: Jairaj Arava <jairaj.arava@intel.com>
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > Link: https://lore.kernel.org/r/20230731214257.444605-5-pierre-louis.bossart@linux.intel.com
> > > Signed-off-by: Mark Brown <broonie@kernel.org>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >  sound/soc/intel/boards/sof_sdw.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
> > > index f36a0fda1b6ae..1955d277fdf20 100644
> > > --- a/sound/soc/intel/boards/sof_sdw.c
> > > +++ b/sound/soc/intel/boards/sof_sdw.c
> > > @@ -214,7 +214,9 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
> > >  			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
> > >  			DMI_MATCH(DMI_PRODUCT_NAME, "Rex"),
> > >  		},
> > > -		.driver_data = (void *)(SOF_SDW_PCH_DMIC),
> > > +		.driver_data = (void *)(SOF_SDW_PCH_DMIC |
> > > +					SOF_BT_OFFLOAD_SSP(1) |
> > > +					SOF_SSP_BT_OFFLOAD_PRESENT),
> > >  	},
> > >  	/* LunarLake devices */
> > >  	{
> > > -- 
> > > 2.40.1
> > 
> > I see the following build issue while trying to check 5.10.196-rc1:
> > 
> > sound/soc/intel/boards/sof_sdw.c:218:6: error: implicit declaration of function ‘SOF_BT_OFFLOAD_SSP’ [-Werror=implicit-function-declaration]
> >   218 |      SOF_BT_OFFLOAD_SSP(1) |
> >       |      ^~~~~~~~~~~~~~~~~~
> > sound/soc/intel/boards/sof_sdw.c:219:6: error: ‘SOF_SSP_BT_OFFLOAD_PRESENT’ undeclared here (not in a function)
> >   219 |      SOF_SSP_BT_OFFLOAD_PRESENT),
> >       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: some warnings being treated as errors
> > make[7]: *** [scripts/Makefile.build:286: sound/soc/intel/boards/sof_sdw.o] Error 1
> 
> Would it be better to drop this patch for the 5.10.y series?
> 
> SOF_SSP_BT_OFFLOAD_PRESENT only got introduced in 19f1eace0441 ("ASoC:
> Intel: sof_sdw: add support for Bluetooth offload") in 5.14-rc1 and
> later the bit changed again in 368fa526e6e3 ("ASoC: Intel: sof_sdw:
> extends SOF_RT711_JDSRC to 4 bits") ?
> 
> Again, note I'm only the person seeing a build failure while testing
> the new RC version for 5.10.y.

Agreed, now dropped.

greg k-h
