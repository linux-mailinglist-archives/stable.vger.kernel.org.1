Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CBC734539
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 09:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjFRHTx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 03:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFRHTx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 03:19:53 -0400
X-Greylist: delayed 464 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Jun 2023 00:19:50 PDT
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A9210D
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 00:19:50 -0700 (PDT)
Message-ID: <877711f8-3cdd-c9d8-bc0c-fb3cc827f9f8@0.smtp.remotehost.it>
Date:   Sun, 18 Jun 2023 09:12:00 +0200
MIME-Version: 1.0
Subject: Re: stable-rc-5.4.y: arch/mips/kernel/cpu-probe.c:2125:9: error:
 duplicate case value 2125 case PRID_COMP_NETLOGIC
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CA+G9fYueU5joKgRRgLgfBaRTx93B71UXMyueNR_NeA_HZTsvFQ@mail.gmail.com>
Content-Language: en-US, de-DE, lb-LU, fr-FR
From:   Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <CA+G9fYueU5joKgRRgLgfBaRTx93B71UXMyueNR_NeA_HZTsvFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[2023-06-18 07:28] Naresh Kamboju:
> Following regressions found on stable rc 5.4 while building MIPS configs,
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> MIPS: Restore Au1300 support
> [ Upstream commit f2041708dee30a3425f680265c337acd28293782 ]
> 
> 
> Build log:
> ======
> arch/mips/kernel/cpu-probe.c: In function 'cpu_probe':
> arch/mips/kernel/cpu-probe.c:2125:9: error: duplicate case value
>   2125 |         case PRID_COMP_NETLOGIC:
>        |         ^~~~
> arch/mips/kernel/cpu-probe.c:2099:9: note: previously used here
>   2099 |         case PRID_COMP_NETLOGIC:
>        |         ^~~~
> make[3]: *** [scripts/Makefile.build:262: arch/mips/kernel/cpu-probe.o] Error 1

The same issue also affects both the 5.10 and the 5.15 branch.


Regards
Pascal
