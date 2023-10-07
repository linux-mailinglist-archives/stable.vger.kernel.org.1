Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DE27BC694
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 11:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343778AbjJGJ6R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 05:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343767AbjJGJ6Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 05:58:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F31B9
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 02:58:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7234CC433C8;
        Sat,  7 Oct 2023 09:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696672694;
        bh=HV4NHF3XeCveBBsadmZtfxD7TAZ19Exe/fQMmYqy0RI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOlnF8IsYi31IQpVRKNbE8WTbHJaETzZnMbO2jbnmgV/XHCqi5Es+RSiQ+ToMJd/k
         nCHF+rgyHXOW8QFce9LFP0sVadrsNZuqYR/ZWu6Y+gfnucWseIcFj2bja6kEbkmOH/
         B5qqlm64vX+9r+h1R7xKDp2m6DjtmbGwFLWfvj6o=
Date:   Sat, 7 Oct 2023 11:58:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     nobuhiro1.iwamatsu@toshiba.co.jp
Cc:     niklas.cassel@wdc.com, stable@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH 4.14.y] ata: libata: disallow dev-initiated LPM
 transitions to unsupported states
Message-ID: <2023100748-untimely-aloft-3f5a@gregkh>
References: <2023092002-mobster-onset-2af9@gregkh>
 <20230928155357.9807-1-niklas.cassel@wdc.com>
 <TYCPR01MB9418B505FA508B884166798192C0A@TYCPR01MB9418.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB9418B505FA508B884166798192C0A@TYCPR01MB9418.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 29, 2023 at 07:27:05AM +0000, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi!
> 
> You have forgotten the upstream commit ID.
> And there is a message of cherry-pick -x. This is not necessary.
> Could you please add commit ID and remove cherry-pick message?
> 
> commit 24e0e61db3cb86a66824531989f1df80e0939f26 upstream.

As pointed out, the cherry-pick message is just fine, the documentation
was being followed properly, so all is good.

thanks,

greg k-h
