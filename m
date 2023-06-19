Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E297351B5
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjFSKN1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjFSKN0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:13:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0B2E58
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:13:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49127601CD
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD82C433C9;
        Mon, 19 Jun 2023 10:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687169604;
        bh=hmQUKy5IuyvjCAgiKjERz/hug/kEYLdHzB9muQiwQFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+AyK2U/KzrdibBdG29fT/PaR7CmmxJIKgA8ldr4peQeZFUEdO1RETuoiv9O9JYhX
         rvOiErh3g3x000m4xPTkRP14KsU2/dd0BNch9NBT6IM22uHntKwC7mXHEUTHSs0llW
         O3lv4yk09PJ5UUP8mTung5bTvBzV3mOiYuqWjnR0=
Date:   Mon, 19 Jun 2023 12:13:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     stable@vger.kernel.org
Subject: Re: 5.10: fixing b58294ce1a8a ("um: Allow PM with suspend-to-idle")
Message-ID: <2023061915-stabilize-renovator-9d9f@gregkh>
References: <c2d46fa2647e616a4e2352479619cd0a0b5a14b6.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2d46fa2647e616a4e2352479619cd0a0b5a14b6.camel@sipsolutions.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 19, 2023 at 10:41:50AM +0200, Johannes Berg wrote:
> Hi,
> 
> Not sure why this was backported in the first place, but if so you'd
> also need 1fb1abc83636 ("um: Fix build w/o CONFIG_PM_SLEEP").
> 
> I think b58294ce1a8a ("um: Allow PM with suspend-to-idle") should just
> be reverted, but picking up the fix for it also works.
> 
> Robot keeps reporting to me that it's broken :)

THanks, now queued up.

greg k-h
