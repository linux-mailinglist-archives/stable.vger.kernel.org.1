Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBC96F8EC3
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 07:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjEFFvv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 01:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjEFFvt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 01:51:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1DF7ECA
        for <stable@vger.kernel.org>; Fri,  5 May 2023 22:51:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C601615CE
        for <stable@vger.kernel.org>; Sat,  6 May 2023 05:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE03AC433D2;
        Sat,  6 May 2023 05:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683352300;
        bh=t/KFLup7yITUu+IXhD2o2B0rbByd3oknsn9no561SZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0jdUoM1uvyf4Ba6WtpIDQp022b5nl10sQ4RuWHykFOYtm3FlllwurGBPsRlFmRarl
         +lJu19BgK4XzpNfhp9F4wkYA7vBqaJIaHIitTtYNeFtn58oTf8XvjhdQHIWZPWXID2
         bHzK5jOKLwwyC/iH+RxwP5edLl03h9TQgWNx/sUc=
Date:   Sat, 6 May 2023 09:57:38 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     gouhao@uniontech.com
Cc:     stable@vger.kernel.org, jiping.ma2@windriver.com,
        davem@davemloft.net
Subject: Re: [PATCH 4.19] stmmac: debugfs entry name is not be changed when
 udev rename device name.
Message-ID: <2023050625-boat-gravel-4215@gregkh>
References: <20230504103937.12687-1-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504103937.12687-1-gouhao@uniontech.com>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, May 04, 2023 at 06:39:37PM +0800, gouhao@uniontech.com wrote:
> From: Jiping Ma <jiping.ma2@windriver.com>
> 
> commit 481a7d154cbbd5ca355cc01cc8969876b240eded upstream.
> 
> Add one notifier for udev changes net device name.
> 
> Fixes: 466c5ac8bdf2 ("net: stmmac: create one debugfs dir per net-device")
> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 

Now queued up, thanks,

greg k-h
