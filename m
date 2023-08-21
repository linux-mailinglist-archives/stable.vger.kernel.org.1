Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F317C7829A6
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 14:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjHUM4r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 08:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjHUM4r (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 08:56:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30E7E3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 05:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 890D46162C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A775C433C9;
        Mon, 21 Aug 2023 12:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692622604;
        bh=45a8ZDPxaWQOfNYIJndSmF0UX1SJTo1j6eWJgtLbj1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gpIdddKsYvWIxNTlkuJB3P4QMqVQwLrHk18cdwSjAOU0K/1FcYmL02c6rpUU7g32f
         rydmvtnokydP27PC0P9OfXKmEsKdsEUAy1dJe54/BXRkJzpHQT1GeKgtCPR37Ozoa9
         uw/k18Piy5/KI+YRhp8j6vQ1e/jCDQD2rxJvxkIY=
Date:   Mon, 21 Aug 2023 14:56:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Tim Huang <Tim.Huang@amd.com>, sashal@kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: skip the RLC stop when S0i3 suspend for
 SMU v13.0.4/11
Message-ID: <2023082112-matchbook-favoring-48cc@gregkh>
References: <20230817134037.1535484-1-alexander.deucher@amd.com>
 <1337fb94-3a31-4aca-897d-8a59e7500dac@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1337fb94-3a31-4aca-897d-8a59e7500dac@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 21, 2023 at 07:15:53AM -0500, Limonciello, Mario wrote:
> 
> 
> On 8/17/2023 8:40 AM, Alex Deucher wrote:
> > From: Tim Huang <Tim.Huang@amd.com>
> > 
> > For SMU v13.0.4/11, driver does not need to stop RLC for S0i3,
> > the firmwares will handle that properly.
> > 
> > Signed-off-by: Tim Huang <Tim.Huang@amd.com>
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > (cherry picked from commit 730d44e1fa306a20746ad4a85da550662aed9daa)
> > Cc: stable@vger.kernel.org # 6.1.x
> 
> Greg,
> 
> Just want to make sure this one didn't get accidentally skipped since you
> populated the stable queues and didn't see it landed.

I'm still working on catching up on the stable backlog as I was gone
last week, this is in my "to get to soon" queue, it's not lost :)

thanks,

greg k-h
