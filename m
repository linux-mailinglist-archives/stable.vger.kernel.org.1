Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6121472BF14
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjFLKcO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbjFLKb5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:31:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597B47AA0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:13:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D009362319
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC59BC433EF;
        Mon, 12 Jun 2023 10:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686564068;
        bh=i75JOqJ7Lx/sirtFkEdFOHsCd/l5GFD+DbqPWvfuXAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hr1mfylhavogtT9eKP6ven4SL/6NSiBwMBZeZ3TnBp+Ixql8LxQeS8030uAgEev5+
         b4OP4mQBtdFUB1aqQ9vpA/cMFrWZzeEwjm9kJLPXu3eVm98vQhXuy7LeuJTTxNYvzq
         7u+q7U/1KHL2QTjBWfonXrRkPz6Id9v5/Oylbtg8=
Date:   Mon, 12 Jun 2023 12:01:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 6.3.y] wifi: rtw89: correct PS calculation for
 SUPPORTS_DYNAMIC_PS
Message-ID: <2023061255-disband-regally-b86e@gregkh>
References: <2023061148-obsessive-robe-72b9@gregkh>
 <20230612024049.10456-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612024049.10456-1-pkshih@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 12, 2023 at 10:40:49AM +0800, Ping-Ke Shih wrote:
> This driver relies on IEEE80211_CONF_PS of hw->conf.flags to turn off PS or
> turn on dynamic PS controlled by driver and firmware. Though this would be
> incorrect, it did work before because the flag is always recalculated until
> the commit 28977e790b5d ("wifi: mac80211: skip powersave recalc if driver SUPPORTS_DYNAMIC_PS")
> is introduced by kernel 5.20 to skip to recalculate IEEE80211_CONF_PS
> of hw->conf.flags if driver sets SUPPORTS_DYNAMIC_PS.
> 
> Correct this by doing recalculation while BSS_CHANGED_PS is changed and
> interface is added or removed. For now, it is allowed to enter PS only if
> single one station vif is working, and it could possible to have PS per
> vif after firmware can support it. Without this fix, driver doesn't
> enter PS anymore that causes higher power consumption.
> 
> Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
> Cc: stable@vger.kernel.org # 6.1+
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Link: https://lore.kernel.org/r/20230527082939.11206-3-pkshih@realtek.com
> (cherry picked from commit 26a125f550a3bf86ac91d38752f4d446426dfe1c)
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/mac80211.c | 16 +++++-------
>  drivers/net/wireless/realtek/rtw89/ps.c       | 26 +++++++++++++++++++
>  drivers/net/wireless/realtek/rtw89/ps.h       |  1 +
>  3 files changed, 34 insertions(+), 9 deletions(-)

All backports now queued up, thanks.

greg k-h
