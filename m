Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CC37351A3
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjFSKKw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjFSKKi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:10:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423621704
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3122C60B3A
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21167C433C0;
        Mon, 19 Jun 2023 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687169389;
        bh=tmIQPEJn5JJ7xRjUXpJxn09Py3fs11G1viwI61ogbD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CqZxMCd2yZV8LW4/fnPdNLr/Wn7u719kKVbpeb9j50bRysn9LkXst840joKov0fhj
         TQhHalhSKrfpluiVIBsVEMBtUfxDgqB0l9ClzQdKWWx65Xj6ZfVr7Q/nKJmvr+yMEq
         oxEhcBaaYWr/6Yw5T1kAkiK/VWUsdiGmfuXyClQw=
Date:   Mon, 19 Jun 2023 12:09:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        lkft-triage@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
        Pascal Ernster <git@hardfalcon.net>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: stable-rc-5.4.y: arch/mips/kernel/cpu-probe.c:2125:9: error:
 duplicate case value 2125 case PRID_COMP_NETLOGIC
Message-ID: <2023061941-bribe-chewy-9dee@gregkh>
References: <CA+G9fYueU5joKgRRgLgfBaRTx93B71UXMyueNR_NeA_HZTsvFQ@mail.gmail.com>
 <877711f8-3cdd-c9d8-bc0c-fb3cc827f9f8@0.smtp.remotehost.it>
 <CA+G9fYu4O-2rdmwuri2GO5VRATw7xCN2x+MX1_Sq4TD18w_0gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYu4O-2rdmwuri2GO5VRATw7xCN2x+MX1_Sq4TD18w_0gw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 19, 2023 at 03:15:15PM +0530, Naresh Kamboju wrote:
> On Sun, 18 Jun 2023 at 12:42, Pascal Ernster <git@hardfalcon.net> wrote:
> >
> > [2023-06-18 07:28] Naresh Kamboju:
> > > Following regressions found on stable rc 5.4 while building MIPS configs,
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > MIPS: Restore Au1300 support
> > > [ Upstream commit f2041708dee30a3425f680265c337acd28293782 ]
> > >
> > >
> > > Build log:
> > > ======
> > > arch/mips/kernel/cpu-probe.c: In function 'cpu_probe':
> > > arch/mips/kernel/cpu-probe.c:2125:9: error: duplicate case value
> > >   2125 |         case PRID_COMP_NETLOGIC:
> > >        |         ^~~~
> > > arch/mips/kernel/cpu-probe.c:2099:9: note: previously used here
> > >   2099 |         case PRID_COMP_NETLOGIC:
> > >        |         ^~~~
> > > make[3]: *** [scripts/Makefile.build:262: arch/mips/kernel/cpu-probe.o] Error 1
> >
> > The same issue also affects both the 5.10 and the 5.15 branch.
> 
> MIPS builds are breaking on stable-rc 5.4, 5.10 and 5.15 branches.
> Due to following patch,
> ----
> 
> Subject: MIPS: Restore Au1300 support
> 
> [ Upstream commit f2041708dee30a3425f680265c337acd28293782 ]
> 
> The Au1300, at least the one I have to test, uses the NetLogic vendor
> ID, but commit 95b8a5e0111a ("MIPS: Remove NETLOGIC support") also
> dropped Au1300 detection.  Restore Au1300 detection.
> 
> Tested on DB1300 with Au1380 chip.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/mips/kernel/cpu-probe.c | 5 +++++
>  1 file changed, 5 insertions(+)

Ah, thanks, I'll go drop this now, for some reason I thought it already
was gone :(

greg k-h
