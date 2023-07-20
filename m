Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02D675B776
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 21:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjGTTIK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 15:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjGTTH7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 15:07:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7F91BE2
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 12:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E88A961C1A
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 19:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC009C433D9;
        Thu, 20 Jul 2023 19:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689880077;
        bh=J9NbtqZA5IokkRv3z2ne8/DWfMLS5yr9ApZctoC3sAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z7pAFtVBx/abhLZ1QKb+t2xpy71rqE6kYMpoVmg+hBWPmDbsFIwCy+itvBTBTqcEC
         3xxSGKb24WhgclBkiisBsyoDd395aQtchC5JNtgkED6moEhEFEkZk/exZrzBPFXdYy
         DAZdjJQm12V7OfEycnxsqIopgztV3m+jl8UFRmjo=
Date:   Thu, 20 Jul 2023 21:07:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Reinhold Mannsberger <reinhold.mannsberger@gmx.at>
Cc:     stable@vger.kernel.org
Subject: Re: cannot mount device with write access with kernel versions >=
 4.20.0
Message-ID: <2023072026-village-cyclist-a4e2@gregkh>
References: <32933d9b5e1a46e4ec60189ea389e012a8fd65d6.camel@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32933d9b5e1a46e4ec60189ea389e012a8fd65d6.camel@gmx.at>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jul 20, 2023 at 08:55:50PM +0200, Reinhold Mannsberger wrote:
> Dear kernel developers!
> 
> Something unintended must have happened in kernel version 4.20.0.

4.20.0 is long end-of-life and not supported anymore at all.

What does the latest 5.4.y release show?

thanks,

greg k-h
