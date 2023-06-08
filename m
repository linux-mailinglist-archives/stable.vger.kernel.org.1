Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4831D728305
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 16:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjFHOuK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 10:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbjFHOuI (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 10:50:08 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F892D72
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 07:50:06 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id C3F672B06750;
        Thu,  8 Jun 2023 10:50:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Jun 2023 10:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686235803; x=1686243003; bh=M/lU9qDtVX08QSJ7u5VWMKne3KhUDPhIvZK
        pS+W+56w=; b=UwHtmnY0MVM9Qww19dmWG2rwSNsZyJFUwuVthkhDS06XH5DNKlQ
        cdg3SmqfmKpuVVWplCXboA8TP6A81FvBxiTeM+X6UC5fcc1pVAGLYFBs0b8m8ob7
        Q7WII+gprtz46005VpwTIqpRmfx+wAR2vYNo0mTid3A+3YRnzEkp9unbCUfChg0r
        UhW+SQy3wSy12VbrqoujaviP4V8Fcr/awHnyrG95eG6JoJjg9yWB+Y9XglTRkry7
        qFWQZkrkqemegm7jCg9WSXEoN0quNpjsf6cjvARDBaO37tzHhZnHtFk6fjmLWU//
        kS5EoNsYCoBvhl+nH5Vl0aSc/rzQDV5cjtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686235803; x=1686243003; bh=M/lU9qDtVX08QSJ7u5VWMKne3KhUDPhIvZK
        pS+W+56w=; b=PidHpj241q23jFSe/ixDt2qovrPYvftWN9RB696SP4wQqkMPS7Z
        P+BtpA6UlQVRCWBke6gywDAkMaut0SQYpMIaakLEJZgIhzHusWcQ0cRjQ2JKiH9H
        l+yjMRIQ49ZhzRIIRBfj7sDpC3FxVdqA8Sg0xIjYX/H/kzTDW0DytEeH18wfjZIv
        WY/bwZ8NXuyxwWepHq62F0gquqBQ0XPx7JXIh9vfI+OBhhoepOnKdKc6DImglwNT
        byOqV6y3bntW4ZaGtZ/Mqo4Ymd5kO3RKP+M/QUr6Xb7rFE7Z9FBo9erUsBpPGoQs
        SlIU6la4Q0RKPbp0pYNp95k2z0egsDXsSGw==
X-ME-Sender: <xms:muqBZKHKK15Lm1A6t_XEBt9Rw26yW5bJI6-nXLoLBdvhxTd0OFIa1g>
    <xme:muqBZLUIFCNwurHg39LaX6YKkrvU6joGkGnizs-yEcKCnsUd9OAdSZXLzrlds2LrW
    OmYqCZKX03UAg>
X-ME-Received: <xmr:muqBZEKrluNzQQeo5UDTbz7y4sPu_TCz6Dv89hOYabg5EerZmnf0_6BQvNAE3rty2-20xWSQ-4jyzJz0VWQtYTczl1wtS1Ys7Ix8hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtiedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelke
    ehjeejieehjedvteehjeevkedugeeuiefgfedufefgfffhfeetueeikedufeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:m-qBZEGjv6Yoinw2-NuxRaRAHkKrFEYJ-DK7Gw6668fwgDXXBBPU4w>
    <xmx:m-qBZAWtdEaM8VI2UgDIXHCpQ1TNsaaWyWv9XaKnZBkKb64ei8Xp8g>
    <xmx:m-qBZHPFoiqEcaXUPsRB4EGGhpaFmr2WyOwZdqoLfD4fdnMLwdvx8Q>
    <xmx:m-qBZGlWTlyKiMz_uEL_s3u0cOcZGKbva73oPQwE_muB1LT3_9TaNRS4TYg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jun 2023 10:50:02 -0400 (EDT)
Date:   Thu, 8 Jun 2023 16:49:59 +0200
From:   Greg KH <greg@kroah.com>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     linux-patch-review@list.ti.com, s.sharma@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, aseketeli@baylibre.com, jpanis@baylibre.com,
        khilman@baylibre.com, d-gole@ti.com, vigneshr@ti.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [tiL6.1-P PATCH] regulator: tps65219: fix matching interrupts
 for their regulators
Message-ID: <2023060840-handcart-subway-d834@gregkh>
References: <20230608142132.3728511-1-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230608142132.3728511-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 08, 2023 at 04:21:32PM +0200, Jerome Neanne wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> The driver's probe() first registers regulators in a loop and then in a
> second loop passes them as irq data to the interrupt handlers.  However
> the function to get the regulator for given name
> tps65219_get_rdev_by_name() was a no-op due to argument passed by value,
> not pointer, thus the second loop assigned always same value - from
> previous loop.  The interrupts, when fired, where executed with wrong
> data.  Compiler also noticed it:
> 
>   drivers/regulator/tps65219-regulator.c: In function ‘tps65219_get_rdev_by_name’:
>   drivers/regulator/tps65219-regulator.c:292:60: error: parameter ‘dev’ set but not used [-Werror=unused-but-set-parameter]
> 
> Fixes: c12ac5fc3e0a ("regulator: drivers: Add TI TPS65219 PMIC regulators support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> ---
> 
> Notes:
>     This is backport of upstream fix in TI mainline:
>     Link: https://lore.kernel.org/all/20230507144656.192800-1-krzysztof.kozlowski@linaro.org/

What is the upstream commit id here?

thanks,

greg k-h
