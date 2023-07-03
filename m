Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA69D745992
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 12:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjGCKEk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 06:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjGCKEQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 06:04:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6E819A1
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 03:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3292860E75
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 10:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4400DC433C7;
        Mon,  3 Jul 2023 10:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688378563;
        bh=pSNfSIIOb4ZKqOMQEnJnIbxoercou0jXFPcNNcBTu7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=usR3Ze5ULeh3lOdrcFNFbqHEHOoUOxlEe7I2otACCqOPfkNzRxD9J6vafeVv9wVXx
         y/eOF5eEBoSnkNcQuuE+fi9vFHa/b5Vp1KCL9IohNDjUpbjDmHodSiCDyWro4EYwac
         qQYrnD/SoD3/V2xoNIxEpNB7IaCYvJ09PZ65YAsI=
Date:   Mon, 3 Jul 2023 12:02:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 6.3 02/29] mm/mmap: Fix error return in
 do_vmi_align_munmap()
Message-ID: <2023070340-alibi-monsoon-e6b6@gregkh>
References: <20230629184151.705870770@linuxfoundation.org>
 <20230629184151.812335573@linuxfoundation.org>
 <aec8346199e1128f4608ffef6882652938cca5fe.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aec8346199e1128f4608ffef6882652938cca5fe.camel@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 03, 2023 at 10:23:59AM +0100, David Woodhouse wrote:
> On Thu, 2023-06-29 at 20:43 +0200, Greg Kroah-Hartman wrote:
> > From: David Woodhouse <dwmw@amazon.co.uk>
> > 
> > commit 6c26bd4384da24841bac4f067741bbca18b0fb74 upstream,
> > 
> > If mas_store_gfp() in the gather loop failed, the 'error' variable that
> > ultimately gets returned was not being set. In many cases, its original
> > value of -ENOMEM was still in place, and that was fine. But if VMAs had
> > been split at the start or end of the range, then 'error' could be zero.
> > 
> > Change to the 'error = foo(); if (error) goto â€¦' idiom to fix the bug.
> 
> Hrm, that isn't what the original commit message said. It said:
> 
> > Change to the 'error = foo(); if (error) goto …' idiom to fix the bug.
> 
> This far into the 21st century, we don't see a lot of tools injecting
> Mojibake any more; the mantra of "everything is UTF-8, all of the time"
> mostly seems to work.
> 
> Granted, there are more important problems in the world, but it'd be
> good to identify where that happened and file bugs if needed.

This is probably due to me going from 'git format-patch' to 'quit
import' and then to 'git am' as part of the workflow I use here.  I'll
try to narrow it down as to where this went wrong...

thanks,

greg k-h
