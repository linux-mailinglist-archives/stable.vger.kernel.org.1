Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB53B71456D
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 09:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjE2H0m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 03:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjE2H0l (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 03:26:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EC0A6
        for <stable@vger.kernel.org>; Mon, 29 May 2023 00:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09AFF6119B
        for <stable@vger.kernel.org>; Mon, 29 May 2023 07:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080DCC433EF;
        Mon, 29 May 2023 07:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685345199;
        bh=3a+kCtESLOpfmvRAuPDpOZaRmapNfK6gg2i+EQJm3a4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=voB+Xk54lGEEjXjSPMWD0ezjCOqcryli9x4CTXpK6isGaAwe0erKXbzNCYwDg0UPf
         t109pidnem1s+Igy/Xpx3eo1Ysl138Y8BS+4UbuVxJrMqxvYYFoX/6/HRF2UocSLzL
         moiiz1i3AaQMi64jzsZyQx1ceYI093vtK0zL6IOk=
Date:   Mon, 29 May 2023 08:26:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     beld zhang <beldzhang@gmail.com>, stable@vger.kernel.org
Subject: Re: Fwd: 6.1.30: thunderbolt: Clear registers properly when auto
 clear isn't in use cause call trace after resume
Message-ID: <2023052908-generous-nutrient-ab24@gregkh>
References: <CAG7aomXv2KV9es2RiGwguesRnUTda-XzmeE42m0=GdpJ2qMOcg@mail.gmail.com>
 <ZHKW5NeabmfhgLbY@debian.me>
 <261a70b7-a425-faed-8cd5-7fbf807bdef7@amd.com>
 <CAG7aomVVJyDpKjpZ=k=+9qKY5+13eFjcGPEWZ0T0+NTNfZWDfA@mail.gmail.com>
 <CAG7aomXP0JHmHytsv5cMsyHzee61BQnG3fc-Y+NLzum7H3DyHA@mail.gmail.com>
 <2023052822-evaluate-essential-52a3@gregkh>
 <ZHQK_ZyW3NW3JXdz@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHQK_ZyW3NW3JXdz@debian.me>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 29, 2023 at 09:16:29AM +0700, Bagas Sanjaya wrote:
> On Sun, May 28, 2023 at 08:02:35PM +0100, Greg KH wrote:
> > > sorry I have no idea how to fill a proper bug report at kernel
> > > bugzilla, hope these shared links work.
> > > btw I have no TB devices to test.
> > > 
> > > dmesg:
> > > https://drive.google.com/file/d/1bUWnV7q2ziM4tdTzmuGiVuvEzaLcdfKm/view?usp=sharing
> > > 
> > > config:
> > > https://drive.google.com/file/d/1It75_AV5tOzfkXXBAX5zAiZMoeJAe0Au/view?usp=sharing
> > 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> > 
> > </formletter>
> 
> Hi Greg,
> 
> You confuse attaching bug artifacts (here dmesg and .config) with stable
> kernel patches. The reporter doesn't have any patches to help fixing
> this regression at the moment.
> 

No, I was not confused, sending bug reports to this email address is not
going to help at all, so my bot was correct.

thanks,

greg k-h
