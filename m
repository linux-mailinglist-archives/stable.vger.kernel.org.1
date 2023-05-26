Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34B3712CEF
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 20:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243254AbjEZS6t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 14:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243671AbjEZS6s (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 14:58:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5620198
        for <stable@vger.kernel.org>; Fri, 26 May 2023 11:58:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D44965298
        for <stable@vger.kernel.org>; Fri, 26 May 2023 18:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75E1C433EF;
        Fri, 26 May 2023 18:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685127525;
        bh=LuO+2BJiNosMjkbK4fDQs2ihVslEgPpRQZiIowABKv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ysYJlGcPZEXxZ0oRwjaaJraIyWWhNulZ9Iry9w8t7s2NOOepQFmyzmfg7rEmvhzU3
         m3f/gzlVFnr64EKNS5Stc0FM2o9MLonz2h+67ZRIWfPLuUG5fXGXsk3w7QHv0s2iH6
         +OHfChmguWsVQx4dJS3oYgklMWqtjMXTwYUk85D0=
Date:   Fri, 26 May 2023 19:58:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     kernel test robot <lkp@intel.com>, Sasha Levin <sashal@kernel.org>,
        oe-kbuild-all@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [linux-stable-rc:queue/5.4 4610/23441]
 include/linux/compiler.h:350:45: error: call to '__compiletime_assert_215'
 declared with attribute error: FIELD_GET: mask is not constant
Message-ID: <2023052621-raisin-clergyman-47ff@gregkh>
References: <202305210701.TND2uZBJ-lkp@intel.com>
 <07135e22-253f-cfdc-dbba-0e5e670c25e9@oracle.com>
 <e542a9ea-8276-16c7-9319-0bf835f923df@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e542a9ea-8276-16c7-9319-0bf835f923df@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 23, 2023 at 03:45:29PM +0200, Vegard Nossum wrote:
> 
> On 5/23/23 15:37, Vegard Nossum wrote:
> > 
> > On 5/21/23 02:12, kernel test robot wrote:
> > > Hi Vegard,
> > > 
> > > FYI, the error/warning still remains.
> > > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > > queue/5.4
> > > head:   9b5924fbde0d84c8b30d7ee297a08ca441a760de
> > > commit: 3910babeac1ab031f4e178042cbd1af9a9a0ec51 [4610/23441]
> > > compiler.h: fix error in BUILD_BUG_ON() reporting
> > > config: sparc64-randconfig-c44-20230521
> > > compiler: sparc64-linux-gcc (GCC) 12.1.0
> [...]
> 
> > I'm not sure why this flags my patch as the culprit.
> > 
> > I just tried this (with the supplied config):
> > 
> > git checkout stable/linux-5.4.y
> > git revert 3910babeac1ab031f4e178042cbd1af9a9a0ec51 # revert my patch
> > make drivers/net/wireless/mediatek/mt76/mt7615/mac.o
> > 
> > and it still outputs the same error.
> > 
> > The FIELD_GET() call was added in bf92e76851009 and seems to have been
> > broken from the start as far as I can tell? If I checkout bf92e76851009^
> > then it builds, if I checkout bf92e76851009 then it fails.
> > 
> > Should we just redefine to_rssi() as a macro so it actually passes the
> > field as a literal/constant?
> 
> Ah, there is a mainline patch that fixes this, doing exactly that:
> 
> commit f53300fdaa84dc02f96ab9446b5bac4d20016c43
> Author: Pablo Greco <pgreco@centosproject.org>
> Date:   Sun Dec 1 15:17:10 2019 -0300
> 
>     mt76: mt7615: Fix build with older compilers
> [...]
> 
> -static inline s8 to_rssi(u32 field, u32 rxv)
> -{
> -       return (FIELD_GET(field, rxv) - 220) / 2;
> -}
> +#define to_rssi(field, rxv)            ((FIELD_GET(field, rxv) - 220) / 2)
> 
> Greg, Sasha, does it make sense to pick that for 5.4 (as it doesn't seem
> to be in there) to shut up the kernel test robot?
> 
> If so, should we add this to the changelog as well?

The changelog says it already, so now queued up :)

thanks,

greg k-h
