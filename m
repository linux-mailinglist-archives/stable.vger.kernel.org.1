Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959D079D367
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 16:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjILOSB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 10:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjILOSB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 10:18:01 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7623010D
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 07:17:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B6E296000C;
        Tue, 12 Sep 2023 14:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694528274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pmAVbqcex+wu8olNhaYbX0tmtwogpGqw3k+C3D9P9VI=;
        b=Gduo1njbql4zsOOX46pEawW4iAGIrEwd/vg4NTaj6RNg7BhwWspIo5fpLZKCcmFAjflXo/
        FMO3qVv2/ulexxC1Nx3DIwwBpLERek3OK3rCzvS4Tmuj1kVXXhjfkUIgJh1r7uYRghPhk/
        jutZ72PuLt99lt2CumNaqE+PuirQyXfs3ehiR2tpwMAczC3QOzXeMA+wA8YYQ2IDM0Rdry
        Aq7vBugTH10L1tBsB8MtiM2GwnEoT/D7afquVBXkzDT3Ye7Six3R7gKOHvYMU18XmM5l7q
        93OJBujlC0LOz7pXBBzItwrGfFjAe765t5Xf2ZJFgMIDlWfvh/SBgnT8Zo8Bwg==
Date:   Tue, 12 Sep 2023 16:17:52 +0200
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
Message-ID: <20230912161752.581019bc@xps-13>
In-Reply-To: <cf1a0b96-0f1e-4a6d-960b-93185faf27ba@amd.com>
References: <20230717194221.229778-1-miquel.raynal@bootlin.com>
        <20230717194221.229778-2-miquel.raynal@bootlin.com>
        <20230911175247.44c1d894@xps-13>
        <cf1a0b96-0f1e-4a6d-960b-93185faf27ba@amd.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Michal,

michal.simek@amd.com wrote on Tue, 12 Sep 2023 15:55:23 +0200:

> Hi Miquel,
>=20
> On 9/11/23 17:52, Miquel Raynal wrote:
> > Hi Michal,
> >=20
> > miquel.raynal@bootlin.com wrote on Mon, 17 Jul 2023 21:42:20 +0200:
> >  =20
> >> The NAND core complies with the ONFI specification, which itself
> >> mentions that after any program or erase operation, a status check
> >> should be performed to see whether the operation was finished *and*
> >> successful.
> >>
> >> The NAND core offers helpers to finish a page write (sending the
> >> "PAGE PROG" command, waiting for the NAND chip to be ready again, and
> >> checking the operation status). But in some cases, advanced controller
> >> drivers might want to optimize this and craft their own page write
> >> helper to leverage additional hardware capabilities, thus not always
> >> using the core facilities.
> >>
> >> Some drivers, like this one, do not use the core helper to finish a pa=
ge
> >> write because the final cycles are automatically managed by the
> >> hardware. In this case, the additional care must be taken to manually
> >> perform the final status check.
> >>
> >> Let's read the NAND chip status at the end of the page write helper and
> >> return -EIO upon error.
> >>
> >> Cc: Michal Simek <michal.simek@amd.com>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 88ffef1b65cf ("mtd: rawnand: arasan: Support the hardware BCH E=
CC engine")
> >> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >>
> >> ---
> >>
> >> Hello Michal,
> >>
> >> I have not tested this, but based on a report on another driver, I
> >> believe the status check is also missing here and could sometimes
> >> lead to unnoticed partial writes.
> >>
> >> Please test on your side that everything still works and let me
> >> know how it goes. =20
> >=20
> > Any news from the testing team about patches 2/3 and 3/3? =20
>=20
> I asked Amit to test and he didn't get back to me even I asked for it cou=
ple of times.

Ok.

> Can you please tell me how to test it? I will setup HW myself and test it=
 and get back to you.

I believe setting up the board to use the hardware BCH engine and
performing basic erase/write/read testing with a known file and check
it still behaves correctly would work. You can also run

	nandbiterrs -i /dev/mtdx

as a second step and verify there is no difference with and without the
patch and finally check the impact:

	flash_speed -d -c 10 /dev/mtdx
	(be careful: this is a destructive operation)

Thanks,
Miqu=C3=A8l
