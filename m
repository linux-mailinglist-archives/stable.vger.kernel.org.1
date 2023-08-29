Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DB078CB61
	for <lists+stable@lfdr.de>; Tue, 29 Aug 2023 19:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbjH2Rfy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 29 Aug 2023 13:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238127AbjH2Rfh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 29 Aug 2023 13:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71E4CD7
        for <stable@vger.kernel.org>; Tue, 29 Aug 2023 10:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7B8765ED2
        for <stable@vger.kernel.org>; Tue, 29 Aug 2023 17:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEAFC433C7;
        Tue, 29 Aug 2023 17:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693330510;
        bh=XjsdAqBk2Atk/xGSjoEN1cn2zjiKXXMWkRpzsfytKIw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LeeF9gp+ur7O9An8qD4+Kd+yb3MPwQusEMFuArAnGTWpeRTY6oOS+5NT75EyCz3wn
         hjiEwcsL8sUnb1Sje9FQt23eAWUEy5rOw/pUCQuXnr9hoVY/I+NyWeJkJp3JaIM7kb
         fhCYpS0bc8Ksd3+1LOEtkuyZCcLu2ebjtoskIurCovMgUFY9BogcW0ZNq+4oRDCw69
         3PX7jGf18CoDxVjnD3VBekuhMYSbWJyje69TxQoaupEMK3I4YfmQmS1lwN7AR4sLrb
         /prTWjCxEY7F9B9Wss04Mr/8zBAZIzNDPiKUx3bnbb5U5HI/h9BWd1nvFqmcFRH/kZ
         gS1h6vGAkDslA==
Message-ID: <a7ec2460-7f34-d138-2f9a-080daacd7bed@kernel.org>
Date:   Tue, 29 Aug 2023 19:35:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] ssb-main: Fix division by zero in ssb_calc_clock_rate()
To:     Rand Deeb <deeb.rand@confident.ru>, stable@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     lvc-project@linuxtesting.org, voskresenski.stanislav@confident.ru
References: <20230829111251.6190-1-deeb.rand@confident.ru>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230829111251.6190-1-deeb.rand@confident.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 29/08/2023 13:12, Rand Deeb wrote:
> In the line 910, the value of m1 may be zero, so there is a possibility
> of dividing by zero, we fixed it by checking the values before dividing
> (found with SVACE). In the same way, after checking and reading the
> function, we found that lines 906, 908, 912 have the same situation, so
> we fixed them as well.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Rand Deeb <deeb.rand@confident.ru>
> ---
>  drivers/ssb/main.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
> index 0a26984acb2c..e0776a16d04d 100644
> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -903,13 +903,21 @@ u32 ssb_calc_clock_rate(u32 plltype, u32 n, u32 m)
>  		case SSB_CHIPCO_CLK_MC_BYPASS:
>  			return clock;
>  		case SSB_CHIPCO_CLK_MC_M1:
> -			return (clock / m1);
> +			if (m1 !=3D 0)

Address list does not look like patch for mainline, but anyway: Your
patch is corrupted. Fix your email setup.

Best regards,
Krzysztof

