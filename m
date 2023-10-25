Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F0B7D6F64
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 16:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344543AbjJYOZN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 10:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344661AbjJYOZM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 10:25:12 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA3293
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 07:25:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qveol-0003GF-2H; Wed, 25 Oct 2023 16:25:07 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1qveok-004CMV-9x; Wed, 25 Oct 2023 16:25:06 +0200
Received: from mfe by dude02.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <mfe@pengutronix.de>)
        id 1qveok-00D6rw-0k;
        Wed, 25 Oct 2023 16:25:06 +0200
Date:   Wed, 25 Oct 2023 16:25:06 +0200
From:   Marco Felsch <mfe@pengutronix.de>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
        kernel@penugtronix.de
Subject: Re: [PATCH] drm: panel: simple: specify bpc for
 powertip_ph800480t013_idf02
Message-ID: <20231025142506.6osds6rjiohn2p4c@pengutronix.de>
References: <20230727172445.1548834-1-dmitry.baryshkov@linaro.org>
 <733a1f2e-708b-6119-6cf9-af18f185fc77@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <733a1f2e-708b-6119-6cf9-af18f185fc77@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

+Cc: stable <stable@kernel.org>

The commit misses the Fixes tag.

On Mon, Jul 31, 2023 at 02:47:47PM +0200, Neil Armstrong wrote:
> On 27/07/2023 19:24, Dmitry Baryshkov wrote:
> > Specify bpc value for the powertip_ph800480t013_idf02 panel to stop drm
> > code from complaining about unexpected bpc value (0).
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/panel/panel-simple.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index a247a0e7c799..4c4c24ab4d12 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -3207,6 +3207,7 @@ static const struct drm_display_mode powertip_ph800480t013_idf02_mode = {
> >   static const struct panel_desc powertip_ph800480t013_idf02  = {
> >   	.modes = &powertip_ph800480t013_idf02_mode,
> >   	.num_modes = 1,
> > +	.bpc = 8,
> >   	.size = {
> >   		.width = 152,
> >   		.height = 91,
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
