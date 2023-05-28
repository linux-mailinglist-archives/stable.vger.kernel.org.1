Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29F8713835
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 09:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjE1HCT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 03:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjE1HCS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 03:02:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E097A0;
        Sun, 28 May 2023 00:02:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26EFF60BA6;
        Sun, 28 May 2023 07:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B78C433EF;
        Sun, 28 May 2023 07:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685257336;
        bh=suqQq9h0i5+ndv8pwgu9Yc/hvbm30nMEUi5hv++eDE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Of+tKunPP2xZ87GrZ9M5jpn4AQn3A4rCpAPIoapoYjO55qD9hh36CyfZMsvtzkNdr
         nWK+fHWY8ismfOB/FzuiDDxo7Sl+lnemwWxnJookMHJqYRIviF8GnvxWgQj2tvAq6Z
         gK3tyWIrmQ8Q1IpN24Rj3wvko/rjAb03JnfV7D9E=
Date:   Sun, 28 May 2023 08:02:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <benh@debian.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-scsi <linux-scsi@vger.kernel.org>, security@kernel.org
Subject: Re: dpt_i2o fixes for stable
Message-ID: <2023052823-uncoated-slimy-cbc7@gregkh>
References: <b1d71ba992d0adab2519dff17f6d241279c0f5f1.camel@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1d71ba992d0adab2519dff17f6d241279c0f5f1.camel@debian.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, May 27, 2023 at 10:42:00PM +0200, Ben Hutchings wrote:
> I'm proposing to address the most obvious issues with dpt_i2o on stable
> branches.  At this stage it may be better to remove it as has been done
> upstream, but I'd rather limit the regression for anyone still using
> the hardware.
> 
> The changes are:
> 
> - "scsi: dpt_i2o: Remove broken pass-through ioctl (I2OUSERCMD)",
>   which closes security flaws including CVE-2023-2007.
> - "scsi: dpt_i2o: Do not process completions with invalid addresses",
>   which removes the remaining bus_to_virt() call and may slightly
>   improve handling of misbehaving hardware.
> 
> These changes have been compiled on all the relevant stable branches,
> but I don't have hardware to test on.

Why don't we just delete it in the stable trees as well?  If no one has
the hardware (otherwise the driver would not have been removed), who is
going to hit these issues anyway?

thanks,

greg k-h
