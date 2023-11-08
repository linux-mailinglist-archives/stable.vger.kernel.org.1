Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C377E50C6
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 08:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjKHHFS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 02:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjKHHFS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 02:05:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1832010D3
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 23:05:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B40C433C7;
        Wed,  8 Nov 2023 07:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699427115;
        bh=7xc9G6SOZ4q68s8IZylizrktOjXd9+dgnshxbYYHsuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVFTMZaPA5PF/9QIu4jL8SdPCqKcsqrusDTcLgOnVw3If1KL96LjObTi8ad0EeqM9
         r/lmrZX0HDrhswdfwYRRD3+AY2kYsbsviOAkvf7BLT9dinwaUPpEjApfG3CQLZH6Xx
         Pc5iCrv11W1azmZOI1sLOLrIzf+TR3BB8TIcP7Cs=
Date:   Wed, 8 Nov 2023 08:05:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Ma <li.ma@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
        mario.limonciello@amd.com, yifan1.zhang@amd.com,
        Heiner Kallweit <hkallweit1@gmail.com>, stable@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH] r8169: fix ASPM-related issues on a number of systems
 with NIC version from RTL8168h
Message-ID: <2023110845-factual-dawn-7d68@gregkh>
References: <20231108033359.3948216-1-li.ma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108033359.3948216-1-li.ma@amd.com>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Nov 08, 2023 at 11:34:00AM +0800, Li Ma wrote:
> From: Heiner Kallweit <hkallweit1@gmail.com>
> 
> This effectively reverts 4b5f82f6aaef. On a number of systems ASPM L1
> causes tx timeouts with RTL8168h, see referenced bug report.
> 
> Fixes: 4b5f82f6aaef ("r8169: enable ASPM L1/L1.1 from RTL8168h")
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217814
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> (cherry picked from commit 90ca51e8c654699b672ba61aeaa418dfb3252e5e)
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 4 ----
>  1 file changed, 4 deletions(-)

Is this a proposed stable tree patch?  If so, what kernel(s) are you
wanting it applied to?

thanks,

greg k-h
