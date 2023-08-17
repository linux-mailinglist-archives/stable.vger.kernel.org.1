Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468CA77FB67
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 18:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351166AbjHQQAW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 12:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353428AbjHQQAD (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 12:00:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1184C30F1
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 09:00:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9933067514
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 16:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4EBC433C8;
        Thu, 17 Aug 2023 16:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692288001;
        bh=URfkQC6T1yRnRQwiIDvntMf2HUheMa6DnBprmeOIMCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ul0yyiEaTE8oWr3XybYQYLQQPYv9zUMygWGRNQysVJCPkhcHGefjVNotKfcqRxjPV
         RNnD9hmAGZy2EUwH5cK9cKVEkLY5M2gxSq0yfIVjAh92zmBU4fD7nzzqql4AnUGTtT
         SBhv8bJMMPP+B+SK8Hg1YUlCOMC1DJcM/6tVQxKg=
Date:   Thu, 17 Aug 2023 17:59:58 +0200
From:   'Greg KH' <gregkh@linuxfoundation.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "t.martitz@avm.de" <t.martitz@avm.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: proc_lseek backport request
Message-ID: <2023081729-strained-hatchback-41af@gregkh>
References: <OF964B0E9A.174E142D-ONC1258A0E.0032FEAA-C1258A0E.00337FA7@avm.de>
 <2023081752-giddily-anytime-237e@gregkh>
 <f98cf66371de47e6a0e87c5214ba2c22@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f98cf66371de47e6a0e87c5214ba2c22@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 17, 2023 at 03:42:02PM +0000, David Laight wrote:
> > Attempting to keep kernel code outside of the kernel tree is, on
> > purpose, very expensive in time and resources.  The very simple way to
> > solve this is to get your drivers merged properly into the mainline
> > kernel tree.
> 
> I've got some of those, you really wouldn't want them.

I would argue we do, but if you want to spend the extra time and money
keeping them out of the kernel, that's your choice to make.

> They are audio/telephony drivers for some very specific hardware.

As are almost all drivers in the kernel.  Your hardware is special and
unique, just like all others :)

thanks,

greg k-h
