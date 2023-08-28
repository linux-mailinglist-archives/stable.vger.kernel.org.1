Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38E978A60B
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 08:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjH1GrK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 02:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjH1Gqp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 02:46:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CFD122
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 23:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED1DB60F8A
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 06:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F404CC433CA;
        Mon, 28 Aug 2023 06:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693205202;
        bh=LUzQXsrCsZa8rZ3OOxpbPkDmZnxrdnHDCKbzeq0TxP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JstbaXSUMytGhnSgM9mrIFccGNglTv7kxgpIhOg8EzM1aneEtOLk+wP/xFo0u0NqS
         UwPtqkkZC6LDHVzW9tvGF7W7U9PaIRxW8bTwBHyLcxvX6nJCMfc8jz3emgEnJiOqV8
         LtE7oF/6Uv9WvetZPCwChS1QTOqu3E793wZQT0+Q=
Date:   Mon, 28 Aug 2023 08:46:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc:     stable@vger.kernel.org, Bernhard Landauer <bernhard@manjaro.org>
Subject: Re: 5.10.192 fails to build =?utf-8?B?KGVy?=
 =?utf-8?B?cm9yOiDigJhSVDcxMV9KRDJfMTAwSw==?= =?utf-8?B?4oCZ?= undeclared
 here (not in a function))
Message-ID: <2023082804-unnamable-papyrus-ab8e@gregkh>
References: <3dc52ac6-790b-42b7-949b-cc1aa6a54b5b@manjaro.org>
 <2023082729-charm-broom-6cfb@gregkh>
 <b8a8451e-675d-4766-a886-2ff01fad1493@manjaro.org>
 <d2cce7fe-7847-4689-b5bd-cceaeac0a2ab@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2cce7fe-7847-4689-b5bd-cceaeac0a2ab@manjaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 28, 2023 at 07:17:21AM +0200, Philip Müller wrote:
> Hi Greg,
> 
> Seems this needs to been backported too:
> 
> https://github.com/torvalds/linux/commit/8e6c00f1fdea9fdf727969d7485d417240d2a1f9
> 
> At least an #include "../../codecs/rt711.h" in
> sound/soc/intel/boards/sof_sdw.c

Now queued up, thanks.

And why are you the only one seeing this issue?  What odd config are you
using that none of the CI systems are catching this?

thanks,

greg k-h
