Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E88C712AE0
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 18:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbjEZQlf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 12:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjEZQlf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 12:41:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728F2125
        for <stable@vger.kernel.org>; Fri, 26 May 2023 09:41:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB72865155
        for <stable@vger.kernel.org>; Fri, 26 May 2023 16:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A90C433EF;
        Fri, 26 May 2023 16:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685119293;
        bh=mvjNlLZflmQ9eqW8p95dzCluSVFryDHkTIl5aLa5JbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kny7HpQRbRdhEnU4vp5TKv49ROVtsQxJOHGt+5CfMX1eu9G2M4kUWZHrBfC5ca3kg
         97LCz57xmsJmmt+r1fzIP/9lunMCtx9Fa0wc17BM+ocvcmpvC2jS4w0zJwlY3C98sT
         3cqYir+Incl8C3yiLe1LsIrUWfEgMNQN5yxkOyFo=
Date:   Fri, 26 May 2023 17:41:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "# 3.4.x" <stable@vger.kernel.org>,
        "Lopez, Jorge A (Security)" <jorge.lopez2@hp.com>
Subject: Re: [linux-stable-rc:queue/5.15 105/106]
 drivers/platform/x86/hp/hp-wmi.c:342:24: warning: cast to smaller integer
 type 'enum hp_wmi_radio' from 'void *'
Message-ID: <2023052620-unrefined-strobe-da13@gregkh>
References: <202305210504.yw7qgOom-lkp@intel.com>
 <MW4PR84MB19703614A2DB230AD0BAF63CA8409@MW4PR84MB1970.NAMPRD84.PROD.OUTLOOK.COM>
 <CAKwvOdnjXD4K6284znWQ7FdshZFYdqNUTN4U79h1pA+xPJ6vCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdnjXD4K6284znWQ7FdshZFYdqNUTN4U79h1pA+xPJ6vCA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 23, 2023 at 11:55:54AM -0700, Nick Desaulniers wrote:
> On Tue, May 23, 2023 at 11:31 AM Lopez, Jorge A (Security)
> <jorge.lopez2@hp.com> wrote:
> >
> > I investigate the compile failure and appears the latest patch reverted the code to an older version.
> > The latest code shows the proper implementation and compiling the code does not report any failures.
> >
> >             enum hp_wmi_radio r = (long)data;
> >
> > instead of
> >
> >                enum hp_wmi_radio r = (enum hp_wmi_radio) data;
> 
> Looks like
> commit ce95010ef62d ("platform/x86: hp-wmi: Fix cast to smaller
> integer type warning")
> 
> is the fixup necessary for 5.15.y.
> 
> Dear stable kernel maintainers, please consider cherry-picking the
> above commit to linux-5.15.y to avoid the new compiler diagnostic
> introduced by
> commit 6e9b8992b122 ("platform/x86: Move existing HP drivers to a new
> hp subdir")

Now queued up, thanks.

greg k-h
