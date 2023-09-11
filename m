Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B44C79BCA3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbjIKVEX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242595AbjIKPx4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:53:56 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE09193
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:53:50 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77D13C0007;
        Mon, 11 Sep 2023 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694447629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u2f5lbfZPYd8C2pVuPX+yj1FqH0A7MGZvRTckaUi4Rc=;
        b=M4pzQvXTevYM8Jyj3rqfQ4VlmWwhARWFptZoycJ54P9aP/0WBHlObqVso2spX20+1N2rHo
        hV8YHTm2LDl6Lf5p8G92CdK/E9QBI6fHFAH1bXgNtsuyPIcgeWYC9w5p2kXeNa1LGmsDMR
        8CsqvB8dUeQes2ieiuHt9zcOV7ibpk4kWbyR/vzqWnJNd1hcbTiTEe5PZ6nRfZG+ZXq28K
        L9qnynyeuea9KHiFdJbN3yILswMbmitVqhP7Z1/SWNbeYCgmZfOOKo/GUXwckZiUrfFYqZ
        wzsvsQqvZuHPiKdUl1AZ3/VAnYc1s3Cv16Hiv7hFZ1k1WAyYRAQC5AyQu5mTrw==
Date:   Mon, 11 Sep 2023 17:52:47 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michal Simek <michal.simek@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] mtd: rawnand: arasan: Ensure program page
 operations are successful
Message-ID: <20230911175247.44c1d894@xps-13>
In-Reply-To: <20230717194221.229778-2-miquel.raynal@bootlin.com>
References: <20230717194221.229778-1-miquel.raynal@bootlin.com>
        <20230717194221.229778-2-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Michal,

miquel.raynal@bootlin.com wrote on Mon, 17 Jul 2023 21:42:20 +0200:

> The NAND core complies with the ONFI specification, which itself
> mentions that after any program or erase operation, a status check
> should be performed to see whether the operation was finished *and*
> successful.
>=20
> The NAND core offers helpers to finish a page write (sending the
> "PAGE PROG" command, waiting for the NAND chip to be ready again, and
> checking the operation status). But in some cases, advanced controller
> drivers might want to optimize this and craft their own page write
> helper to leverage additional hardware capabilities, thus not always
> using the core facilities.
>=20
> Some drivers, like this one, do not use the core helper to finish a page
> write because the final cycles are automatically managed by the
> hardware. In this case, the additional care must be taken to manually
> perform the final status check.
>=20
> Let's read the NAND chip status at the end of the page write helper and
> return -EIO upon error.
>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: stable@vger.kernel.org
> Fixes: 88ffef1b65cf ("mtd: rawnand: arasan: Support the hardware BCH ECC =
engine")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>=20
> ---
>=20
> Hello Michal,
>=20
> I have not tested this, but based on a report on another driver, I
> believe the status check is also missing here and could sometimes
> lead to unnoticed partial writes.
>=20
> Please test on your side that everything still works and let me
> know how it goes.

Any news from the testing team about patches 2/3 and 3/3?

Thanks,
Miqu=C3=A8l
