Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C516D78A0F9
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 20:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjH0S3u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 14:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjH0S3Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 14:29:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B816120
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 11:29:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1250861DEE
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 18:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1352FC433C7;
        Sun, 27 Aug 2023 18:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693160962;
        bh=htn4drkcYd9ql8o7nyTnkZOgRVs2cpE6Z6YF0yUo+Ik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zQFiL0rwau+OjkHdcjfT0VZxTpcIv4ogSF3CebwwQc7eail0yBRD1rS7M3aUoMNC4
         ZhK+4h8MRNFJaxw5jnQ8umVynTtdhnAE/vYkoD/c+WdNsB+kVSKZBNcz1nHv9yGyD/
         IIKtX5v9mWtSWkJPsL7VJ5SCMxSng9Zwf/aR25Jk=
Date:   Sun, 27 Aug 2023 20:29:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc:     stable@vger.kernel.org, Bernhard Landauer <bernhard@manjaro.org>
Subject: Re: 5.10.192 fails to build =?utf-8?B?KGVy?=
 =?utf-8?B?cm9yOiDigJhSVDcxMV9KRDJfMTAwSw==?= =?utf-8?B?4oCZ?= undeclared
 here (not in a function))
Message-ID: <2023082729-charm-broom-6cfb@gregkh>
References: <3dc52ac6-790b-42b7-949b-cc1aa6a54b5b@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3dc52ac6-790b-42b7-949b-cc1aa6a54b5b@manjaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Aug 26, 2023 at 10:36:41PM +0200, Philip Müller wrote:
> Hi Greg,
> 
> please revert the following two patches as 5.10.192 fails to build with
> them:
> 
> asoc-intel-sof_sdw-add-quirk-for-lnl-rvp.patch
> asoc-intel-sof_sdw-add-quirk-for-mtl-rvp.patch
> 
> Error message: error: ‘RT711_JD2_100K’ undeclared here (not in a function)
> 
> 2023-08-26T17:46:51.3733116Z sound/soc/intel/boards/sof_sdw.c:208:41: error:
> ‘RT711_JD2_100K’ undeclared here (not in a function)
> 2023-08-26T17:46:51.3744338Z   208 |                 .driver_data = (void
> *)(RT711_JD2_100K),
> 2023-08-26T17:46:51.3745547Z       |     ^~~~~~~~~~~~~~
> 2023-08-26T17:46:51.4620173Z make[4]: *** [scripts/Makefile.build:286:
> sound/soc/intel/boards/sof_sdw.o] Error 1
> 2023-08-26T17:46:51.4625055Z make[3]: *** [scripts/Makefile.build:503:
> sound/soc/intel/boards] Error 2
> 2023-08-26T17:46:51.4626370Z make[2]: *** [scripts/Makefile.build:503:
> sound/soc/intel] Error 2
> 
> This happened before already:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/queue-5.10?id=2e4795b45723de3d253f38bc57724d9512c737f5

{sigh}  Sorry about that.

I just backported commit 683b0df26c33 ("ASoC: rt711: add two jack
detection modes") instead, that should solve this issue and give more
support to that kernel tree if anyone is actually using it there (based
on me not geting any build errors from any CI systems for that driver, I
kind of doubt it...)

thanks,

greg k-h
