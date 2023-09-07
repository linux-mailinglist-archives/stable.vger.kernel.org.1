Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9F7973A9
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 17:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbjIGP24 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 11:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbjIGPWn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 11:22:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C45C10F6
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 08:22:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B2CC32799;
        Thu,  7 Sep 2023 14:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694097890;
        bh=VKqyfVnhB7SAHajDLc5QiOo3E7j51ER2r5282US6zDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=msdIrU7BNE9+hbOxBcE/ASmVYZuk0nH8CGwWkI/okNhhl/Ir9UhxKjF4JTyKKXewC
         9aKM8GXsujVlF0hSP+PX21Pb1QReGnQB/siCN7+8xjjDKlxyX4QYhXY2Ieg/fvsJVX
         iNu3WUfkBKiknnkp/o+t8tzGyW02RnptFuFvKotQ=
Date:   Thu, 7 Sep 2023 15:44:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org,
        Michael Larabel <Michael@michaellarabel.com>
Subject: Re: Kernel 6.5 black screen regression
Message-ID: <2023090738-wannabe-nape-65c6@gregkh>
References: <074d84cd-e802-4900-ad70-b9402de43e64@amd.com>
 <2023090729-struggle-poison-4ebc@gregkh>
 <2b6d2117-b76d-4e86-87ba-48ebc6da11a9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b6d2117-b76d-4e86-87ba-48ebc6da11a9@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 07, 2023 at 09:06:15AM -0500, Mario Limonciello wrote:
> On 9/7/2023 05:13, Greg KH wrote:
> > On Wed, Sep 06, 2023 at 12:55:29PM -0500, Mario Limonciello wrote:
> > > Hi,
> > > 
> > > The following patch fixes a regression reported by Michael Larabel on an
> > > Acer Phoenix laptop where there is a black screen in GNOME with kernel 6.5.
> > > 
> > > It's marked CC to stable, but I checked the stable queue and didn't see it
> > > so I wanted to make sure it wasn't missed.
> > 
> > The fixes tag in that commit is odd, it says it fixes something that is
> > NOT in 6.5, so are you sure about this?
> > 
> 
> I believe it's one of those cases that the same commit landed twice. So the
> wrong SHA got added to the fixes tag.
> 
> This is the one it should have been:
> 
> 1ca67aba8d11 ("drm/amd/display: only accept async flips for fast updates")
> 
> > > a7c0cad0dc06 ("drm/amd/display: ensure async flips are only accepted for
> > > fast updates")
> > > 
> > > Reported-by: Michael Larabel <Michael@MichaelLarabel.com>
> > 
> > Ok, now queued up, thanks.
> 
> Thanks!
> 
> Seeing the correct sha1; I find the problematic one backported to:
> 
> * 6.4.7 as cd013a58cf64 ("drm/amd/display: only accept async flips for fast
> updates")
> 
> and
> 
> * 6.1.42 as 438542074174 ("drm/amd/display: only accept async flips for fast
> updates")
> 
> Did you only queue for 6.5.y?  If so, can you please add to 6.1.y and 6.4.y
> as well?

Ok, now queued up there too, thanks.

greg k-h
