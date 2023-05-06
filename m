Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03256F8F92
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 09:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjEFHAP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 03:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjEFHAL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 03:00:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29C42727
        for <stable@vger.kernel.org>; Sat,  6 May 2023 00:00:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EEDD60E55
        for <stable@vger.kernel.org>; Sat,  6 May 2023 07:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1765C433EF;
        Sat,  6 May 2023 07:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683356409;
        bh=e2CGOc4sJ82kj3BX3TC75L5w3SAlTbiwFSZgnXIP5oU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q5HzGoFPPZlzhiE7OzbY5rx/h6iUS37n26nWP8ub386N9zp/ibLcaj4ZMvpUocx9y
         Yqp3NVqxf6J+1v1Blw8lb4LLoT6YZKrNiNFkNxgZlfE8/uWKYG1W6vhQdHT4cno2bE
         6VHtZWL5Ex0e8qo0vsOWBoEdXOvFqtoJYniyZgHs=
Date:   Sat, 6 May 2023 15:38:45 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Gong, Richard" <Richard.Gong@amd.com>
Subject: Re: S3 support on some GFX11 products
Message-ID: <2023050638-evaporate-limeade-7bcf@gregkh>
References: <MN0PR12MB610106E9988CC7FF8F0A95C5E2729@MN0PR12MB6101.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB610106E9988CC7FF8F0A95C5E2729@MN0PR12MB6101.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, May 05, 2023 at 10:17:06PM +0000, Limonciello, Mario wrote:
> [AMD Official Use Only - General]
> 
> Hi,
> 
> Some GFX11 based products will have S3 support as an option, but to support this some of the suspend flow had to be adjusted in kernel 6.4 for it to work properly.
> 
> For 6.2.y/6.3.y the following commit is needed:
> f7f28f268b86 ("drm/amd/pm: re-enable the gfx imu when smu resume")
> 
> For 6.1.y the following two commits are needed:
> 484d7dcc709d ("swsmu/amdgpu_smu: Fix the wrong if-condition")
> f7f28f268b86 ("drm/amd/pm: re-enable the gfx imu when smu resume")
> 
> Can you please backport them?

Now queued up, thanks!

greg k-h
