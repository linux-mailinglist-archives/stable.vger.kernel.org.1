Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35690736B6E
	for <lists+stable@lfdr.de>; Tue, 20 Jun 2023 13:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjFTLy6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 20 Jun 2023 07:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjFTLyx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Jun 2023 07:54:53 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EE4E71
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 04:54:52 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-56080bf991aso1014494eaf.2
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 04:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687262092; x=1689854092;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fC7ixx5XGw3lGOWRGdryAAdta1wplBoxevTd3xPK1BU=;
        b=lM5FyqIxcPF2+eS6BbMSyIHh7sF6SftVocmxGFbrbr05Q44DqbNnTwVulFfinzfIRS
         ZqEQWfLE8NU9ZeXHLFzjgYtJzcexs/6LTtsLUQmn6JlMajYkFIaEx18HgBVkzIxnxHCp
         iiwuw5OLZff//aOqQOSylXphJ6WoB1Hfz/IvC2CEogxrF/zcs2FmwNeuNkQ95O+5oV+a
         foBvk88BTZWC52jfffDxTrzwtCz2oFKV336lSy/8AzgLLXXMOMY5OliG37jARXv6Zpx6
         coqTUUKDEX6kPAMbdIc5iPKleMzH3PLHASW19+yzFAdotvCR/tlEZHhDPN/gkbfC2fu9
         J+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687262092; x=1689854092;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fC7ixx5XGw3lGOWRGdryAAdta1wplBoxevTd3xPK1BU=;
        b=erHLjA72WXIgD5M4X5shWGFPntzsihpQ+WfW+KzC912JZ038AQgKFW2z52amRX+arU
         qt2vS/8H1sR5363/vOgjKVy/LrO7ydKha3JbkTpAh/RIgbyUGQPJexv71MIVi+YgQ1qB
         P6SWuYtE4nmAkD9OBBIbC25u9do8xZC63MxWud4hMBY5/Cz3RxLnPx746w/fzjqyJgXN
         WSw852YAzWW2ym0V2LKVCuNvpGHoMc+9gpSNVGylJCbKcr6SaPV+lenKQOFRl8zHYUwn
         KrF1VpSLo3QLNUdSno0j8PnLinnQcEgKZgO/u+OcD9opiB0JHZnpp2xeUy75XH/oBku1
         XiDg==
X-Gm-Message-State: AC+VfDzP53WD7wwHzu38TJgWvm05CmLNdRNH7ABG5Pf2RoGQPcmF3XPb
        AkT+vWXLkoYQuVlghyiBRpTyMnMgvA==
X-Google-Smtp-Source: ACHHUZ7utsmw9lRrpy9ATxzxAxRmjmUNvTzOM0u4nvAHQlQeUvhwIcVG0MjKuWxFIUl+4VFUZvBkkw==
X-Received: by 2002:a05:6808:1451:b0:3a0:3ab4:8cce with SMTP id x17-20020a056808145100b003a03ab48ccemr1552487oiv.45.1687262091670;
        Tue, 20 Jun 2023 04:54:51 -0700 (PDT)
Received: from serve.minyard.net ([47.184.157.108])
        by smtp.gmail.com with ESMTPSA id y186-20020acae1c3000000b0039eb51a5dffsm1017723oig.43.2023.06.20.04.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:54:50 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:3c66:2774:dcfe:891a])
        by serve.minyard.net (Postfix) with ESMTPSA id 0946E1800BA;
        Tue, 20 Jun 2023 11:54:50 +0000 (UTC)
Date:   Tue, 20 Jun 2023 06:54:48 -0500
From:   Corey Minyard <minyard@acm.org>
To:     "Janne Huttunen (Nokia)" <janne.huttunen@nokia.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: IPMI related kernel panics since v4.19.286
Message-ID: <ZJGTiNR0putMfSHu@mail.minyard.net>
Reply-To: minyard@acm.org
References: <7ae67dbec16b93f0e6356337e52bf21921b0897c.camel@nokia.com>
 <ZJBPjOL8chqtPck2@mail.minyard.net>
 <dab0ac65c452ba3af6837b268a1d5d9d280360eb.camel@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dab0ac65c452ba3af6837b268a1d5d9d280360eb.camel@nokia.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 20, 2023 at 09:56:50AM +0000, Janne Huttunen (Nokia) wrote:
> 
> > It looks like
> > 
> >   b4a34aa6d "ipmi: Fix how the lower layers are told to watch for
> > messages"
> > 
> > was backported to fullfill a dependency for another backport, but
> > there was another change:
> > 
> >   e1891cffd4c4 "ipmi: Make the smi watcher be disabled immediately
> > when not needed"
> > 
> > That is needed to avoid calling a lower layer function with
> > xmit_msgs_lock held.  It doesn't apply completely cleanly because of
> > other changes, but you just need to leave in the free_user_work()
> > function and delete the other function in the conflict.  In addition
> > to that, you will also need:
> > 
> >   383035211c79 "ipmi: move message error checking to avoid deadlock"
> > 
> > to fix a bug in that change.
> > 
> > Can you try this out?
> 
> Yes, sorry for the delay, had a bit of technical problems testing
> your proposed patches. In the meantime we found out that over
> a dozen of our test servers have had the same crash, some of them
> multiple times since the kernel update.

I don't consider this a delay, it was quite speedy.

> 
> Anyways, with your proposed patches on top of 4.19.286, I couldn't
> trigger the lockdep warning anymore even in a server that without
> the fixes triggers it very reliably right after the boot. I also
> saw in another very similar server (without the fixes) that it
> took almost 17 hours to get even the lockdep warning. Maybe some
> specific BMC behavior affects this or something? Sadly, that kind
> of diminishes the value of the short duration tests, but at least
> there has so far been zero lockdep warnings with the fixes applied.
> The actual lockups are then way too unpredictable to test reliably
> in any kind of short time frame.

It does depend on what you are doing to the driver, but it sounds like
you are running the same software everywhere.  I'm not sure; I've seen
timing do strange things before.

> 
> Anyways, looking at e1891cffd4c4, it's right there where the issue
> seems to originate from, so it makes total sense to me that it does
> fix it. I was already kind of looking at it when you confirmed it.
> Thanks for pointing out also the 383035211c79 patch, it might have
> been easily missed.
> 

Ok, thank you for testing.  I'll prepare a stable kernel request.

-corey
