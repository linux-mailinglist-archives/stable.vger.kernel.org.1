Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD956F8FB2
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 09:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjEFHMB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 03:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjEFHMA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 03:12:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBB411607
        for <stable@vger.kernel.org>; Sat,  6 May 2023 00:11:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28A4361802
        for <stable@vger.kernel.org>; Sat,  6 May 2023 07:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D72C433D2;
        Sat,  6 May 2023 07:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683357109;
        bh=40PdCTLTcEJxLZ7g+1HtdAimxOwBFKF+OTi07ozBwGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a2a01UoOnYcEjso0sVHUS9d64nG7PFQsMi2IPddxb4cOYtdsEjPCU2EBC/qgce22n
         r6+T2AcvTkiSyRyP9IdomDlDptQuCym400tub4KL0hrmND5Ik46aP1KTngmRCFas2w
         LzzctOBHMHwwOyUBOrbY2eyRFlfpx1ijEeUsvmas=
Date:   Sat, 6 May 2023 15:59:18 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: patch for 5.10.stable (sound/oss/dmasound)
Message-ID: <2023050658-reburial-magenta-8bce@gregkh>
References: <36efe6f3-009c-e849-f9d7-6a643edad8e0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36efe6f3-009c-e849-f9d7-6a643edad8e0@infradead.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, May 05, 2023 at 10:40:13PM -0700, Randy Dunlap wrote:
> Please apply
> 
> commit 9dd7c46346ca
> Author: Randy Dunlap <rdunlap@infradead.org>
> Date:   Tue Apr 5 16:41:18 2022 -0700
> 
>     sound/oss/dmasound: fix build when drivers are mixed =y/=m
> 
> to the 5.10 stable tree. The kernel test robot <lkp@intel.com> reported a build
> error on 5.10.y and this patch fixes the build error.

Thanks, I've also added it to 5.15.y as you don't want to upgrade and
have a regression.

thanks,

greg k-h
