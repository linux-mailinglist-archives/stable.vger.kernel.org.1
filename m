Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5F07D48F4
	for <lists+stable@lfdr.de>; Tue, 24 Oct 2023 09:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjJXHuO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 24 Oct 2023 03:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjJXHuN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Oct 2023 03:50:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB5B118
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 00:50:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD20C433C8;
        Tue, 24 Oct 2023 07:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698133810;
        bh=paAD4Fm02WjfPacN8fv+t+ZeYK8r31ZPb+z4m3rR9AE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSTFqUkjdRHccDShILgP7snp9kSUsbpAaW4pVTbnd/vl57zBXe5zX2B9IgBtFFJTg
         OMOJHlkk+tMhw02UQjEq/qQDb5AMbLTY8vSEGr0DrYrngENq/aJMRL5P6HVPpCwfIg
         miUPs3sBcJ3CB/Kl7wWEioRSyqDyP2tBrIwZNvec=
Date:   Tue, 24 Oct 2023 09:50:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 06/98] platform/x86: hp-wmi:: Mark driver struct
 with __refdata to prevent section mismatch warning
Message-ID: <2023102459-flattery-pegboard-c2a3@gregkh>
References: <20231023104813.580375891@linuxfoundation.org>
 <20231023104813.808917387@linuxfoundation.org>
 <20231023164057.7rlec7423jeha6sg@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023164057.7rlec7423jeha6sg@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 23, 2023 at 06:40:57PM +0200, Uwe Kleine-König wrote:
> On Mon, Oct 23, 2023 at 12:55:55PM +0200, Greg Kroah-Hartman wrote:
> > 4.19-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > 
> > [ Upstream commit 5b44abbc39ca15df80d0da4756078c98c831090f ]
> > 
> > As described in the added code comment, a reference to .exit.text is ok
> > for drivers registered via module_platform_driver_probe(). Make this
> > explicit to prevent a section mismatch warning:
> > 
> > 	WARNING: modpost: drivers/platform/x86/hp/hp-wmi: section mismatch in reference: hp_wmi_driver+0x8 (section: .data) -> hp_wmi_bios_remove (section: .exit.text)
> 
> While that __ref is actually missing since the blamed commit, modpost
> only warns about .data -> .exit.text mismatches since
> 
> 	f177cd0c15fc ("modpost: Don't let "driver"s reference .exit.*")
> 
> (currently in next). So if your goal is to silence warnings in stable,
> patches of this type don't need to be backported unless f177cd0c15fc is
> backported, too. (But they don't hurt either.)

I'll go drop them, thanks!

greg k-h
