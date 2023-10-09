Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735C17BE8D4
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 20:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377392AbjJISCS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 14:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376857AbjJISCS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 14:02:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF5091
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 11:02:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE38C433C7;
        Mon,  9 Oct 2023 18:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696874536;
        bh=KfxjDjrzZwmljYd4jzkGm62ENsuvdGmEdT4z4hPQpX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D23IlfF6pMw3RxEcn9I4wmkLXI8KOJdDxMfrrpzd5bHFqW3QX4MN60sTsWV4Q1hyl
         OWn8DewmDGyYE4Bk3QInF1LTeBWLMKSYibie2kUhzWgQH9CHxJqOfbt65ebP1HDbYi
         iuGEEnHfhYg5YybU/Vkqj2uaS2daq0AbGACR9m4s=
Date:   Mon, 9 Oct 2023 20:02:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Marco Felsch <m.felsch@pengutronix.de>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 5.4 038/131] clk: imx: pll14xx: dynamically configure PLL
 for 393216000/361267200Hz
Message-ID: <2023100901-rocket-catchable-8a26@gregkh>
References: <20231009130116.329529591@linuxfoundation.org>
 <20231009130117.474995235@linuxfoundation.org>
 <fc5955b8-7c4d-620c-9960-0ff644192fb3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc5955b8-7c4d-620c-9960-0ff644192fb3@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 09, 2023 at 04:01:46PM +0200, Ahmad Fatoum wrote:
> Hello Greg,
> 
> On 09.10.23 15:01, Greg Kroah-Hartman wrote:
> > 5.4-stable review patch.  If anyone has any objections, please let me know.
> 
> As mentioned before[1][2], this is not v5.4 stable material.
> 
> Please drop from your queue for all releases older than v5.18.
> 
> [1]: https://lore.kernel.org/all/6e3ad25c-1042-f786-6f0e-f71ae85aed6b@pengutronix.de/
> [2]: <a76406b2-4154-2de4-b1f5-43e86312d487@pengutronix.de>

Now dropped, thanks and sorry for the confusion.

greg k-h
