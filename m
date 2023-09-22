Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8C07AAD86
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 11:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjIVJOt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 05:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjIVJOs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 05:14:48 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B694299
        for <stable@vger.kernel.org>; Fri, 22 Sep 2023 02:14:41 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 87E2920008;
        Fri, 22 Sep 2023 09:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695374080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ovHQ3Vath6T1jZF/E2SbCgvV9DoJuznyAhPnCbq1wiU=;
        b=iCcEYUW8z/+zifPIYQiG4vV7bqhI7ipT47E4l9WZYaE4anqu/TsNl2gurgsDvILEoxWY+m
        iVa2szH3tU09AHSdqwymc0ygNYYWXJhT5kQovMFekV2b670Tn9cbnfUxVjq401mEIUlENs
        5pbEtn5DlClAspDAoym5I0GutHClKExKvoTG0sylhplqm8azGrot5XynPldf0blpkz09uc
        foREMoeda4Qn2GhF0KwjuhVNfRXWJavv+FafI77o5UvlEYAxA3/SCv3fjGBe1vCshOP7ZT
        DJ1uHZpH50B+nEiKL/X62qjEebPN0mJ8ZoRSmLPcDJDMz7nu+Ei5otDyK/l0rA==
Date:   Fri, 22 Sep 2023 11:14:37 +0200
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
Message-ID: <20230922111437.57804995@xps-13>
In-Reply-To: <ead8ac00-cc2d-4258-aac1-af5eed93de7b@amd.com>
References: <20230717194221.229778-1-miquel.raynal@bootlin.com>
        <20230717194221.229778-2-miquel.raynal@bootlin.com>
        <20230911175247.44c1d894@xps-13>
        <cf1a0b96-0f1e-4a6d-960b-93185faf27ba@amd.com>
        <20230912161752.581019bc@xps-13>
        <ead8ac00-cc2d-4258-aac1-af5eed93de7b@amd.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Michal,

michal.simek@amd.com wrote on Thu, 21 Sep 2023 12:25:10 +0200:

> On 9/12/23 16:17, Miquel Raynal wrote:
> > Hi Michal,
> >=20
> > michal.simek@amd.com wrote on Tue, 12 Sep 2023 15:55:23 +0200:
> >  =20
> >> Hi Miquel,
> >>
> >> On 9/11/23 17:52, Miquel Raynal wrote: =20
> >>> Hi Michal,
> >>>
> >>> miquel.raynal@bootlin.com wrote on Mon, 17 Jul 2023 21:42:20 +0200: =
=20
> >>>    >>>> The NAND core complies with the ONFI specification, which its=
elf =20
> >>>> mentions that after any program or erase operation, a status check
> >>>> should be performed to see whether the operation was finished *and*
> >>>> successful.
> >>>>
> >>>> The NAND core offers helpers to finish a page write (sending the
> >>>> "PAGE PROG" command, waiting for the NAND chip to be ready again, and
> >>>> checking the operation status). But in some cases, advanced controll=
er
> >>>> drivers might want to optimize this and craft their own page write
> >>>> helper to leverage additional hardware capabilities, thus not always
> >>>> using the core facilities.
> >>>>
> >>>> Some drivers, like this one, do not use the core helper to finish a =
page
> >>>> write because the final cycles are automatically managed by the
> >>>> hardware. In this case, the additional care must be taken to manually
> >>>> perform the final status check.
> >>>>
> >>>> Let's read the NAND chip status at the end of the page write helper =
and
> >>>> return -EIO upon error.
> >>>>
> >>>> Cc: Michal Simek <michal.simek@amd.com>
> >>>> Cc: stable@vger.kernel.org
> >>>> Fixes: 88ffef1b65cf ("mtd: rawnand: arasan: Support the hardware BCH=
 ECC engine")
> >>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >>>>
> >>>> ---
> >>>>
> >>>> Hello Michal,
> >>>>
> >>>> I have not tested this, but based on a report on another driver, I
> >>>> believe the status check is also missing here and could sometimes
> >>>> lead to unnoticed partial writes.
> >>>>
> >>>> Please test on your side that everything still works and let me
> >>>> know how it goes. =20
> >>>
> >>> Any news from the testing team about patches 2/3 and 3/3? =20
> >>
> >> I asked Amit to test and he didn't get back to me even I asked for it =
couple of times. =20
> >=20
> > Ok.
> >  =20
> >> Can you please tell me how to test it? I will setup HW myself and test=
 it and get back to you. =20
> >=20
> > I believe setting up the board to use the hardware BCH engine and
> > performing basic erase/write/read testing with a known file and check
> > it still behaves correctly would work. You can also run
> >=20
> > 	nandbiterrs -i /dev/mtdx
> >=20
> > as a second step and verify there is no difference with and without the
> > patch and finally check the impact:
> >=20
> > 	flash_speed -d -c 10 /dev/mtdx
> > 	(be careful: this is a destructive operation) =20
>=20
> Testing team won't see any issue that's why feel free to add my
> Acked-by: Michal Smek <michal.simek@amd.com>

I think you told me in the last e-mail you tested the pl353 patch, not
the one for the Arasan controller. Shall I add your Acked-by here and
your Tested-by in the other?

Thanks,
Miqu=C3=A8l
