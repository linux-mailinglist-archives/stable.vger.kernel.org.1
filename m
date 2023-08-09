Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595ED77541B
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 09:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjHIH32 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 03:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjHIH3J (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 03:29:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E461B2724
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 00:28:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 539EC62678
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 07:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7FDC433C8;
        Wed,  9 Aug 2023 07:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691566092;
        bh=Oz829amcM0VaXMZxxv8PY/aExFtAXV2HlovqvJZeJDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1HE5RMOEGt2sDioatkCkRKOzxuDpmknLglafqtHwBONQ7bFCAZI/qQAyf634UD2Ai
         5d7uUqGEx10xOjM3luvtvIPOJm3wyg+TdyJPIocxYsYgWvCxyTGg2dikcV/pBTRXo6
         IxawXkCKirB7n8FcmsMtGtnyd2zZgOiIrbLwPb8s=
Date:   Wed, 9 Aug 2023 09:28:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: stable-rc: 4.19: i386: build warnings / errors
Message-ID: <2023080953-boxcar-dart-6ac7@gregkh>
References: <CA+G9fYt86w3Z+XeZjbjcOq_hvpkx=uUZS3ecH_nQGfBn9KaX3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYt86w3Z+XeZjbjcOq_hvpkx=uUZS3ecH_nQGfBn9KaX3A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 09, 2023 at 12:44:00PM +0530, Naresh Kamboju wrote:
> LKFT build plans updated with toolchain gcc-13 and here is the report.
> 
> While building Linux stable rc 4.19 i386 with gcc-13 failed due to
> following warnings / errors.

I'm amazed that this is all the issues you found, I gave up due to all
of the build issues.

If you care about 4.19 (and any other kernel tree) with newer compilers,
I will gladly take patches/backports for these issues.  But to just
report them like this isn't going to get very far as I doubt anyone who
actually uses 4.19 will ever use gcc-13.

thanks,

greg k-h
