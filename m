Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849497EC16C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 12:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbjKOLs2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 06:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343564AbjKOLs1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 06:48:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D7C11D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 03:48:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53530C433C8;
        Wed, 15 Nov 2023 11:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700048904;
        bh=mmc4JX/CRpX6FwatmFBZtFjdtRaFTI/8bfBatxCgHv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WoRc2t6x7CH3kohQhGSzeeJ27dl3SnRZXBga8gOx4yLsWK8u5e9n+iYAP1fruiBQi
         0/oZEdKCvF7a4ux3kvbvOAag8YPBIasSu37UICT/9WJ3QVRcfzZ1VNk7eWw/mPMqug
         deYUYz2HSh+i1b9bu2S9GnHCcy9zmsSUFjvcHj4c=
Date:   Wed, 15 Nov 2023 06:48:22 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthieu Baerts <matttbe@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
        MPTCP Upstream <mptcp@lists.linux.dev>,
        Mat Martineau <martineau@kernel.org>
Subject: Re: mptcp: commits to backports from 6.7-rc1
Message-ID: <2023111519-atlantic-legwarmer-5c6b@gregkh>
References: <a7a3675a-4531-4559-bea2-c7689317764a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7a3675a-4531-4559-bea2-c7689317764a@kernel.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Nov 07, 2023 at 12:22:19PM +0100, Matthieu Baerts wrote:
> Hi Greg, Sasha,
> 
> This is to let you know that 3 patches from MPTCP tree have been applied
> in Linus' tree and don't have their "Cc: stable":
> 
>   - f4a75e9d1100 ("selftests: mptcp: run userspace pm tests slower")
>     - for >= 6.5

Does not apply to 6.5.y, but did apply to 6.6.y

>   - 9168ea02b898 ("selftests: mptcp: fix wait_rm_addr/sf parameters")
>     - for >= 6.5

Now queued up.

>   - 84c531f54ad9 ("mptcp: userspace pm send RM_ADDR for ID 0")
>     - for >= 5.19
>     - note that the 'Fixes' tag is missing:

Did not apply to any stable queue :(

We'll need backports if you want this applied, thanks!

greg k-h
