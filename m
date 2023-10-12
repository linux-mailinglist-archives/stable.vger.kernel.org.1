Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC737C73B9
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 19:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347311AbjJLRIK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 13:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344025AbjJLRIJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 13:08:09 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5267B90
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 10:08:08 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C27415C0390;
        Thu, 12 Oct 2023 13:08:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 12 Oct 2023 13:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697130487; x=1697216887; bh=n4
        7i1E2QgM/H/PywJnnV7tyrwrT0BJ9SiardzYVlh5o=; b=V4kwoAeoeAFCeyX4Jt
        c9IeEcEuTVGQQoysRdxbcTQQzBbMwVmh9PNhMbQ4dygkoieS2FMRqIgO8hXrKQ+G
        7BPQdCylfyohxYwRyZ52ylarsQQ6BG15fRj2BPdTCN1pgNgWNJWtZ5MLl11GCpG8
        RqU+RlgUbTRqhUM6sweiTnB2d4XmNeXN7GI6PF4XgX5dEyGqnNIIIFBrdbx8Kfg4
        l2Iz6xoueo9uqmoSKkowRBJi+6wrlx8JAaHSqwo/EJILWXoCaaki1lcQon1+/yZr
        vN1nuRcmIid+fNm9enZR/4JgSIQyHSbTWHxK7sb5kAuhb4X0CJAOUm/2ieT8vYuH
        eSaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1697130487; x=1697216887; bh=n47i1E2QgM/H/
        PywJnnV7tyrwrT0BJ9SiardzYVlh5o=; b=fds/N0eWVr+xK4zTGBROyHfFtR+Du
        Yl2ICOrYdvpH5JKfZEvXDLGaFGhtvWpE8dpEFi8nEgIVnyrHGxF3M8o0M3qHO1Ih
        Iz/aE3J91aJlpTkltw8gbjZZOSGxsDibQR2xDv2c+3zLZpX4FtOUqXprauFCncQD
        tzZryJ6Ks8G51npLsxu/lGKQBPs1aCAoWDlESgz9vT8eSwtShTYNiMhN8A8vajsk
        qfaDiq6DiQ2h82p0g+7PPbuceR9W++EMDNqeCROSh/4kUf0vYKSqpyo7J9kz8pc6
        TG9rbcNs4MmCX97L3PNfZsm5kaeM4KkS9A0VGBIUEChtTOVpjK5n5x7pA==
X-ME-Sender: <xms:9ycoZejzkkudGUhLo9gSHakJ04rUXNKB8SDVypU6vPOHtimxhbWOHQ>
    <xme:9ycoZfBlioaoz0InPsST1Iil6UY7v9ynh_xREMJkgG44vRkaKPG0iue059acCKVch
    UKPTmbVt9ow8g>
X-ME-Received: <xmr:9ycoZWFfI7F9s7dAO90WAN1GZ--f-W8cjjtf4Vs26kVGD5h85_GjEp3aLrlscDVD_eqNsrjGvcLpb8SQ8wfWp4pMcJ1HWfOvFBL-7jjr4jE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedriedtgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:9ycoZXQuEIS0HL_mI0MtGSUUsJr3IaND1bwLtDdXA1mY5MBZHcuIPw>
    <xmx:9ycoZbzD02uWaoU-v6J3yel9T7uakRpK3V1gDGS0ilkHa4AYz9KbYg>
    <xmx:9ycoZV7bOyViOhVxl5Ouo9SajEy8oVfvrxTdHf-Vt0vqobBLt5Dcfw>
    <xmx:9ycoZW8M1TdtPAyghZoMO6EPcvqAkg_saqDkqgKZqxsi43dYhxh7Yg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Oct 2023 13:08:06 -0400 (EDT)
Date:   Thu, 12 Oct 2023 19:08:05 +0200
From:   Greg KH <greg@kroah.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 6.5.y 0/2] Fixup for drm/amd/display: apply edge-case
 DISPCLK WDIVIDER changes to master OTG pipes only
Message-ID: <2023101256-rare-unshipped-b594@gregkh>
References: <20231009182037.124395-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009182037.124395-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 09, 2023 at 01:20:35PM -0500, Mario Limonciello wrote:
> commit b206011bf050 ("drm/amd/display: apply edge-case DISPCLK WDIVIDER
> changes to master OTG pipes only") was tagged to stable but fails to
> apply to 6.5.y because resource_is_pipe_type() isn't in 6.5.y.
> 
> The commit that adds it is way too big to be stable, but the new symbol
> from that commit is viable.  Backport just the new symbol and enum to fix
> the backport.
> 
> Mario Limonciello (1):
>   drm/amd/display: implement pipe type definition and adding accessors
> 
> Samson Tam (1):
>   drm/amd/display: apply edge-case DISPCLK WDIVIDER changes to master
>     OTG pipes only
> 
>  .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   4 +-
>  .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   4 +-
>  .../gpu/drm/amd/display/dc/core/dc_resource.c |  35 ++++++
>  drivers/gpu/drm/amd/display/dc/inc/resource.h | 106 ++++++++++++++++++
>  4 files changed, 145 insertions(+), 4 deletions(-)
> 
> -- 
> 2.34.1
> 

All now queued up, thanks.

greg k-h
