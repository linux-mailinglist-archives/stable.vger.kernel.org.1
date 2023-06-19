Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2311734CAF
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 09:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjFSHum (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 03:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjFSHul (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 03:50:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF521AA
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 00:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B446161556
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 07:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF57C433C0;
        Mon, 19 Jun 2023 07:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687161039;
        bh=mtCDmWnvyRZ+MksUjHlna3IsVSv85c3nLkDttiZ4B20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uZsxpm+gVe9oywup3F6tGmKOZeGxyuog+38la4CXUv4kTwxZ+1x0q0hFULFXkbHjJ
         dM9fXppcbOoNQsQIXnfVIM7IYQSva7VBEJqzTIDzMilM5PZN/Oa8R+Wuo+VXq9uFh3
         1yqkNmPNOuyD6dA6OZXJmvo5aDpWD1v8Xw2yzJpg=
Date:   Mon, 19 Jun 2023 09:50:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ovidiu.panait@windriver.com
Cc:     stable@vger.kernel.org, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 5.10 1/3] media: dvbdev: Fix memleak in
 dvb_register_device
Message-ID: <2023061912-framing-cheesy-5390@gregkh>
References: <20230612133907.2999114-1-ovidiu.panait@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612133907.2999114-1-ovidiu.panait@windriver.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 12, 2023 at 04:39:05PM +0300, ovidiu.panait@windriver.com wrote:
> From: Dinghao Liu <dinghao.liu@zju.edu.cn>
> 
> commit 167faadfcf9339088910e9e85a1b711fcbbef8e9 upstream.
> 
> When device_create() fails, dvbdev and dvbdevfops should
> be freed just like when dvb_register_media_device() fails.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> Signed-off-by: Sean Young <sean@mess.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
> ---
>  drivers/media/dvb-core/dvbdev.c | 3 +++
>  1 file changed, 3 insertions(+)

All queued up, thanks.

greg k-h
