Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861F67A2FBC
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 13:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbjIPLjR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 07:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjIPLiu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 07:38:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70065CC4
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 04:38:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD0DC433C8;
        Sat, 16 Sep 2023 11:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694864325;
        bh=7HK9Qrc/+rki+2NflRZOa/g8evtNTGET9jTny9ajXp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hhoKXE2Ao0bZaU24xJWpzmQlqkx0/qyd9oVB4fgDIS8EB1NapgEBmMAvvZQlLPni7
         KsOC58aw20bjkAftvzUUheBRYFK24E8OO93jA1wtEdgZ4BrG/Umb1kSfSOiEy02rab
         n0vT5UBZjgSXaR+Wr7ANrHms9psWjRqEBA0CkaG4=
Date:   Sat, 16 Sep 2023 13:38:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yoann Congal <yoann.congal@smile.fr>
Cc:     stable@vger.kernel.org
Subject: Re: Please apply "watchdog: advantech_ec_wdt: fix Kconfig
 dependencies" to 6.5.y
Message-ID: <2023091633-cobbler-goldmine-f3e0@gregkh>
References: <4cddacd0-37bc-ec7b-1ba2-bb41a9d3eb8d@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cddacd0-37bc-ec7b-1ba2-bb41a9d3eb8d@smile.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 13, 2023 at 11:20:26PM +0200, Yoann Congal wrote:
> Hi,
> 
> Can you please apply "watchdog: advantech_ec_wdt: fix Kconfig dependencies" to the 6.5.y branch?
> commit 6eb28a38f6478a650c7e76b2d6910669615d8a62 upstream.
> 
> This patch fixes a configuration bug in the advantech_ec_wdt (Advantech Embedded Controller Watchdog) driver where it can be compiled into a noop driver.
> I come at the Debian kernel maintainer suggestion following my attempt at adding this driver to their kernel [0].

Now applied, thanks.

greg k-h
