Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182147C43BE
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 00:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjJJWYj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 18:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbjJJWYi (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 18:24:38 -0400
X-Greylist: delayed 148 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Oct 2023 15:24:35 PDT
Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [IPv6:2001:4b98:dc0:41:216:3eff:fe56:8398])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4A19D;
        Tue, 10 Oct 2023 15:24:35 -0700 (PDT)
Received: from violet.fr.zoreil.com ([127.0.0.1])
        by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 39AMLW2b3324422;
        Wed, 11 Oct 2023 00:21:32 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 39AMLW2b3324422
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
        s=v20220413; t=1696976492;
        bh=1jk5idWYaUQ5kRihQ+KrfsDVP7GFGMxbdcsWlzUtJfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDxAk9JBiB7JU7Z9LUTw0rkaRXwa9cK5JMEX/p5lhBnHQBM9VBy3NV7/dZBruL1Zt
         eQTZXNYQh4nLFsv3d2kLyeLbbL737AdcGt2Jtl3dm2Zw1cnlYi/yyK+LcejDaDfAw1
         c09IgvzXVJlq3AxH00Jurn6lBMWNL3JSPVm57Q7I=
Received: (from romieu@localhost)
        by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 39AMLVg93324421;
        Wed, 11 Oct 2023 00:21:31 +0200
Date:   Wed, 11 Oct 2023 00:21:31 +0200
From:   Francois Romieu <romieu@fr.zoreil.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Wei Fang <wei.fang@nxp.com>, kernel@pengutronix.de,
        stable@vger.kernel.org
Subject: Re: [PATCH net] net: davicom: dm9000: dm9000_phy_write(): fix
 deadlock during netdev watchdog handling
Message-ID: <20231010222131.GA3324403@electric-eye.fr.zoreil.com>
References: <20231010-dm9000-fix-deadlock-v1-1-b1f4396f83dd@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-dm9000-fix-deadlock-v1-1-b1f4396f83dd@pengutronix.de>
X-Organisation: Land of Sunshine Inc.
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Marc Kleine-Budde <mkl@pengutronix.de> :
> The dm9000 takes the db->lock spin lock in dm9000_timeout() and calls
> into dm9000_init_dm9000(). For the DM9000B the PHY is reset with
> dm9000_phy_write(). That function again takes the db->lock spin lock,
> which results in a deadlock. For reference the backtrace:
[...]
> To workaround similar problem (take mutex inside spin lock ) , a
> "in_timeout" variable was added in 582379839bbd ("dm9000: avoid
> sleeping in dm9000_timeout callback"). Use this variable and not take
> the spin lock inside dm9000_phy_write() if in_timeout is true.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> During the netdev watchdog handling the dm9000 driver takes the same
> spin lock twice. Avoid this by extending an existing workaround.
> ---

I can review it but I can't really endorse it. :o)

Extending ugly workaround in pre-2000 style device drivers...
I'd rather see the thing fixed if there is some real use for it.

-- 
Ueimor
