Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FD97DD5F1
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 19:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjJaSRW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 14:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjJaSRW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 14:17:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C50EA;
        Tue, 31 Oct 2023 11:17:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9DFC433C8;
        Tue, 31 Oct 2023 18:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698776231;
        bh=3jBqMDrmerEfrbEtffe4NTO+Buy4E+xaOdV/4wYeNwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3nVvWZkB5UwbESsbove9WNCSh5tgc1jCzoPUBBBnPZSuNpuAjUYsA9w9spXZRuNE
         F36ZCJZY5ZzSF9XppsMXqjuIqdwds2e8eLOeWYTYc6mz/UepbgsaX/NsWH4s51Gb0E
         xRkpnJ/6vL7s82LXYmq+2P93XHTaQjXogyCYtgHI=
Date:   Tue, 31 Oct 2023 18:48:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Barker <paul.barker.ct@bp.renesas.com>
Cc:     stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Luis Machado <luis.machado@arm.com>, linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 4.14] ata: ahci: fix enum constants for gcc-13
Message-ID: <2023103125-public-resilient-cc46@gregkh>
References: <20231031173255.28666-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031173255.28666-1-paul.barker.ct@bp.renesas.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 31, 2023 at 05:32:55PM +0000, Paul Barker wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> commit f07788079f515ca4a681c5f595bdad19cfbd7b1d upstream.
> 
> gcc-13 slightly changes the type of constant expressions that are defined
> in an enum, which triggers a compile time sanity check in libata:

Does gcc-13 actually work for these older stable kernels yet?  Last I
tried there were a bunch of issues.  I'll gladly take these, just
wondering what the status was and if there are many more to go.

thanks,

greg k-h
