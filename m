Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F4F778769
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 08:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjHKG1Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 02:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHKG1Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 02:27:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1592D4F;
        Thu, 10 Aug 2023 23:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43440613B3;
        Fri, 11 Aug 2023 06:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285C2C433C7;
        Fri, 11 Aug 2023 06:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691735243;
        bh=N/m6NzP5n9fWBndbbjglZJU7JMrto+tgJomBdSdNKZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I1OSLxrFk6OY9FfiD46CcAWDebMqfCKbhmgTp81SHV3bce0AIxM9fkZ4gHT6qkFEK
         OO03G12byz7wQvttfW6Rc2SiGuNdqjAAmh+KuCc09ijtYTV08Yk7aPRWMa0quPKya7
         l6tB7IiNJ4OEPJzHxsyN/3uHd5v7mfqXJ2jRZuuc=
Date:   Fri, 11 Aug 2023 08:27:20 +0200
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
Message-ID: <2023081109-resent-doorman-2bf1@gregkh>
References: <CA+G9fYsf0jePDO3VPz0pb1sURdefpYCAYH-y+OdsAf3HuzbeRw@mail.gmail.com>
 <202308101328.40620220CB@keescook>
 <CA+G9fYugggRyxJFgxRwb0GvgXPerCE928S5vVW7ZnzfTJCRnZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYugggRyxJFgxRwb0GvgXPerCE928S5vVW7ZnzfTJCRnZA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Aug 11, 2023 at 08:47:53AM +0530, Naresh Kamboju wrote:
> On Fri, 11 Aug 2023 at 02:01, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Aug 08, 2023 at 10:57:30AM +0530, Naresh Kamboju wrote:
> > > LKFT build plans updated with toolchain gcc-13 and here is the report.
> > >
> > > Stable rc 6.1 arm64 builds with gcc-13 failed and the bisection is pointing
> > > to this as first bad commit,
> > >
> > > # first fixed commit: [e6a71160cc145e18ab45195abf89884112e02dfb]
> > >    gcc-plugins: Reorganize gimple includes for GCC 13
> > >
> > > Thanks Anders for bisecting this problem against Linux 6.2-rc6.
> > >
> > > Build errors:
> > > ---------------
> > > In file included from /builds/linux/scripts/gcc-plugins/gcc-common.h:75,
> > >                  from /builds/linux/scripts/gcc-plugins/stackleak_plugin.c:30:
> > > /usr/lib/gcc-cross/aarch64-linux-gnu/13/plugin/include/gimple-fold.h:72:32:
> > > error: use of enum 'gsi_iterator_update' without previous declaration
> > >    72 |                           enum gsi_iterator_update,
> > >       |                                ^~~~~~~~~~~~~~~~~~
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > I'm slightly confused by this report.
> 
> Sorry. I should have provided full details.
> 
> > Is it the build of v6.1 that is failing?
> 
> Linux-stable-rc linux.6.1.y failing with gcc-13.

I don't understand, I test here with gcc-13 for 6.4.y and 6.1.y and it's
working just fine.  What changed to cause this to fail now?

I'm using:
	gcc (GCC) 13.2.1 20230801

thanks,

greg k-h
