Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A397A4E93
	for <lists+stable@lfdr.de>; Mon, 18 Sep 2023 18:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjIRQTh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 18 Sep 2023 12:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjIRQTX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 18 Sep 2023 12:19:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B8810F4
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 09:05:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE133C43142;
        Mon, 18 Sep 2023 15:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695050583;
        bh=DfVuowvxHtRn/NY0EmQQpxPaUhKlE/r7QxRxZOoR1pY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4PIBl169c0rVGuEKXxjT8b8XxqMU43wsoj4ubUbvYYrKmbxjtQ9wOLQ8pGsUu4sr
         9cQ2li+lGn+xkI34plQ7bG8Nzjlf8AA0TKpLKCVc4mo7u2MhGXLjEBI0Ry8cFNJG9t
         VzbWuyXI7E8oQ0JUhw2lCG0r/78k6mwIz/Aixwr8=
Date:   Mon, 18 Sep 2023 17:22:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 261/406] leds: Fix BUG_ON check for
 LED_COLOR_ID_MULTI that is always false
Message-ID: <2023091836-papaya-jackknife-2867@gregkh>
References: <20230917191101.035638219@linuxfoundation.org>
 <20230917191108.094879104@linuxfoundation.org>
 <20230918160004.3511ae2e@dellmb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230918160004.3511ae2e@dellmb>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 18, 2023 at 04:00:04PM +0200, Marek Behún wrote:
> Greg, please drop this patch from both 5.10 and 5.15.
> 
> Reference: 
>   https://lore.kernel.org/linux-leds/ZQLelWcNjjp2xndY@duo.ucw.cz/T/

But this is already in released kernels:
	6.1.53 6.4.16 6.5.3 6.6-rc1

> I am going to send a fix to drop the check altogether.

We will be glad to queue up the fix as well when it hits Linus's tree,
please be sure to tag it for stable backporting so we can get it in all
locations.

But for now, being bug-compatible makes more sense, right?  Or is this
really critical and should not be in these kernels now?

thanks,

greg k-h
