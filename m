Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC30726004
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 14:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240772AbjFGMsi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 08:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241075AbjFGMsS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 08:48:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7BE26B3
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 05:47:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FEAF63EE6
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 12:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BC3C433EF;
        Wed,  7 Jun 2023 12:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686142049;
        bh=aEVqFgqEC2f+uMA0F6TlvdQGKSiy7XN/8zg1kISBuWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sn+cbIqKWltyXtjLnmOnWJ3XE0SyGCRWZgasQNuwy62Kc5L69zpq0VKyYqJyR02tI
         boxT6J51t9VISQZOYaBb2N/pYEHAfEuUxOmwXWIXhhmSRRfh+gr77elKUeK20n7XNz
         1uOcz5hZ/8/qnUMCTi1V/G0qFuyUaRqUJY1CToPk=
Date:   Wed, 7 Jun 2023 14:47:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     stable@vger.kernel.org
Subject: Re: [6.1.y] Please apply 98bea253aa28ad8be2ce565a9ca21beb4a9419e5
Message-ID: <2023060719-tacky-grief-e8c6@gregkh>
References: <23bb697e-c965-8321-f648-03f804853cdb@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23bb697e-c965-8321-f648-03f804853cdb@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 01, 2023 at 05:17:54PM -0400, Luiz Capitulino wrote:
> 
> It fixes CVE-2022-48425 and is applied to 5.15.y and 6.3.y. I quickly tested
> the commit by mounting an NTFS partition and building a kernel in it.
> 
> """
> commit 98bea253aa28ad8be2ce565a9ca21beb4a9419e5
> Author: Edward Lo <edward.lo@ambergroup.io>
> Date:   Sat Nov 5 23:39:44 2022 +0800
> 
>     fs/ntfs3: Validate MFT flags before replaying logs
> """

Now queued up, thanks.

greg k-h
