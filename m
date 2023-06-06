Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5867248E0
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 18:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjFFQWL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 12:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbjFFQWL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Jun 2023 12:22:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D3210C2
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 09:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 358BE62D9D
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 16:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CF8C4339B;
        Tue,  6 Jun 2023 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686068527;
        bh=pJPs4ZvhoOlY9PHI2w863um9uEuLq/rzDD1lSauZotk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TC7++sKnboUCfCsj3iruVHhemQTWBwOJw6St/6/neORlK5KUHLVeb62UiP8qoHFSt
         FA+4H4s3wCWIODFPxO5ANKUURaAK/zrPcO688DWDaiH8Ee/j1sJLN6X7iRWbvam8tb
         31jPsOijRUBBt6oER4agEQQDSzXRHzvxfwvP8b9Y=
Date:   Tue, 6 Jun 2023 18:22:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     stable@vger.kernel.org, edward.lo@ambergroup.io,
        almaz.alexandrovich@paragon-software.com
Subject: Re: [6.1.y] Please apply 98bea253aa28ad8be2ce565a9ca21beb4a9419e5
Message-ID: <2023060624-repave-audience-bfd5@gregkh>
References: <23bb697e-c965-8321-f648-03f804853cdb@amazon.com>
 <61f6d16a-cf0b-9c25-a148-ccf99b6bd77f@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61f6d16a-cf0b-9c25-a148-ccf99b6bd77f@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 06, 2023 at 10:56:34AM -0400, Luiz Capitulino wrote:
> 
> 
> On 2023-06-01 17:17, Luiz Capitulino wrote:
> > 
> > It fixes CVE-2022-48425 and is applied to 5.15.y and 6.3.y. I quickly tested
> > the commit by mounting an NTFS partition and building a kernel in it.
> 
> Humble ping?

5 days later?  Please give us a chance to catch up...

> > """
> > commit 98bea253aa28ad8be2ce565a9ca21beb4a9419e5
> > Author: Edward Lo <edward.lo@ambergroup.io>
> > Date:   Sat Nov 5 23:39:44 2022 +0800
> > 
> >      fs/ntfs3: Validate MFT flags before replaying logs

And really, ntfs?  For an issue that was fixed last year?  What's the
rush?  :)

thanks,

greg k-h
