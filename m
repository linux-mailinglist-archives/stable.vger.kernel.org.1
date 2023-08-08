Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5595F7745C3
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 20:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbjHHSqJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 14:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjHHSpm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 14:45:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45C4C4446A
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 09:46:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A8ED153B;
        Tue,  8 Aug 2023 03:50:03 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78FEA3F59C;
        Tue,  8 Aug 2023 03:49:19 -0700 (PDT)
Date:   Tue, 8 Aug 2023 11:49:17 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        clang-built-linux <llvm@lists.linux.dev>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: stable-rc 5.15: clang-17: drivers/firmware/arm_scmi/smc.c:39:6:
 error: duplicate member 'irq'
Message-ID: <ZNIdrd+SQ0KjYWKA@e120937-lin>
References: <CA+G9fYvPn4N6yPEQauHLXw22AWihQFxyA=twQMDCEwDjXZyYAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvPn4N6yPEQauHLXw22AWihQFxyA=twQMDCEwDjXZyYAg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 08, 2023 at 11:59:22AM +0530, Naresh Kamboju wrote:
> LKFT build plans upgraded to clang-17 and found this failure,
> 
> While building stable-rc 5.15 arm with clang-17 failed with below
> warnings and errors.
> 
> Build log:
> ----------
> 
> drivers/firmware/arm_scmi/smc.c:39:6: error: duplicate member 'irq'
>    39 |         int irq;
>       |             ^
> drivers/firmware/arm_scmi/smc.c:34:6: note: previous declaration is here
>    34 |         int irq;
>       |             ^
> drivers/firmware/arm_scmi/smc.c:118:20: error: use of undeclared
> identifier 'irq'
>   118 |                 scmi_info->irq = irq;
>       |                                  ^
> 2 errors generated.
> 
>   Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.124-80-g6a5dd0772845/testrun/18864721/suite/build/test/clang-lkftconfig/log
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.124-80-g6a5dd0772845/testrun/18864721/suite/build/test/clang-lkftconfig/details/
> 

Hi Naresh and Sasha,

so this fix (unluckily) applies cleanly to v5.15 but fails to build since the
logic and code around it was different in v5.15.

While looking at backporting it properly, though, I realized that the fix is
NOT needed really in v5.15 due to the different context and logic, so I ask you
to DROP this fix in v5.15.

I suppose the patch has been automatically applied because the Fixes referred
a commit that was on v5.15 too since some of those lines were indeed impacted
and were present also in later versions, but the logic around it has
changed afterwards, so the original code (up to v5.17) was not really affected
by the bug addressed by this fix...only later versions from v5.18 (included)
onwards needs it.

Moreover note that the whole SMC ISR logic was introduced in v5.12 (and was
good up to v5.17 as said) so v5.15 is really the only stable release that needs
to drop this fix.

Thanks and sorry for the noise,
Cristian

> 
> Steps to reproduce:
>  tuxmake --runtime podman --target-arch arm --toolchain clang-17
> --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2TeTE3iE8aq4t1kv169LcMmd9jo/config
> LLVM=1 LLVM_IAS=1
> 
>   Links:
>     - https://storage.tuxsuite.com/public/linaro/lkft/builds/2TeTE3iE8aq4t1kv169LcMmd9jo/tuxmake_reproducer.sh
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
