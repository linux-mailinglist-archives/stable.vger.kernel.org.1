Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98887E5161
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 08:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjKHHwz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 02:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKHHwy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 02:52:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2198199
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 23:52:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2121FC433C8;
        Wed,  8 Nov 2023 07:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699429972;
        bh=3PeDvtMdSO3qjEIRN0wzlZUivW+dRg1lpgO8Cx8G+fY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hSt2svxHMxfcvq8fGAArYucSippdqVxYXhNKd4RbHB/xNIehdFm4zoG/NKJidho+v
         +Q7b0VeYVrWNhucZHAsGu0uMmvRCiek/mNXiEJOpEU7cVcOJ3pdSbC8Qn7IN6OROSy
         I0cugCSoAjzPQE3lrRKchuGsf0Dbwp2mZVsm5CNA=
Date:   Wed, 8 Nov 2023 08:52:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
        mario.limonciello@amd.com, yifan1.zhang@amd.com,
        stable@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        Li Ma <li.ma@amd.com>
Subject: Re: [PATCH] r8169: fix ASPM-related issues on a number of systems
 with NIC version from RTL8168h
Message-ID: <2023110833-renegade-fidgety-a008@gregkh>
References: <20231108033359.3948216-1-li.ma@amd.com>
 <2023110845-factual-dawn-7d68@gregkh>
 <9a5ba6df-5d15-4c23-98cd-686b1f62e05b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a5ba6df-5d15-4c23-98cd-686b1f62e05b@gmail.com>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Nov 08, 2023 at 08:40:48AM +0100, Heiner Kallweit wrote:
> On 08.11.2023 08:05, Greg KH wrote:
> > On Wed, Nov 08, 2023 at 11:34:00AM +0800, Li Ma wrote:
> >> From: Heiner Kallweit <hkallweit1@gmail.com>
> >>
> >> This effectively reverts 4b5f82f6aaef. On a number of systems ASPM L1
> >> causes tx timeouts with RTL8168h, see referenced bug report.
> >>
> >> Fixes: 4b5f82f6aaef ("r8169: enable ASPM L1/L1.1 from RTL8168h")
> >> Cc: stable@vger.kernel.org
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217814
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> Signed-off-by: David S. Miller <davem@davemloft.net>
> >> (cherry picked from commit 90ca51e8c654699b672ba61aeaa418dfb3252e5e)
> >> ---
> >>  drivers/net/ethernet/realtek/r8169_main.c | 4 ----
> >>  1 file changed, 4 deletions(-)
> > 
> > Is this a proposed stable tree patch?  If so, what kernel(s) are you
> > wanting it applied to?
> > 
> This should have been sent neither to you nor stable@vger.kernel.org.
> This patch has been applied to stable already, the mail is something
> AMD-internal it seems.

Then someone needs to seriously fix their scripts as it is very
confusing :(
