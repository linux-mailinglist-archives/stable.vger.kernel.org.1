Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8434C6F8EBE
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 07:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjEFFvS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 01:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjEFFvS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 01:51:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335FE7ECF
        for <stable@vger.kernel.org>; Fri,  5 May 2023 22:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7911615CE
        for <stable@vger.kernel.org>; Sat,  6 May 2023 05:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35811C433D2;
        Sat,  6 May 2023 05:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683352276;
        bh=2dGA+9GNL+w9+PbpanVdxieKf9UF6ZG3Oqyrankg9MA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xppzz/no5GQ7vQn2vBw+xAWjotLGqKvyxDwgEZp+BdeQwUIlJhH1lTW1I+ZgIocLL
         DsaRqNpfPj/M8tihsMRc3eTx+Wu6OlHvchN3PaIEuYAV5h7FV2pLv/XwRvewley9ir
         FeOI7f5zXkC+5IDbjaB5dNtOegh+QTjZZ72t2G34=
Date:   Sat, 6 May 2023 09:53:43 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Mediatek mt76 issue
Message-ID: <2023050634-word-dazzler-d2c7@gregkh>
References: <d0503264-3443-ec6e-c68a-b1768a9e8c1d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0503264-3443-ec6e-c68a-b1768a9e8c1d@amd.com>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Apr 28, 2023 at 09:13:46PM -0500, Mario Limonciello wrote:
> Hi,
> 
> A number of laptops with Mediatek wifi the wifi doesn't work unless you turn
> off fast boot in BIOS setup.
> 
> These laptops all ship with fast boot as the default.
> 
> 
> It's been fixed by this commit:
> 
> 09d4d6da1b65 ("wifi: mt76: mt7921e: Set memory space enable in PCI_COMMAND
> if unset")
> 
> 
> Can you please bring it to 5.15.y and later?

Now queued up, thanks.

greg k-h
