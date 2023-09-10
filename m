Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055CA799DC5
	for <lists+stable@lfdr.de>; Sun, 10 Sep 2023 12:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjIJK5O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 10 Sep 2023 06:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346623AbjIJK5O (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 10 Sep 2023 06:57:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEEBCD9
        for <stable@vger.kernel.org>; Sun, 10 Sep 2023 03:57:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557D3C433C8;
        Sun, 10 Sep 2023 10:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694343429;
        bh=tjM6GqiFfgp4vFrIiFZf3xakf/VPm1W2792IKeClBEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GkQAeWtIScWhPXL19OBGYlLylPuBjao/g+00K11qQXOyxQjw2930XZNDCmn4WDwfc
         cGFie6GR+qi81jyvEj3/AkxTc3Yiv37FdL6Lj+lKdl4bHmF8zvEX5z5s1H6IEIbW5J
         YhPVcHHaBsJkIr0cgOfMQZ3L3aSryAi3CsIH2UN4=
Date:   Sun, 10 Sep 2023 11:29:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     stable <stable@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Subject: Re: of: property: fw_devlink: Add a devlink for panel followers
Message-ID: <2023091001-oxidant-magnesium-c5ad@gregkh>
References: <CAHCN7xLNoqy7NYenfZm_2vLZ94bbmU95jeFvr2FAugTtPn_naA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xLNoqy7NYenfZm_2vLZ94bbmU95jeFvr2FAugTtPn_naA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 08, 2023 at 06:26:02PM -0500, Adam Ford wrote:
> Stable Group,
> 
> Please apply commit fbf0ea2da3c7("of: property: fw_devlink: Add a
> devlink for panel followers") to the 6.1.y stable branch. This fixes
> an issue where a display panel is deferred indefinitely on an
> AM3517-EVM.

What about newer kernels?  You can't upgrade and have a regression :(

I've queued it up everywhere now, thanks,

greg k-h
