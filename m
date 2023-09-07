Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F5F797A71
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 19:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245150AbjIGRk2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 13:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245139AbjIGRkH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 13:40:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71C610EC
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 10:39:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6573CC116A7;
        Thu,  7 Sep 2023 10:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694081895;
        bh=6/Gm1xolHwTxiHUcx8y6Kli7jd4PMbChlLqTxA7sh78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WwLXPFOETuNwVasE7pZmuvAqZowtATsSEwxjFgVhnzUOdQsIXVBGe8tJDGosOJgFQ
         6EeYjgXyPKk45kqnl7S3jZ74xf6glttvt+4prRWsBlUjfYBBhQgo+AvmjRC/qqQShC
         0ibECKcPfsnnKeT/iwGn4bmiK28lCtkXNdUo5Fdo=
Date:   Thu, 7 Sep 2023 11:18:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     stable@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        Max Chou <max.chou@realtek.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 6.5.y] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for
 RTL8852C
Message-ID: <2023090700-wildfire-polka-1bc6@gregkh>
References: <2023083021-unease-catfish-92ad@gregkh>
 <20230906071129.37071-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906071129.37071-1-juerg.haefliger@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 06, 2023 at 09:11:29AM +0200, Juerg Haefliger wrote:
> In this commit, prefer to load FW v2 if available. Fallback to FW v1
> otherwise. This behavior is only for RTL8852C.
> 
> Fixes: 9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")
> Cc: stable@vger.kernel.org
> Suggested-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> Tested-by: Hilda Wu <hildawu@realtek.com>
> Signed-off-by: Max Chou <max.chou@realtek.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> [juergh: Adjusted context due to missing .hw_info struct element]
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> ---
>  drivers/bluetooth/btrtl.c | 70 +++++++++++++++++++++++++--------------
>  1 file changed, 45 insertions(+), 25 deletions(-)

What is the git commit id of this change in Linus's tree?

thanks,

greg k-h
