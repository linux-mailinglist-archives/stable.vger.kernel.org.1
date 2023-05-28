Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA85713C14
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjE1TCl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjE1TCk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:02:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415C890
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:02:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF412612F5
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D3EC433EF;
        Sun, 28 May 2023 19:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685300558;
        bh=odk+gOtPUxsMhK1oZUMZtn3YLXrrFX43CnVhOWoADsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q8L6G8pr1B/fWp7QoQ2YOcCNL+pVQ/nmUOEa7u63JWIEo8bS9jPNPyBqp3jehHdXI
         v0UB86bX1JQH10S6cE6zsKxRu3lBuUa+dtpNDSqwJvzpBht2zfkgCv2AdeNq6XiNHh
         vdShPHvYzsq93O2djOtaZ2RQp470qy7xIj1ov7gA=
Date:   Sun, 28 May 2023 20:02:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     beld zhang <beldzhang@gmail.com>
Cc:     stable@vger.kernel.org
Subject: Re: Fwd: 6.1.30: thunderbolt: Clear registers properly when auto
 clear isn't in use cause call trace after resume
Message-ID: <2023052822-evaluate-essential-52a3@gregkh>
References: <CAG7aomXv2KV9es2RiGwguesRnUTda-XzmeE42m0=GdpJ2qMOcg@mail.gmail.com>
 <ZHKW5NeabmfhgLbY@debian.me>
 <261a70b7-a425-faed-8cd5-7fbf807bdef7@amd.com>
 <CAG7aomVVJyDpKjpZ=k=+9qKY5+13eFjcGPEWZ0T0+NTNfZWDfA@mail.gmail.com>
 <CAG7aomXP0JHmHytsv5cMsyHzee61BQnG3fc-Y+NLzum7H3DyHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG7aomXP0JHmHytsv5cMsyHzee61BQnG3fc-Y+NLzum7H3DyHA@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, May 28, 2023 at 02:35:18PM -0400, beld zhang wrote:
> ---------- Forwarded message ---------
> From: beld zhang
> Date: Sun, May 28, 2023 at 2:07 PM
> Subject: Re: 6.1.30: thunderbolt: Clear registers properly when auto
> clear isn't in use cause call trace after resume
> To: Mario Limonciello
> 
> On Sun, May 28, 2023 at 8:55 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > This is specific resuming from s2idle, doesn't happen at boot?
> >
> > Does it happen with hot-plugging or hot-unplugging a TBT3 or USB4 dock too?
> >
> > In addition to checking mainline, can you please attach a full dmesg to
> > somewhere ephemeral like a kernel bugzilla with thunderbolt.dyndbg='+p'
> > on the kernel command line set?
> >
> 
> 6.4-rc4:
>     *) test 1~4 was done with usb hub with ethernet plugged-in
>         model: UE330, usb 3.0 3-port hub & GIgabit Ether adapter
>         a rapoo wireless mouse in one of the ports
>     1) no crash at boot
>         until [169.099024]
>     2) no crash after plug an extra usb dock
>         from [297.004691]
>     3) no crash after remove it
>         from [373.273511]
>     4) crash after suspend/resume: 2 call-stacks
>         from [438.356253]
>     5) removed that hub(only ac-power left): NO crash after resume
>         from [551.820333]
>     6) plug in the hub(no mouse): NO crash after resume
>         from [1250.256607]
>     7) put on mouse: CRASH after resume
>         from [1311.400963]
>         mouse model: Rapoo Wireless Optical Mouse 1620
> 
> sorry I have no idea how to fill a proper bug report at kernel
> bugzilla, hope these shared links work.
> btw I have no TB devices to test.
> 
> dmesg:
> https://drive.google.com/file/d/1bUWnV7q2ziM4tdTzmuGiVuvEzaLcdfKm/view?usp=sharing
> 
> config:
> https://drive.google.com/file/d/1It75_AV5tOzfkXXBAX5zAiZMoeJAe0Au/view?usp=sharing

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
