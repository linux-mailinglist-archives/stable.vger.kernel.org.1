Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FF57C74C5
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 19:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379625AbjJLR3W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 13:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379574AbjJLR3V (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 13:29:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46497D5D
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 10:23:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30565C433C7;
        Thu, 12 Oct 2023 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697131436;
        bh=sq90ahtQY7ZosJXu0/rtvnLkfTJqb1yIGEkTVyFwWRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fpr27ayveMho3YQD+UNn2S9rexf+J686OA1/s/sLKemlXwnR8wvE4KuxAE8XqlK1Y
         ifVFhcx2/P2YqJidqqVCJXTgZ5khTjBIJx18OxuKnOMuY7uAMSkauUC/lLBuPPtAR9
         rgwjMesBaxg7lTsPYQbSyI3jy2YV2rPNCWXDhI2Y=
Date:   Thu, 12 Oct 2023 19:23:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     stable@vger.kernel.org, hackerzheng666@gmail.com,
        sashal@kernel.org, patches@lists.linux.dev, amergnat@baylibre.com,
        wenst@chromium.org, angelogioacchino.delregno@collabora.com,
        hverkuil-cisco@xs4all.nl
Subject: Re: [RESEND PATCH v2] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
Message-ID: <2023101214-trilogy-wildcard-29cb@gregkh>
References: <20231011073204.1069793-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011073204.1069793-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 11, 2023 at 03:32:04PM +0800, Zheng Wang wrote:
> This is a security bug that has been reported to google.
> It affected all platforms on chrome-os. Please apply this
> patch to 4.14 4.19 5.4 5.10 and 5.15.
> 
> [ Upstream commit c677d7ae83141d390d1253abebafa49c962afb52 ]

Did you try to apply this?  The file:

>  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 1 +

Is not in the kernels you asked for this patch to be applied to.

How did you test this?

confused,

greg k-h
