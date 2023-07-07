Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548EA74B4AF
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 17:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjGGPyD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 11:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjGGPyC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 11:54:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE0FFB
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 08:54:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B0DB619D7
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 15:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95646C433C7;
        Fri,  7 Jul 2023 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688745240;
        bh=R3EVT3xWrqlHniUuNHMFx4zO1FwPULHMKiOicr0Cw2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTYe4H+wtRA+FEam2S9V4BWPrGpz+pIIuJT3al3IG+SHV6RShp7VDzBGQdAhmiv+J
         xO5/2Yt9l17nghfHMCJ8hvZeyI74M+tzp1gZvVKswc+s29Hgmv4PIE1G8iHWkE27SE
         3SGeZIbMVC3cKxuHThYqDeuCgWf39I0Yzl/+Nh3o=
Date:   Fri, 7 Jul 2023 17:53:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     stable@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: backport d8c47cc7bf602ef73384a00869a70148146c1191 to linux-5.15.y
Message-ID: <2023070711-overstay-reclining-7443@gregkh>
References: <b606c4f7-1e47-6c26-c73d-7facaff5e469@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b606c4f7-1e47-6c26-c73d-7facaff5e469@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jul 07, 2023 at 02:52:03PM +0530, Charan Teja Kalla wrote:
> Hi,
> 
> Can you please help in back porting the below patch to linux-5.15.y
> stable tree:
> commit d8c47cc7bf602ef73384a00869a70148146c1191("mm: page_io: fix psi
> memory pressure error on cold swapins") .

This commit does not apply to the 5.15.y kernel at all, how did you test
this?

> With the absence of this patch we are seeing some user space tools, like
> Android low memory killer based on PSI events, bit aggressive as it
> makes the PSI is accounted for even cold swapin on a device where swap
> is mounted on a zram with slower backing dev.

How did you test this if the commit does not apply properly at all?

If you need this in the 5.15.y kernel, please provide a working, and
tested, backport.

thanks,

greg k-h
