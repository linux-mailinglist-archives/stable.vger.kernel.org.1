Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE473D536
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 01:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjFYXQa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 25 Jun 2023 19:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjFYXQ3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 25 Jun 2023 19:16:29 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71DD8E51
        for <stable@vger.kernel.org>; Sun, 25 Jun 2023 16:16:26 -0700 (PDT)
Date:   Mon, 26 Jun 2023 01:16:23 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: Inconsistency about backports to stable series for 6e1acfa387b9
 ("netfilter: nf_tables: validate registers coming from userspace.")?
Message-ID: <ZJjKxyKJLc12BUEi@calendula>
References: <ZJhYcEqINyrKpCWV@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJhYcEqINyrKpCWV@eldamar.lan>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Sun, Jun 25, 2023 at 05:08:32PM +0200, Salvatore Bonaccorso wrote:
> Hi Pablo,
> 
> While checking netfilter backports to the stable series, I noticed
> that 6e1acfa387b9 ("netfilter: nf_tables: validate registers coming
> from userspace.") was backported in various series for stable, and
> included in 4.14.316, 4.19.284, 5.4.244, 5.15.32, 5.16.18, 5.17.1,
> where the original fix was in 5.18-rc1.
> 
> While the commit has 
> 
> Fixes: 49499c3e6e18 ("netfilter: nf_tables: switch registers to 32 bit addressing")
> 
> the 6e1acfa387b9 change got not backported to the 5.10.y series.
> 
> The backports to the other series are
> 
> https://lore.kernel.org/stable/20230516151606.4892-1-pablo@netfilter.org/
> https://lore.kernel.org/stable/20230516150613.4566-1-pablo@netfilter.org/
> https://lore.kernel.org/stable/20230516144435.4010-1-pablo@netfilter.org/
> 
> Pablo, was this an oversight and can the change as well be applied to
> 5.10.y?
> 
> From looking at the 5.4.y series, from the stable dependencies,
> 08a01c11a5bb ("netfilter: nftables: statify nft_parse_register()") is
> missing in 5.10.y, then 6e1acfa387b9 ("netfilter: nf_tables: validate
> registers coming from userspace.") can be applied (almost, the comment
> needs to be dropped, as done in the backports).
> 
> I'm right now not understanding what I'm missing that it was for 5.4.y
> but not 5.10.y after the report of the failed apply by Greg.
> 
> At least the two attached bring 5.10.y inline with 5.4.y up to 4) from
> https://lore.kernel.org/stable/20230516144435.4010-1-pablo@netfilter.org/
> but I'm unsure if you want/need as well the remaining 5), 6), 7), 8)
> and 9).

Let me take a look, I can prepare a batch for 5.10.y based on 5.4.y as
you suggest. I'll keep you on Cc.
