Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26FF7A8626
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 16:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbjITOFd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 10:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjITOFd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 10:05:33 -0400
X-Greylist: delayed 4568 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Sep 2023 07:05:25 PDT
Received: from 7.mo575.mail-out.ovh.net (7.mo575.mail-out.ovh.net [46.105.63.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197AFD7
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 07:05:25 -0700 (PDT)
Received: from director9.ghost.mail-out.ovh.net (unknown [10.109.138.56])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id BC081262B8
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 12:49:15 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-m5sqf (unknown [10.110.115.217])
        by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 6BC341FE99;
        Wed, 20 Sep 2023 12:49:15 +0000 (UTC)
Received: from RCM-web7.webmail.mail.ovh.net ([151.80.29.19])
        by ghost-submission-6684bf9d7b-m5sqf with ESMTPSA
        id jf4+GEvqCmUMvwAAR9gfLA
        (envelope-from <rafal@milecki.pl>); Wed, 20 Sep 2023 12:49:15 +0000
MIME-Version: 1.0
Date:   Wed, 20 Sep 2023 14:49:15 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.14 055/186] ARM: dts: BCM53573: Use updated "spi-gpio"
 binding properties
In-Reply-To: <20230920112838.896837720@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
 <20230920112838.896837720@linuxfoundation.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <b7cea4f70cefbff3fac4f4ca1d42e78f@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 31.11.218.106
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16882587628948400954
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudekfedgheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpefghfeuiefhiedttedtheefhfeifeffveekvdegteetkeetjedtiedvvdfhgfffffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdefuddruddurddvudekrddutdeipdduhedurdektddrvdelrdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrrghfrghlsehmihhlvggtkhhirdhplheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeehpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 2023-09-20 13:29, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me 
> know.

I already replied to the queuing e-mail but it was missed I guess. This
patch should not get backported to the 4.14 due its dependencies. See
below for more details.

-------- Original Message --------
Subject: Re: Patch "ARM: dts: BCM53573: Use updated "spi-gpio" binding 
properties" has been added to the 4.14-stable tree
Date: 2023-09-11 09:04
 From: Rafał Miłecki <rafal@milecki.pl>
To: Sasha Levin <sashal@kernel.org>
Cc: stable-commits@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley 
<conor+dt@kernel.org>

On 2023-09-09 01:47, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     ARM: dts: BCM53573: Use updated "spi-gpio" binding properties
> 
> to the 4.14-stable tree which can be found at:
> 
> http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      arm-dts-bcm53573-use-updated-spi-gpio-binding-proper.patch
> and it can be found in the queue-4.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable 
> tree,
> please let <stable@vger.kernel.org> know about it.

The new binding became part of Linux release 4.17-rc1 as a result of 
commits:
77a060533c04 ("spi: spi-gpio: Augment device tree bindings")
9b00bc7b901f ("spi: spi-gpio: Rewrite to use GPIO descriptors")

Kernels older than 4.17-rc1 don't support new binding.

This patch should NOT be backported to the 4.14.


> commit 71f59fe710054f186fa145ba6134a95400585601
> Author: Rafał Miłecki <rafal@milecki.pl>
> Date:   Fri Jul 7 13:40:04 2023 +0200
> 
>     ARM: dts: BCM53573: Use updated "spi-gpio" binding properties
> 
>     [ Upstream commit 2c0fd6b3d0778ceab40205315ccef74568490f17 ]
> 
>     Switch away from deprecated properties.
> 
>     This fixes:
>     arch/arm/boot/dts/broadcom/bcm947189acdbmr.dtb: spi: gpio-sck:
> False schema does not allow [[3, 21, 0]]
>             From schema: 
> Documentation/devicetree/bindings/spi/spi-gpio.yaml
>     arch/arm/boot/dts/broadcom/bcm947189acdbmr.dtb: spi: gpio-miso:
> False schema does not allow [[3, 22, 0]]
>             From schema: 
> Documentation/devicetree/bindings/spi/spi-gpio.yaml
>     arch/arm/boot/dts/broadcom/bcm947189acdbmr.dtb: spi: gpio-mosi:
> False schema does not allow [[3, 23, 0]]
>             From schema: 
> Documentation/devicetree/bindings/spi/spi-gpio.yaml
>     arch/arm/boot/dts/broadcom/bcm947189acdbmr.dtb: spi: 'sck-gpios'
> is a required property
>             From schema: 
> Documentation/devicetree/bindings/spi/spi-gpio.yaml
>     arch/arm/boot/dts/broadcom/bcm947189acdbmr.dtb: spi: Unevaluated
> properties are not allowed ('gpio-miso', 'gpio-mosi', 'gpio-sck' were
> unexpected)
>             From schema: 
> Documentation/devicetree/bindings/spi/spi-gpio.yaml
> 
>     Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>     Link: 
> https://lore.kernel.org/r/20230707114004.2740-4-zajec5@gmail.com
>     Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/arch/arm/boot/dts/bcm947189acdbmr.dts
> b/arch/arm/boot/dts/bcm947189acdbmr.dts
> index ef263412fea51..02c916bedd281 100644
> --- a/arch/arm/boot/dts/bcm947189acdbmr.dts
> +++ b/arch/arm/boot/dts/bcm947189acdbmr.dts
> @@ -61,9 +61,9 @@ wps {
>  	spi {
>  		compatible = "spi-gpio";
>  		num-chipselects = <1>;
> -		gpio-sck = <&chipcommon 21 0>;
> -		gpio-miso = <&chipcommon 22 0>;
> -		gpio-mosi = <&chipcommon 23 0>;
> +		sck-gpios = <&chipcommon 21 0>;
> +		miso-gpios = <&chipcommon 22 0>;
> +		mosi-gpios = <&chipcommon 23 0>;
>  		cs-gpios = <&chipcommon 24 0>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;

-- 
Rafał Miłecki
