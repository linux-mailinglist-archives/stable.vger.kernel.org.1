Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F147ABEE8
	for <lists+stable@lfdr.de>; Sat, 23 Sep 2023 10:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjIWI2a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 23 Sep 2023 04:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjIWI22 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 23 Sep 2023 04:28:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D46C19E
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 01:28:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F5DC433C7;
        Sat, 23 Sep 2023 08:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695457702;
        bh=cXYllov6kwwjbsZToxpPEImhIzItaoo6s+C0oXgoYtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AVHkhWie5TxAG8s6ZWh8m1ws6syV9uvAWgY8N8D3+hvfF5YtP1qvaq5GdpIclLa/j
         LRbyQcoS1siQso9AptdqUwdRZih/s9dZGeo7LugvIMTPJ+kRzd7vBuJU8fdeT15Oed
         VhVXh6wgFppxpKlXJyp69mdQqCC9O9TDs8wn+v9Q=
Date:   Sat, 23 Sep 2023 10:28:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Marco Felsch <m.felsch@pengutronix.de>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 5.4 296/367] clk: imx: pll14xx: dynamically configure PLL
 for 393216000/361267200Hz
Message-ID: <2023092310-shuffle-wildlife-0784@gregkh>
References: <20230920112858.471730572@linuxfoundation.org>
 <20230920112906.208711780@linuxfoundation.org>
 <6e3ad25c-1042-f786-6f0e-f71ae85aed6b@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e3ad25c-1042-f786-6f0e-f71ae85aed6b@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 21, 2023 at 09:03:09AM +0200, Ahmad Fatoum wrote:
> On 20.09.23 13:31, Greg Kroah-Hartman wrote:
> > 5.4-stable review patch.  If anyone has any objections, please let me know.
> 
> [snip]
> 
> > Cc: stable@vger.kernel.org # v5.18+
> 
> Objection: This fix is only applicable starting with v5.18, as before
> commit b09c68dc57c9 ("clk: imx: pll14xx: Support dynamic rates"), there
> was no dynamic rate calculation that would substitute the hardcoded
> parameters removed by my patch.

Ok, thanks, now dropped.

greg k-h
