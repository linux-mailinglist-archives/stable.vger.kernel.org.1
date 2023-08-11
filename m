Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097057791A7
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 16:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjHKOTA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 10:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjHKOTA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 10:19:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021AA2709;
        Fri, 11 Aug 2023 07:19:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 940AA6738C;
        Fri, 11 Aug 2023 14:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F18C433C8;
        Fri, 11 Aug 2023 14:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691763539;
        bh=jftYWO3lvqRM1ASYhInl+BcdxxEBBRz2aqMbqNHCYMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v0Szv5rnm4yijuiXblV4ySdhHgqUJ3arSvJxIJz+o9FQrnkEtgIISlMNWXWD+0U5P
         8mdfcL/SJn7lpI/+BSbaYJiwFKkFvX0FkKvBG1CrQApJ0dkvZwWSfefoHUZcxnFR6K
         HwDl+QEMioXFkAm5fQsRMRWG5jNr+eAV+4gE3pG8=
Date:   Fri, 11 Aug 2023 16:18:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-hardening@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: stable-rc: 6.1: gcc-plugins: Reorganize gimple includes for GCC
 13
Message-ID: <2023081141-unruffled-fondness-aa62@gregkh>
References: <CA+G9fYsf0jePDO3VPz0pb1sURdefpYCAYH-y+OdsAf3HuzbeRw@mail.gmail.com>
 <202308101328.40620220CB@keescook>
 <CA+G9fYugggRyxJFgxRwb0GvgXPerCE928S5vVW7ZnzfTJCRnZA@mail.gmail.com>
 <2023081109-resent-doorman-2bf1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081109-resent-doorman-2bf1@gregkh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Aug 11, 2023 at 08:27:20AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 11, 2023 at 08:47:53AM +0530, Naresh Kamboju wrote:
> > On Fri, 11 Aug 2023 at 02:01, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Tue, Aug 08, 2023 at 10:57:30AM +0530, Naresh Kamboju wrote:
> > > > LKFT build plans updated with toolchain gcc-13 and here is the report.
> > > >
> > > > Stable rc 6.1 arm64 builds with gcc-13 failed and the bisection is pointing
> > > > to this as first bad commit,
> > > >
> > > > # first fixed commit: [e6a71160cc145e18ab45195abf89884112e02dfb]
> > > >    gcc-plugins: Reorganize gimple includes for GCC 13
> > > >
> > > > Thanks Anders for bisecting this problem against Linux 6.2-rc6.
> > > >
> > > > Build errors:
> > > > ---------------
> > > > In file included from /builds/linux/scripts/gcc-plugins/gcc-common.h:75,
> > > >                  from /builds/linux/scripts/gcc-plugins/stackleak_plugin.c:30:
> > > > /usr/lib/gcc-cross/aarch64-linux-gnu/13/plugin/include/gimple-fold.h:72:32:
> > > > error: use of enum 'gsi_iterator_update' without previous declaration
> > > >    72 |                           enum gsi_iterator_update,
> > > >       |                                ^~~~~~~~~~~~~~~~~~
> > > >
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > I'm slightly confused by this report.
> > 
> > Sorry. I should have provided full details.
> > 
> > > Is it the build of v6.1 that is failing?
> > 
> > Linux-stable-rc linux.6.1.y failing with gcc-13.
> 
> I don't understand, I test here with gcc-13 for 6.4.y and 6.1.y and it's
> working just fine.  What changed to cause this to fail now?
> 
> I'm using:
> 	gcc (GCC) 13.2.1 20230801

Anyway, it's easy enough for me to apply it, so now queued up, thanks.

greg k-h
