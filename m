Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14B77AADA9
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 11:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjIVJRa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 05:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVJR3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 05:17:29 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7C1C2
        for <stable@vger.kernel.org>; Fri, 22 Sep 2023 02:17:22 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BD7920003;
        Fri, 22 Sep 2023 09:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695374240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DlogHQgO5T+gATNqDNwjL4VIKOH0zcqYGHyyk8W/NLQ=;
        b=oA6IA8QJs8IIO3OS0wYAgH5iIYyP6WCjR1KNCbOsx6wA8HWnO2kpVftq9yzylY7vbddRjq
        yT840RMpa12UU8DZEYclmgSjGw55lC85pKxRj8DQ7KYlSO8rhmAK3hUqJ3ve4iLiplv3hd
        rPtZW5O0f/VXkrH35q43dszO48P/AlxQxnQLIOBoEAPgl8DC5IF6VFzqhOkZkw8DDXY4Zw
        7P6hdcEJkb/XKKi/d6XSrgNhogotaVoNUJqe+BhvpDG7hMNdfrlUKwX/pYtupr4m88wtCc
        5MVxjRnXvwSQW8YnhfMdSkGcFY0and8lLl1KW/fgKNSwOyszHZIewWf6Z+TZ1w==
Date:   Fri, 22 Sep 2023 11:17:18 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH 2/3] mtd: rawnand: arasan: Ensure program page
 operations are successful
Message-ID: <20230922111718.088ff61a@xps-13>
In-Reply-To: <cfc032b5-dfa4-485f-a2f1-5085964f6697@amd.com>
References: <20230717194221.229778-1-miquel.raynal@bootlin.com>
        <20230717194221.229778-2-miquel.raynal@bootlin.com>
        <20230911175247.44c1d894@xps-13>
        <cf1a0b96-0f1e-4a6d-960b-93185faf27ba@amd.com>
        <20230912161752.581019bc@xps-13>
        <ead8ac00-cc2d-4258-aac1-af5eed93de7b@amd.com>
        <20230922111437.57804995@xps-13>
        <cfc032b5-dfa4-485f-a2f1-5085964f6697@amd.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Michal,

michal.simek@amd.com wrote on Fri, 22 Sep 2023 11:16:20 +0200:

> On 9/22/23 11:14, Miquel Raynal wrote:
> > Hi Michal,
> >=20
> > michal.simek@amd.com wrote on Thu, 21 Sep 2023 12:25:10 +0200:
> >  =20
> >> On 9/12/23 16:17, Miquel Raynal wrote: =20
> >>> Hi Michal,
> >>>
> >>> michal.simek@amd.com wrote on Tue, 12 Sep 2023 15:55:23 +0200: =20
> >>>    >>>> Hi Miquel, =20
> >>>>
> >>>> On 9/11/23 17:52, Miquel Raynal wrote: =20
> >>>>> Hi Michal,
> >>>>>
> >>>>> miquel.raynal@bootlin.com wrote on Mon, 17 Jul 2023 21:42:20 +0200:=
 =20
> >>>>>     >>>> The NAND core complies with the ONFI specification, which =
itself =20
> >>>>>> mentions that after any program or erase operation, a status check
> >>>>>> should be performed to see whether the operation was finished *and*
> >>>>>> successful.
> >>>>>>
> >>>>>> The NAND core offers helpers to finish a page write (sending the
> >>>>>> "PAGE PROG" command, waiting for the NAND chip to be ready again, =
and
> >>>>>> checking the operation status). But in some cases, advanced contro=
ller
> >>>>>> drivers might want to optimize this and craft their own page write
> >>>>>> helper to leverage additional hardware capabilities, thus not alwa=
ys
> >>>>>> using the core facilities.
> >>>>>>
> >>>>>> Some drivers, like this one, do not use the core helper to finish =
a page
> >>>>>> write because the final cycles are automatically managed by the
> >>>>>> hardware. In this case, the additional care must be taken to manua=
lly
> >>>>>> perform the final status check.
> >>>>>>
> >>>>>> Let's read the NAND chip status at the end of the page write helpe=
r and
> >>>>>> return -EIO upon error.
> >>>>>>
> >>>>>> Cc: Michal Simek <michal.simek@amd.com>
> >>>>>> Cc: stable@vger.kernel.org
> >>>>>> Fixes: 88ffef1b65cf ("mtd: rawnand: arasan: Support the hardware B=
CH ECC engine")
> >>>>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >>>>>>
> >>>>>> ---
> >>>>>>
> >>>>>> Hello Michal,
> >>>>>>
> >>>>>> I have not tested this, but based on a report on another driver, I
> >>>>>> believe the status check is also missing here and could sometimes
> >>>>>> lead to unnoticed partial writes.
> >>>>>>
> >>>>>> Please test on your side that everything still works and let me
> >>>>>> know how it goes. =20
> >>>>>
> >>>>> Any news from the testing team about patches 2/3 and 3/3? =20
> >>>>
> >>>> I asked Amit to test and he didn't get back to me even I asked for i=
t couple of times. =20
> >>>
> >>> Ok. =20
> >>>    >>>> Can you please tell me how to test it? I will setup HW myself=
 and test it and get back to you. =20
> >>>
> >>> I believe setting up the board to use the hardware BCH engine and
> >>> performing basic erase/write/read testing with a known file and check
> >>> it still behaves correctly would work. You can also run
> >>>
> >>> 	nandbiterrs -i /dev/mtdx
> >>>
> >>> as a second step and verify there is no difference with and without t=
he
> >>> patch and finally check the impact:
> >>>
> >>> 	flash_speed -d -c 10 /dev/mtdx
> >>> 	(be careful: this is a destructive operation) =20
> >>
> >> Testing team won't see any issue that's why feel free to add my
> >> Acked-by: Michal Smek <michal.simek@amd.com> =20
> >=20
> > I think you told me in the last e-mail you tested the pl353 patch, not
> > the one for the Arasan controller. Shall I add your Acked-by here and
> > your Tested-by in the other? =20
>=20
> Yes exactly.
> I tested pl353 myself. If that log looks good feel free to add my Tested-=
by tag.
> And I got information from testing team that they tested Arasan one hence=
 only Ack one.

Perfect. Thanks a lot!

Miqu=C3=A8l
